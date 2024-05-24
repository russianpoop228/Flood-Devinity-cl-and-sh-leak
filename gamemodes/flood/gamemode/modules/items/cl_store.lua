
--[[
Custom derma stuff
]]
local PANEL = {}
function PANEL:Init()
	self.text = vgui.Create("DLabel", self)
		self.text:SetFont( "FMRegular18" )
		self.text:SetTextColor(Color(150,150,150))

	self:SetSize(0, 24)

	self.OwnLine = true
end
function PANEL:SetIcon(img)
	if self.icon then self.icon:Remove() end

	self.icon = vgui.Create("DImage", self)
		self.icon:SetImage(img)
		self.icon:SetSize(16,16)
end
function PANEL:SetText(txt)
	self.text:SetText(txt)
	self.text:SizeToContents()
	self.text:Dock(FILL)
	self.text:DockMargin(24,0,0,0)
end
function PANEL:PerformLayout()
	if IsValid(self.icon) then
		self.icon:SetPos(4,4)
	end
	self.text:SizeToContents()
	self:SetSize(24 + self.text:GetWide(), 24)
end
function PANEL:PaintOver( w, h )
	self:DrawSelections()
end
function PANEL:DoClick() end
function PANEL:DoRightClick() end
function PANEL:DoDoubleClick() end
vgui.Register("FMContentHeader", PANEL, "Panel")

PANEL = {}
AccessorFunc( PANEL, "m_iCellMarginX", 			"CellMarginX" )
AccessorFunc( PANEL, "m_iCellMarginY", 			"CellMarginY" )
function PANEL:Init()
	self:SetCellMarginX( 0 )
	self:SetCellMarginY( 0 )
end
function PANEL:FindFreeTile( x, y, w, h )
	x = x or 1
	y = y or 1
	local span = math.floor( self:GetWide() / ( self.m_iBaseSize + self.m_iCellMarginX * 2 ) )
	if ( span < 1 ) then span = 1 end
	for i = 1, span do
		if ( (i + (w-1)) > span ) then
			if ( i == 1 ) then
				if ( self:FitsInTile( i, y, w, h ) ) then
					return i, y
				end
			end
			break
		end
		if ( self:FitsInTile( i, y, w, h ) ) then
			return i, y
		end
	end
	return self:FindFreeTile( 1, y + 1, w, h )
end
function PANEL:LayoutTiles()
	local StartLine = 1;
	local tilesizex	= self.m_iBaseSize + self.m_iCellMarginX * 2;
	local tilesizey	= self.m_iBaseSize + self.m_iCellMarginY * 2;
	local MaxWidth	= math.ceil( self:GetWide() / tilesizex );
	self:ClearTiles()
	local chld = self:GetChildren()
	for k, v in pairs( chld ) do
		if ( not v:IsVisible() ) then continue end
		local w = math.ceil( v:GetWide() / tilesizex )
		local h = math.ceil( v:GetTall() / tilesizey )
		if ( v.OwnLine ) then
			w = MaxWidth
		end
		local x, y = self:FindFreeTile( 1, StartLine, w, h )
		v:SetPos( (x-1) * tilesizex + self.m_iCellMarginX, (y-1) * tilesizey + self.m_iCellMarginY )
		self:ConsumeTiles( x, y, w, h )
		if ( v.OwnLine ) then
			StartLine = y + 1
		end
		LastX = x
	end
end
vgui.Register("FMTileLayout", PANEL, "DTileLayout")


PANEL = {}
function PANEL:AddItem(item, removecolliding)
	local ITEM = Items.Items[item]

	if ITEM.Category == "Accessories" then
		if not ITEM.Model then return end

		local ent = ClientsideModel( ITEM.Model, RENDER_GROUP_OPAQUE_ENTITY )
		if not IsValid(ent) then return end

		ent:SetNoDraw( true )

		if not self.Items then
			self.Items = {}
		end

		if removecolliding then
			for k,v in pairs(self.Items) do
				if bit.band(Items.Items[v.item].Covers, ITEM.Covers) > 0 then
					self:RemoveItem(v.item)
				end
			end
		end

		table.insert(self.Items, {item = item, ent = ent})
	elseif ITEM.Category == "Player Models" then
		self:SetModel(ITEM.Model)
	end
end
function PANEL:RemoveItem(item)
	for k,v in pairs(self.Items) do
		if v.item == item then
			v.ent:Remove()
			self.Items[k] = nil
			return true
		end
	end
	return false
end
function PANEL:Clear()
	for k,v in pairs(self.Items) do
		if IsValid(v.ent) then
			v.ent:Remove()
		end
	end

	self.Items = {}
end

function PANEL:SetupAsLocalPlayer()
	self:SetModel(LocalPlayer():GetModel())

	for k,v in pairs(LocalPlayer():GetEquippedItems()) do
		self:AddItem(v)
	end
end

function PANEL:LayoutEntity( Entity )
	if self.bAnimated then
		self:RunAnimation()
	end

	if not self.rotang then self.rotang = 0 end
	self.rotang = (self.rotang + FrameTime()) % 360

	Entity:SetAngles( Angle( 0, self.rotang * 25, 0 ) )
end

