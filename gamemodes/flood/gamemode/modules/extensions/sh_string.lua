
-- Removes # to prevent labels being treated as localized strings
function string.LangSafe(str)
	local pattern = "#" -- regex pattern
	local clean = tostring(str)
	local badchar = string.find(str, pattern)

	if badchar != nil then
		clean = string.gsub(clean, pattern, "") -- remove bad sequences
	end

	return clean
end

function string.FromSeconds(t)
	local hours = math.floor(t / 3600)
	local minutes = math.floor(t / 60) % 60
	local seconds = t % 60

	local hourstxt, minutestxt
	if hours > 0 then
		hourstxt = hours .. ":"
		minutestxt = string.format("%02d", minutes)
	else
		hourstxt = ""
		minutestxt = string.format("%d", minutes)
	end

	return string.format("%s%s:%02d", hourstxt, minutestxt, seconds)
end

function string.EscapeBBCode(str)
	if str then
		str = string.gsub(str, "[%[%]]", "")
	end
	return str
end

function string.URLEncode(str)
	if str then
		str = string.gsub (str, "\n", "\r\n")
		str = string.gsub (str, "([^%w ])",
			function (c) return string.format ("%%%02X", string.byte(c)) end)
		str = string.gsub (str, " ", "+")
	end
	return str
end

function string.ToTable(str)
	local tbl = {}
	for i = 1, utf8.len(str) do
		tbl[i] = utf8.idx(str, i)
	end
	return tbl
end

local vowels = {
	["a"] = true,
	["e"] = true,
	["i"] = true,
	["o"] = true,
	["u"] = true,
}
function string.an(str)
	if #str == 0 then return "a " end

	if vowels[str:lower():sub(1,1)] then
		return "an " .. str
	else
		return "a " .. str
	end
end

function string.ucfirst(str)
	return string.sub(str:upper(),1,1) .. string.sub(str:lower(),2)
end

--[[
Adaption from Garry's string.NiceTime to display full precision instead of just the biggest unit
]]
local function pluralizeString(str, quantity)
	return str .. ((quantity != 1) and "s" or "")
end

function string.NiceTimeFull( seconds )
	if seconds == nil then return "a few seconds" end

	local output = {}

	local yr = 60 * 60 * 24 * 365
	if seconds > yr then
		local t = math.floor( seconds / yr )
		table.insert(output, t .. pluralizeString( " year", t ))
		seconds = seconds - t * yr
	end

	local mo = 60 * 60 * 24 * 30
	if seconds > mo then
		local t = math.floor( seconds / mo )
		table.insert(output, t .. pluralizeString( " month", t ))
		seconds = seconds - t * mo
	end

	local wk = 60 * 60 * 24 * 7
	if seconds > wk then
		local t = math.floor( seconds / wk )
		table.insert(output, t .. pluralizeString( " week", t ))
		seconds = seconds - t * wk
	end

	local day = 60 * 60 * 24
	if seconds > day then
		local t = math.floor( seconds / day )
		table.insert(output, t .. pluralizeString( " day", t ))
		seconds = seconds - t * day
	end

	local hr = 60 * 60
	if seconds > hr then
		local t = math.floor( seconds / hr )
		table.insert(output, t .. pluralizeString( " hour", t ))
		seconds = seconds - t * hr
	end

	local min = 60
	if seconds > min then
		local t = math.floor( seconds / min )
		table.insert(output, t .. pluralizeString( " minute", t ))
		seconds = seconds - t * min
	end

	if seconds > 0 then
		local t = math.floor( seconds )
		table.insert(output, t .. pluralizeString( " second", t ))
	end

	return table.concat(output, ", ")
end
