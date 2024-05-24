SWEP.PrintName = "Shotgun"
SWEP.Category             = "Devinity"
SWEP.Purpose = "It would be stereotypical for russians to use this."
--[[
if CLIENT then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/fm_stick")
	SWEP.BounceWeaponIcon = false
end
]]--
SWEP.Slot = 0
SWEP.SlotPos = 0

SWEP.Spawnable = true

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
    ["v_weapon.receiver"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
    ["v_weapon.bullet1"] = { scale = Vector(0.296, 0.296, 0.296), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
    ["v_weapon.handle"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
    ["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0.1), angle = Angle(0, 0, 0) },
    ["v_weapon.m249"] = { scale = Vector(0.222, 0.222, 0.222), pos = Vector(0, 0, -0.75), angle = Angle(0, 0, 0) }
}

SWEP.Primary.ClipSize = 100
SWEP.Primary.Delay = 0.20
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "grenade"
SWEP.Secondary.Ammo = "none"


function SWEP:PrimaryAttack()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self:TakePrimaryAmmo( 1 )
	self.Weapon:EmitSound("Weapon_SMG1.Double")
end

function SWEP:SecondaryAttack()
end
	 
function SWEP:Deploy()
self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
self:SetDeploySpeed(self.Owner:GetViewModel():SequenceDuration())
self.Weapon:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
self.Weapon:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
end


-- Abzats VElements (courtsey of Space Turtle)
SWEP.VElements = {
    ["Back Top Frame"] = { type = "Model", model = "models/props_wasteland/cargo_container01.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.15, -1, 2.299), angle = Angle(180, 0, 90), size = Vector(0.014, 0.017, 0.017), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Receiver Spring Side Attachment Cap Plate"] = { type = "Model", model = "models/props_c17/streetsign004f.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(2.22, -2.401, -0.5), angle = Angle(0, 90, 0), size = Vector(0.041, 0.041, 0.041), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Barrel 3's Cap"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -1.4, 49), angle = Angle(0, 0, 0), size = Vector(0.048, 0.048, 0.048), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/road", skin = 0, bodygroup = {} },
    ["Underbarrel 2"] = { type = "Model", model = "models/props_docks/dock03_pole01a_256.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, 0.09, 32), angle = Angle(180, 0, -180), size = Vector(0.09, 0.064, 0.079), color = Color(169, 169, 169, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
    ["Barrel 2"] = { type = "Model", model = "models/props_docks/dock03_pole01a_256.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -1.5, 32), angle = Angle(180, 0, -180), size = Vector(0.1, 0.1, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/train_wheel", skin = 0, bodygroup = {} },
    ["Shell 1"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.bullet1", rel = "", pos = Vector(0, 0, -0.541), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["Barrel 1"] = { type = "Model", model = "models/props_docks/dock03_pole01a_256.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -1.5, 19), angle = Angle(180, 0, -180), size = Vector(0.1, 0.1, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/train_wheel", skin = 0, bodygroup = {} },
    ["Grip"] = { type = "Model", model = "models/props_lab/powerbox02a.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.075, 2.4, 1.1), angle = Angle(0, 0, -80), size = Vector(0.185, 0.15, 0.239), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Underbarrel"] = { type = "Model", model = "models/props_docks/dock03_pole01a_256.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, 0.09, 19), angle = Angle(180, 0, -180), size = Vector(0.09, 0.064, 0.05), color = Color(169, 169, 169, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
    ["Barrel 3 Grooves"] = { type = "Model", model = "models/props_c17/utilityconnecter006.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -1.5, 43), angle = Angle(0, 0, 90), size = Vector(0.28, 0.699, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/road", skin = 0, bodygroup = {} },
    ["Back Magazine"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "v_weapon.ammobox", rel = "", pos = Vector(0.899, -3.701, -1.5), angle = Angle(90, 90, 0), size = Vector(0.039, 0.039, 0.029), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Mid Frame"] = { type = "Model", model = "models/props_wasteland/cargo_container01.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.15, -0.59, 8.38), angle = Angle(180, 0, 90), size = Vector(0.014, 0.017, 0.019), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Receiver Spring 2"] = { type = "Model", model = "models/props_c17/utilityconnecter006d.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.899, -2.381, -0.5), angle = Angle(90, 0, 0), size = Vector(0.09, 0.09, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
    ["Shell 4"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.bullet7", rel = "", pos = Vector(0.05, 0, -0.201), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["Barrel 3"] = { type = "Model", model = "models/props_docks/dock03_pole01a_256.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -1.5, 45), angle = Angle(180, 0, -180), size = Vector(0.1, 0.1, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/train_wheel", skin = 0, bodygroup = {} },
    ["Receiver Box"] = { type = "Model", model = "models/props_lab/scrapyarddumpster.mdl", bone = "v_weapon.receiver", rel = "", pos = Vector(-1.601, 0.4, -1.101), angle = Angle(0, -90, 0), size = Vector(0.025, 0.025, 0.019), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Barrel 2 Grooves"] = { type = "Model", model = "models/props_c17/utilityconnecter006.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -1.5, 29.7), angle = Angle(0, 0, 90), size = Vector(0.28, 1.2, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/road", skin = 0, bodygroup = {} },
    ["Shell 6"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.bullet10", rel = "", pos = Vector(-0.26, -0.201, -0.301), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["Receiver Spring 1"] = { type = "Model", model = "models/props_c17/utilityconnecter006d.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -2.5, 2.799), angle = Angle(0, 0, 0), size = Vector(0.09, 0.09, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
    ["Receiver Spring Side Attachment Stick"] = { type = "Model", model = "models/props_docks/dock03_pole01a_256.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(2, -3, -0.7), angle = Angle(0, 0, -110), size = Vector(0.009, 0.009, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/metalset_1-2", skin = 0, bodygroup = {} },
    ["Stock"] = { type = "Model", model = "models/props_interiors/vendingmachinesoda01a.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.15, -0.69, -2.1), angle = Angle(90, 90, 0), size = Vector(0.05, 0.039, 0.039), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Front Magazine"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "v_weapon.ammobox", rel = "", pos = Vector(0.699, -3.8, 1.7), angle = Angle(90, 90, 0), size = Vector(0.064, 0.05, 0.029), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Receiver Box Clip Block"] = { type = "Model", model = "models/props_doors/doorklab01.mdl", bone = "v_weapon.receiver", rel = "", pos = Vector(-1.601, 1.37, -0.01), angle = Angle(-90, 0, -90), size = Vector(0.014, 0.017, 0.018), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Receiver Box Attachment"] = { type = "Model", model = "models/props_wasteland/laundry_cart001.mdl", bone = "v_weapon.receiver", rel = "", pos = Vector(-1.851, -0.7, -0.19), angle = Angle(180, 0, -90), size = Vector(0.025, 0.025, 0.025), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Side Magazine"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "v_weapon.ammobox", rel = "", pos = Vector(2.75, -2.3, -1.9), angle = Angle(0, 0, 0), size = Vector(0.029, 0.039, 0.035), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Barrel and Underbarrel Connector"] = { type = "Model", model = "models/props_borealis/borealis_door001a.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -0.851, 23.6), angle = Angle(90, 0, 90), size = Vector(0.039, 0.045, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/road", skin = 0, bodygroup = {} },
    ["Shell 3"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.bullet5", rel = "", pos = Vector(0, 0, -0.301), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["Trigger"] = { type = "Model", model = "models/props_combine/combine_barricade_bracket01b.mdl", bone = "v_weapon.trigger", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 90, 90), size = Vector(0.07, 0.07, 0.07), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Barrel and Underbarrel Connector 2"] = { type = "Model", model = "models/props_borealis/borealis_door001a.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -0.851, 39), angle = Angle(90, 0, 90), size = Vector(0.039, 0.045, 0.032), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/road", skin = 0, bodygroup = {} },
    ["Receiver Spring Attachment"] = { type = "Model", model = "models/props_c17/woodbarrel001.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.899, -2.401, -0.5), angle = Angle(90, 0, 0), size = Vector(0.039, 0.039, 0.039), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Front Frame"] = { type = "Model", model = "models/props_wasteland/cargo_container01.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.15, -1.3, 13), angle = Angle(180, 0, 90), size = Vector(0.014, 0.023, 0.017), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Side Magazine+"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "v_weapon.ammobox", rel = "", pos = Vector(-1.4, -1.9, -1.9), angle = Angle(0, 0, 0), size = Vector(0.029, 0.035, 0.029), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Front Underframe"] = { type = "Model", model = "models/props_wasteland/cargo_container01.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.15, 0.699, 13), angle = Angle(180, 0, 90), size = Vector(0.014, 0.014, 0.014), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Back Frame"] = { type = "Model", model = "models/props_wasteland/cargo_container01.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.15, -0.366, 2.7), angle = Angle(180, 0, 90), size = Vector(0.014, 0.019, 0.017), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Barrel 3's Attachment"] = { type = "Model", model = "models/props_c17/canister_propane01a.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -0.101, 47.299), angle = Angle(0, 0, 0), size = Vector(0.07, 0.07, 0.059), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/road", skin = 0, bodygroup = {} },
    ["Barrel 1 Grooves"] = { type = "Model", model = "models/props_c17/utilityconnecter006.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.1, -1.5, 19.989), angle = Angle(0, 0, 90), size = Vector(0.28, 0.449, 0.28), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/road", skin = 0, bodygroup = {} },
    ["Shell 5"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.bullet9", rel = "", pos = Vector(0.15, 0, -0.151), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["Top Magazine"] = { type = "Model", model = "models/props_lab/blastdoor001b.mdl", bone = "v_weapon.ammobox", rel = "", pos = Vector(0.2, -3.3, -1.5), angle = Angle(0, 90, 0), size = Vector(0.064, 0.039, 0.039), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} },
    ["Shell 2"] = { type = "Model", model = "models/weapons/shotgun_shell.mdl", bone = "v_weapon.bullet3", rel = "", pos = Vector(0.1, 0, -0.5), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["Receiver Spring Side Attachment Cap"] = { type = "Model", model = "models/props_wasteland/laundry_basket002.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(2, -2.401, -0.5), angle = Angle(90, 0, 180), size = Vector(0.019, 0.019, 0.009), color = Color(105, 105, 105, 255), surpresslightning = false, material = "phoenix_storms/roadside", skin = 0, bodygroup = {} }
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
