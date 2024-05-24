SWEP.TracerCount = 1
SWEP.TracerName = nil -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerDelay		= 0.0 --Delay for lua tracer effect

SWEP.Gun = ("tfa_mmod_smg")

SWEP.Category				= "Flood Weapons"
SWEP.Author				= ""
SWEP.MuzzleAttachment			= "muzzle"
SWEP.Instructions				= ""
SWEP.ShellEjectAttachment			= "1"
SWEP.PrintName				= "SMG\n(SUBMACHINE GUN)"
SWEP.Slot				= 2
SWEP.SlotPos				= 1
SWEP.ViewModelFOV			= 54
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.Weight				= 15
SWEP.AutoSwitchTo			= true
SWEP.AutoSwitchFrom			= true
SWEP.HoldType 				= "smg"
SWEP.IronSightHoldTypeOverride= "smg"  --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.ViewModelFlip			= false
SWEP.Spawnable				= true
SWEP.UseHands 				= true
SWEP.AdminSpawnable			= true
SWEP.ViewModel				= "models/weapons/tfa_mmod/c_smg1.mdl"
SWEP.WorldModel				= "models/weapons/tfa_mmod/w_smg1.mdl"
SWEP.Base					= "tfa_gun_base"
SWEP.FiresUnderwater = false
SWEP.Secondary.IronFOV			= 70
SWEP.data 				= {}

SWEP.RunSightsPos = Vector( -1.8618, -5.4595, -1.4228 )
SWEP.RunSightsAng = Vector( -3.7085, 16.2996, -7.7665 )
SWEP.AllowReloadWhileDraw = true
SWEP.AllowReloadWhileHolster = true
SWEP.AllowReloadWhileSprinting = true
SWEP.AllowReloadWhileNearWall = true
SWEP.Primary.NumShots	= 1
SWEP.Primary.Damage		= 25
SWEP.Primary.Sound			= Sound("TFA_MMOD.SMG1.1")
SWEP.Primary.RPM			= 1150
SWEP.Primary.ClipSize			= 45
SWEP.Primary.DefaultClip		= 90
SWEP.Primary.BaseKick			= 0.1
SWEP.Primary.KickUp				= 0.3
SWEP.Primary.MaxKick 			= 0.3
SWEP.Primary.KickDown			= 0.1
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.Automatic			= true
SWEP.DisableChambering = true
SWEP.Primary.Ammo			= "smg1"


--[[
SWEP.Secondary.Ammo			= "SMG1_Grenade"
SWEP.Secondary.Sound		= Sound( "Weapon_SMG1.Double" )
SWEP.Secondary.Act = ACT_VM_SECONDARYATTACK
SWEP.Secondary.Delay = 1
SWEP.Secondary.Ent = "grenade_ar2"
SWEP.Secondary.Velocity = 1500
SWEP.Secondary.Ammo = "smg1_grenade"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 4
SWEP.Secondary.Delay = 1.05
]]--
SWEP.Primary.StaticRecoilFactor = 0.5
SWEP.Primary.Spread		= .02
SWEP.Primary.SpreadIncrement = 0.2 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second. Example val: 3


SWEP.Primary.IronAccuracy = .01
SWEP.IronRecoilMultiplier = 0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.

SWEP.SelectiveFire		= false
SWEP.data.ironsights			= 1
SWEP.IronSightsPos = Vector( -4.7, -2, 2 )
SWEP.IronSightsAng = Vector( -0.65, 0, 0 )
SWEP.AllowSprintAttack = true
SWEP.IronSightsPos_LEG = Vector(-1.3, 0, 1.32)
SWEP.IronSightsAng_LEG = Vector(0.6,0,0)
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "ShellEject" --The effect used for shell ejection; Defaults to that used for blowback

SWEP.MagModel = Model("models/weapons/tfa_mmod/w_smg1_magazine.mdl")

DEFINE_BASECLASS( "tfa_gun_base" )

local reloadfix = 1
local canglf = 1
local clik = 1
local up = 0

function SWEP:Think(...)

	local nsfac = self:GetNW2Int("FireCount") + 1

	if self:GetStatus() == TFA.GetStatus("idle") then
		if not self.LastIdleTime then
			self.LastIdleTime = CurTime()
		elseif CurTime() > self.LastIdleTime + 0.1 then
			self:SetNW2Int("FireCount",0)
		end
	else
		self.LastIdleTime = nil
	end

	return BaseClass.Think(self,...)
end


function SWEP:Deploy( ... )

    if SERVER then
        self:CallOnClient("Deploy")
    else
