
--[[
Tokens
]]
net.Receive("FMSendTokens", function()
	local am = net.ReadInt(32)
	LocalPlayer().tokens = am
	hook.Run("FMTokensUpdate", am)
end)

local meta = FindMetaTable("Player")

function meta:CanAffordTokens(am)
	return (self.tokens or 0) >= am
end

function meta:GetTokens()
	return self.tokens or 0
end

--[[
Items
]]

local idtocategory = {
	[0] = "plymdls",
	[1] = "accessories",
}

function Items:ReadNetData(itemsTable)
	while net.ReadBool() do
		local id = net.ReadString()
		local t = {
			Name = net.ReadString(),
			Model = net.ReadString(),
			CanPlayerBuy = net.ReadBool(),
			CanPlayerSell = net.ReadBool(),
			Price = net.ReadUInt(32),
		}
		local isonsale = net.ReadBool()
		if isonsale then
			t.SalePrice = net.ReadUInt(32)
		end

		t.VIPRank = net.ReadUInt(8)


		local category = idtocategory[net.ReadUInt(2)]

		if category == "accessories" then
			t.CategoryID = "accessories"
			t.Category = "Accessories"
			t.PosOffset = net.ReadVector()
			t.AngOffset = net.ReadAngle()
			t.Scale = net.ReadVector()
			t.Covers = net.ReadUInt(32)
			t.Bone = net.ReadString()
			t.Skin = net.ReadUInt(8)
			t.BodyGroup = net.ReadString()

			local offsetcnt = net.ReadUInt(32)
			local offsets = util.JSONToTable(util.Decompress(net.ReadData(offsetcnt)))
			t.Offsets = offsets

		elseif category == "plymdls" then
			t.CategoryID = "plymdls"
			t.Category = "Player Models"
			t.Gender = net.ReadString()
			t.Hands = {net.ReadString(), net.ReadUInt(8), net.ReadString()}
		end

		itemsTable[id] = t
	end
end

local buckets = {}
function Items:IncomingItemsTable()
	local txnid = net.ReadUInt(16)
	local itemsexpected = net.ReadUInt(16)

	if not buckets[txnid] then
		buckets[txnid] = {
			startTime = SysTime(),
			items = {}
		}

		timer.Create("FMItemsReceiveTimeout", 15, 1, function()
			printWarn("Items receiving timed out! Please rejoin.")
		end)
	end

	self:ReadNetData(buckets[txnid].items)

	local curitemcnt = table.Count(buckets[txnid].items)

	local perc
	if itemsexpected > 0 then
		perc = math.floor((curitemcnt / itemsexpected) * 100)
	else
		perc = 100
	end

	printInfo("Loading items... (%d%%)", perc)

	if curitemcnt >= itemsexpected then
		printInfo("All items loaded successfully")

		-- Move over the table
		self.Items = buckets[txnid].items

		-- Reset receving logic
		buckets[txnid] = nil
		timer.Remove("FMItemsReceiveTimeout") -- Globally reset the timeout because we got everything now

		self:LoadSequence()
	end
end

function Items:LoadSequence()
	self:SetupAll() -- This takes the database values and creates proper ITEM objects for them
	self:LoadFromDisk()

	hook.Run("FMItemsOnReceived")
	hook.Run("FMItemsUpdate")
end

net.Receive("FMSendItemsTable", function(len)
	Items:IncomingItemsTable()
end)

function meta:ModifyItem(name, modifications)
	net.Start("FMItemModify")
		net.WriteString(name)
		net.WriteTable(modifications)
	net.SendToServer()
end

function Items:SendModifications(item_id, modifications)
	LocalPlayer():ModifyItem(item_id, modifications)
end

function meta:BuyItem(name)
	net.Start("FMItemBuy")
		net.WriteString(name)
	net.SendToServer()
end

function meta:SellItem(name)
	net.Start("FMItemSell")
		net.WriteString(name)
	net.SendToServer()
end

function meta:EquipItem(name)
	net.Start("FMItemEquip")
		net.WriteString(name)
	net.SendToServer()
end

function meta:HolsterItem(name)
	net.Start("FMItemHolster")
		net.WriteString(name)
	net.SendToServer()
