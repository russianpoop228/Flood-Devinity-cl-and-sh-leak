
EVENTS = EVENTS or {} -- List of event tables, id keys
EVENTSLIST = EVENTSLIST or {} -- Sequential list of event ids
EventSystem = EventSystem or { -- Holds variables for the event system
	CanStartEvent = true,
	CurEvent = nil,
	HasPreparedForEvent = false,
	PrepareEvent = nil,
	PrepareEventForce = nil,
}

local function LoadEvent(eventname)
	local FolderName = (GAMEMODE or GM).FolderName .. "/gamemode/events"

	EVENT = {
		id = eventname,
		hooks = {},
		Start = function() end,
		End = function() end,
		GetChance = function(self)
			local override = hook.Run("FMOverrideEventChance", self)
			if isnumber(override) then
				return override
			end
			return self.Chance
		end
	}

	local f
	f = FolderName .. "/sh_" .. eventname .. ".lua"
	if file.Exists(f, "LUA") then
		include(f)
		if SERVER then
			AddCSLuaFile(f)
		end
	end

	if SERVER then
		f = FolderName .. "/sv_" .. eventname .. ".lua"
		if file.Exists(f, "LUA") then
			include(f)
		end
	end

	f = FolderName .. "/cl_" .. eventname .. ".lua"
	if file.Exists(f, "LUA") then
		if SERVER then
			AddCSLuaFile(f)
		else
			include(f)
		end
	end

	if not EVENTS[eventname] then
		-- Event not loaded yet, load it from scratch

		EVENTS[eventname] = EVENT
		table.insert(EVENTSLIST, eventname)
	else
		-- Reloading the event, only update it's Start, End and hooks

		-- Remove existing hooks
		local OldEventTbl = EVENTS[eventname]
		if EventSystem.CurEvent == eventname then
			for k, _ in pairs(OldEventTbl.hooks) do
				hook.Remove(k, eventname)
			end
		end

		-- Add the new event tbl
		EVENTS[eventname] = EVENT

		-- Move over variables
		for k, v in pairs(OldEventTbl) do
			if not EVENT[k] then
				EVENT[k] = v
			end
		end

		-- Hook the new hooks
		if EventSystem.CurEvent == eventname then
			for k, v in pairs(EVENT.hooks) do
				hook.Add(k, eventname, v)
			end
		end
	end

	EVENT = nil -- Prevent us from getting info from this because we shouldn't anyways.

	if EventSystem.CurEvent then
		EVENT = EVENTS[EventSystem.CurEvent]
	end
end

local function LoadEvents()
	local files,_ = file.Find(GM.FolderName .. "/gamemode/events/*.lua", "LUA")
	for _, v in pairs(files) do
		local eventname = string.match(v, "_(%w+)%.lua")

		if EVENTS[eventname] then continue end
		LoadEvent(eventname)
	end
end
LoadEvents()

local function ReloadEvents()
	for _, v in pairs(EVENTSLIST) do
		LoadEvent(v)
	end
end

function IsEventRunning()
	return EventSystem.CurEvent != nil
end

function CurrentEventTable()
	return EVENTS[EventSystem.CurEvent]
end

function CurrentEvent()
	return EventSystem.CurEvent
end

hook.Add("FMOnReloaded", "ReloadEvents", function()
	ReloadEvents()
end)