--[[
		local keyname = input.LookupBinding("+zoom")

		if keyname then
			if self.Owner:HasWeapon("fm_grenadelauncher") and self.Owner:Alive() then -- we need self.Owner:Alive() so it doesn't get printed again if the player dies
				keyname = string.upper(keyname) -- capitalize keyname to make it look better

				self.Owner:Hint("You have some grenades left in your grenade pistol.", "lightbulb")
				self.Owner:Hint("You can use the '"..keyname.."' key (suitzoom) to swap to it.", "information")
			else
			-- We don't have to put anything here if the player has no ammo left
			end

		else -- if they do not have keyname binded
				self.Owner:Hint("You have some grenades left in your launcher.", "lightbulb")
				self.Owner:Hint("Press the 5 key (slot default) or bind suitzoom to swap to it.", "information")
		end
				self.SetNW2Int = self.SetNW2Int or self.SetNWInt
				self.GetNW2Int = self.GetNW2Int or self.GetNWInt
				self.SetNW2Bool = self.SetNW2Bool or self.SetNWBool
				self.GetNW2Bool = self.GetNW2Bool or self.GetNWBool
				self:SetNW2Int("FireCount",0)
				local b = self:GetNW2Bool("AltGL")
					if b == nil then
						self:SetNW2Bool("AltGL", false )
					end
				return BaseClass.Deploy(self)
	end
]]--
	end

	self.Owner:Hint("You have some grenades left in your grenade pistol.", "lightbulb")
	self.Owner:Hint("Press the '5' key to swap to it.", "information")

end


--[[
function SWEP:Think2()
	if not self.Primary.RPM_Default then
		self.Primary.RPM_Default = self.Primary.RPM
	end
	if self:GetNW2Bool("AltGL") or self:GetOwner():KeyDown(IN_USE) then
		if self.data.ironsights == 1 and SERVER then
			--self.Owner:Hint("Toggled Grenade Launcher.", "information")
			self:ClearStatCache()
		end

		self.data.ironsights = 0
		self.data.ironsights_default = 0
		self.data.gl = 1
	else
		if self.data.ironsights == 0 and SERVER then
			--self.Owner:Hint("Toggled ironsights.", "information")
			self:ClearStatCache()
		end
		self.data.ironsights = 1
		self.data.ironsights_default = 1
		self.data.gl = 0
	end


	if self:GetStatus() == TFA.GetStatus("idle") then
		if not self.LastIdleTime then
			self.LastIdleTime = CurTime()
		elseif CurTime() > self.LastIdleTime + 0.1 then
			self:SetNW2Int("FireCount",0)
		end
	else
		self.LastIdleTime = nil
	end
	return BaseClass.Think2(self)
end
]]--
function SWEP:AltAttack()
	if SERVER and self.Owner:HasWeapon("fm_grenadelauncher") then
		if self.Owner:KeyPressed(IN_ZOOM) then
			self.Owner:SelectWeapon( "fm_grenadelauncher" )
		end
	end
end

local scrcol = Color( 50, 255, 170 )
local a = 32

function SWEP:DrawHUD(...)
	--draw.RoundedBox(0,0,0,ScrW(),ScrH(),ColorAlpha(scrcol, ( self.IronSightsProgress or 0 ) * a ) )
	return BaseClass.DrawHUD(self, ...)
end

--code_gs
SWEP.Zoom = {
	Cooldown = 0,
	FOV = {70},
	Times = {
		Reload = 0.1,
		Holster = 0.1,
		[0] = 0.1,
		0.1
	},
	FadeColor = Color(0, 0, 0, 0),
	FadeTime = 0.2
}


--endof code_gs
--[[
SWEP.Secondary.Act = ACT_VM_SECONDARYATTACK
SWEP.Secondary.Delay = 1
SWEP.Secondary.Ent = "grenade_ar2"
SWEP.Secondary.Velocity = 1500
SWEP.Secondary.Ammo = "smg1_grenade"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 4
SWEP.Secondary.Delay = 1.05
SWEP.Secondary.Sound = Sound("Weapon_SMG1.Double")

function SWEP:SecondaryAttack()
	if self.data.gl ~= 1 and not (self:GetOwner():KeyDown(IN_USE)) then return end
	if CurTime() >  self:GetNextSecondaryFire() and self:Ammo2() > 0 and TFA.Enum.ReadyStatus[ self:GetStatus() ] and not self:GetSprinting() then
		if SERVER then
			local ent = ents.Create( self.Secondary.Ent )
			ent:SetOwner( self.Owner )
			ent:SetPos( self.Owner:GetShootPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:SetVelocity( self.Owner:GetAimVector() * self.Secondary.Velocity )
			ent:Spawn()
			ent:Activate()
		end
		self:SendViewModelAnim( self.Secondary.Act )
		self:SetNextSecondaryFire( CurTime()  + self.Secondary.Delay )
		self.Owner:SetAmmo( self.Owner:GetAmmoCount( self.Secondary.Ammo ) - 1, self.Secondary.Ammo )
		self:EmitSound( self.Secondary.Sound )
	end
end
]]--
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Sprint", --Number for act, String/Number for sequence
		["is_idle"] = true
	}
}

SWEP.WalkAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Walk", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
}


SWEP.Attachments = {
	[1] = { offset = { 0, 0 }, atts = { "mmod_si_legacy" }, order = 1 },
}

SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Walk_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

-- devinity floodweapons viewmodel fix
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(0.1, 0.1, 0.1), pos = Vector(0, 0, 0), angle = Angle(20, 180, 0) }
}

--[[
hook.Add("EntityTakeDamage", "FMMP5Grenade", function(ent, dmginfo)
	local inf = dmginfo:GetInflictor()
	if IsValid(inf) and inf:GetClass() == "grenade_ar2" then
		dmginfo:SetDamage(10)
		dmginfo:SetDamagePosition(ent:GetPos())
	end
end)

]]--

