
SWEP.Base = "weapon_fmbase"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"

util.PrecacheModel("models/props_junk/PopCan01a.mdl")
util.PrecacheModel("models/props_c17/canister01a.mdl")

function SWEP:Initialize()
	self.Delay = 0
	self.Status = 0
	self.ThirdPerson = false

	self:SetWeaponHoldType("slam")

	if CLIENT then
		self.FadeCount = 0
		self.Load = 0
		killicon.Add("fm_predator","HUD/killicons/asm_missile",Color(255,0,0,255))
		language.Add("fm_predator","Air-to-surface Missile")
		--hook.Add("HUDPaint","ASMSwepDrawHUD", function() self:DrawInactiveHUD() end)
	end
end

function SWEP:Deploy()
	if SERVER then
		self:SendWeaponAnim(ACT_VM_DRAW)
	end
	return true
end

function SWEP:Holster()
	if self.Status > 0 then return false end
	return true
end

function SWEP:ShouldDropOnDie() return false end
