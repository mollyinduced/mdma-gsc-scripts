drawText(text, font, fontScale, align, relative, x, y, color, alpha, sort)
{
	hud = self createFontString(font, fontScale);
	hud setPoint(align, relative, x, y);
	hud.color = color;
	hud.alpha = alpha;
	hud.hideWhenInMenu = true;
	hud.sort = sort;
	hud.foreground = true;
	hud setSafeText(text);
	return hud;
}

drawValue(value, font, fontScale, align, relative, x, y, color, alpha, sort)
{
	hud = self createFontString(font,fontScale);
	level.result += 1;
	level notify("textset");
	hud setValue(value);
	hud.color = color;
	hud.sort = sort;
	hud.alpha = alpha;
	hud.foreground = true;
	hud.hideWhenInMenu = true;
	hud setPoint(align, relative, x, y);
	return hud;
}

CreateRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
	hud = newClientHudElem(self);
	hud.elemType = "bar";
	hud.children = [];
	hud.sort = sort;
	hud.color = color;
	hud.alpha = alpha;
	hud.hideWhenInMenu = true;
	hud.foreground = true;
	hud setParent(level.uiParent);
	hud setShader(shader, width, height);
	hud setPoint(align, relative, x, y);
	return hud;
}

setSafeText(text)
{
	level.result += 1;
	level notify("textset");
	self setText(text);
}

