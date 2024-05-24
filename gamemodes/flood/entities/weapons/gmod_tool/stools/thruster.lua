
TOOL.Category = "Construction"
TOOL.Name = "#tool.thruster.name"

TOOL.ClientConVar[ "force" ] = tostring(MaxThrusterForce or 100)
TOOL.ClientConVar[ "model" ] = "models/MaxOfS2D/thruster_propeller.mdl"
TOOL.ClientConVar[ "keygroup" ] = "45"
TOOL.ClientConVar[ "keygroup_back" ] = "42"
TOOL.ClientConVar[ "toggle" ] = "0"
TOOL.ClientConVar[ "collision" ] = "0"
TOOL.ClientConVar[ "effect" ] = "fire"
TOOL.ClientConVar[ "damageable" ] = "0"
TOOL.ClientConVar[ "soundname" ] = "PhysicsCannister.ThrusterLoop"

TOOL.Information = { { name = "left" } }

cleanup.Register( "thrusters" )

if SERVER then
	props.RegisterClassForRefund("gmod_thruster", function(ent)
		local curhealth = ent:GetFMHealth()
		if curhealth < 1 then return 0 end

		local healthfraction = (curhealth / ent:GetFMMaxHealth()) or 0 -- maxhealth is always the actual initial health
		healthfraction = math.Clamp(healthfraction, 0, 1)

		local cashback = math.floor(healthfraction * ent.purchaseprice)
		if cashback < 1 then return 0 end

		return cashback
	end)
end

local function IsValidThrusterModel( model )
	for mdl, _ in pairs( list.Get( "ThrusterModels" ) ) do
		if ( mdl:lower() == model:lower() ) then return true end
	end
	return false
end

function TOOL:LeftClick( trace )

	if ( trace.Entity && trace.Entity:IsPlayer() ) then return false end

	-- If there's no physics object then we can't constraint it!
	if ( SERVER && !util.IsValidPhysicsObject( trace.Entity, trace.PhysicsBone ) ) then return false end

	if ( CLIENT ) then return true end

	local ply = self:GetOwner()

	local force = math.Clamp( self:GetClientNumber( "force" ), 0, MaxThrusterForce )
	local model = "models/MaxOfS2D/thruster_propeller.mdl"
	local key = self:GetClientNumber( "keygroup" )
	local key_bk = self:GetClientNumber( "keygroup_back" )
	local toggle = self:GetClientNumber( "toggle" )
	local collision = self:GetClientNumber( "collision" ) == 0
	local effect = self:GetClientInfo( "effect" )
	local damageable = self:GetClientNumber( "damageable" )
	local soundname = self:GetClientInfo( "soundname" )

	-- If we shot a thruster change its force
	if ( IsValid( trace.Entity ) && trace.Entity:GetClass() == "gmod_thruster" && trace.Entity.pl == ply ) then

		trace.Entity:SetForce( force )
		trace.Entity:SetEffect( effect )
		trace.Entity:SetToggle( toggle == 1 )
		trace.Entity.ActivateOnDamage = damageable == 1
		trace.Entity:SetSound( soundname )

		numpad.Remove( trace.Entity.NumDown )
		numpad.Remove( trace.Entity.NumUp )
		numpad.Remove( trace.Entity.NumBackDown )
		numpad.Remove( trace.Entity.NumBackUp )

		trace.Entity.NumDown = numpad.OnDown( ply, key, "Thruster_On", trace.Entity, 1 )
		trace.Entity.NumUp = numpad.OnUp( ply, key, "Thruster_Off", trace.Entity, 1 )

		trace.Entity.NumBackDown = numpad.OnDown( ply, key_bk, "Thruster_On", trace.Entity, -1 )
		trace.Entity.NumBackUp = numpad.OnUp( ply, key_bk, "Thruster_Off", trace.Entity, -1 )

		trace.Entity.key = key
		trace.Entity.key_bk = key_bk
		trace.Entity.force = force
		trace.Entity.toggle = toggle
		trace.Entity.effect = effect
		trace.Entity.damageable = damageable

		return true
	end

	if ( !util.IsValidModel( model ) || !util.IsValidProp( model ) || !IsValidThrusterModel( model ) ) then return false end
	if ( !self:GetSWEP():CheckLimit( "thrusters" ) ) then return false end

	if !ply:CanAfford(ThrusterPrice) then
		ply:HintError("You can't afford that.")
		return false
	end

	local Ang = trace.HitNormal:Angle()
	Ang.pitch = Ang.pitch + 90

	local thruster = MakeThruster( ply, model, Ang, trace.HitPos, key, key_bk, force, toggle, effect, damageable, soundname )
	thruster.purchaseprice = ThrusterPrice

	local min = thruster:OBBMins()
	thruster:SetPos( trace.HitPos - trace.HitNormal * min.z )

	undo.Create( "Thruster" )
		undo.EntityRefund(thruster, "thruster")

		-- Don't weld to world
		if ( IsValid( trace.Entity ) ) then

			local const = constraint.Weld( thruster, trace.Entity, 0, trace.PhysicsBone, 0, collision, true )

			undo.AddEntity( const )
			ply:AddCleanup( "thrusters", const )

		end

		undo.SetPlayer( ply )
	undo.Finish()

	return true

