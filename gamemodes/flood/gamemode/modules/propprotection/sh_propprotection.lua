
--[[
Shared propprotection
]]
local entmeta = FindMetaTable("Entity")

function entmeta:PPGetOwner()
	return self:GetNWEntity("pp_owner")
end
entmeta.FMOwner = entmeta.PPGetOwner

function entmeta:PPGetOwnerName()
	if not IsValid(self:PPGetOwner()) then
		return self:GetNWString("pp_owner_nick", "N/A")
	end
	return self:GetNWEntity("pp_owner"):Nick()
end

function entmeta:PPGetOwnerSteamID()
	return self:GetNWString("pp_owner_sid")
end

function entmeta:PPCanInteract(ply)
	if ply:GetMODTier() >= RANK_ADMIN then return true end

	local propowner = self:PPGetOwner()
	if not IsValid(propowner) and ply:GetMODTier() >= RANK_JUNIOR then return true end -- Allow jr+ to interact with disconnected players props

	local ret = hook.Run("FMPPCanInteract", ply, self, propowner)
	if ret != nil then return ret end

	if not IsValid(propowner) or not propowner:SameTeam(ply) then
		return false
	end

	return true
end

--Called by the custom remover tool
hook.Add("PlayerRemovedEnt", "PlayerRemoveEntShit", function(ply, ent)
	local cashback = ent:Refund(1)

	local owner = ent:FMOwner()
	if not IsValid(owner) then return end

	owner:RoundStatsAdd("cashspent", -cashback)
	owner:RoundStatsAdd("propsspawned", -1)
end)
hook.Add("PlayerRemoveEnt", "PlayerRemoveEntShit", function(ply, ent)
	if ply:IsAdmin() then return true end -- Isadmin

	if not ent.FMOwner or not IsValid(ent:FMOwner()) then return false end -- no valid owner
	return ent:FMOwner() == ply
end)

function GM:CanDrive(ply, ent)
	return false -- Disable driving
end

--[[
Physgun
]]
local pickuprank = RANK_MOD

if CLIENT then
	CreateClientConVar("fma_playerpickup", 1, true, true)
	AddSettingsItem("admin", "checkbox", "fma_playerpickup", {lbl = "Player Pickup"}, pickuprank)
end

function GM:PhysgunPickup(ply, ent)
	if ent.CreatedByMap and ent:CreatedByMap() then return false end

	if SERVER then
		ply.lastplayerpickup = nil
		ply.wanttofreeze = nil
	end

	local isplayerpickup = false
	if ent:IsPlayer() then
		if ply:GetMODTier() < pickuprank then return false end
		if ply:GetInfoNum("fma_playerpickup", 1) != 1 then return false end

		isplayerpickup = true
	end

	local res = isplayerpickup or ply:GetMODTier() >= RANK_MOD or ent:PPCanInteract(ply)

	if SERVER then
		if isplayerpickup then
			ply.lastplayerpickup = ent

			ent:SetMoveType(MOVETYPE_NONE)
			ent:Freeze(true)
			ent.AdminFrozen = true

			ply.wanttofreeze = nil
		end
	end

	return res
end

if SERVER then
hook.Add("PhysgunDrop", "FMAntiPropKill", function(ply, ent)
	if ent:IsPlayer() then return end

	for _, v in pairs(constraint.GetAllConstrainedEntities(ent)) do
		if IsValid(v:GetPhysicsObject()) then
			local vel = v:GetPhysicsObject():GetVelocity()
			local norm = vel:GetNormal()
			local len = vel:Length()
			v:GetPhysicsObject():SetVelocityInstantaneous(norm * math.min(len, 200))

			local angvel = v:GetPhysicsObject():GetAngleVelocity()
			local angnorm = angvel:GetNormal()
			local anglen = angvel:Length()
			local target = angnorm * math.min(anglen, 200)
			v:GetPhysicsObject():AddAngleVelocity(-angvel + target)
		end
	end
end)
end
--[[
Gravity gun
]]
function GM:GravGunPunt(ply, ent)
	return ent:PPCanInteract(ply)
end
