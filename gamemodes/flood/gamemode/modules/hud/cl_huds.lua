
AddSettingsItem("hud", "checkbox", "fm_showhud", {lbl = "Show HUD"})
local showhudconv = CreateClientConVar("fm_showhud", 1, true, false)

--[[
Disabling HUD elements
]]
local hudelements = {}
hudelements["CHudHealth"] = true
hudelements["CHudBattery"] = true
hudelements["CHudAmmo"] = true
hudelements["CHudSecondaryAmmo"] = true
hudelements["CHudDamageIndicator"] = true
hudelements["CHUDQuickInfo"] = true

hook.Add("HUDShouldDraw", "hidehud", function(name)
	if showhudconv:GetBool() == false then return false end
	if hudelements[name] then return false end
end)

local w,h = ScrW(), ScrH()

FMCOLORS = {}
FMCOLORS.bg = Color(40,40,40,255)
FMCOLORS.txt = Color(148,204,75,255)
--FMCOLORS.txt = Color(94,223,255,255)

--[[
Timer
]]
local modes = {}
table.insert(modes, "Build a boat.")
table.insert(modes, "Get on your boat!")
table.insert(modes, "Prepare for fight!")
table.insert(modes, "Destroy enemy boats!")
table.insert(modes, "Restarting the round.")

surface.SetFont("FMRegular20")
local timertxtw,timertxth = surface.GetTextSize(modes[5])
timertxtw = timertxtw + surface.GetTextSize("88:88") + 18
local function DrawTimer()
	local curphase = math.GetBitPosition(GAMEMODE:GetPhase()) + 1

	local x = w/5 + 20
	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(x, h - ((6 - curphase) * (timertxth + 4) + 8) - 2, timertxtw, (timertxth + 2 + 4))
	draw.SimpleText(string.FromSeconds(GAMEMODE:GetTime()), "FMRegular20", x + 3 - 4 + timertxtw - 5, h - ((6 - curphase) * (timertxth + 4) + 8) + 1, FMCOLORS.txt,TEXT_ALIGN_RIGHT,0)

	for k,v in pairs(modes) do
		draw.SimpleText(v, "FMRegular20", x + 3 + 4, h - ((6-k) * (timertxth + 4) + 8) + 1, ((curphase == k) and FMCOLORS.txt or Color(100,100,100,100)),0,0)
	end
end

--[[
Voice mode icon
]]
local voiceicon = Material("icon32/soundicon.png")
surface.SetFont("FMRegular24")
local voicetxtw = surface.GetTextSize("Global")
local function DrawVoice(y)
	local teamvoice = LocalPlayer():GetNWBool("teamchat",false)
	local txt = teamvoice and "Team" or "Global"
	local boxw = 3 + 32 + 3 + voicetxtw + 3
	local offset = y

	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(10, offset, boxw, 32)

	surface.SetMaterial(voiceicon)
	surface.SetDrawColor(FMCOLORS.txt)
	surface.DrawTexturedRect( 10 + 3, offset, 32, 32 )

	draw.SimpleText(txt, "FMRegular24", 10 + 3 + 32 + voicetxtw/2 + 3, offset + 4, FMCOLORS.txt, TEXT_ALIGN_CENTER, 0)
end

local bar_fill = HSVToColor(0,0.63,0.9)
local bar_txt = HSVToColor(0,0.63,0.5)
local function DrawBar(x,y,bar_w,frac,alpha)
	local locx = x - bar_w / 2
	local bar_h = 14

	local col = table.Copy(FMCOLORS.bg)
	col.a = alpha
	surface.SetDrawColor(col)
	surface.DrawRect(locx,y,bar_w,bar_h)

	bar_fill.a = alpha
	surface.SetDrawColor(bar_fill)
	surface.DrawRect(locx + 2,y + 2,(bar_w - 4) * math.Clamp(frac,0,1),bar_h - 4)

	bar_txt.a = alpha
	draw.SimpleText(string.format("%i%%", frac * 100), "FMRegular16", x, y-2, bar_txt, 1)
end

