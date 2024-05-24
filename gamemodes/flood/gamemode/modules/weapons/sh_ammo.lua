
GM.AmmoReservations = GM.AmmoReservations or {}
GM.AmmoBuffer = GM.AmmoBuffer

local function GenerateAmmoBuffer()
	if GM.AmmoBuffer then return end

	GM.AmmoBuffer = {}

	for i = 1,64 do
		local name = string.format("cammo_%i", i)

		game.AddAmmoType({
			name      = name,
			dmgtype   =	DMG_BULLET,
			tracer    =	TRACER_LINE_AND_WHIZ,
			plydmg    =	20,
			npcdmg    =	20,
			force     =	100,
			minsplash =	5,
			maxsplash =	10
		})

		table.insert(GM.AmmoBuffer, name)
	end
end
GenerateAmmoBuffer()

if SERVER then
	local classtoammo = {
		["weapon_357"]      = "357",
		["weapon_pistol"]   = "pistol",
		["weapon_shotgun"]  = "Buckshot",
		["weapon_rpg"]      = "rpg_round",
		["weapon_ar2"]      = "ar2",
		["weapon_frag"]     = "grenade",
		["weapon_crossbow"] = "XbowBolt",
		["weapon_smg1"]     = "SMG1"
	}

	function GM:ReserveAmmoName(class)
		if classtoammo[class] then return classtoammo[class] end
		if self.AmmoReservations[class] then return self.AmmoReservations[class] end

		if #self.AmmoBuffer == 0 then
			error("No ammo left to reserve!")
		end

		local ammo = table.remove(self.AmmoBuffer)
		self.AmmoReservations[class] = ammo
		return ammo
	end
end
