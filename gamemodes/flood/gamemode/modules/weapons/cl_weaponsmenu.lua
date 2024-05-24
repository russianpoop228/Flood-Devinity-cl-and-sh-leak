
surface.CreateFont("FMFontAwesomeWepItemButton",
{
	font     = "FontAwesome",
	size     = 26,
	extended = true
})

surface.CreateFont("FMFontAwesomeWepBadge",
{
	font     = "FontAwesome",
	size     = 18,
	extended = true
})

surface.CreateFont("FMFontAwesomeWepBadgeClick",
{
	font     = "FontAwesome",
	size     = 14,
	extended = true
})

local UpdateWeapons

PANEL = {}
function PANEL:Init()
	self.icon = vgui.Create("DLabel", self)
		self.icon:SetFont("FMFontAwesomeWepItemButton")
		self.icon:SetContentAlignment(5)
		self.icon:SetTextColor(FMCOLORS.txt)
		self.icon:Dock(LEFT)
		self.icon:DockMargin(2, 0, 5, 0)

	self.text = vgui.Create("DLabel", self)
		self.text:SetFont("FMRegular22")
		self.text:SetContentAlignment(4)
		self.text:Dock(FILL)

	self.text:SetVisible(false)

	self:SetPaintBackground(false)
	self:SetText("")
end
function PANEL:SetIcon(hex)
	self.icon:SetText(utf8.char(hex))
end
function PANEL:SetLabel(txt)
	self.text:SetVisible(true)
	self.text:SetText(txt)
end
function PANEL:PerformLayout(w, h)
	self.icon:SetWide(h)
end
function PANEL:Paint(pw, ph)
	local textcol
	if self:GetDisabled() then
		textcol = Color(180, 70, 70)
	elseif self.Hovered then
		textcol = Color(230, 230, 230)
	else
		textcol = Color(180, 180, 180)
	end

	self.text:SetTextColor(textcol)

	local bgcol
	if self.isSelected or self:IsDown() then
		bgcol = FMCOLORS.bg
	elseif self.Hovered then
		bgcol = FMCOLORS.bg
	else
		bgcol = FMCOLORS.bg
	end

	local x, y, w, h
	if self:IsDown() then
		x = 2; y = 2; w = pw - 4; h = ph - 4
	else
		x = 0; y = 0; w = pw; h = ph
	end

	draw.RoundedBox(4, x, y, w, h, bgcol)
end
vgui.Register("FMWeaponsItemButton", PANEL, "DButton")

PANEL = {}
local modelReplacements = {
	["models/blackout.mdl"] = "models/weapons/w_snip_scoub.mdl",
}
local rotationCenters = {
	["models/goldengun.mdl"] = Vector(-20, 0, 0),
	["models/weapons/w_pist_fiveseven.mdl"] = Vector(-4, 0, 0),
	["models/weapons/tfa_cso2/w_tmp.mdl"] = Vector(0, 0, 0),
	["models/weapons/w_rif_ak47.mdl"] = Vector(0, 0, 0),
	["models/weapons/w_rif_galil.mdl"] = Vector(5, 0, 0),
	["models/weapons/w_snip_awp.mdl"] = Vector(0, 0, 0),
	["models/weapons/w_snip_sg550.mdl"] = Vector(0, 0, 0),
	["models/sledge/c_sledgehammer.mdl"] = Vector(-20, 0, 10),
	["models/weapons/w_c4.mdl"] = Vector(0, 0, 0),
}

local drawDebug = false