--[[
Propinfo
]]

function GM:FMShouldDrawEntityInfo(ent)
	if ent:GetClass():sub(1,5) == "func_" then
		return false
	end

	return true
end

function GM:DrawEntityInfo(localply, ent, drawpos)
	local ownerply = ent:PPGetOwner()

	local overrideCol
	if not ent:FMRewardsCash() then
		overrideCol = HSVToColor(0, 0.63, 0.6)
	end

	-- Health
	if ent:IsDestroyable() then
		local healthstr = string.format("%.2f", ent:GetFMHealth())
		healthstr = healthstr:TrimRight("0"):TrimRight(".") -- Trims trailing "0"s and "."s

		draw.SimpleTextOutlined("Health: " .. healthstr, "FMRegular22", drawpos.x-1, drawpos.y - 1, overrideCol or FMCOLORS.txt, 1, 1, 2, FMCOLORS.bg)
	end

	-- Owner
	local Text = "Owner: " .. ent:PPGetOwnerName()
	local Text2 = ""
	local Text2Col
	if IsValid(ownerply) and ownerply:CTeam() then
		Text2 = string.format(" (%s)", ownerply:CTeam():GetName())
		Text2Col = ownerply:CTeam():GetColor()
	end

	surface.SetFont("FMRegular22")
	local tw1, _ = surface.GetTextSize(Text)
	local twtotal, _ = surface.GetTextSize(Text .. Text2)

	draw.SimpleTextOutlined(Text, "FMRegular22", drawpos.x - twtotal / 2, drawpos.y + 26, overrideCol or FMCOLORS.txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, FMCOLORS.bg)
	if Text2Col then
		draw.SimpleTextOutlined(Text2, "FMRegular22", drawpos.x - twtotal / 2 + tw1, drawpos.y + 26, overrideCol or Text2Col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, FMCOLORS.bg)
	end

	-- Jump-up
	if localply == LocalPlayer() then
		local _, max = ent:WorldSpaceAABB()
		local diffz = max.z - localply:GetPos().z

		if not(diffz < 20 or diffz > 140) and ent:IsProp() and (GAMEMODE:GetPhase() <= TIME_FIGHT and GAMEMODE:GetPhase() >= TIME_PREPARE) and IsValid(ent:FMOwner()) and localply:SameTeam(ent:FMOwner()) then
			if not localply.lastjump or localply.lastjump < CurTime() - JumpUpCooldown  then
				draw.SimpleTextOutlined("Press E to jump up!", "FMRegular22", drawpos.x-1, drawpos.y + 50, overrideCol or FMCOLORS.txt, 1, 1, 2, FMCOLORS.bg)
			else
				local perc = (CurTime() - localply.lastjump) / JumpUpCooldown
				DrawBar(drawpos.x, drawpos.y + 50-7, 100, perc, 255)
			end
		end
	end
end

local function DrawEntityInfo(localply, ent)
	local shoulddraw = hook.Run("FMShouldDrawEntityInfo", ent) -- delegate the decision to a hook
	if not shoulddraw then return end

	if ent:GetClass():sub(1,5) == "func_" then return end

	local drawpos = (ent:LocalToWorld(ent:OBBCenter()) + Vector(0,0,30)):ToScreen()
	if not drawpos.visible then return end

	hook.Run("DrawEntityInfo", localply, ent, drawpos)
end

