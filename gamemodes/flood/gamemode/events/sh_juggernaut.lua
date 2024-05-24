
EVENT.Name    = "Juggernaut"
EVENT.PrettyName = "Juggernaut Event"
EVENT.Description = {
	"A bunch of sailors have been sent to subdue a party of fearsome, brutish Juggernauts.",
	"Damage is scaled to the team ratio.",
	[[Juggernauts:
	- Can only utilize the M249, AWP, Frag Grenade, Bazooka, and Harpoon Gun.
	- Water damage is HALVED.
	- Do your best to get up close and personal.]],
	[[Sailors:
	- All weapons and utilities are available at their disposal.
	- Water damage is DOUBLED.
	- Work together with teammates to defeat the Juggernauts.]],
}

if CLIENT then
	CreateClientConVar("fm_jugg_allowtouch", 0, true, true)
	AddSettingsItem("flood", "checkbox", "fm_jugg_allowtouch", {lbl = "Juggernaut Event: Allow team touch (sailors only)"})
end
