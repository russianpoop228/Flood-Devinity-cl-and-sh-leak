
function Vector2D(x, y)
	if isvector(x) then
		return Vector(x.x, x.y, 0)
	end

	return Vector(x, y, 0)
end
