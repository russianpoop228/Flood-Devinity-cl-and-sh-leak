include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

hook.Add("HUDPaint", "DrawPirateChestHUD", function()
	for _,ent in pairs(ents.FindByClass("fm_piratechest")) do
        local tr = LocalPlayer():GetEyeTrace()
        local traceent = tr.Entity
        if not (traceent == ent) then continue end
        if LocalPlayer():EyePos():Distance(tr.HitPos) > 100 then return end
        local drawpos = (ent:LocalToWorld(ent:OBBCenter()) + Vector(0,0,30)):ToScreen()
        draw.SimpleTextOutlined("Press E to Open!", "FMRegular22", drawpos.x-1, drawpos.y + 50, FMCOLORS.txt, 1, 1, 2, FMCOLORS.bg)
	end
end)

hook.Add("FMShouldDrawEntityInfo", "ShouldDrawChestInfo", function(ent)
    if ent:GetClass() == "fm_piratechest" then
        return false
    end
end)

hook.Add("PreDrawHalos", "PirateChestHalo", function()
	halo.Add(ents.FindByClass("fm_piratechest"), Color(255, 215, 0), 5, 5, 2)
end)
