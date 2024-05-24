
AddCSLuaFile()

if CLIENT then
	SWEP.Author           = "LordiAnders"
	SWEP.Slot             = 2
	SWEP.SlotPos          = 5
	SWEP.WepSelectIcon = Material( "vgui/entities/weapon_sledgehammer.png" )
	SWEP.BounceWeaponIcon = false

	killicon.Add("weapon_sledgehammer","vgui/entities/weapon_sledgehammer",Color(255,255,255,255))
	killicon.Add("ent_sledgehammer","vgui/entities/weapon_sledgehammer",Color(255,255,255,255))
end

SWEP.HoldType  = "passive"
SWEP.Base      = "weapon_swepbase"
SWEP.PrintName = "Sledgehammer"

SWEP.ViewModelFOV          = 70
SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/lordi/c_sledgehammer.mdl"
SWEP.WorldModel            = "models/weapons/w_crowbar.mdl"

SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip   = -1
SWEP.Primary.Ammo          = "none"
SWEP.Primary.Automatic     = true

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo        = "none"
SWEP.Secondary.Automatic   = true

SWEP.ShowViewModel         = true
SWEP.ShowWorldModel        = false

SWEP.Damage                = 40 -- Player -> Prop damage
SWEP.PvPDamage             = 15 -- Player -> Player damage
SWEP.CanHurtPlayers        = true

SWEP.AboutToSwing          = false
SWEP.IsSwinging            = false

SWEP.AboutToSwing2         = false
SWEP.IsSwinging2           = false