end

function meta:HolsterAllItems()
	net.Start("FMItemHolsterAll")
	net.SendToServer()
end

function meta:GetSellPrice(name)
	if not self.Items[name] then return end
	return self.Items[name].SellPrice or 0
end

function meta:CanPreviewItem(name)
	local covers = Items.Items[name].Covers
	if covers == 0 then return true end

	for _,id in pairs(self:GetEquippedItems()) do
		if id == name then continue end

		if bit.band(Items.Items[id].Covers, covers) > 0 then return false, "You can't preview this, " .. Items.Items[id].Name .. " is in the way!" end
	end

	return true
end

local addclientsidemodelqueue = {}
function meta:AddClientsideModel(name, isretry)
	if not Items.Items[name] then
		if not isretry then
			table.insert(addclientsidemodelqueue, {self, name})
		end
		return false
	end

	local ITEM = Items.Items[name]

	local mdl = ClientsideModel(ITEM.Model, RENDERGROUP_OPAQUE)
	mdl:SetNoDraw(true)

	if ITEM.Skin then
		mdl:SetSkin(ITEM.Skin)
	end

	if ITEM.BodyGroup then
		mdl:SetBodyGroups(ITEM.BodyGroup)
	end

	if not Items.ClientsideModels[self] then Items.ClientsideModels[self] = {} end
	Items.ClientsideModels[self][name] = mdl
end

function meta:RemoveClientsideModel(name)
	if not Items.Items[name] then return false end
	if not Items.ClientsideModels[self] then return false end
	if not Items.ClientsideModels[self][name] then return false end

	Items.ClientsideModels[self][name] = nil
end

hook.Add("FMItemsOnReceived", "FullUpdate", function()
	for _, tbl in pairs(addclientsidemodelqueue) do
		local ply = tbl[1]
		local name = tbl[2]

		ply:AddClientsideModel(name, true)
	end

	addclientsidemodelqueue = {}
end)

timer.Create("RemovePreviewModels", 0.5, 0, function()
	local ply = LocalPlayer()
	if ply.showthirdperson then return end
	if not Items.ClientsideModels[ply] then return end

	for name,model in pairs(Items.ClientsideModels[ply]) do
		if not ply:HasItemEquipped(name) then
			Items.ClientsideModels[ply][name] = nil
		end
	end
end)

local invalidplayeritems = {}
net.Receive("FMSendItems", function()
	local ply = net.ReadEntity()
	if not IsValid(ply) then return end

	ply.Items = {}

	if not ply then return end
	for i = 1,net.ReadUInt(8) do
		local name = net.ReadString()
		local equipped = net.ReadBool()
		local modifiers = net.ReadTable()
		local sellprice = net.ReadInt(32)

		ply.Items[name] = {
			Equipped = equipped,
			Modifiers = modifiers,
			SellPrice = sellprice,
		}
	end

	if ply == LocalPlayer() then
		hook.Run("FMItemsUpdate")
	end
end)
net.Receive("FMSendItem", function()
	local ply = net.ReadEntity()
	if not IsValid(ply) then return end

	ply.Items = ply.Items or {}

	local name = net.ReadString()
	local equipped = net.ReadBool()
	local modifiers = net.ReadTable()
	local overridden = net.ReadBool()
	local sellprice = net.ReadInt(32)

	ply.Items[name] = {
		Equipped = equipped,
		Modifiers = modifiers,
		Overridden = overridden,
		SellPrice = sellprice,
	}

	if ply == LocalPlayer() then
		hook.Run("FMItemsUpdate")
	end
end)
net.Receive("FMRemoveItem", function()
	local ply = net.ReadEntity()
	if not ply or not ply.Items then return end

	local name = net.ReadString()
	ply.Items[name] = nil

	if ply == LocalPlayer() then
		hook.Run("FMItemsUpdate")
	end
end)

net.Receive("AddClientsideModel", function()
	local ply = net.ReadEntity()
	local name = net.ReadString()

	if not IsValid(ply) then
		if not invalidplayeritems[ply] then
			invalidplayeritems[ply] = {}
		end

		table.insert(invalidplayeritems[ply], name)
		return
	end

	ply:AddClientsideModel(name)
end)

