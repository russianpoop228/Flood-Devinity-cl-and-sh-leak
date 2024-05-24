
VOTES = {}

local VOTE_ARGTYPE_LIST = 0
local VOTE_ARGTYPE_INPUT = 1

local listtypes = {
	players = function()
		local t = {}
		for k,v in pairs(player.GetAll()) do
			t[k] = {v:Nick(), v:UserID()}
		end
		return t
	end,
	events = function()
		local t = {}
		for k, v in pairs(EVENTS) do
			t[k] = {v.Name, k}
		end
		return t
	end
}

local combboxchooseoption = function( self, value, index )
	if ( self.Menu ) then
		self.Menu:Remove()
		self.Menu = nil
	end

	self:SetText( value )

	self.selected = index
	self:OnSelect( index, value, self.Data[index] )
end
local combboxgetselected = function( self )
	if ( !self.selected ) then return end

	return self:GetOptionText(self.selected), self:GetOptionData(self.selected)
end

local pnllist
local function Update()
	if not VOTES or not pnllist then return end
	pnllist:Clear()
	for k,v in SortedPairsByMemberValue(VOTES, "tier") do
		local btn = vgui.Create("DButton")
			btn:SetTall(40)
			btn:SetFont("Trebuchet24")
			btn:SetText(v.text)
			btn.Paint = function(self,w,h)
				if self.Hovered then
					derma.GetDefaultSkin().tex.Panels.Bright(0, 0, w, h, FMCOLORS.txt)
				else
					derma.GetDefaultSkin().tex.Panels.Dark(0, 0, w, h, color_white)
				end
			end
			btn.DoClick = function()
				if LocalPlayer():GetVIPTier() < v.tier then
					HintError("You need to be " .. GetTierName(v.tier, true) .. " to start this vote!")
					return
				end

				local i = 0
				local finalargs = {}
				local function cont()
					if i == #v.args then
						RunConsoleCommand("_startvote", v.id, unpack(finalargs))
						return
					end

					i = i + 1

					local curarg = v.args[i]
					if curarg.typ == VOTE_ARGTYPE_LIST then
						local popup = vgui.Create("DFrame")
							popup:SetSize(250, 90)
							popup:Center()
							popup:SetSizable(true)
							popup:SetTitle("Select action for \"" .. (v.text) .. "\"")
							popup:MakePopup()

						local choice = vgui.Create("DComboBox", popup)
							choice:Dock(TOP)
							choice:DockMargin( 0, 0, 0, 5 )
							choice.ChooseOption = combboxchooseoption
							choice.GetSelected = combboxgetselected
							choice.GetOptionData = function(self, id) return self.Data[id] end

						local targets = listtypes[curarg.id]()
						for k,v in pairs(targets) do
							choice:AddChoice(v[1], v[2])
						end

						local okay = vgui.Create("DButton", popup)
							okay:Dock(FILL)
							okay:SetText("Okay")
							okay.DoClick = function()
								local txt,choicevalue = choice:GetSelected()

								if txt then
									finalargs[i] = choicevalue
									cont()
									popup:Close()
								end
							end
					elseif curarg.typ == VOTE_ARGTYPE_INPUT then
						local popup = vgui.Create("DFrame")
							popup:SetSize(250, 90)
							popup:Center()
							popup:SetSizable(true)
							popup:SetTitle("Select action for \"" .. (v.text) .. "\"")
							popup:MakePopup()

						local choice = vgui.Create("DTextEntry", popup)
							choice:Dock(TOP)
							choice:DockMargin( 0, 0, 0, 5 )
							choice:SetText(curarg.id)

						local okay = vgui.Create("DButton", popup)
							okay:Dock(FILL)
							okay:SetText("Okay")
							okay.DoClick = function()
								local txt = choice:GetValue()

								if txt then
									finalargs[i] = txt
									cont()
								end
							end
					end
				end

				cont()
			end
		pnllist:AddItem(btn)
	end
end

function SetupVoteMenu(parent, parentw, parenth)
	local pw = 200
	local px = math.floor(parentw/2 - pw/2)

	pnllist = vgui.Create("DPanelList", parent)
		pnllist:SetPos( px, 5 )
		pnllist:SetSize( pw, parenth - 10 )
		pnllist:EnableVerticalScrollbar(true)
		pnllist:EnableHorizontal(false)
		pnllist:SetSpacing(5)

	Update()
end

net.Receive("FMSendVoteDefinitions", function()
	local t = {}

	for i=1,net.ReadUInt(6) do
		local k = {
			id = net.ReadUInt(4),
			tier = net.ReadUInt(4),
			text = net.ReadString(),
			deadcantvote = net.ReadBit() == 1,
			args = {}
		}

		for j=1,net.ReadUInt(2) do
			table.insert(k.args, {
				typ = net.ReadUInt(2),
				id = net.ReadString()
			})
		end

		t[i] = k
	end

	table.sort(t, function(a,b)
		if a.tier != b.tier then return a.tier < b.tier end

		return a.text < b.text
	end)

	VOTES = t

	Update()
end)
