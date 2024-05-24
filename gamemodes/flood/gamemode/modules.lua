
--[[
Topological sort "tsort" library
https://github.com/bungle/lua-resty-tsort
Used to generate the dependency load order
]]
local setmetatable = setmetatable
local pairs = pairs
local type = type
local function visit(k, n, m, s)
	if m[k] == 0 then return 1 end
	if m[k] == 1 then return end
	m[k] = 0
	local f = n[k]
	for i = 1, #f do
		if visit(f[i], n, m, s) then return 1 end
	end
	m[k] = 1
	s[#s + 1] = k
end
local tsort = {}
tsort.__index = tsort
function tsort.new()
	return setmetatable({
		n = {}
	}, tsort)
end
function tsort:add(...)
	local p = {...}
	local c = #p
	if c == 0 then return self end
	if c == 1 then
		p = p[1]

		if type(p) == "table" then
			c = #p
		else
			p = {p}
		end
	end
	local n = self.n
	for i = 1, c do
		local f = p[i]

		if n[f] == nil then
			n[f] = {}
		end
	end
	for i = 2, c do
		local f = p[i]
		local t = p[i - 1]
		local o = n[f]
		o[#o + 1] = t
	end
	return self
end
function tsort:sort()
	local n = self.n
	local s = {}
	local m = {}
	for k in pairs(n) do
		if m[k] == nil then
			if visit(k, n, m, s) then
				local involved = {}
				for name, flag in pairs(m) do
					if flag == 0 then involved[#involved + 1] = name end
				end

				return nil, "There is a circular dependency in the graph. Nodes involved: " .. table.concat(involved, ", ")
			end
		end
	end
	return s
end

--[[
Module system
]]
local clr = SERVER and HSVToColor(200, 0.63, 0.8) or HSVToColor(58, 0.63, 0.8)
local function sortLoadOrder(modules)
	local graph = tsort.new()
	for _, mod in ipairs(modules) do
		graph:add(mod.name)
		for dep, _ in pairs(mod.dependencies) do
			graph:add(mod.name, dep)
		end
	end

	local loadOrder, err = graph:sort()
	if not loadOrder then
		MsgC(clr, "[FM] ", Color(230, 100, 100), string.format("Failed to determine the load order: %s\n", err))
		return false
	end

	local lookupLoadOrder = {}
	for pos, name in ipairs(loadOrder) do
		lookupLoadOrder[name] = pos
	end

	table.sort(modules, function(a, b)
		return lookupLoadOrder[a.name] > lookupLoadOrder[b.name]
	end)

	return true
end

function GM:LoadModules()
	MsgC(clr, "[FM] ", Color(230, 230, 230), "Loading modules...\n")

	local modules = {}

	--[[
	Load in all module files
	]]
	local folder = self.FolderName
	local _, dirs = file.Find(folder .. "/gamemode/modules/*", "LUA")
	for _, mod in pairs(dirs) do
		local modul = {
			name = mod,
			dependencies = {},
			noinclude = {},
			files = {
				send = {},
				inc = {},
			}
		}

		local deffile = folder .. "/gamemode/modules/" .. mod .. "/_module.lua"
		if file.Exists(deffile, "LUA") then
			DEPENDENCIES = {}
			NOINCLUDE = {}
			if SERVER then AddCSLuaFile(deffile) end
			include(deffile)
			modul.dependencies = DEPENDENCIES
			modul.noinclude = NOINCLUDE
		end

		local files, _ = file.Find(folder .. "/gamemode/modules/" .. mod .. "/*.lua", "LUA")
		for _, f in pairs(files) do
			if f == "_module.lua" then continue end

			local iscl = f:match("^cl_") != nil
			local issh = f:match("^sh_") != nil
			local issv = f:match("^sv_") != nil

			if not iscl and not issh and not issv then
				Msg(string.format("File %s ignored", f))
			end

			local fullpath = string.format("%s/gamemode/modules/%s/%s", folder, mod, f)

			-- Add to includes
			if not modul.noinclude[f] then
				if SERVER then
					if issh or issv then
						table.insert(modul.files.inc, fullpath)
					end
				else
					if iscl or issh then
						table.insert(modul.files.inc, fullpath)
					end
				end
			end

			-- Add to sends
			if SERVER then
				if iscl or issh then
					table.insert(modul.files.send, fullpath)
				end
			end
		end

		-- Sort files so that shared files are included first
		table.sort(modul.files.inc, function(a, b)
			local aIsSH = a:match(".+/gamemode/modules/.+/([a-z]+)_.+") == "sh"
			local bIsSH = b:match(".+/gamemode/modules/.+/([a-z]+)_.+") == "sh"

			if aIsSH != bIsSH then
				return aIsSH
			end

			return a < b
		end)

		table.insert(modules, modul)
	end

	--[[
	Sort load order by dependencies
	]]
	local success = sortLoadOrder(modules)
	if not success then return end

	--[[
	Do the actual loading
	]]
	local loadedmodules = {}
	for _, modul in ipairs(modules) do
		MsgC(clr, "[FM] ", Color(230, 230, 230), string.format("Loading module %s ", modul.name))

		local skip = false
		for dependency, _ in pairs(modul.dependencies) do
			if not loadedmodules[dependency] then
				MsgC(Color(230, 100, 100), string.format("FAILED: dependency %q missing", dependency))
				MsgN()
				skip = true
				break
			end
		end
		if skip then continue end

		MsgN()

		for _, filepath in ipairs(modul.files.send) do
			AddCSLuaFile(filepath)
		end

		for _, filepath in ipairs(modul.files.inc) do
			include(filepath)
		end

		loadedmodules[modul.name] = true
	end
end
(GM or GAMEMODE):LoadModules()
