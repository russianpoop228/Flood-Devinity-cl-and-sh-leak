
local chatx = 75
local chaty = ScrH() - 200

local showam = 5
local chatautocomplete = nil
local chatautocompletepnl
local function UpdateChatAutocomplete()
	if not chatautocompletepnl then
		chatautocompletepnl = vgui.Create("Panel")
			chatautocompletepnl:SetPos(chatx, chaty + 14)
			chatautocompletepnl:SetSize(1000, 1000)

		chatautocompletepnl.btns = {}
		for i = 1, showam do
			local pnl = vgui.Create("DButton", chatautocompletepnl)
				pnl:SetTall(20)
				pnl:SetPos(0, i * (20 + 2))
				pnl:SetText("")
				pnl.Paint = function(_, w, h)
					surface.SetDrawColor(Color(150, 150, 150, 255))
					surface.DrawRect(0, 0, w, h)
				end

			local lbl = vgui.Create("DLabel", pnl)
				lbl:SetText("Test")
				lbl:SetFont(BRGetHUDFont and BRGetHUDFont(18, "Medium") or "FMRegular18")
				lbl:SetPos(5, 1)
			pnl.lbl = lbl

			pnl.DoClick = function()
				local cmd = lbl:GetText()
				chat.SetText(cmd)
			end

			pnl.SetCmd = function(_, cmd)
				lbl:SetText(cmd)
				lbl:SizeToContents()
				pnl:SetWide(lbl:GetWide() + 10)
			end

			chatautocompletepnl.btns[i] = pnl
		end
	end

	if not chatautocomplete or #chatautocomplete == 0 then
		chatautocompletepnl:SetVisible(false)
		return
	end
	chatautocompletepnl:SetVisible(true)

	for i = 1, showam do
		if not chatautocomplete[i] then
			chatautocompletepnl.btns[i]:SetVisible(false)
			continue
		end
		chatautocompletepnl.btns[i]:SetVisible(true)

		chatautocompletepnl.btns[i]:SetCmd(chatautocomplete[i])
	end
end

local cmdlookup
local function FindCommandMatches(attempt)
	if not cmdlookup then
		if table.Count(GetAdminCmds()) == 0 then return {} end
		cmdlookup = {}
		for cmd, _ in pairs(GetAdminCmds()) do
			cmdlookup[cmd] = cmd:sub(3)
		end
	end

	local scores = {}
	for _, cmd in pairs(cmdlookup) do
		local dist = string.levenshtein(cmd, attempt)

		-- Decrease score if we typed the first characters correctly
		if cmd:sub(1,#attempt) == attempt then
			dist = dist / 10
		end

		table.insert(scores, {
			cmd = cmd,
			dist = dist
		})
	end

	table.sort(scores, function(a, b)
		return a.dist < b.dist
	end)

	while #scores > 5 do
		table.remove(scores)
	end

	return scores
end

local function parseArguments(cmd, argsstr)
	local cmdtbl = GetAdminCmds()["d_" .. cmd]
	if not cmdtbl then return argsstr end -- might happen idk

	local args = string.Explode(" ", argsstr, false)
	local cmdargs = cmdtbl.args

	local out = {}
	for k, v in pairs(cmdargs) do
		local attempt
		if v.typ == CMDARG_EOLSTRING then
			attempt = table.concat(args, " ", k)
		else
			attempt = args[k]
		end

		if attempt and #attempt > 0 then
			out[k] = attempt
		else
			out[k] = "<" .. v.desc .. ">"

			if v.optional then
				out[k] = "[" .. out[k] .. "]"
			end
		end
	end

	return table.concat(out, " ")
end

hook.Add("DefaultChanged", "AutoComplete", function(typed)
	if typed:Left(1) == "!" or typed:Left(1) == "/" then
		local symb = typed:Left(1)
		local cmd = typed:sub(2):match("([^ ]+)")
		if not cmd then chatautocomplete = nil UpdateChatAutocomplete() return end
		local args = typed:match(" (.+)") or ""

		local matches = FindCommandMatches(cmd)
		if #matches == 0 then chatautocomplete = nil UpdateChatAutocomplete() return end
		chatautocomplete = {}
		for i, t in pairs(matches) do
			chatautocomplete[i] = symb .. t.cmd .. " " .. parseArguments(t.cmd, args)
		end
	else
		chatautocomplete = nil
	end

	UpdateChatAutocomplete()
end)

hook.Add("FinishChat", "AutoComplete", function(typed)
	chatautocomplete = nil
	UpdateChatAutocomplete()
end)