local starmat = Material("icon32/star.png")
local plyinfotxtcol = table.Copy(FMCOLORS.txt)
local plyinfobgcol = table.Copy(FMCOLORS.bg)
local function DrawPlayerInfo(localply, ply, x, y, alpha)
	local yoffset = -30

	plyinfotxtcol.a = alpha
	plyinfobgcol.a = alpha

	--Name
	draw.SimpleTextOutlined(ply:FilteredNick(), "FMRegular22", x, y + yoffset, plyinfotxtcol, 1, 0, 2, plyinfobgcol)

	yoffset = yoffset + 26

	--Team
	local tm = ply:CTeam()
	if tm then
		local teamc = table.Copy(tm:GetColor())
		teamc.a = alpha
		draw.SimpleTextOutlined(tm:GetName(), "FMRegular22", x, y + yoffset, teamc, 1, 0, 2, plyinfobgcol)

		local isleader = ply:IsLeader()
		if isleader then
			surface.SetFont("FMRegular22")
			local tw = surface.GetTextSize(tm:GetName())

			render.PushFilterMin(TEXFILTER.ANISOTROPIC)
			render.PushFilterMag(TEXFILTER.ANISOTROPIC)
				surface.SetMaterial(starmat)
				surface.SetDrawColor(Color(255,255,255,alpha))
				surface.DrawTexturedRect(x - tw / 2 - 24, y-4, 20, 20)
			render.PopFilterMag()
			render.PopFilterMin()
		end

		yoffset = yoffset + 26
	end

	--Health
	if ply:Alive() and
		(GAMEMODE:IsPhase(TIME_FIGHT) or GAMEMODE:IsPhase(TIME_REFLECT)) and
		(CUREVENT != "juggernaut" or (ply:CTeam() and ply:CTeam():GetName() != "Juggernauts")) then

		DrawBar(x, y + yoffset, 160, ply:Health() / ply:GetMaxHealth(), alpha)
	end
end

local drawdiststart = 250 ^ 2
local drawdistend = 400 ^ 2
local drawdistdiff = drawdistend-drawdiststart
local function DrawPropInfo(localply)
	for _,v in pairs(player.GetAll()) do v._hasdrawn = false end

	local tr = localply:GetEyeTrace()
	if IsValid(tr.Entity) then
		if tr.Entity:IsPlayer() or (IsValid(tr.Entity:GetRagdollOwner()) and tr.Entity:GetRagdollOwner():IsPlayer()) then
			local ply = tr.Entity
			if not ply:IsPlayer() then ply = tr.Entity:GetRagdollOwner() end

			local drawpos = (tr.Entity:GetPos() + Vector(0,0,80)):ToScreen()
			if not drawpos.visible then return end

			ply._hasdrawn = true
			DrawPlayerInfo(localply, ply, drawpos.x, drawpos.y, 255)
		else
			DrawEntityInfo(localply, tr.Entity)
		end
	end

	if GAMEMODE:IsPhase(TIME_FIGHT) then
		for _, v in pairs(player.GetAll()) do
			if v != LocalPlayer() and not v._hasdrawn and v:Alive() then
				local drawpos = (v:GetPos() + Vector(0,0,80)):ToScreen()
				if not drawpos.visible then continue end

				local dist = v:EyePos():DistToSqr(localply:EyePos())
				local alpha = math.Clamp(255 - ((dist-drawdiststart) / drawdistdiff * 255), 0, 255)


				DrawPlayerInfo(localply, v, drawpos.x, drawpos.y, alpha)
			end
		end
	end
end

--[[
Reuse message
]]
local reusemsg = {txt = nil, w = 0}
local reusemsgfont = "FMRegular24"
local function DrawReuseMsg()
	if not reusemsg.txt or not GAMEMODE:IsPhase(TIME_REFLECT) then return end

	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(0, 0, reusemsg.w + 10, 28)
	draw.SimpleText(reusemsg.txt, reusemsgfont, 5, 2, FMCOLORS.txt, 0, 0)
end

net.Receive("FMReusePromptClose", function()
	reusemsg.txt = nil
end)

net.Receive("FMReusePrompt", function()
	local cost = net.ReadUInt(32)

	surface.PlaySound("buttons/blip1.wav")

	if cost > 0 then
		reusemsg.txt = "Press F1 to reuse your props next round for " .. FormatMoney(cost) .. "."
	else
		reusemsg.txt = "Press F1 to reuse your props next round."
	end

	surface.SetFont(reusemsgfont)
	local txtw, _ = surface.GetTextSize(reusemsg.txt)
	reusemsg.w = txtw
end)

--[[
Cashflow
]]
surface.CreateFont( "CashflowText",
	{
		font		= "coolvetica",
		size		= 30,
		weight		= 400,
		antialias 	= true,
		italic 		= false,
	}
)

