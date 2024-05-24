
local pow = math.pow
local function inOutQuart(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 4) + b
	else
		t = t - 2
		return -c / 2 * (pow(t, 4) - 2) + b
	end
end

local anims = {}
function StartAnim(st, en, dur, func, endfunc)
	return table.insert(anims, {st = st, change = (en - st), dur = dur, t = 0, func = (func or function() end), endfunc = (endfunc or function() end)})
end
function RemoveAnim(id)
	if not anims[id] then return end
	table.remove(anims, id)
end
hook.Add("Think","RunAnims",function()
	for k,v in pairs(anims) do
		local val = inOutQuart(v.t, v.st, v.change, v.dur)

		v.func(val)
		if v.t > v.dur then
			v.endfunc(val)
			table.remove(anims, k)
		end
		v.t = v.t + FrameTime()
	end
end)
