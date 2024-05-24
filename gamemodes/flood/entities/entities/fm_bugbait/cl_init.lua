include("shared.lua")

hook.Add("RenderScreenspaceEffects", "RenderBugbaitRefract", function()
	local inc = 0.006
	if not LocalPlayer():GetNWBool("bugbaitaffected") then inc = -0.006 end

	LocalPlayer().refract = math.Clamp((LocalPlayer().refract or 0) + inc, 0, 1)

	if LocalPlayer().refract == 0 then return end

	DrawMaterialOverlay( "effects/jarate_overlay", LocalPlayer().refract * 0.14 )
end)

function ENT:Think()
	if self:GetExploded() and not self.emitter then
		self.emitter = ParticleEmitter(self:GetPos())

		for i=1,math.ceil((50 * BugbaitRadius/300) * QUALITY) do
			local part = self.emitter:Add( "particle/smokesprites_000" .. math.random(1,6), self:GetPos() + VectorRand() * 50)
			if part then
				part:SetVelocity( VectorRand():GetNormal() * math.Rand(0,BugbaitRadius) )
				part:SetLifeTime(0)
				part:SetDieTime(BugbaitTime + math.Rand(-2,2))
				part:SetStartAlpha(60)
				part:SetEndAlpha(0)
				part:SetStartSize(70)
				part:SetEndSize(70)
				part:SetRollDelta(1)
				part:SetAirResistance(50)
				part:SetColor(95,127,63)
			end
		end
	end
end
