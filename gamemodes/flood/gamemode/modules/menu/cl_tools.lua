
local function CreateLookup(tbl, varname)
	local newtbl = {}
	for k,v in pairs(tbl) do
		if varname then
			newtbl[v[varname]] = k
		else
			newtbl[v] = k
		end
	end
	return newtbl
end

local function OverrideGetTools()
	--Here we're replacing spawnmenu.GetTools() in order for it to only show the tools that we want.
	--We also remove any Utilites tab that garrysmod wants to put in.
	local spawnmenutools = spawnmenu.GetTools()[1]
	local newtools = {
		[1] = {
			Icon = spawnmenutools.Icon,
			Name = spawnmenutools.Name,
			Label = spawnmenutools.Label,
			Items = {}
		}
	}

	local Tools = CreateLookup(VisibleTools)
	for catnum,catt in ipairs(spawnmenutools.Items) do
		local newcat = {
			ItemName = catt.ItemName,
			Text = catt.Text
		}

		for toolnum,toolt in ipairs(catt) do
			if not istable(toolt) or Tools[toolt.ItemName] then
				table.insert(newcat, toolt)
			end
		end

		if #newcat > 0 then
			table.insert(newtools[1].Items, newcat)
		end
	end
	spawnmenu.GetTools = function() return newtools end
end

function SetupTools(parent, parentw, parenth)
	OverrideGetTools()

	local toolsbasepnl = vgui.Create( "ToolPanel", parent )
		toolsbasepnl:Dock(FILL)
		toolsbasepnl:DockMargin(0,0,0,0)
		toolsbasepnl:SetTabID( 1 )
		toolsbasepnl:LoadToolsFromTable( spawnmenu.GetTools()[1].Items )

	MENU.FMToolMenu.GetToolPanel = function(self,id)
		return toolsbasepnl
	end
end
