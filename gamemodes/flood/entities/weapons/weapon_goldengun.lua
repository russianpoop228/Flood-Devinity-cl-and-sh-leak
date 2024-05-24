AddCSLuaFile()

include("weapon_cs_basefm.lua")

if CLIENT then
	SWEP.Slot             = 1
	SWEP.SlotPos          = 1
	SWEP.DrawAmmo         = true
	SWEP.DrawCrosshair    = false

	SWEP.WepSelectIcon    = Material( "vgui/entities/weapon_goldengun.png" )
end

SWEP.SWEPKitVElements = {
	["element_name"] = { type = "Model", model = "models/goldengun.mdl", bone = "Object03", rel = "", pos = Vector(16.1, -0.057, 0.5), angle = Angle(-1.065, -180, -90.282), size = Vector(1,1,1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/player/shared/gold_player", skin = 0, bodygroup = {} }
}
SWEP.SWEPKitWElements = {
	["element_name"] = { type = "Model", model = "models/goldengun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-12.855, 1.567, 0.054), angle = Angle(-3.962, 0, 173.091), size = Vector(0.935, 0.935, 0.935), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/player/shared/gold_player", skin = 0, bodygroup = {} }
}
SWEP.ViewModelBoneMods = {
	["R 09"] = { scale = Vector(1, 1, 1), pos = Vector(0.901, 0.603, -0.12), angle = Angle(0, 0, 0) },
	["Object03"] = { scale = Vector(0.128, 0.128, 0.128), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.PrintName        = "Golden Gun"
SWEP.Author         = "";
SWEP.Contact        = "";
SWEP.Purpose        = "";
SWEP.Instructions   = "";

SWEP.Base           = "weapon_swepbase"

SWEP.HoldType       = "pistol"
SWEP.ViewModelFOV   = 80
SWEP.ViewModelFlip  = true
SWEP.ViewModel      = "models/weapons/v_pist_xiveseven.mdl"
SWEP.WorldModel     = "models/weapons/w_pistol.mdl"

SWEP.ShowViewModel  = true
SWEP.ShowWorldModel = false

SWEP.IronSights    = true
SWEP.IronSightsPos = Vector(4, 5, 1.519)
SWEP.IronSightsAng = Vector(0, 1, 0.068)

SWEP.Primary.Sound       = Sound("weapons/goldengun/gg-shoot2.wav")
SWEP.Primary.Recoil      = .35
SWEP.Primary.Damage      = 99999
SWEP.Primary.NumShots    = 2
SWEP.Primary.Cone        = 0
SWEP.Primary.Delay       = .1

SWEP.Primary.ClipSize    = 1
SWEP.Primary.DefaultClip = 31
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "357"

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
	self.BaseClass.Initialize(self)
end

function SWEP:Holster()
	self.IronSights = false
	self.BaseClass.Holster(self)
	return true
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self.IronSights = false
	self.BaseClass.Deploy(self)
	return true
end

function SWEP:OnDrop()
	self.IronSights = false
	self.BaseClass.OnDrop(self)
	return true
end

function SWEP:Reload()
	if self:Clip1() > 0 then return end
	if self:Ammo1() <= 0 then return end

	self:DefaultReload( ACT_VM_RELOAD )
	self:EmitSound( "weapons/goldengun/reload2.wav" )

	self.IronSights = false

	self.Owner:SetAnimation(PLAYER_RELOAD)

	return true
end

if CLIENT then
	-- We need to mute the default viewmodel sounds
	local mute = {
		["weapons/fiveseven/fiveseven_clipout.wav"] = true,
		["weapons/fiveseven/fiveseven_clipin.wav"] = true,
		["weapons/fiveseven/fiveseven_slideback.wav"] = true,
		["weapons/fiveseven/fiveseven_sliderelease.wav"] = true,
	}
	hook.Add("EntityEmitSound", "GoldenGunMuteReload", function(t)
		if IsValid(t.Entity) and t.Entity:IsPlayer() then
			local wep = t.Entity:GetActiveWeapon()
			if IsValid(wep) then
				if wep:GetClass() == "weapon_goldengun" and mute[t.SoundName] then
					return false
				end
			end
		end
	end)
end

function SWEP:CalcDamage(target, dmginfo)
	if target:IsDestroyable() then
		return math.ceil(target:GetFMMaxHealth() / 4)
	end
end
