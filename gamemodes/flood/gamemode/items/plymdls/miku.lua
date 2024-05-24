ITEM.CanPlayerBuy = function(self, ply)
	return ply:GetMODTier() >= RANK_DEVELOPER
end