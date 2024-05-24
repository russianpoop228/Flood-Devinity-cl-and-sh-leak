ENT.Base      = "fm_special_base"
ENT.Type      = "anim"
ENT.Author    = "Donkie"
ENT.PrintName = "Gun Cabinet"

ENT.IndividualCooldown = true
ENT.Cooldown = 80
ENT.ActiveTime = 0
ENT.FireProof = true
ENT.UnWeldProof = true
ENT.Model = "models/devinity/props/special_props/01_wood/rifle_cabinet_01/rifle_cabinet_01.mdl"
ENT.Health = 650
ENT.Cost = 750
ENT.Mass = 150
ENT.Description = "Gives you a random gun that you don't own or have holstered with full ammunition. Team members use this prop individually and have separate cooldowns."
ENT.DisabledEvents = {"pirate", "oneweapon"}
ENT.IsAllowedPhase = function(self, phase) return phase == TIME_FIGHT end

local className = ENT.Folder:match("/(.+)")
GAMEMODE:RegisterSpecialProp(className, ENT)

sound.Add({
	name = "FM.Special.Gun.Main",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = {
		"items/ammo_pickup.wav"
	}
})
