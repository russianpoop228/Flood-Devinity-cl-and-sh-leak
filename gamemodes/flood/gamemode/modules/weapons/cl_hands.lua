
function GM:PostDrawViewModel( ViewModel, ply, Weapon )
	if not IsValid( Weapon ) then return false end

	ply = (IsValid(Weapon) and IsValid(Weapon:GetOwner())) and Weapon:GetOwner() or ply

	if Weapon.UseHands or not Weapon:IsScripted() then

		local hands = ply:GetHands()
		if IsValid( hands ) then
			hands:DrawModel()
		end

	end

	player_manager.RunClass( ply, "PostDrawViewModel", ViewModel, Weapon )

	if Weapon.PostDrawViewModel == nil then return false end
	return Weapon:PostDrawViewModel( ViewModel, Weapon, ply )
end
