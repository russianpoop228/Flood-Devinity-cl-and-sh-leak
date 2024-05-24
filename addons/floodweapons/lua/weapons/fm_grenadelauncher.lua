SWEP.PrintName = "Pocket Launcher"
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

SWEP.HoldType = "revolver"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.Primary.ClipSize = 4
SWEP.Primary.Delay = 0.20
SWEP.Primary.DefaultClip = 8
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "grenade"
SWEP.Secondary.Ammo = "none"


function SWEP:PrimaryAttack()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	if self:Clip1() == 0 then return
		self:Reload()
	end

	self:TakePrimaryAmmo( 1 )
	self:EmitSound("Weapon_SMG1.Double")

	if SERVER then -- We have to make this SERVER since ents.Create is a serversided function https://wiki.garrysmod.com/page/ents/Create
		local ent = ents.Create( "grenade_ar2" )

		if ( IsValid( ent ) ) then
			ent:SetPos( self.Owner:GetShootPos() )
			ent:SetAngles( self.Owner:EyeAngles() )
			ent:Spawn()
			ent:SetVelocity( self.Owner:EyeAngles():Forward() * 1500) -- You can set how far the grenade entity travels. 1500 is the closest I can get for it to replicate the HL2 SMG's
		end

		if self:Clip1() == 0 and self:Ammo1() == 0 then
			-- Changed from self:Remove() and added a basic timer since it does not swap to the player's previous weapon (and to avoid the entity bugging out)
			timer.Simple(0.1, function()
				if not IsValid(self) or not IsValid(self.Owner) then return end
				self.Owner:StripWeapon("fm_grenadelauncher")
			end) -- We have to remove the weapon since the Flood system also adds a secondary ammo for some reason
		end

		ent:SetOwner( self.Owner )

	end

end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetDeploySpeed(self.Owner:GetViewModel():SequenceDuration())
	self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
	self:SetNextSecondaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() )
end

-- Flood Damage Hook
hook.Add("EntityTakeDamage", "FMGrenadeLauncher", function(ent, dmginfo)
	local inf = dmginfo:GetInflictor()
	if IsValid(inf) and inf:GetClass() == "grenade_ar2" then
		dmginfo:SetDamage(5)
		dmginfo:SetDamagePosition(ent:GetPos())
	end
end)

-- Grenade Launcher VElements (courtesy of Lime)
SWEP.VElements = {
    ["gp5"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.05, -4.301, -6.401), angle = Angle(-90, 90, -180), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5+"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.05, -4.301, -5), angle = Angle(-90, 90, -180), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp2"] = { type = "Model", model = "models/props_wasteland/prison_switchbox001a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(-0.95, -3.3, -1.701), angle = Angle(180, 13, 0), size = Vector(0.1, 0.1, 0.109), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp4"] = { type = "Model", model = "models/props_wasteland/prison_flourescentlight002b.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.1, -2.5, -6), angle = Angle(0, -90, -90), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["gp3"] = { type = "Model", model = "models/props_wasteland/laundry_basket001.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.1, -3.6, 4.19), angle = Angle(-180, 0, 0), size = Vector(0.037, 0.037, 0.037), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5+++++++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.05, -4.301, 3.4), angle = Angle(-90, 90, -180), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5++++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.05, -4.301, -0.801), angle = Angle(-90, 90, -180), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.05, -4.301, -3.6), angle = Angle(-90, 90, -180), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp6"] = { type = "Model", model = "models/props_lab/monitor01b.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.1, -4.5, 3.799), angle = Angle(0, -90, -180), size = Vector(0.075, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5++++++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.05, -4.301, 2), angle = Angle(-90, 90, -180), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5+++++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.05, -4.301, 0.6), angle = Angle(-90, 90, -180), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp1"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.1, -3.6, -9.351), angle = Angle(0, 0, 0), size = Vector(0.02, 0.02, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5+++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.05, -4.301, -2.201), angle = Angle(-90, 90, -180), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
    ["gp5"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.449, 2.38, -5.151), angle = Angle(0, -3.5, 0), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5+"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.1, 2.269, -5.051), angle = Angle(0, -3.5, 0), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp2"] = { type = "Model", model = "models/props_wasteland/prison_switchbox001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7, 3.099, -3.401), angle = Angle(164.804, 86, 85), size = Vector(0.1, 0.1, 0.109), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp4"] = { type = "Model", model = "models/props_wasteland/prison_flourescentlight002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.85, 2.23, -2.8), angle = Angle(86, -5, -90), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["gp3"] = { type = "Model", model = "models/props_wasteland/laundry_basket001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.899, 1.335, -3.35), angle = Angle(-94, 0, 5), size = Vector(0.045, 0.045, 0.045), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp6"] = { type = "Model", model = "models/props_lab/monitor01b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.7, 1.399, -4.45), angle = Angle(90, 175, 0), size = Vector(0.075, 0.075, 0.075), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5+++++++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.899, 1.6, -4.5), angle = Angle(0, -3.5, 0), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5+++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.5, 2.069, -4.875), angle = Angle(0, -3.5, 0), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.8, 2.17, -4.95), angle = Angle(0, -3.5, 0), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp1"] = { type = "Model", model = "models/props_phx/construct/metal_plate_curve360x2.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 1.25, -3.3), angle = Angle(-94, -15, -10), size = Vector(0.025, 0.025, 0.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5+++++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.8, 1.85, -4.7), angle = Angle(0, -3.5, 0), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5++++++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.4, 1.72, -4.6), angle = Angle(0, -3.5, 0), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp7"] = { type = "Model", model = "models/props_wasteland/laundry_basket001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14, 2.45, -4.27), angle = Angle(0, 85, -86), size = Vector(0.046, 0.046, 0.009), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} },
    ["gp5++++"] = { type = "Model", model = "models/props_wasteland/wood_fence02a_board03a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.25, 1.96, -4.801), angle = Angle(0, -3.5, 0), size = Vector(0.1, 0.1, 0.025), color = Color(255, 255, 255, 255), surpresslightning = false, material = "phoenix_storms/officewindow_1-1", skin = 0, bodygroup = {} }
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
