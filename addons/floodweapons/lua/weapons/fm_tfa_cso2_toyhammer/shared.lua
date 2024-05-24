SWEP.Category				= "Flood Weapons"
SWEP.Author				= ""
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "Toy Hammer"		-- Weapon name (Shown on HUD)	
SWEP.Slot				= 0				-- Slot in the weapon selection menu
SWEP.SlotPos				= 27			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.DrawCrosshair			= false		-- set false if you want no crosshair
SWEP.Weight				= 30			-- rank relative ot other weapons. bigger is better
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.HoldType 				= "melee"		-- how others view you carrying the weapon
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive 
-- you're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.ViewModelFlip			= false
SWEP.ViewModel				= "models/weapons/tfa_cso2/c_toyhammer.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/tfa_cso2/w_toyhammer.mdl"	-- Weapon world model
SWEP.ShowWorldModel			= true
SWEP.Base				= "tfa_knife_base"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = true

-- nZombies Stuff
SWEP.NZWonderWeapon		= false	-- Is this a Wonder-Weapon? If true, only one player can have it at a time. Cheats aren't stopped, though.
--SWEP.NZRePaPText		= "your text here"	-- When RePaPing, what should be shown? Example: Press E to your text here for 2000 points.
--SWEP.NZPaPName				= "Quick Blaster-Slicer 09"
--SWEP.NZPaPReplacement 	= "tfa_cso2_pkm_fire"	-- If Pack-a-Punched, replace this gun with the entity class shown here.
SWEP.NZPreventBox		= true	-- If true, this gun won't be placed in random boxes GENERATED. Users can still place it in manually.
SWEP.NZTotalBlackList	= true	-- if true, this gun can't be placed in the box, even manually, and can't be bought off a wall, even if placed manually. Only code can give this gun.	-- if true, this gun can't be placed in the box, even manually, and can't be bought off a wall, even if placed manually. Only code can give this gun.

SWEP.Offset = {
	Pos = {
		Up = 30,
		Right = -22,
		Forward = 20
	},
	Ang = {
		Up = 90,
		Right = -45,
		Forward = 178
	},
	Scale = 1.0
}

SWEP.ViewModelFOV			= 75		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= true		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.

SWEP.SlashTable = {"toyhammer_midslash1", "toyhammer_midslash2"} --Table of possible hull sequences
SWEP.StabTable = {"toyhammer_stab"} --Table of possible hull sequences
SWEP.StabMissTable = {"toyhammer_stab_miss"} --Table of possible hull sequences

SWEP.Primary.RPM = 120 --Primary Slashs per minute
SWEP.Secondary.RPM = 60 --Secondary stabs per minute
SWEP.Primary.Delay = 0.1 --Delay for hull (primary)
SWEP.Secondary.Delay = 0.3 --Delay for hull (secondary)
SWEP.Primary.Damage = 24
SWEP.Secondary.Damage = 100

SWEP.Primary.Ammo = ""
SWEP.Primary.ClipSize = -1

SWEP.Primary.Sound = ""-- Sound("Weapon_Knife.Slash") --Sounds
SWEP.KnifeShink = "tfa_cso2_toyhammer.Hitwall"--"Weapon_Knife.HitWall" --Sounds
SWEP.KnifeSlash = "tfa_cso2_toyhammer.Hit"--"Weapon_Knife.Hit" --Sounds
SWEP.KnifeStab = ""--"Weapon_Knife.Slash" --Sounds

SWEP.Primary.Length = 80
SWEP.Secondary.Length = 80

SWEP.VMPos = Vector(0,0,-2)
SWEP.VMAng = Vector(5,0,0)
