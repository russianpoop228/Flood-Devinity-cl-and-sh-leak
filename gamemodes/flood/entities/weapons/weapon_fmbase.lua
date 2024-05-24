--[[
Ultimate base for all Devinity Flood weapons
]]

function SWEP:Rand(id, min, max)
	return util.SharedRandom("fmbasewep" .. id, min, max, CurTime() + self:EntIndex())
end

SWEP.BounceWeaponIcon = false

function SWEP:PrintWeaponInfo( x, y, alpha )
	if self.DrawWeaponInfoBox == false then return end

	if self.InfoMarkup == nil then
		local found = false

		local str
		local title_color = "<color=230,230,230,255>"
		local text_color = "<color=150,150,150,255>"

		str = "<font=HudSelectionText>"
		if self.Purpose != "" then found = true str = str .. title_color .. "Description:</color>\n" .. text_color .. self.Purpose .. "</color>\n\n" end
		if self.Instructions != "" then found = true str = str .. title_color .. "Instructions:</color>\n" .. text_color .. self.Instructions .. "</color>\n" end
		str = str .. "</font>"

		if not found then
			self.DrawWeaponInfoBox = false
			return
		end

		self.InfoMarkup = markup.Parse(str, 250)
	end

	surface.SetDrawColor(60, 60, 60, alpha)
	surface.SetTexture(self.SpeechBubbleLid)

	surface.DrawTexturedRect(x, y - 64 - 5, 128, 64)
	draw.RoundedBox(8, x - 5, y - 6, 260, self.InfoMarkup:GetHeight() + 18, Color(60, 60, 60, alpha))

	self.InfoMarkup:Draw(x + 5, y + 5, nil, nil, alpha)
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	if self.IconLetter then
		draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide / 2, y + tall * 0.2, Color( 255, 210, 0, alpha ), TEXT_ALIGN_CENTER )

		self:PrintWeaponInfo(x + wide + 20, y + tall * 0.95, alpha)
		return
	end

	surface.SetDrawColor(255, 255, 255, alpha)
	if isnumber(self.WepSelectIcon) then
		surface.SetTexture(self.WepSelectIcon)
	else
		surface.SetMaterial(self.WepSelectIcon)
	end

	local fsin = 0
	if self.BounceWeaponIcon == true then
		fsin = math.sin(CurTime() * 10) * 5
	end

	y = y + 25
	x = x + 10
	wide = wide - 20

	surface.DrawTexturedRect(x + (fsin), y - (fsin),  wide - fsin * 2 , ( wide / 2 ) + (fsin))

	self:PrintWeaponInfo(x + wide + 20, y + tall * 0.95, alpha)
end
