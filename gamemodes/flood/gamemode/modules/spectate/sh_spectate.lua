
local plymeta = FindMetaTable("Player")
function plymeta:GetSpectators()
	local t = {}
	for _, v in pairs(player.GetAll()) do
		if v != self and not v:Alive() and v:GetSpectatingPlayer() == self then
			table.insert(t, v)
		end
	end
	return t
end

function plymeta:GetSpectatingPlayer()
	if self:Alive() then return end

	return self:GetObserverTarget()
end

function plymeta:GetSpectatingMode()
	return self:GetObserverMode()
end
