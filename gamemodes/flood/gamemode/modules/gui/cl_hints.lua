
local PANEL = {}
local QUEUE = {}

local maxHints = 8 -- maximum number of hints on screen

AccessorFunc(PANEL, "m_text", "Text", FORCE_STRING)
AccessorFunc(PANEL, "m_icon", "Icon", FORCE_STRING)
AccessorFunc(PANEL, "m_lifetime", "LifeTime", FORCE_NUMBER)
AccessorFunc(PANEL, "m_font", "Font", FORCE_STRING)
AccessorFunc(PANEL, "m_sound", "Sound", FORCE_STRING)
function PANEL:Init()
end

function PANEL:Setup()
	surface.SetFont(self:GetFont())
	self.txtw, self.txth = surface.GetTextSize(self:GetText())
	self.w = self.txtw + 52 -- width offset
	self.h = self.txth + 8 -- The golden panel height

	self.ID = 1 -- new hints are always first

	for pnl in pairs(QUEUE) do
		pnl.ID = pnl.ID + 1

		if pnl.ID > maxHints then
			pnl.slideout = true
		end
	end

	self.starttime = CurTime()
	self.slideout = false

	self:SetSize(self.w, self.h)
	self:SetPos(ScrW(), (ScrH() / 1.25) - (self.h + 8))

	local icon = vgui.Create("DImage", self)
		icon:SetPos(8, 8)
		icon:SetSize(16, 16)
		icon:SetImage("materials/icon16/" .. self:GetIcon() .. ".png")
	self.icon = icon

	local body = vgui.Create("DLabelCenter", self)
		body:SetFont(self:GetFont())
		body:SetTextColor(FMCOLORS.txt)
		body:SetWide(self.txtw)
		body:SetPos(32, 3) -- the golden label offset
		body:SetText(self:GetText())
	self.body = body

	QUEUE[self] = true

	if isstring(self:GetSound()) and #self:GetSound() > 0 then
		surface.PlaySound(self:GetSound())
	end
end

function PANEL:Paint()
	derma.GetDefaultSkin().tex.Panels.Normal(0, 0, self.w, self.h, FMCOLORS.bg)
end

function PANEL:Think()
	if (self.starttime + self:GetLifeTime()) < CurTime() then
		self.slideout = true
	end

	--Figure out target x pos
	local targx
	if self.slideout then
		targx = ScrW()

		if self.x >= ScrW() then
			self:Dispose()
			return
		end
	else
		targx = ScrW() - self.w
	end

	--Figure out target y pos
	local bottomy = (ScrH() / 1.25) - (self.h + 8)
	local targy = bottomy - (self.ID - 1) * (self.h + 8)

	--Some vector logic
	local diff = Vector(targx, targy, 0) - Vector(self.x, self.y, 0)
	local dist = diff:Length()
	if dist == 0 then return end
	if dist <= 1 then -- Prevents jumping
		self:SetPos(targx, targy)
		return
	end

	local norm = diff:GetNormalized()
	local spd = (dist ^ 1.2 + 5) / 30
	local move = norm * spd * (RealFrameTime() * 150)

	local xsign = (move.x > 0) and 1 or -1 -- math.ceil doesn't work well with negative numbers (always rounds -> positive), so I have to do this method
	local ysign = (move.y > 0) and 1 or -1
	move.x = xsign * math.ceil(math.abs(move.x))
	move.y = ysign * math.ceil(math.abs(move.y))

	local newx = self.x + move.x
	local newy = self.y + move.y
	self:SetPos(newx, newy)
end

function PANEL:Dispose()
	if self.disposed or not IsValid(self) then return end
	self.disposed = true

	for pnl in pairs(QUEUE) do
		if pnl.ID > self.ID then
			pnl.ID = pnl.ID - 1 -- Move the above panels down
		end
	end

	QUEUE[self] = nil
	self:Remove()
end
vgui.Register("FMHint", PANEL, "DPanel")

local hintconvar = CreateClientConVar("fm_shownotifications", 1, true, false)
local hintlenconvar = CreateClientConVar("fm_notificationhangtime", 1, true, false)
AddSettingsItem("flood", "checkbox", "fm_shownotifications", {lbl = "Enable notifications and hints"})
AddSettingsItem("flood", "slider", "fm_notificationhangtime", {lbl = "Hints duration", min = 0, max = 2, decimals = 1})

function Hint(text, icon, snd)
	if not IsValid(LocalPlayer()) then return end
	if hintconvar:GetBool() == false then return end

	local extralife = text:len() * 0.1 -- extend lifetime based on string length
	local lifetime = 5 + extralife
	lifetime = lifetime * hintlenconvar:GetFloat()

	local hint = vgui.Create("FMHint")
		hint:SetText(text)
		hint:SetIcon(icon or "information")
		hint:SetLifeTime(lifetime)
		hint:SetFont("FMRegular24")
		hint:SetSound(snd or "ambient/water/drip" .. math.random(1, 4) .. ".wav")
		hint:Setup()

	LocalPlayer():PrintMessage(HUD_PRINTCONSOLE, text .. "\n") -- Print to console too, incase he missed it
end

function HintError(text)
	Hint(text, "exclamation", "buttons/button10.wav")
end

local plymeta = FindMetaTable("Player")

function plymeta:Hint(...)
	if self != LocalPlayer() then return end
	Hint(...)
end

function plymeta:HintError(...)
	if self != LocalPlayer() then return end
	HintError(...)
end


-- Override the default GMod hints
local typeToIcon = {
	[1] = "exclamation", -- error type
	[2] = "arrow_undo", -- undo type
	[4] = "cut" -- cleanup type
}

function notification.AddLegacy(text, type)
	local icon = typeToIcon[type] or "lightbulb" -- generic hints default to lightbulb icon
	local snd = nil
	if type == 2 then
		snd = "" -- disable sound for undo hints, they got their own blub
	end

	Hint(text, icon, snd)
end

-- Receive hints from the server
net.Receive("FMHint", function()
	local text = net.ReadString()
	local icon = net.ReadString()
	local snd = net.ReadString()

	Hint(text, icon, snd)
end)
