-- Bazooka
local hnstbl = {}
hnstbl["channel"] = "1"
hnstbl["level"] = "150"
hnstbl["volume"] = "1.0"
hnstbl["CompatibilityAttenuation"] = "0.1"
hnstbl["pitch"] = "95,105"
hnstbl["sound"] = "weapons/bazooka/rocket1.wav"
hnstbl["name"] = "Bazooka.Fire"
hnstbl["script"] = "scripts/sounds/hl2_game_sounds_weapons.txt"
sound.Add(hnstbl)

local hnstbl = {}
hnstbl["channel"] = "3"
hnstbl["level"] = "75"
hnstbl["volume"] = "1.0"
hnstbl["CompatibilityAttenuation"] = "1"
hnstbl["pitch"] = "95,105"
hnstbl["sound"] = "weapons/bazooka/draw_grenade.wav"
hnstbl["name"] = "Bazooka.Draw"
hnstbl["script"] = "scripts/sounds/hl2_game_sounds_weapons.txt"
sound.Add(hnstbl)

local hnstbl = {}
hnstbl["channel"] = "3"
hnstbl["level"] = "75"
hnstbl["volume"] = "1.0"
hnstbl["CompatibilityAttenuation"] = "1"
hnstbl["pitch"] = "95,105"
hnstbl["sound"] = "weapons/bazooka/rocket_clipin.wav"
hnstbl["name"] = "Bazooka.ClipIn"
hnstbl["script"] = "scripts/sounds/hl2_game_sounds_weapons.txt"
sound.Add(hnstbl)

-- KF Weapons

--[[ PARTICLES ]]
game.AddParticles("particles/kf2_muzzleflash_test.pcf")
game.AddParticles("particles/matsilagi_muzzle_kf.pcf")
game.AddParticles("particles/kf2_flamethrower2.pcf")
game.AddParticles("particles/ef_flamer.pcf") 
game.AddParticles("particles/muzzleflashes_test.pcf")
game.AddParticles("particles/muzzleflashes_test_b.pcf")

--[[ SOUNDS ]]
// AR15
sound.Add({
	name = 			"TFA_KF2_AR15.1",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = {98,100},
	sound = 			"weapons/kf2/ar15/fire1.wav"
})
sound.Add({
	name = 			"TFA_KF2_AR15.ClipOut",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/ar15/clipout.wav"
})
sound.Add({
	name = 			"TFA_KF2_AR15.MagRelease",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/ar15/magrelease.wav"
})
sound.Add({
	name = 			"TFA_KF2_AR15.ClipIn",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/ar15/clipin.wav"
})
sound.Add({
	name = 			"TFA_KF2_AR15.ClipSlide",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/ar15/clipslide.wav"
})
sound.Add({
	name = 			"TFA_KF2_AR15.BoltBack",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/ar15/boltback.wav"
})
sound.Add({
	name = 			"TFA_KF2_AR15.BoltForward",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/ar15/boltforward.wav"
})
sound.Add({
	name = 			"TFA_KF2_AR15.Equip",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/ar15/equip.wav"
})
sound.Add({
	name = 			"TFA_KF2_AR15.Holster",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/ar15/equip.wav"
})

// M4
sound.Add({
	name = 			"TFA_KF2_M4.1",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = {98,100},
	sound = 			"weapons/kf2/m4/fire1.wav"
})
sound.Add({
	name = 			"TFA_KF2_M4.Open",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/m4/open.wav"
})
sound.Add({
	name = 			"TFA_KF2_M4.Insert",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/m4/insertshell.wav"
})
sound.Add({
	name = 			"TFA_KF2_M4.Equip",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/m4/equip.wav"
})
sound.Add({
	name = 			"TFA_KF2_M4.Holster",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/m4/equip.wav"
})
sound.Add({
	name = 			"TFA_KF2_M4.BoltBack",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/m4/boltback.wav"
})
sound.Add({
	name = 			"TFA_KF2_M4.BoltForward",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/m4/boltforward.wav"
})

