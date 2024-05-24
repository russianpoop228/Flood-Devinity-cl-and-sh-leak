
local entmeta = FindMetaTable("Entity")
function entmeta:IsProp()
	return self:GetClass() == "fm_prop"
end

function entmeta:IsDestroyable()
	return self:GetNWFloat("PropHealth", -1) != -1
end

function entmeta:GetFMHealth()
	local hp = self:GetNWFloat("PropHealth")
	if not hp or hp <= 0 then return 0 end

	return hp
end

function entmeta:GetFMMaxHealth()
	local hp = self:GetNWFloat("MaxPropHealth")
	if not hp or hp <= 0 then
		if SERVER then
			error("Max health not set")
		else
			return -1
		end
	end

	return hp
end

function entmeta:RateLimit(key, delay, errorhint)
	local id = "ratelimit_" .. key

	if self[id] then
		if self[id] + delay > SysTime() then
			if errorhint and self:IsPlayer() then
				local left = (self[id] + delay) - SysTime()
				self:HintError(string.format("Please wait %s before doing that again.", string.NiceTime(left)))
			end
			return true
		end
	end

	self[id] = SysTime()
	return false
end

local maxdist = 30
maxdist = maxdist * maxdist
function entmeta:WithinWeldRadius(ent)
	local p1 = self:NearestPoint(ent:GetPos())
	local p2 = ent:NearestPoint(p1)

	local p3 = ent:NearestPoint(self:GetPos())
	local p4 = self:NearestPoint(p3)

	local out = (p1:DistToSqr(p2) <= maxdist) or (p3:DistToSqr(p4) <= maxdist)

	return out
end

-- Will shooting this prop reward you with money?
function entmeta:FMRewardsCash()
	if not self.FMOwner or not IsValid(self:FMOwner()) then
		return false
	end

	local owner = self:FMOwner()
	if IsValid(owner:CTeam()) then
		return owner:CTeam():HasAliveMember()
	else
		return owner:Alive()
	end
end
