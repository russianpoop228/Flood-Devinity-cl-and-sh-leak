
-- Override DButton to allow font awesome icons

surface.CreateFont("FMFontAwesome16",
{
	font     = "FontAwesome",
	size     = 16,
	extended = true
})

OLDDBUTTONSETIMAGE = OLDDBUTTONSETIMAGE or DButton.SetImage
DButton.SetImage = function(self, img)
	if not isnumber(img) then
		return OLDDBUTTONSETIMAGE(self, img)
	end

	if not IsValid(self.m_Image) then
		self.m_Image = vgui.Create("DLabel", self)
		self.m_Image:SetFont("FMFontAwesome16")
		self.m_Image:SetSize(16, 16)
		self.m_Image:SetContentAlignment(5)
	end

	self.m_Image:SetText(utf8.char(img))
	self.m_Image:SizeToContents()
	self:InvalidateLayout()
end
DButton.SetImageColor = function(self, col)
	if IsValid(self.m_Image) then
		self.m_Image:SetTextColor(col)
	end
end

--[[
Gets a nice key name for a specific binding
]]
function GetKeyName(inp)
	local name = input.LookupBinding(inp)
	if name then
		return name:upper()
	end

	return "???"
end