local Elements = {}
local function addCashflowElement(am)
	table.insert(Elements, {am, 255, (am > 0) and Color(0,255,0,255) or Color(255,0,0,255)})
end

hook.Add("FMCashUpdate", "Cashflow", function(newam)
	util.WaitForLocalPlayer(function()
		local diff = newam - LocalPlayer():GetCash(true)
		if diff != 0 then
			addCashflowElement(diff)
		end
	end)
end)

local woffset = w / 5 + 15
local function DrawCashflow()
	local hoffset = h - (6 * 27) + 12
	for id,tbl in pairs(Elements) do
		local amount = tbl[1]
		local alpha = tbl[2]
		local color = tbl[3]

		color.a = alpha

		local icon = ((amount > 0) and "+" or "-")
		local txt = string.format("%s$%s", icon, string.Comma(math.abs(amount)))

		draw.DrawText(txt, "CashflowText", woffset + 1, hoffset-id * 25 + 1, Color(0, 0, 0, alpha), TEXT_ALIGN_LEFT)
		draw.DrawText(txt, "CashflowText", woffset, hoffset-id * 25, color, TEXT_ALIGN_LEFT)
		Elements[id][2] = alpha-0.3

		if alpha <= 0 then
			table.remove(Elements, id)
		end
	end
end

--[[
Songs
]]
local function inQuart(t, b, c, d)
	t = t / d
	return c * math.pow(t, 4) + b
end

local songt = -1
local songcurtitle
local songcurw,songcurh
hook.Add("FMSongPlay", "HudSongPlay", function(song)
	songt = 0
	songcurtitle = song:GetTitle()
	surface.SetFont("hatchatfont")
	songcurw,songcurh = surface.GetTextSize("Now playing " .. songcurtitle)
	songcurw = songcurw + 32 + 20
end)


local spinnermat = Material("icon32/spinner.png", "smooth")
local spin = 0
local function DrawSongNotify()
	if songt == -1 then return end

	songt = songt + FrameTime()

	local curx
	if songt < 1 then
		curx = inQuart(songt, 0, songcurw, 1)
	elseif songt > 10 then
		curx = songcurw - inQuart(songt - 10, 0, songcurw, 1)
	elseif songt > 11 then
		songt = -1
		return
	else
		curx = songcurw
	end

	surface.SetDrawColor(Color(220,220,220))
	surface.DrawRect(w-curx, 100, songcurw, 10 + 32)

	spin = spin - FrameTime() * 200
	surface.SetMaterial(spinnermat)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRectRotated(w-curx + 16 + 5,100 + 16 + 5,32,32,spin)

	surface.SetFont("hatchatfont")
	surface.SetTextPos(w-curx + 32 + 10,5 + 16-(songcurh / 2) + 100)
	surface.SetTextColor(FMCOLORS.bg)
	surface.DrawText("Now playing " .. songcurtitle)
end

--[[
Killfeed
]]
local t = {
	font = "Coolvetica",
	weight = 500,
	size = 50
}
surface.CreateFont("FMCool", t)

local Color_Icon = Color( 0, 0, 0, 220 )
local killfeed = {}
local nextscroll = -1
local matsui = Material("icon32/killicons/death.png")
local matkill = Material("icon32/killicons/cleaver.png")
net.Receive("FMSendPlayerDeath", function()
	local ply = net.ReadEntity()
	local suicide = net.ReadBit() == 1
	local killer = net.ReadEntity()

	if not IsValid(ply) or not IsValid(killer) then return end

	surface.SetFont("ChatFont")
	local plen, txth = surface.GetTextSize(ply:FilteredNick())
	local klen = surface.GetTextSize(killer:FilteredNick())

	local txtoffset = 32 / 2 - txth / 2

	table.insert(killfeed, {suicide, plen, ply:FilteredNick(), suicide and matsui or matkill, txtoffset, klen, killer:FilteredNick()})

	if nextscroll == -1 then
		nextscroll = CurTime() + 5
	end
end)

