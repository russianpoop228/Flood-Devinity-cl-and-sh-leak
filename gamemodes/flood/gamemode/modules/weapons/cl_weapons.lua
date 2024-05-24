

AddSettingsItem("weapons", "checkbox", "cl_tfa_hud_enabled", {lbl = "Weapon HUD"})
AddSettingsItem("weapons", "checkbox", "cl_tfa_ironsights_toggle", {lbl = "Toggled Ironsights"})
AddSettingsItem("weapons", "checkbox", "cl_tfa_ironsights_resight", {lbl = "Preserve Ironsights"})
AddSettingsItem("weapons", "checkbox", "cl_tfa_fx_gasblur", {lbl = "FX: Gasblur"})
AddSettingsItem("weapons", "checkbox", "cl_tfa_fx_muzzlesmoke", {lbl = "FX: Muzzlesmoke"})
AddSettingsItem("weapons", "checkbox", "cl_tfa_fx_muzzlesmoke_limited", {lbl = "FX: Muzzlesmoke Limit"})
AddSettingsItem("weapons", "checkbox", "cl_tfa_fx_ejectionsmoke", {lbl = "FX: Ejectionsmoke"})
AddSettingsItem("weapons", "checkbox", "cl_tfa_fx_impact_enabled", {lbl = "FX: Impact"})

local hl2weps = {
	["weapon_357"] = true,
	["weapon_ar2"] = true,
	["weapon_crossbow"] = true,
	["weapon_crowbar"] = true,
	["weapon_frag"] = true,
	["weapon_pistol"] = true,
	["weapon_shotgun"] = true,
	["weapon_smg1"] = true,
	["weapon_stunstick"] = true
}

local function SetWeaponInfo(class)
	if hl2weps[class] then return end

	local wepdata = GetWeaponData(class)

	local stored = weapons.GetStored(class)
	if not stored then
		printError("Tried setting weapon info on invalid weapon class %q", class)
		return
	end

	local update = {
		PrintName       = wepdata.name,
		Instructions    = wepdata.tip,
		Slot            = wepdata.wepdata.slotx,
		SlotPos         = wepdata.wepdata.sloty,
		AutoSwitchFrom  = false,
		AutoSwitchTo    = false,
		Weight          = 1,
		AlwaysPVP       = wepdata.alwayspvp,
		FiresUnderwater = wepdata.underwater,
		Primary = {
			Ammo           = wepdata.ammotype,
			Damage         = wepdata.damage,
			PVPDamage      = wepdata.pvpdamage,
			Knockback      = wepdata.wepdata.pvpknockback,
			ClipSize       = wepdata.wepdata.clipsize,
			DefaultClip    = wepdata.wepdata.clipsize,
			RPM            = wepdata.wepdata.rpm,
			KickUp         = wepdata.wepdata.kickup,
			KickDown       = wepdata.wepdata.kickdown,
			KickHorizontal = wepdata.wepdata.kickhorizontal,
			Spread         = wepdata.wepdata.spread,
			IronAccuracy   = wepdata.wepdata.ironspread,
			NumShots       = wepdata.wepdata.numshots,
			Range          = wepdata.wepdata.range,
		}
	}

	if wepdata.secammotype then
		update.Secondary = {
			Ammo = wepdata.secammotype,
		}
	end

	local slotx, sloty = hook.Run("FMOverrideWeaponSlots", class, wepdata, wepdata.wepdata.slotx, wepdata.wepdata.sloty)
	if isnumber(slotx) and isnumber(sloty) then
		update.Slot = slotx
		update.SlotPos = sloty
	end

	if stored.HasReceivedInitialData and LocalPlayer():GetMODTier() >= RANK_JUNIOR then
		local diff = table.Diff(update, stored, wepdata.name .. ": ")
		if #diff > 0 then
			for _, v in pairs(diff) do
				printInfo(v)
			end
		end
	end

	table.Merge(stored, update)
	stored.HasReceivedInitialData = true

	for _, wep in pairs(ents.FindByClass(class)) do
		table.Merge(wep, update)
	end
end

