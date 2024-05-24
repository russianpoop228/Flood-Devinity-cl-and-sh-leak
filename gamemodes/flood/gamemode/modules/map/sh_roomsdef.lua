
-- TODO: Make this into a module system like BR does

-- Default
GM.Map.Boundaries = {
	min = Vector(-1000, -1000, -1000),
	max = Vector(1000, 1000, 1000),
}

if FMIsMapCanals() then
	GM.Map.Boundaries = {
		min = Vector(-1427, -1866, -280),
		max = Vector(1344, 1256, 1550),
	}

	function GM:FMRoofRefundLevel()
		return 230
	end

	local function SwitchFunc(on, spritename, modelname)
		for _, v in pairs(ents.FindByName(spritename)) do
			v:Fire(on and "ShowSprite" or "HideSprite", "", 0)
		end

		for _, v in pairs(ents.FindByName(modelname)) do
			v:SetSkin(on and 0 or 1)
		end
	end

	GM:AddRoom({
		id = "1",
		door = {min = Vector(-572,-160,0), max = Vector(-566,-104,109), normal = Vector(1,0,0)},
		onchange = function(on) SwitchFunc(on, "Sprite_1", "lighta1") end,
		region = {
			boundary = {
				Vector2D(-1420, -538),
				Vector2D(-1420, 107),
				Vector2D(-574, 107),
				Vector2D(-574, -538),
			},
			zmin = -278, zmax = 220,
		},
	})
	GM:AddRoom({
		id = "3",
		door = {min = Vector(-572,-812,0), max = Vector(-566,-756,109), normal = Vector(1,0,0)},
		onchange = function(on) SwitchFunc(on, "Sprite_3", "lighta3") end,
		region = {
			boundary = {
				Vector2D(-1420, -1191),
				Vector2D(-1420, -548),
				Vector2D(-574, -548),
				Vector2D(-574, -1191),
			},
			zmin = -278, zmax = 220,
		},
	})
	GM:AddRoom({
		id = "5",
		door = {min = Vector(-572,-1464,0), max = Vector(-566,-1408,109), normal = Vector(1,0,0)},
		onchange = function(on) SwitchFunc(on, "Sprite_5", "lighta5") end,
		region = {
			boundary = {
				Vector2D(-1420, -1875),
				Vector2D(-1420, -1200),
				Vector2D(-574, -1200),
				Vector2D(-574, -1875),
			},
			zmin = -278, zmax = 220,
		},
	})
	GM:AddRoom({
		id = "0",
		door = {min = Vector(-195,-1042,0), max = Vector(-139,-1036,109), normal = Vector(0,1,0)},
		onchange = function(on) SwitchFunc(on, "Sprite_7", "lighta0") end,
		region = {
			boundary = {
				Vector2D(-354, -1875),
				Vector2D(-354, -1044),
				Vector2D(302, -1044),
				Vector2D(302, -1875),
			},
			zmin = -278, zmax = 220,
		},
	})
	GM:AddRoom({
		id = "6",
		door = {min = Vector(514,-1464,0), max = Vector(520,-1408,109), normal = Vector(-1,0,0)},
		onchange = function(on) SwitchFunc(on, "Sprite_6", "lighta6") end,
		region = {
			boundary = {
				Vector2D(522, -1875),
				Vector2D(522, -1200),
				Vector2D(1352, -1200),
				Vector2D(1352, -1875),
			},
			zmin = -278, zmax = 220,
		},
	})
	GM:AddRoom({
		id = "4",
		door = {min = Vector(514,-812,0), max = Vector(520,-756,109), normal = Vector(-1,0,0)},
		onchange = function(on) SwitchFunc(on, "Sprite_4", "lighta4") end,
		region = {
			boundary = {
				Vector2D(522, -1191),
				Vector2D(522, -548),
				Vector2D(1352, -548),
				Vector2D(1352, -1191),
			},
			zmin = -278, zmax = 220,
		},
	})
	GM:AddRoom({
		id = "2",
		door = {min = Vector(514,-160,0), max = Vector(520,-104,109), normal = Vector(-1,0,0)},
		onchange = function(on) SwitchFunc(on, "Sprite_2", "lighta2") end,
		region = {
			boundary = {
				Vector2D(522, -538),
				Vector2D(522, 107),
				Vector2D(1352, 107),
				Vector2D(1352, -538),
			},
			zmin = -278, zmax = 220,
		},
	})
