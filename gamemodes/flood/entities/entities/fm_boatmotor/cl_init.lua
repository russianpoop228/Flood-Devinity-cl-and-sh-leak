include("shared.lua")

function ENT:Draw()
	local ang = self:GetAngles()
	local prevang = Angle()
	prevang:Set(ang)
	ang:RotateAroundAxis(ang:Up(), self.locyaw)

	self.matrix:SetAngles(Angle(0,self.locyaw,0))
	self:EnableMatrix("RenderMultiply", self.matrix)
	self:DrawModel()

	--Propellor
	self:SetAngles(ang)
	self.prop:SetRenderOrigin(self:LocalToWorld(Vector(-26,1,-4)))
	self.prop:SetRenderAngles(self:LocalToWorldAngles(Angle(0,0,self.spinang)))

	self.throtprop:SetRenderOrigin(self:LocalToWorld(Vector(23,2,12)))
	local a = self:LocalToWorldAngles(Angle(0,90,45))
	a:RotateAroundAxis(a:Up(), (self.throttlelerp/100) * 80-20)
	self.throtprop:SetRenderAngles(a)--self:GetThrottle(),0)))
	self:SetAngles(prevang)

	self.prop:DrawModel()

	--Throtprop
	self.throtprop:DrawModel()
end

function ENT:Think()
	self.spinang = ((self.spinang or 0) + 1 * (FrameTime() * 1000) * (self:GetThrottle()/100 * 2) ^ 2) % 360
	self.throttlelerp = Lerp(0.05, self.throttlelerp, self:GetThrottle())
	self.idlesound:ChangePitch(math.max(10,self:GetThrottle()),0.1)
	self.idlesound:ChangeVolume(self:GetThrottle()/100,0.1)

	local owner = self:GetPossessor()
	if not IsValid(owner) then
		self.locyaw = math.Approach(self.locyaw, 0, 1)
		return
	end
	local hitpos = owner:GetEyeTrace().HitPos

	local ang = (hitpos - self:GetPos()):Angle()
	local locyaw = -self:WorldToLocalAngles(ang).y
	locyaw = math.Clamp(locyaw, -60, 60)
	self.locyaw = locyaw
end

local polys = {
	{5, 0},
	{17, -31},
	{60, -58},
	{186, -58},
	{186, 58},
	{60, 58},
	{17, 31},
}
local mid = 186 / 2

local w = ScrW()

local x = w / 2
local y = 263 + 20
local pw = 80
local ph = 15
for _, v in pairs(polys) do
	local px, py = v[1], v[2]
	table.remove(v)
	table.remove(v)

	v.x = ((px / 186) * pw) + x - ((pw / 186) * mid)
	v.y = ((py / 58) * ph) + y
	v.u = 0
	v.v = 0
end

hook.Add("HUDPaint", "DrawBoatmotorHUD", function()
	if IsValid(LocalPlayer():GetNWEntity("PossessedBoatMotor")) then
		local ent = LocalPlayer():GetNWEntity("PossessedBoatMotor")
		ent.smooththrottle = ent.smooththrottle or 0
		ent.smooththrottle = math.Approach(ent.smooththrottle, ent:GetThrottle(), (ent.smooththrottle > ent:GetThrottle() and -0.3 or 0.3))

		local y = 200
		surface.SetDrawColor(FMCOLORS.bg)
		--surface.DrawRect(w/2 - 100, y, 200, 92)
		draw.RoundedBox(6, w / 2 - 75, y, 150, 110, FMCOLORS.bg)
		y = y + 25

		surface.SetFont("FMRegular24")
		surface.SetTextColor(FMCOLORS.txt)

		-- surface.SetTextPos(w / 2 - 47, y)
		-- surface.DrawText("Boatmotor")
		-- y = y + 24 + 5

		local txt = string.format("%i%% Throttle", math.floor(ent.smooththrottle))
		local tw = surface.GetTextSize(txt)
		surface.SetTextPos(w / 2 + 60 - tw, y)
		surface.DrawText(txt)

		local yaw = -ent.locyaw
		surface.SetDrawColor(FMCOLORS.txt)
		draw.NoTexture()
		surface.DrawPoly(polys)

		local l0 = Vector(w / 2 + 40, 263 + 20, 0)
		local l1 = Vector(20, 5, 0)
		local l2 = Vector(20, -5, 0)
		l1:Rotate(Angle(0,yaw,0))
		l2:Rotate(Angle(0,yaw,0))
		l1:Add(l0)
		l2:Add(l0)

		surface.DrawLine(l0.x, l0.y, l1.x, l1.y)
		surface.DrawLine(l1.x, l1.y, l2.x, l2.y)
		surface.DrawLine(l2.x, l2.y, l0.x, l0.y)
	end
end)

function ENT:Initialize()
	local prop = ClientsideModel("models/props_citizen_tech/windmill_blade004a.mdl", RENDERGROUP_OPAQUE)
		prop:SetNoDraw(true) -- We draw this ourself
	self.prop = prop

	local mat = Matrix()
		mat:Scale( Vector( 0.4,0.4,0.4 ) )
	prop:EnableMatrix( "RenderMultiply", mat )

	local throtprop = ClientsideModel("models/gibs/hgibs_spine.mdl", RENDERGROUP_OPAQUE)
		throtprop:SetNoDraw(true)
	self.throtprop = throtprop

	self.spinang = 0
	self.locyaw = 0
	self.matrix = Matrix()
	self.throttlelerp = 0

	self.idlesound = CreateSound(self, "vehicles/airboat/fan_blade_idle_loop1.wav")
	self.idlesound:Play()
	self.idlesound:ChangePitch(0,0)
	self.idlesound:ChangeVolume(0,0)
end
