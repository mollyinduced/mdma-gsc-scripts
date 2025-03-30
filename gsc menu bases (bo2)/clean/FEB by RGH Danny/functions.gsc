GodMode()
{
	if(self.GM == false)
	{
		self EnableInvulnerability();
		self.GM = true;
		self iPrintln("God Mode ^4ON");
	}
	else
	{
		self DisableInvulnerability();
		self.GM = false;
		self iPrintln("God Mode ^0OFF");
	}
}

ToggleBlur()
{
	if(self.forbidblur == false)
	{
		setDvar("r_blur", "0");
		self iPrintln("No-Blur ^4ON");
		self.forbidblur = true;
	}
	else
	{
		setDvar("r_blur", "5");
		self iPrintln("No-Blur ^0OFF");
		self.forbidblur = false;
	}
}

ToggleHUDvis()
{
	if(self.hudon == false)
	{
		self setclientuivisibilityflag( "hud_visible", 1 );
		self iPrintln("HUD In Menu ^4ON");
		self.hudon = true;
	}
	else
	{
		self setclientuivisibilityflag( "hud_visible", 0 );
		self iPrintln("HUD In Menu ^0OFF");
		self.hudon = false;
	}
}
MenuMoveRight()
{
	if(self.menuxpos <= 260)
	{
		self.menu.line MoveOverTime(.3);
		self.menu.line.x = self.menu.line.x + 20;
		self.menu.line2 MoveOverTime(.3);
		self.menu.line2.x = self.menu.line2.x + 20;
		self.menu.line3 MoveOverTime(.3);
		self.menu.line3.x = self.menu.line3.x + 20;
		self.menu.line4 MoveOverTime(.3);
		self.menu.line4.x = self.menu.line4.x + 20;
		self.menu.scroller MoveOverTime(.3);
		self.menu.scroller.x = self.menu.scroller.x + 20;
		self.menu.background MoveOverTime(.3);
		self.menu.background.x = self.menu.background.x + 20;
		self.menu.creater MoveOverTime(.3);
		self.menu.creater.x = self.menu.creater.x + 20;
		self.menu.options MoveOverTime(.3);
		self.menu.options.x = self.menu.options.x + 20;
		self.menu.title MoveOverTime(.3);
		self.menu.title.x = self.menu.title.x + 20;
		
		self.menuxpos = self.menuxpos + 20;
		self iPrintln("Moved Menu ^1+20 ^7Into Right");
		if (self.menuxpos == 0)
		{
			self iPrintln("^4Centered");
		}
	}
	else
	{
		self iPrintln("^1Cant Move Menu More Into Right");
	}
}
MenuMoveLeft()
{
	if(self.menuxpos >= -260)
	{
		self.menu.line MoveOverTime(.3);
		self.menu.line.x = self.menu.line.x - 20;
		self.menu.line2 MoveOverTime(.3);
		self.menu.line2.x = self.menu.line2.x - 20;
		self.menu.line3 MoveOverTime(.3);
		self.menu.line3.x = self.menu.line3.x - 20;
		self.menu.line4 MoveOverTime(.3);
		self.menu.line4.x = self.menu.line4.x - 20;
		self.menu.scroller MoveOverTime(.3);
		self.menu.scroller.x = self.menu.scroller.x - 20;
		self.menu.background MoveOverTime(.3);
		self.menu.background.x = self.menu.background.x - 20;
		self.menu.creater MoveOverTime(.3);
		self.menu.creater.x = self.menu.creater.x - 20;
		self.menu.options MoveOverTime(.3);
		self.menu.options.x = self.menu.options.x - 20;
		self.menu.title MoveOverTime(.3);
		self.menu.title.x = self.menu.title.x - 20;
		
		self.menuxpos = self.menuxpos - 20;
		self iPrintln("Moved Menu ^1+20 ^7Into Left");
		if (self.menuxpos == 0)
		{
			self iPrintln("^2Centered");
		}
	}
	else
	{
		self iPrintln("^1Cant Move Menu More Into Right");
	}
}

