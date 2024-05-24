
--[[
Allowedprops
]]
local allowedprops
local function IsPropAllowed( mdl ) return not allowedprops or allowedprops[mdl] end

local function UpdatePropsList()
	local PropsMenuList = g_SpawnMenu.PropsMenuList
	if not PropsMenuList then return end

	for k,v in pairs(PropsMenuList:GetChildren()) do
		if v.ClassName == "SpawnIcon" then
			v:SetDisabled(not IsPropAllowed(v.model))
		end
	end
end

net.Receive("FMSendAllowedProps", function()
	allowedprops = {}
	for i = 1,net.ReadUInt(8) do
		allowedprops[net.ReadString()] = true
	end

	UpdatePropsList()
end)
net.Receive("FMRemoveAllowedProps", function()
	allowedprops = nil
	UpdatePropsList()
end)

--[[
Prop price multiplier
]]
local curmul = 1
local function updatePropTooltips()
	local PropsMenuList = g_SpawnMenu.PropsMenuList

	for k,v in pairs(PropsMenuList:GetChildren()) do
		if v.ClassName == "SpawnIcon" then
			v:UpdateTooltip()
		end
	end
end

net.Receive("FMSetPropPriceMultiplier", function()
	curmul = net.ReadDouble()

	for k,v in pairs(SpawnableProps) do
		SpawnableProps[k].price = math.floor(v.origprice * curmul)
	end

	updatePropTooltips()
end)

--[[
Scramble event
]]

local scramble
local ScrambledProps
net.Receive("FMSetScrambleHealth", function()
	scramble = net.ReadBool()
	if scramble then
		ScrambledProps = {}
		for i = 1,net.ReadUInt(8) do
			ScrambledProps[net.ReadString()] = {
				newhealth = net.ReadUInt(16),
				oldhealth = net.ReadUInt(16)
			}
		end

		for mdl,v in pairs(ScrambledProps) do
			SpawnableProps[mdl].health = v.newhealth
		end
	elseif ScrambledProps then
		for mdl,v in pairs(ScrambledProps) do
			SpawnableProps[mdl].health = v.oldhealth
		end
	end

	updatePropTooltips()
end)

local PopulatePropsMenu

--[[
Favorites
]]
local favconv = CreateClientConVar("fm_favoriteprops", "")
local function GetFavorites()
	local str = favconv:GetString()
	local t = {}
	for _, v in pairs(string.Explode(";", str)) do
		if tonumber(v) then
			t[tonumber(v)] = true
		end
	end

	return t
end

