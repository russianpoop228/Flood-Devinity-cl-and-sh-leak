
SWEP.PrintName     = "Harpoon"
SWEP.Author        = "Donkie"
SWEP.Instructions  = "Leftclick to shoot harpoon.\nRightclick to reel in harpoon."
SWEP.Slot          = 5
SWEP.SlotPos       = 1

SWEP.WepSelectIcon = Material( "vgui/entities/weapon_harpoonfm.png" )

function SWEP:Setup(ply)
	if IsValid(ply:GetViewModel()) then
		local attachmentIndex = ply:GetViewModel():LookupAttachment("muzzle")
		if LocalPlayer():GetAttachment(attachmentIndex) then
			self.VM = ply:GetViewModel()
			self.Attach = attachmentIndex
		end
	end

	if IsValid(ply) then
		local attachmentIndex = ply:LookupAttachment("anim_attachment_RH")
		if ply:GetAttachment(attachmentIndex) then
			self.WM = ply
			self.WAttach = attachmentIndex
		end
	end
end

local function DrawRopeSlack(p1, p2, dist, roplen)
	local sag = roplen - dist

	if sag <= 0 then
		render.DrawBeam(p1, p2, 1, 0, sag < -5 and 100 / sag or dist / 50, Color(255, 255, 255, 255))
		return
	end

	local segments = math.ceil(dist / 10)
	render.StartBeam(segments + 1)
		for i = 0, segments do
			local frac = i / segments
			local pos = LerpVector(frac, p1, p2)
			local sine = math.sin(frac * math.pi)

			local finalpos = pos - Vector(0,0,(sine * sag) / 2)

			render.AddBeam(finalpos, 1, frac * dist / 50, color_white)
		end
	render.EndBeam()
end

local tex = Material("cable/rope")
function SWEP:ViewModelDrawn()
	self.BaseClass.ViewModelDrawn(self)

	if IsValid(self:GetHarpoon()) and self.VM then
		render.SetMaterial( tex )

		local aimang = self.Owner:EyeAngles()
		local pos = self.VM:GetAttachment(self.Attach).Pos
		pos = pos + aimang:Right() * -1 + aimang:Forward() * 0 + aimang:Up() * -2

		local dist = self:GetHarpoon():GetPos():Distance(self.Owner:GetPos())
		local roplen = self:GetRopeLength()
		if not self:GetHarpoon():GetAnchored() then
			roplen = dist
		end

		cam.Start3D(EyePos(), EyeAngles())
			DrawRopeSlack(pos, self:GetHarpoon():LocalToWorld(Vector(-19,0,0)), dist, roplen)
		cam.End3D()
	end
end

function SWEP:DrawWorldModel()
	self.BaseClass.DrawWorldModel(self)

	if IsValid(self:GetHarpoon()) and self.WM then
		render.SetMaterial( tex )
		local posang = self.WM:GetAttachment(self.WAttach)
		if not posang then return end
		DrawRopeSlack(posang.Pos + posang.Ang:Forward() * 32 + posang.Ang:Up() * 7 + posang.Ang:Right() * 1.5, self:GetHarpoon():LocalToWorld(Vector(-19,0,0)), self:GetHarpoon():GetPos():Distance(self.Owner:GetPos()), self:GetRopeLength())
	end
end

function SWEP:Initialize()
	self.BaseClass.Initialize(self)
	self:Setup(self.Owner)

	self:SetHoldType("rpg")
end

function SWEP:Deploy(ply)
	self.BaseClass.Deploy(self)
	self:Setup(self.Owner)
	return true
end

function SWEP:SetupDataTables()
	self:NetworkVar("Entity",0,"Harpoon")
end

SWEP.Base           = "weapon_swepbase"
SWEP.HoldType       = "shotgun"
SWEP.ViewModelFOV   = 66.733668341709
SWEP.ViewModelFlip  = false
SWEP.ViewModel      = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel     = "models/weapons/w_shotgun.mdl"
SWEP.UseHands       = true
SWEP.ShowViewModel  = false
SWEP.ShowWorldModel = false
SWEP.IronSightsPos  = Vector(-10.101, -2.073, 4.559)
SWEP.IronSightsAng  = Vector(0.1, -2.1, -4.301)
SWEP.SWEPKitVElements = {
	["v_harpoongun"] = { type = "Model", model = "models/freeman/harpoongun.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.369, -0.616, 2.236), angle = Angle(47.506, 1.496, 97.013), size = Vector(1.993, 1.993, 1.993), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.SWEPKitWElements = {
	["w_harpoongun"] = { type = "Model", model = "models/freeman/harpoongun.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22.424, 0.677, -2.352), angle = Angle(-6.468, 1.848, 180), size = Vector(1.199, 1.486, 1.486), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.LoopSound = Sound("weapons/harpoon/rope1_loop.wav")
SWEP.FireSound = Sound("weapons/harpoon/harpoon1.mp3")
SWEP.ReelSound = Sound("weapons/harpoon/ratchet.wav")

SWEP.Primary.Delay         = 0.5
SWEP.Primary.ClipSize      = 1
SWEP.Primary.DefaultClip   = 1
SWEP.Primary.Automatic     = false
SWEP.Primary.Ammo          = "harpoon_ammo"

SWEP.Secondary.Delay       = 0.01
SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = true
SWEP.Secondary.Ammo        = "none"

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	if IsValid(self:GetHarpoon()) then return end

	if self:Clip1() == 0 then
		self:Reload()
		return
	end

	self:DisplayHarpoon(false)
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

function SWEP:SetRopeLength(len)
	self._len = len
end

function SWEP:GetRopeLength()
	return self._len or 0
end

function SWEP:CanReel()
	return IsValid(self:GetHarpoon()) and self:GetHarpoon():GetAnchored()
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )

	if IsFirstTimePredicted() and self:CanReel() then
		self:SetRopeLength(math.max(self:GetRopeLength() - 2, 120))
	end
end

net.Receive("SendRopeLength", function()
	local newlen = net.ReadFloat()
	local swep = net.ReadEntity()
	if not IsValid(swep) or not swep.SetRopeLength then return end

	swep:SetRopeLength(newlen)
end)

function SWEP:Think()
end

function SWEP:Reload()
	if self:Clip1() > 0 then return end
	if self:Ammo1() <= 0 then return end
	if IsValid(self:GetHarpoon()) then return end

	self:SetNextPrimaryFire(CurTime() + 18 / 30 + 12 / 30)

	self.Owner:SetAnimation(PLAYER_RELOAD)

	local viewmodel = self.Owner:GetViewModel()
	if not IsValid(viewmodel) then return true end

	viewmodel:SendViewModelMatchingSequence( viewmodel:LookupSequence( "idle_to_lowered" ) )
	timer.Simple(18 / 30, function()
		if IsValid(self) then
			self:DisplayHarpoon(true)
			viewmodel:SendViewModelMatchingSequence( viewmodel:LookupSequence( "lowered_to_idle" ) )
		end
	end)
end

function SWEP:DisplayHarpoon(displayharpoon)
	if self:GetEntityByName("v_harpoongun") then
		self:GetEntityByName("v_harpoongun"):SetBodygroup(1, displayharpoon and 0 or 1)
	end
	if self:GetEntityByName("w_harpoongun") then
		self:GetEntityByName("w_harpoongun"):SetBodygroup(1, displayharpoon and 0 or 1)
	end
end