function PANEL:DrawItem(model, item, plymdl)
	local ITEM = Items.Items[item]

	if not ITEM.Attachment and not ITEM.Bone then return end

	local pos = Vector()
	local ang = Angle()

	if ITEM.Attachment then
		local attach_id = plymdl:LookupAttachment(ITEM.Attachment)
		if not attach_id then return end

		local attach = plymdl:GetAttachment(attach_id)

		if not attach then return end

		pos = attach.Pos
		ang = attach.Ang
	else
		local bone_id = plymdl:LookupBone(ITEM.Bone)
		if not bone_id then return end

		pos, ang = plymdl:GetBonePosition(bone_id)

		if pos == plymdl:GetPos() and plymdl:GetBoneMatrix(bone_id) then
			pos = plymdl:GetBoneMatrix(bone_id):GetTranslation()
			ang = plymdl:GetBoneMatrix(bone_id):GetAngles()
		end
	end

	model, pos, ang = ITEM:ModifyClientsideModel(plymdl, model, pos, ang)

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

function PANEL:PreDrawModel()
	DisableClipping(true)
	return true
end
function PANEL:PostDrawModel()
	if not self.Items then return end

	for _,tbl in pairs(self.Items) do
		self:DrawItem(tbl.ent, tbl.item, self.Entity)
	end

	DisableClipping(false)
end
vgui.Register("FMItemModelPanel", PANEL, "DModelPanel")

PANEL = {}
function PANEL:Init()
	self.ModelPanel = vgui.Create("FMItemModelPanel", self)
		self.ModelPanel:SetSize(300,300)
		self.ModelPanel:SetupAsLocalPlayer()

	self.Title = vgui.Create("FMContentHeader", self)
		self.Title.text:SetTextColor(Color(120,120,120))

	self.Desc = vgui.Create("DLabelWordWrap", self)
		self.Desc:SetDark(true)
		self.Desc:SetPos(5,0)
		self.Desc:SetFont("FMRegular18")
		self.Desc:SetMaxWidth(290)
		self.Desc:SetTextColor(Color(120,120,120))

	self.Price = vgui.Create("FMContentHeader", self)
		self.Price.text:SetTextColor(Color(120,120,120))

	self.SalePrice = vgui.Create("FMContentHeader", self)
		self.SalePrice.text:SetTextColor(Color(120,120,120))

	self.VIPText = vgui.Create("FMContentHeader", self)

	self.closebtn = vgui.Create("DButton", self)
		self.closebtn:Dock(FILL)
		self.closebtn.Paint = function() end
		self.closebtn:SetText("")
		self.closebtn.DoClick = function() self:Remove() end
end
function PANEL:Setup(item, titleicon)
	local ITEM = Items.Items[item]

	self.ModelPanel:AddItem(item, true)

	self.Title:SetText(ITEM.Name)
	self.Title:SetIcon(titleicon)
	self.Title:MoveBelow(self.ModelPanel)
	self.Title:InvalidateLayout(true)

	self.Price:SetText(string.format("Cost: %i token%s", ITEM.Price, ITEM.Price == 1 and "" or "s"))
	self.Price:SetIcon("icon16/coins.png")
	self.Price:InvalidateLayout(true)
	self.Price:MoveBelow(self.Title)

	local abovepnl1 = self.Price
	if ITEM.SalePrice then
		self.SalePrice:SetText(string.format("SALE: %i token%s", ITEM.SalePrice, ITEM.SalePrice == 1 and "" or "s"))
		self.SalePrice:SetIcon("icon16/coins.png")
		self.SalePrice:InvalidateLayout(true)
		self.SalePrice:MoveBelow(self.Price)

		self.Price.text:SetTextColor(Color(200,200,200))
		abovepnl1 = self.SalePrice
	end

	local abovepnl2 = self.Price
	if ITEM.VIPRank > 0 then
		self.VIPText:SetText(string.format("%s is required for this item.",GetTierName(ITEM.VIPRank, true)))
		self.VIPText:SetIcon(GetTierSilkicon(ITEM.VIPRank))
		self.VIPText.text:SetTextColor(GetTierColor(ITEM.VIPRank))
		self.VIPText:MoveBelow(abovepnl1)
		self.VIPText:InvalidateLayout(true)

		abovepnl2 = self.VIPText
	end

	if ITEM.Description then
		self.Desc:MoveBelow(abovepnl2)
		self.Desc:SetText(ITEM.Description)
		self.Desc:SizeToContents()
		self.Desc:InvalidateLayout(true)
	else
		self.Desc:SetText("")
	end

	self:InvalidateLayout(true)
	self:SizeToChildren(true,true)

	self.ModelPanel:CenterHorizontal()
	self.Title:CenterHorizontal()
	self.VIPText:CenterHorizontal()
	self.Price:CenterHorizontal()
	self.SalePrice:CenterHorizontal()

	if ITEM.VIPRank == 0 then
		self.VIPText:Remove()
	end

	if not ITEM.SalePrice then
		self.SalePrice:Remove()
	end

	local mx,my = gui.MousePos()
	self:SetPos(mx - self:GetWide() / 2, my - self:GetTall() / 2)
end
vgui.Register("FMItemPreview", PANEL, "DPanel")
--[[
End of custom derma
]]

