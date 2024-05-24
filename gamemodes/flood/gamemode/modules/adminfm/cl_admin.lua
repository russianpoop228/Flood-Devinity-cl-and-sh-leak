
net.Receive("FMForcedRefundNote", function()
	local cash = net.ReadUInt(32)

	local f = vgui.Create("DFrame")
		f:MakePopup()
		f:SetTitle("Clean")

	local txt = vgui.Create("DLabel", f)
		txt:SetText(string.format("A staff member has decided that your boat caused too much trouble for the server and cleaned it up.\n\t\t\tYou've been refunded %s for this", FormatMoney(cash)))
		txt:SetFont("FMRegular20")
		txt:SizeToContents()
		txt:Dock(FILL)

	local btn = vgui.Create("DButton", f)
		btn:SetText("Alright, I understand.")
		btn:Dock(BOTTOM)
		btn:DockMargin(0, 5, 0, 0)
		btn:SetTall(30)
		btn.DoClick = function()
			f:Close()
		end

	f:SetSize(txt:GetWide() + 10, txt:GetTall() + 30 + 35)
	f:Center()
end)
