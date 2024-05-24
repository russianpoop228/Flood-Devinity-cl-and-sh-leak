
local PANEL = {}

local numcol = 6
local colspacing = 5

DEFINE_BASECLASS("DFrame")

local function DrawPanel(x, y, w, h, col)
	derma.GetDefaultSkin().tex.Panels.Bright(x, y, w, h, col)
end

function PANEL:Init()

	local cols = {}
	for i = 1, numcol do
		local colparent = vgui.Create("Panel", self)
			colparent:Dock(LEFT)
			colparent:DockMargin(i > 1 and colspacing or 0, 0, 0, 0)
			colparent:SetZPos(i)

		local collbl = vgui.Create("DLabel", colparent)
			collbl:Dock(TOP)
			collbl:SetText("Key " .. i)
			collbl:SetFont("FMRegular24")
			collbl:SizeToContentsY(10)
			collbl:SetContentAlignment(5)

		local colscroll = vgui.Create("DScrollPanel", colparent)
			colscroll:Dock(FILL)

		local col = vgui.Create("DListLayout", colscroll)
			col:MakeDroppable("fmslotpicker")
			col:SetUseLiveDrag(true)
			col.PerformLayout = function()
				col:SizeToChildren(false, true)
				if col:GetTall() < 20 then
					col:SetTall(20)
				end

				colscroll:InvalidateLayout(true)
				colscroll:GetCanvas():InvalidateLayout(true)
			end
			col.OnModified = function()
				col:InvalidateLayout(true)

				self.SaveAt = SysTime() + 0.1 -- This needs to be deferred because OnModified is spammed like hell sometimes
			end

		cols[i] = {
			parent = colparent,
			scroll = colscroll,
			col = col
		}
	end
	self.cols = cols

	local resetbtn = vgui.Create("DImageButton", self)
		resetbtn:SetImage("icon16/arrow_undo.png")
		resetbtn:SetSize(16, 16)
		resetbtn:SetTooltip("Reset to default")
		resetbtn:SetZPos(100)
		resetbtn.DoClick = function()
			GAMEMODE:SetWeaponSlots({})
			GAMEMODE:SaveWeaponSlots({})
			self:PopulateWeapons()
			self.LastSave = RealTime()
		end
	self.resetbtn = resetbtn

	local colwidth = math.Clamp(math.Round(ScrW() * 0.7 / numcol), 100, 300)
	self:SetSize(colwidth * numcol + colspacing * (numcol - 1) + colspacing * 2, colwidth * 2)
	self:Center()
	self:SetDraggable(true)
	self:SetSizable(true)
	self:SetTitle("Weapon slot rearranging")

	self:PopulateWeapons()
end

function PANEL:Save()
	self.LastSave = RealTime()

	local tbl = {}
	for i = 1, numcol do
		local children = {}
		for _, child in pairs(self.cols[i].col:GetChildren()) do
			table.insert(children, child.wepid)
		end

		tbl[i] = children
	end

	GAMEMODE:SaveWeaponSlots(tbl)
	GAMEMODE:SetWeaponSlots(tbl)
end

function PANEL:Think()
	BaseClass.Think(self)

	if self.SaveAt and SysTime() >= self.SaveAt then
		self:Save()
		self.SaveAt = nil
	end
end

function PANEL:PopulateWeapons()
	for i = 1, numcol do
		self.cols[i].col:Clear()
	end

	for class, weptbl in pairs(GetWeaponTable()) do
		local slotx, sloty
		local customSlots = GAMEMODE:GetWeaponSlots(weptbl.id)
		if customSlots then
			slotx = customSlots.slotx
			sloty = customSlots.sloty
		else
			slotx = weptbl.wepdata.slotx or 0
			sloty = weptbl.wepdata.sloty or 0
		end

		if not LocalPlayer():GotWeapon(class) then continue end

		local holstered = LocalPlayer():WeaponHolstered(class)
		local isDefault = IsDefaultWeapon(class)

		local bghue, bgval, tooltip
		if isDefault then
			bghue = 40
			bgval = 0.8
			tooltip = " - Default"
		elseif holstered then
			bghue = 160
			bgval = 0.7
			tooltip = " - Holstered"
		else
			bghue = 86
			bgval = 0.8
			tooltip = ""
		end

		local pnl = vgui.Create("DPanel")
			pnl:SetTall(28)
			pnl:SetBackgroundColor()
			pnl:Droppable("fmslotpicker")
			pnl:DockMargin(2, 2, 2, 2)
			pnl:DockPadding(5, 2, 2, 2)
			pnl:SetZPos(sloty)
			pnl:SetCursor("sizeall")
			pnl:SetTooltip(string.format("%s%s", weptbl.name, tooltip))
			pnl.Paint = function(_, w, h)
				DrawPanel(0, 0, w, h, HSVToColor(bghue, 0.63, bgval))
			end
			pnl.wepid = weptbl.id

		local lbl = vgui.Create("DLabel", pnl)
			lbl:Dock(FILL)
			lbl:SetContentAlignment(4)
			lbl:SetText(weptbl.name)
			lbl:SetFont("FMRegular22")
			lbl:SetTextColor(Color(80, 80, 80))

		self.cols[slotx + 1].col:Add(pnl)
	end
end

function PANEL:PerformLayout(w, h)
	BaseClass.PerformLayout(self, w, h)

	local colwidth = math.Round((w - colspacing * (numcol - 1) - colspacing * 2) / numcol)

	for i = 1, numcol do
		local colt = self.cols[i]
		colt.parent:SetWide(colwidth)
		colt.col:SetWide(colwidth)
	end

	self.resetbtn:SetPos(5, h - self.resetbtn:GetTall() - 5)
end

function PANEL:Paint(w, h)
	BaseClass.Paint(self, w, h)

	local timeSinceSave = (RealTime() - (self.LastSave or 0))
	if timeSinceSave <= 4 then
		local fade = 1 - timeSinceSave / 4
		draw.SimpleText("Saved!", "FMRegular20", w - 5, h - 5, Color(220, 220, 220, fade * 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
	end
end

vgui.Register("FMWeaponSlotPicker", PANEL, "DFrame")

local frame
concommand.Add("fm_weaponslotpicker", function()
	if IsValid(frame) then frame:Remove() end

	frame = vgui.Create("FMWeaponSlotPicker")
		frame:MakePopup()
end)
