
function GM:FMGiftMessage()
	return "Yay!", "You've received a gift. You were given:"
end

net.Receive("FMSendGiftNotification", function()
	local name = net.ReadString()

	local title, message = hook.Run("FMGiftMessage")

	local p = vgui.Create("DPanel")
		p:SetSize(400,120)
		p:SetPos(ScrW() / 2 - 200, ScrH() / 3)
		p:SetAlpha(0)
		p:AlphaTo(255, 3)
		timer.Simple(9, function()
			p:AlphaTo(0, 1)
		end)

	local txt1 = vgui.Create("DLabel", p)
		txt1:SetText(title)
		txt1:SetFont("FMRegular24")
		txt1:SizeToContents()
		txt1:SetPos(0,5)
		txt1:SetDark(true)

	local txt2 = vgui.Create("DLabel", p)
		txt2:SetText(message)
		txt2:SetFont("FMRegular20")
		txt2:SizeToContents()
		txt2:SetPos(0,50)
		txt2:SetDark(true)

	local txt3 = vgui.Create("DLabel", p)
		txt3:SetText(name)
		txt3:SetFont("FMRegular24")
		txt3:SizeToContents()
		txt3:SetPos(0,80)
		txt3:SetDark(true)

	p:SetWide(math.min(ScrW(), math.max(txt1:GetWide(), txt2:GetWide(), txt3:GetWide()) + 10))
	p:CenterHorizontal()
	txt1:CenterHorizontal()
	txt2:CenterHorizontal()
	txt3:CenterHorizontal()

	timer.Simple(10, function()
		p:Remove()
	end)
end)
