AddCSLuaFile()

ENT.Type = "anim"
ENT.Author = "Donkie"
ENT.RenderGroup = RENDERGROUP_OTHER -- Won't draw automatically

function ENT:Initialize()
	self:SetModel("models/props_junk/wood_crate002a.mdl")

	self:SetPos(Vector(0,0,5))
	self:SetAngles(Angle(0,0,0))
	self:DrawShadow(false)
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

sound.Add({
	name = "fm_sand_step0", -- left
	channel = CHAN_BODY,
	volume = 1.0,
	sound = {
		"player/footsteps/sand1.wav",
		"player/footsteps/sand3.wav",
	},
})

sound.Add({
	name = "fm_sand_step1", -- right
	channel = CHAN_BODY,
	volume = 1.0,
	sound = {
		"player/footsteps/sand2.wav",
		"player/footsteps/sand4.wav",
	},
})

sound.Add({
	name = "fm_snow_step0", -- left
	channel = CHAN_BODY,
	volume = 1.0,
	sound = {
		"player/footsteps/snow1.wav",
		"player/footsteps/snow2.wav",
		"player/footsteps/snow3.wav",
	},
})

sound.Add({
	name = "fm_snow_step1", -- right
	channel = CHAN_BODY,
	volume = 1.0,
	sound = {
		"player/footsteps/snow4.wav",
		"player/footsteps/snow5.wav",
		"player/footsteps/snow6.wav",
	},
})

local stepsounds = {
	["sand"] = "fm_sand_step",
	["snow"] = "fm_snow_step",
}

function ENT:InitializeFootstep()
	if self.hasInitializedFootstep then return end
	self.hasInitializedFootstep = true

	local typ = self:GetType()

	if not stepsounds[typ] then return end

	local trdata = {}
	hook.Add("PlayerFootstep", "FMOverrideFootstep", function(ply, pos, foot, snd, volume, rf)
		trdata.start = pos + Vector(0,0,1)
		trdata.endpos = pos - Vector(0,0,10)
		trdata.filter = ply

		local trres = util.TraceLine(trdata)
		if trres.HitWorld and trres.HitNormal == Vector(0,0,1) then
			local z = math.Round(trres.HitPos.z)
			if z == 0 or z == -278 then -- lol
				ply:EmitSound(stepsounds[typ] .. foot)
				return true
			end
		end
	end)
end

local currentGroundEntity
function ENT:Think()
	self:InitializeFootstep()
	currentGroundEntity = self
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Type")
end

function CreateMapGround(typ)
	local s = ents.Create("fm_ground")
		s:SetType(typ)
		s:Spawn()
		s:Activate()
end

function RemoveVending()
	if not isMap("fm_buildaboat_canal_modern") then return end

	local vendies = ents.FindByModel("models/props_kirby/flood/devinity_vendingmachine2.mdl")
	for _, vending in pairs(vendies) do vending:Remove() end
end

if SERVER then return end

