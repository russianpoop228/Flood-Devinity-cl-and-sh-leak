
local phasetostr
function PhaseToString(p)
	if not phasetostr then
		phasetostr = {
			[TIME_BUILD] = "build",
			[TIME_PREPARE] = "prepare",
			[TIME_FLOOD] = "flood",
			[TIME_FIGHT] = "fight",
			[TIME_REFLECT] = "reflect"
		}
	end

	return phasetostr[p]
end

function FormatMoney(am, round)
	assert(isnumber(am), "FormatMoney accepts only a number argument")

	local decimals = round and 0 or 2

	am = math.Round(am, decimals)
	local sign = (am >= 0) and "" or "-"
	am = math.abs(am)

	return string.format("%s$%s", sign, string.Comma(am))
end