local function ShouldShowItem(name)
	if LocalPlayer():HasItem(name) then
		return true
	end

	local ITEM = Items.Items[name]

	local allowed = true
	if ( type(ITEM.CanPlayerBuy) == "function" ) then
		allowed = ITEM:CanPlayerBuy(LocalPlayer())
	elseif ( type(ITEM.CanPlayerBuy) == "boolean" ) then
		allowed = ITEM.CanPlayerBuy
	end

	return allowed
end

local function bitmatch(bits, test)
	return bit.band(bits, test) > 0
end

local specialcats = {
	{
		name = "Owned Items",
		icon = "icon16/basket_add.png",
		hidden = false,
		shouldshow = function(item, tbl)
			return LocalPlayer():HasItem(item)
		end
	},
	{
		name = "Un-Owned Items",
		icon = "icon16/basket_delete.png",
		hidden = false,
		shouldshow = function(item, tbl)
			return not LocalPlayer():HasItem(item)
		end
	},
	{
		name = "Equipped Items",
		icon = "icon16/user_add.png",
		hidden = false,
		shouldshow = function(item, tbl)
			return LocalPlayer():HasItemEquipped(item)
		end
	},
	{
		name = "Un-Equipped Items",
		icon = "icon16/user_delete.png",
		hidden = false,
		shouldshow = function(item, tbl)
			return not LocalPlayer():HasItemEquipped(item)
		end
	}
}

local categories
categories = {
	{
		name = "Player Models",
		icon = "icon16/user.png",
		largeicon = true,
		hidden = false,
		shouldshow = function(item, tbl)
			if tbl.Category != "Player Models" then return false end
			if not ShouldShowItem(item) then return false end

			return true
		end
	},
	{
		name = "Hats",
		icon = "icon16/vector.png",
		hidden = false,
		shouldshow = function(item, tbl)
			if tbl.Category != "Accessories" then return false end

			if not bitmatch(tbl.Covers, COVERS_SCALP) then return false end
			if bitmatch(tbl.Covers, COVERS_TORSO + COVERS_LEGS + COVERS_ARMS) then return false end

			if not ShouldShowItem(item) then return false end

			return true
		end
	},
	{
		name = "Accessories",
		icon = "icon16/color_swatch.png",
		hidden = false,
		shouldshow = function(item, tbl)
			if tbl.Category != "Accessories" then return false end

			if bitmatch(tbl.Covers, COVERS_SCALP) then return false end
			if bitmatch(tbl.Covers, COVERS_TORSO + COVERS_LEGS + COVERS_ARMS) then return false end
			if tbl.Covers == 0 then return false end

			if not ShouldShowItem(item) then return false end

			return true
		end
	},
	{
		name = "Body Sets",
		icon = "icon16/user_suit.png",
		hidden = false,
		shouldshow = function(item, tbl)
			if tbl.Category != "Accessories" then return false end

			if bitmatch(tbl.Covers, COVERS_HEAD) then return false end
			if tbl.Covers == 0 then return false end

			if not ShouldShowItem(item) then return false end

			return true
		end
	},
	{
		name = "Miscellaneous",
		icon = "icon16/tag_blue.png",
		hidden = false,
		shouldshow = function(item, tbl)
			if not ShouldShowItem(item) then return false end

			--Basically this will catch any item that wasn't included in any of the other categories
			for k,v in pairs(categories) do
				if v.name == "Miscellaneous" then continue end
				if v.shouldshow(item, tbl) then return false end
			end

			return true
		end
	}
}

local function CreateRightClickMenu(item, itemicon)
	local ITEM = Items.Items[item]
	local hasitem = LocalPlayer():HasItem(item)

	local men = DermaMenu()

	local opt = men:AddOption(ITEM.Name)
	opt:SetImage(itemicon)
	opt.OnMouseReleased = function(self, mc) DButton.OnMouseReleased(self, mc) end

	men:AddSpacer()

	/*men:AddOption("Preview", function()
		local can,msg = LocalPlayer():CanPreviewItem(item)
		if not can then
			HintError(msg)
			return
		end
	end):SetImage("icon16/book_open.png")*/

	if LocalPlayer():HasItemEquipped(item) then
		men:AddOption("Holster", function() LocalPlayer():HolsterItem(item) end):SetImage("icon16/user_delete.png")
	elseif hasitem then
		men:AddOption("Equip", function() LocalPlayer():EquipItem(item) end):SetImage("icon16/user_add.png")
	elseif LocalPlayer():GetMODTier() >= ITEM.VIPRank then
		local price = ITEM.SalePrice or ITEM.Price
		men:AddOption(string.format("Purchase (-%i token%s)", price, price == 1 and "" or "s"), function() LocalPlayer():BuyItem(item) end):SetImage("icon16/coins_add.png")
	end

	if hasitem then
		local sellprice = LocalPlayer():GetSellPrice(item)

		if sellprice == 0 then
			men:AddOption("Sell", function()
				Derma_Query("Do you want to sell " .. ITEM.Name .. " for 0 tokens?\nThis item was gifted to you.", "Sell " .. ITEM.Name,
					"Sell", function()
						LocalPlayer():SellItem(item)
					end,
					"Cancel", function() end)
			end):SetImage("icon16/coins_delete.png")
		else
			men:AddOption(string.format("Sell (+%i token%s)", sellprice, sellprice == 1 and "" or "s"), function()
				Derma_Query("Do you want to sell " .. ITEM.Name .. " for " .. sellprice .. " tokens?", "Sell " .. ITEM.Name,
					"Sell", function()
						LocalPlayer():SellItem(item)
					end,
					"Cancel", function() end)
			end):SetImage("icon16/coins_delete.png")
		end
	end

	if ITEM.Modify and hasitem then
		men:AddOption("Customize", function() ITEM:Modify(LocalPlayer().Items[item].Modifiers) end):SetImage("icon16/color_wheel.png")
	end

	men:Open()