function PANEL:Init()
	local mdlpnlcont = vgui.Create("Panel", self)
		mdlpnlcont:Dock(TOP)

	local title = vgui.Create("DLabel", self)
		title:Dock(TOP)
		title:SetFont("FMRegular30")
		title:SetDark(true)
		title:SetTall(30)
		title:SetContentAlignment(5)
		title:SetText("")

	local statpnl = vgui.Create("Panel", self)
		statpnl:Dock(TOP)
		statpnl:DockMargin(0, 10, 0, 0)
		statpnl:DockPadding(5, 5, 5, 5)
		statpnl.Paint = function(_, w, h)
			draw.RoundedBox(2, 0, 0, w, h, Color(20, 20, 20, 220))
		end
		statpnl:SetVisible(false)

		local statcol1 = vgui.Create("Panel", statpnl)
			statcol1:Dock(LEFT)
			statcol1.numChildren = 0

		local statcol2 = vgui.Create("Panel", statpnl)
			statcol2:Dock(LEFT)
			statcol2.numChildren = 0

	local descpnl = vgui.Create("Panel", self)
		descpnl:Dock(TOP)
		descpnl:DockMargin(0, 10, 0, 0)
		descpnl:DockPadding(5, 5, 5, 5)
		descpnl.Paint = function(_, w, h)
			draw.RoundedBox(2, 0, 0, w, h, Color(20, 20, 20, 220))
		end

		local description = vgui.Create("DLabelWordWrap2", descpnl)
			description:Dock(TOP)
			description:SetFont("FMRegular20")
			description:SetDark(true)
			description:SetText("")

	local mdlpnl = vgui.Create("DModelPanel", mdlpnlcont)
		mdlpnl:SetCamPos(Vector(50, 0, 20))
		mdlpnl:SetLookAt(Vector(0, 0, 0))
		mdlpnl:SetFOV(40)
		mdlpnl.LayoutEntity = function(this, ent)
			local yaw = RealTime() * 20 % 360
			local min, max = ent:GetModelBounds()

			local largestSize = math.max(math.abs(max.x - min.x), math.abs(max.y - min.y), math.abs(max.z - min.z))
			local cameraDistance = (largestSize + 5) * 1.25
			this:SetCamPos(Vector(1, 0, 0.4) * cameraDistance)
			this:SetLookAt(Vector(0, 0, 0))

			local rotcenter
			if rotationCenters[ent:GetModel()] then
				rotcenter = rotationCenters[ent:GetModel()]
			else
				rotcenter = -(max + min) / 2
			end

			local pos, ang = LocalToWorld(rotcenter, Angle(0, 0, 0), vector_origin, Angle(0, yaw, 0))
			ent:SetPos(pos)
			ent:SetAngles(ang)

			if drawDebug then
				printDebug("Drawing:", ent:GetModel())

				local x, y = this:LocalToScreen(0, 0)
				cam.Start3D(this.vCamPos, (this.vLookatPos - this.vCamPos):Angle(), this.fFOV, x, y, this:GetWide(), this:GetTall(), 5, this.FarZ )
					render.DrawLine(rotcenter, rotcenter + ang:Forward() * 10, Color(255, 0, 0))
					render.DrawLine(rotcenter, rotcenter + ang:Right() * 10, Color(0, 255, 0))
					render.DrawLine(rotcenter, rotcenter + ang:Up() * 10, Color(0, 0, 255))
				cam.End3D()
			end
		end
	mdlpnlcont.PerformLayout = function(_, w, h)
		mdlpnl:SetSize(w, w)
		mdlpnl:SetPos(0, h / 2 - w / 2)
	end

	descpnl.PerformLayout = function(_, w, h)
		local calctall = description:GetTall() + 10
		if h != calctall then
			descpnl:SetTall(calctall)
		end
	end

	self.mdlpnl = mdlpnl
	self.mdlpnlcont = mdlpnlcont
	self.title = title
	self.desc = description
	self.actionbuttons = {}
	self.statcols = {statcol1, statcol2}
end

function PANEL:ClearActionButtons()
	for _, btn in pairs(self.actionbuttons) do
		if IsValid(btn) then
			btn:Remove()
		end
	end
end

function PANEL:AddActionButton(text, icon, enabled, func)
	local btn = vgui.Create("FMWeaponsItemButton", self)
		btn:Dock(BOTTOM)
		btn:DockMargin(0, 5, 0, 0)
		btn:SetTall(35)
		btn:SetIcon(icon)
		btn:SetLabel(text)
		btn:SetEnabled(enabled)
		if enabled then
			btn.DoClick = func
		end

	table.insert(self.actionbuttons, btn)
