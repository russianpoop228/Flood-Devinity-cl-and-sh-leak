
EVENT.Name = "Pirate"
EVENT.PrettyName = "Pirate Event"
EVENT.Description = {
	"All boats can be boarded.",
	"Collect treasure chests! Some contain goodies while others are rigged to explode!",
	"Attack players and boats with PvP weapons.",
	"Harpoons and extinguishers for everyone!",
	"Cannons are available for deployment. Use them to cripple and tear apart ships.",
	"Boat motors and cannons are free!",
}

EVENT.VortexStart = 20 -- When the vortex should start in fight phase
EVENT.VortexPos = Vector(0, 0, 0)
if FMIsMapCanals() then
	EVENT.VortexPos = Vector((1351 + -1436) / 2, (1264 + -1875) / 2, 0)
end
