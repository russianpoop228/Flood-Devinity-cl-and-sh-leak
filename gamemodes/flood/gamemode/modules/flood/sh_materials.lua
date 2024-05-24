
hook.Add("Initialize", "Override materials", function()
	local unwanted = {
		["models/effects/comball_sphere"] = true,
		["models/effects/comball_tape"] = true,
		["models/effects/splodearc_sheet"] = true,
		["models/effects/vol_light001"] = true,
		["models/props_combine/portalball001_sheet"] = true,
		["models/props_combine/stasisshield_sheet"] = true,
		["models/props_lab/tank_glass001"] = true,
		["models/rendertarget"] = true,
		["models/screenspace"] = true,
		["models/wireframe"] = true,
		["models/xqm/lightlinesred_tool"] = true,
		["models/props/cs_assault/moneywrap"] = true,
		["models/shadertest/shader3"] = true,
		["models/props_combine/tprings_globe"] = true,
		["models/shadertest/shader4"] = true,
		["models/props_c17/frostedglass_01a"] = true,
		["models/props_combine/com_shield001a"] = true,
	}
	local t = list.GetForEdit("OverrideMaterials")

	local k = 1
	while k <= #t do
		if unwanted[string.lower(t[k])] then
			table.remove(t,k)
		else
			k = k + 1
		end
	end

	if not IsMounted("tf") then
		list.Add( "OverrideMaterials", "models/player/shared/gold_player" )
		list.Add( "OverrideMaterials", "models/player/shared/ice_player" )
	end

	list.Add("OverrideMaterials", "custom/rainbow")
	list.Add("OverrideMaterials", "models/dav0r/hoverball")
	list.Add("OverrideMaterials", "models/props/cs_assault/dollar")
	list.Add("OverrideMaterials", "models/props/cs_office/snowmana")
	list.Add("OverrideMaterials", "models/props/de_nuke/pipeset_metal")
	list.Add("OverrideMaterials", "models/props_c17/metalladder001")
	list.Add("OverrideMaterials", "models/props_canal/metalcrate001d")
	list.Add("OverrideMaterials", "models/props_canal/metalwall005b")
	list.Add("OverrideMaterials", "models/props_pipes/pipemetal001a")
	list.Add("OverrideMaterials", "models/props_wasteland/metal_tram001a")
	list.Add("OverrideMaterials", "models/props_wasteland/quarryobjects01")
	list.Add("OverrideMaterials", "models/props_wasteland/tugboat01")
	list.Add("OverrideMaterials", "models/xqm/woodplanktexture")
	list.Add("OverrideMaterials", "phoenix_storms/fender_chrome")
	list.Add("OverrideMaterials", "watermelon")
	list.Add("OverrideMaterials", "warcamo01")
	list.Add("OverrideMaterials", "warcamo02")
	list.Add("OverrideMaterials", "warcamo03")
	list.Add("OverrideMaterials", "warcamo04")
	list.Add("OverrideMaterials", "warcamo05")
	list.Add("OverrideMaterials", "warcamo06")
	list.Add("OverrideMaterials", "warcamo07")
	list.Add("OverrideMaterials", "warcamo08")
	list.Add("OverrideMaterials", "warmetal01")
	list.Add("OverrideMaterials", "warmetal02")
	list.Add("OverrideMaterials", "warmetal03")
	list.Add("OverrideMaterials", "monalisa")
	list.Add("OverrideMaterials", "hell_stone1")
	list.Add("OverrideMaterials", "hell_stone2")
end)
