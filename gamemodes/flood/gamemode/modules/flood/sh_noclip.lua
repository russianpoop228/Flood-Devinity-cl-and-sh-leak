
local plymeta = FindMetaTable("Player")
local trdata = {mins = Vector(-16,-16,0)}
function plymeta:CanUnNoclip()
	trdata.start = self:GetPos()
	trdata.endpos = trdata.start
	trdata.maxs = self:Crouching() and Vector(16,16,36) or Vector(16,16,72)
	trdata.filter = self

	local trres = util.TraceHull(trdata)
	return not trres.Hit
end

function GM:PlayerNoClip(ply)
	if not ply:Alive() then return false end -- Prevent spectators from going out of noclip

	if ply:GetMoveType() == MOVETYPE_NOCLIP then
		if (ply.nextunnocliptry or 0) > CurTime() then return false end
		ply.nextunnocliptry = CurTime() + 0.5

		if not ply:CanUnNoclip() then
			if CLIENT and ply == LocalPlayer() then
				Hint("You can't un-noclip while inside something!")
			end
			return false
		end

		return true
	end -- If he's already in noclip and wants to exit it.

	if hook.Call("FMAllowPlayerNoclip", self, ply) == true then return true end

	if ply:GetMODTier() >= RANK_DEVELOPER and (SERVER and GetServerID() or 1) == 0 then return true end -- Allow devs to noclip in TEST servers

	if not self:IsPhase(TIME_BUILD) then return false end

	if ply:GetMODTier() < RANK_MOD and ply:GetVIPTier() < VIPNoclip then return false end

	if ply:GetMODTier() < RANK_SUPERADMIN and GAMEMODE.TimeElapsed < 10 then return false end

	return true
end
