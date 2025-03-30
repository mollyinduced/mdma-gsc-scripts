DrawHUD()
{
	self.UnboundUser.openclose = createText("objective", 2, "CENTER", "CENTER", 0, -140, 1, 1, (255, 255, 255), "^4Menu Closed");
	self.UnboundUser.patchname = createText("objective", 1.7, "CENTER", "CENTER", 0, -140, 1, 0, (255, 255, 255), "^7=^0=^4=^0=^7=^4U^7nbound^4U^7ser's ^0P.P. ^4v4!^7=^0=^4=^0=^7=");
	
	self.UnboundUser.lastmenunum = self.UnboundUser.toplevelmenucount - 1;
	titlestring = "^4" + self.UnboundUser.menus[self.UnboundUser.toplevelmenus[self.UnboundUser.lastmenunum]].subtitle + "^7-----^0" + self.UnboundUser.menus[self.UnboundUser.toplevelmenus[0]].menuname + "^7-----^4" + self.UnboundUser.menus[self.UnboundUser.toplevelmenus[1]].subtitle;
	self.UnboundUser.title = createText("objective", 1.7, "CENTER", "CENTER", 0, -120, 1, 0, (255, 255, 255), titlestring);
	
}

createText(font, fontscale, align, relative, x, y, sort, alpha, color, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.hideWhenInMenu = true;
	textElem.archived = true;

	textElem setSafeText(text);
	
	return textElem;
}

setSafeText(text)
{
	level.result += 1;
	self setText(text);
	level notify("textset");
}