end

if ( SERVER ) then
	--When round begins we disable all collisions and remove any loose thrusters--When round has ended we enable collisions again so people can manipulate them like normally.

	hook.Add("FMOnChangePhase", "SetupThrusters", function(old, new)
		if new == TIME_PREPARE then
			for k,v in pairs(ents.FindByClass("gmod_thruster")) do
				if #constraint.FindConstraints( v, "Weld" ) == 0 then v:Remove() continue end

				--if IsValid(v:GetPhysicsObject()) then
				--	v:GetPhysicsObject():EnableCollisions(false)
				--end
				--v:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			end
		elseif old == TIME_REFLECT then
			--for k,v in pairs(ents.FindByClass("gmod_thruster")) do
			--	if IsValid(v:GetPhysicsObject()) then
			--		v:GetPhysicsObject():EnableCollisions(true)
			--	end
			--	v:SetCollisionGroup(COLLISION_GROUP_NONE)
			--end
		end
	end)


	local function newfunc( self, phys, deltatime )
		if (!self:IsOn()) then return SIM_NOTHING end
		if not IsValid(self:GetPlayer()) or not self:GetPlayer():Alive() then
			self:Switch(false)
			return SIM_NOTHING
		end

		local ForceAngle, ForceLinear = self.ForceAngle, self.ForceLinear

		return ForceAngle, ForceLinear, SIM_LOCAL_ACCELERATION
	end

	hook.Add("InitPostEntity", "EditThrusterMul", function()
		scripted_ents.GetStored("gmod_thruster").PhysicsSimulate = newfunc
	end)

	function MakeThruster( pl, model, ang, pos, key, key_bck, force, toggle, effect, damageable, soundname, nocollide )

		if ( IsValid( pl ) && !pl:CheckLimit( "thrusters" ) ) then return false end
		if ( !IsValidThrusterModel( model ) ) then return false end

		local thruster = ents.Create( "gmod_thruster" )
		if ( !IsValid( thruster ) ) then return false end

		pl:RoundStatsAdd("cashspent", ThrusterPrice)

		pl:GiveCash(-ThrusterPrice)

		nocollide = true
		model = "models/MaxOfS2D/thruster_propeller.mdl"

		thruster:SetModel( model )
		thruster:SetAngles( ang )
		thruster:SetPos( pos )
		thruster:Spawn()

		thruster.PhysicsSimulate = newfunc

		thruster:SetEffect( effect )
		thruster:SetForce( force )
		thruster:SetToggle( toggle == 1 )
		thruster.ActivateOnDamage = ( damageable == 1 )
		thruster:SetPlayer( pl )
		thruster:SetSound( soundname )

		thruster.NumDown = numpad.OnDown( pl, key, "Thruster_On", thruster, 1 )
		thruster.NumUp = numpad.OnUp( pl, key, "Thruster_Off", thruster, 1 )

		thruster.NumBackDown = numpad.OnDown( pl, key_bck, "Thruster_On", thruster, -1 )
		thruster.NumBackUp = numpad.OnUp( pl, key_bck, "Thruster_Off", thruster, -1 )

		if ( nocollide == true && IsValid( thruster:GetPhysicsObject() ) ) then thruster:GetPhysicsObject():EnableCollisions( false ) end

		table.Merge( thruster:GetTable(), {
			key = key,
			key_bck = key_bck,
			force = force,
			toggle = toggle,
			pl = pl,
			effect = effect,
			nocollide = nocollide,
			damageable = damageable,
			soundname = soundname
		} )

		if ( IsValid( pl ) ) then
			pl:AddCount( "thrusters", thruster )
			pl:AddCleanup( "thrusters", thruster )

			LogFile({"{ply1} spawned a thruster", pl}, "prop")
		end

		DoPropSpawnedEffect( thruster )

		return thruster

	end

	duplicator.RegisterEntityClass( "gmod_thruster", MakeThruster, "Model", "Ang", "Pos", "key", "key_bck", "force", "toggle", "effect", "damageable", "soundname", "nocollide" )

