
function GM:OpenEscapeMenu()
	if not IsValid(self.EscapeMenu) then
		self.EscapeMenu = vgui.Create("FMEscapeMenu")
	elseif self.EscapeMenu:IsVisible() then
		return
	end

	self.EscapeMenu:Open()
end
concommand.Add("fm_openescapemenu", function() GAMEMODE:OpenEscapeMenu() end)

-- This does the actual overriding of the legacy menu with our
local consolekey
hook.Add("Think", "FMEscapeMenu", function()
	if gui.IsGameUIVisible() then
		if not consolekey then consolekey = input.GetKeyCode(input.LookupBinding( "toggleconsole" )) end
		if consolekey and consolekey > 0 and input.IsKeyDown(consolekey) then FMBypassEscapeMenu() return end -- Allow console opening

		if not GAMEMODE.ForceLegacyMainMenu then
			gui.HideGameUI()
			GAMEMODE:OpenEscapeMenu()
		end
	end
end)

-- If you want to run some action that requires the legacy escape menu, run that action in a function supplied to this function
-- That will prevent us from immediately closing the legacy escape menu
function FMBypassEscapeMenu(func)
	GAMEMODE.ForceLegacyMainMenu = true
	if func then func() end
	timer.Create("FMEscapeWaitForLegacyClose", 0.1, 0, function()
		if not gui.IsGameUIVisible() then
			GAMEMODE.ForceLegacyMainMenu = false
			timer.Remove("FMEscapeWaitForLegacyClose")
		end
	end)
end

-- Allow force open specific tab
function GM:EscapeMenuForceOpenTab(tab)
	self:OpenEscapeMenu()
	self.EscapeMenu:OpenTab(tab)
end
net.Receive("FMEscapeMenuForceOpenTab", function()
	GAMEMODE:EscapeMenuForceOpenTab(net.ReadString())
end)

-- Automatically destroy any escape menu on reload
local function removeEscapeMenu()
	local g = GAMEMODE or GM
	if IsValid(g.EscapeMenu) then
		g.EscapeMenu:Remove()
		g.EscapeMenu = nil
	end
end
hook.Add("FMOnReloaded", "FMEscapeMenu", removeEscapeMenu)
removeEscapeMenu()

-- gui.OpenURL depends on the legacy main menu so we need to bypass our menu
OLDGUIOPENURL = OLDGUIOPENURL or gui.OpenURL
function gui.OpenURL(url)
	FMBypassEscapeMenu(function()
		OLDGUIOPENURL(url)
	end)
end

-- Hide some stuff when escape menu is open
local hide = {
	["CHudGMod"] = true,
	["CHudCrosshair"] = true,
	["CHudChat"] = true,
}
hook.Add("HUDShouldDraw", "FMEscapeMenu", function(name)
	if hide[name] then
		if IsValid(GAMEMODE.EscapeMenu) and GAMEMODE.EscapeMenu:IsVisible() then
			return false
		end
	end
end)
