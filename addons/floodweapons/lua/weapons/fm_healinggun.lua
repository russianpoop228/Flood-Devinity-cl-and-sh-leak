SWEP.PrintName = "Healing Gun"
SWEP.Category             = "Devinity"
SWEP.Purpose = "It would be stereotypical for russians to use this."

if CLIENT then
	--SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/fm_stick")
	SWEP.DrawWeaponInfoBox = false		-- Should draw the weapon info box
	SWEP.BounceWeaponIcon = false
end

SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.Spawnable = true

SWEP.HoldType = "physgun"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_physcannon.mdl"
SWEP.WorldModel = "models/weapons/w_physics.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.ViewModelBoneMods = {
   ["Base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
   ["ValveBiped.Bip01_R_Hand"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.Primary.Sound = Sound( "" )
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.MaxAmmo = 10001
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Delay = 0.1

SWEP.Secondary.Sound = Sound( "WeaponMedigun.Charged" )
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Uber = 0
SWEP.UberTimer = CurTime()
SWEP.Attack = 0
SWEP.AttackTimer = CurTime()
SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

function SWEP:Deploy()

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	self:SetDeploySpeed(self.Owner:GetViewModel():SequenceDuration())
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	
end

function SWEP:Holster()

	self:StopSound( self.Primary.Sound )
	
	if SERVER then
		self.Owner:StopSound( self.Secondary.Sound )
	end

	if SERVER and self.Attack == 1 then
		self.Beam:Fire( "kill", "", 0 )
	end
	
end

function SWEP:PrimaryAttack()
	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 450,
		filter = self.Owner,
		mask = MASK_SHOT_HULL,
	} )

	if !IsValid( tr.Entity ) then
		tr = util.TraceHull( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 450,
		filter = self.Owner,
		mins = Vector( -16, -16, 0 ),
		maxs = Vector( 16, 16, 0 ),
		mask = MASK_SHOT_HULL,
	} )
	end
	
	if self.Attack == 0 then
		if ( !( tr.Hit and IsValid( tr.Entity ) and ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() || tr.Entity.Type == "nextbot" ) ) || tr.Entity:Health() <= 0 ) then
			self.Weapon:EmitSound( "items/suitchargeno1.wav" )
			self:SetNextPrimaryFire( CurTime() + 1.1 )
		end

		if tr.Hit and tr.Entity:IsValid() and not tr.Entity:IsPlayer() and tr.Entity:Health() > 0 then
			
			if SERVER then			
				local healtrail = ents.Create( "info_particle_system" )
					healtrail:SetKeyValue( "effect_name", "choreo_skyflower_01c" )
					healtrail:SetOwner( self.Owner )
						
				local Forward = self.Owner:EyeAngles():Forward()
				local Right = self.Owner:EyeAngles():Right()
				local Up = self.Owner:EyeAngles():Up()
					healtrail:SetPos( self.Owner:GetShootPos() + Forward * 24 + Right * 8 + Up * -6 )
					healtrail:SetAngles( self.Owner:EyeAngles() )
						
				local beamtarget = ents.Create( "tf_target_medigun" )
					beamtarget:SetOwner( self.Owner )
					beamtarget:SetPos( tr.Entity:GetPos() + Vector( 0, 0, 50 ) )
					beamtarget:Spawn()
					healtrail:SetKeyValue( "cpoint1", beamtarget:GetName() )
					healtrail:Spawn()
					healtrail:Activate()
					healtrail:Fire("start", "", 0 )
					self.Beam = healtrail
					self.BeamTarget = beamtarget
			end
	
	self:EmitSound( "items/suitchargeok1.wav" )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	self.Target = tr.Entity
	self.Attack = 1
	self.AttackTimer = CurTime()
	self.Idle = 0
	self.IdleTimer = CurTime()
	
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Think()
	if self.Attack == 1 then
		self:TakePrimaryAmmo( 1 )
