include('shared.lua')

function ENT:Draw()
	self.StartTime = self.StartTime or CurTime()
	if ( not IsValid( self.Owner ) ) or self.Owner ~= LocalPlayer() or CurTime() > self.StartTime + 0.05 then
		self:DrawModel()
	end
end