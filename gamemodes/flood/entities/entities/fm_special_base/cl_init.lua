include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:IsActivated(ply)
	local lastUse = self:GetLastUse(ply)
	if not lastUse or lastUse == 0 then
		return false
	end

	local activeTime = lastUse + self.ActiveTime - CurTime()
	return activeTime > 0, activeTime
end

function ENT:GetNextUse(ply)
	local lastUse = self:GetLastUse(ply)
	if not lastUse or lastUse == 0 then
		return 0
	end

	return lastUse + self.ActiveTime + self.Cooldown
end

local maxDist = 200 * 200
local txtcol1 = HSVToColor(140, 0.63, 0.9)
hook.Add("DrawEntityInfo", "SpecialProps", function(localply, ent, drawpos)
	if not ent.IsSpecialProp then return end
	if localply:GetPos():DistToSqr(ent:GetPos()) > maxDist then return end

	local helptext
	local nextUseTimeLeft = ent:GetNextUse(localply) - CurTime()
	local isActive, activeTimeLeft = ent:IsActivated(localply)
	local phase = GAMEMODE:GetPhase()
	if isActive then
		helptext = ("Activated (%is)"):format(math.ceil(activeTimeLeft))
	elseif nextUseTimeLeft > 0 then
		helptext = ("Cooldown (%is)"):format(math.ceil(nextUseTimeLeft))
	elseif ent:IsAllowedPhase(phase) and ent:WaterLevel() < 2 and localply:SameTeam(ent:FMOwner()) then
		helptext = ("Press %s to activate!"):format(GetKeyName("use"))
	else
		helptext = ""
	end

	draw.SimpleTextOutlined(ent.PrintName, "FMRegular26", drawpos.x - 1, drawpos.y + 80, txtcol1, 1, 1, 2, FMCOLORS.bg)
	draw.SimpleTextOutlined(helptext, "FMRegular26", drawpos.x - 1, drawpos.y + 110, txtcol1, 1, 1, 2, FMCOLORS.bg)
end)