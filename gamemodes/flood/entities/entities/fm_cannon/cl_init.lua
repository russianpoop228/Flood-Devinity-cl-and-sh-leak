include("shared.lua")
--Calculate renderbounds, if the view goes out of the renderbounds the trace won't be drawn.--We need to calculate this because if the player doesn't look at the cannon, but still sees the trace it will be invisible
function ENT:ComputeRenderBounds()
	local min = self:LocalToWorld(Vector(-1000,-1000,-1000))
	local max = self:LocalToWorld(Vector(1000,1000,1000))

	for k,v in pairs(self.pathdata) do
		local vec = self:WorldToLocal(v)
		min.x = math.min(min.x, vec.x)
		min.y = math.min(min.y, vec.y)
		min.z = math.min(min.z, vec.z)

		max.x = math.max(max.x, vec.x)
		max.y = math.max(max.y, vec.y)
		max.z = math.max(max.z, vec.z)
	end

	self:SetRenderBounds(min,max)
end

local sharpness = 4-- An increased sharpness reduces the amount of "folds" on the line, more traces, but prettier line.
function ENT:CalculatePath(startpos, dir)
	local ang = self:GetAngles()

	local vel = self:GetEscapeVelocity() * dir / 4.2--4.2 is some stupid value I managed to find out.
	local pstart = startpos
	local pend

	local trdata = {}
	local pathdata = {}

	local filter = ents.FindByClass("fm_cannonball")
	table.insert(filter, self)
	trdata.filter = filter

	table.insert(pathdata, pstart)
	for i=1,1000 do-- Ideally we wouldn't want to hit 1000, but this is just to prevent infinite loops
		pend = pstart + (vel / sharpness)
		vel = vel - Vector(0,0,9.82) * (3.5 / sharpness)-- 3.5 is another stupid value I managed to find out

		trdata.start = pstart
		trdata.endpos = pend
		local tr = util.TraceLine(trdata)
		if tr.Hit then
			table.insert(pathdata, tr.HitPos)
			break
		end

		if bit.band(util.PointContents(pend), CONTENTS_WATER) > 0 then-- If the point is underwater, we'll stop
		--I cast this extra trace because adding mask to traces causes a HUGE amount of lag, hereby we only cast one trace with a mask.
			trdata.mask = bit.bnot(CONTENTS_WATER)
			local tr = util.TraceLine(trdata)
			if tr.Hit then-- If we hit the water, as we wanted, we add the hitpos instead and we get a perfect water-hitpos
				table.insert(pathdata, tr.HitPos)
				break
			end

			table.insert(pathdata, pend)
			break
		end

		table.insert(pathdata, pend)

		pstart = pend
	end

	self.pathdata = pathdata
	self:ComputeRenderBounds()
end

