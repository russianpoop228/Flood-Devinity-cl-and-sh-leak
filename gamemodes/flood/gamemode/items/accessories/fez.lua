function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	if ply.Items and ply.Items[self.ID] then
		local mods = ply.Items[self.ID].Modifiers
		local color = (mods and mods.color) and mods.color or Color(255,0,0)
		model:SetColor(color)
	end

	local mdlpos, mdlang, mdlscale = self:GetModelOffsets(ply)
	mdlscale = mdlscale * self.Scale

	if not isvector(mdlscale) then mdlscale = Vector(mdlscale,mdlscale,mdlscale) end

	local mat = Matrix()
	mat:Scale(mdlscale)
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

function ITEM:SanitizeModifiers(ply, modifications)
	local clr = modifications.color
	if not clr then return end
	if not clr.r or not clr.g or not clr.b then clr = Color(255,255,255) end

	clr.r = math.Clamp(clr.r, 0, 255)
	clr.g = math.Clamp(clr.g, 0, 255)
	clr.b = math.Clamp(clr.b, 0, 255)
	clr.a = 255

	modifications.color = clr
end

function ITEM:Modify(modifications)
	Derma_ColorRequest("Fez Color", "Set your hat color. The Turks recommend red.", function(clr)
		if not clr or not clr.r or not clr.g or not clr.b then return end

		clr.r = math.Clamp(clr.r, 0, 255)
		clr.g = math.Clamp(clr.g, 0, 255)
		clr.b = math.Clamp(clr.b, 0, 255)
		clr.a = 255

		modifications.color = clr

		Items:SendModifications(self.ID, modifications)
	end)
end
