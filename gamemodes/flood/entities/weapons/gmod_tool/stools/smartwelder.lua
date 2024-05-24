
TOOL.Category   = "Constraints"
TOOL.Name       = "#tool.smartwelder.name"
TOOL.ConfigName = ""
TOOL.Operating  = false
TOOL.Props      = {}
TOOL.Filter     = {}

TOOL.Information = {
	{ name = "left", stage = 0 },
	{ name = "left_1", stage = 1 },
	{ name = "right", stage = 2 },
	{ name = "reload", stage = 2 },
}

TOOL.ClientConVar["nocollide"]  = 1
TOOL.ClientConVar["eachother"]  = 1
TOOL.ClientConVar["freeze"]     = 1
TOOL.ClientConVar["clearwelds"] = 0
TOOL.ClientConVar["strength"]   = 0

if CLIENT then
	language.Add( "Undone_smartweld", "Undone Smart Weld" )

	language.Add("tool.smartwelder.name", "Weld - Smart")
	language.Add("tool.smartwelder.desc", "Automatically welds together multiple props")
	language.Add("tool.smartwelder.left", "Select a prop")
	language.Add("tool.smartwelder.left_1", "Select more props")
	language.Add("tool.smartwelder.right", "Finish")
	language.Add("tool.smartwelder.reload", "Clear selection")

	language.Add("tool.smartwelder.freeze", "Auto-freeze")
	language.Add("tool.smartwelder.freeze.help", "Whether all selected props should be frozen during the weld")
	language.Add("tool.smartwelder.clearwelds", "Remove welds")
	language.Add("tool.smartwelder.clearwelds.help", "Removes old welds inside the selection before smart welding")
end

function TOOL.BuildCPanel(cp)
	cp:AddControl("Header", {
		Text        = "#tool.smartwelder.name",
		Description = "#tool.smartwelder.desc"
	})

	cp:AddControl("Checkbox", {
		Label   = "#tool.smartwelder.freeze",
		Help    = "#tool.smartwelder.freeze",
		Command = "smartwelder_freeze"
	})

	cp:AddControl("Checkbox", {
		Label   = "#tool.smartwelder.clearwelds",
		Help    = "#tool.smartwelder.clearwelds",
		Command = "smartwelder_clearwelds"
	})
end

function TOOL:DelayedNotify(str, secs)
	local ply = self:GetOwner()

	timer.Simple(secs, function()
		if not IsValid(ply) then return end

		ply:PrintMessage(HUD_PRINTCENTER, str)
	end)
end

function TOOL:Notify(str)
	local ply = self:GetOwner()
	ply:PrintMessage(HUD_PRINTCENTER,str)
end

function TOOL:LeftClick( trace )
	if self:CheckOperating(true) then return false end

	if not trace.Hit then return false end
	if trace.Entity:IsPlayer() then return false end

	if SERVER and not util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) then return false end
	if CLIENT then return true end

	if self:IsSelectable(trace.Entity) then
		if self:IsSelected(trace.Entity) then
			self:DeSelect(trace.Entity)
		else
			self:Select(trace.Entity)
		end
	else
		return false
	end
	self:CheckStage()
	return true
end

--Finds and removes all welds off an entity
function TOOL:ClearWelds(ent)
	local constraints = constraint.FindConstraints( ent, "Weld" )
	for _,const in pairs(constraints) do
		for cent,_ in pairs(self.Props) do
			if cent != ent and const.Ent2 == cent and IsValid(cent) then
				const.Constraint:Remove()
			end
		end
	end
end

function TOOL:RightClick()
	if self:CheckOperating(true) then return false end

	self:CheckStage()

	local amount = table.Count(self.Props)
	if amount == 0 then
		self:Notify("No props selected!")
		return false
	end

	self.Operating = true

	local freeze = self:GetClientNumber("freeze") > 0
	local clearwelds = self:GetClientNumber("clearwelds") > 0

	local complete,welded,failed,skipped = 0,{},0,0
	self.undoents = {}
	for ent, _ in pairs(self.Props) do
		if not IsValid(ent) then
			self:DeSelect(ent)
			continue
		end

		if freeze then
			local entphys = ent:GetPhysicsObject()
			if IsValid(entphys) then
				entphys:EnableMotion(false)
				entphys:Sleep()
			end
		end

		if amount == 1 then
			break
		end

		if clearwelds then
			self:ClearWelds(ent)
		end

		complete = complete + 1
		timer.Simple(0.1 * complete,function()
			if not IsValid(self:GetSWEP()) then return end

			welded[ent] = true
			local i = 0
			for oent,_ in pairs(self.Props) do
				if not IsValid(oent) then continue end
				if welded[oent] then continue end
				i = i + 1
				timer.Simple(0.001 * i,function()
					if not IsValid(self:GetSWEP()) then return end
					if not IsValid(ent) or not IsValid(oent) then return end

					if ent:WithinWeldRadius(oent) then
						local weld = self:WeldEnts(ent,oent)

						if weld == false then
							failed = failed + 1
						else
							table.insert(self.undoents, weld)
						end
					else
						skipped = skipped + 1
					end
				end)
			end
		end)
	end
	timer.Simple(0.1 * (complete + 1),function()
		self:WeldingFinished(welded,failed,skipped)
	end)
end