local function DrawKillfeed()
	if nextscroll == -1 then return end

	local yoffset = 0
	if CurTime() > nextscroll then
		yoffset = inQuart((CurTime() - nextscroll) + 0.2, 0, 37, 0.6)
	end

	if yoffset >= 37 then
		table.remove(killfeed, 1)
		if #killfeed == 0 then
			nextscroll = -1
			return
		else
			nextscroll = CurTime() + 5
			yoffset = 0
		end
	end

	surface.SetFont("ChatFont")
	surface.SetTextColor(FMCOLORS.txt)
	surface.SetDrawColor(Color_Icon)

	local killy = 40
	render.SetScissorRect(0, killy, w, h, true)
	for _, v in ipairs(killfeed) do
		local killx = w * 0.85 + 100

		killx = killx - v[2]
		surface.SetTextPos(killx, killy - yoffset + v[5])
		surface.DrawText(v[3])

		killx = killx - 32 - 16
		surface.SetMaterial(v[4])
		surface.DrawTexturedRect(killx, killy - yoffset, 32, 32)

		if not v[1] then
			killx = killx - v[6] - 16
			surface.SetTextPos(killx, killy - yoffset + v[5])
			surface.DrawText(v[7])
		end

		killy = killy + 37
	end
	render.SetScissorRect(0, 0, 0, 0, false)
end

--[[
Status stuff, health, ammo, cash
]]
local sat = 0.63
local backgrbl = 0.70
local forebl = 0.90
local backbl = 0.40

local computecolors = {health = 0, ammo = 31, cash = 115}
local colors = {}
for k,hue in pairs(computecolors) do
	colors[k] = {
		bg = HSVToColor(hue, sat, backgrbl),
		fore = HSVToColor(hue, sat, forebl),
		back = HSVToColor(hue, sat, backbl)
	}
end

local function GetPrimaryAmmoData(localply)
	local curwep = localply:GetActiveWeapon()
	local allammo = 0 -- Ammo in current clip, and on the player (all useable ammo)
	local curclipmul = 0 -- Multiplier based on ammo in clip and clipsize
	if localply == LocalPlayer() and IsValid(curwep) then
		local clipsize = curwep:GetMaxClip1()

		if clipsize > 0 then
			local ammo = curwep:Clip1()
			curclipmul = ammo / clipsize
			if curwep:GetPrimaryAmmoType() then
				allammo = ammo + (localply:GetAmmoCount(curwep:GetPrimaryAmmoType()) or 0)
			end
		else
			allammo = -1
		end
	end

	return allammo, curclipmul
end

local wepammosec = {
	["weapon_smg1"] = 1,
	["tfa_bms_mp5"] = 1
}
local function GetSecondaryAmmoData(localply)
	local curwep = localply:GetActiveWeapon()
	local allammo = 0 -- Ammo in current clip, and on the player (all useable ammo)
	local curclipmul = 0 -- Multiplier based on ammo in clip and clipsize
	if localply == LocalPlayer() and IsValid(curwep) then
		local clipsize = curwep:GetMaxClip2()

		if wepammosec[curwep:GetClass()] then
			clipsize = wepammosec[curwep:GetClass()]
		end

		if clipsize > 0 then
			local ammo = curwep:Clip2()
			curclipmul = ammo / clipsize
			if curwep:GetSecondaryAmmoType() then
				allammo = ammo + (localply:GetAmmoCount(curwep:GetSecondaryAmmoType()) or 0)
			end
		else
			allammo = -1
		end
	end

	return allammo, curclipmul
end

