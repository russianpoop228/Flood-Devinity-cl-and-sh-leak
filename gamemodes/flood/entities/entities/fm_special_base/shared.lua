ENT.Type      = "anim"
ENT.Author    = "Donkie"
ENT.PrintName = "Special Base"

ENT.IndividualCooldown = false
ENT.Cooldown = 60
ENT.ActiveTime = 15
ENT.FireProof = true
ENT.UnWeldProof = true
ENT.Model = "models/Combine_Helicopter/helicopter_bomb01.mdl"
ENT.IsSpecialProp = true
ENT.DisabledEvents = {}
ENT.IsAllowedPhase = function(self, phase) return phase == TIME_FLOOD or phase == TIME_FIGHT end

function ENT:SetupDataTables()
end

function ENT:GetLastUse(ply)
	if self.IndividualCooldown then
		if CLIENT then
			return self:GetNWFloat("LastUse" .. ply:UserID(), 0)
		else
			return self.lastUses[ply] or 0
		end
	else
		if CLIENT then
			return self:GetNWFloat("LastUse", 0)
		else
			return self.lastUse or 0
		end
	end
end
