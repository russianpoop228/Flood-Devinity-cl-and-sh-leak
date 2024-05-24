
local bannedwords = {
	"fag",
	"dickhead",
	"cockhead",
	"tard",
	"whore",
	"cunt",
	"queer",
	"bitch",
	"nigga",
	"nigger"
}

function GetWordBlacklist()
	return bannedwords
end

function GetBlacklistCount()
	return #bannedwords
end

VIPTools = {}
function AddVIPOnlyTool(name, viptier)
	table.insert(VIPTools, {name = name, tier = viptier})
end

SENTHealth = {}
function AddEntityHealth(name, hp)
	SENTHealth[name] = hp
end

function GM:OnReloaded()
	if (LASTRELOAD or 0) + 5 > SysTime() then return end
	LASTRELOAD = SysTime()
	timer.Simple(0, function()
		printDebug("Gamemode reloaded")
		hook.Run("FMOnReloaded")
	end)
end

function GM:StartCommand(ply, cmd)
	-- Prevent shooting in flood phase
	if self:IsPhase(TIME_FLOOD) then
		-- Admins should still be allowed to use physgun
		local ignore =
			IsValid(ply:GetActiveWeapon()) and
			ply:GetActiveWeapon():GetClass() == "weapon_physgun" and
			hook.Run("FMShouldGivePhysgun", ply)

		if not ignore then
			cmd:RemoveKey(IN_ATTACK)
			cmd:RemoveKey(IN_ATTACK2)
		end
	end
end
