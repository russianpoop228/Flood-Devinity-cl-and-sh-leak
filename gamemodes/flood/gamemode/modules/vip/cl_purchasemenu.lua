
local packages = {
	{
		id = "Bronze",
		cost = "10",
		txt = {
			"$10,000 cash",
			"Bronze chattag",
			"Forum tag",
			"10 tokens",
			"Votekick",
			"Vote to skip",
			"Vote to postpone",
			"Paint tool",
			"Color tool",
			"Balloon tool",
			"Trails tool",
			"Custom physgun color",
			"Custom player color",
			"Wings unlocked",
			"Healing stick unlocked"
		}
	},
	{
		id = "Silver",
		cost = "20",
		txt = {
			"$25,000 cash",
			"Silver chattag",
			"Forum tag",
			"30 tokens",
			"Votekick",
			"Vote to skip",
			"Vote to postpone",
			"Noclip for build phase",
			"Thrusters",
			"All tools except material",
			"Custom physgun color",
			"Custom player color",
			"Wings unlocked",
			"Healing stick unlocked"
		}
	},
	{
		id = "Gold",
		cost = "30",
		txt = {
			"$50,000 cash",
			"Gold chattag",
			"Forum tag",
			"60 tokens",
			"Votekick",
			"Voteban",
			"Vote to skip",
			"Vote to postpone",
			"Thrusters",
			"All tools",
			"Noclip for build phase",
			"Custom physgun color",
			"Custom player color",
			"Wings unlocked",
			"Healing stick unlocked",
			"Famas unlocked"
		}
	},
	{
		id = "Platinum",
		cost = "50",
		txt = {
			"$75,000 cash",
			"Platinum chattag",
			"Forum tag",
			"120 tokens",
			"Votekick",
			"Voteban",
			"Vote to skip",
			"Vote to postpone",
			"Thrusters",
			"All tools",
			"Access to !songlist",
			"Noclip for build phase",
			"Custom physgun color",
			"Custom player color",
			"Wings unlocked",
			"Healing stick unlocked",
			"Famas unlocked"
		}
	}
}

local cashmat = Material("icon16/money_dollar.png")

function SetupPurchase(parent, parentw, parenth)
	local pw = math.min(400, parentw)
	local px = math.floor(parentw / 2 - pw / 2)

	local createupgradepanels = function()
		local text = vgui.Create("DLabelWordWrap", parent)
			text:SetMaxWidth(parentw - 10)
			text:SetPos(5, 100)
			text:SetDark(true)
			text:SetFont("FMRegular24")
			text:SetText("Looks like you already have a VIP rank. If you'd like to upgrade, please use our forum purchase page instead.")
			text:SizeToContents()

		local btn = vgui.Create("DButton", parent)
			btn:SetSize(150, 50)
			btn:MoveBelow(text, 5)
			btn:SetText("Take me there!")
			btn:SetPos(math.floor(parentw / 2 - 150 / 2), 200)
			btn.DoClick = function()
				gui.OpenURL("https://devinity.org/pages/Purchase?steamid=" .. LocalPlayer():SteamID())
			end

		return
	end

	local ph = 0
	for k,v in pairs(packages) do
		local thisph = 40 + (#v.txt) * 28 + 50
		if thisph > ph then ph = thisph end
	end

	local btnlist = vgui.Create("DPanelList", parent)
		btnlist:SetPos(px,5)
		btnlist:SetSize(150, ph)
		btnlist:SetPadding(2)
		btnlist:SetSpacing(5)
		btnlist.m_bgColor = FMCOLORS.bg
		Derma_Hook( btnlist, "Paint", "Paint", "Panel" )

		btnlist.Think = function()
			if btnlist:IsVisible() and IsValid(LocalPlayer()) then
				btnlist.Think = nil

				if LocalPlayer():GetVIPTier() > 0 then
					for _, v in pairs(parent:GetChildren()) do v:Remove() end
					createupgradepanels()
				end
			end
		end


	local textpanew = pw - 150 - 5
	local textpanebg = vgui.Create("DPanel", parent)
		textpanebg:SetPos(px + 150 + 5, 5)
		textpanebg:SetSize(textpanew, ph)
		textpanebg.Paint = function()end

	local bottomtext = vgui.Create("DLabelWordWrap", parent)
		bottomtext:SetMaxWidth(parentw - 10)
		bottomtext:SetPos(5, 5 + ph + 5)
		bottomtext:SetDark(true)
		bottomtext:SetFont("FMRegular16")
		bottomtext:SetText(
" • All purchases are non-refundable.\n " ..
"• Any unwarranted payment disputes will result in permanent ban.\n " ..
"• Please rejoin any of our Devinity Flood servers after a transaction is completed to activate your VIP benefits.\n " ..
"• Payments should be instant but may take up to 24 hours to complete.\n " ..
"• We reserve the right to revoke the VIP privileges of those who are either abusing them or banned.")
		bottomtext:SizeToContents()

	local packspanels = {}
	local curopen
	local curanim
	local function OpenPanel(p)
		if curopen == p then return end
		curopen = p

		for k,v in pairs(packspanels) do
			v:SetVisible(false)
		end

		p:SetVisible(true)

		if curanim then
			RemoveAnim(curanim)
		end
		curanim = StartAnim(-textpanew, 0, 1, function(val)
			p:SetPos(val, 0)
		end)
	end

	for k,v in pairs(packages) do
		local color = GetTierColor(GetTierID(v.id))

		local textpane = vgui.Create("DPanel", textpanebg)
			textpane:DockPadding(0,0,0,5)
			textpane:SetPos(-textpanew, 0)
			textpane:SetSize(textpanew, ph)
			textpane.m_bgColor = FMCOLORS.bg
			textpane.PaintOver = function(self)
				local w = self:GetWide()
				surface.SetFont("FMRegular28")
				local txtw = surface.GetTextSize(v.id)
				surface.SetTextPos(w/2 - txtw/2, 5)
				surface.SetTextColor(color)
				surface.DrawText(v.id)

				surface.SetDrawColor(Color(255,255,255,255))
				surface.SetMaterial(cashmat)
				surface.DrawTexturedRect(w - 50, 12, 16, 16)

				surface.SetFont("FMRegular24")
				surface.SetTextPos(w - 35, 8)
				surface.SetTextColor(Color( 128, 191, 124, 255 ))
				surface.DrawText(v.cost)
			end

		local y = 40
		local tpw = textpanew/2
		for _,txt in pairs(v.txt) do
			local lbl = vgui.Create("DLabel", textpane)
				lbl:SetText(txt)
				lbl:SetFont("FMRegular24")
				lbl:SizeToContents()
				lbl:SetPos(tpw - lbl:GetWide()/2, y)
			y = y + 28
		end

		local btn = vgui.Create("DButton", textpane)
			btn:Dock(BOTTOM)
			btn:DockMargin(40,0,40,0)
			btn:SetTall(40)
			btn:SetText("Purchase")
			btn:SetFont("FMRegular22")
			btn.DoClick = function()
				gui.OpenURL(string.format("http://purchase.devinity.org/packredirect.php?steamid=%s&packid=%i", LocalPlayer():SteamID(), k-1))
			end

		table.insert(packspanels, textpane)

		local leftbtn = vgui.Create("DButtonColorOverlay")
			leftbtn:SetTall(40)
			leftbtn:SetText(v.id)
			leftbtn:SetFont("FMRegular22")
			leftbtn:SetColorOverlay(color)
			leftbtn.DoClick = function()
				OpenPanel(textpane)
			end
		btnlist:AddItem(leftbtn)
	end
end