local weaponIDLookup
local weaponDefinitions = {}
net.Receive("FMSendWeaponDefinitions", function()
	weaponDefinitions = {}
	weaponIDLookup = nil

	for _ = 1,net.ReadUInt(8) do
		local class = net.ReadString()
		weaponDefinitions[class] = {
			id          = net.ReadUInt(8),
			class       = class,
			name        = net.ReadString(),
			model       = net.ReadString(),
			tip         = net.ReadString(),
			price       = net.ReadInt(20),
			damage      = math.Round(net.ReadFloat(), 5),
			pvpdamage   = math.Round(net.ReadFloat(), 5),
			alwayspvp   = net.ReadBool(),
			tier        = net.ReadUInt(4),
			ammo        = net.ReadInt(16),
			ammotype    = net.ReadString(),
			secammo     = net.ReadInt(16),
			secammotype = net.ReadString(),
			tags        = util.JSONToTable(net.ReadString()),
			sortindex   = net.ReadUInt(8),
			cat         = net.ReadString(),
			underwater  = net.ReadBool(),
			wepdata = {
				rpm            = net.ReadUInt(16),
				pvpknockback   = math.Round(net.ReadFloat(), 5),
				kickup         = math.Round(net.ReadFloat(), 5),
				kickdown       = math.Round(net.ReadFloat(), 5),
				kickhorizontal = math.Round(net.ReadFloat(), 5),
				spread         = math.Round(net.ReadFloat(), 5),
				ironspread     = math.Round(net.ReadFloat(), 5),
				numshots       = net.ReadUInt(8),
				range          = net.ReadUInt(16),
				slotx          = net.ReadUInt(4),
				sloty          = net.ReadUInt(4),
				clipsize       = net.ReadUInt(16),
			}
		}

		if weaponDefinitions[class].secammotype == "" then
			weaponDefinitions[class].secammotype = nil
			weaponDefinitions[class].secammo = nil
		end

		SetWeaponInfo(class)
	end

	hook.Run("FMReceivedWeaponDefinitions")
end)

function GetWeaponTable()
	return weaponDefinitions
end

function GetWeaponData(class)
	return weaponDefinitions[class]
end

function GetWeaponDataByID(id)
	if not weaponIDLookup then
		weaponIDLookup = {}
		for _, weptbl in pairs(GetWeaponTable()) do
			weaponIDLookup[weptbl.id] = weptbl
		end
	end

	return weaponIDLookup[weptbl.id]
end

hook.Add("FMOnReloaded", "ResendWeaponsPlease", function()
	net.Start("FMWeaponsReload")
	net.SendToServer()
end)

local gunvolumeconvar = CreateClientConVar("fm_gunvolume", 1, true, false)
AddSettingsItem("flood", "slider", "fm_gunvolume", {lbl = "Gun Volume (Only your own)", min = 0.15, max = 1, decimals = 2})
hook.Add("EntityEmitSound", "FMControlVolumeGun", function(data)
	if data.Channel == CHAN_WEAPON then
		local vol = math.Round(gunvolumeconvar:GetFloat(), 2)
		if vol == 1 then return end

		vol = math.Clamp(vol, 0.15, 1)

		data.Volume = vol
		return true
	end
end)

-- Disable underwater shooting
-- Somewhat old system, TFA uses its own
hook.Add("CreateMove", "UnderwaterShoot", function(mv)
	local ply = LocalPlayer()
	if GAMEMODE:IsPhase(TIME_FIGHT) and ply:Alive() and ply:WaterLevel() >= 3 then
		local btns = mv:GetButtons()
		if btns != 0 then
			local wep = ply:GetActiveWeapon()
			local wepcl = ""
			if IsValid(wep) then
				wepcl = wep:GetClass()
			end

			if mv:KeyDown(IN_ATTACK) and not AllowLeftClick[wepcl] then
				btns = bit.band(btns, bit.bnot(IN_ATTACK))
			end
			if mv:KeyDown(IN_ATTACK2) and not AllowRightClick[wepcl] then
				btns = bit.band(btns, bit.bnot(IN_ATTACK2))
			end
			mv:SetButtons(btns)
		end
	end
end)
