
TOOL.Category = "Constraints"
TOOL.Name = "#tool.rope.name"

TOOL.ClientConVar[ "forcelimit" ] = "0"
TOOL.ClientConVar[ "addlength" ] = "0"
TOOL.ClientConVar[ "material" ] = "cable/rope"
TOOL.ClientConVar[ "width" ] = "2"
TOOL.ClientConVar[ "rigid" ] = "0"

local maxWidth = 10
TOOL.Information = {
	{ name = "left", stage = 0 },
	{ name = "left_1", stage = 1 },
	{ name = "right", stage = 1 },
	{ name = "reload" }
}

if SERVER then
	-- This is originally only done on the client
	list.Set( "RopeMaterials", "#ropematerial.rope",		"cable/rope" )
	list.Set( "RopeMaterials", "#ropematerial.cable",		"cable/cable2" )
	list.Set( "RopeMaterials", "#ropematerial.xbeam",		"cable/xbeam" )
	list.Set( "RopeMaterials", "#ropematerial.laser",		"cable/redlaser" )
	list.Set( "RopeMaterials", "#ropematerial.electric",	"cable/blue_elec" )
	list.Set( "RopeMaterials", "#ropematerial.physbeam",	"cable/physbeam" )
	list.Set( "RopeMaterials", "#ropematerial.hydra",		"cable/hydra" )
end

function TOOL:LeftClick( trace )

	if ( IsValid( trace.Entity ) && trace.Entity:IsPlayer() ) then return end

	-- If there's no physics object then we can't constraint it!
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

	local iNum = self:NumObjects()

	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 0 ) then
		local Ent1, Ent2 = self:GetEnt( 1 ), self:GetEnt( 2 )

		local ret, err = hook.Run("FMCanRopeEnts", Ent1, Ent2)
		if ret == false then
			self:GetOwner():HintError(err)
			self:ClearObjects()
			return false
		end

		if ( CLIENT ) then

			self:ClearObjects()
			return true

		end

		-- Get client's CVars
		local forcelimit = self:GetClientNumber( "forcelimit" )
		local addlength = self:GetClientNumber( "addlength" )
		local material = self:GetClientInfo( "material" )
		local width = math.Clamp(self:GetClientNumber( "width" ), 0, maxWidth)
		local rigid = self:GetClientNumber( "rigid" ) == 1

		if not list.Contains("RopeMaterials", material) then
			material = "cable/rope"
		end

		-- Get information we're about to use
		local Bone1, Bone2 = self:GetBone( 1 ), self:GetBone( 2 )
		local WPos1, WPos2 = self:GetPos( 1 ), self:GetPos( 2 )
		local LPos1, LPos2 = self:GetLocalPos( 1 ), self:GetLocalPos( 2 )
		local length = ( WPos1 - WPos2 ):Length()

		local constraint, rope = constraint.Rope( Ent1, Ent2, Bone1, Bone2, LPos1, LPos2, length, addlength, forcelimit, width, material, rigid )

		-- Clear the objects so we're ready to go again
		self:ClearObjects()

		-- Add The constraint to the players undo table

		undo.Create( "Rope" )
			undo.AddEntity( constraint )
			undo.AddEntity( rope )
			undo.SetPlayer( self:GetOwner() )
		undo.Finish()

		self:GetOwner():AddCleanup( "ropeconstraints", constraint )
		self:GetOwner():AddCleanup( "ropeconstraints", rope )

	else

		self:SetStage( iNum + 1 )

	end

	return true

end

function TOOL:RightClick( trace )

	if ( IsValid( trace.Entity ) && trace.Entity:IsPlayer() ) then return end

	local iNum = self:NumObjects()

	local Phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
	self:SetObject( iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal )

	if ( iNum > 0 ) then
		local Ent1, Ent2 = self:GetEnt( 1 ), self:GetEnt( 2 )

		local ret, err = hook.Run("FMCanRopeEnts", Ent1, Ent2)
		if ret == false then
			self:GetOwner():HintError(err)
			self:ClearObjects()
			return false
		end

		if ( CLIENT ) then

			self:ClearObjects()
			return true

		end

		-- Get client's CVars
		local forcelimit = self:GetClientNumber( "forcelimit" )
		local addlength = self:GetClientNumber( "addlength" )
		local material = self:GetClientInfo( "material" )
		local width = math.Clamp(self:GetClientNumber( "width" ), 0, maxWidth)
		local rigid = self:GetClientNumber( "rigid" ) == 1

		if not list.Contains("RopeMaterials", material) then
			material = "cable/rope"
		end

		-- Get information we're about to use
		local Bone1, Bone2 = self:GetBone( 1 ), self:GetBone( 2 )
		local WPos1, WPos2 = self:GetPos( 1 ), self:GetPos( 2 )
		local LPos1, LPos2 = self:GetLocalPos( 1 ), self:GetLocalPos( 2 )
		local length = ( WPos1 - WPos2 ):Length()

		local constraint, rope = constraint.Rope( Ent1, Ent2, Bone1, Bone2, LPos1, LPos2, length, addlength, forcelimit, width, material, rigid )

		-- Clear the objects and set the last object as object 1
		self:ClearObjects()

		iNum = self:NumObjects()
		self:SetObject( iNum + 1, Ent2, trace.HitPos, Phys, Bone2, trace.HitNormal )
		self:SetStage( iNum + 1 )

		-- Add The constraint to the players undo table
		undo.Create( "Rope" )
			undo.AddEntity( constraint )
			if ( IsValid( rope ) ) then undo.AddEntity( rope ) end
			undo.SetPlayer( self:GetOwner() )
		undo.Finish()

		self:GetOwner():AddCleanup( "ropeconstraints", constraint )
		self:GetOwner():AddCleanup( "ropeconstraints", rope )

	else

		self:SetStage( iNum + 1 )

	end

	return true

end

function TOOL:Reload( trace )

	if ( !IsValid( trace.Entity ) || trace.Entity:IsPlayer() ) then return false end
	if ( CLIENT ) then return true end

	return constraint.RemoveConstraints( trace.Entity, "Rope" )

end

function TOOL:Holster()

	self:ClearObjects()

end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.rope.help" } )

	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "rope", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

	CPanel:AddControl( "Slider", { Label = "#tool.forcelimit", Command = "rope_forcelimit", Type = "Float", Min = 0, Max = 1000, Help = true } )
	CPanel:AddControl( "Slider", { Label = "#tool.rope.addlength", Command = "rope_addlength", Type = "Float", Min = -500, Max = 500, Help = true } )

	CPanel:AddControl( "CheckBox", { Label = "#tool.rope.rigid", Command = "rope_rigid", Help = true } )

	CPanel:AddControl( "Slider", { Label = "#tool.rope.width", Command = "rope_width", Type = "Float", Min = 0, Max = maxWidth } )
	CPanel:AddControl( "RopeMaterial", { Label = "#tool.rope.material", ConVar = "rope_material" } )

end
