SWEP.Base = "tfa_bash_base"
SWEP.Category = "Flood Weapons"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.VMPos = Vector(1, 3, -1)
SWEP.VMPos_Additive = false
SWEP.Slot = 3
SWEP.PrintName = "Super Shotgun"
SWEP.Manufacturer = "Union Aerospace Corporation"
SWEP.Type = "Shotgun"
SWEP.ViewModel = "models/weapons/tfa_doom/c_ssg.mdl" --Viewmodel path
SWEP.ViewModelFOV = 56
SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/tfa_doom/w_ssg.mdl" --Viewmodel path
SWEP.DefaultHoldType = "shotgun"
SWEP.HoldType = "shotgun"
SWEP.Scoped = false
SWEP.Shotgun = false
SWEP.Primary.AmmoConsumption = 1--2
--SWEP.Primary.ClipSize = -1
SWEP.DisableChambering = true
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Sound = Sound( "TFA_DOOM_SSG.2" )
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 600
SWEP.Primary.Damage = 8
SWEP.Primary.Damage_NPC = 70
SWEP.Primary.DamageTypeHandled = false --true will handle damagetype in base
SWEP.Primary.HullSize = 1
SWEP.Primary.DamageType = bit.bor(DMG_ALWAYSGIB, DMG_BULLET, DMG_AIRBOAT)
SWEP.Primary.NumShots = 1--16
SWEP.Primary.Spread = .08 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .05 -- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.KickUp = 1.25 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 1.0 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.8 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.4 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.Primary.Knockback = 200
SWEP.Primary.MaxPenetration = 2
SWEP.Primary.PenetrationMultiplier = 4
SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 2
SWEP.Primary.SpreadRecovery = 4

SWEP.FireModeName = "Break-Action"

SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-1.56 + 0.5 , 0, 1.159 - 0.5)
SWEP.IronSightsAng = Vector(0.6, 0.219, 0.127)

SWEP.CenteredPos = Vector(-1.55, -1, -1.04)
SWEP.CenteredAng = Vector(-1.5, 0.2, 0)

SWEP.RunSightsPos = Vector(0,0,0) + SWEP.VMPos
SWEP.RunSightsAng = Vector(-10,0,0) + ( SWEP.VMAng or vector_origin )
SWEP.DrawCrosshairIS = true
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA

SWEP.Idle_Mode = TFA.Enum.IDLE_LUA --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.SmokeParticle = ""
SWEP.MuzzleFlashEffect = "tfa_doomssg_muzzle"

SWEP.EventTable = {
	[ACT_VM_PRIMARYATTACK] = {
		--[[
		{
			["time"] = 0.2,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) then
					wep:SetNW2Bool("NeedsReload",true)
				end
			end
		},
		{
			["time"] = 0.3,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) and wep.Reload then
					wep:ChooseReloadAnim()
				end
			end
		}
		]]--
		{
			["time"] = 0.3,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) and wep.Reload and wep:Clip1() < 0.1 then
					wep:Reload( true )
				end
			end
		}
	},
	[ACT_VM_RELOAD] = {
		{
			["time"] = 15 / 60,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.EjectGear"
		},
		{
			["time"] = 17.5 / 60,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.ReloadOpen"
		},
		{
			["time"] = 20.5 / 60,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.EjectTube"
		},
		{
			["time"] = 21 / 60,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) and wep.EjectionSmoke then
					wep.EjectionSmokeEnabled = true
					wep:EjectionSmoke(true)
					wep.EjectionSmokeEnabled = false
				end
			end
		},
		{
			["time"] = 50 / 60,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.Insert"
		},--[[
		{
			["time"] = 51 / 60,
			["type"] = "lua",
			["value"] = function(wep)
				if IsValid(wep) then
					wep:SetNW2Bool("NeedsReload",false)
				end
			end
		},]]--
		{
			["time"] = 71 / 60 - 0.28,
			["type"] = "sound",
			["value"] = "TFA_DOOM_SSG.ReloadClose"
		}
	}
}

SWEP.AllowSprintAttack = true
SWEP.EjectionSmokeEnabled = false
SWEP.LuaShellEject = false --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 21 / 60 --The delay to actually eject things
SWEP.LuaShellEffect = "" --The effect used for shell ejection; Defaults to that used for blowback

-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1 ,1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.InspectPos = Vector(8.6, -5.5, -2.58)
SWEP.InspectAng = Vector(29, 44, 20)

