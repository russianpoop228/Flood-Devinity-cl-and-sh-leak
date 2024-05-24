
--[[
Special props
]]
function GM:FMCanActivateSpecialProp(prop, ply)
	local curevent = CurrentEvent()
	if not curevent then return end

	if table.HasValue(prop.DisabledEvents, curevent) then
		return false, ("%s is disabled during the %s."):format(prop.PrintName, CurrentEventTable().PrettyName)
	end
end

function GM:FMCanSpawnSpecialProp(ply, class)
	local proptbl = scripted_ents.Get(class)
	if not proptbl then return end

	local curevent = CurrentEvent()
	if not curevent then return end

	if table.HasValue(proptbl.DisabledEvents, curevent) then
		return false, ("%s is disabled during the %s."):format(proptbl.PrintName, CurrentEventTable().PrettyName)
	end
end

function GM:RegisterSpecialProp(class, enttbl)
	list.Set("FMSpecialProps", class, {
		name = enttbl.PrintName,
		class = class,
		cooldown = enttbl.Cooldown,
		cost = enttbl.Cost,
		model = enttbl.Model,
		health = enttbl.Health,
		desc = enttbl.Description
	})

	if enttbl.DisabledEvents and #enttbl.DisabledEvents > 0 then
		hook.Add("FMStartEvent", "SpecialProp" .. class, function(event)
			if table.HasValue(enttbl.DisabledEvents, event.id) then
				for _, ent in pairs(ents.FindByClass(class)) do
					local owner = ent:FMOwner()
					ent:Refund(1)
					if IsValid(owner) then
						owner:Hint(("Your %s was refunded because it's disabled during the %s."):format(enttbl.PrintName, event.PrettyName))
					end
				end
			end
		end)
	end

	AddEntityHealth(class, enttbl.Health)

	if SERVER then
		props.RegisterClassForRefund(class, function(ent)
			local curhealth = ent:GetFMHealth()
			if curhealth < 1 then return 0 end

			local healthfraction = (curhealth / ent:GetFMMaxHealth()) or 0 -- maxhealth is always the actual initial health
			healthfraction = math.Clamp(healthfraction, 0, 1)

			local price = ent.purchaseprice or 0
			local cashback = math.floor(healthfraction * price)
			if cashback < 1 then return 0 end

			return cashback
		end)
	end
end
