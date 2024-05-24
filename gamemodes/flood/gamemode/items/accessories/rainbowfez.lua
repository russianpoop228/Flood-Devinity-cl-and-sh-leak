function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	self.hue = (self.hue or 0) + FrameTime() * 150
	model:SetColor(HSVToColor(self.hue % 360, 1, 1))

	local mdlpos, mdlang, mdlscale = self:GetModelOffsets(ply)
	mdlscale = mdlscale * self.Scale

	local mat = Matrix()
	mat:Scale(Vector(mdlscale, mdlscale, mdlscale))
	model:EnableMatrix("RenderMultiply", mat)

	ang:RotateAroundAxis( ang:Up(), -90 )
	ang:RotateAroundAxis( ang:Forward(), -90 )

	if self.Attachment then
		ang:RotateAroundAxis(ang:Forward(), 90)
		ang:RotateAroundAxis(ang:Up(), 90)
		ang:RotateAroundAxis(ang:Right(), -90)
	end

	pos, ang = LocalToWorld(mdlpos, mdlang, pos, ang)
	pos, ang = LocalToWorld(self.PosOffset, self.AngOffset, pos, ang)

	return model, pos, ang
end
