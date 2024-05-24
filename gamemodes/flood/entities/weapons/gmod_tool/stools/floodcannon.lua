TOOL.Category = "Construction"
TOOL.Name     = "#tool.floodcannon.name"

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
}

if CLIENT then
	language.Add( "tool.floodcannon.name", "Cannon" )
	language.Add( "tool.floodcannon.desc", "Spawns a cannon." )
	language.Add( "tool.floodcannon.left", "Spawn a cannon")
	language.Add( "tool.floodcannon.right", "Spawn a cannon without welding it")
	language.Add( "SBoxLimit_cannons", "You've hit the Cannon limit!")
end

function TOOL:PositionCannon(trace)
	local pos = trace.HitPos + trace.HitNormal * 10

	local ang = trace.Normal:Angle()
	ang.p = 0
	ang.r = 0

	pos = pos + ang:Forward() * 115

	return pos, ang
end

function TOOL:SpawnCannon(trace, weld)
	if self:GetOwner():GetCount("cannons") >= CannonsPerPlayer then
		if SERVER then self:GetOwner():LimitHit("cannons") end
		return false
	end

	if (SERVER and (not IsEventRunning() or CurrentEventTable().Name != "Pirate")) or (CLIENT and (not CUREVENT or CUREVENT != "pirate")) then
		if SERVER then
			self:GetOwner():Hint("This is only useable during the pirate event!")
		end
		return false
	end

	if not self:GetOwner():CanAfford(CannonCost) then
		if SERVER then
			self:GetOwner():Hint("You can't afford to buy a cannon! ($" .. CannonCost .. ")")
		end
		return false
	end

	if CLIENT then return true end

	if IsValid(trace.Entity) then
		if not trace.Entity:PPCanTool(self:GetOwner(), "weld") then
			return false
		end
	end

	self:GetOwner():RoundStatsAdd("cashspent", CannonCost)

	self:GetOwner():GiveCash(-CannonCost)

	local pos, ang = self:PositionCannon(trace)

	local cannon = ents.Create("fm_cannon")
		cannon:SetPos(pos)
		cannon:SetAngles(ang)
		cannon:SetPlayer(self:GetOwner())
		cannon:Spawn()
		cannon.purchaseprice = CannonCost

	self:GetOwner():AddCount("cannons", cannon)

	undo.Create("fmcannonspawn")
		if weld and IsValid(trace.Entity) then
			local const = constraint.Weld(cannon, trace.Entity, 0, trace.PhysicsBone, 0, true, false)
			undo.AddEntity(const)
		end

		undo.EntityRefund(cannon, "cannon")
		undo.SetPlayer(self:GetOwner())
	undo.Finish()

	DoPropSpawnedEffect(cannon)

	LogFile({"{ply1} spawned a cannon", self:GetOwner()}, "prop")

	return true
end

function TOOL:LeftClick(trace)
	return self:SpawnCannon(trace, true)
end

function TOOL:RightClick(trace)
	return self:SpawnCannon(trace, false)
end

function TOOL:UpdateGhostCannon( ent, ply )
	if not IsValid(ent) then return end

	local trace = ply:GetEyeTrace()
	if not trace.Hit or
		(IsValid(trace.Entity) and trace.Entity:GetClass() == "fm_cannon") or
		(not CUREVENT or CUREVENT != "pirate") then

		ent:SetNoDraw(true)
		return
	end

	local pos, ang = self:PositionCannon(trace)
	ent:SetPos(pos)
	ent:SetAngles(ang)

	ent:SetNoDraw(false)
end

function TOOL:Think()
	local mdl = "models/solidarity/cannon.mdl"
	if not IsValid(self.GhostEntity) then
		self:MakeGhostEntity(mdl, Vector(0, 0, 0), Angle(0, 0, 0))
	end

	self:UpdateGhostCannon(self.GhostEntity, self:GetOwner())
end

function TOOL:Reload( trace )
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description =
"Spawns a powerful cannon that does blastdamage on props.\n" ..
"The cannonball has a chance of unwelding props it hits!\n\n" ..

"* Hold E while looking at the cannon to 'possess' it, which lets you control it.\n" ..
"* While you hold E, look around and the cannon follows your aim (Only works during fight).\n" ..
"* While you hold E, press Leftclick to fire a cannonball.\n" ..
"* By releasing E, you will unpossess it.\n\n" ..

"The cannon is only available during the pirate event." } )
end

if SERVER then
	props.RegisterClassForRefund("fm_cannon", function(ent)
		local curhealth = ent:GetFMHealth()
		if curhealth < 1 then return 0 end

		local healthfraction = (curhealth / ent:GetFMMaxHealth()) or 0 -- maxhealth is always the actual initial health
		healthfraction = math.Clamp(healthfraction, 0, 1)

		local cashback = math.floor(healthfraction * ent.purchaseprice)
		if cashback < 1 then return 0 end

		return cashback
	end)
end