end

local vipribbon = Material("icon32/indicator.png")
local saleribbon = Material("icon32/saleribbon.png", "smooth")
local itemslist
local lastpreview
local function UpdateItemsList()
	if not IsValid(LocalPlayer()) then return end
	if not IsValid(itemslist) then return end

	itemslist:Clear()

	for _,cat in ipairs(categories) do
		local header = vgui.Create("FMContentHeader")
			header:SetText(cat.name)
			header:SetIcon(cat.icon)
			header:InvalidateLayout(true)
		itemslist:Add(header)

		local items = {}
		for name,tbl in pairs(Items.Items) do
			if cat.shouldshow(name, tbl) then
				table.insert(items, tbl)
			end
		end

		table.sort(items, function(a,b)
			if a.Price == b.Price then return a.Name < b.Name end
			return a.Price < b.Price
		end)

		for _,ITEM in ipairs(items) do
			local mdl = vgui.Create("SpawnIconNoTooltip")
				mdl:SetSize(64,64 + (cat.largeicon and 64 or 0))
				mdl:InvalidateLayout(true)
				mdl:SetModel(ITEM.Model)
				mdl:SetTooltip(ITEM.Name)
				mdl.item = ITEM.ID
				mdl.DoRightClick = function()
					if IsValid(lastpreview) then lastpreview:Remove() end

					lastpreview = vgui.Create("FMItemPreview")
						lastpreview:Setup(ITEM.ID, cat.icon)
						lastpreview:MoveToFront()
						lastpreview:MakePopup()
						lastpreview.Think = function(self)
							if not IsValid(itemslist) or not itemslist:IsVisible() then self:Remove() end
						end
				end
				mdl.DoClick = function()
					CreateRightClickMenu(ITEM.ID, cat.icon)
				end
				if ITEM.VIPRank and ITEM.VIPRank > 0 then
					mdl.tiercol = GetTierColor(ITEM.VIPRank)
				end
				mdl.PaintOver = function(this,w,h)
					if Items.Items[this.item].SalePrice then
						surface.SetMaterial(saleribbon)
						surface.SetDrawColor(color_white)
						surface.DrawTexturedRect(0,0,60,60)
					end
					if this.tiercol then
						surface.SetMaterial(vipribbon)
						surface.SetDrawColor(this.tiercol)
						surface.DrawTexturedRect(w-20,0,20,20)
					end
				end
				mdl.Think = function(this)
					local w,h = this:GetSize()
					local x,y = this:LocalToScreen()
					local mx,my = gui.MousePos()

					local dra = mx >= x and mx <= x + w and my >= y and my <= y + h
					this.quickicon:SetImageVisible(dra)
				end

			local mdlquickicon = vgui.Create("DImageButton", mdl)
				mdlquickicon:SetSize(16,16)
				mdlquickicon:AlignBottom(4)
				mdlquickicon:CenterHorizontal()
				mdlquickicon:SetImageVisible(false)
				mdlquickicon.Show = function(self)
					self:SetSize(16,16)
					self:SetImageVisible(true)
				end
				mdlquickicon.Hide = function(self)
					self:SetSize(0,0)
					self:SetImageVisible(false)
				end

			mdl.quickicon = mdlquickicon

			itemslist:Add(mdl)
		end
	end
end

--This won't actually create anything, just swap out disabled stuff and such after purchases
local function QuickUpdateItemsList()
	if not IsValid(LocalPlayer()) then return end
	if not IsValid(itemslist) then return end

	for k,v in pairs(itemslist:GetChildren()) do
		if v.ClassName == "SpawnIconNoTooltip" then
			local hasitem = LocalPlayer():HasItem(v.item)
			local icon = v.quickicon

			if LocalPlayer():HasItemEquipped(v.item) then
				icon:Show()
				icon:SetImage("icon16/user_delete.png")
				icon:SetTooltip("Holster")
				icon.DoClick = function() LocalPlayer():HolsterItem(v.item) end
			elseif hasitem then
				icon:Show()
				icon:SetImage("icon16/user_add.png")
				icon:SetTooltip("Equip")
				icon.DoClick = function() LocalPlayer():EquipItem(v.item) end
			else
				icon:Hide()
				--[[
				icon:SetImage("icon16/coins_add.png")
				icon:SetTooltip("Purchase")
				icon.DoClick = function() LocalPlayer():BuyItem(v.item) end
				]]
			end
		end
	end
end

