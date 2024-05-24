local pcf = {
	[1] = "hl2mmod_weapons_grenade_trailandblipglow",
}

function EFFECT:Init(data)
	local ent = data:GetEntity()
	local index = data:GetFlags() or 0

	if not IsValid(ent) then return end

	if pcf[index] then
		local _ = CreateParticleSystem(ent, pcf[index], PATTACH_POINT_FOLLOW, ent:LookupAttachment("fuse"))
	end

end

function EFFECT:Render()
end

function EFFECT:Think()
	return false
end