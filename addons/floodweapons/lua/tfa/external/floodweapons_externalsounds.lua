local function BMSAddSound( sndname, sndpath, chan )
	sound.Add({
		name = sndname,
		channel = chan,
		volume = 1,
		level = 100,
		pitch = { 98, 103 },
		sound = sndpath
	})
end

local path

--SPAS Shotgun
path = "weapons/shotgun/"

TFA.AddFireSound("weapon_shotgun_bms.1", path .. "single.wav", CHAN_WEAPON )
TFA.AddFireSound("weapon_shotgun_bms.2", path .. "double.wav", CHAN_WEAPON )

BMSAddSound("weapon_shotgun_bms.Reload.1", path .. "reload1.wav", CHAN_WEAPON)
BMSAddSound("weapon_shotgun_bms.Reload.2", path .. "reload2.wav", CHAN_WEAPON)
BMSAddSound("weapon_shotgun_bms.Reload.3", path .. "reload3.wav", CHAN_WEAPON)
BMSAddSound("weapon_shotgun_bms.Special1", path .. "pump.wav", CHAN_WEAPON)
BMSAddSound("weapon_shotgun_bms.draw_admire01", path .. "draw_admire01.wav", CHAN_WEAPON)

--Glock
path = "weapons/glock/"

TFA.AddFireSound("BMS_GLOCK.1", path .. "single.wav", CHAN_WEAPON )
TFA.AddFireSound("BMS_GLOCK.2", path .. "glock_supp.wav", CHAN_WEAPON )

BMSAddSound("weapon_glock_bms.Reload", path .. "reload.wav", CHAN_WEAPON)
BMSAddSound("weapon_glock_bms.Reload.Chambered", path .. "reload_roundchambered.wav", CHAN_WEAPON)
BMSAddSound("weapon_glock_bms.Fidget", path .. "idle_fidget.wav", CHAN_WEAPON)
BMSAddSound("weapon_glock_bms.Admire", path .. "draw_admire.wav", CHAN_WEAPON)


--.357 Revolver
path = "weapons/357/"

TFA.AddFireSound("weapon_357_bms.1", path .. "single.wav", CHAN_WEAPON)

BMSAddSound("weapon_357_bms.Reload", path .. "reload.wav", CHAN_WEAPON)
BMSAddSound("weapon_357_bms.draw_admire01", path .. "draw_admire01.wav", CHAN_WEAPON)

--Doom SSG
TFA.AddFireSound("TFA_DOOM_SSG.2", {"weapons/tfa_doom/ssg/wpn_shotgun_dbl_fire_01.mp3", "weapons/tfa_doom/ssg/wpn_shotgun_dbl_fire_02.mp3"}, true, ")" )
TFA.AddWeaponSound("TFA_DOOM_SSG.ReloadClose", "weapons/tfa_doom/ssg/wpn_shotgun_dbl_reload_close_01.wav")
TFA.AddWeaponSound("TFA_DOOM_SSG.ReloadOpen", {"weapons/tfa_doom/ssg/wpn_shotgun_dbl_reload_open_01.wav", "weapons/tfa_doom/ssg/wpn_shotgun_dbl_reload_open_02.wav"})
TFA.AddWeaponSound("TFA_DOOM_SSG.Insert", {"weapons/tfa_doom/ssg/sfx_wpn_superShotgun_shell_insert_deep_01.wav", "weapons/tfa_doom/ssg/sfx_wpn_superShotgun_shell_insert_deep_02.wav", "weapons/tfa_doom/ssg/sfx_wpn_superShotgun_shell_insert_deep_03.wav", "weapons/tfa_doom/ssg/sfx_wpn_superShotgun_shell_insert_deep_04.wav"})
TFA.AddWeaponSound("TFA_DOOM_SSG.EjectGear", {"weapons/tfa_doom/ssg/DB_Shells_Eject_Tube_01.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Tube_02.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Tube_03.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Tube_04.wav"})
TFA.AddWeaponSound("TFA_DOOM_SSG.EjectTube", {"weapons/tfa_doom/ssg/DB_Shells_Eject_Gear_01.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Gear_02.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Gear_03.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Gear_04.wav"})