end

function TOOL:UpdateGhostThruster( ent, ply )

	if ( !IsValid( ent ) ) then return end

	local trace = ply:GetEyeTrace()
	if ( !trace.Hit || trace.Entity && ( trace.Entity:GetClass() == "gmod_thruster" || trace.Entity:IsPlayer() ) ) then

		ent:SetNoDraw( true )
		return

	end

	local ang = trace.HitNormal:Angle()
	ang.pitch = ang.pitch + 90

	local min = ent:OBBMins()
	ent:SetPos( trace.HitPos - trace.HitNormal * min.z )
	ent:SetAngles( ang )

	ent:SetNoDraw( false )

end

function TOOL:Think()

	local mdl = self:GetClientInfo( "model" )
	if ( !IsValidThrusterModel( mdl ) ) then self:ReleaseGhostEntity() return end

	if ( !IsValid( self.GhostEntity ) || self.GhostEntity:GetModel() != mdl ) then
		self:MakeGhostEntity( mdl, Vector( 0, 0, 0 ), Angle( 0, 0, 0 ) )
	end

	self:UpdateGhostThruster( self.GhostEntity, self:GetOwner() )

end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel( CPanel )

	CPanel:AddControl( "Header", { Description = "#tool.thruster.desc" } )

	local lbl = vgui.Create("DLabel")
		lbl:SetText([[This version does not let you change the force or model.
			Thrusters cost ]] .. FormatMoney(ThrusterPrice) .. [[ each to spawn.]])
		lbl:SizeToContents()
		lbl:SetDark(true)
	CPanel:AddItem(lbl)

	CPanel:AddControl( "ComboBox", { MenuButton = 1, Folder = "thruster", Options = { [ "#preset.default" ] = ConVarsDefault }, CVars = table.GetKeys( ConVarsDefault ) } )

	CPanel:AddControl( "Numpad", { Label = "#tool.thruster.forward", Command = "thruster_keygroup", Label2 = "#tool.thruster.back", Command2 = "thruster_keygroup_back" } )

	CPanel:AddControl( "Slider", { Label = "#tool.thruster.force", Command = "thruster_force", Type = "Float", Min = 0, Max = MaxThrusterForce } )

	local combo = CPanel:AddControl( "ListBox", { Label = "#tool.thruster.effect" } )
	for k, v in pairs( list.Get( "ThrusterEffects" ) ) do
		combo:AddOption( k, { thruster_effect = v.thruster_effect } )
	end

	CPanel:AddControl( "ListBox", { Label = "#tool.thruster.sound", Options = list.Get( "ThrusterSounds" ) } )

	CPanel:AddControl( "CheckBox", { Label = "#tool.thruster.toggle", Command = "thruster_toggle" } )
	CPanel:AddControl( "CheckBox", { Label = "#tool.thruster.damagable", Command = "thruster_damageable" } )

