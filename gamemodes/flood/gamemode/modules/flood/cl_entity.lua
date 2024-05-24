
local entmeta = FindMetaTable("Entity")

OLDENTREMOVE = OLDENTREMOVE or entmeta.Remove
function entmeta:Remove()
	if self:EntIndex() != -1 then
		error("Tried to remove serverside ent " .. self:EntIndex() .. " : " .. self:GetClass() .. " on client!")
	end

	OLDENTREMOVE(self)
end