end
	
	
	if IsValid( self.Target ) and self.Target:Health() > 0 and self.Attack == 1 then
		if self.AttackTimer <= CurTime() then
			if SERVER then
				local Forward = self.Owner:EyeAngles():Forward()
				local Right = self.Owner:EyeAngles():Right()
				local Up = self.Owner:EyeAngles():Up()
					self.Beam:SetPos( self.Owner:GetShootPos() + Forward * 45 + Right * 13 + Up * -12 )
					self.Beam:SetAngles( self.Owner:EyeAngles() )
					self.BeamTarget:SetPos( self.Target:GetPos() + Vector( 0, 0, 50 ) )
			end
			
		if self.Target:Health() < self.Target:GetMaxHealth() then
			self.Target:SetHealth( self.Target:Health() + 1 )
		end
	

end

		if self.Weapon:Ammo1() < 100 and self.Uber == 0 and self.UberTimer <= CurTime() then
			self.Owner:SetAmmo( self.Weapon:Ammo1() + 1, self.Primary.Ammo )
			self.UberTimer = CurTime() + 0.01
		end
	end


	if ( !IsValid( self.Target ) || self.Target:Health() <= 0 || !self.Owner:KeyDown( IN_ATTACK ) ) and self.Attack == 1 then
		if SERVER then
			self.Beam:Fire( "kill", "", 0 )
			self.BeamTarget:Remove()
		end

		self:StopSound( self.Primary.Sound )


	
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		self.Attack = 0
		self.AttackTimer = CurTime()
		self.Idle = 0
		self.IdleTimer = CurTime()
	
	end
	
	if self.Idle == 0 and self.IdleTimer <= CurTime() then
		if SERVER then
			if self.Attack == 0 then
				self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
			end

			if self.Attack == 1 then
				self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			end
		end
	
		self.Idle = 1
	
	end

	if self.Weapon:Ammo1() > self.Primary.MaxAmmo then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, self.Primary.Ammo )
	end
end


