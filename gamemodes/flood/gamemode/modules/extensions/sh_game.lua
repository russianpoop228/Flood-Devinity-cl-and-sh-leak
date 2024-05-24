
function game.GetIPPort()
	local ipport = game.GetIPAddress()
	local div = string.find(ipport, ":")

	return ipport:sub(1, div - 1), ipport:sub(div + 1, -1)
end
