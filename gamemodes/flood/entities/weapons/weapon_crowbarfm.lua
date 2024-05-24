
AddCSLuaFile()

SWEP.Base = "weapon_fmbase"

if CLIENT then
	SWEP.DrawAmmo        = false
	SWEP.DrawCrosshair   = false
	SWEP.ViewModelFOV    = 50
	SWEP.ViewModelFlip   = false
	SWEP.WepSelectIcon   = Material( "vgui/entities/weapon_crowbar.png" )
end

SWEP.HoldType  = "melee"
SWEP.PrintName = "Crowbar"

SWEP.ViewModel             = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel            = "models/weapons/w_crowbar.mdl"

SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip   = -1
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "none"

SWEP.Damage                = 12 -- Player -> Prop damage
SWEP.PvPDamage             = 3 -- Player -> Player damage
SWEP.CanHurtPlayers        = true

SWEP.Primary.Damage        = 25
SWEP.Primary.Delay         = 0.4
SWEP.Primary.Sound         = Sound("Weapon_Crowbar.Single")
SWEP.Primary.HitSound      = Sound("Weapon_Crowbar.Melee_Hit")

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = true
SWEP.Secondary.Ammo        = "none"

hook.Add("PlayerCanPickupWeapon", "Crowbar", function(ply, wep)
	if wep:GetClass() == "weapon_crowbarfm" and ply:HasWeapon("weapon_crowbarfm") then
		return false
	end
end)

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	return true
end

function SWEP:FirePunch()
	local ang = Angle(0,0,0)

	ang.p = ang.p + self:Rand("crowbarpax", 1, 2)
	ang.y = ang.y + self:Rand("crowbarpay", -2, -1)
	ang.r = 0

	self.Owner:ViewPunch(ang)
end

function SWEP:DealDamage(ent)
	if not IsValid(self.Owner) then return end
	if not ent:IsDestroyable() and not ent:IsPlayer() then return end

	local dmginfo = DamageInfo()
		dmginfo:SetAttacker(self.Owner)
		dmginfo:SetDamageType(DMG_CLUB)
		dmginfo:SetDamageForce(self.Owner:GetAimVector() * 200)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(self.Primary.Damage)

	ent:TakeDamageInfo(dmginfo)
end

function SWEP:PrimaryAttack()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	self:FirePunch()

	if SERVER then
		self:LogWeaponFire()
	end

	local missextra = 0

	self.Owner:LagCompensation(true)
	local trace = util.TraceLine({
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
		filter = self.Owner
	})
	self.Owner:LagCompensation(false)

	if not IsValid(trace.Entity) then
		self.Owner:LagCompensation(true)
		trace = util.TraceHull({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
			filter = self.Owner,
			mins = Vector(-16,-16,-16),
			maxs = Vector(16,16,16)
		})
		self.Owner:LagCompensation(false)
	end

	if IsValid(trace.Entity) or trace.HitWorld then
		self:SendWeaponAnim(ACT_VM_HITCENTER)

		self:EmitSound(self.Primary.HitSound)

		if IsValid(trace.Entity) then
			if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
				if SERVER then
					trace.Entity:EmitSound("Flesh.Break",75,math.random(70,90))
				end

				local effectdata = EffectData()
					effectdata:SetOrigin(trace.HitPos)
					effectdata:SetEntity(trace.Entity)
				util.Effect( "BloodImpact", effectdata )
			else
				local phys = trace.Entity:GetPhysicsObject()
				if phys:IsValid() and not trace.Entity:IsNPC() and phys:IsMoveable() then
					local vel = self.Primary.Damage * 300 * self.Owner:GetAimVector()
					phys:ApplyForceOffset(vel, (trace.Entity:NearestPoint(self.Owner:GetShootPos()) + trace.Entity:GetPos() * 2) / 3)
				end
			end

			if SERVER then
				self:DealDamage(trace.Entity)
			end
		end

		if trace.HitWorld and (not CLIENT or IsFirstTimePredicted()) then
			local decaltrace = self.Owner:GetEyeTrace()

			if self.Owner:GetShootPos():Distance(decaltrace.HitPos) <= 105 then
				util.Decal("Impact.Concrete",decaltrace.HitPos + decaltrace.HitNormal, decaltrace.HitPos - decaltrace.HitNormal)
			end
		end
	else
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
		missextra = 0.2

		if SERVER then
			timer.Simple(0,function()
				if not IsValid(self) then return end
				self:EmitSound(self.Primary.Sound,75,60)
			end)
		end
	end

	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay + missextra)
end

function SWEP:SecondaryAttack()
	if CurrentEvent() == "pirate" then return end -- disable secondary during pirate

	self:SetNextPrimaryFire(CurTime() + 0.3)
	self:SetNextSecondaryFire(CurTime() + 5)
	self:EmitSound("Weapon_Crowbar.Single")
	self:SendWeaponAnim(ACT_VM_MISSCENTER)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if SERVER then
		timer.Simple(0.1, function()
			if not IsValid(self) then return end
			self:Throw()
		end)
	end

	return true
end

function SWEP:Throw()
	local ent = ents.Create("fm_crowbar")
		ent:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector() * 16))
		ent:SetAngles(self.Owner:EyeAngles())
		ent.Owner = self.Owner
		ent:Spawn()

	local phys = ent:GetPhysicsObject()
	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 5500
	velocity = velocity + (VectorRand() * 20) -- a random element

	phys:ApplyForceCenter(velocity)
	phys:AddAngleVelocity(VectorRand() * 1000)

	self.Owner:StripWeapon("weapon_crowbarfm")
end

if SERVER then
	hook.Add("FMOnChangePhase", "Crowbar", function(old, new)
		if new == TIME_REFLECT then
			for _, v in pairs(ents.FindByClass("weapon_crowbarfm")) do
				v:Remove()
			end

			for _, v in pairs(ents.FindByClass("fm_crowbar")) do
				v:Remove()
			end
		end
	end)
end
