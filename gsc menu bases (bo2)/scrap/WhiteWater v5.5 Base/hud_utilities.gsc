createText(font, fontscale, align, relative, x, y, sort, alpha, color, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.hideWhenInMenu = true;

	level.result += 1;
	textElem setText(text);
    level notify(textset);
	
	return textElem;
}

createRectangle(align, relative, x, y, width, height, sort, color, alpha, shader)
{
	shaderElem = newClientHudElem(self);
	shaderElem.elemType = "bar";
	shaderElem.children = [];
	shaderElem.sort = sort;
	shaderElem.color = color;
	shaderElem.alpha = alpha;
	shaderElem setParent(level.uiParent);
	shaderElem setShader(shader, width , height);
	shaderElem.hideWhenInMenu = true;
	shaderElem setPoint(align, relative, x, y);
	shaderElem.type = "shader";
	
	return shaderElem;
}

drawShader(shader, x, y, width, height, color, alpha, sort)
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    return hud;
}

feed()
{
	self endon("menu_exit");

	while(self.menu.open == false)
	{		
		for(i = 0; i < self.WhiteWater["info"].size; i++)
		{
			self iPrintln(self.WhiteWater["info"][i]);
			wait 5;
		}
	}
}



