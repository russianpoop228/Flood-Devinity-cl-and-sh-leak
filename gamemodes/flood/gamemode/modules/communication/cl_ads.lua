
local ads = {}
net.Receive("FMSendAds", function()
	for _ = 1, net.ReadUInt(8) do
		local _ = net.ReadUInt(8)
		local text = net.ReadCompressedString()
		local icon
		if net.ReadBool() then
			icon = net.ReadCompressedString()
		end

		table.insert(ads, {text = text, icon = icon or "star"})
	end
end)

local i = 0
local lastad = -1
local randomiseAdvert = true
timer.Create("doaddthing", 90, 0, function()
	if #ads == 0 then return end

	local adtosend = ""
	if randomiseAdvert then
		while true do
			local x = math.random(1,#ads)
			if x != lastad then -- Make sure we don't repeat same ad
				adtosend = ads[x]
				lastad = x
				break
			end
		end
	else
		adtosend = ads[i + 1]
		i = (i + 1) % #ads
	end

	Hint(adtosend.text, adtosend.icon)
end)
