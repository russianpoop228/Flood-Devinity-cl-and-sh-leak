BuildT   = 180 -- Time to building boats
PrepareT = 10  -- Time for getting on boats
FloodT   = 16  -- Time for water to fill
FightT   = 180 -- Time to Fight
ReflectT = 20  -- Time after fight

TeamMembersPerPlayers = 0.15 -- How many max teammembers is based on players. If 1, member limit would be 6 if serverpop was 6. If 0.5, member limit would be 3 if serverpop was 6. This is rounded up.

-- Basically a list of all tools to be seen in the qmenu.

VisibleTools = {

	"floodflag",
	"thruster",
	"weld",
	"smartwelder",
	"remover",
	"floodcannon",
	"floodmotor",
	"paint",
	"balloon",
	"rope",
	"camera",
	"trails",
	"colour",
	"light",
	"material",
	"specialprops",

}

-- What tools should be useable for everyone for everyround.

ToolsWhitelist = {

	"floodflag",
	"weld",
	"smartwelder",
	"remover",
	"floodmotor",
	"specialprops",

}

JumpUpCooldown = 3  -- How many seconds until you can attempt to jump up again

MaxThrusterForce = 100
ThrusterPrice = 150

CannonsPerPlayer = 1
CannonCost       = 0

MotorsPerPlayer = 1

FlagsPerPlayer = 2

DeathRagLifetime = 10

BugbaitRadius             = 300  -- Area of effect
BugbaitDPS                = 1    -- Damage per second it does to players
BugbaitTime               = 10   -- How long the gascloud stays for
BugbaitOnlyExplodeInWater = true -- Makes the bugbait only explode when it hits water, if it hits a prop, it dies after a few seconds.
BugbaitFriendlyFire       = true -- Can the gascloud harm teammates/yourself?

--[[

Hatschat Config

]]

--Predefined Emoticons

HatsChat_Emoticons = {

	{"???",        Material("icon32/chat/confused.png")},
	{":rolleyes:", Material("icon32/chat/rolleyes.png")},
	{":cool:",     Material("icon32/chat/cool.png")},
	{">:(",        Material("icon32/chat/mad.png")},
	{":)",         Material("icon16/emoticon_smile.png")},
	{":(",         Material("icon16/emoticon_unhappy.png")},
	{":p",         Material("icon16/emoticon_tongue.png")},
	{">:D",        Material("icon16/emoticon_evilgrin.png")},
	{":D",         Material("icon16/emoticon_grin.png")},
	{":o",         Material("icon16/emoticon_surprised.png")},
	{";)",         Material("icon16/emoticon_wink.png")},
	{":3",         Material("icon16/emoticon_waii.png")},
	{"^^",         Material("icon16/emoticon_happy.png")},
	{"<3",         Material("icon16/heart.png")},
	{":gmod:",     Material("games/16/garrysmod.png")},
	{":troll:",    Material("icon32/chat/trollface.png")},
	{"Kappa",      Material("icon32/chat/kappa.png")},
	{"Peka",       Material("icon32/chat/peka.png")},

}

--Line icons

HatsChat_LineIcons = {

}

--[[

Token stuff

]]

function TokenToUSDEquation( tokens )
	if tokens < 0 then return 0 end

	return math.Round(math.pow(tokens, 0.75) / 4, 2)
end



function CashToTokenEquation( cash )
	return cash * 1000
end



function TokenToCashEquation( tokens )
	return tokens * 2000
end

MINTOKENPURCHASE = 5 --Smallest amount of tokens you can purchase in a paypal purchase.

GROUPTOKENREWARD = 10

--[[

VIP stuff

]]

--AddVIPOnlyTool(toolname, viptier)

AddVIPOnlyTool("floodcannon" , 0)
AddVIPOnlyTool("paint"       , 1)
AddVIPOnlyTool("wheel"       , 1)
AddVIPOnlyTool("balloon"     , 1)
AddVIPOnlyTool("rope"        , 1)
AddVIPOnlyTool("camera"      , 1)
AddVIPOnlyTool("trails"      , 1)
AddVIPOnlyTool("colour"      , 1)
AddVIPOnlyTool("light"       , 2)
AddVIPOnlyTool("thruster"    , 2)
AddVIPOnlyTool("material"    , 3)

--What tier should build-noclip be available for? (0 to let everyone use it)

VIPNoclip = 2

--VipTiers, first one in list will be tier 1, fourth will be tier 4.

--Supports up to 16 tiers.

AddVIPTier("Bronze"      , Color(150,90,56))
AddVIPTier("Silver"      , Color(166,166,166))
AddVIPTier("Gold"        , Color(255,215,0))
AddVIPTier("Platinum"    , Color(122,148,162))
AddVIPTier("JR Mod"      , Color(26, 188, 156))
AddVIPTier("Moderator"   , Color(52, 152, 219))
AddVIPTier("SR Mod"      , Color(230, 126, 34))
AddVIPTier("Admin"       , Color(220, 20, 60))
AddVIPTier("Super Admin" , Color(26, 188, 156))
AddVIPTier("Founder"     , Color(148, 204, 75))

-- Admin fallback model

AdminModel = "models/player/11thdoctor/thedoctor.mdl"

--[[

WeaponStuff

]]

--Adds health to specific entities, such as cannons or thrusters

--AddEntityHealth(entname, health)

AddEntityHealth("fm_cannon", 150)
AddEntityHealth("fm_boatmotor", 300)
AddEntityHealth("fm_flag", 150)
AddEntityHealth("gmod_thruster", 50)
AddEntityHealth("gmod_light_fm", 10)

--[[

WEAPONS

]]

hook.Add("OnEntityCreated", "GiveDamageToSpecialWeapons", function(ent)
	if ent:GetClass() == "grenade_ar2" then

		ent.Damage = 15

	elseif ent:GetClass() == "crossbow_bolt" and GetWeaponData("weapon_crossbow") then

		ent.Damage = GetWeaponData("weapon_crossbow").damage
		
	end
end)

