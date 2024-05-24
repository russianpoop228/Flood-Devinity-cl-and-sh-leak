
local entmeta = FindMetaTable("Entity")

--[[
Death Ragdoll
]]
hook.Add("OnEntityCreated", "Deathragdoll", function(ent)
	-- Make ragdolls look like the player that has died
	if ent:IsRagdoll() then
		local ply = ent:GetRagdollOwner()

		if IsValid(ply) then
			-- Only copy any decals if this ragdoll was recently created
			if ent:GetCreationTime() > CurTime() - 1 then
				ent:SnatchModelInstance(ply)
			end

			-- Copy the color for the PlayerColor matproxy
			local playerColor = ply:GetPlayerColor()
			ent.GetPlayerColor = function()
				return playerColor
			end

			ent.lifetime = 0
			ent.lastlifetick = CurTime()
		end
	end
end)

function entmeta:GetRagdollOwner()
	return self:GetDTEntity(0)
end


--[[
Custom gibs with physics!!
]]
local types = {
	"models/gibs/hgibs.mdl",
	"models/gibs/hgibs_rib.mdl",
	"models/gibs/hgibs_scapula.mdl",
	"models/gibs/hgibs_spine.mdl",
}

local humangibs = {
	1, -- 1 skull
	2, -- 4 ribs
	2,
	2,
	2,
	3, -- 2 scapulas
	3,
	4 -- 1 spine
}

function SpawnGibsFromRagdoll(rag)
	if rag.hasbeengibbed then return end
	rag.hasbeengibbed = true

	local ragcent = rag:GetPos() + rag:OBBCenter()
	for _, typ in pairs(humangibs) do
		local pos = ragcent + VectorRand() * 5
		local vel = Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(30, 40)) * 3

		SpawnGib(pos, vel, typ)
	end

	rag:SetNoDraw(true)

	local posses = {}
	for deg = 0, 360, 45 do
		for radius = 10, 50, 10 do
			local vec = Vector(math.cos(math.rad(deg)), math.sin(math.rad(deg)), 0) * radius
			table.insert(posses, ragcent + vec)
		end
	end

	timer.Create(rag:EntIndex() .. "bloodmebaby", 0, 3, function()
		for _, v in pairs(posses) do
			local effectdata = EffectData()
				effectdata:SetOrigin(v + Vector(0,0,math.Rand(5,15)))
			util.Effect("BloodImpact", effectdata, true, true)
		end
	end)
end

local gibs = {}
function SpawnGib(pos, vel, typ)
	local ent = ClientsideModel(types[typ], RENDERGROUP_OPAQUE)
		if not IsValid(ent) then return end
		ent:SetPos(pos)
		ent:SetAngles(AngleRand())
		ent.vel = vel
		ent.angvel = Angle(math.Rand(-1,1), 0, math.Rand(-1,1)) * 200

	timer.Simple(10, function()
		if not IsValid(ent) then return end

		ent.sink = true

		timer.Simple(2, function()
			if not IsValid(ent) then return end

			ent:Remove()
		end)
	end)

	timer.Create(SysTime() .. "bloodgibs", 0, 3, function()
		if not IsValid(ent) then return end

		local effectdata = EffectData()
			effectdata:SetOrigin(ent:GetPos())
		util.Effect("BloodImpact", effectdata, true, true)
	end)

	table.insert(gibs, ent)
end

local function IsInWater(pos)
	return bit.band(util.PointContents(pos), CONTENTS_WATER) == CONTENTS_WATER
end

local function WaterDepth(pos)
	local depth = 0
	for _, v in pairs({-1, 0, 1}) do
		if IsInWater(pos + Vector(0,0,v)) then
			depth = depth + 1
		end
	end
	return depth
end

local lasttick
hook.Add("Think", "FMMoveGibs", function()
	if not lasttick then lasttick = CurTime() return end
	local dt = CurTime() - lasttick
	lasttick = CurTime()

	for k, gib in pairs(gibs) do
		if not IsValid(gib) then table.remove(gibs, k) continue end

		if not gib.sink then
			local depth = WaterDepth(gib:GetPos())

			gib.vel = gib.vel + depth * Vector(0,0,100) * dt -- Buoyancy
			gib.vel = gib.vel * (1 - depth * 0.005) -- More friction in water

			gib.angvel = gib.angvel * (1 - depth * 0.01) -- Angular water friction
		end

		gib.vel = gib.vel + 20 * Vector(0,0,-9.82) * dt -- Gravity

		gib:SetPos(gib:GetPos() + gib.vel * dt)
		gib:SetAngles(gib:GetAngles() + gib.angvel * dt)
	end
end)

--[[
Rotting
]]
local function CalcRotColor(lifetime)
	local shade = math.Clamp(lifetime / DeathRagLifetime, 0, 1)

	local h = 0
	local s = shade
	local v = 1 - shade * 0.6

	return HSVToColor(h, s, v), shade
end

local mat = Material("models/charple/charple4_sheet")
timer.Create("FMRotRagdolls", 0.1, 0, function()
	for _, rag in pairs(ents.FindByClass("prop_ragdoll")) do
		if not rag.lifetime then continue end

		if not rag.RenderOverride then
			rag.RenderOverride = function(self)
				local col, shade = CalcRotColor(self.lifetime)

				self:DrawModel()

				render.SetColorModulation(col.r / 255, col.g / 255, col.b / 255)
				render.SetBlend(shade)
				render.MaterialOverride(mat)
				self:DrawModel()
				render.MaterialOverride()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
			end
		end

		--Increase lifetime
		local diff = CurTime() - rag.lastlifetick
		rag.lifetime = rag.lifetime + diff
		rag.lastlifetick = CurTime()

		if rag.lifetime > DeathRagLifetime then
			SpawnGibsFromRagdoll(rag)
		end
	end
end)
