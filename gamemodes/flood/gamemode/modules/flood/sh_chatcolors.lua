
local ChatColors = {
	{"[red]"     , Color(255,0,0)},
	{"[green]"   , Color(0,255,0)},
	{"[lime]"    , Color(127,255,0)},
	{"[blue]"    , Color(0,0,255)},
	{"[yellow]"  , Color(255,255,0)},
	{"[orange]"  , Color(255,106,0)},
	{"[magenta]" , Color(255,0,170)},
	{"[white]"   , Color(255,255,255)},
	{"[black]"   , Color(0,0,0)},
	{"[cyan]"    , Color(0,255,255)},
	{"[purple]"  , Color(127,0,255)},
	{"[pink]"    , Color(255,102,178)},
	{"^1"        , Color(255,0,0)},
	{"^2"        , Color(0,255,0)},
	{"^3"        , Color(255,255,0)},
	{"^4"        , Color(0,0,255)},
	{"^5"        , Color(0,255,255)},
	{"^6"        , Color(127,0,255)},
	{"^7"        , Color(255,255,255)},
	--{"^8"      , asdf}                , -- in MW2 this is a color that changes depending on team
	{"^9"        , Color(127,127,127)},
	{"^0"        , Color(0,0,0)},
}
function FilterNick( nick )
	for i = 1, #ChatColors do
		nick = string.Replace(nick, ChatColors[i][1], "")
	end
	return nick
end

local meta = FindMetaTable("Player")
function meta:FilteredNick()
	return FilterNick(self:Nick())
end

function GetChatColors()
	return ChatColors
end
