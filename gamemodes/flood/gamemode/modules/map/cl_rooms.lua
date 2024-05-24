
local function mid(x,y)
	return math.floor((y - x) / 2) + x
end

local hasCalculatedDoorData = false
local function calculateDoorData()
	if hasCalculatedDoorData then return end
	hasCalculatedDoorData = true

	local rooms = GAMEMODE:GetPrivateRooms()
	for _,v in pairs(rooms) do
		local doordata = v.door

		if doordata.center and doordata.angle then
			doordata.normal = doordata.angle:Forward()

			doordata.thickness = doordata.max.x - doordata.min.x
		else
			-- Calculates the centerpoint of min and max
			doordata.center = Vector(
				mid(doordata.max.x,doordata.min.x),
				mid(doordata.max.y,doordata.min.y),
				mid(doordata.max.z,doordata.min.z)
			)

			-- Converts max/min to local coords
			doordata.max = doordata.max - doordata.center
			doordata.min = doordata.min - doordata.center

			doordata.angle = angle_zero

			-- Calculate door thickness
			local thiccvec = doordata.max - doordata.min
			local thicc = math.min(math.abs(thiccvec.x), math.abs(thiccvec.y))
			doordata.thickness = thicc
		end
	end
end

net.Receive("FMMapSpecificsTeamSwitch", function()
	local id = net.ReadString()
	local isteam = net.ReadBit() == 1
	local newteam

	if isteam then
		newteam = GetCTeamByID(net.ReadUInt(32))
	else
		newteam = net.ReadEntity()
	end

	for _, v in pairs(GAMEMODE:GetPrivateRooms()) do
		if v.id == id then
			v.curteam = newteam
			break
		end
	end
end)

local function isteam(c)
	return type(c) == "table" and isnumber(c.id)
end

function GetRoomForTeam(tm)
	for _, v in pairs(GAMEMODE:GetPrivateRooms()) do
		if isteam(v.curteam) and v.curteam == tm then
			return v.id
		end
	end
end

local mat = Material("models/props_c17/frostedglass_01a")
hook.Add("PostDrawTranslucentRenderables", "FMRoomDoors", function()
	calculateDoorData()

	for _, v in pairs(GAMEMODE:GetPrivateRooms()) do
		if isteam(v.curteam) or IsValid(v.curteam) then
			local doordata = v.door

			render.SetMaterial(mat)
			render.DrawBox(doordata.center, doordata.angle, doordata.min, doordata.max, color_white, true)

			local ang = doordata.normal:Angle()
			ang:RotateAroundAxis(ang:Forward(),90)
			ang:RotateAroundAxis(ang:Right(),-90)

			local textpos = doordata.center + doordata.normal * doordata.thickness * 0.55
			textpos.z = doordata.center.z + doordata.min.z + 60
			cam.Start3D2D(textpos, ang, 0.12)
				surface.SetTextColor(FMCOLORS.txt)
				surface.SetFont("FMRegular40")

				local txt1 = "Occupied by"
				local txt2 = isteam(v.curteam) and v.curteam:GetName() or v.curteam:FilteredNick()
				local tw,th = surface.GetTextSize(txt1)
				local tw2,th2 = surface.GetTextSize(txt2)

				surface.SetTextPos(-tw / 2, -th / 2)
				surface.DrawText(txt1)
				surface.SetTextColor(v.curteam:GetColor())
				surface.SetTextPos(-tw2 / 2, -th2 / 2 + th + 3)
				surface.DrawText(txt2)
			cam.End3D2D()
		end
	end
end)
