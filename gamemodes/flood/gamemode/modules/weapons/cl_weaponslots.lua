local wepslotsconvar = CreateClientConVar("fm_wepslots", util.TableToJSON({}))

function GM:SetWeaponSlots(tbl)
	-- Parse the tbl into a nicer structure
	local slots = {}
	for slotx, column in pairs(tbl) do
		for sloty, id in pairs(column) do
			slots[id] = {slotx = slotx - 1, sloty = sloty - 1} -- Slots are 0-indexed
		end
	end

	self.WeaponSlots = slots

	-- Update all weapon objects and spawned weapons with the new info
	for class, weptbl in pairs(GetWeaponTable()) do
		local newSlots = slots[weptbl.id]
		local wepdata = weptbl.wepdata

		-- Update weapon tables
		local update = {
			Slot            = newSlots and newSlots.slotx or wepdata.slotx,
			SlotPos         = newSlots and newSlots.sloty or wepdata.sloty,
		}

		local stored = weapons.GetStored(class)
		if not stored then continue end

		table.Merge(stored, update)
		for _, wep in pairs(ents.FindByClass(class)) do
			table.Merge(wep, update)
		end
	end
end

-- Called whenever the server sends new weapon data, lets us override the stored db values
hook.Add("FMOverrideWeaponSlots", "SetWeaponSlots", function(class, weptbl, curslotx, cursloty)
	if not GAMEMODE.WeaponSlots then return end
	if not GAMEMODE.WeaponSlots[weptbl.id] then return end

	local slots = GAMEMODE.WeaponSlots[weptbl.id]
	return slots.slotx, slots.sloty
end)

function GM:SaveWeaponSlots(tbl)
	local txt = util.TableToJSON(tbl)
	txt = string.gsub(txt, "%.0+", "") -- Remove decimals to save space
	wepslotsconvar:SetString(txt)
end

function GM:GetWeaponSlots(id)
	if not GAMEMODE.WeaponSlots then return end
	return GAMEMODE.WeaponSlots[id]
end

function GM:LoadWeaponSlots()
	local txt = wepslotsconvar:GetString()
	local tbl = util.JSONToTable(txt) or {}

	local slots = {}
	for slotx, column in pairs(tbl) do
		for sloty, id in pairs(column) do
			slots[id] = {slotx = slotx - 1, sloty = sloty - 1} -- Slots are 0-indexed
		end
	end
	self.WeaponSlots = slots
end
GM:LoadWeaponSlots()
