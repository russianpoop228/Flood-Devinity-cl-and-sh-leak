
local _songs = GM.SongSystem.Songs


local meta = {}
function meta:GetTitle()
	return self.title
end

function meta:GetURL()
	return self.url
end

function meta:GetLength()
	return self.length
end

function meta:GetUploaderNick()
	return self.uploader.nick
end

function meta:GetUploaderSteamID()
	return self.uploader.steamid
end

function meta:GetTimestamp()
	return self.timestamp
end

function meta:GetAutoPlayEnabled()
	return (self.ap_enabled == nil) and false or self.ap_enabled
end

function meta:GetAutoPlayEvents()
	return self.ap_events or {}
end

function meta:GetAutoPlayPhases()
	return self.ap_phases or 0
end

function meta:GetAutoPlayFrequency()
	return math.Clamp(self.ap_freq or 1, 1, 15)
end

function meta.__tostring(a)
	return string.format("Song{%s, %s, %s}", a:GetTitle(), a:GetURL(), string.FromSeconds(a:GetLength()))
end

AddSettingsItem("music" , "checkbox" , "fm_music"       , {lbl = "Enable music"})
AddSettingsItem("music" , "checkbox" , "fm_muteunfocus" , {lbl = "Mute music when game loses focus"})
AddSettingsItem("music" , "slider"   , "fm_musiclevel"  , {lbl = "Music Volume" , min = 0.1 , max = 1 , decimals = 1})

local usemusic   = CreateClientConVar("fm_music"       , 1   , true , true)
local usemute    = CreateClientConVar("fm_muteunfocus" , 1   , true , true)
local soundlevel = CreateClientConVar("fm_musiclevel"  , 0.3 , true , false)

function meta:GetVolume()
	if not self:IsValid() then return 0 end
	return self:GetSongObject():GetVolume()
end

function meta:SetComputedVolume(mul)
	self:SetVolume(mul or soundlevel:GetFloat())
end

function meta:SetVolume(v)
	if not self:IsValid() then return end
	self:GetSongObject():SetVolume(v)
end

function meta:SetTime(v)
	if not self:IsValid() then return end
	return self:GetSongObject():SetTime(v)
end

function meta:Pause()
	if not self:IsValid() then return end
	self:GetSongObject():Pause()
end

function meta:IsValid()
	return IsValid(self:GetSongObject())
end

function meta:IsPlaying()
	return self.playing or false
end

function meta:GetSongObject()
	return self.songobj
end

local function GrabWebSong(path, callback)
	sound.PlayURL(path, "noplay noblock", function(song,errid,errstr)
		if IsValid(song) then
			callback(song)
		else
			printWarn("Error playing song! (%q, %d:%s)", path, errid, errstr)
		end
	end)
end

function meta:Load()
	if self.loadattempts > 3 then return end
	self.loadattempts = self.loadattempts + 1

	GrabWebSong("http://devinity.org/flood/songs_new/" .. self:GetURL() .. ".mp3", function(songobj)
		self.songobj = songobj

		if GAMEMODE:GetCurrentSong() == self then
			self:Play()
		end
	end)
end

local fadetime = 2
local fadesteps = 10
function meta:Stop()
	if not self:IsPlaying() then return end
	self.playing = false

	if GAMEMODE.SongSystem.Current == self then
		GAMEMODE.SongSystem.Current = nil
		GAMEMODE.SongSystem.CurrentEnd = nil
	end

	local timerid = "FadeOut" .. self:GetURL()
	local curvol = self:GetVolume()
	local startvol = curvol
	timer.Create(timerid, fadetime / fadesteps, 0, function()
		if not IsValid(self) then
			timer.Remove(timerid)
			return
		end

		curvol = curvol - (startvol / fadesteps)
		if curvol <= 0 then
			self:SetVolume(startvol)
			self:SetTime(0)
			self:Pause()
			timer.Remove(timerid)
		else
			self:SetVolume(curvol)
		end
	end)
end

function meta:Play(previewmode)
	if not previewmode and usemusic:GetBool() == false then return end

	GAMEMODE.SongSystem.Current = self
	GAMEMODE.SongSystem.CurrentEnd = CurTime() + self:GetLength()

	if self.playing then
		self:SetTime(0)
	end

	self.playing = true

	if not self:IsValid() then
		self:Load()
		return
	end

	self.songobj:Play()

	if not preview then
		printInfo("Playing song %s", self:GetTitle())
		hook.Run("FMSongPlay", self)
	end

	if GAMEMODE.SongsMuted then
		self:SetVolume(0)
	else
		self:SetComputedVolume()
	end

	timer.Remove("songtimer")
	timer.Create("songtimer", self:GetLength(), 1, function()
		self:Stop()
	end)
end

function meta:ReadNetData(skipurl)
	if not skipurl then
		self.url = net.ReadString()
	end
	self.title = net.ReadString()
	self.uploader = {
		nick = net.ReadString(),
		steamid = net.ReadString()
	}
	self.length = net.ReadUInt(16)
	self.timestamp = net.ReadUInt(32)

	self.ap_enabled = net.ReadBool()
	self.ap_phases = net.ReadUInt(6)
	self.ap_freq = net.ReadUInt(4)
	self.ap_events = {}
	for _ = 1, net.ReadUInt(8) do
		self.ap_events[net.ReadString()] = true
	end
end

