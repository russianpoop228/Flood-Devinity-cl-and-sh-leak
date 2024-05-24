
chat.Close()
surface.CreateFont ( "small", {
        size = 10,
        weight = 390,
        antialias = true,
        shadow = false,
        font = "coolvetica"})
surface.CreateFont ( "hatchatfont", {
        size = 20,
        weight = 900,
        font = "Arimo Bold"})


local maxhist = 3000
local maxshow = 15
local time = 15
surface.SetFont("hatchatfont")
local _,__h = surface.GetTextSize("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrdtuvwxyz")
local tHeight = math.max(15, __h)
local showing = 1
local history = {}
local Default = ""
local barscroll = 225
local barsize = 220
local maxlen = math.floor( ScrW()/3 )

local sel = {Select = false, Start = 1, End = 1, Chosen = false,
	Char = {Start = 1, B = 1, End = 1} }
local HStart = 0
local cur = {At = 0, Show = true, Time = CurTime(), Pos = 0}
local InputSel = {Select = false, Start = nil}
local InputLen = 0
local TeamChat = false

local PasteFrame
local PasteBox
--[[
local ShowLineIcons, ShowLineGlow
timer.Simple(2, function()

ShowLineIcons = CreateClientConVar("HatsChat_LineIcons", (LocalPlayer():GetNWInt("LineIcons") or 1),true,true )
ShowLineGlow = CreateClientConVar("HatsChat_LineGlow", (LocalPlayer():GetNWInt("LineGlow") or 1),true,true )
	local function ChangeCallback( cvar, prev, new )
		LocalPlayer():SetPData( tostring(GetConVar(cvar)) , new)
	end
	cvars.AddChangeCallback( "HatsChat_LineIcons", ChangeCallback)
	cvars.AddChangeCallback( "HatsChat_LineGlow", ChangeCallback)
end)
]]
local Enabled = CreateClientConVar("hatschat_enable", 1, true, true):GetInt()
cvars.AddChangeCallback("hatschat_enable", function(cvar, oldvalue, newvalue)
	CloseChat()
	Enabled = newvalue
	LocalPlayer():ConCommand("HatsChat_Toggle")
end)

local x = 75
local y = ScrH()-200
local emoticons = {}
local EmoticonsReady = false
local function GetEmoticons()


	if HatsChat_Emoticons then
		emoticons = table.Copy(HatsChat_Emoticons)
		EmoticonsReady = true

		timer.Destroy("HatsChat_FindEmoticons")

		for i = 1,#emoticons do
			emoticons[i][5] = 16
		end
	end
end
timer.Create("HatsChat_FindEmoticons", 0, 0, GetEmoticons)
local silkicons = {}
local files = file.Find("materials/icon16/*.png", "MOD")
for k,v in pairs(files) do
	silkicons[string.sub(v,0,-5)] = Material("materials/icon16/" .. v)
end