// MB500
sound.Add({
	name = 			"TFA_KF2_MB500.1",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = {98,100},
	sound = 			"weapons/kf2/mb500/fire1.wav"
})
sound.Add({
	name = 			"TFA_KF2_MB500.Insert",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
    pitch = {100,110},
	sound = 			"weapons/kf2/mb500/insertshell.wav"
})
sound.Add({
	name = 			"TFA_KF2_MB500.Equip",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/mb500/equip.wav"
})
sound.Add({
	name = 			"TFA_KF2_MB500.Holster",
	channel = 		CHAN_WEAPON,
	volume = 		0.9, 
	pitch = {100,110},
	sound = 			"weapons/kf2/mb500/equip.wav"
})
sound.Add({
	name = 			"TFA_KF2_MB500.BoltBack",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/mb500/boltback.wav"
})
sound.Add({
	name = 			"TFA_KF2_MB500.BoltForward",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/mb500/boltforward.wav"
})
sound.Add({
	name = 			"TFA_KF2_MB500.ChanClear",
	channel = 		CHAN_WEAPON,
	volume = 		0.5,
	pitch = {100,110},
	sound = 			"weapons/kf2/mb500/chanclear.wav"
})

// SCAR
sound.Add({
	name = 			"TFA_KF2_SCAR.1",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = {98,100},
	sound = 			"weapons/kf2/scar/fire1.wav"
})
sound.Add({
	name = 			"TFA_KF2_SCAR.ClipOut",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/scar/clipout.wav"
})
sound.Add({
	name = 			"TFA_KF2_SCAR.MagRelease",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/scar/magrelease.wav"
})
sound.Add({
	name = 			"TFA_KF2_SCAR.ClipIn",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/scar/clipin.wav"
})
sound.Add({
	name = 			"TFA_KF2_SCAR.ClipSlide",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/scar/clipslide.wav"
})
sound.Add({
	name = 			"TFA_KF2_SCAR.BoltBack",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/scar/boltback.wav"
})
sound.Add({
	name = 			"TFA_KF2_SCAR.BoltForward",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/scar/boltforward.wav"
})
sound.Add({
	name = 			"TFA_KF2_SCAR.Equip",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/scar/equip.wav"
})
sound.Add({
	name = 			"TFA_KF2_SCAR.Holster",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/scar/equip.wav"
})


// FLAMETHROWER
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.ClipOut",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/clipout.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.ClipIn",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/trapper/NapalmCannonIn.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.BoltBack",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/trapper/FlameOut.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.BoltForward",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/trapper/FlameIn.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.Start",
	channel = 		CHAN_WEAPON,
	volume = 		1,
	pitch = {98,100},
	sound = 			"weapons/kf2/flamethrower/trapper/FlamerStart.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.Loop",
	channel = 		CHAN_WEAPON,
	volume = 		1,
	pitch = {98,100},
	sound = 			"weapons/kf2/flamethrower/trapper/FlamerLoop.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.End",
	channel = 		CHAN_WEAPON,
	volume = 		1,
	pitch = {98,100},
	sound = 			"weapons/kf2/flamethrower/trapper/FlamerStop.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.Equip",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/boltforward.wav"
})
sound.Add({
	name = 			"TFA_KF2_FLAMETHROWER.Holster",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	pitch = {100,110},
	sound = 			"weapons/kf2/flamethrower/boltback.wav"
})

// L85A2 - Devinity.org
sound.Add({
	name = 			"TFA_KF2_L85A2.1",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			"weapons/kf2/l85a2/fire1.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.2",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			"weapons/kf2/l85a2/fire2.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.3",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			"weapons/kf2/l85a2/fire3.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.ClipOut",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/l85a2/clipout.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.ClipIn",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/l85a2/clipin.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.ClipSlide",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/l85a2/clipslide.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.BoltBack",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/l85a2/boltback.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.BoltForward",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/l85a2/boltforward.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.Equip",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/l85a2/equip.wav"
})
sound.Add({
	name = 			"TFA_KF2_L85A2.Holster",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/l85a2/equip.wav"
})


