
--[[
Example

[] = optional
CreateAchievement({
	id           = "cash1",
	[name]       = "Hoboistic",
	[desc]       = "Collect $10,000",
	[icons]      = {{"money"},{"bronze_pin",{16,0},{16,16}}},
	[goal]       = 10000,
	[oncomplete] = nil,
	[req]        = {"cash0"},
	[hidden]     = false,
})
--icons:
--{icon1, icon2, icon3}
--icon -> {filename, pos (defaults to 0,0), size (defaults to 32,32)}

http://game-icons.net/
]]

CreateAchievement({
	id = "burn0",
	name = "Campfire",
	desc = "Set 50 props on fire.",
	icons = {{"fire"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 50,
})

CreateAchievement({
	id = "burn1",
	name = "Bonfire",
	desc = "Set 500 props on fire.",
	icons = {{"fire"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 500,
	req = {"burn0"},
})

CreateAchievement({
	id = "burn2",
	name = "Pyromaniac",
	desc = "Set 1,000 props on fire.",
	icons = {{"fire"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 1000,
	req = {"burn1"},
})

CreateAchievement({
	id = "cash0",
	name = "Hoboistic",
	desc = "Collect $10,000.",
	icons = {{"money"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 10000,
})

CreateAchievement({
	id = "cash1",
	name = "Lowclass",
	desc = "Collect $100,000.",
	icons = {{"money"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 100000,
	req = {"cash0"},
})

CreateAchievement({
	id = "cash2",
	name = "Dreamer",
	desc = "Collect $500,000.",
	icons = {{"money"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 500000,
	req = {"cash1"},
})

CreateAchievement({
	id = "cash4tokens",
	name = "Richie",
	desc = "Purchase 20 tokens using ingame cash.",
	icons = {{"tokens"}},
	exp = 1000,
	goal = 20,
})

CreateAchievement({
	id = "damage0",
	name = "One hole",
	desc = "Cause 5,000 damage to props.",
	icons = {{"pistol"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 5000,
})

CreateAchievement({
	id = "damage1",
	name = "Three holes",
	desc = "Cause 50,000 damage to props.",
	icons = {{"pistol"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 50000,
	req = {"damage0"},
})

CreateAchievement({
	id = "damage2",
	name = "Ninethousand holes",
	desc = "Cause 100,000 damage to props.",
	icons = {{"pistol"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 100000,
	req = {"damage1"},
})

CreateAchievement({
	id = "deathinsurance",
	name = "Death Insurance",
	desc = "Construct a 12-prop (or larger) boat that is welded to a locker, 5 times.",
	icons = {{"lockers"}},
	exp = 1000,
	goal = 5,
})

CreateAchievement({
	id = "destroy0",
	name = "Bender",
	desc = "Do the last damage on 100 props.",
	icons = {{"bomb"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 100,
})

CreateAchievement({
	id = "destroy1",
	name = "Snapper",
	desc = "Do the last damage on 1,000 props.",
	icons = {{"bomb"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 1000,
	req = {"destroy0"},
})

CreateAchievement({
	id = "destroy2",
	name = "Wrecker",
	desc = "Do the last damage on 5,000 props.",
	icons = {{"bomb"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 5000,
	req = {"destroy1"},
})

CreateAchievement({
	id = "destroybeer",
	name = "Prohibition",
	desc = "Destroy 50 beer cases.",
	icons = {{"policehat"}},
	exp = 1000,
	goal = 50,
})

CreateAchievement({
	id = "destroyhousehold",
	name = "Spring Cleaning",
	desc = "Destroy 300 household props.",
	icons = {{"shovel"}},
	exp = 1000,
	goal = 300,
})

CreateAchievement({
	id = "destroymetal",
	name = "Smelter",
	desc = "Destroy 500 metal props.",
	icons = {{"smelter"}},
	exp = 1000,
	goal = 500,
})

CreateAchievement({
	id = "destroymisc",
	name = "Junk Removal",
	desc = "Destroy 500 miscellaneous props.",
	icons = {{"box"}},
	exp = 1000,
	goal = 500,
})

CreateAchievement({
	id = "destroypallets",
	name = "Benjamin Overkill",
	desc = "Destroy 200 money pallets.",
	icons = {{"benjamin"}},
	exp = 1000,
	goal = 200,
})

CreateAchievement({
	id = "destroypaper",
	name = "Towel Safari",
	desc = "Destroy 150 paper towel rolls.",
	icons = {{"safari"}},
	exp = 1000,
	goal = 150,
})

CreateAchievement({
	id = "destroyplastbarrels",
	name = "Bareru Hakai",
	desc = "Destroy 300 plastic barrels.",
	icons = {{"barrelskull"}},
	exp = 1000,
	goal = 300,
})

CreateAchievement({
	id = "destroyplastic",
	name = "Recycle",
	desc = "Destroy 500 plastic props.",
	icons = {{"recycle"}},
	exp = 1000,
	goal = 500,
})

CreateAchievement({
	id = "destroyshelfwbow",
	name = "Magic Arrow",
	desc = "Destroy 75 bookshelves with the Compound Bow.",
	icons = {{"magicarrow"}},
	exp = 1000,
	goal = 75,
})

CreateAchievement({
	id = "destroysnowmen",
	name = "Evaporation",
	desc = "Destroy 20 snowman-related props with the Cataclysm Launcher.",
	icons = {{"snowmanmelt"}},
	exp = 1000,
	goal = 20,
})

CreateAchievement({
	id = "destroythin",
	name = "Hole Punch",
	desc = "Destroy 300 thin props.",
	icons = {{"hole"}},
	exp = 1000,
	goal = 300,
})

CreateAchievement({
	id = "destroywood",
	name = "Wood Chipper",
	desc = "Destroy 500 wooden props.",
	icons = {{"chipper"}},
	exp = 1000,
	goal = 500,
})

CreateAchievement({
	id = "drinker",
	name = "Drinker",
	desc = "Save that precious booze.",
	icons = {{"beer"}},
	exp = 1000,
	goal = 1,
})

CreateAchievement({
	id = "extinguish0",
	name = "Try-hard",
	desc = "Extinguish 5 fires.",
	icons = {{"extinguisher"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 5,
})

CreateAchievement({
	id = "extinguish1",
	name = "Firefighter",
	desc = "Extinguish 50 fires.",
	icons = {{"extinguisher"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 50,
	req = {"extinguish0"},
})

CreateAchievement({
	id = "extinguish2",
	name = "Hero",
	desc = "Extinguish 500 fires.",
	icons = {{"extinguisher"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 500,
	req = {"extinguish1"},
})

CreateAchievement({
	id = "floatingfortress",
	name = "Floating Fortress",
	desc = "Construct a boat with a minimum health value of 5,000 HP, 5 times.",
	icons = {{"ship"}},
	exp = 1000,
	goal = 5,
})

CreateAchievement({
	id = "forumpost0",
	name = "Local skid",
	desc = "Make 10 forum posts.",
	icons = {{"pencil"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 10,
	hidden = true,
	oncomplete = function(ply) hook.Run("FMForumPostAch", ply, 0) end,
})

CreateAchievement({
	id = "forumpost1",
	name = "Dedicated",
	desc = "Make 25 forum posts.",
	icons = {{"pencil"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 25,
	hidden = true,
	oncomplete = function(ply) hook.Run("FMForumPostAch", ply, 1) end,
	req = {"forumpost0"},
})

CreateAchievement({
	id = "forumpost2",
	name = "Devine",
	desc = "Make 50 forum posts.",
	icons = {{"pencil"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 50,
	hidden = true,
	oncomplete = function(ply) hook.Run("FMForumPostAch", ply, 2) end,
	req = {"forumpost1"},
})

CreateAchievement({
	id = "forumregister",
	name = "Worldwide",
	desc = "Register on the forums at Devinity.org.",
	icons = {{"world"}},
	exp = 1000,
	goal = 1,
	oncomplete = function(ply) hook.Run("FMForumRegisterAch", ply) end,
})

CreateAchievement({
	id = "frankensteincreation",
	name = "Frankenstein Creation",
	desc = "Construct a boat with a minimum of 4 props taken from each category, 10 times.",
	icons = {{"frankenstein"}},
	exp = 1000,
	goal = 10,
})

CreateAchievement({
	id = "groupjoin",
	name = "Representin'",
	desc = "Join our official Steam group.",
	icons = {{"team"}},
	exp = 1000,
	goal = 1,
	oncomplete = function(ply)
		if ply.hasgroupreward then return end
		ply.hasgroupreward = true

		ply:CreateTokenTransaction(GROUPTOKENREWARD, "Group Token Reward")
	end,
})

CreateAchievement({
	id = "halfwayraft",
	name = "Half-Way Raft",
	desc = "Construct a boat out of eight props, 10 times.",
	icons = {{"raft8"}},
	exp = 1000,
	goal = 10,
})

CreateAchievement({
	id = "killaszombie0",
	name = "Zombieee",
	desc = "Kill a player as a zombie.",
	icons = {{"zombie2"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 1,
})

CreateAchievement({
	id = "killaszombie1",
	name = "Walking Dead",
	desc = "Kill 10 players as a zombie.",
	icons = {{"zombie2"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 10,
	req = {"killaszombie0"},
})

CreateAchievement({
	id = "killzombie0",
	name = "Zombie Slayer",
	desc = "Kill 5 zombies.",
	icons = {{"zombie"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 5,
})

CreateAchievement({
	id = "killzombie1",
	name = "Survivor",
	desc = "Kill 50 zombies.",
	icons = {{"zombie"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 50,
	req = {"killzombie0"},
})

CreateAchievement({
	id = "lonewolf0",
	name = "One Man Army",
	desc = "Win a round alone.",
	icons = {{"wolf"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 1,
})

CreateAchievement({
	id = "lonewolf1",
	name = "Loner",
	desc = "Win a round alone 10 times.",
	icons = {{"wolf"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 10,
	req = {"lonewolf0"},
})

CreateAchievement({
	id = "lonewolf2",
	name = "Lone Wolf",
	desc = "Win a round alone 50 times.",
	icons = {{"wolf"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 50,
	req = {"lonewolf1"},
})

CreateAchievement({
	id = "pirate0",
	name = "Landlubber",
	desc = "Fight in 5 pirate rounds.",
	icons = {{"pirate"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 5,
})

CreateAchievement({
	id = "pirate1",
	name = "Pirate",
	desc = "Fight in 20 pirate rounds.",
	icons = {{"pirate"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 20,
	req = {"pirate0"},
})

CreateAchievement({
	id = "pirate2",
	name = "Captain Sparrow",
	desc = "Fight in 100 pirate rounds.",
	icons = {{"pirate"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 100,
	req = {"pirate1"},
})

CreateAchievement({
	id = "protectbeer",
	name = "Booze Smuggle",
	desc = "Protect 15 beer cases from being destroyed.",
	icons = {{"beercrate"}},
	exp = 1000,
	goal = 15,
})

CreateAchievement({
	id = "protectpaper",
	name = "Sneeze Guard",
	desc = "Protect 40 paper towel rolls from being destroyed.",
	icons = {{"paper"}},
	exp = 1000,
	goal = 40,
})

CreateAchievement({
	id = "rounddamage0",
	name = "Bruce Banner",
	desc = "Cause 500 damage in one round.",
	icons = {{"pistol",nil,nil,Color(0,255,0,255)},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 500,
})

CreateAchievement({
	id = "rounddamage1",
	name = "Hulk",
	desc = "Cause 2,000 damage in one round.",
	icons = {{"pistol",nil,nil,Color(0,255,0,255)},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 2000,
	req = {"rounddamage0"},
})

CreateAchievement({
	id = "rounddamage2",
	name = "Omnipotent",
	desc = "Cause 4,000 damage in one round.",
	icons = {{"pistol",nil,nil,Color(0,255,0,255)},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 4000,
	req = {"rounddamage1"},
})

CreateAchievement({
	id = "teamcreator",
	name = "Founder",
	desc = "Create a team.",
	icons = {{"team"}},
	exp = 1000,
	goal = 1,
	hidden = true,
})

CreateAchievement({
	id = "teamkicker",
	name = "Boss",
	desc = "Kick a teammember.",
	icons = {{"boot"}},
	exp = 1000,
	goal = 1,
	hidden = true,
})

CreateAchievement({
	id = "time0",
	name = "Player",
	desc = "Play for 2 hours.",
	icons = {{"time"},{"bronze_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 7200,
})

CreateAchievement({
	id = "time1",
	name = "Frequenter",
	desc = "Play for 24 hours.",
	icons = {{"time"},{"silver_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 86400,
	req = {"time0"},
})

CreateAchievement({
	id = "time2",
	name = "Supporter",
	desc = "Play for a week.",
	icons = {{"time"},{"gold_pin",{16,0},{16,16}}},
	exp = 1000,
	goal = 604800,
	req = {"time1"},
})

CreateAchievement({
	id = "toiletpaper",
	name = "That ran out fast",
	desc = "Get a toiletpaper roll destroyed within 30 seconds.",
	icons = {{"toiletpaper"}},
	exp = 1000,
	goal = 1,
	hidden = true,
})

CreateAchievement({
	id = "unweldprops",
	name = "Torn Apart",
	desc = "Un-weld 50 props.",
	icons = {{"tearingmeapart"}},
	exp = 1000,
	goal = 50,
})

CreateAchievement({
	id = "vending",
	name = "Unimaginative",
	desc = "Build a boat out of only vendingmachines.",
	icons = {{"vending"}},
	exp = 1000,
	goal = 1,
	hidden = true,
})

CreateAchievement({
	id = "wardinghy",
	name = "War Dinghy",
	desc = "Construct a boat with a minimum health value of 3,000 HP (up to 4,999 HP), 15 times.",
	icons = {{"dinghy"}},
	exp = 1000,
	goal = 15,
})

CreateAchievement({
	id = "winner",
	name = "Winner",
	desc = "Make your team win a round.",
	icons = {{"team"},{"gold_pin",{16,16},{16,16}}},
	exp = 1000,
	goal = 1,
	hidden = true,
})

CreateAchievement({
	id = "yeoldpirateship",
	name = "Ye Olde Pirate Ship",
	desc = "Construct a boat entirely out of wooden props, 10 times. Must spawn a minimum of 16 props.",
	icons = {{"pirateship"}},
	exp = 1000,
	goal = 10,
})

--[[
Christmas achievements
]]
CreateAchievement({
	id = "christmas_candycane",
	name = "Santinator",
	desc = "Spread the candy cane to 5 other players during the annual christmas event.",
	icons = {{"candycane"}},
	exp = 1000,
	goal = 5,
	hidden = not ISCHRISTMAS,
	oncomplete = function(ply) ply:GiftItem("santahat") ply:Hint("You unlocked the santa hat!") end,
})

CreateAchievement({
	id = "christmas_merry",
	name = "Ho ho ho",
	desc = "Speak the magic two words in chat.",
	icons = {{"christmas"}},
	exp = 1000,
	goal = 1,
	hidden = not ISCHRISTMAS,
})

CreateAchievement({
	id = "christmas_participate",
	name = "Merry Christmas",
	desc = "Participate in the annual christmas event.",
	icons = {{"christmas3"}},
	exp = 1000,
	goal = 1,
})

CreateAchievement({
	id = "christmas_snow",
	name = "Let it snow!",
	desc = "Crank up the winter feeling.",
	icons = {{"christmas2"}},
	exp = 1000,
	goal = 1,
	hidden = not ISCHRISTMAS,
})

--[[
Halloween achievements
]]
CreateAchievement({
	id = "halloween_participate",
	name = "Nyctophobia",
	desc = "Participate in the annual halloween event.",
	icons = {{"reaper"}},
	exp = 1000,
	goal = 1,
})

CreateAchievement({
	id = "halloween_plymdl",
	name = "Masquerade",
	desc = "Equip a halloween model during the annual halloween event.",
	icons = {{"hat"}},
	exp = 1000,
	goal = 1,
	hidden = not ISHALLOWEEN,
})

CreateAchievement({
	id = "halloween_pumpkins",
	name = "Pumpkinsoup",
	desc = "Spawn 50 pumpkins during the annual halloween event.",
	icons = {{"pumpkin"}},
	exp = 1000,
	goal = 50,
	hidden = not ISHALLOWEEN,
})

CreateAchievement({
	id = "halloween_spoopy",
	name = "Spoopy",
	desc = "Convey the spookiest creatures by chat.",
	icons = {{"skeleton"}},
	exp = 1000,
	goal = 1,
	hidden = not ISHALLOWEEN,
})

CreateAchievement({
	id = "halloween_zombieevent",
	name = "Brains!!",
	desc = "Play the zombie event during the annual halloween event.",
	icons = {{"tomb"}},
	exp = 1000,
	goal = 1,
	hidden = not ISHALLOWEEN,
})