local function UpdateItemsFilters()
	if not IsValid(LocalPlayer()) then return end
	if not IsValid(itemslist) then return end

	for _,v in pairs(itemslist:GetChildren()) do
		if v.ClassName == "SpawnIconNoTooltip" then
			local item = v.item
			local ITEM = Items.Items[item]

			local t = {}
			t = table.Add(t, categories)
			t = table.Add(t, specialcats)

			local hide = false
			for _,tbl in pairs(t) do
				if tbl.hidden and tbl.shouldshow(item, ITEM) then
					hide = true
					break
				end
			end

			v:SetVisible(not hide)
		end
	end

	itemslist:Layout()
	timer.Simple(0,function() itemslist:GetParent():GetParent():Rebuild() end) -- Fixes canvas not rescaling properly
end

local function CreateFilterMenu()
	local men = DermaMenu()

	local function addopt(k,v)
		local opt
		opt = men:AddOption("", function(self)
			v.hidden = not v.hidden
			self:SetLabel()
			UpdateItemsFilters()
		end)
		opt.SetLabel = function(self) self:SetText(string.format("%s %s", v.hidden and "Show" or "Hide", v.name)) end
		opt:SetImage(v.icon)
		opt.OnMouseReleased = function( self, mousecode ) -- disable derma menu closing
			DButton.OnMouseReleased( self, mousecode )
			if self.m_MenuClicking and mousecode == MOUSE_LEFT then
				self.m_MenuClicking = false
			end
		end

		opt:SetLabel()
	end

	for k,v in pairs(categories) do
		addopt(k,v)
	end

	men:AddSpacer()

	for k,v in pairs(specialcats) do
		addopt(k,v)
	end

	men:AddSpacer()

	men:AddOption("Reset all filters", function()
		for k,v in pairs(categories) do
			v.hidden = false
		end
		for k,v in pairs(specialcats) do
			v.hidden = false
		end
		UpdateItemsFilters()
	end)

	men:Open()
end

local function OpenClrPicker(clearbtn, donefunc)
	local pickframe = vgui.Create("DFrame")
		pickframe:SetSize(300,300)
		pickframe:Center()
		pickframe:ShowCloseButton(true)
		pickframe:SetTitle("Pick a color")
		pickframe:MakePopup()

	local picker = vgui.Create("DColorMixer", pickframe)
		picker:SetPalette(true)
		picker:SetAlphaBar(false)
		picker:SetWangs(false)
		picker:Dock(FILL)

	if clearbtn then
		local clrbtn = vgui.Create("DButton", pickframe)
			clrbtn:Dock(BOTTOM)
			clrbtn:DockMargin(30,5,30,0)
			clrbtn:SetText("Default")
			clrbtn.DoClick = function()
				donefunc(nil)
				pickframe:Close()
			end
	end

	local okbtn = vgui.Create("DButton", pickframe)
		okbtn:Dock(BOTTOM)
		okbtn:DockMargin(30,5,30,0)
		okbtn:SetText("Ok")
		okbtn.DoClick = function()
			donefunc(picker:GetColor())
			pickframe:Close()
		end
end

local function CreateSettingsMenu()
	local men = DermaMenu()

	if LocalPlayer():Alive() or GAMEMODE:IsPhase(TIME_BUILD) then
		men:AddOption("Preview Yourself", function()
			LocalPlayer().showthirdperson = true
		end):SetImage("icon16/user.png")
	end

	local defplyclr, defphysclr = hook.Run("FMDefaultColors", LocalPlayer())

	if LocalPlayer():GetVIPTier() >= 1 then
		men:AddOption("Set Player Color", function()
			OpenClrPicker(true, function(color)
				RunConsoleCommand("cl_playercolor", ColorToVectorString(color or defplyclr))
				Hint("Player color updated!")
			end)
		end):SetImage("icon16/color_swatch.png")

		men:AddOption("Set Physgun Color", function()
			OpenClrPicker(true, function(color)
				RunConsoleCommand("cl_weaponcolor", ColorToVectorString(color or defphysclr))
				Hint("Physgun color updated!")
			end)
		end):SetImage("icon16/color_wheel.png")
	end

	men:AddOption("Un-Equip All Items", function()
		LocalPlayer():HolsterAllItems()
	end):SetImage("icon16/user_delete.png")

	men:Open()
end

