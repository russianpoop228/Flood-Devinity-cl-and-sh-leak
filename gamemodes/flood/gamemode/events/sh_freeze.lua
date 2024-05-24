
EVENT.Name = "Flash Freeze"
EVENT.PrettyName = "Flash Freeze Event"
EVENT.Description = {
	"Props are instantly frozen once the water has stopped moving",
	"Fire does double damage and unfreezes props",
	"Harpoons are disabled",
}

if CLIENT then
	local snd = Sound("fm/icesound.wav")
	EVENT.hooks.FMOnChangePhase = function(old, new)
		if new == TIME_FIGHT then
			sound.Play(snd, LocalPlayer():GetPos(), 75, 100, 1)
		end
	end
end
