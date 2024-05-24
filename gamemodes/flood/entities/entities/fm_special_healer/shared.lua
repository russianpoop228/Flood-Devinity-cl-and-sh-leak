ENT.Base      = "fm_special_base"
ENT.Type      = "anim"
ENT.Author    = "Donkie"
ENT.PrintName = "Countermeasure Generator"

ENT.IndividualCooldown = false
ENT.Cooldown = 50
ENT.ActiveTime = 15
ENT.FireProof = true
ENT.UnWeldProof = true
ENT.Model = "models/devinity/props/special_props/03_metal/telemetry_equipment_01/telemetry_equipment_01.mdl"
ENT.Health = 375
ENT.Cost = 750
ENT.HealAmount = 50
ENT.Mass = 200
ENT.Description = ("Heals all props on the boat it is welded to and itself for %i health, extinguishes them if they are on fire and makes them immune to fire and unwelding for %i seconds.")
	:format(ENT.HealAmount, ENT.ActiveTime)

local className = ENT.Folder:match("/(.+)")
GAMEMODE:RegisterSpecialProp(className, ENT)

sound.Add({
	name = "FM.Special.Healer.Main1",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = {
		"ambient/energy/zap1.wav",
		"ambient/energy/zap2.wav"
	}
})
sound.Add({
	name = "FM.Special.Healer.Main2",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = {
		"ambient/machines/teleport1.wav"
	}
})
sound.Add({
	name = "FM.Special.Healer.MainLoop",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = {
		"ambient/machines/combine_shield_loop3.wav"
	}
})