--GOL Magnum
path = "weapons/tfa_ins2/gol/"

TFA.AddFireSound("TFA_INS2_GOL.1", path .. "m40a1_fp.wav", CHAN_WEAPON )
TFA.AddWeaponSound("TFA_INS2_SPAS12.Draw", { path .. "uni_weapon_draw_01.wav", path .. "uni_weapon_draw_02.wav", path .. "uni_weapon_draw_03.wav" } ) --, path .. "bash1.wav"})
TFA.AddWeaponSound("TFA_INS2_SPAS12.Holster", path .. "uni_weapon_holster.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.Boltback", path .. "m40a1_boltback.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.Boltrelease", path .. "m40a1_boltrelease.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.Boltforward", path .. "m40a1_boltforward.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.BoltLatch", path .. "m40a1_boltlatch.wav")
TFA.AddWeaponSound("TFA_INS2_GOL.Roundin", { path .. "m40a1_bulletin_1.wav", path .. "m40a1_bulletin_2.wav", path .. "m40a1_bulletin_3.wav", path .. "m40a1_bulletin_4.wav" } )
TFA.AddWeaponSound("TFA_INS2_GOL.Empty", path .. "m40a1_empty.wav")


--MP5
path = "weapons/mp5/"

TFA.AddFireSound("weapon_mp5_bms.1", path .. "single1.wav", CHAN_WEAPON )
TFA.AddFireSound("weapon_mp5_bms.2", path .. "single2.wav", CHAN_WEAPON )
TFA.AddFireSound("weapon_mp5_bms.3", path .. "single3.wav", CHAN_WEAPON )

BMSAddSound("weapon_mp5_bms.reload", path .. "reload.wav", CHAN_WEAPON)
BMSAddSound("weapon_mp5_bms.reloadlong", path .. "reload_long.wav", CHAN_WEAPON)
BMSAddSound("weapon_mp5_bms.DrawAdmire", path .. "draw_admire.wav", CHAN_WEAPON)

--Doom SSG
TFA.AddFireSound("TFA_DOOM_SSG.2", {"weapons/tfa_doom/ssg/wpn_shotgun_dbl_fire_01.mp3", "weapons/tfa_doom/ssg/wpn_shotgun_dbl_fire_02.mp3"}, true, ")" )
TFA.AddWeaponSound("TFA_DOOM_SSG.ReloadClose", "weapons/tfa_doom/ssg/wpn_shotgun_dbl_reload_close_01.wav")
TFA.AddWeaponSound("TFA_DOOM_SSG.ReloadOpen", {"weapons/tfa_doom/ssg/wpn_shotgun_dbl_reload_open_01.wav", "weapons/tfa_doom/ssg/wpn_shotgun_dbl_reload_open_02.wav"})
TFA.AddWeaponSound("TFA_DOOM_SSG.Insert", {"weapons/tfa_doom/ssg/sfx_wpn_superShotgun_shell_insert_deep_01.wav", "weapons/tfa_doom/ssg/sfx_wpn_superShotgun_shell_insert_deep_02.wav", "weapons/tfa_doom/ssg/sfx_wpn_superShotgun_shell_insert_deep_03.wav", "weapons/tfa_doom/ssg/sfx_wpn_superShotgun_shell_insert_deep_04.wav"})
TFA.AddWeaponSound("TFA_DOOM_SSG.EjectGear", {"weapons/tfa_doom/ssg/DB_Shells_Eject_Tube_01.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Tube_02.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Tube_03.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Tube_04.wav"})
TFA.AddWeaponSound("TFA_DOOM_SSG.EjectTube", {"weapons/tfa_doom/ssg/DB_Shells_Eject_Gear_01.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Gear_02.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Gear_03.wav", "weapons/tfa_doom/ssg/DB_Shells_Eject_Gear_04.wav"})

--Minimi
path = "weapons/tfa_ins2/minimi/"

TFA.AddFireSound("TFA_INS2_MINIMI.1", path .. "m249_fp.wav", false, ")" )
TFA.AddFireSound("TFA_INS2_MINIMI.2", path .. "m249_suppressed_fp.wav", false, ")" )

