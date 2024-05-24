
include("shared.lua")

SWEP.PrintName        = "Air-to-surface Missile"
SWEP.Author           = "Otger/Bayrock"
SWEP.Purpose          = "Air-to-surface controllable missile."
SWEP.Instructions     = "Left click to launch an air-to-surface missile from the sky above the aimed position.\n Right click to quit controlling it."
SWEP.WepSelectIcon    = Material( "vgui/entities/weapon_predatorfm.png" )

surface.CreateFont("AsmScreenFont", {
	size      = 18,
	weight    = 400,
	antialias = false,
	shadow    = false,
	font      = "Trebuchet MS"
})

surface.CreateFont("AsmCamFont", {
	size      = 22,
	weight    = 700,
	antialias = false,
	shadow    = false,
	font      = "Courier New"
})

--local texScreenOverlay = surface.GetTextureID("effects/combine_binocoverlay")
--local matMissileAvailable = Material("HUD/asm_available")

local SndReady    = Sound("npc/metropolice/vo/isreadytogo.wav")
local SndReadyB   = Sound("buttons/blip2.wav")
local SndInbound  = Sound("npc/combine_soldier/vo/inbound.wav")

local SndNoPos    = Sound("npc/combine_soldier/vo/sectorisnotsecure.wav")
local SndNoPosB   = Sound("buttons/button19.wav")
local SndNotReady = Sound("buttons/button2.wav")
local SndLost     = Sound("npc/combine_soldier/vo/lostcontact.wav")

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
end

net.Receive("ASM-Update",function()
	local ent = net.ReadEntity()
	local status = net.ReadInt(4)
	if IsValid(ent) && ent:GetClass() == "weapon_predatorfm" then
		ent:UpdateStatus(status)
	end
end)

net.Receive("ASM-Msg",function()
	local nId = net.ReadInt(4)
	if nId == 0 then
		MsgN("[Air-to-surface Missile SWEP] Counter-Strike: Source is not mounted. Using Toolgun model.")
	elseif nId == 1 then
		GAMEMODE:AddNotify("Could not find open sky above the specified position",NOTIFY_ERROR,5)
		LocalPlayer():EmitSound(SndNoPos)
		LocalPlayer():EmitSound(SndNoPosB)
	elseif nId == 2 then
		GAMEMODE:AddNotify("Missiles currently unavailable",NOTIFY_ERROR,5)
		LocalPlayer():EmitSound(SndNotReady)
	elseif nId == 3 then
		GAMEMODE:AddNotify("Lost contact with the missile",NOTIFY_GENERIC,5)
		LocalPlayer():EmitSound(SndLost)
	end
end)

function SWEP:UpdateStatus(status)
	local nLastStatus = self.Status
	self.Status = status
	if status == 0 then
		if self.HtmlIcon then self.HtmlIcon:SetVisible(true) end
		if nLastStatus == -1 then
			self:EmitSound(SndReady)
			self:EmitSound(SndReadyB)
		end
	else
		if self.HtmlIcon then self.HtmlIcon:SetVisible(false) end

		if status == 1 then
			self.Load = CurTime() + 1.75
		elseif status == 2 then
			self:EmitSound(SndInbound)
			self.FadeCount = 0
		elseif status == 3 then
			self.FadeCount = 255
		elseif status == 4 then
			--cam.ApplyShake(LocalPlayer():GetActiveWeapon():GetNWEntity("Missile"):GetPos(),Angle(0,0,0),100)
		end
	end
	if self.Menu && status > 0 then
		self.Menu:SetVisible(false)
	end
end

function SWEP:DrawInactiveHUD()
	if self.Status == 0 then
		draw.RoundedBoxEx(8,ScrW() - 50,60,50,60,Color(224,224,224,255),true,false,true,false)
		draw.DrawText("Missile\nReady","HudHintTextLarge",ScrW() - 4, 26,Color(224,224,224,255),TEXT_ALIGN_RIGHT)
	end
end

function SWEP:CheckFriendly(ent)
	if not ent:IsPlayer() then return false end
	if ent == LocalPlayer() then return true end
	if self.Owner:SameTeam(ent) then return true end
	return false
end

