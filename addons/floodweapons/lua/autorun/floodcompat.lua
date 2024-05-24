
if engine.ActiveGamemode() != "sandbox" then return end

AddCSLuaFile()

print("-----------")
print("Flood Weapons: Loaded flood compatibility module")
print("-----------")

-- Particle quality
QUALITY = 1

--[[
Bazooka
]]
BazookaDamage                = 15 -- The damage the impact explosion does
BazookaDamageRadius          = 300 -- Radius in which the explosion does direct damage
BazookaUnweldChance          = 10 -- Chance that an impact explosion damaged prop will also unweld everything
BazookaForceMultiplier       = 1 -- How much props are pushed (The force is calculated with this value along with the distance from epicenter to the prop.)

BazookaBurnTime              = 14 -- How long ignited props will burn
BazookaBurnRadius            = 250 -- Radius in which fire is applied
BazookaIgniteChance          = 100 --  Chance that an ignition will happen per prop

BazookaVelocity              = 25 -- Velocity, default 25
BazookaGravity               = 0.1 -- Gravity, default 0.2

BazookaPenetrate             = false -- Is the explosion and ignition able to penetrate props? For realism, put this to false. Works exactly like the cannon does.

BazookaHitWater              = true -- Does hitting water count as a hit, or should it just continue to the depths of concrete?
BazookaExplodeOnWaterContact = true -- Hitting water, should it make it explode or just die?

--[[
Hooks
]]
hook.Add("FMPlayerCanDamage", "Compat", function() return true end)

--[[
Functions
]]
local meta = FindMetaTable("Entity")
local plymeta = FindMetaTable("Player")

function meta:IsDestroyable()
	return true
end

if SERVER then
	function meta:FMIgnite(ply, time)
		self:Ignite(time or 60)
	end

	local function damageWeld(const, power, atkr)
		local chance = math.Rand(0.5, 1) / power -- chance of the constraint surviving

		if math.random() > chance then
			const:Remove()

			const.Ent1:IsConstrained() -- Updates some network var
			const.Ent2:IsConstrained()

			return true
		else
			return false
		end
	end

	-- Randomly causes attached to this entity to break.
	-- The chance to break increases as props are more damaged.
	-- Default power = 1, use higher power for increased break chance. Use power = math.huge for guaranteed breaking
	function meta:DamageWeld(attacker, power)
		if isnumber(attacker) then -- Backwards compatibility
			attacker = power
			power = 1
		end

		power = power or 1

		local constraints = constraint.FindConstraints(self, "Weld")
		for _, const in pairs(constraints) do
			damageWeld(const, power, attacker)
		end
	end

	util.AddNetworkString("FMHint")
	function plymeta:Hint(text, icon, sound)
		if self:IsBot() then
			MsgN(string.format("[%s HINT]: %s", tostring(self), text)) -- Print to console instead so devs can see
			return
		end

		net.Start("FMHint")
			net.WriteString(text)
			net.WriteString(sound or "ambient/water/drip" .. math.random(1, 4) .. ".wav")
		net.Send(self)
	end

	function plymeta:HintError(text)
		self:Hint(text, "exclamation", "buttons/button10.wav")
	end
else
	function Hint(text, icon, snd)
		if not IsValid(LocalPlayer()) then return end

		notification.AddLegacy(text, NOTIFY_GENERIC, 5)

		surface.PlaySound(snd or "ambient/water/drip" .. math.random(1, 4) .. ".wav")
		LocalPlayer():PrintMessage(HUD_PRINTCONSOLE, text .. "\n") -- Print to console too, incase he missed it
	end

	function HintError(text)
		Hint(text, "exclamation", "buttons/button10.wav")
	end

	function plymeta:Hint(...)
		if self != LocalPlayer() then return end
		Hint(...)
	end

	function plymeta:HintError(...)
		if self != LocalPlayer() then return end
		HintError(...)
	end

	-- Receive hints from the server
	net.Receive("FMHint", function()
		local text = net.ReadString()
		local snd = net.ReadString()

		Hint(text, nil, snd)
	end)
end
