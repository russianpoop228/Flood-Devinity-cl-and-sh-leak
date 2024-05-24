
local emitpain = CreateClientConVar("fm_emitplayerpain", 1, true, false)
AddSettingsItem("flood", "checkbox", "fm_emitplayerpain", {lbl = "Enable pain SFX"})

local SFX = {
	female = {
		"vo/npc/female01/pain01.wav",
		"vo/npc/female01/pain02.wav",
		"vo/npc/female01/pain03.wav",
		"vo/npc/female01/pain04.wav",
		"vo/npc/female01/pain05.wav",
		"vo/npc/female01/pain06.wav",
		"vo/npc/female01/pain07.wav",
		"vo/npc/female01/pain08.wav",
		"vo/npc/female01/pain09.wav"
	},

	male = {
		"vo/npc/male01/pain01.wav",
		"vo/npc/male01/pain02.wav",
		"vo/npc/male01/pain03.wav",
		"vo/npc/male01/pain04.wav",
		"vo/npc/male01/pain05.wav",
		"vo/npc/male01/pain06.wav",
		"vo/npc/male01/pain07.wav",
		"vo/npc/male01/pain08.wav",
		"vo/npc/male01/pain09.wav"
	},

	combine = {
		"npc/combine_soldier/pain1.wav",
		"npc/combine_soldier/pain2.wav",
		"npc/combine_soldier/pain3.wav"
	}
}

function EmitPainSFX(ply)
	if emitpain:GetBool() == false then return end -- check the setting

	local time = CurTime()
	if ply.lastpaintime and time - ply.lastpaintime < 2 then return end -- limit the sfx


	local pick, sfxtbl
	local gender = ply:GetGender()
	if gender == "female" then
		sfxtbl = SFX.female
	elseif gender == "combine" then
		sfxtbl = SFX.combine
	else
		sfxtbl = SFX.male
	end

	while not pick or ply.lastpainsfx == pick do -- prevent duplicates
		pick = table.Random(sfxtbl)
	end

	ply:EmitSound(pick)
	ply.lastpainsfx = pick
	ply.lastpaintime = time
end

net.Receive("FMEmitPainSFX", function()
	local ply = net.ReadEntity()
	if not IsValid(ply) then return end
	EmitPainSFX(ply)
end)