end

function PANEL:ClearStats()
	for _, col in pairs(self.statcols) do
		for _, stat in pairs(col:GetChildren()) do
			if IsValid(stat) then
				stat:Remove()
			end
		end

		col.numChildren = 0
		col:SetTall(0)
	end
end

function PANEL:AddStat(column, stat, value)
	local colpnl = self.statcols[column]

	local txt
	if value != nil then
		txt = string.format("• %s: %s", stat, value)
	else
		txt = string.format("• %s", stat)
	end

	local lbl = vgui.Create("DLabel", colpnl)
		lbl:SetFont("FMRegular20")
		lbl:SetText(txt)
		lbl:SetDark(true)
		lbl:SetTextInset(10, 0)
		lbl:SetContentAlignment(4)
		lbl:SizeToContentsY(4)
		lbl:Dock(TOP)

	colpnl.numChildren = colpnl.numChildren + 1 -- GetChildren doesn't update immediately when removing so we have to count manually
	colpnl:SetTall(colpnl.numChildren * lbl:GetTall()) -- SizeToChildren is such a fucking mess
	colpnl:GetParent():SizeToChildren(false, true)
	colpnl:GetParent():SetVisible(true)

	return lbl
end

local function getRecoilRating(kickup)
	if kickup <= 0.2 then
		return "Good"
	elseif kickup <= 0.6 then
		return "Mediocre"
	else
		return "Bad"
	end
end

local function getAccuracyRating(spread)
	if spread <= 0.004 then
		return "Good"
	elseif spread <= 0.02 then
		return "Mediocre"
	else
		return "Bad"
	end
end

