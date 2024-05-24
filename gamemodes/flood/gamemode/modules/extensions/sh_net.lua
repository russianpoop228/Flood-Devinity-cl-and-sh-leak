
function net.WriteCompressedString(str)
	local compressed = util.Compress(str)
	net.WriteUInt(#compressed, 16)
	net.WriteData(compressed, #compressed)
end

function net.ReadCompressedString()
	local len = net.ReadUInt(16)
	local compressed = net.ReadData(len)
	return util.Decompress(compressed)
end
