/* Hud Scripts */
createText(font, fontscale, align, relative, x, y, sort, color, alpha, glowColor, glowAlpha, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem.type = "text";
	textElem setText(text);
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.glowColor = glowColor;
	textElem.glowAlpha = glowAlpha;
	textElem.hideWhenInMenu = true;
	level.result += 1;
	level notify("textset");
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
/* Hud Scripts End */


/* Test Functions */
Test()
{
   self iprintln("^1Test");
}
InputTest(a,b,c)
{
	if(!isDefined(a) && !isDefined(b) && !isDefined(c))
	{
		self iprintln("No Inputs Defined!");
	}
	else if(isDefined(a) && !isDefined(b) && !isDefined(c))
	{
		self iprintln("1: "+a);
	}
	else if(isDefined(a) && isDefined(b) && !isDefined(c))
	{
		self iprintln("1: "+a+" 2: "+b);
	}
	else if(isDefined(a) && isDefined(b) && isDefined(c))
	{
		self iprintln("1: "+a+" 2: "+b+" 3: "+c);
	}
}
TestToggle()
{
	if(!self.ToggleTest)
	{
		self.ToggleTest = true;
	}
	else
	{
		self.ToggleTest = false;
	}
}
KillMe()
{
	self suicide();
}
OverflowTest()
{
   display=createFontString("default",1.5);
   display setPoint("CENTER","CENTER",0,0);
	i=0;
	for(;;)
	{
		display setText("Strings: ^1"+i);
		level.result += 1;
		level notify("textset");
		i++;
		wait 0.05;
	}
	wait 0.05;
}
getLoc()
{
   self endon("death");
   self.display destroy();
   wait .2;
   self.display = createFontString("default",1.5);
   self.display setPoint("CENTER","CENTER",0,0);
   self.display setText(self.origin);
   wait 0.05;
}
debugExit()
{
	wait .4;
	exitLevel(true);
	wait .1;
}
/* Test Functions End */

/* Menu Base Shit */
isMenuLeft()
{
	if(self.FuZiioN[self.FuZiioN["CurrentMenu"]].type=="LEFT")
	{
		return true;
	}
	return false;
}










