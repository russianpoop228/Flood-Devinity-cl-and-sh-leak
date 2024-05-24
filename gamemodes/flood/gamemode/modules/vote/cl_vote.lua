
local timersec = 0
local votesw = 0
local curvote
net.Receive("FMStartVote", function()
	local reqvotes = net.ReadUInt(7)
	local text = net.ReadString()
	local id = net.ReadUInt(4)

	text = "Vote: " .. text

	curvote = {votes = 0}

	surface.SetFont("FMRegular24")
	local w,h = surface.GetTextSize(text)
	curvote.w = w + 10
	curvote.h = h

	curvote.text = text
	curvote.req = reqvotes
	curvote.id = id

	timersec = 30
	timer.Create("votecountdown", 1, 30, function()
		timersec = timersec - 1
	end)

	timer.Create("votetimer", 30, 1, function()
		curvote = nil
	end)

	surface.SetFont("FMRegular24")
	votesw = surface.GetTextSize(string.format("Votes: %i/%i", curvote.votes, curvote.req))
	votesw = votesw/2
end)

net.Receive("FMSendVoteData", function()
	local votes = net.ReadUInt(7)
	if not curvote or votes >= curvote.req then
		curvote = nil
		timer.Destroy("votetimer")
		return
	end

	curvote.votes = votes

	surface.SetFont("FMRegular24")
	votesw = surface.GetTextSize(string.format("Votes: %i/%i", curvote.votes, curvote.req))
	votesw = votesw/2
end)

local w = ScrW()
local halfw = w/2
hook.Add("HUDPaint", "DrawVoteMenu", function()
	if curvote then
		local x = halfw - curvote.w/2

		local tall = 46 + curvote.h

		local showdead = false
		for _,v in pairs(VOTES) do
			if v.id == curvote.id then
				if v.deadcantvote and not LocalPlayer():Alive() then
					showdead = true
					tall = tall + 12 + 3
				end
			end
		end

		surface.SetDrawColor(FMCOLORS.bg)
		surface.DrawRect(x, 0, curvote.w + 10, tall)

		surface.SetDrawColor(Color(80,80,80,255))
		surface.DrawRect(x + curvote.w + 3, 3, 4, tall-6)

		local votetall = math.Clamp((curvote.votes / curvote.req) * tall, 2, tall)
		surface.SetDrawColor(FMCOLORS.txt)
		surface.DrawRect(x + curvote.w + 3, 3 + (tall - votetall - 6), 4, votetall)

		local y = 3
		for k,v in pairs(string.Explode("\n", curvote.text)) do
			draw.SimpleText(v, "FMRegular24", x + 5, y, FMCOLORS.txt, 0, 0)
			y = y + 22 + 3
		end

		draw.SimpleText(string.format("Votes: %i/%i", curvote.votes, curvote.req), "FMRegular24", halfw - votesw, y, FMCOLORS.txt, 0, 0)
		y = y + 22 + 3

		draw.SimpleText("Press F3 to vote up", "Default", halfw - 48.5, y, FMCOLORS.txt, 0, 0)
		draw.SimpleText(tostring(timersec), "Default", x + curvote.w, y, Color(160,160,160,255), TEXT_ALIGN_RIGHT, 0)

		y = y + 12 + 3
		if showdead then
			draw.SimpleText("You can't vote right now.", "Default", halfw - 63.5, y, FMCOLORS.txt, 0, 0)
		end
	end
end)
