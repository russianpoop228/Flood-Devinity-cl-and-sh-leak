ENT.Base      = "fm_special_base"
ENT.Type      = "anim"
ENT.Author    = "Donkie"
ENT.PrintName = "Food Stack"

ENT.IndividualCooldown = true
ENT.Cooldown = 45
ENT.ActiveTime = 0
ENT.FireProof = true
ENT.UnWeldProof = true
ENT.Model = "models/devinity/props/special_props/04_miscellaneous/food_stack_01/food_stack_01.mdl"
ENT.Health = 550
ENT.Cost = 750
ENT.HealAmount = 25
ENT.Mass = 200
ENT.Description = ("Heals you for %i health. Team members use this prop individually and have separate cooldowns.")
	:format(ENT.HealAmount)

local className = ENT.Folder:match("/(.+)")
GAMEMODE:RegisterSpecialProp(className, ENT)
