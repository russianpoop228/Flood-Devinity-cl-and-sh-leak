
function ColorToVector(clr)
	return Vector(clr.r / 255, clr.g / 255, clr.b / 255)
end

function ColorToVectorString(clr)
	return util.TypeToString(ColorToVector(clr))
end
