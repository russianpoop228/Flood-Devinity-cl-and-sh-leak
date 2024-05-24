
GM.CameraView = false

local curcamera
net.Receive("FMCameraView", function()
	curcamera = {net.ReadVector(), net.ReadAngle()}
	GAMEMODE.CameraView = true
end)

local panstartcam
local panphase1goal
local panendtime
local pandur1 = 3
local pandur2 = 1
local panphase
net.Receive("FMCameraPan", function()
	if not curcamera then GAMEMODE.CameraView = false end
	panstartcam = curcamera
	panendtime = RealTime() + pandur1
	panphase = 1
	panphase1goal = nil
end)

net.Receive("FMCameraEnd", function()
	GAMEMODE.CameraView = false
end)

-- https://github.com/kikito/tween.lua/blob/master/tween.lua
local pow = math.pow
local function inOutQuad(t, b, c, d)
	t = t / d * 2
	if t < 1 then return c / 2 * pow(t, 2) + b end
	return -c / 2 * ((t - 1) * (t - 3) - 1) + b
end

local view = {}
hook.Add("CalcView", "FMCameraView", function(ply, eyepos, eyeang, fov, znear, zfar)
	if not GAMEMODE.CameraView then return end
	if not curcamera then return end

	if panendtime then
		local spos, sang, gpos, gang, frac
		if panphase == 1 then
			frac = 1 - (panendtime - RealTime()) / pandur1
			if frac > 1 then
				panphase = 2
				panendtime = RealTime() + pandur2
			end
			frac = inOutQuad(frac, 0, 1, 1)

			if not panphase1goal then
				panphase1goal = {eyepos - eyeang:Forward() * 10, eyeang}
			end

			spos, sang = panstartcam[1], panstartcam[2]
			gpos, gang = panphase1goal[1], panphase1goal[2]

			view.drawviewer = true
		elseif panphase == 2 then
			frac = 1 - (panendtime - RealTime()) / pandur2
			if frac > 1 then
				GAMEMODE.CameraView = false
				panendtime = nil
				curcamera = nil
				return
			end
			frac = inOutQuad(frac, 0, 1, 1)

			spos, sang = panphase1goal[1], panphase1goal[2]
			gpos, gang = eyepos, eyeang

			view.drawviewer = true
		end

		view.origin = LerpVector(frac, spos, gpos)
		view.angles = LerpAngle(frac, sang, gang)
		view.fov = fov
	else
		view.origin = curcamera[1]
		view.angles = curcamera[2]
		view.fov = fov
		view.drawviewer = false
	end

	return view
end)

hook.Add("StartCommand", "FMCameraView", function(ply, cmd)
	if not GAMEMODE.CameraView then return end

	cmd:ClearMovement()
	cmd:RemoveKey(IN_ATTACK)
	cmd:RemoveKey(IN_ATTACK2)
	cmd:RemoveKey(IN_RELOAD)
	cmd:RemoveKey(IN_USE)
	cmd:RemoveKey(IN_DUCK)
	cmd:RemoveKey(IN_JUMP)
end)

hook.Add("InputMouseApply", "FMCameraView", function(cmd)
	if not GAMEMODE.CameraView then return end

	cmd:SetMouseX(0)
	cmd:SetMouseY(0)

	return true
end)

hook.Add("FMEscapeMenuClose", "FMCameraView", function()
	if GAMEMODE.CameraView then
		net.Start("FMCameraViewEnd")
		net.SendToServer()
	end
end)
