
AddCSLuaFile()

if CLIENT then
	SWEP.DrawAmmo        = true
	SWEP.DrawCrosshair   = false
	SWEP.ViewModelFOV    = 60
	SWEP.ViewModelFlip   = false
	SWEP.CSMuzzleFlashes = true

	surface.CreateFont("CSKillIcons",   {font = "csd", weight = "500", size = ScreenScale(30), antialiasing = true, additive = true})
	surface.CreateFont("CSSelectIcons", {font = "csd", weight = "500", size = ScreenScale(60), antialiasing = true, additive = true})
end

SWEP.Base                  = "weapon_fmbase"

SWEP.Author                = "Counter-Strike"
SWEP.Contact               = ""
SWEP.Purpose               = ""
SWEP.Instructions          = ""

SWEP.Weight                = 5
SWEP.AutoSwitchTo          = false
SWEP.AutoSwitchFrom        = false

SWEP.Primary.Sound         = Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil        = 1.5
SWEP.Primary.Damage        = 40
SWEP.Primary.NumShots      = 1
SWEP.Primary.Cone          = 0.02
SWEP.Primary.Delay         = 0.15

SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip   = -1
SWEP.Primary.Automatic     = false
SWEP.Primary.Ammo          = "none"

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "none"

SWEP.IronSights            = false

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Reload()
	self:DefaultReload(ACT_VM_RELOAD)

	self.IronSights = false
end

function SWEP:Think()
end

function SWEP:Holster()
	self.IronSights = false
	return true
end

function SWEP:Deploy()
	self.IronSights = false
	return true
end

function SWEP:OnDrop()
	self.IronSights = false
	return true
end

SWEP.NextSecondaryAttack = 0
function SWEP:SecondaryAttack()
	if not self.IronSightsPos then return end
	if self.NextSecondaryAttack > CurTime() then return end

	if not CLIENT or IsFirstTimePredicted() then
		self.IronSights = not self.IronSights
	end

	self.NextSecondaryAttack = CurTime() + 0.3
end

function SWEP:PrimaryAttack()
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.NextSecondaryAttack = CurTime() + 0.3

	if not self:CanPrimaryAttack() then return end

	self:EmitSound(self.Primary.Sound)

	self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)

	self:TakePrimaryAmmo(1)

	if self.Owner:IsNPC() then return end

	self.Owner:ViewPunch(Angle(math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0))

	if game.SinglePlayer() and SERVER or CLIENT then
		self:SetNWFloat("LastShootTime", CurTime())
	end
end

function SWEP:CSShootBullet(dmg, recoil, numbul, cone)
	if SERVER then self:LogWeaponFire() end

	numbul = numbul or 1
	cone   = cone or 0.01

	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Num      = numbul
	bullet.Src      = self.Owner:GetShootPos()
	bullet.Dir      = self.Owner:GetAimVector()
	bullet.Spread   = Vector(cone, cone, 0)
	bullet.Tracer   = 4
	bullet.Force    = 0.5
	bullet.Damage   = dmg

	self:FireBullets(bullet)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if self.Owner:IsNPC() then return end

	if (game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT and IsFirstTimePredicted()) then
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - math.Rand(recoil * 0.5,recoil * 1.5)
		eyeang.yaw = eyeang.yaw + (math.Rand(-10, 10) * recoil * 0.1)
		self.Owner:SetEyeAngles(eyeang)
	end
end

local IRONSIGHT_TIME = 0.25
function SWEP:GetViewModelPosition(pos, ang)
	if not self.IronSightsPos then return pos, ang end

	local bIron = self.IronSights

	if bIron != self.bLastIron then
		self.bLastIron = bIron
		self.fIronTime = CurTime()

		if bIron then
			self.SwayScale = 0.3
			self.BobScale  = 0.1
		else
			self.SwayScale = 1
			self.BobScale  = 1
		end
	end

	local fIronTime = self.fIronTime or 0
	if not bIron and fIronTime < (CurTime() - IRONSIGHT_TIME) then
		return pos, ang
	end

	local mul = 1
	if fIronTime > (CurTime() - IRONSIGHT_TIME) then
		mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

		if not bIron then mul = 1 - mul end
	end

	local Offset = self.IronSightsPos

	if self.IronSightsAng then
		ang:RotateAroundAxis(ang:Right(),   self.IronSightsAng.x * mul)
		ang:RotateAroundAxis(ang:Up(),      self.IronSightsAng.y * mul)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * mul)
	end

	pos = pos + Offset.x * mul * ang:Right()
	pos = pos + Offset.y * mul * ang:Forward()
	pos = pos + Offset.z * mul * ang:Up()

	return pos, ang