// AK12
sound.Add({
	name = 			"TFA_KF2_AK12.1",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			"weapons/kf2/ak12/fire1.wav"
})
sound.Add({
	name = 			"TFA_KF2_AK12.2",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			"weapons/kf2/ak12/fire2.wav"
})
sound.Add({
	name = 			"TFA_KF2_AK12.3",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 			"weapons/kf2/ak12/fire3.wav"
})
sound.Add({
	name = 			"TFA_KF2_AK12.ClipOut",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/ak12/ak12_clipout.wav"
})
sound.Add({
	name = 			"TFA_KF2_AK12.ClipIn",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/ak12/ak12_clipin.wav"
})
sound.Add({
	name = 			"TFA_KF2_AK12.BoltBack",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/ak12/ak12_boltback.wav"
})
sound.Add({
	name = 			"TFA_KF2_AK12.BoltForward",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/ak12/ak12_boltforward.wav"
})
sound.Add({
	name = 			"TFA_KF2_AK12.Equip",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/ak12/ak12_equip.wav"
})
sound.Add({
	name = 			"TFA_KF2_AK12.Holster",
	channel = 		CHAN_WEAPON,
	volume = 		0.9,
	sound = 			"weapons/kf2/ak12/ak12_equip.wav"
})

-- G2 Contender

if CLIENT then
	killicon.Add( "tfa_contender", "vgui/hud/tfa_contender", icol  )
end

sound.Add({
	name =			"contender_g2.Single",
	channel =		CHAN_WEAPON,
	volumel =		1.0,
	sound = 		{"weapons/g2contender/scout-1.wav",
					"weapons/g2contender/scout-2.wav",
					"weapons/g2contender/scout-3.wav"}
})

sound.Add({
	name =			"contender_g2.Draw",
	channel =		CHAN_WEAPON,
	volumel =		1.0,
	sound =			"weapons/g2contender/Draw.mp3"
})


sound.Add({
	name =			"contender_g2.Hammer",
	channel =		CHAN_WEAPON,
	volumel =		1.0,
	sound =			{"weapons/g2contender/Cock-1.mp3",
					"weapons/g2contender/Cock-2.mp3"}
})


sound.Add({
	name =			"contender_g2.Open",
	channel =		CHAN_WEAPON,
	volumel =		1.0,
	sound =			"weapons/g2contender/open_chamber.mp3"
})


sound.Add({
	name =			"contender_g2.Shellout",
	channel =		CHAN_WEAPON,
	volumel =		1.0,
	sound =			"weapons/g2contender/Bullet_out.mp3"
})


sound.Add({
	name =			"contender_g2.Shellin",
	channel =		CHAN_WEAPON,
	volumel =		1.0,
	sound =			"weapons/g2contender/Bullet_in.mp3"
})


sound.Add({
	name =			"contender_g2.Close",
	channel =		CHAN_WEAPON,
	volumel =		1.0,
	sound =			"weapons/g2contender/close_chamber.mp3"
})


sound.Add({
	name =			"contender_g2.Shell",
	channel =		CHAN_WEAPON,
	volumel =		1.0,
	sound =			{"weapons/g2contender/pl_shell1.mp3",
					"weapons/g2contender/pl_shell2.mp3",
					"weapons/g2contender/pl_shell3.mp3",
					"weapons/g2contender/pl_shell4.mp3"}
})

sound.Add( {
	name = "TFA_KF2_DEAGLE.Deploy",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = { 95, 110 },
	sound = ")weapons/kf2_deagle/deagle_deploy_1.wav"
} )

sound.Add( {
	name = "TFA_KF2_DEAGLE.SlideForward",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = { 95, 110 },
	sound = ")weapons/kf2_deagle/deagle_slideforward_1.wav"
} )

