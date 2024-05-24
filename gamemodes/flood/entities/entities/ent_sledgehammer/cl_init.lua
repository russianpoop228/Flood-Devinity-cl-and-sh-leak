include("shared.lua")

killicon.Add( "ent_sledgehammer", "vgui/entities/ent_sledgehammer", Color( 255, 255, 255, 255 ) )

function ENT:Initialize()
	self.modelEnt = ClientsideModel("models/weapons/lordi/c_sledgehammer.mdl", RENDER_GROUP_OPAQUE)

	self.Spin_Ang = 0
end

function ENT:Draw()

	if self:GetHasHit() then
		self.Spin_Ang = 0
	else
		self.Spin_Ang = self.Spin_Ang + 10
	end

	if IsValid(self.modelEnt) and self.modelEnt:LookupBone("sledge_hammer") then
		self.modelEnt:SetPos(self:GetPos() + self:GetAngles():Right() * 20)
		self.modelEnt:SetAngles(self:GetAngles())
		self.modelEnt:SetParent(self)
		self.modelEnt:ManipulateBoneAngles(self.modelEnt:LookupBone("sledge_hammer"),Angle(174 + self.Spin_Ang,110,87))
		self.modelEnt:ManipulateBonePosition(self.modelEnt:LookupBone("sledge_hammer"),Vector(-20,27,8.6))
	end

end

function ENT:OnRemove()
	if IsValid(self.modelEnt) then
		self.modelEnt:Remove()
	end
end