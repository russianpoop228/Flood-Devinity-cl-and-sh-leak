
-- FMEscapeMenuAvatarImage
-- A circular avatar
-- Credit to superiorservers 3d2d escape emnu

local PANEL = {}
function PANEL:Init()
	self.avatarImage = vgui.Create("AvatarImage", self)
	self.avatarImage:SetPaintedManually(true)
	self:PerformLayout()
end

function PANEL:SetPlayer(pl, size)
	self.avatarImage:SetPlayer(pl, size)
end

function PANEL:PerformLayout()
	local w, h = self:GetSize()
	self.avatarImage:SetSize(w,h)

	self.circle = {}
	local wedges = 36
	local wedge_angle = math.pi * 2 / wedges
	local r = w * 0.5
	for i = 1, wedges do
		table.insert(self.circle, {
			x = math.cos(i * wedge_angle) * r + r,
			y = math.sin(i * wedge_angle) * r + r,
		})
	end
end

function PANEL:Paint(w,h)
	render.SetStencilEnable(true)

	render.ClearStencil()

	render.SetStencilWriteMask( 1 )
	render.SetStencilTestMask( 1 )
	render.SetStencilReferenceValue( 1 )

	render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilPassOperation( STENCIL_REPLACE )
	render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )

	surface.SetDrawColor(0,0,0,255)
	draw.NoTexture()
	surface.DrawPoly(self.circle)

	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilFailOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )

	self.avatarImage:SetPaintedManually(false)
	self.avatarImage:PaintManual()
	self.avatarImage:SetPaintedManually(true)

	render.SetStencilEnable(false)
end
vgui.Register("FMEscapeMenuAvatarImage", PANEL)