net.Receive("RemoveClientsideModel", function()
	local ply = net.ReadEntity()
	local name = net.ReadString()

	if not IsValid(ply) or not ply:IsPlayer() then return end

	ply:RemoveClientsideModel(name)
end)

net.Receive("SendClientsideModels", function()
	local itms = net.ReadTable()

	for ply, items in pairs(itms) do
		if not IsValid(ply) then -- skip if the player isn't valid yet and add them to the table to sort out later
			invalidplayeritems[ply] = items
			continue
		end

		for _, name in pairs(items) do
			if Items.Items[name] then
				ply:AddClientsideModel(name)
			end
		end
	end
end)

hook.Add("Think", "InvalidItemPlayers", function()
	for ply, items in pairs(invalidplayeritems) do
		if IsValid(ply) then
			for _, name in pairs(items) do
				if Items.Items[name] then
					ply:AddClientsideModel(name)
				end
			end

			invalidplayeritems[ply] = nil
		end
	end
end)

hook.Add("PostPlayerDraw", "FMItems", function(ply)
	if not ply:Alive() then return end
	if ((ply == LocalPlayer() and ply:Alive()) and not ply:ShouldDrawLocalPlayer())
		or (LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE and LocalPlayer():GetObserverTarget() == ply) then
		return
	end
	--if ply == LocalPlayer() and GetViewEntity():GetClass() == "player" and (GetConVar("thirdperson") and GetConVar("thirdperson"):GetInt() == 0) then return end
	if not Items.ClientsideModels[ply] then return end

	for name, model in pairs(Items.ClientsideModels[ply]) do
		if not Items.Items[name] then Items.ClientsideModels[ply][name] = nil continue end

		local ITEM = Items.Items[name]

		if not ITEM.Attachment and not ITEM.Bone then Items.ClientsideModels[ply][name] = nil continue end

		local pos = Vector()
		local ang = Angle()

		if ITEM.Attachment then
			local attach_id = ply:LookupAttachment(ITEM.Attachment)
			if not attach_id then return end

			local attach = ply:GetAttachment(attach_id)

			if not attach then return end

			pos = attach.Pos
			ang = attach.Ang
		else
			local bone_id = ply:LookupBone(ITEM.Bone)
			if not bone_id then return end

			pos, ang = ply:GetBonePosition(bone_id)

			if pos == ply:GetPos() and ply:GetBoneMatrix(bone_id) then
				pos = ply:GetBoneMatrix(bone_id):GetTranslation()
				ang = ply:GetBoneMatrix(bone_id):GetAngles()
			end
		end

		model, pos, ang = ITEM:ModifyClientsideModel(ply, model, pos, ang)

		local clr = model:GetColor()
		render.SetColorModulation(clr.r / 255, clr.g / 255, clr.b / 255)

		model:SetPos(pos)
		model:SetAngles(ang)

		model:SetRenderOrigin(pos)
		model:SetRenderAngles(ang)
		model:SetupBones()
		model:DrawModel()
		model:SetRenderOrigin()
		model:SetRenderAngles()

		render.SetColorModulation(1, 1, 1)
	end
end)

hook.Add("PostDrawOpaqueRenderables", "FMItems", function()
	for _,rag in pairs(ents.FindByClass("prop_ragdoll")) do
		local ply = rag:GetNWEntity("ownerply")
		if not IsValid(ply) then continue end

		if not Items.ClientsideModels[ply] then return end

		for name, model in pairs(Items.ClientsideModels[ply]) do
			if not Items.Items[name] then Items.ClientsideModels[ply][name] = nil continue end

			local ITEM = Items.Items[name]

			if not ITEM.Attachment and not ITEM.Bone then Items.ClientsideModels[ply][name] = nil continue end

			local pos = Vector()
			local ang = Angle()

			if ITEM.Attachment then
				local attach_id = rag:LookupAttachment(ITEM.Attachment)
				if not attach_id then return end

				local attach = rag:GetAttachment(attach_id)

				if not attach then return end

				pos = attach.Pos
				ang = attach.Ang
			else
				local bone_id = rag:LookupBone(ITEM.Bone)
				if not bone_id then return end

				pos, ang = rag:GetBonePosition(bone_id)

				if pos == rag:GetPos() and rag:GetBoneMatrix(bone_id) then
					pos = rag:GetBoneMatrix(bone_id):GetTranslation()
					ang = rag:GetBoneMatrix(bone_id):GetAngles()
				end
			end

			model, pos, ang = ITEM:ModifyClientsideModel(ply, model, pos, ang)

			model:SetPos(pos)
			model:SetAngles(ang)

			model:SetRenderOrigin(pos)
			model:SetRenderAngles(ang)
			model:SetupBones()
			model:DrawModel()
			model:SetRenderOrigin()
			model:SetRenderAngles()
		end
	end
end)

