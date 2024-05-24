include("shared.lua")
local function Vert( pos, normal, u, v )
	mesh.Position( pos )
	mesh.Normal( normal )
	mesh.Color(255,255,255,255)
	mesh.TexCoord( 0, u, v )
	mesh.AdvanceVertex( )
end

local function Norm( p1, p2, p3 )
	local a = Vector(
		p3.x - p2.x,
		p3.y - p2.y,
		p3.z - p2.z
	)

	local b = Vector(
		p1.x - p2.x,
		p1.y - p2.y,
		p1.z - p2.z
	)

	local norm = Vector(
		(a.y * b.z) - (a.z * b.y),
		(a.z * b.x) - (a.x * b.z),
		(a.x * b.y) - (a.y * b.x)
	)
	norm:Normalize()

	return norm
end

local function AddNorms( n1, n2 )
	return (n1 + n2):GetNormal()
end

local flagmaterial = Material("models/debug/debugwhite")
local ribbonlen = 2 -- How large each subsection is
local ribbonam = 20 -- How many subsections the flag is split into
local flagwide = 40 -- How wide the flag is
local d_wavespeed = 5 -- How fast it waves
local wavemul = 1.5 -- How big the waves are
local waveam = 0.3  -- How many waves
local umul = 1/ribbonam
function ENT:DrawFlag()
	if not self.flagmat then
		self:SetupFlagMaterial()
		return
	end

	local wavespeed = d_wavespeed * self:GetWindStrength()

	local mat = Matrix()
	mat:SetTranslation(self:GetPos() + self:GetUp() * 108)
	mat:SetScale(Vector(1,1,1))

	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Right(), self:GetWindAngle() - self:GetAngles().y)
	mat:SetAngles(ang)

	render.SuppressEngineLighting(true)
	render.SetMaterial(self.flagmat and self.flagmat or flagmaterial)

	cam.PushModelMatrix(mat)
		mesh.Begin(MATERIAL_TRIANGLES, ribbonam * 2 * 2)
			for i=0,ribbonam-1 do
				local wave = math.sin(-CurTime() * wavespeed + i * waveam) * wavemul
				if i == 0 then
					wave = 0
				end

				local wave2 = math.sin(-CurTime() * wavespeed + (i + 1) * waveam) * wavemul

				local p1 = Vector(i * ribbonlen, 0, wave)
				local p2 = Vector((i + 1) * ribbonlen, 0, wave2)
				local p3 = Vector((i + 1) * ribbonlen, flagwide, wave2)
				local p4 = Vector(i * ribbonlen, flagwide, wave)

				--Normal shit
				--[[local wave3 = math.sin(-CurTime() * wavespeed + (i-1) * waveam) * wavemul
				local wave4 = math.sin(-CurTime() * wavespeed + (i + 2) * waveam) * wavemul

				local normprev = vector_up
				if i > 0 then
					normprev = Norm( p1, p4, Vector((i-1) * ribbonlen, 0, wave3) )
				end
				local norm = Norm( p1, p2, p3 )
				local normnext = Norm( p2, p3, Vector((i + 2) * ribbonlen, 0, wave4) )

				--Front
				Vert(p1, -AddNorms(normprev, norm), umul * i,     0)
				Vert(p2, -AddNorms(norm, normnext), umul * (i + 1), 0)
				Vert(p3, -AddNorms(norm, normnext), umul * (i + 1), 1)

				Vert(p3, -AddNorms(norm, normnext), umul * (i + 1), 1)
				Vert(p4, -AddNorms(normprev, norm), umul * i,     1)
				Vert(p1, -AddNorms(normprev, norm), umul * i,     0)--]]
				Vert(p1, -vector_up, umul * i,       0)
				Vert(p2, -vector_up, umul * (i + 1), 0)
				Vert(p3, -vector_up, umul * (i + 1), 1)

				Vert(p3, -vector_up, umul * (i + 1), 1)
				Vert(p4, -vector_up, umul * i,       1)
				Vert(p1, -vector_up, umul * i,       0)

				--Back
				Vert(p3, vector_up,  1 - umul * (i + 1), 1)
				Vert(p2, vector_up,  1 - umul * (i + 1), 0)
				Vert(p1, vector_up,  1 - umul * i,       0)

				Vert(p1, vector_up,  1 - umul * i,       0)
				Vert(p4, vector_up,  1 - umul * i,       1)
				Vert(p3, vector_up,  1 - umul * (i + 1), 1)
			end
		mesh.End()
	cam.PopModelMatrix()
	render.SuppressEngineLighting(false)
end

local function ColVecToCol(vec)
	return Color(vec.x, vec.y, vec.z)
end

TEXI = TEXI or 0
function ENT:SetupFlagMaterial()
	if not self:GetFlagColor() then return end

	TEXI = TEXI + 1

	local col = ColVecToCol(self:GetFlagColor())

	local drawmat = self:GetFlagMaterial() and #self:GetFlagMaterial() > 0
	local teammat
	if drawmat then
		teammat = Material("icon32/flagicons/" .. self:GetFlagMaterial() .. ".png", "noclamp smooth unlitgeneric")
	end

	local pw,ph = 256,256

	local mat = CreateMaterial(self:EntIndex() .. "_flagmat" .. TEXI, "VertexLitGeneric", {})
	local rt = GetRenderTarget(self:EntIndex() .. "_flagmat_rt" .. TEXI,pw,ph,false)

	local oldw,oldh = ScrW(), ScrH()
	local old = render.GetRenderTarget()
	render.SetRenderTarget(rt)
	render.Clear( 255,255,255,255,true,true )
	render.SuppressEngineLighting(true)
	render.SetViewPort(0,0,pw,ph)

	cam.Start2D()
	--Draw background
	surface.SetDrawColor(col)
	surface.DrawRect(0,0,pw,ph)

	--Draw logo
	if drawmat then
		local size = 256
		local th = 0
		if self:GetFlagText() and #self:GetFlagText() > 0 then
			local fonti = 32
			local tw
			repeat
				surface.SetFont("FMRegular" .. fonti)
				tw,th = surface.GetTextSize(self:GetFlagText())
				fonti = fonti - 2
			until tw < pw or fonti < 16

			th = th + 10

			surface.SetTextPos(pw/2 - tw/2, ph - th)
			surface.SetTextColor(color_black)
			surface.DrawText(self:GetFlagText())
		end

		size = size - th

		surface.SetDrawColor(color_white)
		surface.SetMaterial(teammat)
		surface.DrawTexturedRect(pw/2 - size/2, 0, size, size)
	end

	cam.End2D()

	render.SuppressEngineLighting(false)
	render.SetRenderTarget(old)
	render.SetViewPort(0,0,oldw,oldh)

	timer.Simple(0.05,function()
		mat:SetTexture("$basetexture", rt)
	end)

	self.flagmat = mat
end

function ENT:Draw()
	self:DrawFlag()

	self:DrawModel()
end

function ENT:Initialize()
	self:SetupFlagMaterial()
	self:SetRenderBounds(Vector(-50,-50,0),Vector(50,50,120))
end
