
EVENT.Name = "Haste"
EVENT.PrettyName = "Haste Event"
EVENT.Description = {
	"Whoops, look at the time.... Start building!",
	"1-minute Build Phase.",
	"Weapon and water damage is DOUBLED!",
	"Props are cheaper!",
}

if CLIENT then
	EVENT.hooks.HUDPaint = function()
		if not GAMEMODE:IsPhase(TIME_BUILD) then return end

		DrawBlinkingText("Haste round ~ build quickly!", ScrW() / 2, 250)
	end
end