local healthwide
local function DrawStatus(localply)
	--Ammo data gathering
	local hasammowep = true

	local pri_ammo, pri_clipmul = GetPrimaryAmmoData(localply)
	local sec_ammo, sec_clipmul = GetSecondaryAmmoData(localply)
	if pri_ammo < 1 then hasammowep = false end -- If the weapon doesn't have ammo (physgun, toolgun)

	local showammo = (hasammowep and localply == LocalPlayer()) --We disable ammo for other players because it's not networked.
	local showsecammo = showammo and sec_ammo != -1
	local showhealth = ((GAMEMODE:IsPhase(TIME_FIGHT) or GAMEMODE:IsPhase(TIME_FLOOD)) and localply:Alive())

	local bgh = 38
	if showhealth then
		bgh = bgh + 4 + 30
	end
	if showammo then
		bgh = bgh + 4 + 30
	end

	DrawVoice(h - 56 - bgh)

	local y = h-10
	--Background
	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(10, y - bgh, w / 5, bgh)

	--Cash
	y = y - 4 - 30
	local cash = LocalPlayer().GetCash and LocalPlayer():GetCash() or 0
	surface.SetDrawColor(colors.cash.bg)
	surface.DrawRect(14, y, w / 5 - 8, 30)

	draw.SimpleText(FormatMoney(cash), "FMRegular24", w / 10 + 10, y + 3, colors.cash.fore,TEXT_ALIGN_CENTER,0)

	--Ammo
	if showammo then
		y = y - 4 - 30

		local ammowide = math.max((w / 5 - 8) * math.Clamp(pri_clipmul,0,1), 2)
		surface.SetDrawColor(colors.ammo.bg)
		surface.DrawRect(14, y, ammowide, 30)

		local secaddition = ""
		if showsecammo then
			secaddition = string.format(" (%i)", sec_ammo)
		end

		render.SetScissorRect(14, y, 14 + ammowide, y + 30, true)
		draw.SimpleText(string.format("Ammo: %i%s", pri_ammo, secaddition), "FMRegular24", w / 10 + 10, y + 3, colors.ammo.fore,TEXT_ALIGN_CENTER,0)
		render.SetScissorRect(14 + ammowide, y, w / 5 + 14, y + 30, true)
		draw.SimpleText(string.format("Ammo: %i%s", pri_ammo, secaddition), "FMRegular24", w / 10 + 10, y + 3, colors.ammo.back,TEXT_ALIGN_CENTER,0)
		render.SetScissorRect(0,0,0,0,false)
	end

	--Health
	if showhealth then
		y = y - 4 - 30

		local health = math.max(localply:Health(), 0)
		local targhealthwide = math.max((w / 5 - 8) * math.Clamp(health / localply:GetMaxHealth(), 0, 1), 2)

		if not healthwide then healthwide = targhealthwide end
		healthwide = math.Approach(healthwide, targhealthwide, FrameTime() * 6 * (1 + math.abs(targhealthwide - healthwide)))

		surface.SetDrawColor(colors.health.bg)
		surface.DrawRect(14, y, healthwide, 30)

		render.SetScissorRect(14, y, 14 + healthwide, y + 30, true)
		draw.SimpleText(string.format("%i%%", health), "FMRegular24", w / 10 + 10, y + 3, colors.health.fore,TEXT_ALIGN_CENTER,0)
		render.SetScissorRect(14 + healthwide, y, w / 5 + 14, y + 30, true)
		draw.SimpleText(string.format("%i%%", health), "FMRegular24", w / 10 + 10, y + 3, colors.health.back,TEXT_ALIGN_CENTER,0)
		render.SetScissorRect(0,0,0,0,false)
	end
end

--[[
Team info
]]
local function EllipsifyText(txt, maxw)
	local txtw = surface.GetTextSize(txt)
	if txtw <= maxw then return txt end

	while true do
		txt = txt:sub(1,-2)

		if #txt == 0 then
			return "..."
		end

		txtw = surface.GetTextSize(txt .. "...")
		if txtw <= maxw then
			return txt .. "..."
		end
	end
end

