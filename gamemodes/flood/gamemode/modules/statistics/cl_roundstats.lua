
BONUS_SURVIVE = 1
BONUS_SURVIVEALONE = 2
BONUS_DAMAGEDONE = 4
BONUS_TIMEALIVE = 8
net.Receive("FMSendRoundStats", function()
	local ply = net.ReadEntity()
	if not IsValid(ply) then return end

	ply.roundstats = {}

	ply.roundstats.damagedone = ply.GetDamageDone and ply:GetDamageDone() or 0
	ply.roundstats.destroys = net.ReadUInt(10)
	ply.roundstats.timealive = net.ReadUInt(10)
	ply.roundstats.cashspent = net.ReadInt(20)
	ply.roundstats.cashearned = net.ReadInt(20)
	ply.roundstats.propsspawned = net.ReadUInt(10)
	ply.roundstats.healthleft = net.ReadUInt(8)

	local earned = 0
	local flags = net.ReadUInt(4)
	ply.roundstats.bonuses = {}
	if bit.band(flags, BONUS_SURVIVE) == BONUS_SURVIVE then
		local bonus = net.ReadUInt(16)
		ply.roundstats.bonuses[BONUS_SURVIVE] = bonus
		earned = earned + bonus
	end
	if bit.band(flags, BONUS_SURVIVEALONE) == BONUS_SURVIVEALONE then
		local bonus = net.ReadUInt(16)
		earned = earned + bonus
		ply.roundstats.bonuses[BONUS_SURVIVEALONE] = {
			cash = bonus,
			wonover = net.ReadUInt(8)
		}
	end
	if bit.band(flags, BONUS_DAMAGEDONE) == BONUS_DAMAGEDONE then
		local bonus = net.ReadUInt(16)
		earned = earned + bonus
		ply.roundstats.bonuses[BONUS_DAMAGEDONE] = bonus
	end
	if bit.band(flags, BONUS_TIMEALIVE) == BONUS_TIMEALIVE then
		local bonus = net.ReadUInt(16)
		earned = earned + bonus
		ply.roundstats.bonuses[BONUS_TIMEALIVE] = bonus
	end
	ply.roundstats.cashearned = ply.roundstats.cashearned + earned
end)

local bonustotext = {
	[BONUS_SURVIVE] = "Survived",
	[BONUS_SURVIVEALONE] = "Survived Alone",
	[BONUS_DAMAGEDONE] = "Damage Done",
	[BONUS_TIMEALIVE] = "Time Spent Alive"
}

local function PaintPanelBright(self, w, h)
	derma.GetDefaultSkin().tex.Panels.Bright(0, 0, w, h, self.m_bgColor)
end

local timeformats = {
	{
		sec = "%i sec",
		minsec = "%i min %i sec",
	},
	{
		sec = "%is",
		minsec = "%im %is",
	},
}
local function FormatTime(t, short)
	local i = short and 2 or 1

	if t <= 60 then
		return timeformats[i].sec:format(t)
	end

	local min = math.floor(t / 60)
	local sec = t % 60

	return timeformats[i].minsec:format(min, sec)
end

