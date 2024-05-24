function ITEM:ModifyClientsideModel(ply, model, pos, ang)
	if ply.Items and ply.Items[self.ID] then
		local mods = ply.Items[self.ID].Modifiers
		local ski = (mods and mods.skin) and mods.skin or 0

		if model:GetSkin() != ski then
			model:SetSkin(ski)
		end
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

--Is run serverside to make sure nothing invalid gets set as the strength
function ITEM:SanitizeModifiers(ply, modifications)
	local ski = tonumber(modifications.skin)
	if not ski then ski = 0 else ski = math.Clamp(ski, 0, 3) end
	modifications.skin = ski
end

function ITEM:Modify(modifications)
	Derma_StringRequest("Skin", "Set wizard hat skin, input a number 1-4", "", function(text)
		local ski = tonumber(text)
		if not ski then return end

		ski = math.Clamp(math.floor(ski), 1, 4) - 1
		modifications.skin = ski

		Items:SendModifications(self.ID, modifications)
	end)
end
