

if FMIsMapCanals() then
	/*
	Draw asphalt on top of the map, easier predator navigating among other reasons
	*/
	local groundmat = Material("fm/road")

	local offset = 400
	local mxmin, mxmax, mymin, mymax = -1420, 1352, -1875, 1264
	local quads = {
		{xmin = -1420, xmax = 1352, ymin = -608, ymax = -256, z = 1856},
		{xmin = mxmin - offset, xmax = mxmin, ymin = mymin - offset, ymax = mymax, z = 1856},
		{xmin = mxmax, xmax = mxmax + offset, ymin = mymin, ymax = mymax + offset, z = 1856},
		{xmin = mxmin, xmax = mxmax + offset, ymin = mymin - offset, ymax = mymin, z = 1856},
		{xmin = mxmin - offset, xmax = mxmax, ymin = mymax, ymax = mymax + offset, z = 1856},
	}

	local quadverts = {}
	local uvscale = 200
	for k,v in pairs(quads) do

		quadverts[k] = {
			{Vector(v.xmin, v.ymin, v.z), v.xmin / uvscale, v.ymin / uvscale},
			{Vector(v.xmin, v.ymax, v.z), v.xmin / uvscale, v.ymax / uvscale},
			{Vector(v.xmax, v.ymax, v.z), v.xmax / uvscale, v.ymax / uvscale},
			{Vector(v.xmax, v.ymin, v.z), v.xmax / uvscale, v.ymin / uvscale},
		}
	end
	hook.Add("PostDrawTranslucentRenderables", "FMMapSpecifics", function()
		render.SuppressEngineLighting(true)
		for _, v in pairs(quadverts) do
			render.SetMaterial(groundmat)

			mesh.Begin(MATERIAL_QUADS, 1)
			for i = 1, 4 do
				mesh.Position(v[i][1])
				mesh.TexCoord(0, v[i][2], v[i][3])
				mesh.Normal(Vector(0,0,1))
				mesh.Color(255,255,255,255)
				mesh.AdvanceVertex()
			end
			mesh.End()
		end
		render.SuppressEngineLighting(false)
	end)
end
