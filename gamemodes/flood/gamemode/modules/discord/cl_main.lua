
if not moduleExist("discord_rpc") then
	printWarn("Discord rich presence module not installed. Install link: https://github.com/Donkie/gm_discord_rpc")
	return
end

require("discord_rpc")

printInfo("Discord RPC module found")

local phasenames = {
	[TIME_BUILD] = "Build",
	[TIME_PREPARE] = "Prepare",
	[TIME_FLOOD] = "Flood",
	[TIME_FIGHT] = "Fight",
	[TIME_REFLECT] = "Reflect"
}

function GM:DiscordUpdatePresence()
	if not IsValid(LocalPlayer()) or not LocalPlayer().CTeam then return end

	local tea = LocalPlayer():CTeam()
	local state = phasenames[GAMEMODE:GetPhase()]

	local presence = {
		details = string.format("%s (%i / %i players)", state, player.GetCount(), game.MaxPlayers()),
		smallImageKey = "devinity",
		smallImageText = "Devinity.org",
		largeImageKey = "flood",
		largeImageText = GetHostName(),
		endTimestamp = os.time() + GAMEMODE:GetTime(),
		-- startTimestamp = "",
		-- joinSecret = ""
	}

	if IsValid(tea) then
		presence.state = "In a team"
		presence.partyId = tea:GetID()
		presence.partySize = tea:GetNumberOfMembers()
		presence.partyMax = GetMaxTeamPlayers()
	else
		presence.state = "Not in a team"
	end


	discord.updatePresence(presence)
end


hook.Add("Initialize", "FMDiscordRPC", function()
	timer.Create("FMDiscordRPCWaitForLocalPlayer", 0, 0, function()
		if IsValid(LocalPlayer()) and LocalPlayer().CTeam then
			timer.Remove("FMDiscordRPCWaitForLocalPlayer")

			discord.init("452192804207067146")
			GAMEMODE:DiscordUpdatePresence()
			timer.Create("FMDiscordRPCUpdatePresence", 15, 0, function()
				GAMEMODE:DiscordUpdatePresence()
			end)
		end
	end)
end)
