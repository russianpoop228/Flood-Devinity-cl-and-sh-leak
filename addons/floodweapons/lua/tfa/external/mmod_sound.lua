local path = "weapons/tfa_mmod/pistol/"
local pref = "TFA_MMOD.USP"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref .. ".1", path .. "player_pistol_fire1.wav", "player_pistol_fire2.wav", "player_pistol_fire3.wav", false, ")")

TFA.AddWeaponSound(pref .. ".Draw", path .. "pistol_deploy.wav")
TFA.AddWeaponSound(pref .. ".SlideRelease", path .. "pistol_sliderelease.wav")
TFA.AddWeaponSound(pref .. ".SlidePull", path .. "pistol_slidepull.wav")
TFA.AddWeaponSound(pref .. ".ClipOut", path .. "pistol_ClipOut.wav")
TFA.AddWeaponSound(pref .. ".ClipIn", path .. "pistol_Clipin.wav")

local path1 = "weapons/tfa_mmod/movement/"
local pref1 = "TFA_MMOD.Generic"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddWeaponSound(pref1 .. ".Movement1", path1 .. "weapon_movement1.wav")
TFA.AddWeaponSound(pref1 .. ".Movement2", path1 .. "weapon_movement2.wav")
TFA.AddWeaponSound(pref1 .. ".Movement3", path1 .. "weapon_movement3.wav")
TFA.AddWeaponSound(pref1 .. ".Movement4", path1 .. "weapon_movement4.wav")
TFA.AddWeaponSound(pref1 .. ".Movement5", path1 .. "weapon_movement5.wav")
TFA.AddWeaponSound(pref1 .. ".Movement6", path1 .. "weapon_movement6.wav")

local path2 = "weapons/tfa_mmod/crossbow/"
local pref2 = "TFA_MMOD.Crossbow"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref2 .. ".1", path2 .. "fire1.wav", false, ")")

TFA.AddWeaponSound(pref2 .. ".BoltElectrify", path2 .. "bolt_load1.wav", "bolt_load2")
TFA.AddWeaponSound(pref2 .. ".DrawBack", path2 .. "crossbow_draw.wav")
TFA.AddWeaponSound(pref2 .. ".Draw", path2 .. "crossbow_deploy.wav")
TFA.AddWeaponSound(pref2 .. ".Lens", path2 .. "crossbow_lens.wav")
TFA.AddWeaponSound(pref2 .. ".String", path2 .. "crossbow_string.wav")

local path3 = "weapons/tfa_mmod/ar3/"
local pref3 = "TFA_MMOD.AR3"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref3 .. ".1", path3 .. "ar3_fire1.wav", "ar3_fire2.wav", "ar3_fire3.wav", false, ")")

TFA.AddWeaponSound(pref3 .. ".Draw", path3 .. "ar3_deploy.wav")
TFA.AddWeaponSound(pref3 .. ".Pump", path3 .. "ar3_pump.wav")
TFA.AddWeaponSound(pref3 .. ".Fidget", path3 .. "ar3_fidget.wav")
TFA.AddWeaponSound(pref3 .. ".Barrel_Open", path3 .. "ar3_barrel_open.wav")
TFA.AddWeaponSound(pref3 .. ".Barrel_Close", path3 .. "ar3_barrel_close.wav")

local path4 = "weapons/tfa_mmod/shotgun/"
local pref4 = "TFA_MMOD.Shotgun"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref4 .. ".1", path4 .. "shotgun_fire.wav", false, ")")
TFA.AddFireSound(pref4 .. ".2", path4 .. "shotgun_dbl_fire.wav", false, ")")

TFA.AddWeaponSound(pref4 .. ".Draw", path4 .. "shotgun_deploy.wav")
TFA.AddWeaponSound(pref4 .. ".Cock_Back", path4 .. "shotgun_cock_back.wav")
TFA.AddWeaponSound(pref4 .. ".Cock_Forward", path4 .. "shotgun_cock_forward.wav")
TFA.AddWeaponSound(pref4 .. ".Insert", path4 .. "shotgun_reload1.wav", "shotgun_reload2.wav", "shotgun_reload3.wav", "shotgun_reload4.wav", "shotgun_reload5.wav", "shotgun_reload6.wav")

local path5 = "weapons/tfa_mmod/rpg/"
local pref5 = "TFA_MMOD.RPG"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref5 .. ".1", path5 .. "rocketfire1.wav", false, ")")

TFA.AddWeaponSound(pref5 .. ".Draw", path5 .. "rpg_deploy.wav")
TFA.AddWeaponSound(pref5 .. ".Loop", path5 .. "rocket1.wav")
TFA.AddWeaponSound(pref5 .. ".Button", path5 .. "rpg_button.wav")
TFA.AddWeaponSound(pref5 .. ".Pet1", path5 .. "rpg_pet1.wav")
TFA.AddWeaponSound(pref5 .. ".Pet2", path5 .. "rpg_pet2.wav")
TFA.AddWeaponSound(pref5 .. ".Insert", path5 .. "rpg_reload1.wav")
TFA.AddWeaponSound(pref5 .. ".Inspect", path5 .. "rpg_fidget.wav")

local path6 = "weapons/tfa_mmod/357/"
local pref6 = "TFA_MMOD.357"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref6 .. ".1", path6 .. "357_fire1.wav", "357_fire2.wav", "357_fire3.wav", false, ")")