elseif game.GetMap():lower() == "fm_sewers_dev" then
	GM.Map.Boundaries = {
		min = Vector(-1702, -1664, -260),
		max = Vector(1062, 1856, 832),
	}

	function GM:FMRoofRefundLevel()
		return 234
	end

	GM:AddRoom({
		id = "1",
		door = {
			center = Vector(-984.00,792.00,60.00),
			min = Vector(-8.03,-45.97,-59.97),
			max = Vector(8.03,45.97,59.97),
			angle = Angle(-0.000,0.000,0.000),
		},
		onchange = function(on) end,
		region = {
			boundary = {
				Vector2D(-992.00,544.00),
				Vector2D(-1536.00,544.00),
				Vector2D(-1536.00,1040.00),
				Vector2D(-992.00,1040.00),
			},
			zmin = -256, zmax = 224,
		},
	})
	GM:AddRoom({
		id = "2",
		door = {
			center = Vector(-863.99,1168.01,60.00),
			min = Vector(-8.04,-45.97,-59.97),
			max = Vector(8.04,45.97,59.97),
			angle = Angle(-0.000,315.000,0.000),
		},
		onchange = function(on) end,
		region = {
			boundary = {
				Vector2D(-752.03,1791.97),
				Vector2D(-752.03,1291.76),
				Vector2D(-987.76,1056.03),
				Vector2D(-1535.97,1056.03),
				Vector2D(-1535.97,1791.97),
			},
			zmin = -256, zmax = 224,
		},
	})
	GM:AddRoom({
		id = "3",
		door = {
			center = Vector(-320.00,1288.00,60.00),
			min = Vector(-8.03,-45.97,-59.97),
			max = Vector(8.03,45.97,59.97),
			angle = Angle(-0.000,270.000,0.000),
		},
		onchange = function(on) end,
		region = {
			boundary = {
				Vector2D(96.00,1296.00),
				Vector2D(-736.00,1296.00),
				Vector2D(-736.00,1792.00),
				Vector2D(96.00,1792.00),
			},
			zmin = -256, zmax = 224,
		},
	})
	GM:AddRoom({
		id = "4",
		door = {
			center = Vector(224.01,1168.03,60.00),
			min = Vector(-8.00,-45.97,-59.97),
			max = Vector(8.00,45.97,59.97),
			angle = Angle(-0.000,225.000,0.000),
		},
		onchange = function(on) end,
		region = {
			boundary = {
				Vector2D(347.76,1056.03),
				Vector2D(112.03,1291.76),
				Vector2D(112.03,1791.97),
				Vector2D(895.97,1791.97),
				Vector2D(895.97,1056.03),
			},
			zmin = -256, zmax = 224,
		},
	})
	GM:AddRoom({
		id = "5",
		door = {
			center = Vector(344.00,792.00,60.00),
			min = Vector(-8.03,-45.97,-59.97),
			max = Vector(8.03,45.97,59.97),
			angle = Angle(-0.000,180.000,0.000),
		},
		onchange = function(on) end,
		region = {
			boundary = {
				Vector2D(352.00,544.00),
				Vector2D(352.00,1040.00),
				Vector2D(896.00,1040.00),
				Vector2D(896.00,544.00),
			},
			zmin = -256, zmax = 224,
		},
	})
	GM:AddRoom({
		id = "6",
		door = {
			center = Vector(82.00,-936.00,60.00),
			min = Vector(-8.03,-45.97,-59.97),
			max = Vector(8.03,45.97,59.97),
			angle = Angle(-0.000,90.000,0.000),
		},
		onchange = function(on) end,
		region = {
			boundary = {
				Vector2D(-255.97,-1617.94),
				Vector2D(-287.96,-1280.00),
				Vector2D(-7.99,-944.03),
				Vector2D(895.97,-944.03),
				Vector2D(895.97,-1343.97),
				Vector2D(639.97,-1617.94),
			},
			zmin = -256, zmax = 224,
		},
	})
	GM:AddRoom({
		id = "7",
		door = {
			center = Vector(-722.00,-936.00,60.00),
			min = Vector(-8.03,-45.97,-59.97),
			max = Vector(8.03,45.97,59.97),
			angle = Angle(-0.000,90.000,0.000),
		},
		onchange = function(on) end,
		region = {
			boundary = {
				Vector2D(-384.03,-1617.94),
				Vector2D(-1279.97,-1617.94),
				Vector2D(-1535.97,-1311.97),
				Vector2D(-1535.97,-944.03),
				Vector2D(-632.01,-944.03),
				Vector2D(-352.04,-1280.00),
			},
			zmin = -256, zmax = 224,
		},
	})
end