SWEP.StatusLengthOverride = {}
SWEP.StatusLengthOverride[ACT_VM_RELOAD] = 50 / 60
SWEP.StatusLengthOverride[ACT_VM_HITCENTER] = 0.7

SWEP.SequenceLengthOverride = {}
SWEP.SequenceLengthOverride[ACT_VM_RELOAD] = 1.3
SWEP.SequenceLengthOverride[ACT_VM_HITCENTER] = 0.6
SWEP.SequenceLengthOverride[ACT_VM_DRAW] = 0.3

SWEP.SequenceRateOverrideScaled = {}
SWEP.SequenceRateOverrideScaled[ACT_VM_DRAW] = 1.5

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime = 0.2
SWEP.ProceduralHolsterPos = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng = Vector(-60, -50, 20)


SWEP.Double = false

DEFINE_BASECLASS(SWEP.Base)

function SWEP:Deploy( ... )
	self:CompleteReload()
	return BaseClass.Deploy(self,...)
end


function SWEP:PrimaryAttack( skip_parse, ... )
	if not self:GetStat("Double") then
		self.Primary.DefaultNumShots = self.Primary.NumShots
		self.Primary.DefaultAmmoConsumption = self.Primary.AmmoConsumption
		self.Primary.DefaultKickUp = self.Primary.KickUp
		self.Primary.DefaultKickDown = self.Primary.KickDown

		BaseClass.PrimaryAttack( self, true, ... )

		self.Primary.NumShots = self.Primary.DefaultNumShots
		self.Primary.AmmoConsumption = self.Primary.DefaultAmmoConsumption
		self.Primary.KickUp = self.Primary.DefaultKickUp
		self.Primary.KickDown = self.Primary.DefaultKickDown
	else
		return BaseClass.PrimaryAttack( self, true, ... )
	end
end
function SWEP:SecondaryAttack( ... )
	return false
end

function SWEP:ShootBullet(damage, recoil, num_bullets, aimcone)

	num_bullets = num_bullets or 1
	aimcone = aimcone or 0
	self:ShootEffects()
	TracerName = "Tracer"

	local punch = self.Owner:GetViewPunchAngles()
	local recoil = self.Weapon:GetNWFloat("RecoilTime")
	local bullet = {}

	bullet.Num = num_bullets
	bullet.Src = self.Owner:GetShootPos()                 -- Source
	bullet.Dir = self.Owner:GetAimVector() + punch:Forward() - Vector( 1, 0, 0) -- Dir of bullet
	bullet.Spread = Vector(aimcone, aimcone, 0) + Vector(0.01, 0.01, 0) * (math.Clamp( recoil - CurTime(), 0.0, self.Primary.Spread * 200 ) + self.Owner:GetVelocity():Length() / 250) --* (1 + self.Owner:GetVelocity():Length() / 360) -- Aim Cone
	bullet.Tracer = 2 	-- Show a tracer on every x bullets
	--[[
	if SERVER then
		bullet.Callback = function(attacker, tr, dmginfo)
			local ent = tr.Entity
			if IsValid(ent) then

				ent:DamageWeld(self.Owner)
			end
		end
	end ]]--
	bullet.TracerName = TracerName
	bullet.Force = 1
	bullet.Damage = damage

	self.Owner:FireBullets(bullet)
	if !(self.Primary.Spread == self.Primary.IronAccuracy) then
		local addrecoil = math.Clamp( self.Primary.KickDown + self.Primary.KickUp + self.Primary.KickHorizontal, 0, self.Primary.Spread * 25)
		if (!self.Owner:Crouching()) then
			self.Weapon:SetNWFloat("RecoilTime", math.Clamp( recoil + addrecoil, CurTime() + addrecoil, CurTime() + self.Primary.Spread * 200 ))
		else
			self.Weapon:SetNWFloat("RecoilTime", math.Clamp( recoil + 0.5, CurTime() + 0.5, CurTime() + self.Primary.Spread * 200 ))
		end
	end

	local anglo1 = Angle(math.Rand(-self.Primary.KickDown,-self.Primary.KickUp), math.Rand(-self.Primary.KickHorizontal,self.Primary.KickHorizontal), 0)
	if !self.Owner:IsNPC() then
		self.Owner:ViewPunch(anglo1)
	end
end

