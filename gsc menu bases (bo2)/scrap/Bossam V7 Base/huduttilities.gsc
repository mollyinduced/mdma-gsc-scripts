drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort)
{
    hud = self createFontString(font, fontScale);
    hud setText(text);
    hud.x = x;
    hud.y = y;
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    return hud;
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

drawText2(text, font, fontScale, align, relative, x, y, color, alpha, sort)
{
	hud = self createFontString(font, fontScale);
    hud setPoint( align, relative, x, y );
    hud.color = color;
    hud.alpha = alpha;
    hud.hideWhenInMenu = true;
    hud.sort = sort;
    
    level.result += 1;
    hud setText(text);
    level notify("textset");
    
    return hud;
}

scaleLol()
{
    self endon("stopScale");
    for(;;)
    {
	self.EPI["options"].glowColor = (0.1, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.2, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.3, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.4, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.5, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.6, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.7, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.8, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.9, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (1, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.9, 0, 0);
    wait 1.5;
    self.EPI["options"].glowColor = (0.8, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.7, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.6, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.5, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.4, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.3, 0, 0);
    wait .05;
	self.EPI["options"].glowColor = (0.2, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0.1, 0, 0);
    wait .05;
    self.EPI["options"].glowColor = (0, 0, 0);
    wait .05;    
    }
}

setMenuColor(color)
{
    self.EPI["animation"] FadeOverTime(0.2);
    self.EPI["scroller"] FadeOverTime(0.2);
    self.EPI["line"] FadeOverTime(0.2);
    self.EPI["line2"] FadeOverTime(0.2);
    self.EPI["line3"] FadeOverTime(0.2);
    self.EPI["line4"] FadeOverTime(0.2);
    self.EPI["animation"].color = color;
    self.EPI["scroller"].color = color; 
    self.EPI["backgrounddesign"].color = color; 
    self.EPI["line"].color = color; 
    self.EPI["line2"].color = color;
    self.EPI["line3"].color = color;
    self.EPI["line4"].color = color; 
}

addColor(name, rgb)
{
	level.Private["colors"][name] = rgb;
}

color(name)
{
	return level.Private["colors"][name];
}

setColor(elem, color)
{
	self.Private["colors"][elem] = color;
}

//Shaders
AS(name, shaderName)
{
	level.Private["shaders"][name] = shaderName;
}

shader(name)
{
	return level.Private["shaders"][name];
}

setShader(elem, shader)
{
	self.Private["shaders"][elem] = shader;
}

changeShader(shader)
{
	self.EPI["header"] destroy();
	self.Private["header"] destroy();
	setShader("header", shader);
	self.Private["header"].shader = shader;
	shaders = self.Private["shaders"];
	self.Private["header"] = self drawShader(shaders["header"], 235, -34, 200, 70, (1, 1, 1), 255, 1);
	self.Private["header"].foreground = true;
}


ToggleScroll()
{
	if(self.scroll == false)
	{
		self.EPI["scroller"] destroy();
        self.EPI["scroller"] = self drawShader("white", 235, -100, 200, 15, (1, 0, 0), 255, 1); 
        openMenu();
		self.scroll = true;
	}
	else
	{
		self.EPI["scroller"] destroy();
        self.EPI["scroller"] = self drawShader("rank_prestige12", 235, -100, 200, 15, (1, 0, 0), 255, 1); 
        openMenu();
		self.scroll = false;
	}
}

ToggleAni()
{
	if(self.scroll == false)
	{
		self.EPI["animation"] destroy();
		self.scroll = true;
	}
	else
	{
		self.EPI["animation"] destroy();
        self.EPI["animation"] = self drawShader("compass_emp", 235, -100, 200, 1000, (1, 0, 0), 0, 1); 
        openMenu();
		self.scroll = false;
	}
}