end

function SWEP:DrawHUD()
	if self:GetNWBool("Ironsights") then return end

	local x, y

	-- If we're drawing the local player, draw the crosshair where they're aiming, instead of in the center of the screen.
	if self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() then
		local trdata = util.GetPlayerTrace(self.Owner)
			trdata.mask = bit.bor(CONTENTS_SOLID,CONTENTS_MOVEABLE,CONTENTS_MONSTER,CONTENTS_WINDOW,CONTENTS_DEBRIS,CONTENTS_GRATE,CONTENTS_AUX)
		local trace = util.TraceLine(trdata)

		local coords = trace.HitPos:ToScreen()
		x, y = coords.x, coords.y
	else
		x, y = ScrW() / 2, ScrH() / 2
	end

	local scale = 10 * self.Primary.Cone

	-- Scale the size of the crosshair according to how long ago we fired our weapon
	local LastShootTime = self:GetNWFloat("LastShootTime", 0)
	scale = scale * (2 - math.Clamp((CurTime() - LastShootTime) * 5, 0, 1))

	surface.SetDrawColor(0, 255, 0, 255)

	local gap = 40 * scale
	local length = gap + 20 * scale
	surface.DrawLine(x - length , y          , x - gap , y)
	surface.DrawLine(x + length , y          , x + gap , y)
	surface.DrawLine(x          , y - length , x       , y - gap)
	surface.DrawLine(x          , y + length , x       , y + gap)
end



AddCSLuaFile()

if CLIENT then
	SWEP.DrawAmmo        = true
	SWEP.DrawCrosshair   = false
	SWEP.ViewModelFOV    = 60
	SWEP.ViewModelFlip   = false
	SWEP.CSMuzzleFlashes = true

	surface.CreateFont("CSKillIcons",   {font = "csd", weight = "500", size = ScreenScale(30), antialiasing = true, additive = true})
	surface.CreateFont("CSSelectIcons", {font = "csd", weight = "500", size = ScreenScale(60), antialiasing = true, additive = true})
end

SWEP.Base                  = "weapon_fmbase"

SWEP.Author                = "Counter-Strike"
SWEP.Contact               = ""
SWEP.Purpose               = ""
SWEP.Instructions          = ""

SWEP.Weight                = 5
SWEP.AutoSwitchTo          = false
SWEP.AutoSwitchFrom        = false

SWEP.Primary.Sound         = Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil        = 1.5
SWEP.Primary.Damage        = 40
SWEP.Primary.NumShots      = 1
SWEP.Primary.Cone          = 0.02
SWEP.Primary.Delay         = 0.15

SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip   = -1
SWEP.Primary.Automatic     = false
SWEP.Primary.Ammo          = "none"

SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "none"

SWEP.IronSights            = false

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Reload()
	self:DefaultReload(ACT_VM_RELOAD)

	self.IronSights = false
end

function SWEP:Think()
end

function SWEP:Holster()
	self.IronSights = false
	return true
end

function SWEP:Deploy()
	self.IronSights = false
	return true
end

function SWEP:OnDrop()
	self.IronSights = false
	return true
end

SWEP.NextSecondaryAttack = 0
function SWEP:SecondaryAttack()
	if not self.IronSightsPos then return end
	if self.NextSecondaryAttack > CurTime() then return end

	if not CLIENT or IsFirstTimePredicted() then
		self.IronSights = not self.IronSights
	end

	self.NextSecondaryAttack = CurTime() + 0.3
end

