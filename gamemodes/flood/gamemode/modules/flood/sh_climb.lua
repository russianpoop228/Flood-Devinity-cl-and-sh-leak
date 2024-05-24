
local maxlen = 70 * 70
hook.Add("SetupMove", "ClimbSetupMove", function(ply, mv, cmd)
	if not GAMEMODE:GetPhase() then
		hook.Remove("SetupMove", "ClimbSetupMove")
		error("GAMEMODE:GetPhase() returns nil")
	end

	if GAMEMODE:GetPhase() < TIME_PREPARE or GAMEMODE:GetPhase() > TIME_FIGHT then return end
	if not cmd:KeyDown(IN_USE) then return end

	if ply.lastjump and ply.lastjump > CurTime() - JumpUpCooldown then return end

	local tr = ply:GetEyeTraceNoCursor()

	if not tr.Hit or not IsValid(tr.Entity) then return end
	if tr.HitPos:DistToSqr(tr.StartPos) > maxlen then return end
	if not tr.Entity:IsProp() then return end
	if not tr.Entity.FMOwner or not IsValid(tr.Entity:FMOwner()) or not tr.Entity:FMOwner():SameTeam(ply) then return end

	local _,max = tr.Entity:WorldSpaceAABB()
	local diffz = max.z - ply:GetPos().z
	if diffz < 20 or diffz > 140 then return end

	ply.lastjump = CurTime()

	mv:SetVelocity(Vector(0,0,0))
end)

hook.Add("Move", "ClimbMove", function(ply, mv)
	if not ply.lastjump or ply.lastjump < CurTime() - 0.5 then return end

	local ang = mv:GetMoveAngles()
	local pos = mv:GetOrigin()
	local vel = mv:GetVelocity()

	local spd = 0.0005 * FrameTime() * (CurTime() - ply.lastjump + 0.5)

	vel = Vector(0,0,0)

	vel = vel + Vector(0,0,1) * spd * 800000
	vel = vel + ang:Forward() * (mv:KeyDown(IN_FORWARD) and 1 or 0) * spd * 500000

	vel = vel * 0.9

	pos = pos + vel

	mv:SetVelocity(vel)
	mv:SetOrigin(pos)
end)
