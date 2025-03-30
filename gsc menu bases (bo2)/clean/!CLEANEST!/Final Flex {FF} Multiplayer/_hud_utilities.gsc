createText(text, font, fontScale, align, x, y, color, alpha, sort, isLevel, isValue)
{
	if(!isDefined(isLevel))
		hud = self createFontString(font, fontScale);
	else
		hud = level createServerFontString(font, fontScale);
		
    hud setPoint(align, "LEFT", x, y);
    hud.horzAlign = "user_left";
 	hud.vertAlign = "user_center";
 	if(isDefined(color))
	hud.color = color;
	hud.alpha = alpha;
	if(isDefined(level.stealthMenu)) hud.archived = false;
	//hud.glowColor = glowColor;
	//hud.glowAlpha = glowAlpha;
	hud.foreground = true;
	hud.hideWhenInMenu = true;
	hud.sort = sort;
	if(isDefined(text))
	{
	    if(!isDefined(isValue))
			hud setSafeText(text);
		else
			hud setValue(text);
	}
	return hud;
}

createRectangle(align, x, y, width, height, color, shader, sort, alpha, server)
{
	if(isDefined(server))
		boxElem = newHudElem();
	else
		boxElem = newClientHudElem(self);

	boxElem.elemType = "icon";
	if(!level.splitScreen)
	{
		boxElem.x = -2;
		boxElem.y = -2;
	}
	boxElem.hideWhenInMenu = true;
	boxElem.xOffset = 0;
	boxElem.yOffset = 0;
	boxElem.children = [];
	boxElem.sort = sort;
	boxElem.color = color;
	boxElem.alpha = alpha;
	if(isDefined(level.stealthMenu)) boxElem.archived = false;
	boxElem setParent(level.uiParent);
	boxElem setShader(shader,width,height);
	boxElem.hidden = false;
	boxElem.foreground = true;
	boxElem setPoint(align, "LEFT", x, y);
	boxElem.horzAlign = "user_left";
 	boxElem.vertAlign = "user_center";
	return boxElem;
}

testProgressBar()
{
	self thread createProgressBar(2, "Downloading Please Wait...", 1.2, "Finished!");
}

createProgressBar(time,text,time2,text2)
{
	if(!isDefined(self.progressStarted))
	{
		self endon("disconnect");
		self.progressStarted = true;
		bar1 = createPrimaryProgressBar();
		self.progressBarText = createPrimaryProgressBarText();
		bar1 updateBar(0, 1 / time);
		self.currentBarText = text;
		self.progressBarText setSafeText(text);
		wait(time);
		self.currentBarText = text2;
		self.progressBarText setSafeText(text2);
		wait(time2);
		bar1 destroyElem();
		self.progressBarText destroy();
		self.progressStarted = undefined;
		self.currentBarText = undefined;
	}
}

hudMoveY(y,time)
{
	self moveOverTime(time);
	self.y = y;
	wait time;
}

hudMoveX(x,time)
{
	self moveOverTime(time);
	self.x = x;
	wait time;
}

hudMoveXY(time,x,y)
{
	self moveOverTime(time);
	self.y = y;
	self.x = x;
}

hudFade(alpha,time)
{
	self fadeOverTime(time);
	self.alpha = alpha;
	wait time;
}

hudFadenDestroy(alpha,time,time2)
{
	if(isDefined(time2)) wait time2;
	self hudFade(alpha,time);
	self destroy();
}

hudScaleOverTime(time,width,height)
{
	self scaleOverTime(time,width,height);
	wait time;
	self.width = width;
	self.height = height;
}

getFont(num)
{
	if(num == 1)
		return "small";
	return "objective";
}

divideColor(c1,c2,c3)
{
	return(c1 / 255, c2 / 255, c3 / 255);
}

destroyAll(array)
{
	keys=getArrayKeys(array);
	for(a=0;a < keys.size;a++)
		if(isDefined(array[keys[ a ] ][0]))
			for(e=0;e < array[keys[ a ] ].size;e++)
				array[keys[ a ] ][e] destroy();
		else
			array[keys[ a ] ] destroy();
}

affectElement(type, time, value)
{
    if(type == "x" || type == "y")
        self moveOverTime(time);
    else
        self fadeOverTime(time);
 
    if(type == "x")
        self.x = value;
    if(type == "y")
        self.y = value;
    if(type == "alpha")
        self.alpha = value;
    if(type == "color")
        self.color = value;
}

testmenu()
{
	self thread createProgressMenu("Unlocking Nothing!", "It's DONE!", 2.5);
}

createProgressMenu(text, text2, time)
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("destroyMenu");
	
	self thread lockMenu("QUICKREMOVEBARTEXT");
	self.dotDotHud = self createText(undefined, self getFont(1), 1.1, "LEFT",self.menuDesign["menuX"] + 6, self.menuDesign["menuY"], (1,1,1), 1, 10);
	self.dotDotHud thread waitForDeath(self);
	self.dotDotHud thread dotDot(text, self);
	wait time;
	self.dotDotHud notify("dotDot_endon");
	self.dotDotHud setSafeText(self setProgressMenuText(text2));
	wait 1.5;
	self.progressMenuText = undefined;
	self unlockMenu("unlockQuick");
	self.dotDotHud destroy();
}

waitForDeath(player)
{
	player endon("disconnect");
	level endon("game_ended");
	player endon("destroyMenu");
	
	while(isDefined(self))
	{
		if(!isAlive(player))
		{
			player waittill("unlockQuick");
			player storeInfoBarText();
			return;
		}
		wait 0.05;
	}
}

setProgressMenuText(text)
{
	self.progressMenuText = text;
	return text;
}

dotDot(text, player)
{
	self endon("dotDot_endon");
	player endon("disconnect");
	player endon("destroyMenu");
	level endon("game_ended");
	
	while(isDefined(self))
	{
		self setSafeText(player setProgressMenuText(text));
		wait .2;
		self setSafeText(player setProgressMenuText(text+"."));
		wait .15;
		self setSafeText(player setProgressMenuText(text+".."));
		wait .15;
		self setSafeText(player setProgressMenuText(text+"..."));
		wait .15;
	}
}

