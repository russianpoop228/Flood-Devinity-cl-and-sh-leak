
--[[
DColorMixerFM
A color mixer with support for Set/GetDisabled
]]

local greyoverlay = function(self,w,h)
	surface.SetDrawColor(Color(255,255,255,50))
	surface.DrawRect(0,0,w,h)
end

derma.DefineControl("DColorMixerFM", "", {
	Init = function(self)
	end,
	SetDisabled = function(self, bool)
		for _, v in pairs(self.Palette:GetChildren()) do
			v:SetDisabled(bool)
			v:SetMouseInputEnabled(not bool)
		end
		self.RGB:SetMouseInputEnabled(not bool)
		self.HSV:SetMouseInputEnabled(not bool)

		if bool then
			self.RGB.PaintOver = greyoverlay
			self.Palette.PaintOver = greyoverlay
			self.HSV.PaintOver = greyoverlay
		else
			self.RGB.PaintOver = function() end
			self.Palette.PaintOver = function() end
			self.HSV.PaintOver = function() end
		end
	end
}, "DColorMixer")
