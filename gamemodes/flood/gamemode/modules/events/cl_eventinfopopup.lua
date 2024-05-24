local PANEL = {}

AccessorFunc(PANEL, "m_eventname", "EventName",	FORCE_STRING)
AccessorFunc(PANEL, "m_eventinfo", "EventInfo")
AccessorFunc(PANEL, "m_maxwidth", "MaxWidth", FORCE_NUMBER)
function PANEL:Init()
	self:DockPadding(5, 5, 5, 5)
	self:SetVisible(false)

	local closeinfolbl = self:Add("DLabel")
		closeinfolbl:Dock(TOP)
		closeinfolbl:SetZPos(200)
		closeinfolbl:SetFont("Default")
		closeinfolbl:SetText("Press F3 to close this.")
		closeinfolbl:SizeToContents()

	self.m_maxwidth = math.Round(ScrW() / 5)
end

function PANEL:Setup()
	local maxw = 0

	local titlelbl = self:Add("DLabelCenter")
		titlelbl:SetFont("FMRegular28")
		titlelbl:SetTextColor(FMCOLORS.txt)
		titlelbl:SetText(self:GetEventName() .. "!")
		titlelbl:SizeToContents()

		maxw = math.max(titlelbl.txt:GetWide(), maxw)

		titlelbl:Dock(TOP)
		titlelbl:DockMargin(0, 0, 0, 15)

	for _, str in pairs(self:GetEventInfo()) do
		str = "• " .. str

		local infolbl = self:Add("DLabelWordWrap")
			infolbl:SetFont("FMRegular20")
			infolbl:SetTextColor(FMCOLORS.txt)
			infolbl:SetMaxWidth(self:GetMaxWidth() - 10)
			infolbl:SetText(str)
			infolbl:SizeToContents()

			maxw = math.max(infolbl:GetWide(), maxw)

			infolbl:Dock(TOP)
			infolbl:DockMargin(0, 0, 0, 10)
	end

	self:SetWide(maxw + 10)

	self:InvalidateLayout(true)
end

function PANEL:MakePopup()
	self:SetVisible(true)

	local w, h = self:GetSize()
	local y = ScrH() / 2 - h / 2
	self:SetPos(-w, y)

	self:MoveTo(0, y, 0.8, 0, 0.3)
end

function PANEL:PopOut()
	self:Stop()

	local w, h = self:GetSize()
	local y = ScrH() / 2 - h / 2

	self:MoveTo(-w, y, 0.5, 0, 1.9, function()
		self:Remove()
	end)
end

function PANEL:PerformLayout()
	self:SizeToChildren(false, true)
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(0, 0, w, h)
end

vgui.Register("FMEventInfoPopup", PANEL, "DPanel")

local popup
function GM:MakeEventInfoPopup(eventname, eventinfo)
	if IsValid(popup) then popup:Remove() end

	popup = vgui.Create("FMEventInfoPopup")
		popup:SetEventName(eventname)
		popup:SetEventInfo(eventinfo)
		popup:Setup()
		popup:MakePopup()

	timer.Create("EventInfoPopout", 60, 1, function()
		if IsValid(popup) then
			popup:PopOut()
		end
	end)
end

function CloseEventInfo()
	if IsValid(popup) then
		popup:PopOut()
	end
end