function PANEL:DisplayWeapon(class)
	local wepdata = GetWeaponData(class)
	local classdata = weapons.Get(class)

	local ownsIt = LocalPlayer():GotWeapon(class)
	local holstered = LocalPlayer():WeaponHolstered(class)
	local canbuy = wepdata.price >= 0 and LocalPlayer():CanAfford(wepdata.price) and LocalPlayer():GetVIPTier() >= wepdata.tier
	local isDefault = IsDefaultWeapon(class)

	local isMelee = wepdata.tags.melee
	local isThrowable = wepdata.tags.throwable

	local automatic = false
	if classdata and classdata.Primary and classdata.Primary.Automatic then
		automatic = true
	end

	self.title:SetText(wepdata.name)

	self.desc:SetText(wepdata.tip:Trim())

	if modelReplacements[wepdata.model] then
		self.mdlpnl:SetModel(modelReplacements[wepdata.model])
	else
		self.mdlpnl:SetModel(wepdata.model)
	end

	self:ClearStats()

	local dmg = wepdata.damage
	local dps = math.Round(wepdata.damage * wepdata.wepdata.rpm / 60, 1)

	-- Column 1

	if dmg > 0 then
		self:AddStat(1, "Damage", dmg)
	elseif dmg < 0 then
		self:AddStat(1, "Healing power", -dmg .. " HP")
	end

	if isMelee then
		if wepdata.ammo > -1 then
			self:AddStat(1, "Charge", tostring(wepdata.ammo))
		end
	else
		self:AddStat(1, isThrowable and "Count" or "Ammo", ((wepdata.ammo == -1) and "Infinite" or tostring(wepdata.ammo)))
	end

	if wepdata.secammotype then
		self:AddStat(1, "Secondary ammo", ((wepdata.secammo == -1) and "Infinite" or tostring(wepdata.secammo)))
	end

	if wepdata.price >= 0 then
		self:AddStat(1, "Price", wepdata.price == 0 and "Free" or wepdata.price > 0 and FormatMoney(wepdata.price))
	end

	if wepdata.tier > 0 then
		self:AddStat(1, "Rank", GetTierName(wepdata.tier, true)):SetTextColor(GetTierColor(wepdata.tier))
	end

	if isDefault then
		self:AddStat(1, "Default")
	end

	-- Column 2

	if isThrowable then
		self:AddStat(2, "Throwable")
	end

	if isMelee then
		self:AddStat(2, "Melee weapon")
	end

	if wepdata.wepdata.rpm > 0 and (automatic or isMelee) then
		if dmg > 0 then
			self:AddStat(2, "DPS", dps)
		elseif dmg < 0 then
			self:AddStat(2, "HPS", -dps)
		end

		if isMelee then
			self:AddStat(2, "Speed", wepdata.wepdata.rpm .. " HPM")
		else
			self:AddStat(2, "Rate", wepdata.wepdata.rpm .. " RPM")
		end
	end

	if not isThrowable and wepdata.wepdata.clipsize > 1 then
		self:AddStat(2, "Clip size", wepdata.wepdata.clipsize)
	end

	if not isMelee and wepdata.wepdata.rpm > 0 then
		self:AddStat(2, "Accuracy", getAccuracyRating(math.min(wepdata.wepdata.spread, wepdata.wepdata.ironspread)))
		self:AddStat(2, "Recoil", getRecoilRating(wepdata.wepdata.kickup))
	end

	self:ClearActionButtons()

	if ownsIt then
		if wepdata.price >= 0 then
			local sellprice = math.floor(wepdata.price * 0.5)
			local selltext = sellprice > 0 and string.format("Sell for %s (50%% return)", FormatMoney(sellprice)) or "Remove"
			self:AddActionButton(selltext, 0xf0a3, true, function()
				net.Start("FMSellGun")
					net.WriteString(class)
				net.SendToServer()
			end)
		end

		self:AddActionButton("Set as default", 0xf005, not isDefault, function()
			SetDefaultWeapon(class)

			if holstered then
				net.Start("FMHolsterGun")
					net.WriteString(class)
					net.WriteBool(false)
				net.SendToServer()
			else
				UpdateWeapons()
			end
		end)

		self:AddActionButton(string.format("%sHolster", holstered and "Un-" or ""), 0xf056, not isDefault, function()
			net.Start("FMHolsterGun")
				net.WriteString(class)
				net.WriteBool(not holstered)
			net.SendToServer()
		end)
	elseif wepdata.price >= 0 then
		local text
		if wepdata.price > 0 then
			text = string.format("Purchase for %s", FormatMoney(wepdata.price))
		else
			text = "Claim"
		end

		self:AddActionButton(text, 0xf07a, canbuy, function()
			net.Start("FMPurchaseGun")
				net.WriteString(class)
			net.SendToServer()
		end)
	end
end

