-- devinity floodweapons worldmodel fix
SWEP.WElements = {
	["devinity_worldmodel_fix"] = { type = "Model", model = "models/weapons/tfa_kf2/w_eviscerator.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-8.193, 0.685, -2.263), angle = Angle(-12.822, 0, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Base = "tfa_gun_base"
SWEP.Category = "Flood Weapons"
SWEP.PrintName = "Eviscerator"
SWEP.ViewModel = "models/weapons/tfa_kf2/c_eviscerator.mdl"
SWEP.ViewModelFOV = 80
SWEP.VMPos = Vector(0, 0, 0)
SWEP.UseHands = true
SWEP.CameraOffset = Angle(0, 0, 0)
--SWEP.InspectPos = Vector(17.184, -4.891, -11.902) - SWEP.VMPos
--SWEP.InspectAng = Vector(70, 46.431, 70)
SWEP.WorldModel = "models/weapons/tfa_kf2/w_eviscerator.mdl"
SWEP.ShowWorldModel = false
SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 5,
		Forward = -8
	},
	Ang = {
		Up = 9,
		Right = -10,
		Forward = 180
	},
	Scale = 0.9
}
SWEP.HoldType = "shotgun"
SWEP.DefaultHoldType = SWEP.HoldType
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.AllowSprintAttack = false
SWEP.IsMelee = true

--Movespeed
SWEP.MoveSpeed 						= 0.65 											-- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed 			= SWEP.MoveSpeed 						-- Multiply the player's movespeed by this when sighting.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID-- ANI = mdl, Hybrid = ani + lua, Lua = lua only
SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}

SWEP.ViewModelBoneMods = {
	["FrontSaw"] = {
		scale = Vector(1, 1, 1),
		pos = Vector(0, 0, 0),
		angle = Angle(0,0,0)
	},
	["BevelGear3"] = {
		scale = Vector(1, 1, 1),
		pos = Vector(0, 0, 0),
		angle = Angle(0,0,0)
	}
}

SWEP.InspectionActions = {ACT_VM_RECOIL1, ACT_VM_RECOIL2, ACT_VM_RECOIL3}

SWEP.ProjectileEntity = "eviscerator_blade"
SWEP.ProjectileVelocity = 5000
SWEP.ProjectileModel = "models/weapons/tfa_kf2/w_eviscerator_blade.mdl"

SWEP.MuzzleFlashEnabled = false

SWEP.Primary.Sound = "TFA_KF2_EVISCERATOR.1"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 60
SWEP.Primary.Damage = 200
SWEP.Primary.NumShots = 1
SWEP.Primary.Spread		= .015					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .005	-- Ironsight accuracy, should be the same for shotguns
SWEP.SelectiveFire = false

SWEP.Secondary.Sound = ""
SWEP.Secondary.Automatic = true
SWEP.Secondary.RPM = 1500
SWEP.Secondary.Damage = 120--DPS
SWEP.Secondary.NumShots = 1
SWEP.Secondary.Spread		= .015					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Secondary.IronAccuracy = .005	-- Ironsight accuracy, should be the same for shotguns
SWEP.Secondary.Reach = 30 * 4.5
SWEP.Secondary.ClipSize = 200
SWEP.Secondary.Ammo = EVISCERATOR_GAS_TYPE or "gas"
SWEP.Secondary.DefaultClip = 200

SWEP.Primary.ClipSize = 5
SWEP.Primary.Ammo = EVISCERATOR_AMMO_TYPE or "eviscerator_blades"
SWEP.Primary.DefaultClip = 12

SWEP.data = {}
SWEP.data.ironsights = 0

SWEP.SawAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "atk_f_in", --Number for act, String/Number for sequence
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "atk_f_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "atk_f_out", --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}

SWEP.Saw_Sound_Idle = "TFA_KF2_EVISCERATOR.Idle"
SWEP.Saw_Sound_Saw = "TFA_KF2_EVISCERATOR.Saw"
SWEP.Saw_Sound_In = "TFA_KF2_EVISCERATOR.StartSaw"
SWEP.Saw_Sound_Out = "TFA_KF2_EVISCERATOR.EndSaw"

SWEP.SawHoldType = "ar2"

SWEP.Saw_Sound_Idle_Next = -1
SWEP.Saw_Sound_Saw_Next = -1

