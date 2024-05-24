
function OpenPurchaseMenu(str)
	local frame = vgui.Create("DFrame")
		frame:SetSize(250,120)
		frame:SetTitle("Purchase Claim")
		frame:MakePopup()

	local lbl = vgui.Create("DLabel", frame)
		lbl:Dock(FILL)
		lbl:SetText("You have now claimed your '" .. str .. "' purchase!")
		lbl:SetTextColor(FMCOLORS.txt)
		lbl:SetFont("FMRegular22")
		lbl:SizeToContents()

	local btn = vgui.Create("DButton", frame)
		btn:SetSize(40,30)
		btn:SetText("Okay!")
		btn:Dock(BOTTOM)
		btn.DoClick = function() frame:Close() end

	frame:SetSize(lbl:GetWide() + 10, lbl:GetTall() + 30 + 40)
	frame:Center()
end

function OpenTokensPurchaseMenu(am)
	local frame = vgui.Create("DFrame")
		frame:SetSize(250,120)
		frame:SetTitle("Purchase Claim")
		frame:MakePopup()

	local lbl = vgui.Create("DLabel", frame)
		lbl:Dock(FILL)
		lbl:SetText("You have now claimed your purchase of " .. am .. " tokens!")
		lbl:SetTextColor(FMCOLORS.txt)
		lbl:SetFont("FMRegular22")
		lbl:SizeToContents()

	local btn = vgui.Create("DButton", frame)
		btn:SetSize(40,30)
		btn:SetText("Okay!")
		btn:Dock(BOTTOM)
		btn.DoClick = function() frame:Close() end

	frame:SetSize(lbl:GetWide() + 10, lbl:GetTall() + 30 + 40)
	frame:Center()
end
