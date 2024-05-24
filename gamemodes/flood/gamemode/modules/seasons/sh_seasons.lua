
local seasons = {}
local function registerSeason(name, query)
	local t = {
		query = query,
	}

	local inc = {}
	local send = {}

	local folder = (GM or GAMEMODE).FolderName
	local files, _ = file.Find(folder .. "/gamemode/modules/seasons/" .. name .. "/*.lua", "LUA")
	for _, f in pairs(files) do
		local iscl = f:match("^cl_") != nil
		local issh = f:match("^sh_") != nil
		local issv = f:match("^sv_") != nil

		local fullpath = string.format("%s/gamemode/modules/seasons/%s/%s", folder, name, f)
		if SERVER then
			if issv or issh then
				table.insert(inc, fullpath)
			end
			if iscl or issh then
				table.insert(send, fullpath)
			end
		else
			if iscl or issh then
				table.insert(inc, fullpath)
			end
		end
	end

	t.inc = inc
	t.send = send

	seasons[name] = t
end

local force
local function getForced()
	if force != nil then return force end
	if file.Exists("flood_forceevent.txt", "DATA") then
		force = file.Read("flood_forceevent.txt", "DATA")
	end

	return force
end

local function isDisabled()
	return getForced() == "" -- Disable seasons with an empty file
end

local function loadSeasons()
	if isDisabled() then return end
	for season, t in pairs(seasons) do
		local shouldForce = getForced() and season == getForced()
		if getForced() and not shouldForce then continue end
		
		local on = t.query()
		if not on and not shouldForce then continue end

		t.on = true
		t.forced = shouldForce

		printInfo("Loaded season %q%s", season, shouldForce and " [FORCED]" or "")

		for _, path in pairs(t.inc) do
			include(path)
		end

		for _, path in pairs(t.send) do
			AddCSLuaFile(path)
		end
	end
end

local function testSeasons()
	if isDisabled() then return end
	for season, t in pairs(seasons) do
		local currentlyOn = t.on
		local shouldBeOn = t.query()

		if currentlyOn and t.forced then continue end

		if currentlyOn and not shouldBeOn then
			t.on = false -- Prevent spam
			LogFile(("Season \"%s\" has now ended, queueing update!"):format(season))
		elseif not currentlyOn and shouldBeOn then
			t.on = true -- Prevent spam
			LogFile(("Season \"%s\" is now live, queueing update!"):format(season))
		else
			continue
		end

		GAMEMODE:QueueUpdate()
	end
end

registerSeason("halloween", function()
	local now = os.date("!*t")
	return (now.month == 10 and now.day > 10)
		or (now.month == 11 and now.day < 4)
end)

registerSeason("christmas", function()
	local now = os.date("!*t")
	return (now.month == 12 and now.day > 4)
		or (now.month == 12 and now.day < 27)
end)

registerSeason("summer", function()
	local now = os.date("!*t")
	return (now.month == 6 and now.day > 20)
		or (now.month == 7)
		or (now.month == 8 and now.day < 24)
end)

loadSeasons()

if SERVER then
	timer.Create("FMCheckForSeason", 60, 0, function()
		testSeasons()
	end)
end
