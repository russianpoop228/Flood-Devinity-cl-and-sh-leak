
function math.RandomizeSeed()
	math.randomseed((os.time() / CurTime()) + SysTime())
end

local cachedgoldenratio
function math.GoldenRatio()
	if not cachedgoldenratio then
		cachedgoldenratio = (1 + math.sqrt(5)) / 2
	end
	return cachedgoldenratio
end

function math.GetBitPosition(b)
	return math.log(b, 2)
end