local function CheckEmote( args )

	local ChatColours = GetChatColors()
	for i = 1,#ChatColours do
		local col = ChatColours[i]
		local place, pend = 0,0
		while (place != nil) do
			for k,v in pairs(args) do
				if (type(v) == "string") then
					place, pend = string.find(string.lower(v), col[1],1,true)

					if place != nil then
						args[k] = string.sub(v,1,place-1)
						table.insert(args, k + 1, col[2])
						table.insert(args, k + 2, string.sub(v,pend + 1,string.len(v)))
					end
				end
			end
		end
	end


	if !EmoticonsReady then return args, false end

	local emoticon = false
	for k,v in pairs(args) do
		if type(v) == "string" then
			for w in string.gmatch(v, "(:[%a_]+:)") do

				local mat = silkicons[string.sub(string.lower(w),2,-2)]
				if mat then
					emoticon = true

					local spos, epos = string.find( v, w, 0, true )


					table.insert(args, k + 1, {"emote", mat, w, 16})

					args[k] = string.sub(v, 1, spos-1)
					table.insert(args, k + 2, string.sub(v,epos + 1,#v))
					v = string.sub(v,epos + 1,#v)

					k = k + 2
					v = args[k]
				end
			end
		end
	end

	for i=1,#emoticons do
		local emote = emoticons[i]
		local pstart, pend = 0,0
		while (pstart != nil) do
			for k,v in pairs(args) do
				if (type(v) == "string") then
					if emote[3] then
						pstart, pend = string.find(v, emote[1],1,true)
					else
						local str = string.lower(v)
						pstart, pend = string.find(str, emote[1],1,true)
					end
					if pstart != nil then
						emoticon = true
						args[k] = string.sub(v,1,pstart-1)

						table.insert(args, k + 1, {"emote", emote[2], string.sub(v,pstart,pend), emote[5]})

						table.insert(args, k + 2, string.sub(v,pend + 1,#v))
					end
				end
			end
		end
	end

	return args, emoticon
end

local function AddMsg( ... )


	local args = { ... }
	local msgargs = {}
	local fullmsg = ""
	local NewArgs = {}

	local LineIcon, LineGlow



	if args[1] and type(args[1]) == "table" then
		if args[1][1] == "LineIcon" then
			LineIcon = tostring(args[1][2])

			table.remove( args, 1 )
		end
	end


	if args[1] and type(args[1]) == "table" then
		if args[1][1] == "LineGlow" then
			LineGlow = args[1][2]

			table.remove( args, 1 )
		end
	end

	local args, emote = CheckEmote( args )

	local NeedNewLine = false

	local LineLength = 0



	local strnum = 0
	local elength = 0
	surface.SetFont("hatchatfont")
	for k,v in ipairs(args) do
		if (type(v)=="string") then
			strnum = strnum + 1
			if (surface.GetTextSize( fullmsg .. v ) + elength > maxlen) then
				NeedNewLine = true



				local ocol = Color(125,175,255)
				for i=1,k do
					if ( ( type(args[i]) == "table") and (args[i].r and args[i].g and args[i].b)) then
						ocol=args[i]
					end
				end

				NewArgs = { ocol }




				local fullstr = ""
				local words = string.Explode(" ", v)
				local newstring = ""

				local ToNew = false

				for i = 1,#words do
					local word = words[i]
					if ToNew then
						newstring = newstring .. " " .. word
					else
						if (surface.GetTextSize( fullmsg .. fullstr .. " " .. word ) + elength > maxlen) then
							ToNew = true
							if (i == 1) then
								if (strnum == 1) then


									local fullword = ""
									local newword = ""

									local foundword = false
									for num, char in ipairs( string.ToTable( word ) ) do
										if foundword then
											newword = newword .. char
										else
										if (surface.GetTextSize( fullmsg .. fullstr .. fullword .. char ) + elength > maxlen) then
											foundword = true
											fullstr = fullstr .. fullword
											newword = char
										else
											fullword = fullword .. char
										end
										end
									end
									newstring = newword

								else
									newstring = word
								end
							else
								newstring = word
							end
						else
							if (i == 1) then
								fullstr = word
							else
								fullstr = fullstr .. " " .. word
							end
						end
					end
				end
				fullmsg = fullmsg .. fullstr
				table.insert(msgargs, fullstr)
				table.insert(NewArgs, newstring)





				for i= k,#args do
					if (i>k) then
						table.insert(NewArgs, args[i] )
					end
				end
				break
			else
				fullmsg = fullmsg .. v
			end
		end

		if (type(v) == "table") and (v[1] == "emote") then
			elength = elength + v[4]
			strnum = strnum + 1

			if (surface.GetTextSize( fullmsg ) + elength > maxlen) then

				NeedNewLine = true
				local ocol = Color(125,175,255)
				for i=1,k do
					if ( ( type(args[i]) == "table") and (args[i].r and args[i].g and args[i].b)) then
						ocol=args[i]
					end
				end

				NewArgs = { ocol, v }

				for i= k,#args do
					if (i>k) then
						table.insert(NewArgs, args[i] )
					end
				end
				break
			end
		end

		table.insert(msgargs, v)
	end




	surface.SetFont("hatchatfont")
	for _,v in pairs( msgargs ) do
		if (type(v) == "string") then
			LineLength = LineLength + surface.GetTextSize( v )
		elseif (type(v) == "table") and (v[1] == "emote") then
			LineLength = LineLength + v[4]
		end
	end


	local info = {
		time = CurTime() + time,
		fullmsg = fullmsg,
		length = LineLength,
		icon = LineIcon,
		glow = LineGlow,
		args = msgargs
	}
	table.insert(history, 1, info)

	if ShowChat then

		if (showing>1) then
			showing = math.min(showing + 1, (#history-maxshow) + 1)
		end
	end

	if (#history > maxhist) then

		while (#history > maxhist) do
			table.remove(history)
		end
	end


	if (sel.Chosen) then
		sel.Start = math.min(sel.Start + 1, maxhist)
		sel.End = math.min(sel.End + 1, maxhist)
		HStart = math.min(HStart + 1, maxhist)
	end



	if NeedNewLine then
		AddMsg( unpack(NewArgs) )
	end
end
hook.Add("PlayerSay", "HatsChat_PlayerSay", function(ply, msg, t, dead)
	local tab = {}


	if dead then
		table.insert(tab, Color(255,25,25) )
		table.insert(tab, "*DEAD* ")
	end


	if t then
		table.insert(tab, Color(10,100,10) )
		table.insert(tab, "(Team) " )
	end


	if ply and ply:IsValid() and ply:IsPlayer() then
		table.insert(tab, team.GetColor( ply:Team() ) )
		table.insert(tab, ply:Nick() )
	else
		table.insert(tab, Color(175,175,200) )
		table.insert(tab, "Console" )
	end


	table.insert(tab, Color(200,200,200)  )
	table.insert(tab, ": " ..msg)

	if ply then
		if ply:IsSuperAdmin() then
			AddMsg( {"LineIcon", "SuperAdmin"}, {"LineGlow", Color(255,255,255)}, unpack( tab ) )
		elseif ply:IsAdmin() then
			AddMsg( {"LineIcon", "Admin"}, {"LineGlow", Color(0,0,0)}, unpack( tab ) )
		elseif TEAM_SPECTATOR and ply:Team() == TEAM_SPECTATOR then
			AddMsg( {"LineIcon", "Spectator"}, unpack( tab ) )
		else
			AddMsg( {"LineIcon", "Player"}, unpack( tab ) )
		end
	else
		AddMsg( {"LineIcon", "Global"}, unpack( tab ) )
	end
end)
local OAddText = chat.AddText
function chat.AddText( ... )
	local args = { ... }

	local LineIcon, LineGlow


	if args[1] then
		if type(args[1]) == "table" and type(args[1][1])=="string" and string.lower(args[1][1]) == "lineicon" then

			LineIcon = tostring(args[1][2])

			table.remove( args, 1 )
		elseif type(args[1]) == "Player" and IsValid(args[1]) then


			if args[1]:IsSuperAdmin() then
				LineIcon = "SuperAdmin"
				LineGlow = Color(255,255,255)
			elseif args[1]:IsAdmin() then
				LineIcon = "Admin"
				LineGlow = Color(0,0,0)
			else
				LineIcon = "Player"
			end
		end
	end

	for k,v in pairs( args ) do
		if (type(v) != "string") and !((type(v) == "table") and (v.r and v.g and v.b)) then
			if (type(v) == "Player") then
				local ocol = Color(125,175,255)
				for i=1,k do
					if ( ( type(args[i]) == "table") and (args[i].r and args[i].g and args[i].b)) then
						ocol=args[i]
					end
				end

				if IsValid(v) and v:IsPlayer() then
					local newargs = args
					table.remove(newargs, k)
					table.insert(newargs, k, team.GetColor( v:Team()) )
					table.insert(newargs, k + 1, v:Nick() )
					table.insert(newargs, k + 2, ocol )



				else
					table.remove(args, k)

					table.insert(args, k, Color(125,175,255) )
					table.insert(args, k + 1, "Console" )
					table.insert(args, k + 2, ocol )
				end
			else
				ErrorNoHalt("[HatsChat Error] Invalid entry to chat.AddText! Type: " .. type(v) .. " Attempting to fix...\n")
				table.remove(args, k)
				table.insert(args, k, tostring(v))
			end
		end
	end

	if LineIcon then
		if LineGlow then
			AddMsg( {"LineIcon", LineIcon}, {"LineGlow", LineGlow}, unpack(args) )
		else
			AddMsg( {"LineIcon", LineIcon}, unpack(args) )
		end
	elseif LineGlow then
		AddMsg( {"LineIcon", "Other"}, {"LineGlow", LineGlow}, unpack(args) )
	else
		AddMsg( {"LineIcon", "Other"}, unpack(args) )
	end
	OAddText( unpack(args) )
	return true
end

hook.Add("Default", "HatsChat_Default", function(plindex, plname, text, typ)
	if typ == "joinleave" then
		if type(text) == "string" then
			if string.find(text, "left the game") then
				AddMsg( {"LineIcon", "Leave"}, Color(125,255,175), text )
			else
				AddMsg( {"LineIcon", "Join"}, Color(125,255,175), text )
			end
		else
			AddMsg( Color(125,255,175), text )
		end
	else
		AddMsg( {"LineIcon", "Global"}, Color(125,175,255), text )
	end
end)

local BorderCol = Color(25, 25, 25, 255)
local BGCol = Color(25, 25, 25, 100)
local FGCol = Color(25, 25, 25, 200)
local HCol = Color(50,150,255)
local DefCol = Color(125,175,255,255)

local function DrawChat()
	if Enabled then
		render.SetScissorRect(x, y - maxshow * tHeight, x + maxlen + 21, y, true)

		surface.SetFont("hatchatfont")

		for k, v in pairs(history) do
			if ( ShowChat or (v.time > CurTime()) ) then

				if ((k <= maxshow + showing) and (k >= (showing - 1))) then
					local pos = ((k-showing) + 1)

					if v.icon and HatsChat_LineIcons then
					--if v.icon and ShowLineIcons and ShowLineIcons:GetBool() and HatsChat_LineIcons then
						local icon = HatsChat_LineIcons[ v.icon ]
						if icon then
							surface.SetMaterial( icon[1] )
							surface.SetDrawColor(255,255,255,255)

							surface.DrawTexturedRect( x-17, y-pos * tHeight, 15, 15)
						end
					end
					local col = DefCol

					if v.glow then
					--if v.glow and ShowLineGlow and ShowLineGlow:GetBool() then
						local GlowMod = math.Clamp( ( math.sin( CurTime() * 2 ) + 1 )/2, 0, 1)
						for i=1,#v.args do
							local arg = v.args[i]
							if type(arg)=="string" then
								for n=i,0,(-1) do
									if n<1 then
										local r = ((DefCol.r - v.glow.r) * GlowMod) + DefCol.r
										local g = ((DefCol.g - v.glow.g) * GlowMod) + DefCol.g
										local b = ((DefCol.b - v.glow.b) * GlowMod) + DefCol.b

										col = Color(r, g, b)
										break
									elseif type( v.args[n] ) == "table" and v.args[n].r and v.args[n].g then
										local OldCol = v.glow.old
										if not OldCol then
											v.glow.old = table.Copy(v.args[n]) OldCol = v.glow.old
										end

										local r = ((OldCol.r - v.glow.r) * GlowMod) + v.glow.r
										local g = ((OldCol.g - v.glow.g) * GlowMod) + v.glow.g
										local b = ((OldCol.b - v.glow.b) * GlowMod) + v.glow.b

										v.args[n] = Color(r, g, b)
										break
									end
								end

								break
							end
						end
					end

					local len = x

					if sel.Chosen and (k >= sel.Start and k <= sel.End) then
						local _,h = surface.GetTextSize( v.fullmsg )



						surface.SetDrawColor(HCol)

						if k==sel.Start then
							if k==sel.End then
								surface.DrawRect(sel.Char.Start[2], (y-pos * tHeight) + 1, (sel.Char.End[2]-sel.Char.Start[2]), h)



							else
								surface.DrawRect(x, (y-pos * tHeight) + 1, (sel.Char.End[2]-x), h)


							end
						elseif k==sel.End then
							surface.DrawRect(sel.Char.Start[2], (y-pos * tHeight) + 1, ((v.length + x)-sel.Char.Start[2]), h)


						else
							surface.DrawRect(x, (y-pos * tHeight) + 1, v.length, h)
						end
					end

					for k,text in pairs( v.args ) do
						if (type(text) == "string") then
							draw.SimpleText(text, "hatchatfont", len + 1, y-pos * tHeight + 1, color_black)
							draw.SimpleText(text, "hatchatfont", len, y-pos * tHeight, col)
							len = len + surface.GetTextSize(text, "hatchatfont")
						elseif (type(text) == "table" and text[1]=="emote") then
							surface.SetMaterial( text[2] )
							surface.SetDrawColor(255,255,255,255)

							local offy = math.floor(tHeight/2 - text[4]/2)
							surface.DrawTexturedRect(len, y - pos * tHeight + offy, text[4], text[4])
							len = len + text[4]
						else
							col = text
						end
					end
				end
			end
		end

		render.SetScissorRect(0,0,0,0,false)


		if ShowChat then

			local chatboxtall = maxshow * tHeight

			if (#history > maxshow) then
				local max = (#history-maxshow) + 1
				if (max > 10) then
					barsize = 22
					local percent = (showing-1)/(max-1)


					barscroll = ( (chatboxtall-22) * percent ) + 27
				else
					barsize = chatboxtall/max

					barscroll = ( (showing/max) * chatboxtall )
				end

				barscroll = math.floor(barscroll)

				derma.GetDefaultSkin().tex.Scroller.TrackV( x - 24 - 5, y-chatboxtall, 24, chatboxtall, Color(255,255,255,50))
				derma.GetDefaultSkin().tex.Scroller.ButtonV_Normal( x - 24 - 5, y-barscroll, 24, barsize, color_white)
			else

				barsize = chatboxtall
				barscroll = chatboxtall
			end


			surface.SetFont("hatchatfont")
			local InputVerf = Default
			InputLen = math.max( surface.GetTextSize(InputVerf), (maxlen-2) )





			if TeamChat then
				draw.SimpleText( "Team: ", "hatchatfont", x-7, y + 5 + 10, BorderCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT )
			else
				draw.SimpleText( "Chat: ", "hatchatfont", x-7, y + 5 + 10, BorderCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT )
			end


			surface.SetDrawColor(Color(255,255,255,50))
			surface.DrawRect(x - 1, y + 14, InputLen + 2, tHeight + 2)



			if InputSel.Select then
				if (InputSel.Start == cur.At) then InputSel.Select = false end

				local Start, End
				if InputSel.Start < cur.At then
					Start,End = InputSel.Start, cur.At
				else
					Start,End = cur.At, InputSel.Start
				end

				StrStart = surface.GetTextSize( utf8.sub(InputVerf, 0, Start) )
				Width = surface.GetTextSize( utf8.sub(InputVerf, (Start==0 and 0 or Start + 1), End) )

				draw.RoundedBox(2, x + StrStart, y + 6 + 10, Width, 18, HCol)
			end


			draw.SimpleText( Default , "hatchatfont", x, y + 5 + 10, BorderCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT )


			if (cur.Show) then
				draw.RoundedBox(0, x + cur.Pos, y + 5 + 10, 1, 17, BorderCol)
			end
			if (CurTime() > cur.Time) then cur.Show,cur.Time=!cur.Show,CurTime() + 0.35 end
		end
	end
end
hook.Add("HUDPaint", "HatsChat_DrawChat", DrawChat)

hook.Add( "HUDShouldDraw", "HatsChat_HideChat", function ( x ) if ( x == "CHudChat" ) then return not Enabled end end )

function CloseChat()

	if !ShowChat then return true end
	ShowChat = false

	gui.EnableScreenClicker( false )

	showing = 1
	Default = ""


	sel.Select = false
	sel.Chosen = false


	cur.At = 0
	cur.Show = false
	cur.Str = ""
	cur.Time = CurTime() + 900
	cur.Pos = 0

	hook.Call("FinishChat", GAMEMODE)
end
concommand.Remove("messagemode")
concommand.Remove("messagemode2")

local function OpenChat(ply, bind, pressed)
	if (ply == LocalPlayer()) and Enabled then

		if ShowChat then
			if (bind == "cancelselect") then CloseChat() return true end
			if (bind ~= "toggleconsole") then return true end

		elseif (bind == "messagemode" or bind == "messagemode2") and pressed then
			timer.Simple(0.05, function() ShowChat = true end)

			TeamChat = (bind == "messagemode2")

			gui.EnableScreenClicker( true )

			Default = ""


			cur.At = 0
			cur.Show = true
			cur.Time = CurTime() + 0.5
			cur.Pos = 0

			hook.Call("StartChat", GAMEMODE)

			return true
		end
	end
end
hook.Add("PlayerBindPress","HatsChat_BindPress",OpenChat)

local BadInput = Sound("common/wpn_denyselect.wav")
local function AddText( str )
	if (!str) or (type(str) ~= "string") or (#str <=0) then return false end

	cur.Show = true
	cur.Time = CurTime() + 0.3

	local Start,End
	if InputSel.Select then
		local NumStart, NumEnd

		if InputSel.Start < cur.At then
			NumStart,NumEnd = InputSel.Start, cur.At
		else
			NumStart,NumEnd = cur.At, InputSel.Start
		end

		Start,End = utf8.sub(Default,0,math.max(NumStart,0)),utf8.sub(Default,NumEnd + 1,utf8.len(Default) + 1)

		InputSel.Select = false

		cur.At = NumStart
	else
		Start, End = utf8.sub(Default,1,cur.At),utf8.sub(Default,cur.At + 1,-1)
	end

	if cur.At == utf8.len(Default) then End = "" end

	if utf8.len(Start .. str .. End) <=126 then
		Default = Start .. str .. End

		cur.At = math.min(cur.At + utf8.len(str), utf8.len(Default))
	else

		if utf8.len(Start .. End) < 126 then
			local tab = string.ToTable(str)
			for i=1,#tab do
				local char = tab[i]
				if utf8.len(Start .. char .. End)<=126 then
					Start = Start .. char
				else
					cur.At = utf8.len(Start)
					Default = Start .. End
					break
				end
			end
		end
		surface.PlaySound(BadInput)
	end

	surface.SetFont("hatchatfont")
	local InputVerf = Default
	cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )

	hook.Call("DefaultChanged", GAMEMODE, tostring(Default) )
end

local KeyMap = {KEY_A,KEY_C,KEY_X,KEY_LEFT,KEY_RIGHT,KEY_DELETE,KEY_BACKSPACE}
local Pressed = {}
local HoldKey = {false,CurTime()}

local function KeyPress()
	if ShowChat and Enabled then
		if input.IsKeyDown(KEY_ENTER) then
		elseif input.IsKeyDown(KEY_ESCAPE) then
			CloseChat()
		elseif input.IsKeyDown(KEY_HOME) then
			if input.IsKeyDown(KEY_LSHIFT) then
				if not InputSel.Select then
					InputSel.Start = cur.At
					sel.Select = false
					sel.Chosen = false
				end
			end InputSel.Select = input.IsKeyDown(KEY_LSHIFT)

			cur.At = 0

			surface.SetFont("hatchatfont")
			local InputVerf = string.gsub( Default, "&", "#" )
			cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
		elseif input.IsKeyDown(KEY_END) then
			if input.IsKeyDown(KEY_LSHIFT) then
				if not InputSel.Select then
					InputSel.Start = cur.At
					sel.Select = false
					sel.Chosen = false
				end
			end InputSel.Select = input.IsKeyDown(KEY_LSHIFT)

			cur.At = utf8.len(Default)

			surface.SetFont("hatchatfont")
			local InputVerf = string.gsub( Default, "&", "#" )
			cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
		elseif (input.IsKeyDown(KEY_A) and input.IsKeyDown(KEY_LCONTROL)) and ((!Pressed[KEY_A]) or (HoldKey[1]==KEY_A and HoldKey[2]<CurTime())) then
			InputSel.Select = true
			InputSel.Start = 0
			cur.At = utf8.len(Default)

			sel.Select = false
			sel.Chosen = false

			surface.SetFont("hatchatfont")
			local InputVerf = string.gsub( Default, "&", "#" )
			cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
		elseif (input.IsKeyDown(KEY_C) and input.IsKeyDown(KEY_LCONTROL)) and ((!Pressed[KEY_C]) or (HoldKey[1]==KEY_C and HoldKey[2]<CurTime())) and InputSel.Select then
			if InputSel.Start < cur.At then
				SetClipboardText( utf8.sub( Default, InputSel.Start + 1, cur.At ) )
			elseif InputSel.Start ~= cur.At then
				SetClipboardText( utf8.sub( Default, cur.At + 1, InputSel.Start ) )
			else
				InputSel.Select = false
			end
		elseif (input.IsKeyDown(KEY_X) and input.IsKeyDown(KEY_LCONTROL)) and ((!Pressed[KEY_X]) or (HoldKey[1]==KEY_X and HoldKey[2]<CurTime())) and InputSel.Select then
			local NumStart, NumEnd
			if InputSel.Start < cur.At then
				NumStart,NumEnd = InputSel.Start, cur.At
				SetClipboardText( utf8.sub( Default, InputSel.Start + 1, cur.At ) )
			elseif InputSel.Start ~= cur.At then
				NumStart,NumEnd = cur.At, InputSel.Start
				SetClipboardText( utf8.sub( Default, cur.At + 1, InputSel.Start ) )
			else
				InputSel.Select = false
			end
			Start,End = utf8.sub(Default,0,math.max(NumStart,0)),utf8.sub(Default,NumEnd + 1,utf8.len(Default) + 1)

			Default = Start .. End

			InputSel.Select = false
			cur.At = NumStart

			hook.Call("DefaultChanged", GAMEMODE, tostring(Default) )
		elseif input.IsKeyDown(KEY_LEFT) and ((!Pressed[KEY_LEFT]) or (HoldKey[1]==KEY_LEFT and HoldKey[2]<CurTime())) then
			cur.Time = CurTime() + 0.3 cur.Show = true
			HoldKey = {KEY_LEFT,CurTime() + 0.2}

			if input.IsKeyDown(KEY_LSHIFT) then
				if not InputSel.Select then
					InputSel.Start = cur.At
					sel.Select = false
					sel.Chosen = false
				end
			end InputSel.Select = input.IsKeyDown(KEY_LSHIFT)

			if input.IsKeyDown(KEY_LCONTROL) then
				local num = 0
				for i=(cur.At-1),0,-1 do
					if utf8.sub(Default,i,i) == " " then
						num=i
						break
					end
				end
				cur.At = num
				if cur.At==0 then cur.Pos = 0 else
					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
				end
			else
				cur.At = math.max(0, cur.At-1)
				if cur.At==0 then cur.Pos = 0 else
					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
				end
			end
		elseif input.IsKeyDown(KEY_RIGHT) and ((!Pressed[KEY_RIGHT]) or (HoldKey[1]==KEY_RIGHT and HoldKey[2]<CurTime())) then
			cur.Time = CurTime() + 0.3 cur.Show = true
			HoldKey = {KEY_RIGHT,CurTime() + 0.2}

			if input.IsKeyDown(KEY_LSHIFT) then
				if not InputSel.Select then
					InputSel.Start = cur.At

					sel.Select = false
					sel.Chosen = false
				end
			end InputSel.Select = input.IsKeyDown(KEY_LSHIFT)

			if input.IsKeyDown(KEY_LCONTROL) then
				local num = utf8.len(Default)
				for i= (cur.At + 1),utf8.len(Default) do
					if utf8.sub(Default,i,i) == " " then
						num=i
						break
					end
				end
				cur.At = num
				if cur.At>utf8.len(Default) then cur.At = utf8.len(Default) end
				if cur.At==0 then cur.Pos = 0 else
					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
				end
			else
				cur.At = math.min(utf8.len(Default), cur.At + 1)
				if cur.At==0 then cur.Pos = 0 else
					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
				end
			end
		elseif input.IsKeyDown(KEY_BACKSPACE) and ((!Pressed[KEY_BACKSPACE]) or (HoldKey[1]==KEY_BACKSPACE and HoldKey[2]<CurTime())) then
			HoldKey = {KEY_BACKSPACE,(!Pressed[KEY_BACKSPACE]) and CurTime() + 0.4 or CurTime() + 0.03}
			if InputSel.Select then
				local Start, End
				if InputSel.Start < cur.At then
					Start,End = InputSel.Start, cur.At
				else
					Start,End = cur.At, InputSel.Start
				end
				StrStart,StrEnd = utf8.sub(Default,0,math.max(Start,0)),utf8.sub(Default,End + 1,utf8.len(Default) + 1)
				Default = StrStart .. StrEnd

				InputSel.Select = false

				cur.At = math.min(cur.At,Start)
				if cur.At==0 then cur.Pos = 0 else
					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
				end

			else
				local Start, End = utf8.sub(Default,0,math.max(cur.At-1,0)),utf8.sub(Default,cur.At + 1,-1)
				Default = Start .. End

				cur.At = math.max(0, cur.At-1)
				if cur.At==0 then cur.Pos = 0 else
					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
				end
			end

			hook.Call("DefaultChanged", GAMEMODE, tostring(Default) )
		elseif input.IsKeyDown(KEY_DELETE) and ((!Pressed[KEY_DELETE]) or (HoldKey[1]==KEY_DELETE and HoldKey[2]<CurTime())) then
			HoldKey = {KEY_DELETE,CurTime() + 0.2}
			if InputSel.Select then
				local Start, End
				if InputSel.Start < cur.At then
					Start,End = InputSel.Start, cur.At
				else
					Start,End = cur.At, InputSel.Start
				end
				StrStart,StrEnd = utf8.sub(Default,0,math.max(Start,0)),utf8.sub(Default,End + 1,utf8.len(Default) + 1)
				Default = StrStart .. StrEnd

				InputSel.Select = false

				cur.At = math.min(cur.At,Start)
				if cur.At==0 then cur.Pos = 0 else
					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
				end
			else
				if cur.At + 2 >utf8.len(Default) then Default=utf8.sub(Default,1,cur.At) else
					local Start, End = utf8.sub(Default,1,cur.At),utf8.sub(Default,cur.At + 2,-1)
					Default = Start .. End
				end

				cur.At = math.min(cur.At,utf8.len(Default))
				if cur.At==0 then cur.Pos = 0 else
					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )
				end
			end

			hook.Call("DefaultChanged", GAMEMODE, tostring(Default) )
		else
			if not PasteFrame then
				PasteFrame = vgui.Create("DFrame")
				PasteFrame:SetPos( ScrW() * 2, ScrH() * 2 ) PasteFrame:ShowCloseButton( false )
				PasteFrame:MakePopup()

				PasteBox = vgui.Create("DTextEntry",PasteFrame)
				PasteBox.OnTextChanged = function(self)
					local msg = PasteBox:GetValue()
					if (msg ~= "") then AddText( msg ) end
					PasteBox:SetText("")

					hook.Call("DefaultChanged", GAMEMODE, tostring(Default) )
				end
				PasteBox.OnLoseFocus = function(self) PasteBox:RequestFocus() end
				PasteBox.OnEnter = function(self)
					if not Enabled then CloseChat() return end

					if utf8.len(Default) > 0 then
						if TeamChat then
							RunConsoleCommand("say_team", Default)
						else
							RunConsoleCommand("say", Default)
						end
					end
					CloseChat()
				end

				PasteBox:RequestFocus()
			elseif not PasteBox.OnTextChanged then ErrorNoHalt("Chat input box disappeared!") PasteFrame:Close() PasteFrame = nil end
		end
	else
		if PasteFrame then PasteFrame:Close() PasteFrame = nil end
	end

	for _,v in pairs( KeyMap ) do
		Pressed[v] = input.IsKeyDown(v)
	end
end
hook.Add("Think","HatsChat_KeyPress",KeyPress)

function chat.SetText(txt)
	if ShowChat and Enabled then
		Default = txt
		cur.At = utf8.len(txt)

		--jesus christ who coded hatschat
		--this chunk of code is needed everywhere cur.At is done, to visually position the cursor
		surface.SetFont("hatchatfont")
		local InputVerf = string.gsub( txt, "&", "#" )
		cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )

		hook.Run("DefaultChanged", txt)
	end
end

local function PlaceInLine( line, pos )
	surface.SetFont( "hatchatfont" )
	if !line or !pos then return 0 end

	if type(line) ~= "table" then
		ErrorNoHalt("Bad argument #1 to PlaceInLine (table expected, got " .. type(line) .. ")\n") return 0
	elseif line.args then line = line.args end

	if #line==0 then return 0 end
	surface.SetFont("hatchatfont")

	pos=pos-x
	local size = 0
	local len = 0
	for i=1,#line do
		local part = line[i]

		if type(part)=="table" and part[1]=="emote" then
			if len + part[4] > pos then
				return size
			else
				size=size + 1
				len = len + part[4]
			end
		elseif type(part)=="string" then
			local PartStr = string.gsub( part, "&", "#" )
			local w = 0
			for n=1,utf8.len(part) do
				w = surface.GetTextSize( utf8.sub( PartStr, 1, n), "hatchatfont" )
				if (w + len)>pos then return (size + (n-1)) end
			end
			size = size + utf8.len(part)
			len = len + w
		end
	end

	return size
end
local function PosFromPlace( line, place )
	surface.SetFont("hatchatfont")
	if place<=0 then return x end

	if type(line) ~= "table" then
		ErrorNoHalt("Bad argument #1 to PosFromPlace (table expected, got " .. type(line) .. ")\n") return 0
	elseif line.args then line = line.args end

	if #line==0 then return x end

	local pos = x
	local point = 0
	for i=1,#line do
		local part = line[i]
		if type(part)=="string" then
			local PartStr = string.gsub( part, "&", "#" )
			for n=1,utf8.len(part) do
				local str = utf8.sub( PartStr, 1, n)
				point = point + 1

				if point>=place then
					surface.SetFont("hatchatfont")

					local w = surface.GetTextSize(str, "hatchatfont")
					return (pos + w)
				end
			end

			surface.SetFont( "hatchatfont" )
			local w = surface.GetTextSize(part, "hatchatfont")
			pos=pos + w

		elseif type(part)=="table" and part[1]=="emote" then
			point = point + 1
			pos = pos + part[4]
			if point>=place then
				return pos
			end
		end
	end

	return pos
end
local M1 = false
local drag = false
local InputHigh = false
local function Think()
	if !ShowChat then return end
	if not Enabled then return end


	if input.IsMouseDown( MOUSE_LEFT ) then
		local mx = gui.MouseX()

		if drag then
			local max = (#history-maxshow) + 1
			local b = y- gui.MouseY()


			showing = math.Clamp(
			( ((max-1) * (b-27)) /(maxshow * tHeight - 22)) +1,
			1, max)
		else
			if (mx > (x - 24 - 5)) and (mx < (x - 5)) then
				local my = gui.MouseY()
				if (my > (y-225)) and (my < (y-5)) then
					drag = true
				end
			end
		end


		if InputHigh then
			local tab = string.ToTable( Default )
			local str = ""
			local size = 0
			cur.At = 0

			surface.SetFont("hatchatfont")
			for i=1,#tab do
				str = str .. tab[i]
				local InputVerf = string.gsub( str, "&", "#" )

				size = surface.GetTextSize( string.gsub( str, "&", "#" ) )
				if (size + (x-1))<mx then
					cur.At = i
					cur.Pos = size
				else break end
			end

			surface.SetFont("hatchatfont")
			local InputVerf = string.gsub( Default, "&", "#" )
			cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )

			InputHigh = true
			InputSel.Select = (cur.At ~= InputSel.Start)
		elseif !M1 then
			if (mx > (x-1)) and (mx < (x + InputLen + 1)) then
				local my = gui.MouseY()
				if (my > y + 4) and (my < y + 24) then
					local tab = string.ToTable( Default )
					local str = ""
					local size = 0
					cur.At = 0

					surface.SetFont("hatchatfont")
					for i=1,#tab do
						str = str .. tab[i]

						size = surface.GetTextSize( string.gsub( str, "&", "#" ) )
						if ( (size + (x-1)) < mx ) then
							cur.At = i
						else break end
					end

					surface.SetFont("hatchatfont")
					local InputVerf = string.gsub( Default, "&", "#" )
					cur.Pos = surface.GetTextSize( utf8.sub(InputVerf, 1, cur.At) )

					InputHigh = true
					InputSel.Start = cur.At
				end
			end
		end


		if sel.Select then
			local my = gui.MouseY()

			local HNum = math.floor( (y +tHeight -my-1 +tHeight * showing)/tHeight )-1

			if (HNum > HStart) then
				sel.Start = HStart
				sel.End = HNum

				local line = history[HNum]
				local place = PlaceInLine( line , mx)
				sel.Char.Start = {place, PosFromPlace(line, place)}
				sel.Char.End = table.Copy( sel.Char.B )
			elseif (HNum < HStart) then
				sel.Start = HNum
				sel.End = HStart

				local line = history[HNum]
				local place = PlaceInLine( line , mx)
				sel.Char.Start = table.Copy( sel.Char.B )
				sel.Char.End = {place, PosFromPlace(line, place)}
			elseif (HNum == HStart) then
				sel.Start = HStart
				sel.End = HStart

				local line = history[HNum]
				local place = PlaceInLine( line , mx)
				if mx > sel.Char.B[2] then
					sel.Char.Start = table.Copy( sel.Char.B )
					sel.Char.End = {place, PosFromPlace(line, place)}
				else
					sel.Char.Start = {place, PosFromPlace(line, place)}
					sel.Char.End = table.Copy( sel.Char.B )
				end
			end

			InputSel.Select = false
		elseif !M1 then
			if (mx > x) and (mx < (x + maxlen)) then
				local my = gui.MouseY()
				if (my < (y)) and (my > (y-226)) then
					sel.Select = true
					sel.Chosen = true
					InputSel.Select = false

					HStart = math.floor( (y +tHeight-my-1 +tHeight * showing)/tHeight )-1
					if (HStart > #history) then HStart = #history end

					sel.Start = HStart
					sel.End = HStart

					local line = history[HStart]
					local place = PlaceInLine(line, mx)
					sel.Char.B = {place, PosFromPlace(line, place)}
					sel.Char.Start = table.Copy( sel.Char.B )
					sel.Char.End = table.Copy( sel.Char.B )

				else
					sel.Chosen = false
				end
			else
				local my = gui.MouseY()
				if !( (mx > (x-55)) and (mx < (x-31)) and (my > (y-225)) and (my < (y-5)) ) then
					sel.Chosen = false
				end
			end
		end

		M1 = true
	else
		if (#history > maxshow) then showing = math.Clamp( math.Round(showing), 1, (#history-maxshow) + 1 ) end
		M1 = false
		drag = false
		sel.Select = false
		InputHigh = false
	end


	if (input.IsKeyDown(KEY_C)) then
		if (input.IsKeyDown(KEY_LCONTROL) or input.IsKeyDown(KEY_RCONTROL)) then
			if sel.Chosen then
				local tab = {}
				for i= sel.Start, sel.End do
					local line = ""
					if i==sel.Start and i==sel.End and (i>=1) and (i<=#history) then
						local pos = 0
						for _,text in pairs( history[i].args ) do
							if type(text)=="string" then
								for n=1,#text do
									pos = pos + 1
									if pos>sel.Char.Start[1] and pos<=sel.Char.End[1] then
										line = line .. utf8.sub(text,n,n)
									end
								end
							elseif type(text)=="table" and text[1]=="emote" then
								pos=pos + 1
								if pos > sel.Char.Start[1] and pos<=sel.Char.End[1] then
									line = line .. text[3]
								end
							end
						end
					elseif i==sel.End and (i>=1) and (i<=#history) then
						local pos = 0
						for _,text in pairs( history[i].args ) do
							if type(text)=="string" then
								for n=1,#text do
									pos = pos + 1
									if pos>sel.Char.Start[1] then
										line = line .. utf8.sub(text,n,-1)
										break
									end
								end
							elseif type(text)=="table" and text[1]=="emote" then
								pos=pos + 1
								if pos > sel.Char.Start[1] then
									line = line .. text[3]
								end
							end
						end
					elseif i==sel.Start and (i>=1) and (i<=#history) then
						local pos = 0
						for _,text in pairs( history[i].args ) do
							if type(text)=="string" then
								for n=1,#text do
									pos = pos + 1
									if pos<=sel.Char.End[1] then
										line = line .. utf8.sub(text,n,n)
									end
								end
							elseif type(text)=="table" and text[1]=="emote" then
								pos=pos + 1
								if pos <= sel.Char.End[1] then
									line = line .. text[3]
								end
							end
						end
					elseif (i>=1) and (i<=#history) then
						for _,text in pairs( history[i].args ) do
							if (type(text) == "string") then
								line = line .. text
							elseif (type(text) == "table" and text[1]=="emote") then
								line = line .. text[3]
							end
						end

					end

					table.insert(tab, 1, line)
				end


				local str = table.concat(tab,"\n")
				SetClipboardText( str )
			end
		end
	end
end
hook.Add("Think", "HatsChat_Think", Think)


function MsgColor( ... )
	if Enabled then
		OAddText( ... )
	else
		local str = ""
		local args = {...}

		for i=1,#args do
			if type(args[i]) == "string" then
				str = str .. tostring(args[i])
			elseif type(args[i]) == "Player" then
				str = str .. args[i]:Nick()
			end
		end

		MsgN( tostring(str) )
	end
end
MsgCol = MsgColor
concommand.Add("HatsChat_Test", function(ply, c, a)
	if ply~=LocalPlayer() then return end

	local loop = (tonumber(a[1]) or maxshow) or 15
	if #a>=1 then table.remove(a, 1) end

	timer.Create("DefaultTesting",0, loop, function()
		chat.AddText( Color(math.random() * 255,math.random() * 255,math.random() * 255),

			a[1] and table.concat(a," ") or
			("[Testing Chatbox] " .. HatsChat_Emoticons[math.Round(math.random(1,#HatsChat_Emoticons))][1]))
	end)
end)
concommand.Add("HatsChat_Toggle", function(ply,c,a)
	if ply~=LocalPlayer() then return end

	CloseChat()
	Enabled = not Enabled
end)