sound.Add( {
	name = "TFA_KF2_DEAGLE.SlideBack",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = { 95, 110 },
	sound = ")weapons/kf2_deagle/deagle_slideback_1.wav"
} )

sound.Add( {
	name = "TFA_KF2_DEAGLE.ClipOut",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = { 95, 110 },
	sound = ")weapons/kf2_deagle/deagle_clip_out_1.wav"
} )

sound.Add( {
	name = "TFA_KF2_DEAGLE.ClipIn",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = { 95, 110 },
	sound = ")weapons/kf2_deagle/deagle_clip_in_1.wav"
} )

sound.Add( {
	name = "TFA_KF2_DEAGLE.ClipLocked",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = { 95, 110 },
	sound = ")weapons/kf2_deagle/deagle_clip_locked_1.wav"
} )

sound.Add( {
	name = "TFA_KF2_DEAGLE.HelpingHandRetract",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = 100,
	pitch = { 95, 110 },
	sound = ")weapons/kf2_deagle/deagle_helpinghandretract.wav"
} )

-- Eviscerator

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.1",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/shoot.wav"},
	["pitch"] = {95, 105}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.Idle",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/saw_idle.wav"},
	["pitch"] = {100,100},
	["volume"] = 0.3
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.Saw",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/saw_loop.wav"},
	["pitch"] = {100,100}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.SawSlide",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/saw_slide.wav"},
	["pitch"] = {97, 103}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.StartSaw",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/revup.wav"},
	["pitch"] = {105, 110}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.EndSaw",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/revdown.wav"},
	["pitch"] = {97, 103}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.StartIdle",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/idle_start.wav"},
	["pitch"] = {97, 103},
	["volume"] = 0.3
	
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.EndIdle",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/idle_end.wav"},
	["pitch"] = {97, 103},
	["volume"] = 0.3
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.MagOut",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/magout.wav"},
	["pitch"] = {97, 103}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.MagIn",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/magin.wav"},
	["pitch"] = {97, 103}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.Foley1",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/foley_metal.wav"},
	["pitch"] = {97, 103}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.Smack",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/eviscerator/smack.wav"},
	["pitch"] = {97, 103}
})

sound.Add({
	["name"] = "TFA_KF2_EVISCERATOR.Holster",
	["channel"] = CHAN_WEAPON,
	["sound"] = {"weapons/tfa_kf2/zweihander/sheath_1.wav", "weapons/tfa_kf2/zweihander/sheath_2.wav" },
	["pitch"] = {95, 105}
})

-- Tiki Rifle

sound.Add({
	name = 			"Weapon_Tikih.Clipout",			
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			"weapons/Tiki/tiki_clipout.wav"	
})

sound.Add({
	name = 			"Weapon_Tikih.Clipin",			
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = { 98, 102 },
	sound = 			"weapons/Tiki/tiki_clipin.wav"	
})

sound.Add({
	name = 			"Weapon_Tikih.Boltslap",			
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			"weapons/Tiki/tiki_boltslap.wav"	
})

sound.Add({
	name = 			"Weapon_Tikih.Deploy",			
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	pitch = { 95, 110 },
	sound = 			"weapons/Tiki/deploy.wav"	
})


sound.Add({
	name = 			"Weapon_Tiki.1",
	channel = 		CHAN_WEAPON,
	volume = 		0.35,
	pitch = { 95, 110 },
	sound = 			 "weapons/tiki/ump45-1.wav"
})

-- Ray Gun

sound.Add({
	name = 			"Weapon_Raygun.Shoot",
	channel = 		CHAN_WEAPON,
	volume = 		1.0,
	sound = 		"weapons/raygun/raygun_fire.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Open",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 100,
    sound = "weapons/waw_raygun/raygun/wpn_ray_reload_open.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Magout",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 100,
    sound = "weapons/waw_raygun/raygun/wpn_ray_reload_battery_out.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Magin",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 100,
    sound = "weapons/waw_raygun/raygun/wpn_ray_reload_battery.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Close",
    channel = CHAN_WEAPON,
    volume = 0.5,
    soundlevel = 100,
    sound = "weapons/waw_raygun/raygun/wpn_ray_reload_close.wav"
})
sound.Add(
{
    name = "Weapon_Raygun.Raise",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 100,
    sound = "weapons/waw_raygun/raygun/bo3wpn_ray_1straise.wav"
})

