
function os.UnixTimestamp(str)
	local p = "(%d+)-(0?%d+)-(%d+) (%d+):(%d+):(%d+)"
	local year,month,day,hour,min,sec = str:match(p)
	local offset = os.time() - os.time(os.date("!*t"))
	return os.time({day = day,month = month,year = year,hour = hour,min = min,sec = sec}) + offset
end
