

local mat = Material("fm/swirl.png")
EVENT.hooks.PostDrawTranslucentRenderables = function()
	if not GAMEMODE:IsPhase(TIME_FIGHT) or GAMEMODE.TimeElapsed < EVENT.VortexStart then return end

	local drawpos = Vector(0, 0, 771) + EVENT.VortexPos

	render.SetMaterial(mat)
	render.DrawQuadEasy(drawpos, vector_up, 1024, 1024, Color(255, 255, 255, 100), CurTime() * -20)
end
