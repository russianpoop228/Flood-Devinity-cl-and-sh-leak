if SERVER then
	AddCSLuaFile()
end

sound.Add(
	{
		name = "DamageAnime",
		sound = {"damage/1.ogg", "damage/2.ogg", "damage/3.ogg", "damage/4.ogg"},
		channel = CHAN_VOICE,
		level = 100,
		volume = 1
	}
)

sound.Add(
	{
		name = "DeathAnime",
		sound = {"death/1.ogg", "death/2.ogg", "death/3.ogg"},
		channel = CHAN_VOICE,
		level = 100,
		volume = 1
	}
)