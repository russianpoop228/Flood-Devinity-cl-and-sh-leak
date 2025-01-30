--[[

Floattranslation

]]

local floaty = {}

floaty["-3"] = "Extremely Bad"
floaty["-2"] = "Very Bad"
floaty["-1"] = "Bad"
floaty["0"]  = "Average"
floaty["1"]  = "Good"

function TranslateFloat(float)
	return floaty[tostring(float)]
end

--[[

Weapon left and rightclick underwater allowance

]]

AllowLeftClick = {

	["weapon_crowbarfm"]  = true,
	["weapon_sledgehammer"]  = true,
	["weapon_pistolfm"]  = true,
	["weapon_stunstick"]  = true,
	["weapon_harpoonfm"]  = true,
	["weapon_crossbow"]   = true,
	["weapon_physgun"]    = true,
	["weapon_physcannon"] = true,
	["gmod_tool"]         = true,
	["weapon_crowbar"]    = true,

}

AllowRightClick = {

	["weapon_harpoonfm"]   = true,
	["weapon_physgun"]     = true,
	["weapon_sledgehammer"]  = true,
	["weapon_physcannon"]  = true,
	["gmod_tool"]          = true,
	["weapon_awpfm"]       = true,
	["weapon_svufm"]       = true,
	["weapon_ak47fm"]      = true,
	["weapon_m4fm"]        = true,
	["weapon_tmpfm"]       = true,
	["weapon_galilfm"]     = true,
	["weapon_parafm"]      = true,
	["weapon_fivesevenfm"] = true,
	["weapon_deaglefm"]    = true,
	["weapon_crossbow"]    = true,
	["weapon_famasfm"]     = true,

}

--[[

Festives

]]

Gift_PopupTitle = "Yay!"
Gift_PopupMessage = "You've received a gift. You were given:"

--[[

Icon adjusting

]]

IconCoords = {

	--Store content

	["models/mymodels/fezhat.mdl"]                 = {Vector(0,0,0)   , Angle(0,-40,0)   , 20    , Color(255,0,0)},
	["models/daftpunk/ghelm.mdl"]                  = {Vector(0,0,-5)  , Angle(0,20,0)    , 20},
	["models/daftpunk/shelm.mdl"]                  = {Vector(0,0,-5)  , Angle(0,20,0)    , 20},
	["models/piratehat/piratehat2.mdl"]            = {Vector(0,0,-2)  , Angle(0,180,0)   , 30},
	["models/cloud/kn_santahat.mdl"]               = {Vector(0,0,-2)  , Angle(0,180,0)   , 30},
	["models/sinful/angel_wings.mdl"]              = {Vector(30,0,0)  , Angle(0,10,0)    , 125},

	--Weapons

	["models/weapons/w_crowbar.mdl"]               = {Vector(0,0,0)   , Angle(45,0,0)    , 50},
	["models/weapons/lordi/c_sledgehammer.mdl"]    = {Vector(-14,0,-4), Angle(-32,-4,67) , 75},

	["models/weapons/w_pistol.mdl"]                = {Vector(-1,0,1)  , Angle(0,180,0)   , 20},
	["models/weapons/w_pist_fiveseven.mdl"]        = {Vector(-3,0,-4) , Angle(0,0,0)     , 20},
	["models/weapons/w_357.mdl"]                   = {Vector(-8,0,0)  , Angle(0,0,0)     , 25},
	["models/weapons/w_pist_deagle.mdl"]           = {Vector(-4,0,-4) , Angle(0,0,0)     , 22},
	["models/goldengun.mdl"]                       = {Vector(-20,0,0) , Angle(0,0,0)     , 20},

	["models/weapons/w_smg_tmp.mdl"]               = {Vector(-8,0,-2) , Angle(0,0,0)     , 50},
	["models/weapons/w_smg1.mdl"]                  = {Vector(0,0,0)   , Angle(0,0,0)     , 35},
	["models/weapons/w_rif_m4a1.mdl"]              = {Vector(4,0,-5)  , Angle(-40,0,0)   , 50},
	["models/weapons/w_irifle.mdl"]                = {Vector(-9,0,0)  , Angle(30,0,0)    , 60},
	["models/weapons/w_rif_ak47.mdl"]              = {Vector(0,0,-8)  , Angle(-40,0,0)   , 50},
	["models/weapons/w_rif_galil.mdl"]             = {Vector(-0,0,-5) , Angle(-40,0,0)   , 50},
	["models/weapons/w_rif_famas.mdl"]             = {Vector(5,0,-5)  , Angle(-45,0,0)   , 43},

	["models/weapons/weapon_shotgun.mdl"]          = {Vector(0,0,0)   , Angle(0,0,0)     , 80},
	["models/weapons/w_shotgun.mdl"]               = {Vector(-3,0,0)  , Angle(30,0,0)    , 50},

	["models/weapons/w_snip_awp.mdl"]              = {Vector(0,0,-2)  , Angle(-45,-45,0) , 80},
	["models/weapons/w_dragunov_svu.mdl"]          = {Vector(-5,0,-8) , Angle(-40,0,0)   , 50},
	["models/weapons/w_crossbow.mdl"]              = {Vector(-10,0,0) , Angle(0,0,-30)   , 70},
	["models/weapons/w_snip_scoub.mdl"]            = {Vector(-10,0,0) , Angle(0,0,0)     , 60},

	["models/weapons/w_mach_m249para.mdl"]         = {Vector(-6,0,-5) , Angle(30,0,0)    , 60},
	["models/weapons/w_grenade.mdl"]               = {Vector(0,0,-5)  , Angle(0,0,0)     , 30},
	["models/weapons/b_bazooka_f.mdl"]             = {Vector(0,0,-3)  , Angle(0,0,-20)   , 60},
	["models/weapons/tfa_nmrih/w_exp_molotov.mdl"] = {Vector(4,0,-3)  , Angle(45,140,0)  , 20},
	["models/weapons/tfa_nmrih/w_exp_tnt.mdl"]     = {Vector(0,0,0)   , Angle(-90,90,0)  , 30},

	["models/weapons/w_c4.mdl"]                    = {Vector(0,0,0)   , Angle(40,90,0)   , 20},
	["models/weapons/w_fire_extinguisher.mdl"]     = {Vector(0,0,-18) , Angle(0,0,0)     , 70},
	["models/freeman/harpoongun.mdl"]              = {Vector(0,0,0)   , Angle(40,0,0)    , 50},
	["models/weapons/w_bugbait.mdl"]               = {Vector(0,0,0)   , Angle(0,0,0)     , 15},
	["models/weapons/w_stunbaton.mdl"]             = {Vector(0,0,0)   , Angle(45,0,0)    , 40},

}