local tracemat = Material( "fm/cannontrace" )
local hitmat = Material( "fm/hitmarker" )
function ENT:DrawPath(startpos, dir)
	self:CalculatePath(startpos, dir)

	render.SetMaterial(tracemat)
	render.StartBeam(#self.pathdata)
		for k,v in ipairs(self.pathdata) do
			render.AddBeam(v, 8, k - CurTime() * 4, Color(255,255,255,255))
		end
	render.EndBeam()

	local hitvec = self.pathdata[#self.pathdata] + Vector(0,0,1)
	render.SetMaterial(hitmat)
	render.DrawQuadEasy(hitvec, Vector(0,0,1), 256, 256, Color(255,255,255,255), CurTime() * 40)
end

function ENT:Draw()

	local ang = self:LocalToWorldAngles(self.locang)
	local basepos = self:LocalToWorld(Vector(-120, 0, 0))

	local renderorig = ang:Forward() * 120 + basepos

	if self:GetPossessor() == LocalPlayer() then
		self:DrawPath(renderorig, ang:Forward())
	end

	self.can:SetRenderOrigin(renderorig)
	self.can:SetRenderAngles(ang)
	self.can:DrawModel()

	self.canbase:SetRenderOrigin(basepos)
	self.canbase:SetRenderAngles(Angle(self:GetAngles().p,ang.y,ang.r))
	self.canbase:DrawModel()
end

function ENT:Initialize()
	self.showtrace = false
	self.mouselock = false
	self.soundplaying = false
	self.locang = Angle(0,0,0)


	self:DrawShadow(false)

	self.fusesound = CreateSound(self, "/ambient/fire/fire_small_loop1.wav")
		self.fusesound:ChangePitch(255, 0)

	self.can = ClientsideModel("models/solidarity/cannon.mdl", RENDERGROUP_OPAQUE)
		self.can:SetNoDraw(true)

	self.canbase = ClientsideModel("models/props_lab/monitor01a.mdl", RENDERGROUP_OPAQUE)
		self.canbase:SetNoDraw(true)
		self.canbase:SetMaterial("models/props_wasteland/wood_fence01a")
end

function ENT:GetPlayer()
	return self:GetInternalFMOwner()
end

local w,h = ScrW(), ScrH()
hook.Add("HUDPaint", "DrawCannonHUD", function()
	for k,ent in pairs(ents.FindByClass("fm_cannon")) do if ent:GetPossessor() == LocalPlayer() then

	local y = 200
	surface.SetDrawColor(FMCOLORS.bg)
--surface.DrawRect(w/2 - 100, y, 200, 92)
	draw.RoundedBox(6, w/2 - 75, y, 150, 92, FMCOLORS.bg)
	y = y + 5

	surface.SetFont("FMRegular24")
	surface.SetTextColor(FMCOLORS.txt)

	surface.SetTextPos(w/2 - 33, y)
	surface.DrawText("Cannon")
	y = y + 24 + 5

	surface.SetTextPos(w/2 - (124/2), y)
	surface.DrawText(string.format("%i Cannonballs", ent:GetBalls()))
	y = y + 24 + 5


	if ent:GetBalls() == 0 then
		surface.SetTextColor(Color(160,16,16))
	else
		surface.SetTextColor(Color(85,229,194))
	end

	local txt = (ent:GetBalls() == 0) and "Empty" or (ent.soundplaying and "Firing..." or "Ready")
	local tw = surface.GetTextSize(txt)
	surface.SetTextPos(w/2 - (tw/2), y)
	surface.DrawText(txt)

	return end end
end)

function ENT:Think()
--This code keeps checking if the owner has been set yet, if it finds that it's set, it checks if the owner is localplayer. If he is, it'll show the trace by default.
	--[[if not self.foundowner then
		if IsValid(self:GetPlayer()) then
			self.foundowner = true

			local owner = self:GetPlayer()
			if LocalPlayer() == owner then
				self.showtrace = true-- Only show trace by default for the owner.
			end
		end
	end]]

	local owner = self:GetPossessor()
	if not IsValid(owner) then
		self.locang = Angle(math.ApproachAngle(self.locang.p, 0, 0.3), math.ApproachAngle(self.locang.y, 0, 0.3), math.ApproachAngle(self.locang.r, 0, 0.3))
		return
	end

	local trdata = {}
		trdata.start = owner:GetShootPos()
		trdata.endpos = trdata.start + owner:GetAimVector() * 2000
		trdata.filter = {owner, self, self.canbase}
--local hitpos = owner:GetEyeTrace().HitPos
	local hitpos = util.TraceLine(trdata).HitPos

	local ang = (hitpos - self:GetPos()):Angle()

	local locang = self:WorldToLocalAngles(ang)
	locang.p = math.Clamp(locang.p, -50, 0)
	locang.y = math.Clamp(locang.y, -45, 45)
	locang.r = math.Clamp(locang.r, -45, 45)
	self.locang = locang

	local playfusesound = self:GetPlayFuseSound() or false
	if playfusesound == true and not self.soundplaying then
		self.soundplaying = true
		self.fusesound:Play()
	elseif playfusesound == false and self.soundplaying then
		self.soundplaying = false
		self.fusesound:Stop()
	end
--[[
	if not self.foundowner or self:GetPlayer() != LocalPlayer() then return end-- Prevent non-teammates from interacting with it
	if self:BeingLookedAtByLocalPlayer() then
		local txt = string.format("%s%i/%i Cannonballs left.\nPress E to fire.\nRightclick + E to toggle traceline.",
			(self.soundplaying and "Firing...\n" or ""),
			self:GetBalls(), self:GetMaxBalls())

		AddWorldTip( nil, txt, nil, self:GetCenter(), nil )

		if ((self.lastchange or 0) < CurTime()) and input.IsKeyDown(KEY_E) and input.IsMouseDown(MOUSE_RIGHT) then
			self.showtrace = not self.showtrace
			self.lastchange = CurTime() + .5
		end
	end
]]
end

