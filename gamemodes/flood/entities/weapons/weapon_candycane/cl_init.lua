
SWEP.PrintName    = "Candy Cane"
SWEP.Author       = "Donkie"
SWEP.Instructions = "Leftclick for magic joy"
SWEP.Slot         = 2
SWEP.SlotPos      = 1

SWEP.Base           = "weapon_swepbase"
SWEP.HoldType       = "grenade"
SWEP.ViewModelFOV   = 54.673366834171
SWEP.ViewModelFlip  = false
SWEP.ViewModel      = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel     = "models/weapons/w_crowbar.mdl"
SWEP.ShowViewModel  = false
SWEP.ShowWorldModel = false
SWEP.UseHands       = true
SWEP.SWEPKitVElements = {
	["candycane"] = { type = "Model", model = "models/cloudstrifexiii/candycane/candycane_large.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, 3.635), angle = Angle(-180, -90, -5.844), size = Vector(0.56, 0.56, 0.56), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.SWEPKitWElements = {
	["candycane"] = { type = "Model", model = "models/cloudstrifexiii/candycane/candycane_large.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, 1.557, 2.596), angle = Angle(180, -90, 5.843), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.Delay         = 0.5
SWEP.Primary.ClipSize      = -1
SWEP.Primary.DefaultClip   = -1
SWEP.Primary.Automatic     = false
SWEP.Primary.Ammo          = "none"

SWEP.Secondary.Delay       = 0.01
SWEP.Secondary.ClipSize    = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic   = false
SWEP.Secondary.Ammo        = "none"

function SWEP:Initialize()
	self.BaseClass.Initialize(self)

	self:SetHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	self:SendWeaponAnim( ACT_VM_HITKILL )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end

local firework = Sound("weapons/candycane/firework.mp3")

net.Receive("ConfettiExplosion", function()
	local targ = net.ReadEntity()
	local start = net.ReadInt(32)

	targ:EmitSound(firework,100,100)
	timer.Simple(1.3, function()
		if not IsValid(targ) then return end
		local emitter = ParticleEmitter(targ:GetPos())

		for i = 1,math.random(160,180) do
			local particle = emitter:Add("effects/blueblacklargebeam.vmt", targ:GetPos() + Vector(0,0,100))
			if particle then
				particle:SetLifeTime(math.random(0,0))
				particle:SetDieTime(math.Clamp((200 / 40) + math.random(-10, 10), 10, 40))
				particle:SetStartAlpha(254)
				particle:SetEndAlpha(0)
				particle:SetStartSize(2)
				particle:SetEndSize(2)
				particle:SetAirResistance(0.5)
				particle:SetVelocity(VectorRand():GetNormal() * 120 + Vector(0,0,-10))
				particle:SetGravity(Vector(0,0,-400))
				particle:SetCollide(true)
				particle:SetRollDelta(1)
				particle:SetRoll(math.random(0,360))
				particle.starttime = CurTime()
				particle:SetCollideCallback(function(part, hitpos, hitnormal)
					part:SetRoll(math.pi / 2)
				end)
				particle:SetBounce(0.01)

				local isgreen = math.random(1,2) == 1
				local col = HSVToColor(math.random(-20,20) + (isgreen and 120 or 0), .7, .5 + math.Rand(-.2, .2))
				particle:SetColor(col.r,col.g,col.b,255)
			end
		end
	end)
end)