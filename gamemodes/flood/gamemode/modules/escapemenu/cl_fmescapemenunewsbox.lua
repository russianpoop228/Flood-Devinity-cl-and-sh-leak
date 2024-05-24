
-- FMEscapeMenuNewsBox
-- MenuBox containing the news feed

local color_text = Color(220, 220, 220)

local font_small = "FMEscapeMenuSmall"
local font_mini = "FMEscapeMenuMini"
local font_mini_i = "FMEscapeMenuMiniItalic"

local PANEL = {}
function PANEL:Init()
	self:SetText("Latest Flood News")

	self.newscontainer = vgui.Create("DScrollPanel", self)
		self.newscontainer:Dock(FILL)
		self.newscontainer:DockMargin(10, 10, 10, 10)

	self:LoadNews()
end

function PANEL:AddNews(title, post, author, date)
	local article = vgui.Create("Panel", self.newscontainer)
		article:Dock(TOP)

	local headline = vgui.Create("DLabel", article)
		headline:Dock(TOP)
		headline:SetFont(font_small)
		headline:SetText(title)
		headline:SetTextColor(color_text)
		headline:SizeToContents()

	local subheader = vgui.Create("Panel", article)
		subheader:Dock(TOP)
		subheader:DockMargin(0, 0, 0, 10)

	local authorlbl = vgui.Create("DLabel", subheader)
		authorlbl:Dock(LEFT)
		authorlbl:SetFont(font_mini_i)
		authorlbl:SetText("By " .. author .. ", " .. date)
		authorlbl:SetTextColor(Color(150, 150, 150))
		authorlbl:SizeToContentsX(30)

	local url = string.match(post, "(https?://[A-Za-z0-9%./#-_]+)")
	if url then
		local linklbl = vgui.Create("DButton", subheader)
			linklbl:Dock(RIGHT)
			linklbl:SetPaintBackground(false)
			linklbl:SetFont(font_mini)
			linklbl:SetText("Follow link")
			linklbl:SetTextColor(FMCOLORS.txt)
			linklbl:SizeToContentsX(20)
			linklbl:DockMargin(0, 0, 10, 0)
			linklbl.DoClick = function()
				gui.OpenURL(url)
			end

		subheader:SetTall(math.max(authorlbl:GetTall(), linklbl:GetTall()))
	else
		subheader:SetTall(authorlbl:GetTall())
	end

	local text = vgui.Create("DLabelWordWrap2", article)
		text:Dock(TOP)
		text:SetFont(font_mini)
		text:SetText(post)
		text:SetTextColor(Color(180, 180, 180))
		text:SizeToContents()
		text:DockMargin(10, 0, 0, 10)

	article.PerformLayout = function(_, _, h)
		local calctall = headline:GetTall() + subheader:GetTall() + 10 + text:GetTall() + 10
		if h != calctall then
			article:SetTall(calctall)
		end
	end
end

function PANEL:LoadNews()
	self.newscontainer:Clear()
	http.Fetch("https://loading.devinity.org/fm/grabavatar.php?steamid=" .. LocalPlayer():SteamID64(),
		function(body, len, headers, code)
			if code != 200 then
				printError("Failed to fetch news, error code %d", code)
			end

			local data = util.JSONToTable(body)
			if not data or not data.news then
				printError("Failed to fetch news, invalid body")
			end

			for _, t in pairs(data.news) do
				local post = string.gsub(t.post,"<br>","\n")
				self:AddNews(t.title, post, t.author, t.date)
			end
		end,
		function(err)
			printError("Failed to fetch news, error: %q", err)
		end)
end

function PANEL:PerformLayout()
end

function PANEL:Think()
end
vgui.Register("FMEscapeMenuNewsBox", PANEL, "FMEscapeMenuBox")
