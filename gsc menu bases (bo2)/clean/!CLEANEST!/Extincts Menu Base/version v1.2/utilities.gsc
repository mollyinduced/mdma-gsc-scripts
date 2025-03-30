createText(font, fontScale, align, relative, x, y, sort, alpha, text, color, isLevel)
{
	return self createOtherText(font, fontScale, align, relative, x, y, sort, alpha, text, color, true, isLevel);
}

createOtherText(font, fontScale, align, relative, x, y, sort, alpha, text, color, watchText, isLevel)
{
	if(isDefined(isLevel))
		textElem = level createServerFontString(font, fontScale);
	else 
		textElem = self createFontString(font, fontScale);
	
	textElem setPoint(align, relative, x, y);
	textElem.hideWhenInMenu = true;
	textElem.archived = false;
	textElem.sort = sort;
	textElem.alpha = alpha;
	textElem.color = color;
	self addToStringArray(text);

	if(isDefined(watchText))
		textElem thread watchForOverFlow(text);
	else
		textElem setText(text);
	return textElem;
}

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha, server)
{
	if(isDefined(server))
		boxElem = newHudElem();
	else
		boxElem = newClientHudElem(self);

	boxElem.elemType = "icon";
	boxElem.color = color;
	if(!level.splitScreen)
	{
		boxElem.x = -2;
		boxElem.y = -2;
	}
	boxElem.hideWhenInMenu = true;
	boxElem.archived = false;
	boxElem.width = width;
	boxElem.height = height;
	boxElem.align = align;
	boxElem.relative = relative;
	boxElem.xOffset = 0;
	boxElem.yOffset = 0;
	boxElem.children = [];
	boxElem.sort = sort;
	boxElem.alpha = alpha;
	boxElem.shader = shader;
	boxElem setParent(level.uiParent);
	boxElem setShader(shader, width, height);
	boxElem.hidden = false;
	boxElem setPoint(align, relative, x, y);
	return boxElem;
}

setSafeText(text)
{
	self notify("stop_TextMonitor");
	self addToStringArray(text);
	self thread watchForOverFlow(text);
}

addToStringArray(text)
{
	if(!isInArray(level.strings,text))
    {
		level.strings[level.strings.size] = text;
		level notify("CHECK_OVERFLOW");
	}
}

watchForOverFlow(text)
{
	self endon("stop_TextMonitor");

	while(isDefined(self))
	{
		if(isDefined(text.size))
			self setText(text);
		else
		{
			self setText(undefined);
			self.label = text;
		}
		level waittill("FIX_OVERFLOW");
	}
}

buildFromMenu(menu)
{
	if(!isDefined(menu)) 
		menu = self getCurrentMenu();
	if(isDefined(self.eMenu_O[ menu ][ "option" ][ 0 ]))
		return self;
	else
		return getPlayers()[ 0 ];
}

getCurrentMenu()
{
	return self.eMenu[ "CurrentMenu" ];
}

setCurrentMenu(menu)
{
	self.eMenu[ "CurrentMenu" ] = menu;
}

destroyAll(array)
{
	if(!isDefined(array))
		return;
	keys = getArrayKeys(array);
	for(a=0;a<keys.size;a++)
		if(isDefined(array[ keys[ a ] ][ 0 ]))
			for(e=0;e<array[ keys[ a ] ].size;e++)
				array[ keys[ a ] ][ e ] destroy();
	else
		array[ keys[ a ] ] destroy();
}

hudFade(alpha,time)
{
	self fadeOverTime(time);
	self.alpha = alpha;
	wait time;
}

getCursor()
{
	return self.eMenu_C[ self getCurrentMenu()+"_Cursor" ];
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

hasMenu()
{
	if(self.verStatus != level.status[0])
		return true;
	return false;	
}

isInMenu()
{
	if(isDefined(self.eMenu["inMenu"]))
		return true;
	return false;	
}

getName()
{
	nT=getSubStr(self.name,0,self.name.size);
	for(i=0;i<nT.size;i++)
	{
		if(nT[i]=="]")
			break;
	}
	if(nT.size!=i)
		nT=getSubStr(nT,i+1,nT.size);
	return nT;
}

grabMenuColour( curs )
{
	if(IsSubStr(self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"][curs], ",") && isDefined( level.eShader[ self getCurrentMenu() ] ))
	{
		colour = strTok(self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"][ curs ], ",");
		return divideColor(int(colour[0]), int(colour[1]), int(colour[2]));
	}
	else if(isDefined( level.eShader[ self getCurrentMenu() ] ))
		return (1,1,1);
	else if(self.eMenu_C1[ self getCurrentMenu() ][ "colour" ][ curs ] != self.eMenu["Select_Colour"])
		return self.eMenu["Opt_Colour"];
	else return self.eMenu_C1[ self getCurrentMenu() ][ "colour" ][ curs ];
}

divideColor(c1,c2,c3,ignore)
{
	if(isDefined(ignore))
		return (c1, c2, c3);
	return (c1 /255, c2 /255, c3 /255);
}

coHostList(player, action)
{
	dvar = getDvar("coHostList");
	name = player getPlayerName();
	if(action == true)
	{
		if(dvar == "")
			dvar += name;
		else
			dvar += "," + name;
	}
	if(action == false)
	{
		array = strTok(dvar, ",");
		dvar = "";
		for(i = 0; i < array.size; i++)
		{
			if(array[i] != name)
			{
				if(i == 0)
					dvar += array[i];
				else
					dvar += "," + array[i];	
			}
		}
	}
	setDvar("coHostList", dvar);
}

isInCoHostList(who)
{
	if(getDvar("coHostList") == "")
		return false;
	array = strTok(getDvar("coHostList"), ",");
	for(i = 0; i < array.size; i++)
		if(array[i] == who getPlayerName())
			return true;
	return false;
}

getPlayerName()
{
	name = self.name;
	if(name[0] != "[")
		return name;
	for(a = name.size - 1; a >= 0; a--)
		if(name[a] == "]")
			break;
	return(getSubStr(name, a + 1));
}












