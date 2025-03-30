DrawHUD()
{
	self.SimplyPerfect.background = createRectangle("CENTER", "CENTER", 600, 0, 5, 30, (0, 0, 0), "white", 0, 0.95);
	self.SimplyPerfect.cursor = createRectangle("LEFT", "CENTER", 600, 0, 5, 30, (0, 168, 255), "white", 2, 1);
}

rgb( r, g , b) 
{
       return ((r/255), (g/255), (b/255));
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

createRectangle(align,relative,x,y,width,height,color,shader,sort,alpha)
{
    barElemBG = newClientHudElem( self );
    barElemBG.elemType = "bar";
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.sort = sort;
    barElemBG.color = color;
    barElemBG.alpha = alpha;
    barElemBG setParent( level.uiParent );
    barElemBG setShader( shader, width , height );
    barElemBG.hidden = false;
    barElemBG setPoint(align,relative,x,y);
    return barElemBG;
}


setSafeText(text)
{
	level.result += 1;
	self setText(text);
	level notify("textset");
}


affectElement(type, time, value)
{
    if( type == "x" || type == "y" )
        self moveOverTime( time );
    else if (type == "alpha" || type == "color")
        self fadeOverTime( time );
 
    if( type == "x" )
        self.x = value;
    if( type == "y" )
        self.y = value;
    if( type == "alpha" )
        self.alpha = value;
    if( type == "color" )
        self.color = value;
}

updateTextEffects(type) //1 = instant, 2 = over time, 3 = instant grey color
{
	if (type == 1)
	{
		for(i = 0; i < self.SimplyPerfect.options.size; i ++)
		{
			self.SimplyPerfect.options[i].alpha = 0.5;
			self.SimplyPerfect.options[i].color = (128, 128, 128);
			
			YPos = self.SimplyPerfect.cursorStartingYPos + (i * self.SimplyPerfect.cursorspacing);
			
			if (self.SimplyPerfect.cursor.y == YPos)
			{
				self.SimplyPerfect.options[i].alpha = 1;
				self.SimplyPerfect.options[i].color = (0, 168, 255);
			}
		}
	}
	else if (type == 2)
	{
		for(i = 0; i < self.SimplyPerfect.options.size; i ++)
		{
			self.SimplyPerfect.options[i] stopPulse();
			
			YPos = self.SimplyPerfect.cursorStartingYPos + (i * self.SimplyPerfect.cursorspacing);
			
			if (self.SimplyPerfect.cursor.y == YPos)
				self.SimplyPerfect.options[i] pulseElement();
		}
	}
	else
	{
		for(i = 0; i < self.SimplyPerfect.options.size; i ++)
		{
			self.SimplyPerfect.options[i].alpha = 0.5;
			self.SimplyPerfect.options[i].color = (128, 128, 128);
		}
	}
}

doOpeningAnim()
{
	self.SimplyPerfect.DoingAnim = true;
	x = int(self.SimplyPerfect.optionstoshow / 2);
	for(i = int(self.SimplyPerfect.optionstoshow / 2); i >= 0; i--)
	{
	
		self.SimplyPerfect.options[i].alpha = 1;
		self.SimplyPerfect.options[i].color = (0, 168, 255);
		self.SimplyPerfect.options[x].alpha = 1;
		self.SimplyPerfect.options[x].color = (0, 168, 255);
		
		wait .1;
		
		self.SimplyPerfect.options[i].alpha = 0.5;
		self.SimplyPerfect.options[i].color = (128, 128, 128);
		self.SimplyPerfect.options[x].alpha = 0.5;
		self.SimplyPerfect.options[x].color = (128, 128, 128);
		
		//wait .1;
		x++;
	}
	self.SimplyPerfect.DoingAnim = false;
}

doClosingAnim()
{
	self.SimplyPerfect.DoingAnim = true;
	x = self.SimplyPerfect.optionstoshow - 1;
	for(i = 0; i <= int(x / 2) + 2; i++)
	{
		self.SimplyPerfect.options[i] affectElement("alpha", 0.1, 1);
		self.SimplyPerfect.options[x] affectElement("alpha", 0.1, 1);
		self.SimplyPerfect.options[i].color = (0, 168, 255);
		self.SimplyPerfect.options[x].color = (0, 168, 255);
		
		wait .065;
		
		self.SimplyPerfect.options[i] affectElement("alpha", 0.1, 0);
		self.SimplyPerfect.options[x] affectElement("alpha", 0.1, 0);
		self.SimplyPerfect.options[i].color = (128, 128, 128);
		self.SimplyPerfect.options[x].color = (128, 128, 128);
		
		wait .065;
		x--;
	}
	self.SimplyPerfect.DoingAnim = false;
}

pulseElement()
{
	self affectElement("alpha", 0.2, 1);
	self affectElement("color", 0.2, (0, 168, 255));
}

stopPulse()
{
	self affectElement("alpha", 0.2, 0.6);
	self affectElement("color", 0.2, (128, 128, 128));
}






