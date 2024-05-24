ENT.Base      = "fm_special_base"
ENT.Type      = "anim"
ENT.Author    = "Donkie"
ENT.PrintName = "Damage Amplifier"

ENT.IndividualCooldown = false
ENT.Cooldown = 55
ENT.ActiveTime = 15
ENT.FireProof = true
ENT.UnWeldProof = true
ENT.Model = "models/devinity/props/special_props/03_metal/orrery_01/orrery_01.mdl"
ENT.DamageScale = 1.5
ENT.Health = 500
ENT.Cost = 750
ENT.Mass = 500
ENT.Description = ("Multiplies all bullet/arrow/melee damage dealt by you and your team by %.1f for %i seconds.")
	:format(ENT.DamageScale, ENT.ActiveTime)

local className = ENT.Folder:match("/(.+)")
GAMEMODE:RegisterSpecialProp(className, ENT)

-- Override spawnicon generation cause the model has broken render bounds
if CLIENT then
	SpawniconGenFunctions["models/props/de_piranesi/pi_orrery.mdl"] = function(model, pos, middle, size)
		size = size * ( 1 - ( size / 900 ) )
		size = math.Clamp( size, 5, 1000 )

		local ViewAngle = Angle( 25, 220, 0 )
		local ViewPos = pos + ViewAngle:Forward() * size * -15
		local view = {}

		view.fov		= 4 -- Small fov = bigger model
		view.origin		= ViewPos + middle
		view.znear		= 1
		view.zfar		= ViewPos:Distance( pos ) + size * 2
		view.angles		= ViewAngle

		return view
	end
end

sound.Add({
	name = "FM.Special.DmgAmp.MainLoop",
	channel = CHAN_AUTO,
	volume = 1,
	level = 80,
	pitch = 100,
	sound = {
		"ambient/machines/combine_shield_loop3.wav"
	}
})