
function EFFECT:Init( data )
	self.StartPos = data:GetStart()
	self.EndPos = data:GetOrigin()
	self.Normal = data:GetNormal()
	self:SetRenderBoundsWS( self.StartPos, self.EndPos )

	self.CurPos = self.StartPos


	self.emitter = ParticleEmitter( self.EndPos, true )
	if not self.emitter then return end
end

function EFFECT:Hit( hitpos, normal )
	for i=1,math.ceil(5 * QUALITY) do
		local particle = self.emitter:Add( "particles/particle_smokegrenade", hitpos )
		if particle then
			local Spread = 0.3
			local rotvec = Vector()
			rotvec:Set(normal)
			rotvec:Rotate(Angle(math.random(-90,90), math.random(-90,90), math.random(-90,90)))

			particle:SetVelocity( rotvec * math.random(50,100) * -1)
			particle:SetDieTime( 2 )
			particle:SetColor( 255, 255, 255 )
			particle:SetStartAlpha( 150 )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( 15 )
			particle:SetEndSize( 15 )
			particle:SetAirResistance( 100 )
			particle:SetGravity(Vector(0,0,0))
		end
	end

	self.emitter:Finish()
end

function EFFECT:Think()
	self.CurPos = self.CurPos + (self.EndPos - self.StartPos):GetNormal() * 20
	local dot = (self.EndPos - self.CurPos):Dot(self.EndPos - self.StartPos)

	if dot < 0 then
		self:Hit(self.EndPos, self.Normal)
		return false
	end

	return true
end

local mat = Material("fm/lasertracer.png")
function EFFECT:Render()
	local start = self.CurPos
	local endpos = self.CurPos + (self.EndPos - self.StartPos):GetNormal() * 30

	render.SetMaterial( mat )
	render.DrawBeam( start, endpos, 2, 1, 0, color_white )
end