TFA.AddWeaponSound("TFA_INS2_MINIMI.Empty", path .. "m249_empty.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.CoverOpen", path .. "m249_coveropen.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.CoverClose", path .. "m249_coverclose.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.FetchMag", path .. "m249_fetchmag.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.ThrowAway", path .. "m249_beltremove.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.Magout", path .. "m249_magout.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.MagoutFull", path .. "m249_magout.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.MagHit", path .. "m249_maghit.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.MagIn", path .. "m249_magin.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.BeltJingle", path .. "m249_bulletjingle.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.BeltAlign", path .. "m249_beltalign.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.ArmMovement_01",path .. "m249_armmovement_01.wav" )
TFA.AddWeaponSound("TFA_INS2_MINIMI.ArmMovement_02",path .. "m249_armmovement_02.wav" )
TFA.AddWeaponSound("TFA_INS2_MINIMI.Boltback", path .. "m249_boltback.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.Boltrelease", path .. "m249_boltrelease.wav")
TFA.AddWeaponSound("TFA_INS2_MINIMI.Shoulder", path .. "m249_shoulder.wav")

-- Plasma Gun. Green goo versus the world! (sounds like some hentai concept :v)
sound.Add(soundData)

local soundData = {
	name 		= "PlasmaGun.ClipOut" ,
	channel 	= CHAN_WEAPON,
	volume 		= 1,
	soundlevel 	= 80,
	pitchstart 	= 100,
	pitchend 	= 100,
	sound 		= "weapons/tfa_cso/plasma_gun/clipout.wav"
}

sound.Add(soundData)

local soundData = {
	name 		= "PlasmaGun.ClipIn1" ,
	channel 	= CHAN_WEAPON,
	volume 		= 1,
	soundlevel 	= 80,
	pitchstart 	= 100,
	pitchend 	= 100,
	sound 		= "weapons/tfa_cso/plasma_gun/clipin_1.wav"
}

sound.Add(soundData)

local soundData = {
	name 		= "PlasmaGun.ClipIn2" ,
	channel 	= CHAN_WEAPON,
	volume 		= 1,
	soundlevel 	= 80,
	pitchstart 	= 100,
	pitchend 	= 100,
	sound 		= "weapons/tfa_cso/plasma_gun/clipin_2.wav"
}

sound.Add(soundData)

local soundData = {
	name 		= "PlasmaGun.Fire" ,
	channel 	= CHAN_WEAPON,
	volume 		= 1,
	soundlevel 	= 80,
	pitchstart 	= 100,
	pitchend 	= 100,
	sound 		= "weapons/tfa_cso/plasma_gun/fire.wav"
}

sound.Add(soundData)


-- Laserminigun!!!
local soundData = {
	name		= "Laserminigun.ClipOut1" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/laserminigun/clipout1.wav"
}
 
sound.Add(soundData)
 
local soundData = {
	name		= "Laserminigun.ClipOut2" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/laserminigun/clipout2.wav"
}
 
sound.Add(soundData)
 
local soundData = {
	name		= "Laserminigun.ClipIn1" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/laserminigun/clipin1.wav"
}
 
sound.Add(soundData)
 
local soundData = {
	name		= "Laserminigun.ClipIn2" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/laserminigun/clipin2.wav"
}
 
sound.Add(soundData)
 
local soundData = {
	name		= "Laserminigun.Idle" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/laserminigun/idle.wav"
}
 
sound.Add(soundData)

local soundData = {
	name		= "Laserminigun.Draw" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/laserminigun/draw.wav"
}
 
sound.Add(soundData)
 
local soundData = {
	name		= "Laserminigun.Fire" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/glock/single.wav"
}

sound.Add(soundData)

--TMP
TFA.AddWeaponSound( "tfa_cso2_tmp.1", "devinity/css/tmp-1.wav")

TFA.AddWeaponSound( "tfa_cso2_tmp.Clipout", "devinity/css/tmp_clipout.wav")
TFA.AddWeaponSound( "tfa_cso2_tmp.Clipin", "devinity/css/tmp_clipin.wav")
TFA.AddWeaponSound( "tfa_cso2_tmp.Boltpull", "devinity/css/mac10_boltpull.wav")

