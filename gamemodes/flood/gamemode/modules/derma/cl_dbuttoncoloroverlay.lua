
--[[
DButtonColorOverlay
Adds a sexy colorline to a normal DButton
]]
vgui.Register("DButtonColorOverlay",
{
	Init = function()
	end,
	SetColorOverlay = function(self, hue)
		if type(hue) == "table" then
			self.coloroverlay = table.Copy(hue)
		else
			self.coloroverlay = HSVToColor(hue, 0.63, 1)
		end
		self.coloroverlay.a = 150
	end,
	PaintOver = function(self,w,h)
		if self.coloroverlay then
			surface.SetDrawColor(self.coloroverlay)
			surface.DrawRect(1,h-5,w-2,5)
		end
	end
}, "DButton")
