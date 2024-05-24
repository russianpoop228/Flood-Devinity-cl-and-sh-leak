

--[[
Muting convar thing
]]
local muteconvar = CreateClientConVar("fm_mutebydefault", 0, true, false)
AddSettingsItem("flood", "checkbox", "fm_mutebydefault", {lbl = "Mute non-admins by default"})
hook.Add("OnEntityCreated", "MuteByDefault", function(ply)
	if muteconvar:GetBool() == false then return end

	if not ply:IsPlayer() then return end

	--Some delay to make sure IsAdmin gets networked properly
	timer.Simple(20, function()
		if not IsValid(ply) then return end
		if not ply:IsAdmin() then ply:SetMuted(true) end
	end)
end)

hook.Add("InitPostEntity", "MuteByDefault", function()
	if muteconvar:GetBool() == false then return end

	timer.Simple(20, function()
		for k,v in pairs(player.GetAll()) do
			if not v:IsAdmin() and v != LocalPlayer() then
				v:SetMuted(true)
			end
		end
	end)
end)


--[[
Voice stuff
]]
local PlayerVoicePanels = {}
PANEL = {}
function PANEL:Init()
	self.LabelName = vgui.Create( "DLabel", self )
	self.LabelName:SetFont( "GModNotify" )
	self.LabelName:Dock( FILL )
	self.LabelName:DockMargin( 8, 0, 0, 0 )
	self.LabelName:SetTextColor( Color( 255, 255, 255, 255 ) )

	self.Avatar = vgui.Create( "AvatarImage", self )
	self.Avatar:Dock( LEFT );
	self.Avatar:SetSize( 32, 32 )
	self.Avatar.UpdateAvatar = function(av)
		if self.ply.customname then
			av:SetSteamID(self.ply.fakesteamid, 16)
		else
			av:SetPlayer(self.ply)
		end
	end

	self.Color = color_transparent

	self:SetSize( 250, 32 + 8 )
	self:DockPadding( 4, 4, 4, 4 )
	self:DockMargin( 2, 2, 2, 2 )
	self:Dock( BOTTOM )
	self.isteam = false
end
function PANEL:Paint(w, h)
	if ( !IsValid( self.ply ) ) then return end

	draw.RoundedBox( 4, 0, 0, w, h, Color( 0, self.ply:VoiceVolume() * 255, 0, 240 ) )

	if self.isteam then
		draw.SimpleText( "Team", "GModNotify", 4, 11, color_white, 0, 0 )
	end
end
function PANEL:Setup(ply)
	self.ply = ply
	self.LabelName:SetText( ply:FilteredNick() )
	self.Color = team.GetColor( ply:Team() )

	self.LastHiddenName = ply.customname
	self.Avatar:UpdateAvatar()

	self:InvalidateLayout()

	self.isteam = ply:GetNWBool("teamchat",false)
end
function PANEL:Think()
	if self.fadeAnim then
		self.fadeAnim:Run()
	end

	if not IsValid(self.ply) then return true end

	if self.ply.customname != self.LastHiddenName then
		self.LastHiddenName = self.ply.customname
		self.Avatar:UpdateAvatar()
	end

	if self.ply:GetNWBool("teamchat",false) == true and self.ply:CTeam() then
		self.isteam = true
		self:InvalidateLayout()
	else
		self.isteam = false
	end
end
function PANEL:PerformLayout()
	if self.isteam then
		local x,y = self:GetPos()
		self:SetPos( 0, y )
		self:SetSize( 300, 32 + 8 )
		self:DockPadding( 4 + 50, 4, 4, 4 )
	else
		local x,y = self:GetPos()
		self:SetPos(50, y)
		self:SetSize( 250, 32 + 8 )
		self:DockPadding( 4, 4, 4, 4 )
	end
end
function PANEL:FadeOut( anim, delta, data )

	if ( anim.Finished ) then

		if ( IsValid( PlayerVoicePanels[ self.ply ] ) ) then
			PlayerVoicePanels[ self.ply ]:Remove()
			PlayerVoicePanels[ self.ply ] = nil
			return
		end

	return end

	self:SetAlpha( 255 - (255 * delta) )