-- Healing Gun VElements (courtesy of Lime)
SWEP.VElements = {
   ["ht5+"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve01_long.mdl", bone = "Base", rel = "", pos = Vector(0.224, -0.851, -20), angle = Angle(0, 180, 90), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht2+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "Base", rel = "", pos = Vector(0.2, 2, -7), angle = Angle(0, 90, 0), size = Vector(0.085, 0.085, 0.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/iron_rails", skin = 0, bodygroup = {} },
   ["ht4++++"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "Base", rel = "", pos = Vector(0.25, 2, -8.15), angle = Angle(0, 0, 0), size = Vector(0.2, 0.2, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht4++"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "Base", rel = "", pos = Vector(0.25, 2, 5), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht5+++"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve01_long.mdl", bone = "Base", rel = "", pos = Vector(3, 2, -12.7), angle = Angle(-180, 90, 90), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht6"] = { type = "Model", model = "models/props_combine/portalball.mdl", bone = "Base", rel = "", pos = Vector(0.2, 1.5, 11), angle = Angle(90, 0, 0), size = Vector(0.05, 0.05, 0.05), color = Color(90, 60, 230, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht2"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "Base", rel = "", pos = Vector(0.25, 2, -22.4), angle = Angle(0, 90, 0), size = Vector(0.05, 0.05, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht5++"] = { type = "Model", model = "models/props_pipes/pipe03_connector01.mdl", bone = "Base", rel = "", pos = Vector(0.224, -1.201, -16.4), angle = Angle(90, 0, 0), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht5++++"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve01_long.mdl", bone = "Base", rel = "", pos = Vector(3, 2, -20), angle = Angle(0, 90, 90), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht4+"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "Base", rel = "", pos = Vector(0.25, 2, -2), angle = Angle(0, 0, 0), size = Vector(0.34, 0.34, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht4"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "Base", rel = "", pos = Vector(0.25, 2, -28), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht4++"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "Base", rel = "", pos = Vector(0.25, 2, -33.2), angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht3"] = { type = "Model", model = "models/props_phx/wheels/drugster_front.mdl", bone = "Base", rel = "", pos = Vector(13.8, 5.55, -5.401), angle = Angle(85, -12, 0), size = Vector(0.054, 0.054, 0.319), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
   ["ht1"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "Base", rel = "", pos = Vector(3.5, 3.4, -4.5), angle = Angle(-95, -20, -8), size = Vector(0.649, 0.649, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht5"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve01_long.mdl", bone = "Base", rel = "", pos = Vector(0.224, -0.851, -12.7), angle = Angle(-180, -180, 90), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht5+++++"] = { type = "Model", model = "models/props_pipes/pipe03_connector01.mdl", bone = "Base", rel = "", pos = Vector(3.349, 2, -16.4), angle = Angle(90, 0, 0), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht4+++"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "Base", rel = "", pos = Vector(0.25, 2, -8), angle = Angle(0, 0, 0), size = Vector(0.34, 0.34, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
   ["ht2+"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.5, -0.401, -5), angle = Angle(-94, 10, 0), size = Vector(0.064, 0.064, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/iron_rails", skin = 0, bodygroup = {} },
   ["ht5+++"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.9, 2.299, -4.75), angle = Angle(94, 180, -81), size = Vector(0.019, 0.017, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht5++"] = { type = "Model", model = "models/props_pipes/pipe03_connector01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.2, 0.625, -6.651), angle = Angle(0, 10, 0), size = Vector(0.025, 0.025, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht4+"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.599, -0.25, -5), angle = Angle(-93, 10, 0), size = Vector(0.27, 0.27, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht4"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-3.401, 1.75, -4.25), angle = Angle(-93, 10, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht4+++++"] = { type = "Model", model = "models/props_wasteland/laundry_basket001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20, -2.75, -5.901), angle = Angle(86.5, 10, 0), size = Vector(0.145, 0.145, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
   ["ht4+++"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.8, -1.101, -5.401), angle = Angle(-93, 10, 0), size = Vector(0.27, 0.27, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht5+"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 0.86, -6.45), angle = Angle(180, -80, 3.5), size = Vector(0.019, 0.017, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht4++++"] = { type = "Model", model = "models/props_phx/misc/iron_beam1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.75, 1, -5.151), angle = Angle(0, -80, 0), size = Vector(0.145, 0.145, 0.145), color = Color(255, 255, 255, 255), surpresslightning = false, material = "rubber", skin = 0, bodygroup = {} },
   ["ht4++"] = { type = "Model", model = "models/props_phx/wheels/magnetic_large_base.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.699, -2, -5.7), angle = Angle(-93, 10, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht5++++"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.5, 2.68, -4.6), angle = Angle(-93, 0, 81), size = Vector(0.019, 0.017, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht2"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.1, 1, -4.5), angle = Angle(-94, 10, 0), size = Vector(0.035, 0.035, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht5"] = { type = "Model", model = "models/props_pipes/pipe03_lcurve01_long.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.5, 0.4, -6.6), angle = Angle(180, 100, -3.5), size = Vector(0.019, 0.017, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht1"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.5, 0.5, -4.901), angle = Angle(0, 5, 95), size = Vector(0.649, 0.649, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
   ["ht5+++++"] = { type = "Model", model = "models/props_pipes/pipe03_connector01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.599, 2.599, -4.7), angle = Angle(0, 10, 0), size = Vector(0.025, 0.025, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/pack2/interior_top", skin = 0, bodygroup = {} },
   ["ht3"] = { type = "Model", model = "models/props_phx/wheels/drugster_front.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10, 6.5, -5.5), angle = Angle(0, 5.5, 95), size = Vector(0.05, 0.05, 0.275), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} }
}


/********************************************************
	SWEP Construction Kit base code
		Created by Clavus
	Available for public use, thread at:
	   facepunch.com/threads/1032378
	   
	   
	DESCRIPTION:
		This script is meant for experienced scripters 
		that KNOW WHAT THEY ARE DOING. Don't come to me 
		with basic Lua questions.
		
		Just copy into your SWEP or SWEP base of choice
		and merge with your own code.
		
		The SWEP.VElements, SWEP.WElements and
		SWEP.ViewModelBoneMods tables are all optional
		and only have to be visible to the client.
********************************************************/

function SWEP:Initialize()
	// other initialize code goes here
	-- changed from self:SetWeaponHoldType because the wiki discourages it https://wiki.garrysmod.com/page/WEAPON/SetWeaponHoldType
	self:SetHoldType(self.HoldType)
	
	if CLIENT then
		
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
				// Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255,255,255,255))
				else
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
				end
			end
		end
		
	end

end

function SWEP:Holster()
	
	if CLIENT and IsValid(self.Owner) then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end
	
	return true
end

function SWEP:OnRemove()
	self:Holster()
end

if CLIENT then

	SWEP.vRenderOrder = nil
	function SWEP:ViewModelDrawn()
		
		local vm = self.Owner:GetViewModel()
		if !IsValid(vm) then return end
		
		if (!self.VElements) then return end
		
		self:UpdateBonePositions(vm)

		if (!self.vRenderOrder) then
			
			// we build a render order because sprites need to be drawn after models
			self.vRenderOrder = {}

			for k, v in pairs( self.VElements ) do
				if (v.type == "Model") then
					table.insert(self.vRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.vRenderOrder, k)
				end
			end
			
		end

		for k, name in ipairs( self.vRenderOrder ) do
		
			local v = self.VElements[name]
			if (!v) then self.vRenderOrder = nil break end
			if (v.hide) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (!v.bone) then continue end
			
			local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
			
			if (!pos) then continue end
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	SWEP.wRenderOrder = nil
	function SWEP:DrawWorldModel()
		
		if (self.ShowWorldModel == nil or self.ShowWorldModel) then
			self:DrawModel()
		end
		
		if (!self.WElements) then return end
		
		if (!self.wRenderOrder) then

			self.wRenderOrder = {}

			for k, v in pairs( self.WElements ) do
				if (v.type == "Model") then
					table.insert(self.wRenderOrder, 1, k)
				elseif (v.type == "Sprite" or v.type == "Quad") then
					table.insert(self.wRenderOrder, k)
				end
			end

		end
		
		if (IsValid(self.Owner)) then
			bone_ent = self.Owner
		else
			// when the weapon is dropped
			bone_ent = self
		end
		
		for k, name in pairs( self.wRenderOrder ) do
		
			local v = self.WElements[name]
			if (!v) then self.wRenderOrder = nil break end
			if (v.hide) then continue end
			
			local pos, ang
			
			if (v.bone) then
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
			else
				pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
			end
			
			if (!pos) then continue end
			
			local model = v.modelEnt
			local sprite = v.spriteMaterial
			
			if (v.type == "Model" and IsValid(model)) then

				model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				model:SetAngles(ang)
				//model:SetModelScale(v.size)
				local matrix = Matrix()
				matrix:Scale(v.size)
				model:EnableMatrix( "RenderMultiply", matrix )
				
				if (v.material == "") then
					model:SetMaterial("")
				elseif (model:GetMaterial() != v.material) then
					model:SetMaterial( v.material )
				end
				
				if (v.skin and v.skin != model:GetSkin()) then
					model:SetSkin(v.skin)
				end
				
				if (v.bodygroup) then
					for k, v in pairs( v.bodygroup ) do
						if (model:GetBodygroup(k) != v) then
							model:SetBodygroup(k, v)
						end
					end
				end
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(true)
				end
				
				render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
				render.SetBlend(v.color.a/255)
				model:DrawModel()
				render.SetBlend(1)
				render.SetColorModulation(1, 1, 1)
				
				if (v.surpresslightning) then
					render.SuppressEngineLighting(false)
				end
				
			elseif (v.type == "Sprite" and sprite) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				render.SetMaterial(sprite)
				render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
				
			elseif (v.type == "Quad" and v.draw_func) then
				
				local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
				cam.Start3D2D(drawpos, ang, v.size)
					v.draw_func( self )
				cam.End3D2D()

			end
			
		end
		
	end

	function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			// Technically, if there exists an element with the same name as a bone
			// you can get in an infinite loop. Let's just hope nobody's that stupid.
			pos, ang = self:GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
			
			if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
				ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
				ang.r = -ang.r // Fixes mirrored models
			end
		
		end
		
		return pos, ang
	end

	function SWEP:CreateModels( tab )

		if (!tab) then return end

		// Create the clientside models here because Garry says we can't do it in the render hook
		for k, v in pairs( tab ) do
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(self:GetPos())
					v.modelEnt:SetAngles(self:GetAngles())
					v.modelEnt:SetParent(self)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
		end
		
	end
	
	local allbones
	local hasGarryFixedBoneScalingYet = false

	function SWEP:UpdateBonePositions(vm)
		
		if self.ViewModelBoneMods then
			
			if (!vm:GetBoneCount()) then return end
			
			// !! WORKAROUND !! //
			// We need to check all model names :/
			local loopthrough = self.ViewModelBoneMods
			if (!hasGarryFixedBoneScalingYet) then
				allbones = {}
				for i=0, vm:GetBoneCount() do
					local bonename = vm:GetBoneName(i)
					if (self.ViewModelBoneMods[bonename]) then 
						allbones[bonename] = self.ViewModelBoneMods[bonename]
					else
						allbones[bonename] = { 
							scale = Vector(1,1,1),
							pos = Vector(0,0,0),
							angle = Angle(0,0,0)
						}
					end
				end
				
				loopthrough = allbones
			end
			// !! ----------- !! //
			
			for k, v in pairs( loopthrough ) do
				local bone = vm:LookupBone(k)
				if (!bone) then continue end
				
				// !! WORKAROUND !! //
				local s = Vector(v.scale.x,v.scale.y,v.scale.z)
				local p = Vector(v.pos.x,v.pos.y,v.pos.z)
				local ms = Vector(1,1,1)
				if (!hasGarryFixedBoneScalingYet) then
					local cur = vm:GetBoneParent(bone)
					while(cur >= 0) do
						local pscale = loopthrough[vm:GetBoneName(cur)].scale
						ms = ms * pscale
						cur = vm:GetBoneParent(cur)
					end
				end
				
				s = s * ms
				// !! ----------- !! //
				
				if vm:GetManipulateBoneScale(bone) != s then
					vm:ManipulateBoneScale( bone, s )
				end
				if vm:GetManipulateBoneAngles(bone) != v.angle then
					vm:ManipulateBoneAngles( bone, v.angle )
				end
				if vm:GetManipulateBonePosition(bone) != p then
					vm:ManipulateBonePosition( bone, p )
				end
			end
		else
			self:ResetBonePositions(vm)
		end
		   
	end
	 
	function SWEP:ResetBonePositions(vm)
		
		if (!vm:GetBoneCount()) then return end
		for i=0, vm:GetBoneCount() do
			vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
			vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
			vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
		end
		
	end

	/**************************
		Global utility code
	**************************/

	// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
	// Does not copy entities of course, only copies their reference.
	// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
	function table.FullCopy( tab )

		if (!tab) then return nil end
		
		local res = {}
		for k, v in pairs( tab ) do
			if (type(v) == "table") then
				res[k] = table.FullCopy(v) // recursion ho!
			elseif (type(v) == "Vector") then
				res[k] = Vector(v.x, v.y, v.z)
			elseif (type(v) == "Angle") then
				res[k] = Angle(v.p, v.y, v.r)
			else
				res[k] = v
			end
		end
		
		return res
		
	end
	
end