local function SetupStoreSection(parent, parentw, parenth)
	parent.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(31, 31, 31))
	end

	local topbar = vgui.Create("DPanel", parent)
		topbar:SetTall(30)
		topbar:Dock(TOP)
		topbar.Paint = function(self, w, h)
			surface.SetDrawColor(Color(105, 105, 105))
			surface.DrawRect(0,h-2,w,2)
		end

	local topbaricon = vgui.Create("DImage", topbar)
		topbaricon:SetImage("icon16/information.png")
		topbaricon:SetSize(16, 16)
		topbaricon:SetPos(7, 7)

	local topbarlbl = vgui.Create("DLabel", topbar)
		topbarlbl:SetFont("FMRegular18")
		topbarlbl:SetText("Left click an item to purchase/customize. Right click to preview it.")
		topbarlbl:SizeToContents()
		topbarlbl:SetPos(30,0)
		topbarlbl:CenterVertical()

	local bottombar = vgui.Create("DPanel", parent)
		bottombar:SetTall(30)
		bottombar:Dock(BOTTOM)
		bottombar.Paint = function(self, w, h)
			surface.SetDrawColor(Color(105, 105, 105))
			surface.DrawRect(0,0,w,2)
		end

	local bottombarlbl = vgui.Create("DLabel", bottombar)
		bottombarlbl:SetFont("FMRegular24")
		bottombarlbl:SetTextColor(Color(111, 203, 90))
		bottombarlbl:SizeToContents()
		bottombarlbl:Dock(FILL)
		bottombarlbl:DockMargin(5, 7, 5, 5)
		bottombarlbl.Think = function()
			local tokens = LocalPlayer().GetTokens and LocalPlayer():GetTokens()
			if tokens then
				bottombarlbl:SetText("Tokens: " .. tokens)
			end
		end

	local bottombarsettingsbtn = vgui.Create("DButton", bottombar)
		bottombarsettingsbtn:SetFont("FMRegular16")
		bottombarsettingsbtn:SetText("Settings")
		bottombarsettingsbtn:SetSize(100, 20)
		bottombarsettingsbtn:Dock(RIGHT)
		bottombarsettingsbtn:DockMargin(0, 7, 5, 5)
		bottombarsettingsbtn.DoClick = CreateSettingsMenu

	local bottombarfilterbtn = vgui.Create("DButton", bottombar)
		bottombarfilterbtn:SetFont("FMRegular16")
		bottombarfilterbtn:SetText("Filter")
		bottombarfilterbtn:SetSize(100, 20)
		bottombarfilterbtn:Dock(RIGHT)
		bottombarfilterbtn:DockMargin(5, 7, 5, 5)
		bottombarfilterbtn.DoClick = CreateFilterMenu

	local scrollbar = vgui.Create("DScrollPanel", parent)
		scrollbar:Dock(FILL)

	local width = parentw - 50
	local iconsx = math.floor(width / 64)
	local spacingx = math.floor((width - (iconsx * 64)) / (iconsx * 2))

	itemslist = vgui.Create("FMTileLayout", scrollbar)
		itemslist:Dock(FILL)
		itemslist:SetCellMarginX(spacingx)

	UpdateItemsList()
	QuickUpdateItemsList()
	UpdateItemsFilters()

	itemslist:Layout()
end

hook.Add("OnSpawnMenuClose", "ItemsStore", function()
	CloseDermaMenus()

	if IsValid(lastpreview) then
		lastpreview:Remove()
	end
end)

hook.Add("FMReloadSpawnIcons", "ReloadStoreIcons", function()
	if itemslist then
		for _,v in pairs(itemslist:GetChildren()) do
			if v.RebuildSpawnIcon then
				v:RebuildSpawnIcon()
			end
		end
		printInfo("Store icons reloaded.")
	else
		printInfo("Store icons not reloaded")
	end
end)

local tokenlbl
hook.Add("FMTokensUpdate", "UpdateStore", function(newam)
	if tokenlbl then
		tokenlbl:SetText("Tokens: " .. newam)
	end
end)

hook.Add("FMItemsUpdate", "honk", function()
	UpdateItemsList()
	QuickUpdateItemsList()
	UpdateItemsFilters()
end)

local function SetupTokensForCash(bg,bgw)
	local bg2 = vgui.Create("DPanel")
		bg2:SetTall(109)
		bg:Add(bg2)

	local txt1 = vgui.Create("DLabelCenter", bg2)
		txt1:SetPos(5,5)
		txt1:SetWide(bgw-10)
		txt1:SetFont("FMRegular24")
		txt1:SetTextColor(FMCOLORS.txt)
		txt1:SetText("Buy tokens with in-game cash")

	local txt2 = vgui.Create("DLabelCenter", bg2)
		txt2:SetPos(5,34 + 20 + 5)
		txt2:SetWide(bgw-10)
		txt2:SetFont("FMRegular20")
		txt2:SetBright(true)
		txt2:SetText("Will cost $0 cash.")

	local txtbx
	local btn = vgui.Create("DButton", bg2)
		btn:SetPos(5,34 + 20 + 5 + 20 + 5)
		btn:SetSize(bgw-10, 20)
		btn:SetText("Purchase")
		btn:SetDisabled(true)
		btn.DoClick = function()
			net.Start("FMCashForTokens")
				net.WriteUInt(txtbx:GetInt(), 32)
			net.SendToServer()
		end

	txtbx = vgui.Create("DTextEntry", bg2)
		txtbx:SetPos(5, 34)
		txtbx:SetWide(bgw-10)
		txtbx:SetPlaceholderText("Input desired amount (1 Token will cost you $2,000 in-game cash)​")
		txtbx.AllowInput = function(this, value)
			return string.find("1234567890", value) -- Allow only numbers
		end
		txtbx.OnChange = function(this)
			local newstr, founds = string.gsub(this:GetText(), "[^%d]", "") -- Replace any nondigits with nothing
			if #newstr > 4 then
				founds = 1
				newstr = string.sub(newstr, 1, 4)
			end
			if founds > 0 then
				this:SetText(newstr)
			end

			local am = this:GetText()
			local cost
			if not am or #am == 0 then
				cost = 0
			else
				am = tonumber(am)
				if not am then
					cost = 0
				else
					cost = math.Round(TokenToCashEquation( am ))
					cost = math.max(cost,0)
				end
			end

			txt2:SetText(string.format("Will cost %s cash.", FormatMoney(cost)))
			btn:SetDisabled(not (cost > 0 and LocalPlayer():CanAfford(cost)))
		end
end

