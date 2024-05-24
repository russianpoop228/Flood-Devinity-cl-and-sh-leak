local meta = FindMetaTable("Player")

Items = {}
Items.__index = Items

Items.Items = {}
Items.Categories = {}
Items.ClientsideModels = {}

COVERS_SCALP     = bit.lshift(1,0)
COVERS_NECK      = bit.lshift(1,1)
COVERS_FOREHEAD  = bit.lshift(1,2)
COVERS_EYES      = bit.lshift(1,3)
COVERS_NOSE      = bit.lshift(1,4)
COVERS_MOUTH     = bit.lshift(1,5)
COVERS_THROAT    = bit.lshift(1,6)
COVERS_UPPERBACK = bit.lshift(1,7)
COVERS_LOWERBACK = bit.lshift(1,8)
COVERS_CHEST     = bit.lshift(1,9)
COVERS_STOMACH   = bit.lshift(1,10)
COVERS_WAIST     = bit.lshift(1,11)
COVERS_RHAND     = bit.lshift(1,12)
COVERS_LHAND     = bit.lshift(1,13)
COVERS_RLEGLOW   = bit.lshift(1,14)
COVERS_LLEGLOW   = bit.lshift(1,15)
COVERS_RLEGHIGH  = bit.lshift(1,16)
COVERS_LLEGHIGH  = bit.lshift(1,17)
COVERS_RARMLOW   = bit.lshift(1,18)
COVERS_LARMLOW   = bit.lshift(1,19)
COVERS_RARMHIGH  = bit.lshift(1,20)
COVERS_LARMHIGH  = bit.lshift(1,21)

COVERS_FACE      = COVERS_FOREHEAD + COVERS_EYES + COVERS_NOSE + COVERS_MOUTH
COVERS_HEAD      = COVERS_SCALP + COVERS_FACE
COVERS_BACK      = COVERS_UPPERBACK + COVERS_LOWERBACK
COVERS_FRONT     = COVERS_CHEST + COVERS_STOMACH
COVERS_TORSO     = COVERS_BACK + COVERS_FRONT
COVERS_LLEG      = COVERS_LLEGLOW + COVERS_LLEGHIGH
COVERS_RLEG      = COVERS_RLEGLOW + COVERS_RLEGHIGH
COVERS_LEGS      = COVERS_LLEG + COVERS_RLEG
COVERS_LARM      = COVERS_LARMLOW + COVERS_LARMHIGH
COVERS_RARM      = COVERS_RARMLOW + COVERS_RARMHIGH
COVERS_ARMS      = COVERS_LARM + COVERS_RARM

COVERS_PLYMDL    = bit.lshift(1,22)

function Items:SetupItem(id, filename, CategoryName, CategoryID)
	local folder = GM and GM.FolderName or GAMEMODE.FolderName

	ITEM = self.Items[id] or {}

	ITEM.__index    = ITEM
	ITEM.ID         = id
	ITEM.Category   = ITEM.Category or CategoryName
	ITEM.CategoryID = ITEM.CategoryID or CategoryID
	ITEM.Price      = ITEM.Price or 0

	ITEM.VIPRank        = ITEM.VIPRank or 0
	ITEM.SingleUse      = false
	ITEM.NoPreview      = false
	ITEM.Covers         = ITEM.Covers or 0
	ITEM.PersistOnDeath = false

	if ITEM.CanPlayerBuy == nil then ITEM.CanPlayerBuy = true end
	if ITEM.CanPlayerSell == nil then ITEM.CanPlayerSell = true end
	ITEM.CanPlayerEquip   = true
	ITEM.CanPlayerHolster = true

	ITEM.OnBuy                 = function() end
	ITEM.OnSell                = function() end
	ITEM.OnEquip               = function() end
	ITEM.OnHolster             = function() end
	ITEM.OnModify              = function() end
	ITEM.SanitizeModifiers     = function() end
	ITEM.ModifyClientsideModel = function(_, ply, model, pos, ang)
		return model, pos, ang
	end

	ITEM.HookHooks = function(self, ply)
		for k,v in pairs(self) do
			if type(v) == "function" then
				local hookid = "ITEM_HOOK_" .. self.Name .. "_" .. ply:EntIndex()
				hook.Add(k, hookid, function(...)
					if not IsValid(ply) then
						hook.Remove(k, hookid)
						return
					end
					if not ply.Items then return end

					local item = ply.Items[self.ID]
					if not item then
						LogFile("Item not valid error! " .. util.TableToJSON({self.ID, self.Name, ply:EntIndex(), ply:SteamID()}), "admin")
						return
					end

					local ret = self[k](self, ply, item.Modifiers, unpack({...}))
					if ret != nil then
						return ret
					end
				end)
			end
		end
	end
	ITEM.UnHookHooks = function(self, ply)
		for k,v in pairs(self) do
			if type(v) == "function" then
				hook.Remove(k, "ITEM_HOOK_" .. self.Name .. "_" .. ply:EntIndex())
			end
		end
	end

	include(folder .. "/gamemode/items/" .. ITEM.CategoryID .. "/_base.lua")
	if filename then
		include(filename)
	end

	if not ITEM.Name then
		printWarn("Item missing name: %q", id)
		return
	elseif not ITEM.Price then
		printWarn("Item missing price: %q", id)
		return
	elseif not ITEM.Model and not ITEM.Material then
		printWarn("Item missing model or material: %q", id)
		return
	end

	--Check model's $modelname
	if CLIENT and ITEM.Model then
		local ent = ClientsideModel(ITEM.Model)
		if ent:GetModel() == "models/error.mdl" then
			printWarn("You're missing a model, ask for help in the forums (%q).", ITEM.Model)
		elseif ent:GetModel():lower() != ITEM.Model:lower() then
			printWarn("Item %q: $modelname doesn't match model path, might cause issues.\n$modelname:\t%q\nPath:\t\t%q", id, ent:GetModel(), ITEM.Model)
		end
		ent:Remove()
	end

	-- precache

	if ITEM.Model then
		if ITEM.Hands then
			player_manager.AddValidModel(id, ITEM.Model)

			local hands = istable(ITEM.Hands) and ITEM.Hands or {ITEM.Hands}
			player_manager.AddValidHands(id, hands[1], hands[2] or 0, hands[3] or "0000000")
			util.PrecacheModel(hands[1])
		end

		util.PrecacheModel(ITEM.Model)
	end

	self.Items[id] = ITEM

	ITEM = nil
