-- Wunderwaffle
AddCSLuaFile("autorun/particle_additions.lua")

game.AddParticles("particles/wunderwaffe_fx.pcf")
PrecacheParticleSystem("tesla_beam")

sound.Add({ name = "wunderwaffe.tesla_switch_flip_on", channel = CHAN_ITEM, volume = 1.0, sound = "weapons/tesla_gun/tesla_switch_flip_on.wav" })
sound.Add({ name = "wunderwaffe.tesla_switch_flip_off", channel = CHAN_ITEM, volume = 1.0, sound = "weapons/tesla_gun/tesla_switch_flip_off.wav" })
sound.Add({ name = "wunderwaffe.tesla_handle_pullback", channel = CHAN_ITEM, volume = 1.0, sound = "weapons/tesla_gun/tesla_handle_pullback.wav" })
sound.Add({ name = "wunderwaffe.tesla_clip_in", channel = CHAN_ITEM, volume = 1.0, sound = "weapons/tesla_gun/tesla_clip_in.wav" })
sound.Add({ name = "wunderwaffe.tesla_handle_release", channel = CHAN_ITEM, volume = 1.0, sound = "weapons/tesla_gun/tesla_handle_release.wav" })

-- Eviscerator
if SERVER then
	AddCSLuaFile()
end

EVISCERATOR_AMMO_TYPE = "eviscerator_blades"
EVISCERATOR_GAS_TYPE = "gas"

game.AddAmmoType( {
	name  = EVISCERATOR_AMMO_TYPE,
	dmgtype = DMG_SLASH
})

game.AddAmmoType( {
	name  = EVISCERATOR_GAS_TYPE,
	dmgtype = DMG_SLASH
})

if language then
	language.Add( EVISCERATOR_AMMO_TYPE .. "_ammo", "Saw Blades" )
end

if language then
	language.Add( EVISCERATOR_GAS_TYPE .. "gas_ammo", "Gasoline" )
end

-- Shotguns
game.AddParticles("particles/tfa_dshotgun_muzzle.pcf")

PrecacheParticleSystem("tfa_shotgun_muzzle") --SShotgun Muzzle, Hooray!

PrecacheParticleSystem("tfa_shotgun_muzzle_fire")

PrecacheParticleSystem("tfa_shotgun_muzzle_flash")

PrecacheParticleSystem("tfa_shotgun_muzzle_fsmoke")

PrecacheParticleSystem("tfa_shotgun_muzzle_shockwave")

PrecacheParticleSystem("tfa_shotgun_muzzle_smoke")

PrecacheParticleSystem("tfa_shotgun_muzzle_sparks")

-- Raygun
game.AddParticles("particles/bo3raygun.pcf")
PrecacheParticleSystem("rgun1_impact")
PrecacheParticleSystem("rgun1_trail_child1")
PrecacheParticleSystem("rgun1_flash")
PrecacheParticleSystem("rgun1_flash_pap")