local function SetupCashForTokens(bg,bgw)
	local bg2 = vgui.Create("DPanel")
		bg2:SetTall(109)
		bg:Add(bg2)

	local txt1 = vgui.Create("DLabelCenter", bg2)
		txt1:SetPos(5,5)
		txt1:SetWide(bgw-10)
		txt1:SetFont("FMRegular24")
		txt1:SetTextColor(FMCOLORS.txt)
		txt1:SetText("Sell tokens for in-game cash")

	local txt2 = vgui.Create("DLabelCenter", bg2)
		txt2:SetPos(5,34 + 20 + 5)
		txt2:SetWide(bgw-10)
		txt2:SetFont("FMRegular20")
		txt2:SetBright(true)
		txt2:SetText("Will give you $0 cash.")

	local txtbx
	local btn = vgui.Create("DButton", bg2)
		btn:SetPos(5,34 + 20 + 5 + 20 + 5)
		btn:SetSize(bgw-10, 20)
		btn:SetText("Sell")
		btn:SetDisabled(true)
		btn.DoClick = function()
			net.Start("FMTokensForCash")
				net.WriteUInt(txtbx:GetInt(), 32)
			net.SendToServer()
		end

	txtbx = vgui.Create("DTextEntry", bg2)
		txtbx:SetPos(5, 34)
		txtbx:SetWide(bgw-10)
		txtbx:SetPlaceholderText("Input token amount (1 Token gives you $1,000 in-game cash)​")
		txtbx.AllowInput = function(this, value)
			return string.find("1234567890", value) -- Allow only numbers
		end
		txtbx.OnChange = function(this)
			local newstr, founds = string.gsub(this:GetText(), "[^%d]", "") -- Replace any nondigits with nothing
			if #newstr > 4 then
				founds = 1
				newstr = string.sub(newstr, 1, 4)
			end
			if founds > 0 then
				this:SetText(newstr)
			end

			local am = this:GetText()
			local cost
			if not am or #am == 0 then
				am = 0
				cost = 0
			else
				am = tonumber(am)
				if not am then
					cost = 0
				else
					cost = math.Round(CashToTokenEquation( am ))
					cost = math.max(cost,0)
				end
			end

			txt2:SetText(string.format("Will give you %s.", FormatMoney(cost)))
			btn:SetDisabled(not (am > 0 and LocalPlayer():CanAffordTokens(am)))
		end
end

local function SetupTokensForUSD(bg,bgw)
	local bg2 = vgui.Create("DPanel")
		bg:Add(bg2)

	local txt1 = vgui.Create("DLabelCenter", bg2)
		txt1:SetPos(5,5)
		txt1:SetWide(bgw-10)
		txt1:SetFont("FMRegular24")
		txt1:SetTextColor(FMCOLORS.txt)
		txt1:SetText("Buy tokens with USD")

	local btn
	local txt2
	local txtbx = vgui.Create("DTextEntry", bg2)
		txtbx:SetPos(5, 34)
		txtbx:SetWide(bgw-10)
		txtbx:SetPlaceholderText("Input desired amount")
		txtbx.AllowInput = function(this, value)
			return string.find("1234567890", value) -- Allow only numbers
		end
		txtbx.OnChange = function(this)
			local am = tonumber(this:GetText())
			local cost = 0
			if not am then
				am = 0
			elseif am >= MINTOKENPURCHASE and am <= 9999 then
				cost = TokenToUSDEquation(am)
			end

			txt2:SetText(string.format("Will cost $%g USD.", cost))
			btn:SetDisabled(not (am >= MINTOKENPURCHASE and am <= 9999))
		end

	local txt4 = vgui.Create("DLabelCenter", bg2)
		txt4:SetPos(5,34 + 20 + 5)
		txt4:SetWide(bgw-10)
		txt4:SetFont("FMRegular18")
		txt4:SetTextColor(Color(150, 150, 150))
		txt4:SetText("The more you buy, the cheaper it gets")

	txt2 = vgui.Create("DLabelCenter", bg2)
		txt2:SetPos(5,34 + 20 + 5 + 20 + 5)
		txt2:SetWide(bgw-10)
		txt2:SetFont("FMRegular20")
		txt2:SetBright(true)
		txt2:SetText("Will cost $0 USD.")

	btn = vgui.Create("DButton", bg2)
		btn:SetPos(5,34 + 20 + 5 + 20 + 5 + 20 + 5)
		btn:SetSize(bgw-10, 20)
		btn:SetText("Purchase")
		btn:SetDisabled(true)
		btn.DoClick = function()
			gui.OpenURL(string.format("https://purchase.devinity.org/tokenredirect.php?steamid=%s&tokenam=%i", LocalPlayer():SteamID(), txtbx:GetInt()))
		end

	local txt3 = vgui.Create("DLabelWordWrap", bg2)
		txt3:SetMaxWidth(bgw-10)
		txt3:SetPos(5,34 + 20 + 5 + 20 + 5 + 20 + 5 + 20 + 5)
		txt3:SetTextColor(Color(100,100,100))
		txt3:SetFont("FMRegular16i")
		txt3:SetText(
" • Purchases made with USD require a minimum of five tokens.\n " ..
"• All purchases are non-refundable.\n " ..
"• Currency will be converted to USD if necessary; paypal conversion rates may apply.\n" ..
"• Please rejoin any of Devinity's Flood servers to claim your tokens after a completed transaction.\n " ..
"• Token rates are subject to change.")
		txt3:SizeToContents()

	bg2:SetTall(34 + 20 + 5 + 20 + 5 + 20 + 5 + 20 + 5 + txt3:GetTall() + 5)
