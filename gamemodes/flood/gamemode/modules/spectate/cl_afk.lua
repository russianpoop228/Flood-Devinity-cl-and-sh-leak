

local showhudconv = GetConVar("fm_showhud")
hook.Add("HUDPaint","AFK", function()
	if showhudconv:GetBool() == false then return end

	if LocalPlayer():GetNWBool("roundspec", false) then
		DrawBlinkingText("You're currently spectating", ScrW() / 2, 200)
	end
end)
