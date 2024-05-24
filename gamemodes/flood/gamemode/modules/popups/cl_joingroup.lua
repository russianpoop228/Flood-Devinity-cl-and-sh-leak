
local PANEL = {}

local groupmenu
local function CloseGroupPopup()
	if IsValid(groupmenu) then
		groupmenu:Close()
	end
end

function PANEL:Init()
	self:SetTitle("Devinity Steam Group")

	self.lbl1 = vgui.Create("DLabel", self)
		self.lbl1:SetFont("FMRegular24")
		self.lbl1:SetTextColor(FMCOLORS.txt)
		self.lbl1:SetText(string.format("Join our group to earn %i tokens!", GROUPTOKENREWARD))
		self.lbl1:SizeToContents()

	local closetime
	self.joingroupbtn = vgui.Create("DButton", self)
		self.joingroupbtn:SetText("Join Group")
		self.joingroupbtn:SetSize(100, 30)
		self.joingroupbtn.DoClick = function()
			if closetime <= (CurTime() + 20) then -- if it's not already extended
				closetime = CurTime() + 60
				timer.Adjust("FMCloseGroupPopup", 60, 1, CloseGroupPopup)
			end

			self.claimbtn:SetDisabled(false)

			RunConsoleCommand("say", "!group")
		end

	self.claimbtn = vgui.Create("DButton", self)
		self.claimbtn:SetText("Claim")
		self.claimbtn:SetSize(100, 30)
		self.claimbtn:SetDisabled(true)
		self.claimbtn.DoClick = function()
			net.Start("FMGroupRewardAsk")
			net.SendToServer()
		end

	timer.Create("FMCloseGroupPopup", 20, 1, CloseGroupPopup)
	closetime = CurTime() + 20

	self.lbl2 = vgui.Create("DLabel", self)
		self.lbl2:SetFont("FMRegular18")
		self.lbl2:SetTextColor(FMCOLORS.txt)
		self.lbl2:SizeToContents()
		self.lbl2.time = -1
		self.lbl2.Think = function(this)
			if this.time != math.ceil(closetime - CurTime()) then
				this.time = math.ceil(closetime - CurTime())
				this:SetText(string.format("Menu will close in %i seconds.", this.time))
				this:SizeToContents()
			end
		end

	self.chkbx = vgui.Create("DCheckBoxLabel", self)
		self.chkbx:SetText("Don't show this again")
		self.chkbx:SizeToContents()
		self.chkbx:SetCookieName("flood_group_show")

	self:MakePopup()
end

function PANEL:PerformLayout(w, h)
	DFrame.PerformLayout(self, w, h)

	self.lbl1:SetPos(0, 27)
	self.lbl1:CenterHorizontal()

	self.joingroupbtn:MoveBelow(self.lbl1, 5)
	self.joingroupbtn:CenterHorizontal()

	self.claimbtn:MoveBelow(self.joingroupbtn, 5)
	self.claimbtn:CenterHorizontal()

	self.lbl2:MoveBelow(self.claimbtn, 5)
	self.lbl2:CenterHorizontal()

	self.chkbx:SetPos(5, 0)
	self.chkbx:MoveBelow(self.lbl2, 0)

	local calcwide = self.lbl1:GetWide() + 10
	local calctall = 27 + self.lbl1:GetTall() + 5 + 30 + 5 + 30 + 5 + self.lbl2:GetTall() + self.chkbx:GetTall() + 5

	if w != calcwide then
		self:SetWide(calcwide)
		self:Center()
	end
	if h != calctall then
		self:SetTall(calctall)
		self:Center()
	end
end
vgui.Register("FMGroupJoinPopup", PANEL, "DFrame")

net.Receive("FMOpenGroupRewardPopup", function()
	local show = cookie.GetNumber("flood_group_show", 0) == 0

	if show then
		groupmenu = vgui.Create("FMGroupJoinPopup")
	end
end)