function ENT:InitializeGroundMesh()
	if self.hasInitializedGroundMesh then return end
	self.hasInitializedGroundMesh = true

	local groundsnowvecs = {
		-- Floor
		{
			Vector(-1008.03,977.02,0.03),
			Vector(-984.85,994.03,0.03),
			Vector(913.96,994.03,0.03),
			Vector(940.03,978.02,0.03),
			Vector(940.03,140.03,0.03),
			Vector(-1008.03,140.03,0.03),
		},
		{
			Vector(-1008.03,140.03,0.03),
			Vector(940.03,140.03,0.03),
			Vector(940.03,-1463.03,0.03),
			Vector(-1008.03,-1463.03,0.03),
		},
		{
			Vector(-353.97,-1463.03,0.03),
			Vector(-353.97,-1874.97,0.03),
			Vector(-1008.03,-1874.97,0.03),
			Vector(-1008.03,-1463.03,0.03),
		},
		{
			Vector(301.97,-1463.03,0.03),
			Vector(940.03,-1463.03,0.03),
			Vector(940.03,-1874.97,0.03),
			Vector(301.97,-1874.97,0.03),
		}
	}

	if self:GetType() == "snow" then
		table.Add(groundsnowvecs, {
			-- Room wall tops
			{
				Vector(-1426.92,140.03,228.03),
				Vector(-563.97,140.03,228.03),
				Vector(-574.03,106.97,228.03),
				Vector(-1426.92,106.97,228.03),
			},
			{
				Vector(-574.03,106.97,228.03),
				Vector(-563.97,140.03,228.03),
				Vector(-563.97,-1874.97,228.03),
				Vector(-574.03,-1874.97,228.03),
			},
			{
				Vector(-574.03,-537.97,220.03),
				Vector(-574.03,-548.03,220.03),
				Vector(-1425.66,-548.03,220.03),
				Vector(-1425.66,-537.97,220.03),
			},
			{
				Vector(-574.03,-1190.97,220.03),
				Vector(-574.03,-1200.03,220.03),
				Vector(-1425.66,-1200.03,220.03),
				Vector(-1425.66,-1190.97,220.03),
			},
			{
				Vector(-366.03,-1874.97,221.03),
				Vector(-366.03,-1033.97,221.03),
				Vector(-353.97,-1044.03,221.03),
				Vector(-353.97,-1874.97,221.03),
			},
			{
				Vector(-353.97,-1044.03,221.03),
				Vector(-366.03,-1033.97,221.03),
				Vector(314.03,-1033.97,221.03),
				Vector(301.97,-1044.03,221.03),
			},
			{
				Vector(301.97,-1044.03,221.03),
				Vector(314.03,-1033.97,221.03),
				Vector(314.03,-1874.97,221.03),
				Vector(301.97,-1874.97,221.03),
			},
			{
				Vector(522.03,106.97,228.03),
				Vector(511.97,140.03,228.03),
				Vector(1360,140.03,228.03),
				Vector(1360,106.97,228.03),
			},
			{
				Vector(522.03,106.97,228.03),
				Vector(522.03,-1874.97,228.03),
				Vector(511.97,-1874.97,228.03),
				Vector(511.97,140.03,228.03),
			},
			{
				Vector(1358,-537.97,220.03),
				Vector(1358,-548.03,220.03),
				Vector(522.03,-548.03,220.03),
				Vector(522.03,-537.97,220.03),
			},
			{
				Vector(1358,-1190.97,220.03),
				Vector(1358,-1200.03,220.03),
				Vector(522.03,-1200.03,220.03),
				Vector(522.03,-1190.97,220.03),
			}
		})
	end

	if self:GetType() == "sand" then
		table.Add(groundsnowvecs, {
			-- Waterbottom
			{
				Vector(1351.97,1263.97,-277.97),
				Vector(1351.97,140.03,-277.97),
				Vector(940.03,140.03,-277.97),
				Vector(940.03,1263.97,-277.97),
			},
			{
				Vector(940.03,978.02,-277.97),
				Vector(913.96,994.03,-277.97),
				Vector(940.03,1263.97,-277.97),
			},
			{
				Vector(940.03,1263.97,-277.97),
				Vector(913.96,994.03,-277.97),
				Vector(-984.85,994.03,-277.97),
				Vector(-1008.03,1263.97,-277.97),
			},
			{
				Vector(-984.85,994.03,-277.97),
				Vector(-1008.03,977.02,-277.97),
				Vector(-1008.03,1263.97,-277.97),
			},
			{
				Vector(-1008.03,140.03,-277.97),
				Vector(-1419.97,140.03,-277.97),
				Vector(-1419.97,1263.97,-277.97),
				Vector(-1008.03,1263.97,-277.97),
			},
			--room water bottom
			{
				Vector(-1419.97,106.97,-277.97),
				Vector(-1008.03,106.97,-277.97),
				Vector(-1008.03,-537.97,-277.97),
				Vector(-1419.97,-537.97,-277.97),
			},
			{
				Vector(-1008.03,-548.03,-277.97),
				Vector(-1008.03,-1190.97,-277.97),
				Vector(-1419.97,-1190.97,-277.97),
				Vector(-1419.97,-548.03,-277.97),
			},
			{
				Vector(-1008.03,-1874.97,-277.97),
				Vector(-1419.97,-1874.97,-277.97),
				Vector(-1419.97,-1200.03,-277.97),
				Vector(-1008.03,-1200.03,-277.97),
			},
			{
				Vector(301.97,-1874.97,-277.97),
				Vector(-353.97,-1874.97,-277.97),
				Vector(-353.97,-1463.03,-277.97),
				Vector(301.97,-1463.03,-277.97),
			},
			{
				Vector(940.03,-1200.03,-277.97),
				Vector(1351.97,-1200.03,-277.97),
				Vector(1351.97,-1874.97,-277.97),
				Vector(940.03,-1874.97,-277.97),
			},
			{
				Vector(940.03,-548.03,-277.97),
				Vector(1351.97,-548.03,-277.97),
				Vector(1351.97,-1190.97,-277.97),
				Vector(940.03,-1190.97,-277.97),
			},
			{
				Vector(1351.97,106.97,-277.97),
				Vector(1351.97,-537.97,-277.97),
				Vector(940.03,-537.97,-277.97),
				Vector(940.03,106.97,-277.97),
			},
		})
	end

	local groundsnow = {}
	for _, poly in pairs(groundsnowvecs) do
		local p = {}

		for k, pos in pairs(poly) do
			local u = pos.x / 128
			local v = pos.y / 128
			p[k] = {pos + Vector(0,0,0.5), u, v}
		end

		table.insert(groundsnow, p)
	end

	self.mesh = groundsnow

	if self:GetType() == "sand" then
		self.mat = Material("fm/sand")
	elseif self:GetType() == "snow" then
		self.mat = Material("fm/snow01")
	elseif self:GetType() == "grass" then
		self.mat = Material("fm/grass")
	end
end

function ENT:CustomDraw()
	self:InitializeGroundMesh()

	render.SuppressEngineLighting(true)
	for _,v in pairs(self.mesh) do
		render.SetMaterial(self.mat)
		render.SetColorModulation(0.5, 0.5, 0.5)

		mesh.Begin(MATERIAL_POLYGON, #v)
		for _, v2 in pairs(v) do
			mesh.Color(0, 0, 0, 255)
			mesh.Position(v2[1])
			mesh.TexCoord(0, v2[2], v2[3])
			mesh.Normal(Vector(0, 0, 1))
			mesh.AdvanceVertex()
		end
		mesh.End()
	end
	render.SuppressEngineLighting(false)
end

local convar = CreateClientConVar("fm_drawcustomground", 1, true, false)
AddSettingsItem("quality", "checkbox", "fm_drawcustomground", {lbl = "Draw Custom Ground"})

--We want to always draw it so we do it here instead of the entity's Draw method
hook.Add("PostDrawOpaqueRenderables", "CustomSandDraw", function(drawingdepth, drawingskybox)
	if not IsValid(currentGroundEntity) then return end
	if not convar:GetBool() then return end
	if drawingskybox then return end

	currentGroundEntity:CustomDraw()
end)
