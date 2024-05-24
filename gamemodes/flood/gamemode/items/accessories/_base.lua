ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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

ITEM.PersistOnDeath = true

function ITEM:OnEquip(ply, modifications)
	ply:AddClientsideModel(self.ID)
end

function ITEM:OnHolster(ply)
	ply:RemoveClientsideModel(self.ID)
end

function ITEM:GetModelOffsets(ply)
	if not self.Offsets or not self.Offsets[ply:GetModel()] then
		return Vector(0,0,0), Angle(0,0,0), Vector(1,1,1)
	end
	local t = self.Offsets[ply:GetModel()]

	return t[1] or Vector(0,0,0), t[2] or Angle(0,0,0), t[3] or Vector(1,1,1)
end

function ITEM:ModifyClientsideModel(ply, model, pos, ang)
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