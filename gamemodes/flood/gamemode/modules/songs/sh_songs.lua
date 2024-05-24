
GM.SongSystem = GM.SongSystem or {Songs = {}}
local _songs = GM.SongSystem.Songs

function GM:GetSongs()
	return self.SongSystem.Songs
end

function GM:GetSongByURL(url)
	for _,v in pairs(self:GetSongs()) do
		if v:GetURL() == url then
			return v
		end
	end
end

function GM:GetSongByTitle(title)
	for _,v in pairs(self:GetSongs()) do
		if v:GetTitle() == title then
			return v
		end
	end
end

function GM:GetSongByPartialTitle(title)
	for _,v in pairs(self:GetSongs()) do
		if string.find(v:GetTitle(), title) then
			return v
		end
	end
end

function GM:GetCurrentSong()
	if not self.SongSystem.Current or not self.SongSystem.CurrentEnd then return end
	if self.SongSystem.CurrentEnd <= CurTime() then return end

	return self.SongSystem.Current
end

function GM:StopCurrentSong()
	local song = self:GetCurrentSong()
	if not song then return end

	song:Stop()
end

function GM:PlaySongByURL(url)
	local song = self:GetSongByURL(url)
	if not song then return end

	self:PlaySong(song)
end

function GM:PlaySongByTitle(title)
	local song = self:GetSongByTitle(title)
	if not song then return end

	self:PlaySong(song)
end

function GM:PlaySongByPartialTitle(title)
	local song = self:GetSongByPartialTitle(title)
	if not song then return false end

	self:PlaySong(song)
	return true
end
