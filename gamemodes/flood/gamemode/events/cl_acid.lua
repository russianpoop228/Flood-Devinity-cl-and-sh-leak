
local waterent
local wateroffset
local mat = Material("water/acid")
EVENT.hooks.PostDrawOpaqueRenderables = function()
	if not waterent then
		local w = {}
		table.Add(w, ents.FindByClass("func_water_analog"))
		waterent = w[1]
		if not waterent then error("Couldn't find water") end

		for i = 1, waterent:GetBrushPlaneCount() do
			local _, direction, distance = waterent:GetBrushPlane(i)
			if direction == Vector(0, 0, 1) then
				wateroffset = distance
				break
			end
		end
	end

	local pos = waterent:GetPos() + Vector(0, 0, wateroffset)

	render.SetMaterial(mat)
	render.DrawQuadEasy(pos, Vector(0, 0, 1), 20000, 20000, Color(255, 255, 255), 0)
end

EVENT.hooks.FMDrawPlayerFishes = function(ply)
	return false
end
