
-- Non-sequential shallow equal comparison
function table.Equals(t1, t2)
	for k1, v1 in pairs(t1) do
		if not t2[k1] then return false end
		if t2[k1] != v1 then return false end
	end

	for k2, v2 in pairs(t2) do
		if not t1[k2] then return false end
		if t1[k2] != v2 then return false end
	end

	return true
end

--table.Diff
local function TableDiffInternal(update, original, tname, out)
	for k, updtv in pairs(update) do
		local origv = original[k]
		if updtv != origv then
			if type(updtv) == "table" and type(origv) == "table" then
				TableDiffInternal(updtv, origv, tname .. k .. ".", out)
			else
				if type(origv) == "string" then origv = string.format("%q", origv) else origv = tostring(origv) end
				if type(updtv) == "string" then updtv = string.format("%q", updtv) else updtv = tostring(updtv) end

				local diffstr = string.format("%s%s:\t[%s => %s]", tname,  k, origv, updtv)
				table.insert(out, diffstr)
			end
		end
	end
end

function table.Diff(update, original, prefix)
	local out = {}
	TableDiffInternal(update, original, prefix or "", out)
	return out
end

function table.Shuffle( t )
	local rand = math.random
	local iterations = #t
	local j

	for i = iterations, 2, -1 do
		j = rand(i)
		t[i], t[j] = t[j], t[i]
	end
end