function TOOL:WeldingFinished(welded,failed,skipped)
	if not IsValid(self:GetSWEP()) then return end

	undo.Create("smartweld")
		undo.SetPlayer(self:GetOwner())
		for _, v in pairs(self.undoents or {}) do
			undo.AddEntity(v)
		end
	undo.Finish()

	self:ResetSelection()
	self:Notify("Welded " .. table.Count(welded) .. " entities")
	if failed > 0 then self:DelayedNotify("Failed to weld " .. failed .. " times", 2) end
	if skipped > 0 then self:DelayedNotify("Skipped " .. skipped .. " welds due to props being too far apart", 4) end
	self:CheckStage()
	self.Operating = false
end

function TOOL:WeldEnts(ent1, ent2)
	if IsValid(ent1) and IsValid(ent2) then
		return constraint.Weld( ent1, ent2, 0, 0, 0, false )
	end
	return false
end

if SERVER then
	util.AddNetworkString("smartweld_addent")
	util.AddNetworkString("smartweld_delent")
	util.AddNetworkString("smartweld_sendweldables")
end

local SelectedEntities = {}
function TOOL:UpdateWeldables()
	local validwelds = {}

	for k, _ in pairs(SelectedEntities) do
		if not IsValid(k) then continue end
		for k2, _ in pairs(SelectedEntities) do
			if k == k2 or not IsValid(k2) then continue end

			local e1 = k:EntIndex()
			local e2 = k2:EntIndex()

			--The same two props will always generate the same index
			local idx
			if e1 > e2 then
				idx = e2 .. "_" .. e1
			else
				idx = e1 .. "_" .. e2
			end

			if validwelds[idx] then continue end -- Already added

			if k:WithinWeldRadius(k2) then
				validwelds[idx] = {k, k2}
			end
		end
	end

	net.Start("smartweld_sendweldables")
		for _, v in pairs(validwelds) do
			net.WriteEntity(v[1])
			net.WriteEntity(v[2])
		end
	net.Send(self:GetOwner())
end

function TOOL:Select(ent)
	if not IsValid(ent) then return false end
	if self:IsSelected(ent) then return end

	SelectedEntities[ent] = {ply = self:GetOwner()}
	self.Props[ent] = SelectedEntities[ent]

	net.Start("smartweld_addent")
		net.WriteEntity(ent)
	net.Send(self:GetOwner())

	self:UpdateWeldables()

	return true
end

function TOOL:DeSelect(ent)
	local Selection = SelectedEntities[ent]
	if not Selection then return false end

	SelectedEntities[ent] = nil
	self.Props[ent] = SelectedEntities[ent]

	net.Start("smartweld_delent")
		net.WriteEntity(ent)
	net.Send(self:GetOwner())

	self:UpdateWeldables()

	return true
end

function TOOL:IsSelectable(ent)
	return IsValid(ent) and IsValid(ent:GetPhysicsObject()) and ent:FMOwner():SameTeam(self:GetOwner())

end

function TOOL:ResetSelection(ply)
	if not IsValid(ply) then ply = self:GetOwner() end

	for ent,v in pairs(SelectedEntities) do
		if v.ply == ply then
			self:DeSelect(ent)
		end
	end
end
function TOOL:IsSelected(ent)
	return tobool(SelectedEntities[ent])
end
function TOOL:CheckOperating(warn)
	local oper = tobool(self.Operating)
	if oper and warn then
		self:Notify("Please wait until the previous operation finishes")
	end
	return oper
end
function TOOL:CheckStage()
	local cnt = table.Count(self.Props)
	local stage = cnt == 0 and 0 or (cnt > 1 and 2 or 1)
	self:SetStage(stage)
end
function TOOL:Reload( trace )
	if self:CheckOperating(true) then return false end

	self:ResetSelection()
	self:CheckStage()
	self:Notify("Selection cleared!")
end
function TOOL:Holster()
	if self:CheckOperating() then return false end
	self:ResetSelection()
end

if SERVER then return end

local entlist = {}
net.Receive("smartweld_addent", function()
	table.insert(entlist, net.ReadEntity())
end)

net.Receive("smartweld_delent", function()
	local ent = net.ReadEntity()

	for k,v in pairs(entlist) do
		if v == ent then
			table.remove(entlist, k)
			break
		end
	end
end)

local validwelds = {}
net.Receive("smartweld_sendweldables", function(l)
	validwelds = {}
	for _ = 1, (l / 16 / 2) do
		table.insert(validwelds, {net.ReadEntity(), net.ReadEntity()})
	end
end)

local mat1 = Material("models/debug/debugwhite")
local mat2 = Material("cable/physbeam")
hook.Add("PostDrawTranslucentRenderables", "smartweld", function(a,b)

	local w = LocalPlayer():GetActiveWeapon()
	if not w or not w.Mode or w.Mode != "smartwelder" then return end

	cam.Start3D(EyePos(), EyeAngles())
	render.MaterialOverride(mat1)
	render.SetColorModulation(0.3,0.3,0)
	for _, v in pairs(entlist) do
		if IsValid(v) then
			v:DrawModel()
		end
	end
	render.SetColorModulation(1,1,1)
	render.MaterialOverride()
	cam.End3D()

	if validwelds then
		cam.IgnoreZ(true)
		render.SetMaterial(mat2)
		for _, v in pairs(validwelds) do
			local v1 = v[1]
			local v2 = v[2]

			if not IsValid(v1) or not IsValid(v2) then continue end

			local d = v1:GetPos():Distance(v2:GetPos())

			render.DrawBeam(v1:GetPos(), v2:GetPos(), 5, 0, d / 5, Color(255,255,255,255))
		end
		cam.IgnoreZ(false)
	end

end)


