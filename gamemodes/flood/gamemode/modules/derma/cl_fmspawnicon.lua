--[[
FMSpawnIcon

Like a spawn icon but uses a model panel instead of a 2d cached image
]]
local hovericon = Material( "vgui/spawnmenu/hover" )

local PANEL = {}
function PANEL:Init()
	self.Depressed = false
	self.Hovered = false
	self:SetCamPos( Vector( 20, -50, 10 ) )
	self:SetLookAt( Vector( 0, 0, 0 ) )
end

function PANEL:SetupPositions(mdl)
	self:SetCamPos( Vector( 20, 30, 10 ) )
	local t = IconCoords[mdl]
	if t then
		self.Entity:SetPos(t[1] or vector_origin)
		self.Entity:SetAngles(t[2] or angle_zero)
		self:SetFOV(t[3] or 50)
		self:SetColor(t[4] or color_white)
	end
end

function PANEL:SetModel(name)
	DModelPanel.SetModel(self,name)
	self:SetupPositions(name)
end

function PANEL:Paint()
	if not IsValid( self.Entity ) then return end

	local x, y = self:LocalToScreen( 0, 0 )

	local ang = self.aLookAngle
	if not ang then
		ang = (self.vLookatPos-self.vCamPos):Angle()
	end

	local w, h = self:GetSize()
	cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, 4096 )
	cam.IgnoreZ( true )

	render.SuppressEngineLighting( true )
	render.SetLightingOrigin( self.Entity:GetPos() )
	render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
	render.SetColorModulation( self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255 )
	render.SetBlend( self.colColor.a / 255 )

	for i = 0, 6 do
		local col = self.DirectionalLight[ i ]
		if ( col ) then
			render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
		end
	end

	local pnl = self:GetParent():GetParent():GetParent()
	if pnl then
		local x2, y2 = pnl:LocalToScreen( 0, 0 )
		local w2, h2 = pnl:GetSize()
		render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true )
		self.Entity:DrawModel()
		render.SetScissorRect( 0, 0, 0, 0, false )
	end

	render.SuppressEngineLighting( false )
	cam.IgnoreZ( false )
	cam.End3D()

	self.LastPaint = RealTime()

	return true
end

function PANEL:OnMousePressed(mc)
	self:MouseCapture(true)
	self.Depressed = true
end

function PANEL:OnMouseReleased(mc)
	self:MouseCapture(false)

	if not self.Depressed then return end
	self.Depressed = nil

	if not self.Hovered then return end

	self.Depressed = true
	if mc == MOUSE_LEFT then
		self:DoClick()
	elseif mc == MOUSE_RIGHT then
		self:DoRightClick()
	end
	self.Depressed = nil
end

function PANEL:PaintOver()
	if self.Hovered or self.Depressed then
		local x,y,w,h = 0,0,self:GetSize()
		if self.Depressed then
			x = x + 4
			y = y + 4
			w = w - 8
			h = h - 8
		end

		surface.SetMaterial(hovericon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(x,y,w,h)
	end
end
derma.DefineControl("FMSpawnIcon", "", PANEL, "DModelPanel")