function meta:Save()
	net.Start("FMSaveSong")
		net.WriteString(self.url)
		net.WriteString(self.edit.title)
		net.WriteBool(self.edit.ap_enabled)
		net.WriteUInt(self.edit.ap_phases, 6)

		local events = self.edit.ap_events or {}
		net.WriteUInt(table.Count(events), 8)
		for k, _ in pairs(events) do
			net.WriteString(k)
		end
	net.SendToServer()

	self:ResetEdits()
end

function meta:Remove()
	net.Start("FMRemoveSong")
		net.WriteString(self.url)
	net.SendToServer()
end

function meta:IsEdited()
	if not self.edit then return false end

	for key, newval in pairs(self.edit) do
		if istable(newval) then
			if not table.Equals(self[key], newval) then return true end
		else
			if self[key] != newval then return true end
		end
	end

	return false
end

function meta:ResetEdits()
	self.edit = {
		title = self.title,
		ap_enabled = self.ap_enabled,
		ap_phases = self.ap_phases,
		ap_freq = self.ap_freq,
		ap_events = table.Copy(self.ap_events),
	}
end

meta.__index = meta
local function CreateSongObject(dontadd)
	local t = {}
	setmetatable(t, meta)

	t.title = "N/A"
	t.url = "N/A"
	t.length = 0
	t.timestamp = 0
	t.uploader = {
		nick = "N/A",
		steamid = "N/A"
	}
	t.ap_enabled = false
	t.ap_phases = 0
	t.ap_freq = 1
	t.ap_events = nil
	t.loadattempts = 0
	t:ResetEdits()

	if not dontadd then
		table.insert(_songs, t)
	end

	return t
end

net.Receive("FMSongRemoved", function()
	local url = net.ReadString()

	local obj
	for k,v in pairs(_songs) do
		if v.url == url then
			_songs[k] = nil
			obj = v
			break
		end
	end

	if not obj then return end

	hook.Run("FMSongRemoved", obj)
end)

local songsexpected
local songsincoming = {}
net.Receive("FMSendAllSongs", function()
	local isfirstmessage = net.ReadBool()
	if isfirstmessage then
		songsexpected = net.ReadUInt(16)

		timer.Create("FMSongsReceiveTimeout", 30, 1, function()
			printWarn("Songdata receiving timed out! Please rejoin if you want songs to be played.")
			songsexpected = nil
			songsincoming = {}
		end)
	end

	while net.ReadBool() do
		local obj = CreateSongObject(true)
		obj:ReadNetData()
		obj:ResetEdits()

		table.insert(songsincoming, obj)
	end

	local perc
	if songsexpected > 0 then
		perc = math.floor((#songsincoming / songsexpected) * 100)
	else
		perc = 100
	end

	printInfo("Loading songs... (%d%%)", perc)

	if #songsincoming >= songsexpected then
		-- All songs have arrived!!

		printInfo("All songs loaded successfully")

		--Stop current songs
		if GAMEMODE.SongSystem and GAMEMODE.SongSystem.Songs then
			for _,v in pairs(GAMEMODE.SongSystem.Songs) do
				if IsValid(v) then
					v:Stop()
				end
			end
		end

		-- Move over the table
		GAMEMODE.SongSystem = {Songs = songsincoming}
		_songs = GAMEMODE.SongSystem.Songs

		-- Reset receving logic
		songsincoming = {}
		songsexpected = nil
		timer.Remove("FMSongsReceiveTimeout")

		-- Notify others
		hook.Run("FMSongsFullUpdate")
	end
end)

net.Receive("FMSendSongs", function()
	local sent = {}

	for _ = 1, net.ReadUInt(16) do
		local url = net.ReadString()

		table.insert(sent, url)

		local song = GAMEMODE:GetSongByURL(url)
		if song then -- Song already exists, only update it
			local isedited = song:IsEdited()
			song:ReadNetData(true)
			if not isedited then
				song:ResetEdits()
			end

			hook.Run("FMSongUpdate", song)
		else
			song = CreateSongObject()
			song.url = url
			song:ReadNetData(true)
			song:ResetEdits()

			hook.Run("FMSongAdded", song)
		end
	end
end)

net.Receive("FMPlaySong", function()
	local url = net.ReadString()
	GAMEMODE:PlaySongByURL(url)
end)

net.Receive("FMStopSong", function()
	GAMEMODE:StopCurrentSong()
end)

function GM:PlaySong(song)
	local cursong = self:GetCurrentSong()
	if not IsValid(cursong) or song != cursong then
		self:StopCurrentSong()
	end

	song:Play()
end

cvars.AddChangeCallback("fm_music", function(cvar, old, new)
	local num = tonumber(new)
	if num and num == 0 then
		GAMEMODE:StopCurrentSong()
	end
end)

cvars.AddChangeCallback("fm_musiclevel", function(cvar, old, new)
	local num = tonumber(new)
	if num then
		local song = GAMEMODE:GetCurrentSong()
		if not song then return end

		song:SetComputedVolume(num)
	end
end)

timer.Create("FMSongsCheckGameFocus", 0.1, 0, function()
	if usemute:GetBool() == false then GAMEMODE.SongsMuted = false return end

	local song = GAMEMODE:GetCurrentSong()
	if not song then return end

	if GAMEMODE.SongsMuted and system.HasFocus() then
		GAMEMODE.SongsMuted = false

		song:SetComputedVolume()
	elseif not system.HasFocus() and not GAMEMODE.SongsMuted then
		GAMEMODE.SongsMuted = true

		song:SetVolume(0)
	end
end)
