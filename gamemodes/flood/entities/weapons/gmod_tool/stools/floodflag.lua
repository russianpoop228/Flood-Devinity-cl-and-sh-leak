TOOL.Category = "Construction"
TOOL.Name     = "#tool.floodflag.name"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
}

TOOL.ClientConVar[ "material" ] = "icon32/flagicons/bear.png"
TOOL.ClientConVar[ "drawteamname" ] = 1
TOOL.ClientConVar[ "drawsymbol" ] = 1

if CLIENT then
	language.Add( "tool.floodflag.name", "Flag" )
	language.Add( "tool.floodflag.desc", "Spawns a flag with your team's colors." )
	language.Add( "tool.floodflag.left", "Spawn a flag")
	language.Add( "tool.floodflag.right", "Spawn a flag without welding it")
	language.Add( "tool.floodflag.drawteamname", "Draw team name")
	language.Add( "tool.floodflag.drawteamname.help", "Whether your teams name should be displayed underneath the symbol")
	language.Add( "tool.floodflag.drawsymbol", "Draw symbol")
	language.Add( "tool.floodflag.drawsymbol.help", "Whether to draw a symbol or not")
	language.Add( "SBoxLimit_flags", "You've hit the Flags limit!")
end

function TOOL:PositionFlag(trace)
	local pos = trace.HitPos

	local ang = trace.HitNormal:Angle()
	ang:RotateAroundAxis(ang:Right(), -90)

	return pos, ang
end

function TOOL:SpawnFlag(trace, weld)
	if self:GetOwner():GetCount("flags") >= FlagsPerPlayer then
		if SERVER then self:GetOwner():LimitHit("flags") end
		return false
	end

	if CLIENT then return true end

	local inteam = self:GetOwner():CTeam() != nil
	local teamname = false

	local mat = false
	if self:GetOwner():GetVIPTier() >= RANK_SILVER then
		if inteam and self:GetClientNumber("drawteamname") > 0 then
			teamname = self:GetOwner():CTeam().name
		end

		if self:GetClientNumber("drawsymbol") > 0 then
			if not list.Contains("FlagMaterials", self:GetClientInfo("material")) then return end

			mat = string.match(self:GetClientInfo("material"), "icon32/flagicons/([%w%-%_]+)%.png")
			if not mat then return end
		end
	end

	local pos, ang = self:PositionFlag(trace)

	local flag = ents.Create("fm_flag")
		flag:SetPos(pos)
		flag:SetAngles(ang)
		flag:Setup(inteam and self:GetOwner():CTeam():GetColor() or color_white, mat, teamname)
		flag:SetPlayer(self:GetOwner())
		flag:Spawn()
		flag:Activate()

	self:GetOwner():AddCount("flags", flag)

	undo.Create("Flag")
		if weld and IsValid(trace.Entity) then
			local const = constraint.Weld(flag, trace.Entity, 0, trace.PhysicsBone, 0, true, false)
			undo.AddEntity(const)
		end

		undo.AddEntity(flag)
		undo.SetPlayer(self:GetOwner())
		undo.SetCustomUndoText("Undone Flag.")
	undo.Finish()

	DoPropSpawnedEffect(flag)

	LogFile({"{ply1} spawned a flag", self:GetOwner()}, "prop")

	return true
end

function TOOL:LeftClick(trace)
	return self:SpawnFlag(trace, true)
end

function TOOL:RightClick(trace)
	return self:SpawnFlag(trace, false)
end

function TOOL:UpdateGhostFlag( ent, ply )
	if not IsValid(ent) then return end

	local trace = ply:GetEyeTrace()
	if not trace.Hit or
		(IsValid(trace.Entity) and trace.Entity:GetClass() == "fm_flag") then

		ent:SetNoDraw(true)
		return
	end

	local pos, ang = self:PositionFlag(trace)
	ent:SetPos(pos)
	ent:SetAngles(ang)

	ent:SetNoDraw(false)
end

function TOOL:Think()
	local mdl = "models/props_c17/signpole001.mdl"
	if not IsValid(self.GhostEntity) then
		self:MakeGhostEntity(mdl, Vector(0, 0, 0), Angle(0, 0, 0))
	end

	self:UpdateGhostFlag(self.GhostEntity, self:GetOwner())
end

local prettyname
local function AddFlagIcon(icon)
	prettyname = icon:gsub("^%l", string.upper):gsub(".png", "")
	list.Set("FlagMaterials", prettyname, string.format("icon32/flagicons/%s", icon))
end

local files = file.Find("materials/icon32/flagicons/*.png", "GAME")
for _, icon in pairs(files) do AddFlagIcon(icon) end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description =
"Spawns a flag in your team's colors.\n\n"..
"If you don't have a team your flag will default to white.\n\n"..
"If you're a Silver VIP or higher, you will be able to have a symbol along with your teamname on the flag." } )

	local disable = LocalPlayer():GetVIPTier() < RANK_SILVER

	local drawteamname = CPanel:AddControl( "Checkbox", {
		Label = "#tool.floodflag.drawteamname",
		Help = "#tool.floodflag.drawteamname",
		Command = "floodflag_drawteamname" } )
	drawteamname:SetDisabled(disable)

	local drawsymbol = CPanel:AddControl( "Checkbox", {
		Label = "#tool.floodflag.drawsymbol",
		Help = "#tool.floodflag.drawsymbol",
		Command = "floodflag_drawsymbol" } )
	drawsymbol:SetDisabled(disable)

	if not disable then
		CPanel:MatSelect( "floodflag_material", list.Get("FlagMaterials"), true, 1 / 5, 1 / 5 )
	end
end

function TOOL:Reload( trace )
end

if SERVER then
	hook.Add("FMOnChangePhase", "SetupFlags", function(old, new)
		if new == TIME_PREPARE then
			for k,v in pairs(ents.FindByClass("fm_flag")) do
				if #constraint.FindConstraints( v, "Weld" ) == 0 then v:Remove() continue end

				if IsValid(v:GetPhysicsObject()) then
					v:GetPhysicsObject():EnableCollisions(false)
				end
				v:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			end
		elseif old == TIME_REFLECT then
			for k,v in pairs(ents.FindByClass("fm_flag")) do
				if IsValid(v:GetPhysicsObject()) then
					v:GetPhysicsObject():EnableCollisions(true)
				end
				v:SetCollisionGroup(COLLISION_GROUP_NONE)
			end
		end
	end)
end
