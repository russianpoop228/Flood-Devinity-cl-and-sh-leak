function EFFECT:Init( data )
	
	self.PartName = "kf_microwavegun"
	
	self.Ply = data:GetEntity()
	
	print(self.Ply)
	
	self.Attachment = 1
	
	if !IsValid(self.Ply) then return end
	
	local thirdperson = ( self.Ply.ShouldDrawLocalPlayer and self.Ply:ShouldDrawLocalPlayer() ) or ( self.Ply != LocalPlayer() )
	
	if thirdperson then
		ParticleEffectAttach(self.PartName,PATTACH_POINT_FOLLOW,self.Ply:GetActiveWeapon(),self.Attachment)	
	else
		ParticleEffectAttach(self.PartName,PATTACH_POINT_FOLLOW,self.Ply:GetViewModel(),self.Attachment)		
	end
	
end 

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end

 