end
derma.DefineControl( "FMVoiceNotify", "", PANEL, "DPanel" )

function GM:PlayerStartVoice( ply )
	if ( not IsValid( g_VoicePanelList ) ) then return end

	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )

	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then
		if ( PlayerVoicePanels[ ply ].fadeAnim ) then
			PlayerVoicePanels[ ply ].fadeAnim:Stop()
			PlayerVoicePanels[ ply ].fadeAnim = nil
		end
		PlayerVoicePanels[ ply ]:SetAlpha( 255 )
		return;
	end
	if ( !IsValid( ply ) ) then return end

	local pnl = g_VoicePanelList:Add( "FMVoiceNotify" )
	pnl:Setup( ply )

	PlayerVoicePanels[ ply ] = pnl
end
local function VoiceClean()
	for k, v in pairs( PlayerVoicePanels ) do
		if ( not IsValid( k ) ) then
			GAMEMODE:PlayerEndVoice( k )
		end
	end
end
timer.Create( "VoiceClean", 10, 0, VoiceClean )
function GM:PlayerEndVoice( ply )
	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then
		if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end
		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 2 )
	end
end
local function CreateVoiceVGUI()
	g_VoicePanelList = vgui.Create( "DPanel" )
	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( ScrW() - 300, 100 )
	g_VoicePanelList:SetSize( 300, ScrH() - 200 )
	g_VoicePanelList:SetDrawBackground( false )
end
hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )

--[[
Chat Stuff
]]
local contentfilter = CreateClientConVar("fm_contentfilter", 1, true, false)
AddSettingsItem("flood", "checkbox", "fm_contentfilter", {lbl = "Mature content filter"})

function GM:OnPlayerChat( ply, strText, teamchat, bPlayerIsDead )
	local tab = {}

	if IsValid(ply) then
		local isachat = #strText > 0 and strText[1] == "@"
		if isachat then
			strText = strText:sub(2) -- remove "@"

			table.insert(tab, Color(198, 0, 255))
			table.insert(tab, "[ACHAT] ")
		end

		if bPlayerIsDead then
			table.insert(tab, Color(255, 30, 40))
			table.insert(tab, "*DEAD* ")
		end

		if not isachat and ply:CTeam() and teamchat then
			table.insert(tab, ply:CTeam():GetColor())
			table.insert(tab, "[TEAM] ")
		end

		if ply:GetMODTier() > 0 then
			local tier = ply:GetMODTier()

			table.insert(tab, GetTierColor(tier))
			table.insert(tab, string.format("[%s] ", GetTierName(tier)))
		end

		table.insert(tab, ply)
	else
		table.insert(tab, "Console")
	end

	table.insert(tab, ": ")
	table.insert(tab, (IsValid(ply) and bPlayerIsDead and not ply:IsMod()) and Color(197,127,255) or Color(255, 255, 255))

	if strText and #strText > 0 and contentfilter:GetBool() == true then -- Filter offensive chat
		local word, a, b, replace, lower
		local i = 1
		while i < GetBlacklistCount() do
			lower = strText:lower()
			word = GetWordBlacklist()[i]
			a,b = lower:find(word) -- find it lower case
			if not (a and b) then
				i = i + 1
			else
				replace = string.sub(strText, a, b) -- grab the actual casing
				strText = string.gsub(strText, replace, ("*"):rep(word:len())) -- replace it
			end
		end
	end

	table.insert( tab, strText )

	chat.AddText( unpack(tab) )

	return true
end

net.Receive("FMSendChatPrint", function()
	local txt = net.ReadString()
	local iscol = net.ReadBit() == 1
	local col = FMCOLORS.txt
	if iscol then
		col = Color(net.ReadUInt(8),net.ReadUInt(8),net.ReadUInt(8))
	end

	chat.AddText(col, txt)
end)
