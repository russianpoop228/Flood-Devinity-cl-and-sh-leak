TOOL.Category = "Construction"
TOOL.Name     = "#tool.floodmotor.name"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
}

if CLIENT then
	language.Add( "tool.floodmotor.name", "Boat Motor" )
	language.Add( "tool.floodmotor.desc", "Spawns a boatmotor." )
	language.Add( "tool.floodmotor.left", "Spawn a boatmotor")
	language.Add( "tool.floodmotor.right", "Spawn a boatmotor without welding it")
	language.Add( "SBoxLimit_boatmotors", "You've hit the Boat Motors limit!")
end

function TOOL:PositionMotor(trace)
	local pos = trace.HitPos + trace.HitNormal * 10

	local ang = trace.Normal:Angle()
	ang.p = 0
	ang.y = ang.y + 180
	ang.r = 0

	return pos, ang
end

function TOOL:SpawnMotor(trace, weld)
	if self:GetOwner():GetCount("boatmotors") >= MotorsPerPlayer then
		if SERVER then self:GetOwner():LimitHit("boatmotors") end
		return false
	end

	if CLIENT then return true end

	if IsValid(trace.Entity) then
		if not trace.Entity:PPCanTool(self:GetOwner(), "weld") then
			return false
		end
	end

	if not self:GetOwner():CanAfford(MotorCost) then
		self:GetOwner():Hint("You can't afford to buy a boat motor! ($" .. MotorCost .. ")")
		return
	end

	self:GetOwner():RoundStatsAdd("cashspent", MotorCost)

	self:GetOwner():GiveCash( -MotorCost )

	local pos, ang = self:PositionMotor(trace)

	local boatmotor = ents.Create("fm_boatmotor")
		boatmotor:SetPos(pos)
		boatmotor:SetAngles(ang)
		boatmotor:SetPlayer(self:GetOwner())
		boatmotor:Spawn()
		boatmotor.purchaseprice = MotorCost

	self:GetOwner():AddCount("boatmotors", boatmotor)

	undo.Create("fmboatmotorspawn")
		if weld and IsValid(trace.Entity) then
			local const = constraint.Weld(boatmotor, trace.Entity, 0, trace.PhysicsBone, 0, true, false)
			undo.AddEntity(const)
		end

		undo.EntityRefund(boatmotor, "boat motor")
		undo.SetPlayer(self:GetOwner())
	undo.Finish()

	DoPropSpawnedEffect(boatmotor)

	LogFile({"{ply1} spawned a boatmotor", self:GetOwner()}, "prop")

	return true
end

function TOOL:LeftClick(trace)
	return self:SpawnMotor(trace, true)
end

function TOOL:RightClick(trace)
	return self:SpawnMotor(trace, false)
end

function TOOL:UpdateGhostMotor( ent, ply )
	if not IsValid(ent) then return end

	local trace = ply:GetEyeTrace()
	if not trace.Hit or
		(IsValid(trace.Entity) and trace.Entity:GetClass() == "fm_boatmotor") then

		ent:SetNoDraw(true)
		return
	end

	local pos, ang = self:PositionMotor(trace)
	ent:SetPos(pos)
	ent:SetAngles(ang)

	ent:SetNoDraw(false)
end

function TOOL:Think()
	local mdl = "models/gibs/airboat_broken_engine.mdl"
	if not IsValid(self.GhostEntity) then
		self:MakeGhostEntity(mdl, Vector(0, 0, 0), Angle(0, 0, 0))
	end

	self:UpdateGhostMotor(self.GhostEntity, self:GetOwner())
end

function TOOL:Reload(trace)
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description =
"Spawns a boatmotor which you can use to steer and move your boat.\n\n" ..
"* A good idea is to place the motor at the back of your boat, facing backwards (like it does in reality)\n" ..
"* Hold E while looking at the motor to 'possess' it, which lets you control it.\n" ..
"* While you hold E, turn around so you face the front of your boat.\n" ..
"* While you hold E, hold Rightclick to throttle up, making the fan spin.\n" ..
"* While you hold E, you can now look to the right and your boat steers to the right.\n" ..
"* By releasing E, you will unpossess it.\n\n" ..
"The boatmotor is free during pirate!" } )
end

if SERVER then
	props.RegisterClassForRefund("fm_boatmotor", function(ent)
		local curhealth = ent:GetFMHealth()
		if curhealth < 1 then return 0 end

		local healthfraction = (curhealth / ent:GetFMMaxHealth()) or 0 -- maxhealth is always the actual initial health
		healthfraction = math.Clamp(healthfraction, 0, 1)

		local cashback = math.floor(healthfraction * ent.purchaseprice)
		if cashback < 1 then return 0 end

		return cashback
	end)
end
