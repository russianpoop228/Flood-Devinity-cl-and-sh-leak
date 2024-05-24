
local openedpanel
hook.Add("FMReceivedAchievementData", "Menu", function(ply)
	if openedpanel and openedpanel.ply == ply then openedpanel:Update(ply, true) end
end)

local gradtex = surface.GetTextureID("VGUI/gradient-r")
local lockmat = Material("icon32/lockf.png")
hook.Add("SetupPlayerInfo", "Achievements", function(pnlply, panel)
	local pnl = vgui.Create("DPanelList")
		pnl:SetTall(200)
		pnl:EnableHorizontal(false)
		pnl:EnableVerticalScrollbar(true)
		pnl:SetPadding(1)
		pnl:SetSpacing(1)

	pnl.Update = function(self, ply, dontreq)
		if not dontreq then
			net.Start("FMReqAchData")
				net.WriteUInt(ply:UserID(), 16)
			net.SendToServer()
		end

		self.ply = ply
		openedpanel = self

		pnl:Clear()

		local achtbl = {}
		for k, v in pairs(AchGetData(ply)) do
			if not Achievements[k] then printWarn("Couldn't find achievementdata for %q!", k) continue end

			table.insert(achtbl, {achid = k, value = v, name = Achievements[k].name})
		end

		for k, _ in pairs(Achievements) do
			--if v.hidden then continue end
			if not Achievements[k] then printWarn("Couldn't find achievementdata for %q!", k) continue end

			local found = false
			for _, v2 in pairs(achtbl) do
				if v2.achid == k then found = true break end
			end

			if not found then
				table.insert(achtbl, {achid = k, value = 0, name = Achievements[k].name})
			end
		end

		for _, t in pairs(achtbl) do
			t.achieved = t.value == -1
			t.goal = Achievements[t.achid].goal
			t.locked = AchLocked(ply, t.achid) -- can this be progressed on
			t.hidden = Achievements[t.achid].hidden and t.value != -1 -- is hidden
			t.perc = t.achieved and 1 or t.value / t.goal -- completion percentage
			t.isonetime = t.goal == 1 -- is a "one-time" achievement
		end

		table.sort(achtbl, function(a, b)
			-- Move hidden down
			if a.hidden != b.hidden then
				return b.hidden
			end

			-- Move achieved up
			if a.achieved != b.achieved then
				return a.achieved
			end

			if not a.achieved then
				-- Both are unachieved
				-- Move higher completion percentage up
				if a.perc != b.perc then
					return a.perc > b.perc
				end

				-- Move one-time achievements up
				if a.isonetime != b.isonetime then
					return a.isonetime
				end

				-- Same completion percentage, sort alphabetically
				-- Sort by achievement id so they get grouped together
				return a.achid < b.achid
			else
				-- Both are completed
				return a.achid < b.achid
			end
		end)

		for _, v in pairs(achtbl) do
			local achid = v.achid
			local value = v.value

			local drawprog = not v.achieved and not v.hidden and not v.locked and v.goal > 1

			local icons = Achievements[achid].icons
			local bg = vgui.Create("DPanel")
				bg:SetTall(50 + (drawprog and 10 or 0))
				bg:DockPadding(36, 4, 2, 4)
				local gradclr = table.Copy(FMCOLORS.txt)
				gradclr.a = 100
				bg.Paint = function(this, pnlw, pnlh)
					DPanel.Paint(this, pnlw, pnlh)
					local cy = pnlh / 2

					if v.locked then
						surface.SetDrawColor(Color(150,150,150,50))
						surface.SetMaterial(lockmat)
						surface.DrawTexturedRect(pnlw - pnlh, 0, pnlh, pnlh)
					elseif v.achieved then
						surface.SetDrawColor(gradclr)
						surface.SetTexture(gradtex)
						surface.DrawTexturedRect(pnlw / 2, 2, pnlw / 2, pnlh - 4)
					end

					for _,v2 in pairs(icons) do
						local col = v2.col
						col.a = v.hidden and 150 or 255

						surface.SetMaterial(v2.mat)
						surface.SetDrawColor(col)
						surface.DrawTexturedRect(v2.x + 2, cy - 16 + v2.y + 2, v2.w, v2.h)
					end
				end

			local head = vgui.Create("DLabel", bg)
				head:Dock(TOP)
				if v.achieved then head:SetTextColor(Color(102,140,51,255)) else head:SetDark(true) end
				head:SetFont("FMRegular24")
				head:SetText(Achievements[achid].name)
				head:SizeToContentsY()

			local desc = vgui.Create("DLabel", bg)
				desc:Dock(TOP)
				desc:SetDark(true)
				desc:SetFont("FMRegular18")
				desc:SetText(v.hidden and "Hidden Achievement" or Achievements[achid].desc)
				desc:SizeToContentsY()

			if drawprog then
				local prog = vgui.Create("FMProgress", bg)
					prog:Dock(BOTTOM)
					prog:SetMax(v.goal)
					prog:SetValue(v.achieved and prog:GetMax() or value)
					prog:SetPaintText(true)
			end

			pnl:AddItem(bg)
		end
	end

	pnl:Update(pnlply)

	panel:AddItem(pnl, "Achievements")
end)