--[[
Weapons
]]
local plymeta = FindMetaTable("Player")
net.Receive("FMSendWeaponData", function()
	local ply = net.ReadEntity()

	local holstert = {}
	local t = {}
	for i = 1,net.ReadUInt(8) do
		local class = net.ReadString()
		table.insert(t, class)

		if net.ReadBool() then
			holstert[class] = true
		end
	end

	ply.Weapons = t
	ply.HolsteredWeapons = holstert

	hook.Run("FMReceivedWeaponData")
end)

function plymeta:GotWeapon(class)
	class = string.lower(class)

	if not self.Weapons then return false end

	return table.HasValue(self.Weapons, class)
end

function plymeta:WeaponHolstered(class)
	return (self.HolsteredWeapons or {})[class] and true or false
end

local defwep = CreateClientConVar("fm_defwep", "", true, true)
function SetDefaultWeapon(class)
	defwep:SetString(class)
end

function GetDefaultWeapon()
	return defwep:GetString():Trim()
end

function IsDefaultWeapon(class)
	return (GetDefaultWeapon() == class:Trim())
end

hook.Add("SetupPlayerInfo", "Weapons", function(panelply, panel)
	local pnl = vgui.Create("DPanelList")
		pnl:SetTall(200)
		pnl:EnableHorizontal(false)
		pnl:EnableVerticalScrollbar(true)
		pnl:SetPadding(1)
		pnl:SetSpacing(1)

	pnl.Update = function(this, ply)
		this:Clear()

		if ply.Weapons then
			local weptbl = ply.Weapons
			if ply.fakeskill then
				local shouldhaveweps = math.Round((ply.fakeskill * 1.7) ^ 0.6 + 2)

				weptbl = table.Copy(ply.Weapons)

				while #weptbl > shouldhaveweps do
					table.remove(weptbl, math.random(1, #weptbl))
				end
			end

			for _,v in pairs(weptbl) do
				local wepinfo = GetWeaponData(v)
				if not wepinfo then continue end

				local bg = vgui.Create("FMPanel")
					bg:SetTall(34)

				local icon = vgui.Create("SpawnIcon", bg)
					icon:SetPos(2,2)
					icon:SetSize(64,32)
					icon:InvalidateLayout(true)
					icon:SetModel(wepinfo.model)

				local txt = vgui.Create("DLabel", bg)
					txt:SetFont("FMRegular22")
					txt:SetDark(true)
					txt:SetPos(68, 7)
					txt:SetText(wepinfo.name)
					txt:SizeToContents()

				local cashstr = FormatMoney(wepinfo.price)
				if wepinfo.price == -1 then
					cashstr = ""
				end

				surface.SetFont("FMRegular22")
				local txtw = surface.GetTextSize(cashstr)
				local txt2 = vgui.Create("DLabel", bg)
					txt2:SetFont("FMRegular22")
					txt2:SetTextColor(HSVToColor(115, 0.63, 0.50))
					txt2:SetPos(bg:GetWide() - txtw - 2, 7)
					txt2:SetText(cashstr)
					txt2:SizeToContents()

				bg.PerformLayout = function(_, w, h)
					txt2:SetPos(w - txtw - 2, 7)
				end

				this:AddItem(bg)
			end
		end
	end

	pnl:Update(panelply)

	panel:AddItem(pnl, "Weapons")
end)
