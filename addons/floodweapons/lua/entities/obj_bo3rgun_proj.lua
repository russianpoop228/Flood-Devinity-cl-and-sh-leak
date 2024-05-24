AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

sound.Add( {
	name = "rg_explode",
	volume = 0.3,
	level = 3,
	sound = "weapons/wpn_ray_exp.wav"
} )

ENT.CollideSND = "weapons/waw_raygun/raygun/proj_hit.wav"

--ENT.MoveSpeed = 3500
ENT.TrailPCF = "rgun1_trail_child1"
ENT.CollidePCF = "rgun1_impact"
ENT.MuzzlePCF = "rgun1_flash"

function ENT:Initialize()
	self:SetModel( "models/props_junk/PopCan01a.mdl" )
	self:SetNoDraw(true)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow(false)
	self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetSolidFlags(FSOLID_NOT_STANDABLE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self.Entity:SetNetworkedString("Owner", "World")
	--self.cspSound = CreateSound(self, self.TrailSND)
	--self.cspSound:Play()
	if CLIENT then return end
	self:SetTrigger(true)
	if SERVER then
		effect = ents.Create("info_particle_system")
		effect:SetKeyValue("effect_name", self.MuzzlePCF)
		effect:SetKeyValue("start_active", "1")
		effect:SetPos(self:GetPos())
		effect:SetAngles(self:GetAngles())
		effect:SetParent(self)
		effect:Spawn()
		effect:Activate()
	end
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass( 1 )
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:Wake()
		phys:ApplyForceCenter(self:GetForward()*3500)
	else
		self:Remove()
	end
	 ParticleEffect( self.MuzzlePCF, self:GetPos() + self:GetForward() * 55, self:GetAngles() )
	self.LifeTime = CurTime() + math.Rand(3,4)
end


if SERVER then
	function ENT:OnCollide(ent,hitpos)
		if self.DoRemove then return end
		if self.Owner == ent then
			return true
		end
		self.DoRemove = true
		--self.Trail:SetParent(self.Effect)
		--self.Effect:SetParent(NULL)
		--SafeRemoveEntityDelayed(self.Effect,1)
		--self.Effect:Fire("Stop")
		self:PhysicsDestroy()
		SafeRemoveEntityDelayed(self,0)
		

        local dmg = DamageInfo()

			dmg:SetAttacker(self.Owner)
			dmg:SetDamageForce(vector_origin)
			dmg:SetDamagePosition( self.Entity:GetPos() )
			dmg:SetInflictor( self.Owner )								

			dmg:SetDamage( 6 )
			
		local c = ent:GetClass()

	
	 for _,v in pairs(ents.FindInSphere(hitpos,65)) do
	  		if c == "nz_spawn_player" then return end		
		if v == self.Owner then

	
     end
 end
	

		util.BlastDamage( self, self.Owner, hitpos, 65, 335 )		
		self:EmitSound(self.CollideSND)	
	    ParticleEffect( self.CollidePCF, hitpos, self:GetAngles() )		
		util.ScreenShake(hitpos, 1.5, 5, 0.5, 350 )
		return true
	end
	
function ENT:StartTouch(ent)
	if (ent:GetClass() == "prop_dynamic") then return end
		self:OnCollide(ent,self:GetPos())
	end
	
	function ENT:PhysicsCollide(data)
		self:OnCollide(data.HitEntity,data.HitPos)
	end
end

function ENT:PhysicsUpdate()
	if SERVER then

		if self:WaterLevel() > 0 then
			self:Remove()
		end
	end
end


-- Making sure the entity removes if it doesn't hit an object

function ENT:PhysicsUpdate()
	if SERVER then

		if self:WaterLevel() > 0 then
			self:Remove()
		end
	end
end

function ENT:Think()

	self:NextThink(CurTime())

	return true
	
	
end

