
-- Converts a relative index to an absolute
local function relToAbs(str, pos)
	if pos < 0 then
		pos = math.max(pos + utf8.len(str) + 1, 0)
	end
	return pos
end

-- Returns the utf-8 found on idx
-- Works exactly like str[idx]
function utf8.idx(str, idx)
	idx = relToAbs( str, idx )

	if idx == 0 then return "" end
	if idx > utf8.len(str) then return "" end

	local offset = utf8.offset(str, idx - 1)
	return utf8.char(utf8.codepoint(str, offset))
end

-- UTF-8 compilant version of string.sub
-- Works exactly the same
function utf8.sub(str, charstart, charend)
	charstart = relToAbs(str, charstart)
	charend = relToAbs(str, charend)

	local buf = {}
	for i = charstart, charend do
		buf[#buf + 1] = utf8.idx(str, i)
	end

	return table.concat(buf)
end