end

function Items:SetupAll()
	for k, _ in pairs(self.Items) do
		self:SetupItem(k)
	end
end

function Items:LoadFromDisk()
	local folder = GM and GM.FolderName or GAMEMODE.FolderName

	local _, dirs = file.Find(folder .. "/gamemode/items/*", "LUA")

	for _, category in pairs(dirs) do
		local f, _ = file.Find(folder .. "/gamemode/items/" .. category .. "/__category.lua", "LUA")

		if #f > 0 then
			CATEGORY = {}

			CATEGORY.Name = ""
			CATEGORY.Icon = ""
			CATEGORY.Order = 0
			CATEGORY.AutoHolsterAll = false
			CATEGORY.ModifyTab = function(tab) return end

			include(folder .. "/gamemode/items/" .. category .. "/__category.lua")

			if not Items.Categories[category] then
				Items.Categories[category] = CATEGORY
			end

			local files, _ = file.Find(folder .. "/gamemode/items/" .. category .. "/*.lua", "LUA")

			for _, name in pairs(files) do
				if name != "__category.lua" then
					if name:sub(1,1) == "_" then continue end -- file starting with _ indicates this is a "base" item

					local id = string.gsub(string.lower(name), ".lua", "")

					self:SetupItem(id, folder .. "/gamemode/items/" .. category .. "/" .. name, CATEGORY.Name, category)
				end
			end

			CATEGORY = nil
		end
	end
end

function meta:GetItems()
	return self.Items or {}
end

function meta:HasItem(name)
	if not self.Items then return false end
	if not self.Items[name] then return false end
	if self.Items[name].Overridden then return false end

	return true
end

function meta:HasItemEquipped(name)
	if not self.Items then return false end
	if not self.Items[name] then return false end

	return self.Items[name].Equipped or false
end

function meta:GetEquippedItems()
	local t = {}
	for k,v in pairs(self.Items or {}) do
		if not Items.Items[k] then continue end -- Item might not have loaded yet (clientside)

		if v.Equipped then
			t[#t + 1] = k
		end
	end
	return t
end

function meta:GetEquippedItemFromCategory(cat)
	for _,name in pairs(self:GetEquippedItems()) do
		local c = Items.Items[name].Category

		if c == cat then
			return name
		end
	end
end

function meta:GetGender()
	local mdl = self:GetModel()

	--Caching
	if self._lastgendermdl and self._lastgendermdl == mdl then return self._lastgender end
	self._lastgendermdl = mdl

	local mdlitem = self:GetEquippedItemFromCategory("Player Models")
	if mdlitem then
		local ITEM = Items.Items[mdlitem]
		if ITEM.Gender then
			self._lastgender = ITEM.Gender
			return ITEM.Gender
		end
	end

	local gender
	if mdl:find("combine") then
		gender = "combine"
	elseif mdl:find("female") then
		gender = "female"
	else
		gender = "male"
	end

	self._lastgender = gender

	return gender
end
