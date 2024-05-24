
local settingspanels = {}
local queue_panels = {}
local queue_items = {}

function AddSettingsItem(panel, typ, convar, data, modrank)
	queue_panels[panel] = true
	table.insert(queue_items, {panel, typ, convar, data, modrank or 0})
end

local function RunPanelsQueue( parent )
	for name,_ in pairs(queue_panels) do
		local pnl = vgui.Create("DPanelList")
			pnl:SetSpacing(2)
			pnl:SetPadding(5)
			pnl:EnableHorizontal(false)
			pnl:SetAutoSize(true)
			pnl:EnableVerticalScrollbar(true)
			Derma_Hook( pnl, "Paint", "Paint", "Panel" )

		local headertext = name:gsub("^%l", string.upper)
		if headertext == "Hud" then headertext = "HUD" end --lol

		local header = vgui.Create("DLabel")
			header:SetText(headertext)
			header:SetFont("FMRegular20")
			header:SetTextColor(FMCOLORS.txt)
			header:SetTall(24)

		pnl:AddItem(header)

		settingspanels[name] = pnl
		parent:AddItem(pnl)
	end
end

local function RunItemsQueue(pnllist)
	for _,tbl in pairs(queue_items) do
		local panel = tbl[1]
		local typ = tbl[2]
		local convar = tbl[3]
		local data = tbl[4]
		if LocalPlayer():GetMODTier(true) < tbl[5] then continue end

		local pnl
		if typ == "checkbox" then

			pnl = vgui.Create("DCheckBoxLabel")
				pnl:SetText(data.lbl)
				pnl:SetTooltip(data.lbl)
				pnl:SetConVar(convar)

		elseif typ == "slider" then

			pnl = vgui.Create("DNumSlider")
				pnl:SetConVar(convar)
				pnl:SetText(data.lbl)
				pnl:SetTooltip(data.lbl)
				pnl:SetMin(data.min)
				pnl:SetMax(data.max)
				pnl:SetDecimals(data.decimals or 0)
				pnl:SetTall(20)

		elseif typ == "button" then

			pnl = vgui.Create("DButton")
				pnl:SetText(data.lbl)
				pnl:SetTooltip(data.lbl)
				pnl:SetTall(20)
				pnl.DoClick = data.func

		else
			MsgN("[Flood] Tried to add invalid settings type '" .. (typ or "") .. "'!")
			return
		end

		settingspanels[panel]:AddItem(pnl)
	end

	for _, v in pairs(settingspanels) do
		if #v:GetItems() == 0 then
			v:Remove()
		end
	end

	pnllist:Rebuild()
end

local panellist
function SetupSettings(parent, parentw, parenth)
	panellist = vgui.Create("DPanelList", parent)
		panellist:Dock(FILL)
		panellist:SetPadding(0)
		panellist:SetSpacing(5)
		panellist:EnableHorizontal(false)
		panellist:EnableVerticalScrollbar()
		panellist.Think = function(self)
			if self:IsVisible() then
				RunPanelsQueue(panellist)
				RunItemsQueue(panellist)
				self.Think = function() end
			end
		end
		local oldperfl = panellist.PerformLayout
		panellist.PerformLayout = function(...)
			local wide = math.min(400, parent:GetWide())
			local margin = (parent:GetWide() - wide) / 2
			panellist:DockMargin(margin, 0, margin, 0)

			oldperfl(...)
		end
end