end

local raisins =
{
	"Failed: Couldn't contact the Steam Web API correctly. Please try again later.",
	"Failed: Couldn't find you in our group.",
	"Failed: Already claimed reward.",
	"Failed: Profile private.",
	"Failed: Unknown error.",
	"Success, You've received 10 tokens!"
}

local lastclaim = 0
function ClaimGroupReward()
	if lastclaim > CurTime() then Hint(string.format("Please wait %i seconds before doing that again.", math.ceil(lastclaim - CurTime()))) return end
	lastclaim = CurTime() + 10

	net.Start("FMGroupRewardAsk")
	net.SendToServer()
end

net.Receive("FMGroupRewardResp", function()
	local raisin = raisins[net.ReadUInt(3) + 1]

	Hint(raisin)
end)

local tokenlabel
local function SetupTokenSection(parent, parentw, parenth)
	local w = math.min(parentw - 15, 586)
	local containerw = w - 20
	local bgw = 400
	local inset = containerw / 2 - bgw / 2

	local scrollbar = vgui.Create("DScrollPanel", parent)
		scrollbar:Dock(FILL)

	local bgtokens = vgui.Create("DListLayout", scrollbar)
		bgtokens:Dock(FILL)
		bgtokens:DockMargin(inset,0,inset,0)

		local old = bgtokens.OnChildAdded
		bgtokens.OnChildAdded = function(self, child)
			old(self, child)
			child:DockMargin(0, 10, 0, 0)
		end

	local bg1 = vgui.Create("DPanel", bgtokens)
		bg1:SetTall(34)
		bgtokens:Add(bg1)

	tokenlabel = vgui.Create("DLabelCenter", bg1)
		tokenlabel:SetPos(5,5)
		tokenlabel:SetWide(bgw-10)
		tokenlabel:SetFont("FMRegular24")
		tokenlabel:SetTextColor(FMCOLORS.txt)
		tokenlabel:SetText(string.format("You currently have: %i tokens", 0)) -- Setting to 0 cause LocalPlayer() will be invalid here anyways

	SetupTokensForCash(bgtokens,bgw)
	SetupCashForTokens(bgtokens,bgw)
	SetupTokensForUSD(bgtokens,bgw)

	local bg2 = vgui.Create("DPanel")
		bg2:DockPadding(5,5,5,5)
		bg2:SetTall(130)

	local txt1 = vgui.Create("DLabelCenter", bg2)
		txt1:Dock(FILL)
		txt1:DockMargin(0,0,0,5)
		txt1:SetFont("FMRegular20")
		txt1:SetTextColor(FMCOLORS.txt)
		txt1:SetText(string.format("Receive %i tokens by joining our Steam group!", GROUPTOKENREWARD))

	local btn = vgui.Create("DButton", bg2)
		btn:Dock(BOTTOM)
		btn:DockMargin(0,0,0,5)
		btn:SetTall(24)
		btn:SetFont("FMRegular20")
		btn:SetText("Claim Reward")
		btn.DoClick = ClaimGroupReward

	local grpbtn = vgui.Create("DButton", bg2)
		grpbtn:Dock(BOTTOM)
		grpbtn:DockMargin(0,0,0,5)
		grpbtn:SetTall(24)
		grpbtn:SetFont("FMRegular20")
		grpbtn:SetText("Steam Group")
		grpbtn.DoClick = function() gui.OpenURL("http://devinity.org/groupredirect.php") end
		txt1:SizeToContents()

	local txt2 = vgui.Create("DLabelWordWrap", bg2)
		txt2:Dock(BOTTOM)
		txt2:DockMargin(0,0,0,5)
		txt2:SetFont("FMRegular16i")
		txt2:SetMaxWidth(bgw - 10)
		txt2:SetTextColor(Color(100,100,100))
		txt2:SetText("NOTE: Your Steam profile must be set to \"Public\" before joining.")
		txt2:SizeToContents()

	bgtokens:Add(bg2)
end

function SetupStore(parent, parentw, parenth)
	local w = math.min(parentw - 15, 586)
	local h = parenth - 45

	local proplist = vgui.Create("DPropertySheet", parent)
		proplist:SetSize(w,h)
		proplist:SetPos(0,5)

	--[[
	Store section
	]]
	local bgstore = vgui.Create("DPanel")
		bgstore.Paint = function() end

	SetupStoreSection(bgstore, parentw, parenth)

	proplist:AddSheet("Store", bgstore, "icon16/cart.png")

	--[[
	Token section
	]]
	local bgtokens = vgui.Create("DPanel")
		bgtokens.Paint = function() end

	SetupTokenSection(bgtokens, parentw, parenth)

	proplist:AddSheet("Tokens", bgtokens, "icon16/coins_add.png")

end

hook.Add("FMSpawnmenuUpdate", "UpdateTokensCount", function()
	if IsValid(tokenlabel) then
		tokenlabel:SetText(string.format("You currently have: %i tokens", LocalPlayer():GetTokens()))
	end
end)
