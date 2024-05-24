if SERVER then
	hook.Add("EntityTakeDamage" , "CrossbowBolt - damage override" , function( ent , info )
		local inflictor = info:GetInflictor()
		
		if IsValid( inflictor ) && inflictor:GetClass() == "crossbow_bolt" && info:GetDamage() == 0 then
			info:SetDamageType(DMG_NEVERGIB)
			info:SetDamage( 100 ) -- your custom damage value
			local own = inflictor:GetOwner()
			if (own && IsValid(own)) then
				info:SetAttacker(own)
			end
		end
	end)
end


-- local ents = {
	-- "crossbow_bolt" --No need for others here
-- }

-- local function EntityTakeWeaponDamage( ent, dmginfo )
	-- local infl = dmginfo:GetInflictor()
	-- local att = dmginfo:GetAttacker()
	-- local amount	= dmginfo:GetDamage()

	-- local pClass 	= infl:GetClass()
	-- local pOwner 	= infl:GetOwner()

	-- if (infl:IsValid()) then
		-- if (table.HasValue( ents, pClass )) then
			-- if (infl.m_iDamage) then
				-- dmginfo:SetDamage( infl.m_iDamage )
			-- end
			
			-- if (pOwner && pOwner:IsValid()) then
				-- dmginfo:SetAttacker( pOwner )
			-- end
		-- end	
	-- end
-- end
-- hook.Add( "EntityTakeDamage", "EntityTakeWeaponDamage", EntityTakeWeaponDamage )

