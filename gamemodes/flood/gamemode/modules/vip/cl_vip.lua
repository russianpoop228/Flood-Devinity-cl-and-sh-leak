
local disableVIP = CreateConVar("d_disablevip", "0", bit.bor(FCVAR_REPLICATED))

local meta = FindMetaTable("Player")
function meta:GetVIPTier()
	if disableVIP:GetBool() then return 0 end

	local tier = self.fm_viptier or 0
	return math.min(tier, 4)
end
function meta:GetMODTier(getreal)
	if getreal and (self.fm_viptier or 0) == 0 and self.fm_realrank then
		return self.fm_realrank
	end

	return self.fm_viptier or 0
end
function GetTierName(tier, withsuffix)
	if tier == 0 then return "Player" end
	return VIPTiers[tier].name .. (withsuffix and tier <= 4 and " VIP" or "")
end
function GetTierColor( tier )
	if tier == 0 then return FMCOLORS.txt end
	return VIPTiers[tier].color
end

local icons = {"cross",
			"medal_bronze_2", "medal_silver_2", "medal_gold_2", "star",
			"user_female", "user_orange", "user", "user_green", "user_suit", "user_gray"}
function GetTierSilkicon( tier )
	return string.format("icon16/%s.png", icons[tier + 1])
end

function GetTierID( name )
	for k,v in pairs(VIPTiers) do
		if v.name == name then
			return k
		end
	end
end


VIPTiers = {}
function AddVIPTier( name, color )
	table.insert(VIPTiers, {name = name, color = color})
end

net.Receive("FMSendVIPTier", function()
	local ply = net.ReadEntity()
	local tier = net.ReadUInt(4)
	ply.fm_viptier = tier

	if ply == LocalPlayer() then
		hook.Run("FMReceivedVIPTier")
	end
end)

net.Receive("FMSendRealTier", function()
	local ply = net.ReadEntity()
	local tier = net.ReadUInt(4)
	ply.fm_realrank = tier
end)
