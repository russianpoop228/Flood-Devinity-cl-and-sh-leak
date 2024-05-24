
function SetupLeaderboards(parent, parentw, parenth)
	local topbox = vgui.Create("DPanel", parent)
		topbox.Paint = function()end
		topbox:Dock(TOP)
		topbox:SetTall(22)

	local html
	local filterbox = vgui.Create("DTextEntry", topbox)
		filterbox:SetWide(150)
		filterbox.OnChange = function(self)
			local txt = filterbox:GetValue()
			html:RunJavascript(string.format([[$("#namefilterform input[name='name']").val("%s")]], txt))
		end

	local btn = vgui.Create("DButton", topbox)
		btn:SetPos(155, 0)
		btn:SetSize(50, filterbox:GetTall())
		btn:SetText("Search")
		btn.DoClick = function()
			html:RunJavascript([[$("#namefilterform").submit()]])
		end

	html = vgui.Create( "DHTML", parent )
		html:Dock(FILL)
		html:SetWide(600)
		html:SetScrollbars(false)
		html:SetAllowLua(true)

	parent.Think = function(self)
		if self:IsVisible() then
			html:OpenURL("https://devinity.org/pages/leaderboards/?gm=flood")
			self.Think = function() end
		end
	end
end
