
GM.Map = GM.Map or {}
GM.Map.Rooms = GM.Map.Rooms or {}

function GM:AddRoom(data)
	table.insert(self.Map.Rooms, data)
end

function GM:GetPrivateRooms()
	return self.Map.Rooms
end
