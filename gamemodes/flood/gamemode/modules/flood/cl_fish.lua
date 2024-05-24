
local fishconvar = CreateClientConVar("fm_showfishandblood", 1, true, false)
AddSettingsItem("flood", "checkbox", "fm_showfishandblood", {lbl = "Enable fish gore"})

cvars.AddChangeCallback("fm_showfishandblood", function(cvar, old, new)
	local num = tonumber(new)
	if not num or num != 0 then return end

	for _,ply in pairs(player.GetAll()) do
		if not ply.fishes then continue end

		for _,v in pairs(ply.fishes) do
			if IsValid(v) then
				v:SetNoDraw(true)
			end
		end
	end
end)

local fisham = 4 -- How many fishes should we draw.
local function CreateFishes(ply)
	ply.fishes = {}

	for _ = 1, fisham do
		local fish = ClientsideModel("models/props/de_inferno/goldfish.mdl", RENDERGROUP_OPAQUE)
			fish:SetNoDraw(true)
			fish.owner = ply
			--fish.yaw = nil
			fish.step = math.Rand(0,1)
			fish:SetColor(Color(150,0,0,255))

		table.insert(ply.fishes, fish)
	end
end

hook.Add("EntityRemoved", "RemoveFishes", function(ply)
	if not IsValid(ply) or not ply:IsPlayer() or ply == LocalPlayer() or not ply.fishes then return end

	for _, v in pairs(ply.fishes) do
		if IsValid(v) then v:Remove() end
	end
end)

function GM:FMDrawPlayerFishes(ply)
	return true
end

hook.Add("Think", "ProcessFishes", function()
	if fishconvar:GetBool() == false then return end

	for _, v in pairs(player.GetAll()) do
		local should = v:Alive() and v:WaterLevel() > 1 and GAMEMODE:IsPhase(TIME_FIGHT)
		if should and not hook.Run("FMDrawPlayerFishes", v) then should = false end

		local fishdrawn = false
		if should then
			if not v.emitter then
				v.emitter = ParticleEmitter(v:GetPos())
			else
				v.emitter:SetPos(v:GetPos())
			end

			if not v.fishes then
				CreateFishes(v)
			end

			fishdrawn = true

			for i = 1,fisham do
				local fish = v.fishes[i]
				if not IsValid(fish) then continue end

				fish:SetNoDraw(false)

				if not fish.yaw then
					fish.yaw = math.random(1,360)

					fish.step = 0
					local vec = Vector(100, 100, 0)
					vec:Rotate(Angle(0,fish.yaw,0))
					vec:Add(v:GetPos() + Vector(0,0,-30))

					fish.start = vec
					fish.endpos = v:GetPos() + Vector(math.random(-10,10),math.random(-10,10),math.random(20,40)) + v:GetVelocity() / 5
				end

				local vec = LerpVector(fish.step, fish.start, fish.endpos)
				fish:SetRenderOrigin(vec)

				local ang = (fish.endpos - vec):Angle()
				fish:SetRenderAngles(ang)

				fish.step = fish.step + math.Rand(0.01,0.03)
				if fish.step > 1 then
					local particle = v.emitter:Add("decals/flesh/blood" .. math.random(1,5), vec + VectorRand() * 20)
					if not particle then continue end

					particle:SetLifeTime(0)
					particle:SetDieTime(math.Rand(0.1,0.5))
					particle:SetStartAlpha(100)
					particle:SetEndAlpha(0)
					particle:SetStartSize(35)
					particle:SetEndSize(35)
					particle:SetAirResistance(0.5)

					particle:SetVelocity(VectorRand() * 80 + Vector(0,0,math.random(300,400)))
					particle:SetGravity(Vector(0,0,-1000))
					particle:SetColor(100,0,0,255)

					fish.yaw = nil -- Reset yaw so we get a new yaw next think.
				end
			end
		end

		if not fishdrawn and v.fishes then
			for i = 1,fisham do
				if IsValid(v.fishes[i]) then
					v.fishes[i]:SetNoDraw(true)
				end
			end
		end
	end
end)
