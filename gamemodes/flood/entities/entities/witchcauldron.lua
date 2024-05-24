AddCSLuaFile()

ENT.Type      = "anim"
ENT.Base      = "base_anim"

ENT.PrintName = "Normal WitchCauldron"
ENT.Author    = "ClemensProduction aka Zerochain"

ENT.Effect    =  "soup_bubbles01"

function ENT:Initialize()
	self:SetModel("models/zerochain/props_halloween/witchcauldron.mdl")
	self:SetSkin(1)

	local attid = self:LookupAttachment("particle_effect")
	if not attid then return end

	ParticleEffectAttach("soup_bubbles01", PATTACH_POINT_FOLLOW, self, attid)
end

--[[
function ENT:Think()
	if not CLIENT then return end
	if QUALITY < 1 then return end

	local dlight = DynamicLight(self:EntIndex())
	if dlight then
		dlight.Pos = self:GetPos() + Vector(0,0,60)
		dlight.r = 160
		dlight.g = 255
		dlight.b = 0
		dlight.Brightness = 1
		dlight.Size = 256
		dlight.Decay = 0
		dlight.Style = 5
		dlight.DieTime = CurTime() + 1
	end
end
]]

function ENT:OnRemove()
	self:StopParticles()
end

function CreateCauldron(pos, ang)
	local cauldron = ents.Create("witchcauldron")
		cauldron:SetPos(pos)
		cauldron:SetAngles(ang)
		cauldron:Spawn()
		cauldron:Activate()
end