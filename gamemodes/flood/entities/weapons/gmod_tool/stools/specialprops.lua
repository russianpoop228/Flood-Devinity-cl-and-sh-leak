TOOL.Category = "Construction"
TOOL.Name     = "#tool.specialprops.name"

TOOL.Information = {
	{ name = "left" }
}

TOOL.ClientConVar[ "type" ] = 1

if CLIENT then
	language.Add("tool.specialprops.name", "Special Props")
	language.Add("tool.specialprops.desc", "Spawns a unique prop with special abilities.")
	language.Add("tool.specialprops.left", "Spawn the special prop")
end

local function teamHasSpecialProp(tea)
	for _, ply in pairs(tea:GetAllMembers()) do
		if IsValid(ply.curSpecialProp) then
			return true
		end
	end

	return false
end

function TOOL:CanSpawnProp()
	if IsValid(self:GetOwner().curSpecialProp) then
		return false
	end

	local tea = self:GetOwner():CTeam()
	if IsValid(tea) and teamHasSpecialProp(tea) then
		return false
	end

	return true
end

function TOOL:SpawnProp(trace, weld)
	if CLIENT then return true end

	if not self:CanSpawnProp() then self:GetOwner():HintError("You or your team has already spawned a special prop.") return false end

	local class = self:GetClientInfo("type")

	if not self:IsValidPropType(class) then return false end

	local ret, err = hook.Run("FMCanSpawnSpecialProp", self:GetOwner(), class)
	if ret == false then
		if err then
			self:GetOwner():HintError(err)
		end
		return false
	end

	local proptbl = self:GetPropTableByClass(class)
	local price = proptbl.cost

	if not self:GetOwner():CanAfford(price) then
		self:GetOwner():HintError("You can't afford that!")
		return false
	end

	local ang = trace.HitNormal:Angle()
	ang.pitch = ang.pitch + 90

	local prop = ents.Create(class)
		prop:SetPos(trace.HitPos)
		prop:Spawn()
		prop:Activate()

		local pos = trace.HitPos - (trace.HitNormal * 512)
		pos = prop:NearestPoint(pos)
		pos = prop:GetPos() - pos
		pos = trace.HitPos + pos
		prop:SetPos(pos)

		prop:SetAngles(ang)
		prop:PPSetOwner(self:GetOwner())
		prop.purchaseprice = price

	self:GetOwner():RoundStatsAdd("cashspent", price)
	self:GetOwner():GiveCash(-price)

	self:GetOwner().curSpecialProp = prop

	undo.Create("SpecialProp")
		undo.EntityRefund(prop, "special prop")
		undo.SetPlayer(self:GetOwner())
	undo.Finish()

	DoPropSpawnedEffect(prop)

	LogFile({("{ply1} spawned a special prop (%s)"):format(class), self:GetOwner()}, "prop")

	return true
end

function TOOL:LeftClick(trace)
	return self:SpawnProp(trace, true)
end

function TOOL:RightClick(trace)
	return self:SpawnProp(trace, false)
end

hook.Add("FMPlayerJoinTeam", "SpecialProp", function(ply, tea, force)
	if force then return end

	if not IsValid(ply.curSpecialProp) then return end

	if teamHasSpecialProp(tea) then
		ply.curSpecialProp:Refund(1)
		ply:Hint("Your special prop was refunded because the team you joined already had one.")
	end
end)

function TOOL:UpdateGhost( ent, ply )
	if not IsValid(ent) then return end

	local trace = ply:GetEyeTrace()
	if not trace.Hit then
		ent:SetNoDraw(true)
		return
	end

	local ang = trace.HitNormal:Angle()
	ang.pitch = ang.pitch + 90

	ent:SetPos(trace.HitPos)

	local pos = trace.HitPos - (trace.HitNormal * 512)
	pos = ent:NearestPoint(pos)
	pos = ent:GetPos() - pos
	pos = trace.HitPos + pos
	ent:SetPos(pos)

	ent:SetAngles(ang)

	ent:SetNoDraw(false)
end

function TOOL:IsValidPropType(typ)
	-- Cache valid prop types
	if not self.validPropTypes then
		self.validPropTypes = {}
		for _, proptbl in pairs(list.GetForEdit("FMSpecialProps")) do
			self.validPropTypes[proptbl.class] = true
		end
	end

	return self.validPropTypes[typ] or false
end

