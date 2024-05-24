function EFFECT:Init( data )

	local vOffset = data:GetOrigin()
	local ent = data:GetEntity()

	local dlight = DynamicLight( ent:EntIndex() )

	if ( dlight ) then
	
		dlight.Pos = vOffset
		dlight.r = 255
		dlight.g = 220
		dlight.b = 128
		dlight.Brightness = 1.0
		dlight.Size = 255
		dlight.Decay = 200
		dlight.DieTime = CurTime() + 0.1

	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end