local function SaveFavorites(t)
	local tbl = {}
	PrintTable(t)
	for prop, v in pairs(t) do
		tbl[#tbl + 1] = prop
	end
	favconv:SetString(table.concat(tbl, ";"))
end

local function SetFavorite(propid, add)
	local favs = GetFavorites()

	if tobool(favs[propid]) == add then return end

	if add then
		favs[propid] = true
	else
		favs[propid] = nil
	end

	SaveFavorites(favs)
	PopulatePropsMenu()
end

local function IsFavorite(propid)
	return tobool(GetFavorites()[propid])
end

--[[
]]
local function getOrderedProps()
	-- Create lookup table of the props to allow us to sort them
	local lookup = {}
	for k, v in pairs(SpawnableProps) do
		local t = {
			mdl = k,
			isfav = IsFavorite(v.id),
			cat = v.cat,
			propindex = v.propindex,
		}

		if t.isfav then
			t.cat = "Favorites"
		end

		lookup[#lookup + 1] = t
	end

	-- Sort the props
	table.sort(lookup, function(a, b)
		-- Push favorites up
		if a.isfav != b.isfav then
			return a.isfav
		end

		-- Sort asc alphabetically by category
		if a.cat != b.cat then
			return a.cat < b.cat
		end

		-- Sort by propindex (order)
		return a.propindex < b.propindex
	end)

	-- Shove the props into a category structure
	local cats = {}
	local curcattbl
	local curcatname
	for _, v in pairs(lookup) do
		if not curcatname or v.cat != curcatname then
			curcatname = v.cat
			local catname = string.gsub(v.cat, "(%d+% %-% )", "") -- Strip the order prefix

			curcattbl = {
				cat = catname,
				props = {}
			}

			cats[#cats + 1] = curcattbl
		end

		curcattbl.props[#curcattbl.props + 1] = v.mdl
	end

	return cats
end

function PopulatePropsMenu()
	local PropsMenuList = g_SpawnMenu.PropsMenuList
	PropsMenuList:Clear()

	for _, catt in ipairs(getOrderedProps()) do
		local header = vgui.Create("ContentHeader")
			header:SetText(catt.cat)
			header.DoDoubleClick = function() end
			header.DoClick = function() end
			header.DoRightClick = function() end
		PropsMenuList:Add(header)

		for _, mdl in pairs(catt.props) do
			local Prop = vgui.Create("SpawnIcon")
				Prop:SetModel(mdl)
				Prop.model = mdl
				Prop.id = SpawnableProps[mdl].id
				Prop.UpdateTooltip = function(this)
					local tooltip = {}
					local t = SpawnableProps[mdl]
					table.insert(tooltip, t.name)
					if #t.desc > 0 then
						table.insert(tooltip, "")

						surface.SetFont("Default")
						local desc = string.WordWrap(t.desc, 150)
						table.insert(tooltip, desc)
					end
					table.insert(tooltip, "")
					table.insert(tooltip, ("Health: %i"):format(t.health))
					table.insert(tooltip, ("Cost: %s"):format(FormatMoney(t.price)))
					table.insert(tooltip, ("Floating: %s"):format(TranslateFloat(t.float)))
					if t.limit > 0 then
						table.insert(tooltip, ("Limit: %i"):format(t.limit))
					else
						table.insert(tooltip, "Limit: ∞")
					end

					if IsValid(LocalPlayer()) and LocalPlayer():IsAdmin() then
						local tagstbl = {}
						for tag,_ in pairs(t.tags) do
							table.insert(tagstbl, tag)
						end
						local tagsstr = table.concat(tagstbl, ";")
						table.insert(tooltip, ("Tags: %s"):format(tagsstr))

						table.insert(tooltip, ("Prop ID: %i"):format(t.id))
					end

					this:SetTooltip(table.concat(tooltip, "\n"))
				end
				Prop.DoClick = function()
					surface.PlaySound("ui/buttonclickrelease.wav")

					net.Start("FMSpawnProp")
						net.WriteString(mdl)
					net.SendToServer()
				end
				Prop.DoRightClick = function()
					local men = DermaMenu()
					local t = SpawnableProps[mdl]

					if IsFavorite(t.id) then
						men:AddOption("Remove from favorites", function()
							SetFavorite(t.id, false)
						end)
					else
						men:AddOption("Add to favorites", function()
							SetFavorite(t.id, true)
						end)
					end

					men:Open()
				end
				local old = Prop.PaintOver
				Prop.PaintOver = function(_, w, h)
					old(Prop, w, h)

					if Prop:GetDisabled() then
						draw.RoundedBox(4,1,1,62,62,Color(0,0,0,200))
					end

					local price = SpawnableProps[mdl].price
					if not LocalPlayer():CanAfford(price) then
						draw.RoundedBox(4,1,1,62,62,Color(150,0,0,100))
					end

					local cnt = GetPerPropCount(Prop.id)
					if cnt > 0 then
						draw.SimpleTextOutlined(cnt, "Default", 4, 2, FMCOLORS.txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, FMCOLORS.bg)
					end

					local t = SpawnableProps[mdl]
					if Prop:IsHovered() then
						draw.SimpleTextOutlined("$" .. t.price, "Default", 4, h - 4, FMCOLORS.txt, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, FMCOLORS.bg)
					end
				end
				Prop:UpdateTooltip()
			PropsMenuList:Add(Prop)
		end
	end

	UpdatePropsList()
end

function SetupProps(parent, parentw, parenth)
	local PropsMenuList = vgui.Create("DTileLayout", parent)
		PropsMenuList:SetBaseSize(64)
		PropsMenuList:SetSize((parentw - 10) - 15, parenth)

	g_SpawnMenu.PropsMenuList = PropsMenuList
end

SpawnableProps = SpawnableProps or {}
net.Receive("FMSendPropDefinitions", function()
	SpawnableProps = {}
	for _ = 1,net.ReadUInt(8) do
		SpawnableProps[net.ReadString()] = {
			cat = net.ReadString(),
			id = net.ReadUInt(8),
			propindex = net.ReadUInt(8),
			name = net.ReadString(),
			desc = net.ReadString(),
			float = net.ReadInt(4),
			health = net.ReadUInt(16),
			limit = net.ReadUInt(8),
			origprice = net.ReadUInt(16),
			price = net.ReadUInt(16),
			tags = util.JSONToTable(net.ReadString())
		}
	end

	PopulatePropsMenu()
end)

local propscnt = 0
function GetPropCount()
	return propscnt
end

local maxprops = 0
function GetMaxProps()
	return maxprops
end

local perpropcounttbl = {}
function GetPerPropCount(id)
	return perpropcounttbl[id] or 0
end

net.Receive("FMSendPropCountData", function(len)
	propscnt = net.ReadUInt(8)
	maxprops = net.ReadUInt(8)

	perpropcounttbl = {}
	local propsam = (len - 8 - 8) / (16 + 8)
	for i = 1, propsam do
		perpropcounttbl[net.ReadUInt(16)] = net.ReadUInt(8)
	end
end)

hook.Add("FMReceivedVIPTier", "ReloadPropList", function()
	PopulatePropsMenu()
end)

hook.Add("FMReloadSpawnIcons", "ReloadPropIcons", function()
	local PropsMenuList = g_SpawnMenu.PropsMenuList
	if PropsMenuList then
		for _, v in pairs(PropsMenuList:GetChildren()) do
			if v and v.RebuildSpawnIcon then
				v:RebuildSpawnIcon()
			end
		end
		printInfo("Prop icons reloaded.")
	else
		printInfo("Prop icons not reloaded")
	end
end)

hook.Add("FMOnReloaded", "ResendPropsPlease", function()
	net.Start("FMPropsReloaded")
	net.SendToServer()
end)
