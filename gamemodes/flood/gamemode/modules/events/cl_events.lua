
local function StartEvent(eventname, islate)
	if not EVENTS[eventname] then printError("Tried to start invalid event %q!", eventname) return end

	local event = EVENTS[eventname]
	EVENT = event

	for k,v in pairs(event.hooks) do
		hook.Add(k, eventname, v)
	end

	--islate means the player joined mid-round and wasn't here for the event start
	event:Start(islate)

	EventSystem.CurEvent = eventname

	GAMEMODE:MakeEventInfoPopup(EVENT.PrettyName, EVENT.Description)

	printInfo("%q started.", EVENT.PrettyName)
end

local function StopEvent()
	if not EventSystem.CurEvent then return end

	local event = EVENTS[EventSystem.CurEvent]
	for k, _ in pairs(event.hooks) do
		hook.Remove(k, EventSystem.CurEvent)
	end

	event:End()

	printInfo("%q ended.", event.PrettyName)

	EVENT = nil
	EventSystem.CurEvent = nil
end

net.Receive("FMStartEvent", function()
	local newevent = net.ReadString()
	local islate = net.ReadBool()

	StartEvent(newevent, islate)
end)

net.Receive("FMEndEvent", function()
	StopEvent()
end)
