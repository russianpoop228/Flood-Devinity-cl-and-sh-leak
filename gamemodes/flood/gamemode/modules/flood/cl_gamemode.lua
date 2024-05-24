
net.Receive("ClearDecals", function()
	RunConsoleCommand("r_cleardecals")
	timer.Simple(0, function() RunConsoleCommand("r_cleardecals") end)
	timer.Simple(0.1, function() RunConsoleCommand("r_cleardecals") end)
end)

local hasResponded = false
net.Receive("FMTryNet", function()
	if hasResponded then return end
	hasResponded = true

	net.Start("FMTryNetResponse")
	net.SendToServer()
end)