SWEP.Saw_Sound_BlendTime = 0.05

SWEP.Saw_Drain_Idle = 0
SWEP.Saw_Drain_Sawing = 100 / 10--Ammo per second

SWEP.EventTable = {
	[ACT_VM_DRAW] = {
		{ ["time"] = 0.01, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.StartIdle" }
	},
	[ACT_VM_PRIMARYATTACK] = {
		{ ["time"] = 115 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.SawSlide" }
	},
	[ACT_VM_RECOIL1] = {
		{ ["time"] = 60 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" },
		{ ["time"] = 256 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Smack" },
		{ ["time"] = 386 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" }
	},
	[ACT_VM_RECOIL2] = {
		{ ["time"] = 36 / 30, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.MagOut" }
	},
	[ACT_VM_RECOIL3] = {
		{ ["time"] = 74 / 30, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" },
		{ ["time"] = 86 / 30, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" },
		{ ["time"] = 90 / 30, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" }
	},
	[ACT_VM_RELOAD] = {
		{ ["time"] = 1 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.EndIdle" },
		{ ["time"] = 100 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.MagOut" },
		{ ["time"] = 222 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" },
		{ ["time"] = 512 / 240 - 0.1, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.MagIn" },
		{ ["time"] = 860 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" },
		{ ["time"] = 1000 / 240 - 0.525, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.StartIdle" }
	},
	[ACT_VM_RELOAD_EMPTY] = {
		--{ ["time"] = 1 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.EndIdle" },
		{ ["time"] = 100 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.MagOut" },
		{ ["time"] = 222 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" },
		{ ["time"] = 512 / 240 - 0.1, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.MagIn" },
		{ ["time"] = 860 / 240, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Foley1" },
		{ ["time"] = 1000 / 240 - 0.525, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.StartIdle" }
	},
	[ACT_VM_HOLSTER] = {
		{ ["time"] = 25 / 60, ["type"] = "sound", ["value"] = "TFA_KF2_EVISCERATOR.Holster" }
	}
}


SWEP.CanBlock = true
SWEP.BlockAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "brace_in", --Number for act, String/Number for sequence
		["transition"] = true
	}, --Inward transition
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "brace_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},--looping animation
	["hit"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_RELOAD_DEPLOYED, --Number for act, String/Number for sequence
		["is_idle"] = true
	},--when you get hit and block it
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "brace_out", --Number for act, String/Number for sequence
		["transition"] = true
	} --Outward transition
}
SWEP.BlockCone = 135 --Think of the player's view direction as being the middle of a sector, with the sector's angle being this
SWEP.BlockDamageMaximum = 0.0 --Multiply damage by this for a maximumly effective block
SWEP.BlockDamageMinimum = 0.3 --Multiply damage by this for a minimumly effective block
SWEP.BlockTimeWindow = 0.3 --Time to absorb maximum damage
SWEP.BlockTimeFade = 0.3 --Time for blocking to do minimum damage.  Does not include block window
SWEP.BlockSound = "TFA_KF2_ZWEIHANDER.Block"
SWEP.BlockDamageCap = 100
SWEP.BlockDamageTypes = {
	DMG_SLASH,DMG_CLUB
}
SWEP.BlockHoldType = "ar2"
SWEP.BlockFadeOutEnd = 0.1

SWEP.Secondary.CanBash = true
SWEP.Secondary.BashDamage = 130
SWEP.Secondary.BashDelay = 0.1
SWEP.Secondary.BashLength = 16 * 5.5
SWEP.Secondary.BashSound = Sound("TFA_KF2_EVISCERATOR.StartSaw")

SWEP.SequenceLengthOverride = {
	[ACT_VM_DRAW] = 0.5,
	[ACT_VM_RELOAD] = 1000 / 240,
	[ACT_VM_RELOAD_EMPTY] = 1000 / 240,
	[ACT_VM_UNDEPLOY] = 0.2,
	[ACT_VM_DEPLOY] = 0.3,
	[ACT_VM_HITCENTER] = 40 / 60
}

DEFINE_BASECLASS( SWEP.Base )

local stat,_,tanim

function SWEP:Initialize( ... )
	self.StatCache_Blacklist[ "Secondary.BashSound"] = true
	self.StatCache_Blacklist[ "Secondary.BashDamage"] = true
	return BaseClass.Initialize( self, ... )
end

function SWEP:Deploy( ... )
	self.FSaw_Velocity = 0
	if IsFirstTimePredicted() then
		self.Saw_Sound_Idle_Next = -1
		self.Saw_Sound_Saw_Next = -1
	end
	return BaseClass.Deploy( self, ... )
end

function SWEP:Holster( ... )
	return BaseClass.Holster(self, ... )
end

function SWEP:Think2( ... )
	self:SawThink()
	--self:BlockThink()
	BaseClass.Think2( self, ... )
end

function SWEP:SecondaryAttack( ... )
end
--[[
function SWEP:AltAttack()
	if self.CanBlock then
		if self.Secondary.CanBash and self.CanBlock and self.Owner:KeyDown(IN_USE) then
			BaseClass.AltAttack( self )
			return
		end
	else
		if not self:VMIV() then return end
		if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end
		if not self.Secondary.CanBash then return end
		if self:IsSafety() then return end

		return BaseClass.AltAttack(self)
	end
end

function SWEP:BlockThink()
	if self.CanBlock then
		stat = self:GetStatus()
		if self.Owner:KeyDown(IN_ZOOM) and TFA.Enum.ReadyStatus[stat] and not self.Owner:KeyDown(IN_USE) then
			self:SetStatus( TFA.GetStatus("blocking") )
			if self.BlockAnimation["in"] then
				self:PlayAnimation( self.BlockAnimation["in"] )
			elseif self.BlockAnimation["loop"] then
				self:PlayAnimation( self.BlockAnimation["loop"] )
			end
			self:SetStatusEnd( math.huge )
			self.BlockStart = CurTime()
		elseif stat == TFA.GetStatus("blocking") and not self.Owner:KeyDown(IN_ZOOM) then
			self:SetStatus( TFA.GetStatus("blocking_end") )
			if self.BlockAnimation["out"] then
				_,tanim = self:PlayAnimation( self.BlockAnimation["out"] )
			else
				_,tanim = self:ChooseIdleAnim()
			end
			self:SetStatusEnd( CurTime() + ( self.BlockFadeOut or ( self:GetActivityLength( tanim ) - self.BlockFadeOutEnd ) ) )
		elseif stat == TFA.GetStatus("blocking") and CurTime() > self:GetNextIdleAnim() then
			self:ChooseIdleAnim()
		end
	end
end

function SWEP:GetBlockStart()
	return self.BlockStart or -1
end

function SWEP:ChooseBlockAnimation()
	if self.BlockAnimation["hit"] then
		self:PlayAnimation( self.BlockAnimation["hit"] )
	elseif self.BlockAnimation["in"] then
		self:PlayAnimation( self.BlockAnimation["in"] )
	end
end
]]--
function SWEP:SawThink()
	stat = self:GetStatus()
	if self:Clip2() > 0 and self.Owner:KeyDown(IN_ATTACK2) and TFA.Enum.ReadyStatus[stat] and not self:GetSprinting() then
		if self.SawAnimation["in"] then
			_,tanim = self:PlayAnimation( self.SawAnimation["in"] )
		else
			_,tanim = self:PlayAnimation( self.SawAnimation["loop"] )
		end
		self:SetStatus( TFA.GetStatus("sawing") )
		self:SetStatusEnd( math.huge )
		if self:CanSoundPredict() then
			self:EmitSound(self.Saw_Sound_In)
			self.Saw_Sound_Saw_Next = SysTime() + 0.1
		end
	elseif stat == TFA.GetStatus("sawing") and ( ( not self.Owner:KeyDown(IN_ATTACK2) ) or self:Clip2() <= 0 or self:GetSprinting() ) then
		self:SetStatus( TFA.GetStatus("sawing_end") )
		if self.SawAnimation["out"] then
			_,tanim = self:PlayAnimation( self.SawAnimation["out"] )
		else
			_,tanim = self:ChooseIdleAnim()
		end
		self:SetStatusEnd( CurTime() + self:GetActivityLength( tanim ) )
		if self:CanSoundPredict() then
			self:EmitSound(self.Saw_Sound_Out)
			self.Saw_Sound_Idle_Next = SysTime() + 0.1
		end
	elseif stat == TFA.GetStatus("sawing") and CurTime() > self:GetNextIdleAnim() then
		self:ChooseIdleAnim()
	end
	if self:Clip2() > 0 then
		self.Secondary.BashSound = Sound("TFA_KF2_EVISCERATOR.StartSaw")
		self.Secondary.BashDamage = 130
	else
		self.Secondary.BashSound = Sound("TFA.Bash")
		self.Secondary.BashDamage = 80
	end
	self:SawMechanics()
	self:SawSounds()
	self:AnimateSaw()
end

SWEP.AmmoDrainDelta = 0

function SWEP:SawMechanics()
	stat = self:GetStatus()
--[[	if SERVER then
		self.AmmoDrainDelta = self.AmmoDrainDelta + ( ( stat == TFA.GetStatus("sawing") ) and self.Saw_Drain_Sawing or self.Saw_Drain_Idle ) * TFA.FrameTime()
		while self.AmmoDrainDelta >= 1 do
			self.AmmoDrainDelta = self.AmmoDrainDelta - 1
			self:TakeSecondaryAmmo(1)
		end
	end]]--
	if self:GetStatus() == TFA.GetStatus("sawing") and CurTime() > self:GetNextSecondaryFire() and ( IsFirstTimePredicted() and not ( game.SinglePlayer() and CLIENT ) ) then
		local ft = 60 / self.Secondary.RPM
		if IsFirstTimePredicted() then
			self:Saw( 4, 4, self.Secondary.Reach ) -- secondary fire dmg i think
		end
		self:SetNextSecondaryFire( CurTime() + ft )
		self:TakeSecondaryAmmo(1)
	end
end

SWEP.FSaw_Velocity = 0
SWEP.FSaw_Accel = 720
SWEP.FSaw_Decel = 360
SWEP.FSaw_IdleSpeed = 180
SWEP.FSaw_SawingSpeed = 720
SWEP.FSaw_Friction = 90

function SWEP:AnimateSaw()
	if self:Clip2() > 0 then
		if self:GetStatus() == TFA.GetStatus("sawing") or self:GetStatus() == TFA.GetStatus("bashing") then
			self.FSaw_Velocity = math.min( self.FSaw_Velocity + self.FSaw_Accel * TFA.FrameTime(), self.FSaw_SawingSpeed )
		else
			if self.FSaw_Velocity > self.FSaw_IdleSpeed then
				self.FSaw_Velocity = math.max( self.FSaw_Velocity - self.FSaw_Decel * TFA.FrameTime() , self.FSaw_IdleSpeed )
			else
				self.FSaw_Velocity = math.min( self.FSaw_Velocity + self.FSaw_Accel * TFA.FrameTime(), self.FSaw_IdleSpeed )
			end
		end
	else
		self.FSaw_Velocity = math.max( self.FSaw_Velocity - self.FSaw_Friction * TFA.FrameTime() , 0 )
	end
	self.ViewModelBoneMods["FrontSaw"].angle.p = math.NormalizeAngle(  self.ViewModelBoneMods["FrontSaw"].angle.p + self.FSaw_Velocity * TFA.FrameTime() )
	self.ViewModelBoneMods["BevelGear3"].angle.p = math.NormalizeAngle( self.ViewModelBoneMods["BevelGear3"].angle.p + self.FSaw_Velocity * TFA.FrameTime() )
end

function SWEP:ProcessHoldType( ... )
	if self:GetStatus() == TFA.GetStatus("blocking") then
		self:SetHoldType( self.BlockHoldType or "magic")
	elseif self:GetStatus() == TFA.GetStatus("sawing") then
		self:SetHoldType( self.SawHoldType or "ar2" )
		return self.SawHoldType or "ar2"
	else
		return BaseClass.ProcessHoldType(self,...)
	end
end

function SWEP:ChooseIdleAnim( ... )
	if self.CanBlock and self:GetStatus() == TFA.GetStatus("blocking") and self.BlockAnimation["loop"] then
		return self:PlayAnimation( self.BlockAnimation["loop"] )
	elseif self:GetStatus() == TFA.GetStatus("sawing") and self.SawAnimation["loop"] then
		return self:PlayAnimation( self.SawAnimation["loop"] )
	else
		return BaseClass.ChooseIdleAnim(self, ...)
	end
end

function SWEP:SawSounds()
	stat = self:GetStatus()
	if stat == TFA.GetStatus("holster") or stat == TFA.GetStatus("holster_final") or stat == TFA.GetStatus("holster_ready") then
		self:MuteSounds( true )
		return
	end
	if self:Clip2() <= 0 then
		self:MuteSounds( true )
		return
	end
	if not self:CanSoundPredict() then return end
	if self:GetStatus() == TFA.GetStatus("sawing") then
		if SysTime() > self.Saw_Sound_Saw_Next then
			self.Saw_Sound_Saw_Next = SysTime() + SoundDuration( self.Saw_Sound_Saw ) / self:GetTimeScale() - self.Saw_Sound_BlendTime
			self:EmitSound( self.Saw_Sound_Saw )
		end
		if self.Saw_Sound_Idle_Next ~= -1 then
			self:StopSound( self.Saw_Sound_Idle )
			self.Saw_Sound_Idle_Next = -1
		end
	elseif self:Clip1() >= 0 and stat ~= TFA.GetStatus("reloading") then
		if SysTime() > self.Saw_Sound_Idle_Next then
			self.Saw_Sound_Idle_Next = SysTime() + SoundDuration( self.Saw_Sound_Idle ) / self:GetTimeScale() - self.Saw_Sound_BlendTime
			self:EmitSound( self.Saw_Sound_Idle )
		end
		if self.Saw_Sound_Saw_Next ~= -1 then
			self:StopSound( self.Saw_Sound_Saw )
			self.Saw_Sound_Saw_Next = -1
		end
	end
end

function SWEP:MuteSounds( offsnd )
	if self.Saw_Sound_Saw_Next ~= -1 then
		self:StopSound( self.Saw_Sound_Saw )
		self.Saw_Sound_Saw_Next = -1
		if offsnd then
			self:EmitSound("TFA_KF2_EVISCERATOR.EndSaw")
		end
	end
	if self.Saw_Sound_Idle_Next ~= -1 then
		self:StopSound( self.Saw_Sound_Idle )
		self.Saw_Sound_Idle_Next = -1
		if offsnd then
			self:EmitSound("TFA_KF2_EVISCERATOR.EndIdle")
		end
	end
end

function SWEP:CanSoundPredict()
	if game.SinglePlayer() then
		if CLIENT then return false end
	else
		if not IsFirstTimePredicted() then return false end
	end
	return true
end

function SWEP:PrimaryAttack( ... )
	local ret = BaseClass.PrimaryAttack( self, ... )
	if self:GetStatus() == TFA.GetStatus("shooting") then
		self:SetStatusEnd( CurTime() + 0.3 )
	end
	return ret
end

local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")
local ct

function SWEP:Reload(released)
	if not self:VMIV() then return end
	if self:Ammo1() <= 0 then return end
	if self.Primary.ClipSize < 0 then return end
	if ( not released ) and ( not self:GetLegacyReloads() ) then return end
	if self:GetLegacyReloads() and not  dryfire_cvar:GetBool() and not self.Owner:KeyDown(IN_RELOAD) then return end

	ct = CurTime()
	stat = self:GetStatus()

	if TFA.Enum.ReadyStatus[stat] or ( stat == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting() ) then
		if self:Clip1() < self.Primary.ClipSize then
			if nzombies and self.Owner.HasPerk and self.Owner:HasPerk("speed") then
				self.SequenceRateOverrideScaled[ACT_VM_RELOAD] = 2
				self.SequenceRateOverrideScaled[ACT_VM_RELOAD_EMPTY] = 2
				self.SequenceRateOverrideScaled[ACT_VM_RELOAD_SILENCED] = 2
			end
			success, tanim = self:ChooseReloadAnim()
			self:SetStatus(TFA.Enum.STATUS_RELOADING)
			if self:GetStat("ProceduralReloadEnabled") then
				self:SetStatusEnd(ct + self:GetStat("ProceduralReloadTime"))
			else
				self:SetStatusEnd(ct + self:GetActivityLength( tanim ))
			end
			if ( not game.SinglePlayer() ) or ( not self:IsFirstPerson() ) then
				self.Owner:SetAnimation(PLAYER_RELOAD)
			end
			self:MuteSounds()
		elseif released or self.Owner:KeyPressed(IN_RELOAD) then--if self.Owner:KeyPressed(IN_RELOAD) or not self:GetLegacyReloads() then
			self:CheckAmmo()
		end
	end
end

function SWEP:CompleteReload()
	local maxclip = self.Primary.ClipSize
	local curclip = self:Clip1()
	local amounttoreplace = math.min(maxclip - curclip, self:Ammo1())
	self.Owner:SetAmmo( self:Ammo1() - amounttoreplace, self:GetPrimaryAmmoType() )
	self:SetClip1( curclip + amounttoreplace )
end

function SWEP:ChooseReloadAnim()
	if not self:VMIV() then return false, 0 end
	if self.ProceduralReloadEnabled then return false, 0 end

	if self:GetActivityEnabled( ACT_VM_RELOAD_EMPTY ) and (self:Clip2() == 0) then
		typev, tanim = self:ChooseAnimation( "reload_empty" )
	else
		typev, tanim = self:ChooseAnimation( "reload" )
	end

	local fac = 1
	if self.Shotgun and self.ShellTime then
		fac = self.ShellTime
	end

	self.AnimCycle = 0

	if typev ~= TFA.Enum.ANIMATION_SEQ then
		return self:SendViewModelAnim(tanim, fac, fac ~= 1)
	else
		return self:SendViewModelSeq(tanim, fac, fac ~= 1)
	end
end

local hull = {}

function SWEP:Saw( damage, force, reach )
	if not self:OwnerIsValid() then return end
	pos = self.Owner:GetShootPos()
	ang = self.Owner:GetAimVector()

	self.Owner:LagCompensation(true)

	hull.start = pos
	hull.endpos = pos + (ang * reach)
	hull.filter = self.Owner
	hull.mins = Vector(-5, -5, 0)
	hull.maxs = Vector(5, 5, 5)
	local slashtrace = util.TraceHull(hull)

	self.Owner:LagCompensation(false)

	if slashtrace.Hit then
		if game.GetTimeScale() > 0.99 then
			self.Owner:FireBullets({
				Attacker = self.Owner,
				Inflictor = self,
				Damage = damage,
				Force = force,
				Distance = reach + 10,
				HullSize = 12.5,
				Tracer = 0,
				Src = self.Owner:GetShootPos(),
				Dir = slashtrace.Normal,
				Callback = function(a, b, c)
					c:SetDamageType( bit.bor( DMG_SLASH,DMG_ALWAYSGIB) )
				end
			})
		else
			if not IsValid( slashtrace.Entity ) then return end
			local dmg = DamageInfo()
			dmg:SetAttacker(self.Owner)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(self.Owner:GetShootPos())
			dmg:SetDamageForce(self.Owner:GetAimVector() * (damage * 0.25))
			dmg:SetDamage(damage)
			dmg:SetDamageType( bit.bor( DMG_SLASH,DMG_ALWAYSGIB) )
			if slashtrace.Entity.TakeDamageInfo then
				slashtrace.Entity:TakeDamageInfo(dmg)
			end
		end
	end
end

local sv_cheats_cv = GetConVar("sv_cheats")
local host_timescale_cv = GetConVar("host_timescale")
local ts
function SWEP:GetTimeScale()
	ts = game.GetTimeScale()
	if sv_cheats_cv:GetBool() then
		ts = ts * host_timescale_cv:GetFloat()
	end
	return ts
end

--[[

EntityTakeDamage could only really be used if it does regular damage to the player (punting props at players, explosive damage)

Flood gamemode doesn't use any physics damage
PhysicsCollide and TakeDamageInfo for prop-related damage (such as the blade or arrow)

The MP5's grenade launcher works because the explosive deals AoE damage in singleplayer
Original code of eviscerator doesn't call for prop dmg on Flood (attacker, inflictor, victim)


]]--

--[[
hook.Add("EntityTakeDamage", "FMEviseratorBlade", function(ent, dmginfo) 
	local inf = dmginfo:GetInflictor()
	PrintTable(inf:GetTable())
	if IsValid(inf) and inf:GetClass() == "eviscerator_blade" then
		dmginfo:SetDamage( 20 )
		dmginfo:SetDamagePosition(ent:GetPos())
	end
	
end)

print ("is this weapon working?")

]]--