function SWEP:PrimaryAttack()
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
	self.NextSecondaryAttack = CurTime() + 0.3

	if not self:CanPrimaryAttack() then return end

	self:EmitSound(self.Primary.Sound)

	self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone)

	self:TakePrimaryAmmo(1)

	if self.Owner:IsNPC() then return end

	self.Owner:ViewPunch(Angle(math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0))

	if game.SinglePlayer() and SERVER or CLIENT then
		self:SetNWFloat("LastShootTime", CurTime())
	end
end

function SWEP:CSShootBullet(dmg, recoil, numbul, cone)
	if SERVER then self:LogWeaponFire() end

	numbul = numbul or 1
	cone   = cone or 0.01

	local bullet = {}
	bullet.Attacker = self.Owner
	bullet.Num      = numbul
	bullet.Src      = self.Owner:GetShootPos()
	bullet.Dir      = self.Owner:GetAimVector()
	bullet.Spread   = Vector(cone, cone, 0)
	bullet.Tracer   = 4
	bullet.Force    = 0.5
	bullet.Damage   = dmg

	self:FireBullets(bullet)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	if self.Owner:IsNPC() then return end

	if (game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and CLIENT and IsFirstTimePredicted()) then
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - math.Rand(recoil * 0.5,recoil * 1.5)
		eyeang.yaw = eyeang.yaw + (math.Rand(-10, 10) * recoil * 0.1)
		self.Owner:SetEyeAngles(eyeang)
	end
end

local IRONSIGHT_TIME = 0.25
function SWEP:GetViewModelPosition(pos, ang)
	if not self.IronSightsPos then return pos, ang end

	local bIron = self.IronSights

	if bIron != self.bLastIron then
		self.bLastIron = bIron
		self.fIronTime = CurTime()

		if bIron then
			self.SwayScale = 0.3
			self.BobScale  = 0.1
		else
			self.SwayScale = 1
			self.BobScale  = 1
		end
	end

	local fIronTime = self.fIronTime or 0
	if not bIron and fIronTime < (CurTime() - IRONSIGHT_TIME) then
		return pos, ang
	end

	local mul = 1
	if fIronTime > (CurTime() - IRONSIGHT_TIME) then
		mul = math.Clamp((CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1)

		if not bIron then mul = 1 - mul end
	end

	local Offset = self.IronSightsPos

	if self.IronSightsAng then
		ang:RotateAroundAxis(ang:Right(),   self.IronSightsAng.x * mul)
		ang:RotateAroundAxis(ang:Up(),      self.IronSightsAng.y * mul)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z * mul)
	end

	pos = pos + Offset.x * mul * ang:Right()
	pos = pos + Offset.y * mul * ang:Forward()
	pos = pos + Offset.z * mul * ang:Up()

	return pos, ang
end

function SWEP:DrawHUD()
	if self:GetNWBool("Ironsights") then return end

	local x, y

	-- If we're drawing the local player, draw the crosshair where they're aiming, instead of in the center of the screen.
	if self.Owner == LocalPlayer() and self.Owner:ShouldDrawLocalPlayer() then
		local trdata = util.GetPlayerTrace(self.Owner)
			trdata.mask = bit.bor(CONTENTS_SOLID,CONTENTS_MOVEABLE,CONTENTS_MONSTER,CONTENTS_WINDOW,CONTENTS_DEBRIS,CONTENTS_GRATE,CONTENTS_AUX)
		local trace = util.TraceLine(trdata)

		local coords = trace.HitPos:ToScreen()
		x, y = coords.x, coords.y
	else
		x, y = ScrW() / 2, ScrH() / 2
	end

	local scale = 10 * self.Primary.Cone

	-- Scale the size of the crosshair according to how long ago we fired our weapon
	local LastShootTime = self:GetNWFloat("LastShootTime", 0)
	scale = scale * (2 - math.Clamp((CurTime() - LastShootTime) * 5, 0, 1))

	surface.SetDrawColor(0, 255, 0, 255)

	local gap = 40 * scale
	local length = gap + 20 * scale
	surface.DrawLine(x - length , y          , x - gap , y)
	surface.DrawLine(x + length , y          , x + gap , y)
	surface.DrawLine(x          , y - length , x       , y - gap)
	surface.DrawLine(x          , y + length , x       , y + gap)
end
