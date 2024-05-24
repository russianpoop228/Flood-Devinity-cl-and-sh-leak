
--[[
FMAvatar
An avatar panel.
]]

PANEL = {}
AccessorFunc(PANEL, "m_fallback", "FallbackURL", FORCE_STRING)
function PANEL:Init()
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(false)

	self:SetAllowLua(false)
	self:SetScrollbars(false)

	self.isloading = true
	self.curply = nil

	self:SetFallbackURL("devinity.org/flood/avatar.jpg")
end

function PANEL:Paint(w,h)
	if self.isloading or self:IsLoading() then
		draw.SimpleText("Loading .. ", "FMRegular24", w/2, h/2, FMCOLORS.txt, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		return true
	end
end
function PANEL:Think()
	if self.urlset and not self:IsLoading() then
		self.urlset = false
		self:OnFinishedLoading()
	end

	if IsValid(self.curply) then
		local sid = game.SinglePlayer() and "76561197993138946" or self.curply:SteamID64()
		if self.curply.fakesteamid then
			sid = self.curply.fakesteamid
		end
		if self.lastsid and self.lastsid != sid then
			self.lastsid = sid
			self:SetPlayerSID(sid)
		end
	end
end

--For overriding
--Called when the avatar has loaded and is displayed.
function PANEL:OnFinishedLoading()
end

--Sets this panels avatar to the avatar of this steamid64.
function PANEL:SetPlayerSID(sid)
	self.isloading = true

	local url = string.format("devinity.org/steamapi.php?avatar=true&steamid=%s", sid)
	local function setimg(url)
		-- print("setting avatar url: " .. url)
		self.urlset = true
		self:OpenURL(url:gsub("https://", ""))
		self.isloading = false
	end

	http.Fetch(url,
	function(html)
		if not html or (#html < 10) then setimg(self:GetFallbackURL()) return end
		setimg(html)
	end,
	function()
		setimg(self:GetFallbackURL())
	end)
end

--Sets this panels avatar to the avatar of this player.
function PANEL:SetPlayer(ply)
	self.curply = ply
	self.lastsid = game.SinglePlayer() and "76561197993138946" or ply:SteamID64()

	if ply.fakesteamid then
		self.lastsid = ply.fakesteamid
	end

	self:SetPlayerSID(self.lastsid)
end
derma.DefineControl("FMAvatar", "", PANEL, "DHTML")
