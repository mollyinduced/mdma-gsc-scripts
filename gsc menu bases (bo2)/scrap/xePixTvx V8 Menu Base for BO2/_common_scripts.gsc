createText(font, fontscale, align, relative, x, y, sort, color, alpha, glowColor, glowAlpha, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem.type = "text";
	textElem setSafeText(text);
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.glowColor = glowColor;
	textElem.glowAlpha = glowAlpha;
	textElem.hideWhenInMenu = true;
	return textElem;
}
createRectangle(align, relative, x, y, width, height, color, alpha, sorting, shadero)
{
	barElemBG = newClientHudElem( self );
	barElemBG.elemType = "bar";
	if ( !level.splitScreen )
	{
		barElemBG.x = -2;
		barElemBG.y = -2;
	}
	barElemBG.width = width;
	barElemBG.height = height;
	barElemBG.align = align;
	barElemBG.relative = relative;
	barElemBG.xOffset = 0;
	barElemBG.yOffset = 0;
	barElemBG.children = [];
	barElemBG.color = color;
	if(isDefined(alpha))
		barElemBG.alpha = alpha;
	else
		barElemBG.alpha = 1;
	barElemBG setShader( shadero, width , height );
	barElemBG.hidden = false;
	barElemBG.sort = sorting;
	barElemBG setPoint(align,relative,x,y);
	return barElemBG;
}
elemFadeOverTime(time,alpha)
{
	self fadeovertime(time);
	self.alpha = alpha;
}
elemMoveOverTimeY(time,y)
{
	self moveovertime(time);
	self.y = y;
}
elemMoveOverTimeX(time,x)
{
	self moveovertime(time);
	self.x = x;
}
elemScaleOverTime(time,width,height)
{
	self scaleovertime(time,width,height);
}
changeFontScaleOverTimes(time,scale)
{
	self ChangeFontScaleOverTime(time);  
	self.fontScale = scale;
}
deleteOffHand()
{
	self endon("death");
	self endon("disconnect");
	self endon("Donnnnwwwww");
	self waittill("grenade_fire",flash);
	flash delete();
	self notify("Donnnnwwwww");
}
Test()
{
	self iprintln("^1Test");
}
RemovedeathTriggers()
{
	ents = getEntArray();
	for ( index = 0; index < ents.size; index++ )
	{
    	if(isSubStr(ents[index].classname, "trigger_hurt"))
    	ents[index].origin = (0, 0, 9999999);
	}
}

