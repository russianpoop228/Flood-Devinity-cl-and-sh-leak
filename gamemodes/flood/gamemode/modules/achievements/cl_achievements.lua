
Achievements = Achievements or {}
AchievementLookup = AchievementLookup or {}

local achievementi = 0
function CreateAchievement(tbl)
	if not tbl.icons or #tbl.icons == 0 then
		tbl.icons = {{"silver"}}
	end

	local ic = {}
	for _, v in ipairs(tbl.icons) do
		table.insert(ic, {
			col = v[4] or color_white,
			mat = Material("icon32/achievements/" .. v[1] .. ".png", "smooth mips"),
			x = v[2] and v[2][1] or 0, y = v[2] and v[2][2] or 0,
			w = v[3] and v[3][1] or 32, h = v[3] and v[3][2] or 32
		})
	end

	Achievements[tbl.id] = {
		i = achievementi,
		icons = (ic or {{"placeholder"}}),
		name = (tbl.name or "PLACEHOLDER"),
		desc = (tbl.desc or "PLACEHOLDER"),
		goal = (tbl.goal or 1),
		req = (tbl.req or {}),
		hidden = (tbl.hidden or false),
	}

	AchievementLookup[achievementi] = tbl.id
	achievementi = achievementi + 1
end

net.Receive("FMSendAchievementData", function()
	local ply = net.ReadEntity()
	if not IsValid(ply) then return end

	ply.achi = {}
	for _ = 1, net.ReadUInt(8) do
		local idx = net.ReadUInt(8)
		if not AchievementLookup[idx] then
			printWarn("Couldn't find achievement for index %q, data %q", idx, net.ReadInt(32))
			continue
		end

		local achid = AchievementLookup[idx]
		ply.achi[achid] = net.ReadInt(32)
	end

	hook.Run("FMReceivedAchievementData", ply)
end)

local progress = Sound("fm/achievement_progress.wav")
local unlocked = Sound("fm/achievement_unlocked.wav")

local curach
local achievementqueue = {}
local function ProcessQueue()
	if #achievementqueue == 0 then return end
	local tbl = table.remove(achievementqueue, 1) -- Pops first line

	local achid = tbl.achid
	local newam = tbl.newam
	local goal = tbl.goal

	curach = {}
	local h = 0
	if newam >= goal then
		surface.PlaySound(unlocked)
		curach.col = FMCOLORS.txt
	else
		surface.PlaySound(progress)
		curach.col = Color(200,200,200,255)

		if goal > 1 then
			h = 6
			curach.progress = newam
			curach.goal = goal
		end
	end
	curach.txt = Achievements[achid].name

	surface.SetFont("FMRegular24")
	local w, txth = surface.GetTextSize(curach.txt)
	curach.txth = txth
	h = h + math.max(36, txth)

	curach.w = w + 36 + 2

	curach.icons = Achievements[achid].icons

	curach.h = h
	curach.y = -h
	StartAnim(-h,0,0.5,function(x)
		curach.y = x
	end,
	function()
		timer.Simple(5, function()
			StartAnim(0,-h,0.5,function(x)
				curach.y = x
			end,
			function()
				curach = nil
				ProcessQueue()
			end)
		end)
	end)
end

net.Receive("FMSendAchievementProgress", function()
	local achid = net.ReadString()
	local newam = net.ReadUInt(32)
	if not Achievements[achid] then return end
	local goal = Achievements[achid].goal

	table.insert(achievementqueue, {achid = achid, newam = newam, goal = goal})
	if not curach then
		ProcessQueue()
	end
end)

local w = ScrW()
hook.Add("HUDPaint", "DrawAchievement", function()
	if not curach then return end

	local x = w-curach.w-50
	local y = curach.y
	surface.SetDrawColor(FMCOLORS.bg)
	surface.DrawRect(x,y,curach.w,curach.h)

	for k,v in pairs(curach.icons) do
		surface.SetMaterial(v.mat)
		surface.SetDrawColor(Color(255,255,255,255))
		surface.DrawTexturedRect(x + v.x + 2,y + v.y + 2,v.w,v.h)
	end

	surface.SetFont("FMRegular24")
	surface.SetTextColor(curach.col)
	surface.SetTextPos(x + 36, y + (curach.txth <= 32 and 18 - curach.txth / 2 or 2))
	surface.DrawText(curach.txt)

	if curach.progress then
		surface.SetDrawColor(Color(10,10,10,255))
		surface.DrawRect(x + 5,y + 36,curach.w-10,4)

		local mul = math.Clamp(curach.progress / curach.goal, 0, 1)
		surface.SetDrawColor(FMCOLORS.txt)
		surface.DrawRect(x + 5,y + 36,(curach.w-10) * mul,4)
	end
end)

net.Receive("FMSendAchievementChatNote", function()
	local ply = net.ReadEntity()
	local achkey = net.ReadString()
	if not IsValid(ply) then return end

	chat.AddText(FMCOLORS.bg, ply:FilteredNick(), " has unlocked: ", FMCOLORS.txt, Achievements[achkey].name)
end)

function AchLocked(ply, achid)
	if not Achievements[achid] then return true end

	local req = Achievements[achid].req
	if not req then return false end -- no requirements

	local plyacht = AchGetData(ply)

	for _, v in pairs(req) do
		if not plyacht[v] then return true end -- It's not even in the table!
		if plyacht[v] >= 0 then return true end -- Goal not reached!
	end
	return false
end

--A list of theoretical achievement unlocking order
local fakeachilist = {
	"cash0","winner","damage0","time0",
	"teamcreator","teamkicker","destroy0","burn0",
	"cash1","damage1","destroy1","destroywood",
	"destroyplastic","destroymetal","destroymisc","burn1",
	"extinguish0","pirate0","lonewolf0","rounddamage0",
	"cash4tokens","killzombie0","frankensteincreation","yeoldpirateship", "wardinghy",
}
local fakeachipointlist = {
	{"burn0", 50},{"pirate0", 5},{"destroywood", 500},
	{"destroyplastic", 500},{"destroymetal", 500},{"destroymisc", 500},{"destroypallets", 200},
	{"unweldprops", 50},{"destroyplastbarrels", 300},{"destroysnowmen", 20},
	{"destroythin", 300},{"destroyhousehold", 300},{"protectbeer", 15},{"destroybeer", 50},
	{"protectpaper", 40},{"destroypaper", 150},{"frankensteincreation", 10},{"yeoldpirateship", 10},
	{"wardinghy", 15},{"floatingfortress", 5},{"halfwayraft", 10},{"deathinsurance", 5},
}
function AchGetData(ply)
	if ply.fakeskill then
		local shouldhaveachis = math.Round((ply.fakeskill * 1.5 + 4) ^ 0.7)

		local achitbl = {}
		for i = 1, shouldhaveachis do
			achitbl[fakeachilist[i]] = -1
		end

		for _ = 1, math.Round(shouldhaveachis / 2) do
			local randt = table.Random(fakeachipointlist)
			if achitbl[randt[1]] then continue end

			achitbl[randt[1]] = math.random(0, randt[2]-2)
		end

		return achitbl
	end

	return ply.achi or {}
end
