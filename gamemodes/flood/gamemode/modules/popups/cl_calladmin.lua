
local PANEL = {}
function PANEL:Init()
	self:SetTitle("Call admin")

	self:SetWide(300)

	self.lbl1 = vgui.Create("DLabelWordWrap2", self)
		self.lbl1:Dock(TOP)
		self.lbl1:SetFont("FMRegular20")
		self.lbl1:SetTextColor(FMCOLORS.txt)
		self.lbl1:SetText("You're about to notify the staff team.")
		self.lbl1:SizeToContentsY()

	self.lbl2 = vgui.Create("DLabel", self)
		self.lbl2:Dock(TOP)
		self.lbl2:DockMargin(0, 10, 0, 0)
		self.lbl2:SetFont("FMRegular18")
		self.lbl2:SetTextColor(FMCOLORS.txt)
		self.lbl2:SetText("Misuse may result in a permanent ban.")
		self.lbl2:SetContentAlignment(5)
		self.lbl2:SizeToContentsY()

	self.accept = vgui.Create("DButton", self)
		self.accept:Dock(TOP)
		self.accept:DockMargin(20, 5, 20, 0)
		self.accept:SetText("Continue")
		self.accept:SetTall(30)
		self.accept.DoClick = function()
			self:Close()

			RunConsoleCommand("d_submitrequest", self.reason or "")
		end

	self:MakePopup()
end

function PANEL:SetReason(reason)
	reason = reason:Trim():ucfirst()
	reason = reason:TrimRight(".") .. "."

	self.reason = reason

	self.lbl1:SetText(("You're about to notify the staff team with the text \"%s\"."):format(reason))
	self.lbl1:SizeToContentsY()
	self:InvalidateLayout()
end

function PANEL:PerformLayout(w, h)
	DFrame.PerformLayout(self, w, h)

	local calctall = 30 + self.lbl1:GetTall() + 10 + self.lbl2:GetTall() + 5 + self.accept:GetTall() + 5
	if h != calctall then
		self:SetTall(calctall)
		self:Center()
	end
end

vgui.Register("FMCallAdminPopup", PANEL, "DFrame")

local shoutmenu
net.Receive("FMOpenShoutPopup", function()
	if IsValid(shoutmenu) then shoutmenu:Remove() end

	local reason = net.ReadString()

	shoutmenu = vgui.Create("FMCallAdminPopup")

	if reason and #reason > 0 then
		shoutmenu:SetReason(reason)
	end
end)
