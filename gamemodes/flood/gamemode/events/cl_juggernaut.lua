
local circle = Material("icon32/circle.png")
local bar_fill = HSVToColor(0,0.63,0.9)
local bar_txt = HSVToColor(0,0.63,0.5)
EVENT.hooks.HUDPaint = function()
	if GAMEMODE:IsPhase(TIME_BUILD) and LocalPlayer():CTeam() and LocalPlayer():CTeam():GetName() != "Juggernauts" then return end
	if not GetCTeam("Juggernauts") then return end

	for _, v in pairs(GetCTeam("Juggernauts"):GetMembers()) do
		if not IsValid(v) or not v:Alive() then continue end

		local barpos = v:GetPos()
		local max = v:OBBMaxs()
		barpos.z = barpos.z + max.z + 20

		local screenpos = barpos:ToScreen()

		local w = 200
		local h = 18

		local m = Matrix()
		m:SetScale(Vector(1,1,1) * math.Clamp(((4000 - v:GetPos():Distance(LocalPlayer():GetPos())) / 4000), 0.1, 1))
		m:SetTranslation(Vector(screenpos.x,screenpos.y,0))
		cam.PushModelMatrix(m)
			DisableClipping(true)
			if GAMEMODE:IsPhase(TIME_BUILD) then
				surface.SetMaterial(circle)
				surface.SetDrawColor(Color(0,255,255))
				surface.DrawTexturedRect(-32,-32,64,64)
			else
				local x,y = -w / 2,0
				local frac = v:Health() / v:GetMaxHealth()

				local col = table.Copy(FMCOLORS.bg)
				col.a = alpha
				surface.SetDrawColor(col)
				surface.DrawRect(x,y,w,h)

				bar_fill.a = alpha
				surface.SetDrawColor(bar_fill)
				surface.DrawRect(x + 2,y + 2,(w-4) * math.Clamp(frac,0,1),h-4)

				bar_txt.a = alpha
				draw.SimpleText(string.format("%i%%", frac * 100), "FMRegular16", x + w / 2, y + h / 2, bar_txt, 1, 1)
			end
			DisableClipping(false)
		cam.PopModelMatrix()
	end
end