
local PANEL = {}
function PANEL:Init()
	self:SetTitle("Warning")
	self:ShowCloseButton(false)

	local lbl1 = vgui.Create("DLabel", self)
		lbl1:Dock(TOP)
		lbl1:SetContentAlignment(5)
		lbl1:SetFont("FMRegular20")
		lbl1:SetTextColor(FMCOLORS.txt)
		lbl1:SetText("Your Steam name violates our rules.")

	local lbl2 = vgui.Create("DLabel", self)
		lbl2:Dock(TOP)
		lbl2:DockMargin(0, 5, 0, 0)
		lbl2:SetContentAlignment(5)
		lbl2:SetFont("FMRegular18")
		lbl2:SetTextColor(FMCOLORS.txt)
		lbl2:SetText("Please change it to remove this notice.")

	self:SetWide(350)
	self:SetTall(30 + lbl1:GetTall() + 5 + lbl2:GetTall() + 5)
	self:Center()

	self:MakePopup()
end
vgui.Register("FMBadNamePopup", PANEL, "DFrame")

local namemenu
net.Receive("FMToggleNameWarning", function()
	if not IsValid(namemenu) then
		namemenu = vgui.Create("FMBadNamePopup")
	else
		namemenu:Close()
	end
end)