function SWEP:DrawHUD()
	if self.Status > 1 then
		local bNoMissile = false
		local eMissile = self:GetNWEntity("Missile")
		if not IsValid(eMissile) or util.PointContents(eMissile:GetPos()) == CONTENTS_SOLID then
			bNoMissile = true
		end

		if self.Status == 2 then
			surface.SetDrawColor(0,0,0,self.FadeCount)
			surface.DrawRect(0,0,ScrW(),ScrH())

			if self.FadeCount < 255 then
				self.FadeCount = self.FadeCount + 5
			end
		elseif self.Status > 4 or bNoMissile then
			surface.SetDrawColor(0,0,0,self.FadeCount)
			surface.DrawRect(0,0,ScrW(),ScrH())

			if self.FadeCount > 0 then
				self.FadeCount = self.FadeCount - 5
			end
		elseif self.Status == 3 or self.Status == 4 then
			local col = {}
				col["$pp_colour_addr"]       = 0
				col["$pp_colour_addg"]       = 0
				col["$pp_colour_addb"]       = 0
				col["$pp_colour_brightness"] = 0.1
				col["$pp_colour_contrast"]   = 1
				col["$pp_colour_colour"]     = 0
				col["$pp_colour_mulr"]       = 0
				col["$pp_colour_mulg"]       = 0
				col["$pp_colour_mulb"]       = 0
			DrawColorModify(col)
			DrawSharpen(1,2)

			local h = ScrH() / 2
			local w = ScrW() / 2
			local ho = 2 * h / 3

			surface.SetDrawColor(160,160,160,255)
			surface.DrawOutlinedRect(w-48,h-32,96,64)

			surface.DrawLine(w, h-32, w, h-128)
			surface.DrawLine(w, h+32, w, h+128)
			surface.DrawLine(w-48, h, w-144, h)
			surface.DrawLine(w+48, h, w+144, h)

			surface.DrawLine(w-ho, h-ho+64, w-ho, h-ho)
			surface.DrawLine(w-ho, h-ho, w-ho+64, h-ho)
			surface.DrawLine(w+ho-64, h-ho, w+ho, h-ho)
			surface.DrawLine(w+ho, h-ho, w+ho, h-ho+64)
			surface.DrawLine(w+ho, h+ho-64, w+ho, h+ho)
			surface.DrawLine(w+ho, h+ho, w+ho-64, h+ho)
			surface.DrawLine(w-ho+64, h+ho, w-ho, h+ho)
			surface.DrawLine(w-ho, h+ho, w-ho, h+ho-64)

			local pos = eMissile:GetPos()
			surface.SetFont("AsmCamFont")
			surface.SetTextColor(64,64,64,255)

			surface.SetTextPos(24,16)
			surface.DrawText(tostring(math.Round(pos.x)) .. " " .. tostring(math.Round(pos.y)) .. " " .. tostring(math.Round(pos.z)))

			surface.SetTextPos(24,40)
			local dist = self.Owner:GetEyeTrace().HitPos:Distance(pos-Vector(0,0,eMissile:OBBMaxs().z))
			surface.DrawText(tostring(math.Round(dist)) .. " : " .. tostring(math.Round(eMissile:GetVelocity():Length())))

			surface.SetTextPos(24,64)
			surface.DrawText("5 295 [" .. math.Round(CurTime()) .. "]")

			local tEnts = ents.GetAll()
			for _,ent in pairs(tEnts) do
				if ent:IsPlayer() or ent:IsNPC() then
					local vPos = ent:GetPos() + Vector(0,0,0.5 * ent:OBBMaxs().z)
					local scrPos = vPos:ToScreen()
					if self:CheckFriendly(ent) then
						surface.SetDrawColor(64,255,64,160)
						surface.DrawLine(scrPos.x-16,scrPos.y-16,scrPos.x+16,scrPos.y+16)
						surface.DrawLine(scrPos.x-16,scrPos.y+16,scrPos.x+16,scrPos.y-16)
					else
						surface.SetDrawColor(255,64,64,160)
					end
					surface.DrawOutlinedRect(scrPos.x-16, scrPos.y-16,32,32)
				end
			end
		end
	end
	--surface.SetMaterial(matMissileAvailable)
	--surface.SetDrawColor(255,255,255,255)
	--surface.DrawTexturedRect(32, 32, 512, 512)
end

local GlowMat = CreateMaterial("AsmLedGlow","UnlitGeneric",{
	["$basetexture"] = "sprites/light_glow01",
	["$vertexcolor"] = "1",
	["$vertexalpha"] = "1",
	["$additive"]    = "1",
})