SWEP.SWEPKitWElements = {
	["sledge"] = { type = "Model", model = "models/weapons/lordi/c_sledgehammer.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-16.33, -3.294, -16.605), angle = Angle(8.395, 0, -115.988), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

hook.Add("PlayerCanPickupWeapon", "Sledgehammer", function(ply, wep)
	if wep:GetClass() == "weapon_sledgehammer" and ply:HasWeapon("weapon_sledgehammer") then
		return false
	end
end)


function SWEP:VerifyAndSet(bone,data)
	if not IsValid(self.Owner) then return end

	bone = self.Owner:LookupBone(bone)
	if bone then
		self.Owner:ManipulateBoneAngles(bone,data)
	end
end

function SWEP:SetPassiveHoldType()
	if not IsValid(self.Owner) then return end
	if CLIENT then return end

	self:SetHoldType("passive")

	self:VerifyAndSet("ValveBiped.Bip01_R_UpperArm",Angle(13.894,12.334,14.597))
	self:VerifyAndSet("ValveBiped.Bip01_R_Hand",Angle(17,30,9))
	self:VerifyAndSet("ValveBiped.Bip01_L_Forearm",Angle(-16.224,-24.887,7.893))
	self:VerifyAndSet("ValveBiped.Bip01_L_UpperArm",Angle(-32.017,-35.637,16))
	self:VerifyAndSet("ValveBiped.Bip01_L_Hand",Angle(0.171,0,0))
end

function SWEP:SetMelee2HoldType()
	if not IsValid(self.Owner) then return end
	if CLIENT then return end

	self:SetHoldType("melee2")

	self:VerifyAndSet("ValveBiped.Bip01_R_UpperArm",Angle(0,0,0))
	self:VerifyAndSet("ValveBiped.Bip01_R_Hand",Angle(0,0,0))
	self:VerifyAndSet("ValveBiped.Bip01_L_Forearm",Angle(0,0,0))
	self:VerifyAndSet("ValveBiped.Bip01_L_UpperArm",Angle(0,0,0))
	self:VerifyAndSet("ValveBiped.Bip01_L_Hand",Angle(0,0,0))
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetDeploySpeed(self.Owner:GetViewModel():SequenceDuration())
	self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )

	self.AboutToSwing = true --Just to disable holstering

	self:SetPassiveHoldType()

	if SERVER then
		timer.Simple(0.9,function()
			if not IsValid(self) then return end
			if not IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self then return end

			self:EmitSound("npc/combine_soldier/gear6.wav")
			self.Owner:ViewPunch( Angle(-2,0,1) )
		end)

		timer.Simple(2,function()
			if not IsValid(self) then return end
			if not IsValid(self.Owner) or self.Owner:GetActiveWeapon() != self then return end

			self.Owner:ViewPunch( Angle(5,0,-5) )
			self:EmitSound("physics/flesh/flesh_impact_hard2.wav",75,180)
			self.AboutToSwing = false
		end)
	end
end

function SWEP:Think()
	if self.IsSwinging and not self.Owner:KeyDown(IN_ATTACK) then
		self:PrimaryAttack()
	elseif self.IsSwinging2 and not self.Owner:KeyDown(IN_ATTACK2) then
		self:SecondaryAttack()
	end
end

function SWEP:DealDamage(ent)
	if not IsValid(self.Owner) then return end

	local dmginfo = DamageInfo()
		dmginfo:SetAttacker(self.Owner)
		dmginfo:SetDamageType(DMG_CLUB)
		dmginfo:SetDamageForce(self.Owner:GetAimVector() * 400)
		dmginfo:SetInflictor(self)
		if ent:IsDestroyable() then
			dmginfo:SetDamage(self.Damage)
		elseif ent:IsPlayer() then
			dmginfo:SetDamage(self.PvPDamage)
		else
			return
		end

	ent:TakeDamageInfo(dmginfo)
end

function SWEP:PrimaryAttack()
	if self.IsSwinging2 or self.AboutToSwing2 then return end

	if not self.IsSwinging then
		self.AboutToSwing = true
		self:SetMelee2HoldType()
		self:SetNextPrimaryFire( CurTime() + 5000 )
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		timer.Simple(self.Owner:GetViewModel():SequenceDuration(), function()
			if not IsValid(self) then return end
			self.AboutToSwing = false
			self.IsSwinging = true
		end)
	end

	if self.IsSwinging then
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		timer.Simple(0.25,function()
			if not IsValid(self) then return end
			self:SetPassiveHoldType()
		end)

		if SERVER then
			self:LogWeaponFire()
		end

		self.Owner:LagCompensation(true)
		local trace = util.TraceLine({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 105,
			filter = self.Owner
		})
		self.Owner:LagCompensation(false)

		if not IsValid(trace.Entity) then
			self.Owner:LagCompensation(true)
			trace = util.TraceHull({
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 105,
				filter = self.Owner,
				mins = Vector( -10, -10, -8 ),
				maxs = Vector( 10, 10, 8 )
			})
			self.Owner:LagCompensation(false)
		end

		if trace.Entity:IsValid() or trace.HitWorld then
			self:SendWeaponAnim(ACT_VM_HITKILL)
			self.Owner:ViewPunch( Angle(-10,0,0) )

			timer.Simple(0.1,function()
				if not IsValid(self) or not IsValid(self.Owner) then return end
				self.Owner:ViewPunch( Angle(15,0,0) )
			end)

			if IsValid(trace.Entity) then
				if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then
					if SERVER then
						trace.Entity:EmitSound("physics/body/body_medium_break" .. math.random(2,4) .. ".wav",75,math.random(70,90))
					end

					local effectdata = EffectData()
						effectdata:SetOrigin(trace.HitPos)
						effectdata:SetEntity(trace.Entity)
					util.Effect( "BloodImpact", effectdata )
				else
					local phys = trace.Entity:GetPhysicsObject()
					if phys:IsValid() and not trace.Entity:IsNPC() and phys:IsMoveable() then
						local vel = 1 * 30000 * self.Owner:GetAimVector()
						phys:ApplyForceOffset(vel, (trace.Entity:NearestPoint(self.Owner:GetShootPos()) + trace.Entity:GetPos() * 2) / 3)
					end
				end

				if SERVER then
					self:DealDamage(trace.Entity)
				end
			end

			if trace.HitWorld then
				local decaltrace = self.Owner:GetEyeTrace()

				if self.Owner:GetShootPos():Distance(decaltrace.HitPos) <= 105 then
					util.Decal("Impact.Sand",decaltrace.HitPos + decaltrace.HitNormal, decaltrace.HitPos - decaltrace.HitNormal)
				end
			end

			if SERVER then
				timer.Simple(0,function()
					if not IsValid(self) then return end
					self:EmitSound("physics/metal/metal_canister_impact_hard" .. math.random(1,3) .. ".wav",75,math.random(90,110))
				end)
			end
		else
			self:SendWeaponAnim(ACT_VM_MISSCENTER)

			if SERVER then
				timer.Simple(0,function()
					if not IsValid(self) then return end
					self:EmitSound("npc/zombie/claw_miss1.wav",75,60)
				end)
			end

			self.Owner:ViewPunch( Angle(-10,0,0) )

			timer.Simple(0.1,function()
				if not IsValid(self) or not IsValid(self.Owner) then return end
				self.Owner:ViewPunch( Angle(30,0,0) )
			end)
		end

		self.IsSwinging = false
		self:SetNextPrimaryFire( CurTime() + 1 )
		self:SetNextSecondaryFire( CurTime() + 1 )
	end
end

function SWEP:GetViewModelPosition(pos, ang)
	if self.IsSwinging then
		pos = pos + (math.random(-1,1) / 40) * ang:Right()
		pos = pos + (math.random(-1,1) / 40) * ang:Forward()
		pos = pos + (math.random(-1,1) / 40) * ang:Up()
	end

	return pos, ang
end

function SWEP:SecondaryAttack()
	if self.IsSwinging or self.AboutToSwing then return end

	if not self.IsSwinging2 then
		self.AboutToSwing2 = true
		self:SetMelee2HoldType()
		self:SetNextSecondaryFire( CurTime() + 5000 )
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		timer.Simple(self.Owner:GetViewModel():SequenceDuration(),function()
			if not IsValid(self) then return end
			self.AboutToSwing2 = false
			self.IsSwinging2 = true
		end)
	end

	if self.IsSwinging2 then
		self.IsSwinging2 = false
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
		self.Owner:SetAnimation(PLAYER_ATTACK1)

		if SERVER then
			timer.Simple(0.1,function()
				if not IsValid(self) or not IsValid(self.Owner) then return end

				local trdata = {
					start = self.Owner:GetShootPos() - self.Owner:GetAimVector() * 10,
					endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 25,
					filter = self.Owner
				}
				local trres = util.TraceLine(trdata)

				local spawnpos
				if trres.Hit then
					spawnpos = trres.HitPos - self.Owner:GetAimVector() * 20
				else
					spawnpos = trdata.endpos
				end

				local sledge = ents.Create("ent_sledgehammer")
					sledge:SetPos(spawnpos)
					sledge:SetAngles(self.Owner:GetAngles())
					sledge.Owner = self.Owner
					sledge:Spawn()
					sledge:Activate()

					sledge:GetPhysicsObject():ApplyForceCenter( self.Owner:GetAimVector() * 7000 )

				timer.Simple(0.25,function()
					if not IsValid(self) or not IsValid(self.Owner) then return end
					self.Owner:StripWeapon(self:GetClass())
				end)
			end)
		end
	end
end

function SWEP:Reload()
end

function SWEP:ResetModifications()
	if not IsValid(self.Owner) then return end

	self:VerifyAndSet("ValveBiped.Bip01_R_UpperArm",Angle(0,0,0))
	self:VerifyAndSet("ValveBiped.Bip01_R_Hand",Angle(0,0,0))
	self:VerifyAndSet("ValveBiped.Bip01_L_Forearm",Angle(0,0,0))
	self:VerifyAndSet("ValveBiped.Bip01_L_UpperArm",Angle(0,0,0))
	self:VerifyAndSet("ValveBiped.Bip01_L_Hand",Angle(0,0,0))

	local vm = self.Owner:GetViewModel()
	if IsValid(vm) then
		vm:SetMaterial("")

		if CLIENT then
			self:ResetBonePositions(vm)
		end
	end
end

function SWEP:OnRemove()
	self:ResetModifications()
end

function SWEP:Holster()
	if /*self.AboutToSwing or*/ self.IsSwinging or self.IsSwinging2 or self.AboutToSwing2 then
		return false
	end

	self:ResetModifications()

	return true
end

if SERVER then
	hook.Add("FMOnChangePhase", "Sledgehammer", function(old, new)
		if new == TIME_REFLECT then
			for _, v in pairs(ents.FindByClass("weapon_sledgehammer")) do
				v:Remove()
			end

			for _, v in pairs(ents.FindByClass("ent_sledgehammer")) do
				v:Remove()
			end
		end
	end)
end
