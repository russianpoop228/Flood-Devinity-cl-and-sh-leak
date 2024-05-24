ENT.Base      = "fm_special_base"
ENT.Type      = "anim"
ENT.Author    = "Donkie"
ENT.PrintName = "Ammo Pile"

ENT.IndividualCooldown = true
ENT.Cooldown = 50
ENT.ActiveTime = 0
ENT.FireProof = true
ENT.UnWeldProof = true
ENT.Model = "models/devinity/props/special_props/03_metal/ammunition_stockpile_01/ammunition_stockpile_01.mdl"
ENT.Health = 500
ENT.Cost = 500
ENT.Mass = 200
ENT.Description = "Refills magazines/ammunition of the weapon you are currently holding, amount varying by weapon type. Does not work for all weapons. Team members use this prop individually and have separate cooldowns."

local className = ENT.Folder:match("/(.+)")
GAMEMODE:RegisterSpecialProp(className, ENT)

if SERVER then
	local catNameToMagazines = {
		["explosives"] = 1,
		["handguns"] = 3,
		["heavy"] = 0,
		["melee"] = 0,
		["rifles"] = 1,
		["shotguns"] = 1,
		["snipers"] = 2,
		["submachine guns"] = 2,
	}
	local classMagazines = {
		["weapon_bow"] = 0.32,
		["fm_tfa_doom_ssg"] = 10,
		["weapon_molotov"] = 2,
		["weapon_harpoonfm"] = 4,
	}
	function ENT:CalculateAmmoAmount(class)
		local wepdata = GetWeaponData(class)
		if not wepdata then return 0 end

		if wepdata.tags["noammopile"] then return 0 end

		local catName = string.gsub(wepdata.cat, "(%d+% %-% )", ""):lower()
		local mags
		if classMagazines[class] then
			mags = classMagazines[class]
		elseif catNameToMagazines[catName] then
			mags = catNameToMagazines[catName]
		else
			mags = 0
		end

		if mags == 0 then return 0 end

		local ammo = math.Round(wepdata.wepdata.clipsize * mags)

		return ammo
	end
end

sound.Add({
	name = "FM.Special.Ammo.Main",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = {
		"items/ammo_pickup.wav"
	}
})