function PANEL:PerformLayout(w, h)
	self.mdlpnlcont:SetTall(w * 0.7)

	for k, pnl in pairs(self.statcols) do
		pnl:SetWide(w / #self.statcols)
	end
end
vgui.Register("FMWeaponsDisplay", PANEL, "Panel")

local function DrawPanel(x, y, w, h, col)
	derma.GetDefaultSkin().tex.Panels.Bright(x, y, w, h, col)
end

local function openRightClickWeaponMenu(class)
	local ownsIt = LocalPlayer():GotWeapon(class)
	local holstered = LocalPlayer():WeaponHolstered(class)
	local isDefault = IsDefaultWeapon(class)

	if not ownsIt then return end
	if isDefault then return end

	local men = DermaMenu()
	local opt

	opt = men:AddOption("Set as default", function()
		SetDefaultWeapon(class)

		if holstered then
			net.Start("FMHolsterGun")
				net.WriteString(class)
				net.WriteBool(false)
			net.SendToServer()
		else
			UpdateWeapons()
		end
	end)
	opt:SetImage(0xf005)
	opt:SetImageColor(FMCOLORS.txt)

	opt = men:AddOption(string.format("%sHolster", holstered and "Un-" or ""), function()
		net.Start("FMHolsterGun")
			net.WriteString(class)
			net.WriteBool(not holstered)
		net.SendToServer()
	end)
	opt:SetImage(0xf056)
	opt:SetImageColor(FMCOLORS.txt)

	men:Open()
end

local function getOrderedWeapons()
	-- Sort weapons into their categories
	local cats = {}
	for k, v in pairs(GetWeaponTable()) do
		local t = {
			class = k,
			data = v,
			cat = v.cat,
			sortindex = v.sortindex,
		}

		if not cats[v.cat] then
			cats[v.cat] = {}
		end

		local cat = cats[v.cat]
		cat[#cat + 1] = t
	end

	-- Sort the weapons
	for cat, tbls in pairs(cats) do
		table.sort(tbls, function(a, b)
			return a.sortindex < b.sortindex
		end)
	end

	-- Make it sequential so we can sort it by category as well
	local newCats = {}
	for cat, tbls in pairs(cats) do
		table.insert(newCats, {
			weps = tbls,
			name = string.gsub(cat, "(%d+% %-% )", ""),
			sortName = cat,
		})
	end

	table.sort(newCats, function(a, b)
		return a.sortName < b.sortName
	end)

	return newCats
end

local wepList
function UpdateWeapons()
	if not IsValid(wepList) then return end
	if not IsValid(LocalPlayer()) then return end

	local oldClass = IsValid(wepList.selectedButton) and wepList.selectedButton.wepClass

	wepList:Clear()
	wepList.buttons = {}

	for _, cattbl in pairs(getOrderedWeapons()) do
		local collapse = vgui.Create("DCollapsibleCategory")
			collapse:SetLabel(cattbl.name)
			collapse.Paint = function(self, pw, ph)
				draw.RoundedBoxEx(4, 0, 0, pw, 21, Color(100, 100, 100), true, true, false, false)
			end

		local cont = vgui.Create("DListLayout")
		cont:DockPadding(3, 5, 3, 2)

		for k, weaponTable in pairs(cattbl.weps) do
			local btn = vgui.Create("DButton")
				btn:DockMargin(0, 0, 0, k > 0 and 2 or 0)
				btn:SetText(weaponTable.data.name)
				btn:SetFont("FMRegular18")
				btn:SetContentAlignment(4)
				btn:SetTextInset(5, 0)
				btn:SetTextColor(FMCOLORS.bg)
				btn:SetTall(22)
				btn:SetZPos(k * 5) -- Sort it
				btn.wepClass = weaponTable.class
				btn.OnCursorEntered = function(self)
					wepList:Select(self)
				end
				btn.Paint = function(self, pw, ph)
					local col
					if self.isSelected or self:IsDown() then
						col = self.cols.selected
					elseif self.Hovered then
						col = self.cols.hover
					else
						col = self.cols.normal
					end

					local x, y, w, h
					if self:IsDown() then
						x = 2; y = 2; w = pw - 4; h = ph - 4
					else
						x = 0; y = 0; w = pw; h = ph
					end

					draw.RoundedBox(4, x, y, w, h, col)

					if self.btncol then
						local badgew = h
						draw.RoundedBoxEx(4, x + w - badgew - 1, y, badgew + 2, h, FMCOLORS.bg, false, true, false, true)

						local font = self:IsDown() and "FMFontAwesomeWepBadgeClick" or "FMFontAwesomeWepBadge"
						draw.SimpleText(utf8.char(self.iconhex), font, x + w - badgew / 2, y + badgew / 2, self.btncol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				end
				btn.DoClick = function(self)
					wepList:Select(self)
				end
				btn.DoRightClick = function(self)
					openRightClickWeaponMenu(self.wepClass)
				end
				btn.UpdateStyle = function(self)
					local weptbl = GetWeaponData(self.wepClass)

					local ownsIt = LocalPlayer():GotWeapon(self.wepClass)
					local holstered = LocalPlayer():WeaponHolstered(self.wepClass)
					local canbuy = weptbl.price >= 0 and LocalPlayer():CanAfford(weptbl.price) and LocalPlayer():GetVIPTier() >= weptbl.tier
					local isDefault = IsDefaultWeapon(self.wepClass)

					local bghue, bgval, tooltip
					if not ownsIt and canbuy then
						-- Player does not own it but can afford it
						bghue = 86
						bgval = 0.8
						self.btncol = HSVToColor(90, 1, 1)
						self.btncol.a = 100
						self.iconhex = 0xf291
						tooltip = " - Purchasable"
					elseif not ownsIt and not canbuy then
						-- Player does not own it and can't afford it
						bghue = 10
						bgval = 0.8
						tooltip = ""
					elseif isDefault then
						-- Player owns it and it's set as the default weapon
						bghue = 86
						bgval = 0.8
						self.btncol = HSVToColor(60, 1, 1)
						self.btncol.a = 100
						self.iconhex = 0xf005
						tooltip = " - Default"
					elseif holstered then
						-- Player owns it and it's holstered
						bghue = 160
						bgval = 0.7
						tooltip = " - Holstered"
					else
						-- Player owns it
						bghue = 86
						bgval = 0.8
						tooltip = ""
					end

					self.cols = {
						normal = HSVToColor(bghue, 0.63, bgval), -- devinity green
						hover = HSVToColor(bghue, 0.63, bgval + 0.05),
						selected = HSVToColor(bghue, 0.63, bgval - 0.1),
					}
					self:SetTooltip(string.format("%s%s", weptbl.name, tooltip))
				end

			btn:UpdateStyle()

			cont:Add(btn)
			table.insert(wepList.buttons, btn)

			if oldClass and weaponTable.class == oldClass then
				wepList:Select(btn)
			end
		end

		collapse:SetContents(cont)

		wepList:Add(collapse)

		collapse:SetCookieName("flood_weapons_" .. cattbl.name)
	end
end

hook.Add("FMCashUpdate", "WeaponsMenu", function(newam)
	if not IsValid(wepList) then return end

	for _, btn in pairs(wepList.buttons or {}) do
		btn:UpdateStyle()
	end
end)

function SetupWeapons(parent, parentw, parenth)
	local wepcont = vgui.Create("Panel", parent)
		wepcont:Dock(FILL)

	local wepDisplayCont = vgui.Create("FMWeaponsDisplay", wepcont)
		wepDisplayCont:Dock(FILL)

	local wepLeftSide = vgui.Create("Panel", wepcont)
		wepLeftSide:Dock(LEFT)
		wepLeftSide:SetWide(200)
		wepLeftSide:DockMargin(0, 0, 5, 0)

	local wepPickerBtn = vgui.Create("DButton", wepLeftSide)
		wepPickerBtn:Dock(BOTTOM)
		wepPickerBtn:DockMargin(0, 5, 0, 0)
		wepPickerBtn:SetText("Rearrange Weapons")
		wepPickerBtn.DoClick = function()
			RunConsoleCommand("fm_weaponslotpicker")
		end

	local wepListScroll = vgui.Create("DScrollPanel", wepLeftSide)
		wepListScroll:Dock(FILL)
		wepListScroll.Paint = function(_, w, h)
			DrawPanel(0, 0, w, h, FMCOLORS.bg)
		end

	wepList = vgui.Create("DListLayout", wepListScroll)
		wepList:Dock(FILL)
		wepList.buttons = {}
		wepList.PerformLayout = function(self, w, h)
			DListLayout.PerformLayout(self, w, h)

			wepList:GetParent():GetParent():InvalidateLayout() -- Rebuild the scrollpanel
		end
		wepList.Select = function(self, btn)
			for _, v in pairs(self.buttons) do v.m_bSelected = false v:ApplySchemeSettings() end
			btn.m_bSelected = true
			btn:ApplySchemeSettings()
			self.selectedButton = btn

			wepDisplayCont:DisplayWeapon(btn.wepClass)
		end

	UpdateWeapons()
end

hook.Add("FMReceivedWeaponDefinitions", "UpdateWeaponsTab", function()
	UpdateWeapons()
end)

hook.Add("FMReceivedWeaponData", "UpdateWeaponsTab", function()
	UpdateWeapons()
end)
