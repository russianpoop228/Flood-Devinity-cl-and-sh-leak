
--[[
Color request
]]
function Derma_ColorRequest(strTitle, strText, fnEnter, fnCancel, strButtonText, strButtonCancelText)

	local Window = vgui.Create( "DFrame" )
		Window:SetTitle( strTitle or "Message Title (First Parameter)" )
		Window:SetDraggable( false )
		Window:ShowCloseButton( false )
		Window:SetBackgroundBlur( true )
		Window:SetSizable( true )

	local InnerPanel = vgui.Create( "DPanel", Window )
		InnerPanel:SetPaintBackground( false )
		InnerPanel:Dock(FILL)

	local Text = vgui.Create( "DLabel", InnerPanel )
		Text:SetText( strText or "Message Text (Second Parameter)" )
		Text:SizeToContents()
		Text:SetContentAlignment( 5 )
		Text:SetTextColor( color_white )
		Text:Dock(TOP)

	local Palette = vgui.Create("DColorMixer", InnerPanel)
		Palette:SetPalette(true)
		Palette:SetAlphaBar(false)
		Palette:SetWangs(false)
		Palette:Dock(FILL)
		Palette:DockMargin(0, 5, 0, 5)

	local ButtonPanel = vgui.Create( "DPanel", Window )
		ButtonPanel:SetTall( 30 )
		ButtonPanel:Dock(BOTTOM)
		ButtonPanel:SetPaintBackground( false )

	local Button = vgui.Create( "DButton", ButtonPanel )
		Button:SetText( strButtonText or "OK" )
		Button:SizeToContents()
		Button:SetTall( 20 )
		Button:SetWide( Button:GetWide() + 20 )
		Button:Dock(LEFT)
		Button:DockMargin(0, 0, 5, 0)
		Button.DoClick = function() Window:Close() fnEnter( Palette:GetColor() ) end

	local ButtonCancel = vgui.Create( "DButton", ButtonPanel )
		ButtonCancel:SetText( strButtonCancelText or "Cancel" )
		ButtonCancel:SizeToContents()
		ButtonCancel:SetTall( 20 )
		ButtonCancel:SetWide( Button:GetWide() + 20 )
		ButtonCancel:Dock(LEFT)
		ButtonCancel:DockMargin(0, 0, 5, 0)
		ButtonCancel.DoClick = function() Window:Close() if ( fnCancel ) then fnCancel( Palette:GetColor() ) end end

	local PreviewPanel = vgui.Create( "DPanel", ButtonPanel )
		PreviewPanel:SetTall( 30 )
		PreviewPanel:Dock(FILL)
		PreviewPanel:SetPaintBackground( true )
		PreviewPanel.Think = function()
			PreviewPanel:SetBackgroundColor(Palette:GetColor())
		end


	ButtonPanel:SetWide( Button:GetWide() + 5 + ButtonCancel:GetWide() + 10 )

	local w, h = Text:GetSize()
	w = math.max( w + 50, 266 )

	Window:SetSize( w, h + 150 + 75 + 10 )
	Window:Center()

	Window:MakePopup()
	Window:DoModal()
	return Window
end
