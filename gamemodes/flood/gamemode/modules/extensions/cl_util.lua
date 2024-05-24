
--[[
util.WaitForLocalPlayer(callback)
Runs the callback whenever LocalPlayer() becomes available
]]

local lpwaits = {}
function util.WaitForLocalPlayer(cb)
	if IsValid(LocalPlayer()) then
		util.WaitForLocalPlayer = function(_cb) _cb() end -- Redefine this function for speed
		cb()
	else
		lpwaits[#lpwaits + 1] = cb
	end
end

hook.Add("Think", "FloodWaitForLocalPlayer", function()
	if IsValid(LocalPlayer()) then
		for _, cb in pairs(lpwaits) do
			cb()
		end
		lpwaits = {}
		hook.Remove("Think", "FloodWaitForLocalPlayer")
	end
end)