-- P90

sound.Add( {
	name = "TFA_ROCKY_KF2_P90.1",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_p90/gunfire/smg_fire_1.wav"
} )

sound.Add( {
	name = "TFA_ROCKY_KF2_P90.Deploy",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_p90/gunother/smg_deploy_1.wav"
} )

sound.Add( {
	name = "TFA_ROCKY_KF2_P90.SlideForward",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_p90/gunother/smg_slideforward_1.wav"
} )

sound.Add( {
	name = "TFA_ROCKY_KF2_P90.SlideBack",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_p90/gunother/smg_slideback_1.wav"
} )

sound.Add( {
	name = "TFA_ROCKY_KF2_P90.ClipOut",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_p90/gunother/smg_clip_out_1.wav"
} )

sound.Add( {
	name = "TFA_ROCKY_KF2_P90.ClipIn",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_p90/gunother/smg_clip_in_1.wav"
} )

sound.Add( {
	name = "TFA_ROCKY_KF2_P90.ClipLocked",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_p90/gunother/smg_clip_locked_1.wav"
} )

sound.Add( {
	name = "TFA_ROCKY_KF2_P90.HelpingHandRetract",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_p90/gunother/rifle_helpinghandretract.wav"
} )

-- Dragon Breath
sound.Add( {
	name = "TFA_L4D2_KF2_DBREATH.1",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_dbreath/gunfire/shotgun_fire_1_incendiary.wav"
} )

sound.Add( {
	name = "TFA_L4D2_KF2_DBREATH.Deploy",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_dbreath/gunother/shotgun_deploy_1.wav"
} )

sound.Add( {
	name = "TFA_L4D2_KF2_DBREATH.LoadShell",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = { ")weapons/l4d2_rocky_kf2_dbreath/gunother/shotgun_load_shell_2.wav", ")weapons/l4d2_rocky_kf2_dbreath/gunother/shotgun_load_shell_4.wav" }
} )

sound.Add( {
	name = "TFA_L4D2_KF2_DBREATH.Pump",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_kf2_dbreath/gunother/shotgun_pump_1.wav"
} )
-- S&W Revolver
sound.Add( {
	name = "TFA_L4D2_SW_500.1",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunfire/magnum_shoot.wav"
} )

sound.Add( {
	name = "TFA_L4D2_SW_500.Deploy",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunother/pistol_deploy_1.wav"
} )

sound.Add( {
	name = "TFA_L4D2_SW_500.SlideForward",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunother/pistol_slideforward_1.wav"
} )

sound.Add( {
	name = "TFA_L4D2_SW_500.SlideBack",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunother/pistol_slideback_1.wav"
} )

sound.Add( {
	name = "TFA_L4D2_SW_500.ClipOut",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunother/pistol_clip_out_1.wav"
} )

sound.Add( {
	name = "TFA_L4D2_SW_500.ClipIn",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunother/pistol_clip_in_1.wav"
} )

sound.Add( {
	name = "TFA_L4D2_SW_500.ClipLocked",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunother/pistol_clip_locked_1.wav"
} )

sound.Add( {
	name = "TFA_L4D2_SW_500.FullAutoButton",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunother/pistol_fullautobutton_1.wav"
} )

sound.Add( {
	name = "TFA_L4D2_SW_500.HelpingHandRetract",
	channel = CHAN_WEAPON,
		volume	  = 1,
		soundlevel  = 60,
		pitchstart  = 100,
		pitchend	= 100,
	sound = ")weapons/l4d2_rocky_m500/gunother/pistol_helpinghandretract.wav"
} )


