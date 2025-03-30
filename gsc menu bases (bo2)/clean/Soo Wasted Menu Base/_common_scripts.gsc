/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : _common_scripts
*	 Description :
*	 Date : 2015.07.30 - 05:12:22	
*
*/	

/* Hud Scripts */

/* Creating Text Elems */
createText(font, fontscale, align, relative, x, y, sort, color, alpha, glowColor, glowAlpha, text)
{
	textElem = CreateFontString( font, fontscale );
	textElem setPoint( align, relative, x, y );
	textElem.sort = sort;
	textElem.type = "text";
	textElem setSafeText(self,text);
	textElem.color = color;
	textElem.alpha = alpha;
	textElem.glowColor = glowColor;
	textElem.glowAlpha = glowAlpha;
	textElem.hideWhenInMenu = true;
	return textElem;
}

/* Creating Shader Elems */
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

/* Changes alpha of elem over time */
elemFadeOverTime(time,alpha)
{
	self fadeovertime(time);
	self.alpha = alpha;
}

/* Moves Y axis elem overtime */
elemMoveOverTimeY(time,y)
{
	self moveovertime(time);
	self.y = y;
}

/* Moves X axis elem overtime */
elemMoveOverTimeX(time,x)
{
	self moveovertime(time);
	self.x = x;
}

/* Changes scale of elem overtime */
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
debugExit()
{
	wait .4;
	exitLevel(true);
	wait .1;
}
/* Test Functions End */