doTheme2(color)
{
    self notify("stopflash");
    self.menu.background elemcolor(1, color);
    self iPrintln("Background: [^1"+self.menu.menuopt[Menu][Num]+"]");
 
}
doTheme(color)
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, color);
    self.menu.line elemcolor(1, color);
    self.menu.line2 elemcolor(1, color);
    self.menu.line3 elemcolor(1, color);
    self.menu.line4 elemcolor(1, color);
    self iPrintln("Lines And Scroller: [^1"+self.menu.menuopt[Menu][Num]+"]");
 
}
elemcolor(time, color)
{
    self fadeovertime(time);
    self.color = color;
}
/*elemgcolor(time, gcolor)
{
    self fadeovertime(time);
    glowColor = gcolor;
}
doWhiteTheme3()
{
    
    self.menu.creater.glowColor elemgcolor(1, (1, 1, 1));
    self.menu.title.glowColor elemgcolor(1, (1, 1, 1));
    self.menu.options.glowColor elemgcolor(1, (1, 1, 1));
    self iPrintln("Background: [WHITE]");
}
doRedtheme3()
{
   
    self.menu.creater.glowColor elemgcolor(1, (1, 0, 0));
    self.menu.title.glowColor elemgcolor(1, (1, 0, 0));
    self.menu.options.glowColor elemgcolor(1, (1, 0, 0));
 	self iPrintln("Background: [^1RED^7]");
}
dobluetheme3()
{
  
    self.menu.creater.glowColor elemgcolor(1, (0, 0, 1));
    self.menu.title.glowColor elemgcolor(1, (0, 0, 1));
    self.menu.options.glowColor elemgcolor(1, (0, 0, 1));
 	self iPrintln("Background: [^4BLUE^7]");
 
}
doGreentheme3()
{

    self.menu.creater.glowColor elemgcolor(1, (0, 1, 0));
    self.menu.title.glowColor elemgcolor(1, (0, 1, 0));
    self.menu.options.glowColor elemgcolor(1, (0, 1, 0));
 	self iPrintln("Background: [^2GREEN^7]");
}
doYellowtheme3()
{

    self.menu.creater.glowColor elemgcolor(1, (1, 1, 0));
    self.menu.title.glowColor elemgcolor(1, (1, 1, 0));
    self.menu.options.glowColor elemgcolor(1, (1, 1, 0));
 	self iPrintln("Background: [^3YELLOW^7]");
}
doPinktheme3()
{

    self.menu.creater.glowColor elemgcolor(1, (1, 0, 1));
    self.menu.title.glowColor elemgcolor(1, (1, 0, 1));
    self.menu.options.glowColor elemgcolor(1, (1, 0, 1));
 	self iPrintln("Background: [^6PINK^7]");
}
doCyantheme3()
{
    self.menu.creater.glowColor elemgcolor(1, (0, 1, 1));
    self.menu.title.glowColor elemgcolor(1, (0, 1, 1));
    self.menu.options.glowColor elemgcolor(1, (0, 1, 1));
 	self iPrintln("Background: [^5CYAN^7]");
}
doAquatheme3()
{
    self.menu.creater.glowColor elemgcolor(1, (0.04, 0.66, 0.89));
    self.menu.title.glowColor elemgcolor(1, (0.04, 0.66, 0.89));
    self.menu.options.glowColor elemgcolor(1, (0.04, 0.66, 0.89));
 	self iPrintln("Background: [^5AQUA^7]");
}
doBlackTheme3()
{
    self.menu.creater.glowColor elemgcolor(1, (0, 0, 0));
    self.menu.title.glowColor elemgcolor(1, (0, 0, 0));
    self.menu.options.glowColor elemgcolor(1, (0, 0, 0));
    self iPrintln("Background: [^0BLACK^7]");
}*/

