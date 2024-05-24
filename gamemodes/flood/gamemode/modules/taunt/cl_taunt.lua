
local temp = {}
hook.Add("CalcView", "CalcViewTaunt", function(ply, view, angle, fov)
	local client = LocalPlayer()
	if not client.TauntCam then
		client.TauntCam = TauntCamera()
	end
	temp = {
		angles = angle,
		origin = view,
		fov = 100
	}
	if client.TauntCam:CalcView(temp, client, client:IsPlayingTaunt()) then
		view = temp.origin
		angle = view.angles
		fov = 100
		return GAMEMODE:CalcView( ply, temp.origin, temp.angles, fov )
	end
end)

hook.Add("ShouldDrawLocalPlayer", "ShouldDrawLocalTaunt", function()
	local client = LocalPlayer()
	if not client.TauntCam then
		client.TauntCam = TauntCamera()
	end
	if client.TauntCam:ShouldDrawLocalPlayer(client, client:IsPlayingTaunt()) then
		return true
	end
end)

hook.Add("CreateMove", "CreateMoveTaunt", function(command)
	local client = LocalPlayer()
	if not client.TauntCam then
		client.TauntCam = TauntCamera()
	end
	if client.TauntCam:CreateMove(command, client, client:IsPlayingTaunt()) then
		return GAMEMODE:CreateMove(command)
	end
end)
