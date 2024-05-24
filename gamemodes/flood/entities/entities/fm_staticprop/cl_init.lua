include("shared.lua")

local convar = CreateClientConVar("fm_drawscenery", 1, true, false)
AddSettingsItem("quality", "checkbox", "fm_drawscenery", {lbl = "Draw Event Scenery"})

cvars.AddChangeCallback("fm_drawscenery", function(_, _, new)
	local on = tobool(new)
	for _, v in pairs(ents.FindByClass("fm_staticprop")) do
		v:DrawShadow(on)

		if on then
			v:CreateShadow()
			v:MarkShadowAsDirty()
		else
			v:DestroyShadow()
		end
	end
end)

function ENT:Draw()
	if not convar:GetBool() then return end
	self:DrawModel()
end

function ENT:DrawTranslucent()
	if not convar:GetBool() then return end
	self:DrawModel()
end