TFA.AddWeaponSound(pref6 .. ".Draw", path6 .. "357_deploy.wav")
TFA.AddWeaponSound(pref6 .. ".Fidget_Spinner", path6 .. "357_spin2.wav")
TFA.AddWeaponSound(pref6 .. ".OpenLoader", path6 .. "357_reload1.wav")
TFA.AddWeaponSound(pref6 .. ".Spin", path6 .. "357_spin1.wav")
TFA.AddWeaponSound(pref6 .. ".RemoveLoader", path6 .. "357_reload2.wav")
TFA.AddWeaponSound(pref6 .. ".ReplaceLoader", path6 .. "357_reload3.wav")
TFA.AddWeaponSound(pref6 .. ".CloseLoader", path6 .. "357_reload4.wav")
TFA.AddWeaponSound(pref6 .. ".Hammer_Pull", path6 .. "357_hammerpull.wav")
TFA.AddWeaponSound(pref6 .. ".Hammer_Release", path6 .. "357_hammerrelease.wav")

local path7 = "weapons/tfa_mmod/ar2/"
local pref7 = "TFA_MMOD.AR2"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref7 .. ".1", path7 .. "fire1.wav", "fire2.wav", "fire3.wav", false, ")")
TFA.AddFireSound(pref7 .. ".2", path7 .. "ar2_secondary_fire.wav", false, ")")

TFA.AddWeaponSound(pref7 .. ".Draw", path7 .. "ar2_deploy.wav")
TFA.AddWeaponSound(pref7 .. ".Charge", path7 .. "ar2_charge_beep.wav")
TFA.AddWeaponSound(pref7 .. ".FidgetPush", path7 .. "ar2_push.wav")
TFA.AddWeaponSound(pref7 .. ".FidgetRotate", path7 .. "ar2_rotate.wav")
TFA.AddWeaponSound(pref7 .. ".BoltPull", path7 .. "ar2_boltpull.wav")
TFA.AddWeaponSound(pref7 .. ".Reload_Rotate", path7 .. "ar2_reload_rotate.wav")
TFA.AddWeaponSound(pref7 .. ".Reload_Push", path7 .. "ar2_reload_push.wav")
TFA.AddWeaponSound(pref7 .. ".MagOut", path7 .. "ar2_magout.wav")
TFA.AddWeaponSound(pref7 .. ".Magin", path7 .. "ar2_magin.wav")

local path8 = "weapons/tfa_mmod/smg1/"
local pref8 = "TFA_MMOD.SMG1"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref8 .. ".1", path8 .. "smg1_fire1.wav", "smg1_fire2.wav", "smg1_fire3.wav")
TFA.AddFireSound(pref8 .. ".2", path8 .. "smg1_glauncher.wav", false, ")")

TFA.AddWeaponSound(pref8 .. ".Draw", path8 .. "smg1_deploy.wav")
TFA.AddWeaponSound(pref8 .. ".ClipOut", path8 .. "smg1_clipout.wav")
TFA.AddWeaponSound(pref8 .. ".ClipIn", path8 .. "smg1_clipin.wav")
TFA.AddWeaponSound(pref8 .. ".ClipHit", path8 .. "smg1_cliphit.wav")
TFA.AddWeaponSound(pref8 .. ".BoltBack", path8 .. "smg1_boltback.wav")
TFA.AddWeaponSound(pref8 .. ".BoltForward", path8 .. "smg1_boltforward.wav")
TFA.AddWeaponSound(pref8 .. ".GripFold", path8 .. "smg1_gripfold.wav")
TFA.AddWeaponSound(pref8 .. ".GripUnfold", path8 .. "smg1_gripunfold.wav")

local path9 = "weapons/tfa_mmod/crowbar/"
local pref9 = "TFA_MMOD.Crowbar"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref9 .. ".1", path9 .. "crowbar_swing1.wav", "crowbar_swing2.wav", "crowbar_swing3.wav", false, ")")

TFA.AddWeaponSound(pref9 .. ".Draw", path9 .. "crowbar_deploy.wav")

local path10 = "weapons/tfa_mmod/stunstick/"
local pref10 = "TFA_MMOD.StunStick"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddFireSound(pref10 .. ".1", path10 .. "stunstick_swing1.wav", "stunstick_swing2.wav", "stunstick_swing3.wav", false, ")")

TFA.AddWeaponSound(pref10 .. ".Draw", path10 .. "crowbar_deploy.wav")
TFA.AddWeaponSound(pref10 .. ".HitWall", path10 .. "stunstick_impact1.wav", "stunstick_impact2.wav", "stunstick_impact3.wav")
TFA.AddWeaponSound(pref10 .. ".Hit", path10 .. "stunstick_fleshhit1.wav", "stunstick_fleshhit2.wav", "stunstick_fleshhit3.wav")

local path11 = "weapons/tfa_mmod/grenade/"
local pref11 = "TFA_MMOD.Grenade"
local hudcolor = Color(255, 80, 0, 191)

TFA.AddWeaponSound(pref11 .. ".Ready", path11 .. "grenade_ready.wav")
TFA.AddWeaponSound(pref11 .. ".Throw", path11 .. "grenade_throw.wav")
TFA.AddWeaponSound(pref11 .. ".Roll", path11 .. "grenade_lob.wav")
TFA.AddWeaponSound(pref11 .. ".Pull", path11 .. "pin_pull.wav")

TFA.AddAmmo("pheropod", "Pheropod")

function VectorNormalize( v )
	local l = v:Length();
	if (l != 0.0) then
		v = v / l;
	else
		// FIXME:
		// Just copying the existing implemenation; shouldn't res.z == 0?
		v.x = 0.0;
		v.y = 0.0; v.z = 1.0;
	end
	return v;
end

function CrossProduct(a, b)
	return Vector( a.y*b.z - a.z*b.y, a.z*b.x - a.x*b.z, a.x*b.y - a.y*b.x );
end