--Toyhammer
BMSAddSound( "tfa_cso2_toyhammer.Draw", "tfa_cso2/weapons/toyhammer/toyhammer_draw.wav" )
BMSAddSound( "tfa_cso2_toyhammer.Stab", "tfa_cso2/weapons/toyhammer/toyhammer_stab.wav", CHAN_WEAPON  )
BMSAddSound( "tfa_cso2_toyhammer.Stabmiss", "tfa_cso2/weapons/toyhammer/toyhammer_stabmiss.wav", CHAN_WEAPON  )
BMSAddSound( "tfa_cso2_toyhammer.Attack01", "tfa_cso2/weapons/toyhammer/toyhammer_attack01.wav", CHAN_WEAPON  )
BMSAddSound( "tfa_cso2_toyhammer.Attack02", "tfa_cso2/weapons/toyhammer/toyhammer_attack02.wav", CHAN_WEAPON  )
BMSAddSound( "tfa_cso2_toyhammer.Hit", "tfa_cso2/weapons/toyhammer/toyhammer_stab_hit.wav", CHAN_WEAPON  )
BMSAddSound( "tfa_cso2_toyhammer.Hitwall", { "tfa_cso2/weapons/toyhammer/toyhammer_attack_hit_1.wav", "tfa_cso2/weapons/toyhammer/toyhammer_attack_hit_2.wav" } )

-- M249 Saw (Test)
path = "weapons/eleweps/m249saw/"

TFA.AddFireSound("TFA_ELEPHANT_M249.FIRE",  path .. "m249_fire1.wav")

TFA.AddWeaponSound("TFA_ELEPHANT_M249.INDOOR_TRAIL", path .. "m249_indoor_trail.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.OUTDOOR_TRAIL", path .. "m249_outdoor_trail.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.BOXOUT", path .. "handling_m249_boxout.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.BOXIN", path .. "handling_m249_boxin.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.OPEN", path .. "handling_m249_open.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.CLOSE", path .. "handling_m249_close.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.BOLT", path .. "handling_m249_bolt.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.BELTLOAD", path .. "handling_m249_beltload.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.BELTPULL", path .. "handling_m249_beltpull.wav")
TFA.AddWeaponSound("TFA_ELEPHANT_M249.BELTREMOVE", path .. "handling_m249_beltremove.wav")

-- G36

path = "weapons/tfa_ins2/fas2_g36c/"
pref = "TFA_INS2.FAS2_G36C"

TFA.AddFireSound(pref .. ".1", path .. "g36c_fire1.wav", true, ")")
TFA.AddFireSound(pref .. ".2", path .. "g36c_suppressed_fire1.wav", true, ")")

TFA.AddWeaponSound(pref .. ".SightRaise", {path .. "generic/weapon_sightraise.wav", path .. "generic/weapon_sightraise2.wav"})
TFA.AddWeaponSound(pref .. ".SightLower", {path .. "generic/weapon_sightlower.wav", path .. "generic/weapon_sightlower2.wav"})
TFA.AddWeaponSound(pref .. ".Cloth_Movement", {path .. "generic/generic_cloth_movement4.wav", path .. "generic/generic_cloth_movement8.wav", path .. "generic/generic_cloth_movement12.wav", path .. "generic/generic_cloth_movement16.wav"})
TFA.AddWeaponSound(pref .. ".Deploy", {path .. "generic/weapon_deploy1.wav", path .. "generic/weapon_deploy2.wav", path .. "generic/weapon_deploy3.wav"})
TFA.AddWeaponSound(pref .. ".Holster", {path .. "generic/weapon_holster1.wav", path .. "generic/weapon_holster2.wav", path .. "generic/weapon_holster3.wav"})
TFA.AddWeaponSound(pref .. ".BoltHandle", path .. "g36c_handle.wav")
TFA.AddWeaponSound(pref .. ".BoltBack", path .. "g36c_boltback.wav")
TFA.AddWeaponSound(pref .. ".BoltForward", path .. "g36c_boltforward.wav")
TFA.AddWeaponSound(pref .. ".Stock", path .. "g36c_stock.wav")
TFA.AddWeaponSound(pref .. ".Switch", path .. "generic/switch.wav")
TFA.AddWeaponSound(pref .. ".MagIn", path .. "g36c_magin.wav")
TFA.AddWeaponSound(pref .. ".MagOut", path .. "g36c_magout.wav")
TFA.AddWeaponSound(pref .. ".MagOutEmpty", path .. "g36c_magout_empty.wav")
TFA.AddWeaponSound(pref .. ".MagPouch", path .. "generic/generic_magpouch1.wav")

