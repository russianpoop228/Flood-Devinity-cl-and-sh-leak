SWEP.Base				= "tfa_gun_base"SWEP.PrintName				= "'Cataclysm' Rocket Launcher"SWEP.Category				= "Devinity"if CLIENT then	--SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/fm_stick")	SWEP.DrawAmmo = true		-- Should draw the default HL2 ammo counter if enabled in the GUI.	SWEP.DrawWeaponInfoBox = false		-- Should draw the weapon info box	SWEP.BounceWeaponIcon = falseendSWEP.Slot = 4SWEP.SlotPos = 0SWEP.Spawnable = trueSWEP.DrawCrosshair = trueSWEP.DrawCrosshairIS = trueSWEP.HoldType = "rpg"SWEP.ViewModelFOV = 56SWEP.UseHands = trueSWEP.ViewModel = "models/weapons/c_rpg.mdl"SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"SWEP.VMPos = Vector(0,2,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.        Pos = {        Up = 0,        Right = 10,        Forward = 0,        },        Ang = {        Up = 0,        Right = -10,        Forward = 180        },		Scale = 1}SWEP.ShowViewModel = trueSWEP.ShowWorldModel = false--[[TFA Base Weapon Info]]--SWEP.Manufacturer = "Lime (https://devinity.org/members/10836/)" --Gun Manufactrer (e.g. Hoeckler and Koch )SWEP.Author							= "counter (https://devinity.org/members/929/)"SWEP.Type = "Arc-based Explosive"SWEP.FireModeName = "Rocket" --Change to a text value to override it--[[TFA Base Weapon Handling]]----Firing relatedSWEP.Primary.Sound = Sound("npc/env_headcrabcanister/launch.wav")				-- This is the sound of the weapon, when you shoot.SWEP.Primary.Damage = 250 -- Damage, in standard damage points.SWEP.Primary.HullSize = 0.6 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.SWEP.DamageType = nil --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.SWEP.Primary.NumShots	= 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.SWEP.Primary.Automatic = false -- Automatic/Semi AutoSWEP.Primary.RPM = 35 -- This is in Rounds Per Minute / RPMSWEP.FiresUnderwater = false--Ammo RelatedSWEP.Primary.ClipSize			= 1					-- This is the size of a clipSWEP.Primary.DefaultClip			= 5					-- This is the number of bullets the gun gives you, counting a clip as defined directly above.SWEP.Primary.Ammo			= "RPG_Round"					-- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets--Recoil RelatedSWEP.Primary.KickUp			= 5					-- This is the maximum upwards recoil (rise)SWEP.Primary.KickDown			= 4.6					-- This is the maximum downwards recoil (skeet)SWEP.Primary.KickHorizontal			= 3.6					-- This is the maximum sideways recoil (no real term)SWEP.Primary.StaticRecoilFactor = 0.5 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.--Firing Cone RelatedSWEP.Primary.Spread		= .01					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)SWEP.Primary.IronAccuracy = .0001	-- Ironsight accuracy, should be the same for shotguns--Range RelatedSWEP.Primary.Range = 370*52.46 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm. 1m = 52.46 source unitsSWEP.Primary.RangeFalloff = 0.38 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.--MiscSWEP.IronRecoilMultiplier=0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.SWEP.CrouchRecoilMultiplier=0.65  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.SWEP.JumpRecoilMultiplier=1.3  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.SWEP.WallRecoilMultiplier=1.1  --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.SWEP.ChangeStateRecoilMultiplier=1.3  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.SWEP.CrouchAccuracyMultiplier=0.5--Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurateSWEP.ChangeStateAccuracyMultiplier=1.5 --Less is more.  A change of state is when we're in the progress of doing something, like crouching or ironsighting.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurateSWEP.JumpAccuracyMultiplier=2--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurateSWEP.WalkAccuracyMultiplier=1.35--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurateSWEP.IronSightTime = 0.3 --The time to enter ironsights/exit it.SWEP.NearWallTime = 0.25 --The time to pull up  your weapon or put it back downSWEP.ToCrouchTime = 0.05 --The time it takes to enter crouching stateSWEP.WeaponLength = 40 --Almost 3 feet Feet.  This should be how far the weapon sticks out from the player.  This is used for calculating the nearwall trace.SWEP.MoveSpeed = 0.83 --Multiply the player's movespeed by this.SWEP.IronSightsMoveSpeed = 0.8 --Multiply the player's movespeed by this when sighting.SWEP.SprintFOVOffset = 0 --Add this onto the FOV when we're sprinting.SWEP.SprintBobMult=0.9 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.--[[SPRINTING]]--SWEP.RunSightsPos = Vector (-1,0,2) --Change this, using SWEP Creation Kit preferablySWEP.RunSightsAng = Vector (-25,0,-25) --Change this, using SWEP Creation Kit preferably--[[IRONSIGHTS]]--SWEP.data 				= {}SWEP.data.ironsights			= 1 --Enable IronsightsSWEP.Secondary.IronFOV			= 76				-- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.SWEP.IronSightsPos = Vector(-2, 0, -3)SWEP.IronSightsAng = Vector(0,0,0)--[[INSPECTION]]--SWEP.InspectPos = Vector(5,3,5) --Replace with a vector, in style of ironsights position, to be used for inspectionSWEP.InspectAng = Vector(2,20,25) --Replace with a vector, in style of ironsights angle, to be used for inspection--[[PROJECTILES]]--SWEP.ProjectileEntity = "fm_rocketmissile" --Entity to shootSWEP.ProjectileVelocity = 900 --Entity to shoot's velocitySWEP.ProjectileModel = "models/weapons/w_bazooka_rocket.mdl" --Entity to shoot's model-- Deployfunction SWEP:Deploy()self.Weapon:SendWeaponAnim(ACT_VM_DRAW)self:SetDeploySpeed(self.Owner:GetViewModel():SequenceDuration())self.Weapon:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )self.Weapon:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )end-- Repasted reload function for soundsfunction SWEP:Reload(released)local l_CT = CurTime	if self.Owner:IsNPC() then		return	end	if not self:VMIV() then return end	if self:Ammo1() <= 0 then return end	if self:GetStat("Primary.ClipSize") < 0 then return end	if ( not released ) and ( not self:GetLegacyReloads() ) then return end	--if self:GetLegacyReloads() and not  dryfire_cvar:GetBool() and not self:GetOwner():KeyDown(IN_RELOAD) then return end	if self:GetOwner():KeyDown(IN_USE) then return end	ct = l_CT()	stat = self:GetStatus()	if self.PumpAction and self:GetShotgunCancel() then		if stat == TFA.Enum.STATUS_IDLE then			self:DoPump()		end	elseif TFA.Enum.ReadyStatus[stat] or ( stat == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting() ) then		if self:Clip1() < self:GetPrimaryClipSize() then				success, tanim = self:ChooseReloadAnim()				self:SetStatus(TFA.Enum.STATUS_RELOADING)				timer.Simple( 0.35, function()					if not IsValid(self) then return end					self:EmitSound("physics/metal/metal_grenade_scrape_smooth_loop1.wav")				end)				timer.Simple( 0.9, function()					if not IsValid(self) then return end					self:EmitSound("physics/metal/metal_grate_impact_soft"..math.random(1, 2)..".wav")				end)				timer.Simple( 1.5, function()					if not IsValid(self) then return end					self:EmitSound("buttons/button6.wav")				end)				if self:GetStat("ProceduralReloadEnabled") then					self:SetStatusEnd(ct + self:GetStat("ProceduralReloadTime"))				else					self:SetStatusEnd(ct + self:GetActivityLength( tanim, true ) )					self:SetNextPrimaryFire(ct + self:GetActivityLength( tanim, false ) )				end			if ( not game.SinglePlayer() ) or ( not self:IsFirstPerson() ) then				self:GetOwner():SetAnimation(PLAYER_RELOAD)			end			if self:GetStat("Primary.ReloadSound") and IsFirstTimePredicted() then				self:EmitSound(self:GetStat("Primary.ReloadSound"))			end			self:SetNextPrimaryFire( -1 )		elseif released or self:GetOwner():KeyPressed(IN_RELOAD) then--if self:GetOwner():KeyPressed(IN_RELOAD) or not self:GetLegacyReloads() then			self:CheckAmmo()		end	endend-- Adding opacity to the viewmodelfunction SWEP:PreDrawViewModel( vm )     render.SetBlend(0)endfunction SWEP:PostDrawViewModel( vm )     render.SetBlend(1)end-- Rocket Launcher VElements (courtesy of Lime)SWEP.VElements = {    ["rpg4+"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "base", rel = "", pos = Vector(-0.7, -0.25, 14.5), angle = Angle(0, -75.5, 180), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg5++"] = { type = "Model", model = "models/props_c17/pipe_cap005.mdl", bone = "base", rel = "", pos = Vector(-0.7, -0.25, -8.5), angle = Angle(-90, -90, 0), size = Vector(0.284, 0.284, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg4++"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "base", rel = "", pos = Vector(-0.7, -0.25, -8.801), angle = Angle(0, -86, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg6"] = { type = "Model", model = "models/props_combine/combine_interface002.mdl", bone = "base", rel = "", pos = Vector(1.5, 1.5, -5), angle = Angle(0, -45, -90), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg2"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "base", rel = "", pos = Vector(-1, 0.5, 30), angle = Angle(0, 170, 0), size = Vector(0.15, 0.15, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg3"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "base", rel = "", pos = Vector(-0.5, 6.5, 10), angle = Angle(0, 90, -90), size = Vector(0.25, 0.25, 0.224), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg1"] = { type = "Model", model = "models/props_combine/combine_mortar01b.mdl", bone = "base", rel = "", pos = Vector(-0.851, -5, 29), angle = Angle(-90, 0, -90), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg5+"] = { type = "Model", model = "models/props_c17/pipe_cap005.mdl", bone = "base", rel = "", pos = Vector(-0.7, -0.25, 3), angle = Angle(-90, -90, 0), size = Vector(0.284, 0.284, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg4"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "base", rel = "", pos = Vector(-0.7, -0.25, 14.5), angle = Angle(0, 90, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg8"] = { type = "Model", model = "models/props_wasteland/prison_switchbox001a.mdl", bone = "base", rel = "", pos = Vector(4, -0.75, 15), angle = Angle(0, 0, 0), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg9"] = { type = "Model", model = "models/props_combine/combine_barricade_med01a.mdl", bone = "base", rel = "", pos = Vector(-0.7, 4, 20), angle = Angle(0, -90, 0), size = Vector(0.05, 0.05, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg7"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "base", rel = "", pos = Vector(0.1, 4, 16), angle = Angle(-180, 180, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg5"] = { type = "Model", model = "models/props_c17/pipe_cap005.mdl", bone = "base", rel = "", pos = Vector(-0.7, -0.25, 15), angle = Angle(-90, -130, 0), size = Vector(0.284, 0.284, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg4+++"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "base", rel = "", pos = Vector(-0.7, -0.25, -8.9), angle = Angle(0, -75.5, 180), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} }}SWEP.WElements = {    ["rpg13"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-20, 0.349, -1.701), angle = Angle(-102, 0, 0), size = Vector(0.09, 0.09, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg2"] = { type = "Model", model = "models/props_wasteland/laundry_washer001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16, 1.7, -9.5), angle = Angle(11, -90, -101), size = Vector(0.075, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg3"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5, 0.8, -1.9), angle = Angle(-85, -180, 90), size = Vector(0.275, 0.2, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg1"] = { type = "Model", model = "models/props_combine/combine_mortar01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.5, 1.57, -11.45), angle = Angle(-180, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg8"] = { type = "Model", model = "models/props_wasteland/prison_switchbox001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8, 3.579, -8), angle = Angle(1, -92.5, -100), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg9"] = { type = "Model", model = "models/props_combine/combine_barricade_med01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 1, -7), angle = Angle(105, -180, -2), size = Vector(0.075, 0.025, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg11"] = { type = "Model", model = "models/props_wasteland/laundry_washer003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-13.5, 0.4, -3), angle = Angle(168, -2, 0), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg4+"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.149, 1.25, -7.5), angle = Angle(79, -2, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg5++"] = { type = "Model", model = "models/props_c17/pipe_cap003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-5.75, 0.824, -4.75), angle = Angle(-11.5, -1, -120), size = Vector(0.319, 0.319, 0.319), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg10"] = { type = "Model", model = "models/props_junk/metalbucket01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16.299, 1.575, -9.25), angle = Angle(79, 0, -3), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg5"] = { type = "Model", model = "models/props_c17/pipe_cap003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 1.2, -7.1), angle = Angle(-10.5, -2, 0), size = Vector(0.319, 0.319, 0.319), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg4+++"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-3.35, 0.879, -5.2), angle = Angle(79, -2, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg5+"] = { type = "Model", model = "models/props_c17/pipe_cap003.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.97, -5.881), angle = Angle(-10.5, -2, -120), size = Vector(0.319, 0.319, 0.319), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg12"] = { type = "Model", model = "models/props_phx/construct/plastic/plastic_panel1x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-13, 0.56, -0.601), angle = Angle(-0.5, -91.7, -12), size = Vector(0.085, 0.109, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg6"] = { type = "Model", model = "models/props_combine/combine_interface002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.5, 1.399, -5), angle = Angle(45, -82.5, 165), size = Vector(0.054, 0.054, 0.054), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg4"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.199, 1.25, -7.5), angle = Angle(-101, -2, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg4++"] = { type = "Model", model = "models/props_phx/construct/concrete_pipe01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-3.3, 0.85, -5.2), angle = Angle(-101.5, -2, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} },    ["rpg7"] = { type = "Model", model = "models/props_combine/combine_generator01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.5, 1.5, -4.801), angle = Angle(0, -92, 80), size = Vector(0.059, 0.059, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/future_vents", skin = 0, bodygroup = {} }}