function SWEP:ViewModelDrawn()
	if self.Status != 3 and self.Status != 4 then
		local ent = self.Owner:GetViewModel()
		if ent:GetModel() != "models/weapons/v_c4.mdl" then return end

		local bone = ent:LookupBone("v_weapon.c4") or 56
		local pos,ang = ent:GetBonePosition(bone)
		local offset
		if self.Status == 0 then
			offset = Vector(-1.6,2.8,-0.25)
			render.SetMaterial(GlowMat)
			render.DrawQuadEasy(pos + offset,ang:Right() * -1,1.5,1.5,Color(255,128,128,255))
		else
			offset = Vector(-1.8,2.7,1.4)
		end

		offset:Rotate(ang)
		ang:RotateAroundAxis(ang:Forward(),-90)
		ang:RotateAroundAxis(ang:Up(),180)

		local res = 0.03
		local height = 53
		local z = 16

		pos = pos + offset
		cam.Start3D2D(pos,ang,res)
			surface.SetDrawColor(4,32,4,255)
			surface.DrawRect(0,0,96,height)
			if self.Status == -1 then
				draw.SimpleText("Missiles","AsmScreenFont",48,z,Color(80,192,64,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("unavailable","AsmScreenFont",48,z + 16,Color(80,192,64,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			elseif self.Status == 0 then
				draw.SimpleText("Waiting for","AsmScreenFont",48,z,Color(80,192,64,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				draw.SimpleText("target...","AsmScreenFont",48,z + 16,Color(80,192,64,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			elseif self.Status == 1 then
				draw.SimpleText("Requesting...","AsmScreenFont",48,z,Color(80,192,64,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
				surface.SetDrawColor(80,192,64,255)
				surface.DrawOutlinedRect(11,z + 15,74,10)
				surface.SetDrawColor(112,224,96,255)
				surface.DrawRect(12,z + 16,72 * (1-((self.Load-CurTime()) / 1.75)),8)
			else
				draw.SimpleText("Inbound","AsmScreenFont",48,z + 8,Color(80,192,64,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
			end
			//surface.SetTexture(texScreenOverlay)
			//surface.DrawTexturedRectUV(0,0,96,height,96,height)
		cam.End3D2D()
	end
end

function SWEP:FreezeMovement()
	if self.Status > 0 and self.Status != 5 then
		return true
	end
	return false
end

function SWEP:HUDShouldDraw(el)
	if self.Status > 2 and self.Status < 7 then
		return el == "CHudGMod"
	end
	return true
end

function SWEP:OnRemove()
	if self.HtmlIcon and self.HtmlIcon:IsValid() then self.HtmlIcon:Remove() end

	self.HtmlIcon = nil
	if IsValid(self.Menu) then
		self.Menu:SetVisible(false)
		self.Menu:Remove()
	end
	hook.Remove("HUDPaint","AsmSwepDrawHUD")
end

-- Explosion effect

local EFFECT = {}
function EFFECT:Init(data)
	self.Pos = data:GetOrigin()
	self.Radius = data:GetRadius()

	sound.Play("ambient/explosions/explode_4.wav", self.Pos, 100, 140, 1)
	sound.Play("npc/env_headcrabcanister/explosion.wav", self.Pos, 100, 140, 1)

	local em = ParticleEmitter(self.Pos)
	for n = 1,math.ceil(180 * QUALITY) do
		local wave = em:Add("particle/particle_noisesphere",self.Pos)
			wave:SetVelocity(Vector(math.sin(math.rad(n*2)),math.cos(math.rad(n*2)),0)*self.Radius*3)
			wave:SetAirResistance(128)
			wave:SetLifeTime(math.random(0.2,0.4))
			wave:SetDieTime(math.random(3,4))
			wave:SetStartSize(64)
			wave:SetEndSize(48)
			wave:SetColor(160,160,160)
			wave:SetRollDelta(math.random(-1,1))
		local fire = em:Add("effects/fire_cloud1",self.Pos+VectorRand()*self.Radius/2)
			fire:SetVelocity(Vector(math.random(-8,8),math.random(-8,8),math.random(8,16)):GetNormal()*math.random(128,1024))
			fire:SetAirResistance(256)
			fire:SetLifeTime(math.random(0.2,0.4))
			fire:SetDieTime(math.random(2,3))
			fire:SetStartSize(80)
			fire:SetEndSize(32)
			fire:SetColor(160,64,64,192)
			fire:SetRollDelta(math.random(-1,1))
	end
	for n = 1,math.ceil(16 * QUALITY) do
		local smoke = em:Add("particle/particle_noisesphere", self.Pos+48*VectorRand()*n)
			smoke:SetVelocity(VectorRand()*math.Rand(32,96))
			smoke:SetAirResistance(32)
			smoke:SetDieTime(8)
			smoke:SetStartSize((32-n)*2*math.Rand(8,16))
			smoke:SetEndSize((32-n)*math.Rand(8,16))
			smoke:SetColor(160,160,160)
			smoke:SetStartAlpha(math.Rand(224,255))
			smoke:SetEndAlpha(0)
			smoke:SetRollDelta(math.random(-1,1))
	end
	em:Finish()
end

function EFFECT:Think() return false end
function EFFECT:Render() end

effects.Register(EFFECT,"ASM-Explosion")
