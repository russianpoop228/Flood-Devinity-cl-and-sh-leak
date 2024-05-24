
EVENT.Name = "Team"
EVENT.PrettyName = "Team Event"
EVENT.Description = {
	"All players are divided between two gigantic teams!",
	"Use cooperation and teamwork to win.",
	"Props are cheaper!",
	"Your teammates can't touch your props, but you can allow this in the Settings tab."
}

if CLIENT then
	CreateClientConVar("fm_team_allowtouch", 0, true, true)
	AddSettingsItem("flood", "checkbox", "fm_team_allowtouch", {lbl = "Team Event: Allow team touch"})
end