local hudw = ScrW() / 8
local function DrawCTeamPlayer(ply, id)
	local y = 20 + 24 + id * 30

	local health = math.max(ply:Health(), 0)
	local plyhealthwide = math.max((hudw - 2) * math.Clamp(health / ply:GetMaxHealth(), 0, 1), 0)
	local disttxt = ""
	if ply != LocalPlayer() and ply:Alive() and LocalPlayer():Alive() then
		disttxt = math.Round(LocalPlayer():GetPos():Distance(ply:GetPos()) * 0.0208333333)
	end


	--0.0208333333 <-> 1 unit in yards
	surface.SetFont("FMRegular20")
	local disttxtw = surface.GetTextSize(disttxt)
	local nick = EllipsifyText(ply:FilteredNick(), hudw-disttxtw-4)

	draw.SimpleTextOutlined(nick, "FMRegular20", 5, y, health > 0 and Color(200,200,200) or colors.health.back, 0, 0, 2, FMCOLORS.bg)
	draw.SimpleTextOutlined(disttxt, "FMRegular20", hudw, y, Color(200,200,200), TEXT_ALIGN_RIGHT, 0, 2, FMCOLORS.bg)

	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(5, y + 20, hudw, 6)
	surface.SetDrawColor(colors.health.fore)
	surface.DrawRect(5 + 1, y + 20 + 1, plyhealthwide, 4)
end

local houseicon = Material("icon16/house.png", "noclamp unlitgeneric smooth")
local brickicon = Material("icon16/brick.png", "noclamp unlitgeneric smooth")
local function DrawCTeamInfo()
	local tm = LocalPlayer():CTeam()
	if not tm then return end

	local plys = {}
	for _, v in pairs(tm:GetMembers()) do
		if IsValid(v) then
			table.insert(plys, v)
		end
	end

	if #plys > 5 then -- Don't show any HUD for big teams
		return
	end

	local room = GetRoomForTeam(tm)

	surface.SetFont("FMRegular20")
	local tmname = EllipsifyText(tm:GetName(), hudw - (room and 100 or 64))

	draw.SimpleTextOutlined(tmname, "FMRegular20", 5, 14, tm:GetColor(), 0, 0, 2, FMCOLORS.bg)

	if room then
		surface.SetDrawColor(color_white)
		surface.SetMaterial(houseicon)
		surface.DrawTexturedRect(hudw - 32, 15, 16, 16)

		draw.SimpleTextOutlined(room, "FMRegular20", hudw, 14, tm:GetColor(), TEXT_ALIGN_RIGHT, 0, 2, FMCOLORS.bg)
	end

	surface.SetDrawColor(color_white)
	surface.SetMaterial(brickicon)
	surface.DrawTexturedRect(hudw - (room and 100 or 64), 15, 16, 16)

	draw.SimpleTextOutlined(("%i/%i"):format(GetPropCount(), GetMaxProps()), "FMRegular20", hudw - (room and 80 or 44), 14, tm:GetColor(), TEXT_ALIGN_LEFT, 0, 2, FMCOLORS.bg)


	local id = 0
	if IsValid(tm:GetLeader()) then
		DrawCTeamPlayer(tm:GetLeader(), id)
		id = id + 1
	end

	table.sort(plys, function(a,b)
		if a:Health() != b:Health() then
			return a:Health() < b:Health()
		end

		return a:Nick() < b:Nick()
	end)

	for _, v in pairs(plys) do
		DrawCTeamPlayer(v, id)
		id = id + 1
	end
end

--[[
Actual drawing code
]]

function DrawBlinkingText(txt, x, y)
	local a = ((math.sin(math.rad((CurTime() * 100) % 360)) + 1) / 2) * 90
	draw.SimpleTextOutlined(txt, "FMRegular28", x, y, HSVToColor(a, 0.63, 0.8), TEXT_ALIGN_CENTER, 0, 2, FMCOLORS.bg)
end

hook.Add("HUDPaint","FMDrawHud", function()
	if showhudconv:GetBool() == false then return end

	local localply = IsValid(LocalPlayer():GetSpectatingPlayer()) and LocalPlayer():GetSpectatingPlayer() or LocalPlayer()
	DrawPropInfo(localply)
	DrawCashflow()
	DrawCTeamInfo()
	DrawReuseMsg()
	DrawTimer()
	DrawStatus(localply)
	DrawKillfeed()
	DrawSongNotify()

	hook.Run( "DrawDeathNotice", 0.85, 0.04 )
end)
