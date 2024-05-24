
AddCSLuaFile()

SWEP.Base                   = "weapon_fmbase"

-- Variables that are used on both client and server
SWEP.Category               = "EXP"
SWEP.Author                 = "Mighty Lolrus and various people I stole from"
SWEP.Contact                = ""
SWEP.Purpose                = ""
SWEP.Instructions           = ""
SWEP.MuzzleAttachment       = "1"
SWEP.ShellEjectAttachment   = "2"
SWEP.DrawCrosshair          = false
SWEP.ViewModelFOV           = 65
SWEP.ViewModelFlip          = true

SWEP.Spawnable              = false
SWEP.AdminSpawnable         = false


SWEP.Primary.Sound          = Sound("")
SWEP.Primary.Round          = ("")
SWEP.Primary.Cone           = 0.2
SWEP.Primary.RPM            = 0
SWEP.Primary.Damage         = 0
SWEP.Primary.ClipSize       = 0
SWEP.Primary.DefaultClip    = 0
SWEP.Primary.KickUp         = 0
SWEP.Primary.KickDown       = 0
SWEP.Primary.KickHorizontal = 0
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo           = "none"

SWEP.Secondary.ClipSize     = 0
SWEP.Secondary.DefaultClip  = 0
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.Secondary.IronFOV      = 0

SWEP.WallSights             = false

SWEP.Single                 = nil
SWEP.IronSightsPos          = Vector (2.4537, 1.0923, 0.2696)
SWEP.IronSightsAng          = Vector (0.0186, -0.0547, 0)

SWEP.WallSightsPos          = Vector (0.2442, -11.6177, -3.9856)
SWEP.WallSightsAng          = Vector (59.2164, 1.6346, -1.8014)


function SWEP:Initialize()

	util.PrecacheSound(self.Primary.Sound)
	self.Reloadaftershoot = 0
	if !self.Owner:IsNPC() then
		self:SetHoldType("rpg")
	end
	if SERVER and self.Owner:IsNPC() then
		self:SetHoldType("rpg")
		self:SetNPCMinBurst(3)
		self:SetNPCMaxBurst(10)
		self:SetNPCFireRate(1)
		self:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_VERY_GOOD )
	end
end

function SWEP:Deploy()

	if game.SinglePlayer() then
		self.Single=true
	else
		self.Single=false
	end

	self:SetHoldType("fist")
	self:SetIronsights(false)
	self:SendWeaponAnim( ACT_VM_DRAW )
	self.Owner:EmitSound("weapons/bow/draw.wav")
	self.Owner:ViewPunch(Angle(-3, 2, 2))
	return true
end


function SWEP:Precache()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheSound("Buttons.snd14")
end

function SWEP:FireRocket()
	if self:GetIronsights() and self.Owner:KeyDown(IN_ATTACK2) then
		aim = self.Owner:GetAimVector()
	else
		aim = self.Owner:GetAimVector() + Vector(math.Rand(-0.02,0.02), math.Rand(-0.02,0.02),math.Rand(-0.02,0.02))
	end

	if SERVER then
		self:LogWeaponFire()

		local rocket = ents.Create(self.Primary.Round)
		if !rocket:IsValid() then return false end
		rocket:SetAngles(aim:Angle() + Angle(90,0,0))
		rocket:SetPos(self.Owner:GetShootPos())
		rocket:SetOwner(self.Owner)
		rocket:Spawn()
		rocket.Damage = self.Primary.Damage
		rocket.owner = self.Owner
		rocket:Activate()

		if !self.Owner:IsNPC() then
			local anglo = Angle(math.Rand(-self.Primary.KickDown,self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
			self.Owner:ViewPunch(anglo)
			angle = self.Owner:EyeAngles() - anglo
			self.Owner:SetEyeAngles(angle)
		end
	end
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	if (SERVER) then end

	self:DefaultReload(ACT_VM_RELOAD)

	if !self.Owner:IsNPC() then
		self.Idle = CurTime() + self.Owner:GetViewModel():SequenceDuration()
	end

	if ( self:Clip1() < self.Primary.ClipSize ) and !self.Owner:IsNPC() then

		self.Owner:SetFOV( 0, 0.3 )
		self:SetIronsights(false)

	end
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Ironsights")
end


function SWEP:IronSight()
	if (SERVER) then end

	if self.Owner:KeyPressed(IN_ATTACK2) then

		self.Owner:EmitSound("weapons/bow/ironin.wav")

		self:SetHoldType("ar2")                          	-- Hold type styles; ar2 ar2 shotgun rpg normal melee grenade smg slam fist melee2 passive knife
		self.Owner:SetFOV( self.Secondary.IronFOV, 0.3 )
		self.IronSightsPos = self.SightsPos				-- Bring it up
		self.IronSightsAng = self.SightsAng				-- Bring it up

		self:SetIronsights(true)

	elseif self.Owner:KeyReleased(IN_ATTACK2) then

		self.Owner:EmitSound("weapons/bow/ironout.wav")

		self:SetHoldType("rpg")
		self.Owner:SetFOV( 0, 0.3 )

		self:SetIronsights(false)
	end


	if self.Owner:KeyDown(IN_ATTACK2) then
		self.SwayScale 	= 0.03
		self.BobScale 	= 0.03
	else
		self.SwayScale 	= 0.0
		self.BobScale 	= 0.7
	end

	if self.Owner:KeyPressed(IN_JUMP) then

		self.Owner:SetFOV( 0, 0.3 )
		self:SetIronsights(false)
		self:SendWeaponAnim( ACT_VM_DRAW )
		self.Owner:GetViewModel():SetPlaybackRate( 2 )

	end
end

function SWEP:Think()
	self:IronSight()

	if self.Idle and CurTime() >= self.Idle then
		self.Idle = nil
		self:SendWeaponAnim(ACT_VM_IDLE)
	end
end


local IRONSIGHT_TIME = 0.2
function SWEP:GetViewModelPosition(pos, ang)

	if (not self.IronSightsPos) then return pos, ang end

	local bIron = self:GetIronsights()

	if (bIron != self.bLastIron) then
		self.bLastIron = bIron
		self.fIronTime = CurTime()
	end

	local fIronTime = self.fIronTime or 0

	if (not bIron and fIronTime < CurTime() - IRONSIGHT_TIME) then
		return pos, ang
	end

	local Mul = 1.0

	if (fIronTime > CurTime() - IRONSIGHT_TIME) then
		Mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

		if not bIron then Mul = 1 - Mul end
	end

	local Offset	= self.IronSightsPos

	if (self.IronSightsAng) then
		ang = ang * 1
		ang:RotateAroundAxis(ang:Right(), 		self.IronSightsAng.x * Mul)
		ang:RotateAroundAxis(ang:Up(), 		self.IronSightsAng.y * Mul)
		ang:RotateAroundAxis(ang:Forward(), 	self.IronSightsAng.z * Mul)
	end

	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
end