function TOOL:Think()

	local class = self:GetClientInfo("type")
	if not self:IsValidPropType(class) then self:ReleaseGhostEntity() return end

	if not IsValid(self.GhostEntity) or self.GhostEntity.class != class then
		self:MakeGhostEntity(self:GetPropTableByClass(class).model, Vector(0, 0, 0), Angle(0, 0, 0))

		if self.GhostEntity then
			self.GhostEntity.class = class
		end
	end

	self:UpdateGhost(self.GhostEntity, self:GetOwner())
end

function TOOL:GetPropTableByClass(class)
	for _, proptbl in pairs(list.GetForEdit("FMSpecialProps")) do
		if proptbl.class == class then
			return proptbl
		end
	end
end

function TOOL.BuildCPanel( CPanel )
	CPanel:AddControl( "Header", { Description =
"Spawn special props that enhance your fight performance.\nOnly one can be spawned per team.\nCan be reused like regular props." } )

	local specialProps = table.ClearKeys(list.Get("FMSpecialProps"))
	table.sort(specialProps, function(a, b)
		return a.name < b.name
	end)

	local cont = vgui.Create("DPanel")
		cont:SetBackgroundColor(Color(100, 100, 100))
		cont:SetTall(400)

	local scroll = cont:Add("DScrollPanel")
		scroll:Dock(FILL)

	local conv = GetConVar("specialprops_type")
	for k, proptbl in pairs(specialProps) do
		local proppnl = scroll:Add("DPanel")
			proppnl:DockPadding(5, 5, 5, 5)
			proppnl:DockMargin(5, k > 1 and 0 or 5, 5, 5)
			proppnl:Dock(TOP)
			proppnl:SetTall(160)
			proppnl.proptbl = proptbl
			proppnl.Think = function(self)
				if conv:GetString() == self.proptbl.class then
					self:SetBackgroundColor(Color(150, 255, 150))
				else
					self:SetBackgroundColor(Color(150, 150, 150))
				end
			end

		local header = proppnl:Add("DLabel")
			header:Dock(TOP)
			header:DockMargin(0, 0, 0, 5)
			header:SetText(proptbl.name)
			header:SetFont("FMRegular24")
			header:SizeToContentsY()

		local mdlimg = proppnl:Add("SpawnIcon")
			mdlimg:SetSize(120, 120)
			mdlimg:SetModel(proptbl.model)

		local healthlbl = proppnl:Add("DLabel")
			healthlbl:Dock(TOP)
			healthlbl:DockMargin(125, 0, 0, 0)
			healthlbl:SetTextColor(Color(200, 0, 0))
			healthlbl:SetText(("Health: %i"):format(proptbl.health))
			healthlbl:SetFont("FMRegular18")
			healthlbl:SizeToContents()

		local costlbl = proppnl:Add("DLabel")
			costlbl:Dock(TOP)
			costlbl:DockMargin(125, 0, 0, 0)
			costlbl:SetTextColor(Color(0, 200, 0))
			costlbl:SetText(("Cost: %s"):format(FormatMoney(proptbl.cost)))
			costlbl:SetFont("FMRegular18")
			costlbl:SizeToContents()

		local cldwnlbl = proppnl:Add("DLabel")
			cldwnlbl:Dock(TOP)
			cldwnlbl:DockMargin(125, 0, 0, 0)
			cldwnlbl:SetTextColor(Color(0, 0, 200))
			cldwnlbl:SetText(("Cooldown: %i seconds"):format(proptbl.cooldown))
			cldwnlbl:SetFont("FMRegular18")
			cldwnlbl:SizeToContents()

		local desclbl = proppnl:Add("DLabelWordWrap2")
			desclbl:Dock(TOP)
			desclbl:DockMargin(125, 10, 0, 0)
			desclbl:SetText(proptbl.desc)
			desclbl:SetFont("FMRegular18")
			desclbl:SizeToContents()

		local coverbtn = vgui.Create("DButton", proppnl)
			coverbtn.Paint = function() end
			coverbtn:SetText("")
			coverbtn.DoClick = function()
				RunConsoleCommand("specialprops_type", proptbl.class)
			end

		proppnl.PerformLayout = function(self, w, h)
			coverbtn:SetSize(w, h)

			mdlimg:SetPos(0, 5 + header:GetTall())

			local calch = 5 + header:GetTall() +
				math.max(mdlimg:GetTall(),
					healthlbl:GetTall() +
					costlbl:GetTall() +
					cldwnlbl:GetTall() +
					10 + desclbl:GetTall()
				) + 10

			if h != calch then
				proppnl:SetTall(calch)
			end
		end
	end

	CPanel:AddPanel(cont)
end

function TOOL:Reload( trace )
end
