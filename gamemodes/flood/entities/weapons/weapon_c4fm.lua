--CONTAINS SOME BASIC CODE FOR C4 AND GHOST
if true then return end

AddCSLuaFile()

SWEP.Base                  = "weapon_fmbase"

SWEP.PrintName             = "C4"
SWEP.Author                = "Donkie"
SWEP.Slot                  = 4
SWEP.SlotPos               = 1
SWEP.WepSelectIcon         = Material( "vgui/entities/weapon_c4fm.png" )

SWEP.HoldType              = "slam"

SWEP.Spawnable             = false
SWEP.AdminSpawnable        = false

SWEP.ViewModel             = "models/weapons/tfa_nmrih/v_exp_tnt.mdl"
SWEP.WorldModel            = "models/weapons/tfa_nmrih/w_exp_tnt.mdl"

SWEP.UseHands              = true

SWEP.Weight                = 5
SWEP.AutoSwitchTo          = false
SWEP.AutoSwitchFrom        = false

SWEP.Primary.ClipSize      = 100
SWEP.Primary.DefaultClip   = 100
SWEP.Primary.Automatic     = false
SWEP.Primary.Ammo          = "Grenade"

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "none"

if CLIENT then
	function SWEP:DeleteGhost()
		if IsValid(self.ghostmdl) then self.ghostmdl:Remove() end
	end

	function SWEP:OnRemove()
		self:DeleteGhost()
	end

	function SWEP:Holster()
		self:DeleteGhost()
	end
end

function SWEP:PositionC4(pos, norm)
	return pos, Angle(0,0,0)
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Think()
	if CLIENT then
		if not IsValid(self.ghostmdl) then
			self.ghostmdl = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)
			self.ghostmdl:SetNoDraw(true)
			self.ghostmdl:SetColor(Color(255, 255, 255, 0.5))
		end
	end

	if self.animstart then
		local diff = (CurTime() - self.animstart)
		if self.animstep == 0 and diff >= 2.5 then
			self:SendWeaponAnim( ACT_VM_THROW )

			self.animstep = 1
		elseif self.animstep == 1 and diff >= 3 then
			self:Throw()

			self:SendWeaponAnim( ACT_VM_HOLSTER )
			self:DestroyParticles()

			self.animstep = 2
		elseif self.animstep == 2 and diff >= 5 then
			self:SendWeaponAnim( ACT_VM_DRAW )

			self.animstep = nil
		end
	end

	self:NextThink(CurTime() + 0.1)
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 6)
	--if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then return end

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	self.animstart = CurTime()
	self.animstep = 0
	self:SendWeaponAnim( ACT_VM_PULLPIN )

	return true
end

hook.Add("PostDrawTranslucentRenderables", "DrawC4Ghost", function()
	if not IsValid(LocalPlayer()) or not IsValid(LocalPlayer():GetActiveWeapon()) then return end

	local wep = LocalPlayer():GetActiveWeapon()
	if wep:GetClass() != "weapon_c4fm" then return end
	if not IsValid(wep.ghostmdl) then return end

	local tr = LocalPlayer():GetEyeTrace()
	if not tr.Hit then return end

	local pos,ang = wep:PositionC4(tr.HitPos, tr.HitNormal)

	wep.ghostmdl:SetPos(pos)
	wep.ghostmdl:SetRenderOrigin(pos)
	wep.ghostmdl:SetRenderAngles(ang)
	wep.ghostmdl:DrawModel()
end)