-- Thunderbolt. Pew-pew

local soundData = {
	name 		= "ThunderBolt.Draw" ,
	channel 	= CHAN_WEAPON,
	volume 		= 1,
	soundlevel 	= 80,
	pitchstart 	= 100,
	pitchend 	= 100,
	sound 		= "weapons/tfa_cso/thunderbolt/draw.wav"
}

sound.Add(soundData)

local soundData = {
	name 		= "ThunderBolt.Idle" ,
	channel 	= CHAN_WEAPON,
	volume 		= 1,
	soundlevel 	= 80,
	pitchstart 	= 100,
	pitchend 	= 100,
	sound 		= "weapons/tfa_cso/thunderbolt/idle.wav"
}

sound.Add(soundData)

local soundData = {
	name 		= "ThunderBolt.Fire" ,
	channel 	= CHAN_WEAPON,
	volume 		= 1,
	soundlevel 	= 80,
	pitchstart 	= 100,
	pitchend 	= 100,
	sound 		= "weapons/tfa_cso/thunderbolt/fire.wav"
}

sound.Add(soundData)


-- Star-Chaser SR. TWINKLES!

local soundData = {
	name		= "StarChaserSR.ClipOut" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/star_chaser_sr/clipout.wav"
}
 
sound.Add(soundData)
 
local soundData = {
	name		= "StarChaserSR.ClipIn" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/star_chaser_sr/clipin.wav"
}
 
sound.Add(soundData)

local soundData = {
	name		= "StarChaserSR.Idle" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/star_chaser_sr/idle.wav"
}
 
sound.Add(soundData)
 
local soundData = {
	name		= "StarChaserSR.Fire" ,
	channel	 = CHAN_WEAPON,
	volume	  = 1,
	soundlevel  = 80,
	pitchstart  = 100,
	pitchend	= 100,
	sound	   = "weapons/tfa_cso/star_chaser_sr/fire.wav"
}

sound.Add(soundData)


-- StarChaser AR. Shooting AUG
local soundData = {
    name        = "StarAR.Fire" ,
    channel     = CHAN_WEAPON,
    volume      = 1,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound       = "weapons/tfa_cso/starchaserar/fire.wav"
}

sound.Add(soundData)

local soundData = {
    name        = "StarAR.Boom" ,
    channel     = CHAN_WEAPON,
    volume      = 1,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound       = "weapons/tfa_cso/starchaserar/boom.wav"
}

sound.Add(soundData)

local soundData = {
    name        = "StarAR.ClipOut" ,
    channel     = CHAN_WEAPON,
    volume      = 1,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound       = "weapons/tfa_cso/starchaserar/clipout.wav"
}
 
sound.Add(soundData)

local soundData = {
    name        = "StarAR.ClipIn" ,
    channel     = CHAN_WEAPON,
    volume      = 1,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound       = "weapons/tfa_cso/starchaserar/clipin.wav"
}
 
sound.Add(soundData)

local soundData = {
    name        = "StarAR.BoltPull" ,
    channel     = CHAN_WEAPON,
    volume      = 1,
    soundlevel  = 80,
    pitchstart  = 100,
    pitchend    = 100,
    sound       = "weapons/tfa_cso/starchaserar/boltpull.wav"
}
 
sound.Add(soundData)

-- KF2 Revolver
TFA.AddFireSound("TFA_KF2_DEAGLE.1", "weapons/kf2_deagle/deagle_shoot.wav", false, ")" )