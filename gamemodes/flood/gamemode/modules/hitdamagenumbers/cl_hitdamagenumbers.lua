local hit_txts = {}
local hit_lastcurtime = 0

local dmg_cols =
{
	gen = Color(255, 230, 210), -- Generic/Bullet damage
	crit = Color(255, 40, 40), -- Critical hit
	fire = Color(255, 120, 0), -- Fire damage
	expl = Color(240,240,50), -- Explosion damage
	acid = Color(140, 255, 75), -- Toxic damage
	elec = Color(100, 160, 255) -- Electric/Shock damage
}

local on = true
CreateConVar("hitnums_enable", 1)
cvars.AddChangeCallback( "hitnums_enable", function()
	on = (GetConVarNumber("hitnums_enable") ~= 0)

	Msg("Damage indicators ")
	if on then
		MsgN("enabled")
	else
		MsgN("disabled")
		table.Empty(hit_txts)
	end
end)


local use3dtxt = true
CreateConVar("hitnums_3dtext", 1)
cvars.AddChangeCallback( "hitnums_3dtext", function()
	use3dtxt = (GetConVarNumber("hitnums_3dtext") ~= 0)
end )


function createHitNumber()

	if not on then return end
	local lply = LocalPlayer()

	if not lply:IsValid() then return end

	local data = {}

	local dmg = net.ReadFloat()
	local dmgtype = net.ReadUInt(32)

--	print("Damage info type: " .. bit.tohex(dmgtype))

	data.dmg = math.Round(dmg, 2)
	--if dmg < 1 then data.dmg = math.Round(dmg, 3)
	--else data.dmg = math.floor(dmg) end

	data.crit = (net.ReadBit()==1)

	data.pos = net.ReadVector()
	local force = net.ReadVector()

	local d = data.pos:Distance(lply:GetPos())/200
	d = math.Clamp(d, 0, 2)

	data.life = 1.0
	data.g = 0.03 * d
	data.velx = math.Rand(-0.5, 0.5) * d + force.x
	data.vely = math.Rand(-0.5, 0.5) * d + force.y
	data.velz = math.Rand(1, 2) * d + force.z

	data.c = (data.crit and dmg_cols.crit or dmg_cols.gen)

	if not data.crit then
		if bit.band(dmgtype, bit.bor(DMG_BURN, DMG_SLOWBURN, DMG_PLASMA)) > 0 then
			data.c = dmg_cols.fire
		--	print("Fire damage")
		elseif bit.band(dmgtype, bit.bor(DMG_BLAST, DMG_BLAST_SURFACE)) > 0 then
			data.c = dmg_cols.expl
		--	print("Explosion damage")
		elseif bit.band(dmgtype, bit.bor(DMG_ACID, DMG_POISON, DMG_RADIATION, DMG_NERVEGAS)) > 0 then
			data.c = dmg_cols.acid
		--	print("Acid damage")
		elseif bit.band(dmgtype, bit.bor(DMG_DISSOLVE, DMG_ENERGYBEAM, DMG_SHOCK)) > 0 then
			data.c = dmg_cols.elec
		--	print("Electric damage")
		end
	end

	table.insert(hit_txts, data)

end
net.Receive( "imHDN_create", createHitNumber)


-- Update indicators.
function updateIndicators()

	if not on then return end

	local dt = CurTime()-hit_lastcurtime

	-- Update hit texts
	for k,v in pairs(hit_txts) do
		v.life = v.life - dt

		v.velz = math.Min(v.velz - v.g, 1)

		v.pos.x = v.pos.x + v.velx
		v.pos.y = v.pos.y + v.vely
		v.pos.z = v.pos.z + v.velz
	end

	-- Remove expired hit texts
	local i = 1
	while i <= #hit_txts do
		if hit_txts[i].life < 0 then
			table.remove(hit_txts, i)
		else
			i = i + 1
		end
	end

	hit_lastcurtime = CurTime()

end
hook.Add( "Tick", "ihHDN_Tick", updateIndicators )


-- Draw 3D numbers
function drawNumbers3d()

	if not on then return end
	if not use3dtxt then return end

	local ang = LocalPlayer():EyeAngles()

	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local ignorez = GetGlobalBool("HDN_IgnoreZ", false)
	if ignorez then
		cam.IgnoreZ( true )
	end

	local col
	local txt
	for k,v in pairs(hit_txts) do

		col = v.c
		col.a = v.life * 255

		txt = tostring(-v.dmg)

		surface.SetFont("FMRegular50")
		local w,h = surface.GetTextSize(txt)

		local dist = v.pos:Distance(LocalPlayer():GetPos())

		local scale = dist ^ 0.7 / 100
		cam.IgnoreZ(true)
		cam.Start3D2D( v.pos + Vector(0,0,0), Angle( 0, ang.y, ang.r ), scale )
			surface.SetTextPos(-w/2, -h/2)
			surface.SetTextColor(col)
			surface.DrawText(txt)
		cam.End3D2D()
		cam.IgnoreZ(false)
	end

	if ignorez then
		cam.IgnoreZ( false )
	end

end
hook.Add( "PostDrawTranslucentRenderables", "ihHDN_drawNumbers3d", drawNumbers3d );

-- Draw 2D numbers
function drawNumbers2d()

	if not on then return end
	if use3dtxt then return end

	local col
	local txt
	for k,v in pairs(hit_txts) do

		local spos = v.pos:ToScreen()

		col = v.c
		col.a = v.life * 255

		txt = tostring(-v.dmg)

		draw.SimpleTextOutlined(
			txt, "FMRegular20", spos.x, spos.y, col,
			TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, v.life * 255) )

	end

end
hook.Add( "HUDPaint", "ihHDN_drawNumbers2d", drawNumbers2d );