--[[
Ideas:
heart - Most Careful - Most amount of health left
rainbow - Living On The Edge - Guy with least amount of health left (max 10hp)
sword - The Destroyer - Destroyed most props
chart - Economically Unstable - Most negative profit
molecule - Corrosive - Most damage done
briefcase - Bankman - Most profit
boxer - Alone Winner - Won alone
pukecash - Shopaholic - Spent most cash
pyramid - Builder - Created the most props
]]
local roundbestfuncs = {
	-- Most Careful
	function()
		local most = 0
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			if v.roundstats.healthleft > most then
				most = v.roundstats.healthleft
				ply = v
			end
		end

		if not ply then return end
		if most == 100 then return end -- If someone or several has 100 hp, it's no fun

		return {"Most Careful", ply:FilteredNick(), "Had " .. most .. "hp at the end of the round.", Material("icon32/achievements/heart.png", "noclamp unlitgeneric smooth")}
	end,
	-- Living On The Edge
	function()
		local leasthp = 100
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			if v.roundstats.healthleft > 0 and v.roundstats.healthleft < leasthp then
				leasthp = v.roundstats.healthleft
				ply = v
			end
		end

		if not ply then return end
		if leasthp > 10 then return end

		return {"Living On The Edge", ply:FilteredNick(), "Had only " .. leasthp .. "hp at the end of the round.", Material("icon32/achievements/rainbow.png", "noclamp unlitgeneric smooth")}
	end,
	-- The Destroyer
	function()
		local most = 0
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			if v.roundstats.destroys > most then
				most = v.roundstats.destroys
				ply = v
			end
		end

		if not ply then return end
		if most == 0 then return end

		return {"The Destroyer", ply:FilteredNick(), "Destroyed " .. most .. " props.", Material("icon32/achievements/sword.png", "noclamp unlitgeneric smooth")}
	end,
	-- Economically Unstable
	function()
		local least = 0
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			local profit = v.roundstats.cashearned - v.roundstats.cashspent
			if profit < least then
				least = profit
				ply = v
			end
		end

		if not ply then return end
		if least == 0 then return end

		return {"Economically Unstable", ply:FilteredNick(), "Lost " .. FormatMoney(math.abs(least)) .. " this round!", Material("icon32/achievements/chart.png", "noclamp unlitgeneric smooth")}
	end,
	-- Corrosive
	function()
		local most = 0
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			if v.roundstats.damagedone > most then
				most = v.roundstats.damagedone
				ply = v
			end
		end

		if not ply then return end
		if most == 0 then return end

		return {"Corrosive", ply:FilteredNick(), "Dealt " .. most .. " damage this round.", Material("icon32/achievements/molecule.png", "noclamp unlitgeneric smooth")}
	end,
	-- Bankman
	function()
		local most = 0
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			local profit = v.roundstats.cashearned - v.roundstats.cashspent
			if profit > most then
				most = profit
				ply = v
			end
		end

		if not ply then return end
		if most <= 0 then return end

		return {"Bankman", ply:FilteredNick(), "Earned " .. FormatMoney(most) .. " this round!", Material("icon32/achievements/briefcase.png", "noclamp unlitgeneric smooth")}
	end,
	-- Alone Winner
	function()
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			if v.roundstats.bonuses[BONUS_SURVIVEALONE] then
				ply = v
				break
			end
		end

		if not ply then return end

		return {"Alone Winner", ply:FilteredNick(), "Won by himself against " .. ply.roundstats.bonuses[BONUS_SURVIVEALONE].wonover .. " other players!", Material("icon32/achievements/boxer.png", "noclamp unlitgeneric smooth")}
	end,
	-- Shopaholic
	function()
		local most = 0
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			if v.roundstats.cashspent > most then
				most = v.roundstats.cashspent
				ply = v
			end
		end

		if not ply then return end
		if most < 500 then return end -- No fun

		return {"Shopaholic", ply:FilteredNick(), "Spent " .. FormatMoney(most) .. " on props this round!", Material("icon32/achievements/pukecash.png", "noclamp unlitgeneric smooth")}
	end,
	-- Builder
	function()
		local most = 0
		local ply
		for k,v in pairs(player.GetAll()) do
			if not v.roundstats then continue end
			if v.roundstats.propsspawned > most then
				most = v.roundstats.propsspawned
				ply = v
			end
		end

		if not ply then return end
		if most < 7 then return end -- No fun

		return {"Builder", ply:FilteredNick(), "Used " .. most .. " props for his boat this round!", Material("icon32/achievements/pyramid.png", "noclamp unlitgeneric smooth")}
	end
}
function GetRoundBest()
	local datat = {}
	for k,v in pairs(roundbestfuncs) do
		local out = v()
		if out then
			table.insert(datat, 0, out)
		end
	end

	local outt = {}
	for i=1,math.min(3,#datat) do
		outt[i] = table.remove(datat, math.random(1,#datat))
	end

	return outt
end

--[[
Stats panel
]]
AddSettingsItem("flood", "checkbox", "fm_showroundstats", {lbl = "Show post-round statistics"})
local togglestats = CreateClientConVar("fm_showroundstats", 1, true, false)

local circlemat = Material("icon32/circle.png", "noclamp unlitgeneric smooth")
local frame
function OpenStatsPanel()
	if frame then frame:Remove() end

	local framew = 700

	local plyam = #player.GetAll()
	local tall = math.min(460 + plyam * 17, 700)

	frame = vgui.Create("FMFrame")
		frame:SetSize(framew, tall)
		frame:Center()
		frame:SetSizable(true)
		frame:SetMinimumSize(650, 450)
		frame:MakePopup()
		frame.btnMaxim:Remove()
		frame.btnMinim:Remove()
		frame.lblTitle:Remove()
		frame:DockPadding(5, 36, 5, 5)


	local titlelbl = vgui.Create("DLabel", frame)
		titlelbl:SetFont("FMRegular24")
		titlelbl:SetTextColor(FMCOLORS.txt)
		titlelbl:SetText("Round Over!")
		titlelbl:SizeToContents()

	frame.PerformLayout = function(self, w, h)
		self.btnClose:SetPos(w - 31 - 4, 0)
		self.btnClose:SetSize(31, 31)

		titlelbl:SetPos(w / 2 - 112 / 2,3)
	end
	frame:InvalidateLayout()

	local locstats = LocalPlayer().roundstats or {}

	--[[
	Top Panel
	]]
	local toppanel = vgui.Create("DPanel", frame)
		toppanel:SetTall(230)
		toppanel.Paint = function() end
		toppanel:Dock(TOP)
		toppanel:SetZPos(100)

		local left = vgui.Create("DPanelList", toppanel)
			left:Dock(LEFT)
			left:SetWide(300)
			left.Paint = function() end
			left:EnableHorizontal(false)

			local function MakeMoneyPanel(txt, am)
				local pnl = vgui.Create("DPanel")
					pnl.Paint = function(self, w, h)
						surface.SetFont("FMRegular24")
						surface.SetTextColor(FMCOLORS.txt)

						surface.SetTextPos(0,0)
						surface.DrawText(txt)

						surface.SetTextPos(w - 90,0)
						surface.DrawText(FormatMoney(am))
					end
					pnl:SetTall(26)

				left:AddItem(pnl)
			end
			local function MakeSpacer()
				local pnl = vgui.Create("DPanel")
					pnl:SetTall(10)
					pnl.Paint = function(self,w,h)
						surface.SetDrawColor(FMCOLORS.txt)
						surface.DrawRect(0,4,w,2)
					end

				left:AddItem(pnl)
			end

			local lbl = vgui.Create("DPanel")
				lbl.Paint = function(self,w,h)
					surface.SetFont("FMRegular24")
					surface.SetTextColor(FMCOLORS.txt)

					surface.SetTextPos(w / 2 - 129 / 2,0)
					surface.DrawText("Your Economy")
				end
				lbl:SetTall(30)
			left:AddItem(lbl)

			if locstats.bonuses then
				for k,v in pairs(locstats.bonuses) do
					local cash = v
					if istable(v) then cash = v.cash end
					MakeMoneyPanel(bonustotext[k] .. ":", cash)
				end
			end
			MakeSpacer()
			MakeMoneyPanel("Subtotal:", locstats.cashearned or 0)
			MakeMoneyPanel("Spent On Props:", -(locstats.cashspent or 0), 2)
			MakeSpacer()
			MakeMoneyPanel("Total:", (locstats.cashearned or 0) - (locstats.cashspent or 0))

		local right = vgui.Create("DPanelList", toppanel)
			right:Dock(FILL)
			right:DockMargin(10,0,0,0)
			right.Paint = function() end
			right:EnableHorizontal(false)
			right:SetAutoSize(true)
			right:SetSpacing(5)

		local function MakeAwardPanel(title,name,text,iconmat)
			local pnl = vgui.Create("DPanel")
				pnl:SetTall(66)
				pnl:DockPadding(2, 2, 2, 2)
				pnl.Paint = PaintPanelBright
				pnl:SetBackgroundColor(Color(70, 70, 70))

			local icon = vgui.Create("DPanel", pnl)
				icon:SetSize(64,64)
				icon:Dock(LEFT)
				icon.Paint = function()
					surface.SetDrawColor(Color(200,200,200))
					surface.SetMaterial(circlemat)
					surface.DrawTexturedRect(0,0,64,64)

					surface.SetDrawColor(color_white)
					surface.SetMaterial(iconmat)
					surface.DrawTexturedRect(16,16,32,32)
				end

			local lblplyname = vgui.Create("DLabelCenter", pnl)
				lblplyname:SetFont("FMRegular24")
				lblplyname:SetTextColor(FMCOLORS.txt)
				lblplyname:SetText(name)
				lblplyname:Dock(TOP)
				lblplyname:SizeToContents()

			local lbltitle = vgui.Create("DLabelCenter", pnl)
				lbltitle:SetFont("FMRegular20")
				lbltitle:SetTextColor(Color(140,140,140))
				lbltitle:SetText(title)
				lbltitle:Dock(TOP)
				lbltitle:SizeToContents()

			local lbltxt = vgui.Create("DLabelCenter", pnl)
				lbltxt:SetFont("FMRegular18")
				lbltxt:SetTextColor(Color(140,140,140))
				lbltxt:SetText(text)
				lbltxt:Dock(TOP)
				lbltxt:SizeToContents()

			right:AddItem(pnl)
		end
		local best = GetRoundBest()
		for _, v in pairs(best) do
			MakeAwardPanel(unpack(v))
		end
		right:DockMargin(10, (230 - (66 * #best)) / 2, 0, 0)

	--[[
	Middle Panel
	]]
	local midpanel = vgui.Create("DPanel", frame)
		midpanel:SetTall(160)
		midpanel.Paint = function() end
		midpanel:Dock(TOP)
		midpanel:SetZPos(101)
		midpanel.PerformLayout = function(self)
			local margin = (frame:GetWide() - framew - 10) / 2
			self:DockMargin(margin, 0, margin, 0)
		end

		local lbl = vgui.Create("DLabelCenter", midpanel)
			lbl:SetFont("FMRegular24")
			lbl:SetTextColor(FMCOLORS.txt)
			lbl:SetWide(framew - 10)
			lbl:SetPos(5,8)
			lbl:SetText("Your Stats")

		local plist = vgui.Create("DPanelList", midpanel)
			plist:SetSize(framew - 100, 160-35)
			plist:SetPos(50, 35)
			plist:EnableHorizontal(true)
			plist:SetSpacing(6)
			plist:SetPadding(10)
			plist:SetAutoSize(true)
			plist.Paint = PaintPanelBright
			plist:SetBackgroundColor(Color(70, 70, 70))

		local function AddStat(txt)
			local lbl = vgui.Create("DPanel")
				lbl.Paint = function()
					surface.SetFont("FMRegular20")
					surface.SetTextColor(Color(140,140,140))
					surface.SetTextPos(0,0)
					surface.DrawText(txt)
				end
				lbl:SetSize((framew - 100) / 2 - 3 - 5, 20)

			plist:AddItem(lbl)
		end
		AddStat("Props Destroyed: " .. locstats.destroys)
		AddStat("Cash Spent: " .. FormatMoney(locstats.cashspent))
		AddStat("Damage Done: " .. locstats.damagedone)
		AddStat("Cash Earned: " .. FormatMoney(locstats.cashearned))
		AddStat("Props Spawned: " .. locstats.propsspawned)
		AddStat("Cash Profit: " .. FormatMoney(locstats.cashearned - locstats.cashspent))
		AddStat("Time Alive: " .. FormatTime(locstats.timealive))
		AddStat("Health Left: " .. locstats.healthleft .. " hp")

	--[[
	Bottom Panel
	]]
	local botpanel = vgui.Create("DPanel", frame)
		botpanel.Paint = function() end
		botpanel:Dock(FILL)
		botpanel:SetZPos(102)

		local dlist = vgui.Create("DListView", botpanel)
			dlist:Dock(FILL)
			dlist:SetSortable(true)
			dlist:SetMultiSelect(false)
			dlist:AddColumn("Name")
			dlist:AddColumn("Team")
			dlist:AddColumn("Damage"):SetFixedWidth(70)
			dlist:AddColumn("Destroys"):SetFixedWidth(70)
			dlist:AddColumn("Time Alive"):SetFixedWidth(70)
			dlist:AddColumn("Spent $"):SetFixedWidth(50)
			dlist:AddColumn("Earned $"):SetFixedWidth(60)
			dlist:AddColumn("Profit"):SetFixedWidth(60)

		for _, v in pairs(player.GetAll()) do
			local stats = v.roundstats
			if not stats then continue end

			local line = dlist:AddLine(
				v:FilteredNick(),
				(IsValid(v:CTeam()) and v:CTeam():GetName() or ""),
				stats.damagedone,
				stats.destroys,
				FormatTime(stats.timealive, true),
				FormatMoney(stats.cashspent),
				FormatMoney(stats.cashearned),
				FormatMoney(stats.cashearned - stats.cashspent)
			)

			line.Data = {}
			line.SetSortValue = function(self, i, v2) self.Data[i] = v2 end
			line.GetSortValue = function(self, i) return self.Data[i] end

			line:SetSortValue(5, stats.timealive)
			line:SetSortValue(6, stats.cashspent)
			line:SetSortValue(7, stats.cashearned)
			line:SetSortValue(8, stats.cashearned - stats.cashspent)
		end
end

local randseed
net.Receive("FMReOpenStatsPanel", function()
	if not randseed then return end -- No randseed set
	math.randomseed(randseed)
	OpenStatsPanel()
end)

net.Receive("FMOpenStatsPanel", function()
	randseed = net.ReadUInt(32)

	if togglestats:GetBool() == false then return end
	math.randomseed(randseed) -- Makes sure that everybody sees the same awardwinners
	OpenStatsPanel()
end)
