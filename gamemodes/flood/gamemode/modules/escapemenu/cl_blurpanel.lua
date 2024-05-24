
--[[
Blur
]]
local blurmat = Material("pp/blurscreen")
local levelstbl = { -- How many blurs needed for each bluram
	[1] = 2,
	[2] = 3,
	[3] = 3,
	[4] = 4,
	[5] = 4,
}
function DrawBlurRect(panel, x, y, w, h, bluram)
	bluram = math.Clamp(math.floor(bluram), 1, 5) -- Blurs > 5 looks weird
	local levels = levelstbl[bluram]

	surface.SetMaterial(blurmat)
	surface.SetDrawColor(Color(255, 255, 255))

	for i = 1, levels do
		blurmat:SetFloat("$blur", (i / levels) * bluram)
		blurmat:Recompute()
		render.UpdateScreenEffectTexture()

		if panel then
			surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
		else
			render.SetScissorRect(x, y, x + w, y + h, true)
				surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
			render.SetScissorRect(0, 0, 0, 0, false)
		end
	end
end
