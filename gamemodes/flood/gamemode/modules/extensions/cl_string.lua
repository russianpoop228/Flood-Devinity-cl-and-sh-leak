
--[[
https://github.com/SuperiorServers/dash
]]
local surface_SetFont 		= surface.SetFont
local surface_GetTextSize 	= surface.GetTextSize
local string_Explode 		= string.Explode

function string.Wrap(font, text, width)
	surface_SetFont(font)

	local sw = surface_GetTextSize(' ')
	local ret = {}

	local w = 0
	local s = ''

	local t = string_Explode('\n', text)
	for i = 1, #t do
		local t2 = string_Explode(' ', t[i], false)
		for i2 = 1, #t2 do
			local neww = surface_GetTextSize(t2[i2])

			if (w + neww >= width) then
				ret[#ret + 1] = s
				w = neww + sw
				s = t2[i2] .. ' '
			else
				s = s .. t2[i2] .. ' '
				w = w + neww + sw
			end
		end
		ret[#ret + 1] = s
		w = 0
		s = ''
	end

	if (s ~= '') then
		ret[#ret + 1] = s
	end

	return ret
end

-- TODO: Replace WordWrap with the string.Wrap instead
function string.WordWrap(txt, width)
	local arr = string.Explode(" ", txt)

	--This code will split up \n to their own lines
	for k = 1, #arr do
		local v = arr[k]

		if #v > 1 and string.EndsWith(v, "\n") then
			arr[k] = string.sub(v, 0, -2)
			table.insert(arr, k + 1, "\n")
			k = k + 1
		elseif #v > 1 and string.find(v, "\n") then
			local nls = string.Explode("\n", v)
			arr[k] = nls[1]:Trim()
			k = k + 1
			table.insert(arr, k, "\n")
			k = k + 1
			table.insert(arr, k, nls[2]:Trim())
		end
	end

	local spacew = surface.GetTextSize(" ")

	local maxw = width
	local curw = 0
	for i = 1,#arr do
		if not arr[i] then break end
		local wordw = surface.GetTextSize(arr[i])

		if arr[i] == "\n" then
			curw = 0
		elseif curw == 0 and wordw > maxw then --If this word is wider than maxwidth, just do a softwrap
			arr[i] = arr[i] .. "\n"
		elseif (curw + wordw) > maxw then
			arr[i] = "\n" .. arr[i]
			curw = wordw
		else
			curw = curw + wordw + spacew
		end
	end

	local out = table.concat(arr, " ")
	out = string.gsub(out, "\n ", "\n")
	out = out:Trim()
	return out
end

-- Returns the Levenshtein distance between the two given strings
--https://gist.github.com/Badgerati/3261142
function string.levenshtein(str1, str2)
	local len1 = string.len(str1)
	local len2 = string.len(str2)
	local matrix = {}
	local cost = 0

	-- quick cut-offs to save time
	if (len1 == 0) then
		return len2
	elseif (len2 == 0) then
		return len1
	elseif (str1 == str2) then
		return 0
	end

	-- initialise the base matrix values
	for i = 0, len1, 1 do
		matrix[i] = {}
		matrix[i][0] = i
	end
	for j = 0, len2, 1 do
		matrix[0][j] = j
	end

	-- actual Levenshtein algorithm
	for i = 1, len1, 1 do
		for j = 1, len2, 1 do
			if (str1:byte(i) == str2:byte(j)) then
				cost = 0
			else
				cost = 1
			end

			matrix[i][j] = math.min(matrix[i-1][j] + 1, matrix[i][j-1] + 1, matrix[i-1][j-1] + cost)
		end
	end

	-- return the last value - this is the Levenshtein distance
	return matrix[len1][len2]
end
