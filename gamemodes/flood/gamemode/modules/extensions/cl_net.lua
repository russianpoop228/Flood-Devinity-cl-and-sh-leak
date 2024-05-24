
--[[
net.FMReadEntity(callback)
Defers reading the entity until it's actually valid on the clientside, used to fix PVS and connect issues
]]

local TIMEOUT = 20 -- How many seconds we should wait for the entity
local MAX_ATTEMPTS = TIMEOUT / 0.05
local invalidents = {}
local invalidents_cbs = {}
timer.Create("ProcessNetInvalidEnts", 0.05, 0, function()
	for id,cnt in pairs(invalidents) do
		local e = Entity(id)
		if IsValid(e) then
			invalidents[id] = nil
			invalidents_cbs[id](e)
			continue
		end

		if cnt > MAX_ATTEMPTS then
			invalidents[id] = nil
			continue
		end

		invalidents[id] = cnt + 1
	end
end)

function net.FMReadEntity(cb)
	local id = net.ReadUInt(16)
	local e = Entity(id)
	if IsValid(e) then cb(e) return end

	invalidents[id] = 0
	invalidents_cbs[id] = cb
end
