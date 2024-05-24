AddCSLuaFile()



SWEP.Base                  = "weapon_fmbase"



SWEP.PrintName             = "Bugbait"

SWEP.Author                = "Valve, Donkie"

SWEP.WepSelectIcon         = Material( "vgui/entities/weapon_bugbaitfm.png" )



SWEP.HoldType              = "grenade"



SWEP.Spawnable             = false

SWEP.AdminSpawnable        = false

SWEP.UseHands              = true



SWEP.ViewModel             = "models/weapons/c_bugbait.mdl"

SWEP.WorldModel            = "models/weapons/w_bugbait.mdl"



SWEP.Weight                = 5

SWEP.AutoSwitchTo          = false

SWEP.AutoSwitchFrom        = false



SWEP.Primary.Automatic     = false



SWEP.Secondary.ClipSize    = -1

SWEP.Secondary.DefaultClip = -1

SWEP.Secondary.Automatic   = false

SWEP.Secondary.Ammo        = "none"



function SWEP:Initialize()

	self:SetHoldType(self.HoldType)



	if CLIENT then

		self.worldmodel = ClientsideModel( "models/weapons/w_bugbait.mdl", RENDERGROUP_OPAQUE )

		self.worldmodel:SetNoDraw(true)

		self.worldmodel:SetModelScale(0.85,0)

	end

end



function SWEP:SpawnGrenade()

	local ent = ents.Create("fm_bugbait")

		ent:Spawn()

		ent.owner = self.Owner



	return ent

end



function SWEP:Throw()

	local ent = self:SpawnGrenade()

	if not IsValid(ent) then return end



	self:LogWeaponFire()



	local eye = self.Owner:GetAimVector()

	local eyeang = self.Owner:EyeAngles()



	local spawnpos = self.Owner:EyePos() + eye * 18 + eyeang:Right() * 12

	local spawnvel = self.Owner:GetVelocity() + eye * 1000



	ent:SetPos(spawnpos)



	if ent:GetPhysicsObject():IsValid() then

		ent:GetPhysicsObject():SetVelocity(spawnvel)

		ent:GetPhysicsObject():AddAngleVelocity(VectorRand() * 3000)

	end



	self:TakePrimaryAmmo(1)

end



function SWEP:PrimaryAttack()

	self:SetNextPrimaryFire(CurTime() + 2)

	if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then return end



	self:SendWeaponAnim( ACT_VM_HAULBACK )

	timer.Simple(0.1, function()

		if not IsValid(self) or not IsValid(self.Owner) then return end



		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		self:SendWeaponAnim( ACT_VM_THROW )

		if SERVER then

			self:Throw()

		else

			self.hide = true

		end



		timer.Simple(1.8, function()

			if not IsValid(self) or not IsValid(self.Owner) then return end

			if CLIENT then self.hide = false end

			self:SendWeaponAnim( ACT_VM_IDLE )

		end)

	end)



	return true

end



function SWEP:SecondaryAttack() end



function SWEP:DrawWorldModel()

	if self.hide then return end



	local bonei = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")

	if not bonei or bonei == 0 then

		return

	end



	local pos,ang = self.Owner:GetBonePosition(bonei)

	self.worldmodel:SetRenderOrigin(pos + ang:Forward() * 3 + ang:Right() * 3)

	self.worldmodel:SetRenderAngles(ang)

	self.worldmodel:DrawModel()

end

SWEP.DrawWorldModelTranslucent = SWEP.DrawWorldModel