end

list.Set( "ThrusterSounds", "#thrustersounds.none", { thruster_soundname = "" } )
list.Set( "ThrusterSounds", "#thrustersounds.steam", { thruster_soundname = "PhysicsCannister.ThrusterLoop" } )
list.Set( "ThrusterSounds", "#thrustersounds.zap", { thruster_soundname = "WeaponDissolve.Charge" } )
list.Set( "ThrusterSounds", "#thrustersounds.beam", { thruster_soundname = "WeaponDissolve.Beam" } )
list.Set( "ThrusterSounds", "#thrustersounds.elevator", { thruster_soundname = "eli_lab.elevator_move" } )
list.Set( "ThrusterSounds", "#thrustersounds.energy", { thruster_soundname = "combine.sheild_loop" } )
list.Set( "ThrusterSounds", "#thrustersounds.ring", { thruster_soundname = "k_lab.ringsrotating" } )
list.Set( "ThrusterSounds", "#thrustersounds.resonance", { thruster_soundname = "k_lab.teleport_rings_high" } )
list.Set( "ThrusterSounds", "#thrustersounds.dropship", { thruster_soundname = "k_lab2.DropshipRotorLoop" } )
list.Set( "ThrusterSounds", "#thrustersounds.machine", { thruster_soundname = "Town.d1_town_01_spin_loop" } )

list.Set( "ThrusterModels", "models/dav0r/thruster.mdl", {} )
list.Set( "ThrusterModels", "models/MaxOfS2D/thruster_projector.mdl", {} )
list.Set( "ThrusterModels", "models/MaxOfS2D/thruster_propeller.mdl", {} )
list.Set( "ThrusterModels", "models/thrusters/jetpack.mdl", {} )
list.Set( "ThrusterModels", "models/props_junk/plasticbucket001a.mdl", {} )
list.Set( "ThrusterModels", "models/props_junk/PropaneCanister001a.mdl", {} )
list.Set( "ThrusterModels", "models/props_junk/propane_tank001a.mdl", {} )
list.Set( "ThrusterModels", "models/props_junk/PopCan01a.mdl", {} )
list.Set( "ThrusterModels", "models/props_junk/MetalBucket01a.mdl", {} )
list.Set( "ThrusterModels", "models/props_lab/jar01a.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/lampShade001a.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/canister_propane01a.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/canister01a.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/canister02a.mdl", {} )
list.Set( "ThrusterModels", "models/props_trainstation/trainstation_ornament002.mdl", {} )
list.Set( "ThrusterModels", "models/props_junk/TrafficCone001a.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/clock01.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/pottery02a.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/pottery03a.mdl", {} )
list.Set( "ThrusterModels", "models/props_junk/terracotta01.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/TrapPropeller_Engine.mdl", {} )
list.Set( "ThrusterModels", "models/props_c17/FurnitureSink001a.mdl", {} )
list.Set( "ThrusterModels", "models/props_trainstation/trainstation_ornament001.mdl", {} )
list.Set( "ThrusterModels", "models/props_trainstation/trashcan_indoor001b.mdl", {} )

--PHX
list.Set( "ThrusterModels", "models/props_phx2/garbage_metalcan001a.mdl", {} )

--Tile Model Pack Thrusters
list.Set( "ThrusterModels", "models/hunter/plates/plate.mdl", {} )
list.Set( "ThrusterModels", "models/hunter/blocks/cube025x025x025.mdl", {} )

--XQM Model Pack Thrusters
list.Set( "ThrusterModels", "models/XQM/AfterBurner1.mdl", {} )
list.Set( "ThrusterModels", "models/XQM/AfterBurner1Medium.mdl", {} )
list.Set( "ThrusterModels", "models/XQM/AfterBurner1Big.mdl", {} )
list.Set( "ThrusterModels", "models/XQM/AfterBurner1Huge.mdl", {} )
list.Set( "ThrusterModels", "models/XQM/AfterBurner1Large.mdl", {} )