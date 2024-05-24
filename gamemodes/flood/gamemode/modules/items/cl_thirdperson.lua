
hook.Add("CreateMove", "ShowThirdperson", function(mv)
	local ply = LocalPlayer()

	if ply.showthirdperson then
		local btndown = mv:GetButtons() > 0
		if btndown then
			ply.showthirdperson = nil
		end
		mv:ClearMovement()
		return
	end
end)

local view = {}
local dist = 100
hook.Add("CalcView", "ShowThirdperson", function(ply, origin, angles, fov)
	if ply.showthirdperson then
		local headpos = ply:GetPos() + Vector(0,0,60)

		local aimang = ply:EyeAngles()
		aimang.y = 0
		local pos = headpos - ((aimang:Forward()) * dist)
		local ang = (headpos - pos):Angle()

		--Do a traceline so he can't see through walls
		local trdata = {}
		trdata.start = headpos
		trdata.endpos = pos
		trdata.filter = ply
		local trres = util.TraceLine(trdata)
		if trres.Hit then
			pos = trres.HitPos + (trres.HitWorld and trres.HitNormal * 3 or vector_origin)
		end

		view.origin = pos
		view.angles = ang

		return view
	end
end)

hook.Add("ShouldDrawLocalPlayer", "ShowThirdperson", function(ply)
	if ply.showthirdperson then
		return true
	end
end)

local val = 0
hook.Add("HUDPaint", "ShowThirdperson", function()
	if LocalPlayer().showthirdperson then
		val = val + FrameTime() * 5
		draw.SimpleText("Press any button to exit.", "TargetID", ScrW() / 2, ScrH() / 4 + 15, HSVToColor(0, 1, math.sin(val) * 0.25 + 0.75), 1)
	end
end)
