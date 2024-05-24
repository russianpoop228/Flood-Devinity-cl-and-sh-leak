
local lookup
local function makeCmdLookup()
	lookup = {}
	for k,v in pairs(GetAdminCmds()) do
		table.insert(lookup, {cmd = k, rank = v.rank, desc = v.desc, args = v.args})
	end

	table.sort(lookup, function(a,b)
		if a.rank != b.rank then
			return a.rank < b.rank
		end

		return a.cmd < b.cmd
	end)
end

local function DrawPanel( x,y,w,h,col )
	derma.GetDefaultSkin().tex.Panels.Bright( x,y,w,h, col )
end

local argtostr = {
	[CMDARG_PLAYER]    = "Player",
	[CMDARG_PLAYERS]   = "Player(s)",
	[CMDARG_STEAMID]   = "SteamID",
	[CMDARG_NUMBER]    = "Number",
	[CMDARG_EOLSTRING] = "Text",
	[CMDARG_STRING]    = "Text",
}
local function ArgTypeToStr( argtype )
	return argtostr[argtype]
end

local bgcmds
local function SetupCommandsPanel()
	makeCmdLookup()

	local pnl = bgcmds

	pnl:Clear()

	local pw = pnl:GetParent():GetParent():GetParent():GetWide()

	local argsw = pw * (2 / 5)

	for _, v in ipairs(lookup) do
		local p = vgui.Create("DPanel")
			p:DockMargin(0, 0, 0, 5)

		local pr = vgui.Create("DPanel", p)
			pr:SetPos(5,5)
			pr:SetSize(110, 24)
			pr.Paint = function(self, w, h)
				DrawPanel(0,0,w,h,GetTierColor(v.rank))
				draw.SimpleText(GetTierName(v.rank), "FMRegular20", w / 2, h / 2, Color(255, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

		local lbl1 = vgui.Create("DLabel", p)
			lbl1:SetPos(110 + 8,8)
			lbl1:SetFont("FMRegular20")
			lbl1:SetText("!" .. v.cmd:sub(3))
			lbl1:SizeToContents()

		local lbl2 = vgui.Create("DLabelWordWrap", p)
			lbl2:SetPos(5,5 + 24 + 2)
			lbl2:SetMaxWidth(pw - argsw)
			lbl2:SetFont("FMRegular16")
			lbl2:SetText(v.desc)
			lbl2:SizeToContents()

		local argstall = 0
		if #v.args > 0 then
			local lbl3 = vgui.Create("DLabel", p)
				lbl3:SetPos(pw - argsw + 5,5)
				lbl3:SetFont("FMRegular16")
				lbl3:SetText("Arguments:")
				lbl3:SizeToContents()

			local argslist = vgui.Create("DListLayout", p)
				argslist:SetPos(pw - argsw + 5,5 + lbl3:GetTall() + 2)
				argslist:SetWide(argsw - 5 - 35)

			for k2,v2 in pairs(v.args) do
				local s1 = string.format("<%s>", ArgTypeToStr(v2.typ))
				if v2.optional then
					s1 = string.format("[%s]", s1)
				end
				s1 = string.format("#%i %s", k2, s1)
				local s2 = v2.desc

				local ap = vgui.Create("DPanel")
					ap.Paint = function(self, w, h)
						DrawPanel(0,0,w,h,Color(255,234,123))
						draw.SimpleText(s1 , "FMRegular16" , 2 , 2      , FMCOLORS.bg)
						draw.SimpleText(s2 , "FMRegular16" , 2 , 2 + 16 , FMCOLORS.bg)
					end
					ap:SetTall(16 * 2 + 4)
					ap:DockMargin(0, 0, 0, 2)

				argslist:Add(ap)
			end

			argstall = #v.args * (16 * 2 + 4 + 2) - 8
		end

		p:SetTall(5 + lbl1:GetTall() + 5 + math.max(argstall, lbl2:GetTall()) + 5)

		pnl:Add(p)
	end
end

local function SetupRules()
	local basepnl = vgui.Create("DPanel")
		basepnl.Paint = function() end

	local html = vgui.Create( "DHTML", basepnl )
		html:Dock(FILL)
		html:SetWide(600)
		html:SetScrollbars(false)
		html:SetAllowLua(true)

	basepnl.Think = function(self)
		if self:IsVisible() then
			html:OpenURL("http://devinity.org/flood/rules.php")
			self.Think = function() end
		end
	end

	return basepnl
end


function SetupHelpMenu(parent, parentw, parenth)
	local w = math.min(parentw - 15, 586)
	local h = parenth - 45

	local helplist = vgui.Create("DPropertySheet", parent)
		helplist:SetSize(w,h)
		helplist:SetPos(0,5)

	--Rules
	helplist:AddSheet("Rules", SetupRules(), "icon16/comment.png")

	--Commands
	local cmdsscroll = vgui.Create( "DScrollPanel" )

	bgcmds = vgui.Create("DListLayout", cmdsscroll)
		bgcmds:Dock(FILL)

	SetupCommandsPanel()

	helplist:AddSheet("Commands", cmdsscroll, "icon16/comment.png")

	--Changelog
	--helplist:AddSheet("ChangeLog", SetupChangeLogs(), "icon16/page_green.png")
end

hook.Add("FMCommandsReceived", "MakeCmdLookup", function()
	if not bgcmds then return end

	SetupCommandsPanel()
end)
