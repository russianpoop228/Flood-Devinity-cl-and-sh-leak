
--[[
Font creation
]]
do
	local t = {
		font = "Arimo",--"bebasneue"
		--weight = 900
	}
	for i = 16,50,2 do
		t.size = i
		t.weight = 500
		if i == 22 then
			t.weight = 300
		end
		surface.CreateFont("FMRegular" .. i, t)
		t.italic = true
		surface.CreateFont("FMRegular" .. i .. "i", t)
		t.italic = nil
	end
end

include("shared.lua")
include("modules.lua")

--[[
Gather current time
]]
function GM:Initialize()
	self.TimeElapsed = 0
	self.TimeCounter = 0
	self.PhaseType = TIME_BUILD
	self.WaitForPhaseInit = true
end

function GM:GetPhase()
	return self.PhaseType
end

function GM:IsPhase(t)
	return self.PhaseType == t
end

function GM:GetTime()
	return self.TimeCounter
end

function GM:TimerUpdate(new)
	self.TimeCounter = new
	self.TimeElapsed = self.TimeElapsed + 1
end

function GM:PhaseUpdate(new)
	local old = self.PhaseType

	self.PhaseType = new

	if self.WaitForPhaseInit then
		self.WaitForPhaseInit = nil
		return
	end

	hook.Run("FMOnChangePhase", old, new)
end

net.Receive("FMTimeLeft", function()
	GAMEMODE:TimerUpdate(net.ReadUInt(16))
end)

net.Receive("FMGetPhaseType", function()
	GAMEMODE:PhaseUpdate(net.ReadUInt(6))
end)

hook.Add("FMOnChangePhase", "General", function(old,new)
	GAMEMODE.TimeElapsed = 0
end)

--[[
Quality slider
]]

local qualityconvar = CreateClientConVar("fm_quality", 1, true, false)

QUALITY = qualityconvar:GetFloat()
cvars.AddChangeCallback("fm_quality", function(_,_, newvalue)
	QUALITY = tonumber(newvalue)
	if not QUALITY then
		RunConsoleCommand("fm_quality","1")
	end
end)

AddSettingsItem("quality", "slider", "fm_quality", {lbl = "Particle Quality", min = 0.2, max = 2, decimals = 1})

--[[
Config
]]

include("config.lua")
include("cl_config.lua")



--Overriding any old hudpaint the base gamemode may have. I use hooks to call my hud, which makes it easier to reload the file.
function GM:HUDPaint()
	self:PaintWorldTips() -- Draws AddWorldTip's (used by cannon)
end

--Overriden to support spectators
function GM:HUDShouldDraw( name )
	if not LocalPlayer().GetSpectatingPlayer then return true end

	-- Allow the weapon to override this
	local ply = IsValid(LocalPlayer():GetSpectatingPlayer()) and LocalPlayer():GetSpectatingPlayer() or LocalPlayer()
	if ( IsValid( ply ) ) then

		local wep = ply:GetActiveWeapon()

		if ( IsValid( wep ) && wep.HUDShouldDraw != nil ) then

			return wep.HUDShouldDraw( wep, name )

		end

	end

	return true

end
