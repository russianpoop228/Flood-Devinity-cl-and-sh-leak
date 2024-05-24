
net.Receive("FMSendAdminNote", function()
	local isred = net.ReadBit() == 1
	local clearclr = net.ReadBit() == 1
	local clr = clearclr and (isred and Color(255,0,0) or Color(0,255,0)) or (isred and Color(255,90,90) or Color(96,201,96))

	local msgtype = net.ReadBit()
	local str = net.ReadString()

	if msgtype == 0 then
		chat.AddText(clr, str)
	else
		MsgC(clr, str .. "\n")
	end
end)

local autocmplts = {}
local function RegisterAutoComplete(cmd, func)
	autocmplts[cmd] = func
end

local cmds = {}
net.Receive("FMSendAdminCommands", function()
	for i = 1,net.ReadUInt(8) do
		local cmd = net.ReadString()
		local rank = net.ReadUInt(5)
		local desc = net.ReadString()
		local args = {}
		for j = 1, net.ReadUInt(3) do
			args[j] = {
				typ = net.ReadUInt(4),
				desc = net.ReadString(),
				optional = net.ReadBit() > 0,
			}
		end
		cmds[cmd] = {rank = rank, desc = desc, args = args}

		local autocmplt = autocmplts[cmd] or function() end
		concommand.Add(cmd, function(_,_,cargs)
			net.Start("FMRunAdminCommand")
				net.WriteString(cmd)
				net.WriteUInt(#cargs, 4)
				for k,v in pairs(cargs) do
					net.WriteString(v)
				end
			net.SendToServer()
		end, autocmplt)
	end

	hook.Run("FMCommandsReceived")
end)

hook.Add("FMOnReloaded", "FMAdminCommandsReload", function()
	net.Start("FMRequestAdminCommands")
	net.SendToServer()
end)

function GetAdminCmds()
	return cmds
end

RegisterAutoComplete("d_kick", function(cmd, sargs)
	local args = string.Explode(" ", string.sub(sargs,2,-1))
	local numargs = #args

	local t = {}

	if numargs > 0 then
		local searchnick = args[1]:lower()
		searchnick = string.gsub(searchnick, "\"", "")

		for k,v in pairs(player.GetAll()) do
			if string.find(v:Nick():lower(), searchnick, 0, true) then
				local str = cmd .. " \"" .. v:Nick() .. "\" "
				if numargs == 1 then
					str = str .. "<reason>"
				else
					str = str .. table.concat(args, " ", 2)
				end
				table.insert(t, str)
			end
		end
	end

	return t
end)

RegisterAutoComplete("d_ban", function(cmd, sargs)
	local args = string.Explode(" ", string.sub(sargs,2,-1))
	local numargs = #args

	local t = {}

	if numargs > 0 then
		local searchnick = args[1]:lower()
		searchnick = string.gsub(searchnick, "\"", "")

		for k,v in pairs(player.GetAll()) do
			if string.find(v:Nick():lower(), searchnick, 0, true) then

				local str = cmd .. " \"" .. v:Nick() .. "\" "
				if numargs == 1 then
					str = str .. "<time> <reason>"
				else
					str = str .. tostring(args[2]) .. " "
					if numargs == 2 then
						str = str .. "<reason>"
					else
						str = str .. table.concat(args, " ", 3)
					end
				end
				table.insert(t, str)

			end
		end
	end

	return t
end)

local function GeneralPlayerAffectAutoComplete(cmd, sargs)
	local args = string.Explode(" ", string.sub(sargs,2,-1))
	local numargs = #args

	local t = {}

	if numargs > 0 then
		local searchnick = args[1]:lower()
		searchnick = string.gsub(searchnick, "\"", "")

		for k,v in pairs(player.GetAll()) do
			if string.find(v:Nick():lower(), searchnick, 0, true) then
				table.insert(t, cmd .. " \"" .. v:Nick() .. "\"")
			end
		end
	end

	return t
end

RegisterAutoComplete("d_mute", GeneralPlayerAffectAutoComplete)
RegisterAutoComplete("d_unmute", GeneralPlayerAffectAutoComplete)
RegisterAutoComplete("d_gag", GeneralPlayerAffectAutoComplete)
RegisterAutoComplete("d_ungag", GeneralPlayerAffectAutoComplete)

RegisterAutoComplete("d_slay", GeneralPlayerAffectAutoComplete)
RegisterAutoComplete("d_goto", GeneralPlayerAffectAutoComplete)
RegisterAutoComplete("d_spectate", GeneralPlayerAffectAutoComplete)

--[[
PM
]]
net.Receive("FMSendPM", function()
	local isTargPlayer = (net.ReadBit() == 1)
	local targNick = "Console"
	local targCol = Color(80, 80, 255)
	if isTargPlayer then
		local targPlayer = net.ReadEntity()
		if IsValid(targPlayer) then
			targNick = targPlayer:FilteredNick()
			if targPlayer:GetVIPTier() > 0 then
				targCol = GetTierColor(targPlayer:GetVIPTier())
			end
		end
	end
	local fromto = (net.ReadBit() == 1) and "To" or "From"
	local txt = net.ReadString()

	chat.AddText(FMCOLORS.txt, "[PM " .. fromto .. " ", targCol, targNick, FMCOLORS.txt, "]: ", color_white, txt)
end)

net.Receive("FMSendPMAdminNote", function()
	local isFromPlayer = (net.ReadBit() == 1)
	local fromNick = "Console"
	local fromCol = Color(80, 80, 255)
	if isFromPlayer then
		local fromPlayer = net.ReadEntity()
		if IsValid(fromPlayer) then
			fromNick = fromPlayer:FilteredNick()
			if fromPlayer:GetVIPTier() > 0 then
				fromCol = GetTierColor(fromPlayer:GetVIPTier())
			end
		end
	end

	local toPlayer = net.ReadEntity()
	local toNick = "Unknown"
	local toCol = Color(80, 80, 255)
	if IsValid(toPlayer) then
		toNick = toPlayer:FilteredNick()
		if toPlayer:GetVIPTier() > 0 then
			toCol = GetTierColor(toPlayer:GetVIPTier())
		end
	end

	local txt = net.ReadString()

	chat.AddText(FMCOLORS.txt, "[PM ", fromCol, fromNick, FMCOLORS.txt, "->", toCol, toNick, FMCOLORS.txt, "]: ", color_white, txt)
end)

--[[
Friends
]]
net.Receive("FMFriendDataRequest", function()
	local callerID = net.ReadUInt(6)

	local friends = {}
	for _, ply in pairs(player.GetAll()) do
		if ply:GetFriendStatus() == "friend" then
			table.insert(friends, ply)
		end
	end

	local friendcount = #friends
	net.Start("FMFriendDataReturn")
		net.WriteUInt(friendcount, 6)

		for _, friend in pairs(friends) do
			net.WriteString(friend:Nick())
		end

		net.WriteUInt(callerID, 6)
	net.SendToServer()
end)

local function GetDuration(seconds)
	seconds = math.abs(seconds)
	if seconds < 1 then
		return "0 Seconds"
	end

	local durtbl = {
		{12 * 30 * 24 * 60 * 60, "year"},
		{30 * 24 * 60 * 60     , "month"},
		{7 * 24 * 60 * 60      , "week"},
		{24 * 60 * 60          , "day"},
		{60 * 60               , "hour"},
		{60                    , "minute"},
		{1                     , "second"}
	}

	for _,v in pairs(durtbl) do
		local secs = v[1]
		local str = v[2]
		local d = seconds / secs
		if d >= 1 then
			d = math.Round(d)
			return d .. " " .. str .. (d > 1 and "s" or "")
		end
	end
end

local function infTypeToColor(inf)
	if inf == "ban" then
		return HSVToColor(0, 0.63, 0.7)
	elseif inf == "kick" then
		return HSVToColor(30, 0.63, 0.7)
	else
		return HSVToColor(60, 0.63, 0.7)
	end
end

local datestr = "%Y/%m/%d"
net.Receive("FMSendAdminGetBans", function()
	local steamid = net.ReadString()
	local data = net.ReadTable()

	--Print to chat
	local c1 = FMCOLORS.txt
	local c2 = Color(182, 204, 154)

	for _, v in pairs(data) do
		chat.AddText(infTypeToColor(v.type), string.format("(%s) ", v.type:upper()), c1, os.date(datestr, v.bannedat), c2, ":")
		if v.type == "ban" then
			chat.AddText(c2, "\tDuration: ", c1, GetDuration(v.unban - v.bannedat))
		end
		chat.AddText(c2, "\tReason: ", c1, v.reason)
		chat.AddText(c2, "\tAdmin: ", c1, v.admin)

		if v.modifieddate and v.modifieddate > 0 then
			chat.AddText(c2, "\tModified: ", c1, os.date(datestr, v.modifieddate), c2, " by ", c1, v.modifiedname)
		end
	end

	chat.AddText(c1, tostring(#data), c2, " infraction" .. (#data != 1 and "s" or "") .. " on record.")
end)

net.Receive("FMOpenBanRequest", function()
	gui.OpenURL("https://devinity.org/pages/bansreq/?" .. net.ReadString())
end)

local function execcode(str)
	local wrap = "local a = function() " .. str .. " end RET = a()"

	RET = nil
	local err = RunString(wrap, "RunLua (" .. LocalPlayer():Nick() .. ")", false)
	if err then
		RET = nil
		return false,err
	end
	if RET == nil then
		return true,"Code ran successfully."
	end

	local msg = tostring(RET)
	RET = nil
	return true, msg
end
net.Receive("ExecuteLua", function()
	local execid = net.ReadUInt(16)
	local code = net.ReadString()

	local bool, msg = execcode(code)

	net.Start("ExecuteLua_Back")
		net.WriteUInt(execid, 16)
		net.WriteBool(bool)
		net.WriteString(msg)
	net.SendToServer()
end)
