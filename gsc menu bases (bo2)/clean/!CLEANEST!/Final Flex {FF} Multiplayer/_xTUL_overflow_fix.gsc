recreateMenuText()
{
	self.AIO.string["status"] setSafeText("Status: " + self.status);
	self.AIO.string["title"] setSafeText(self.menu.curTitle);
	if(isDefined(self.AIO.string["playerInfo"])) self.AIO.string["playerInfo"] setSafeText(self getPlayerInfoString());

	if(!isDefined(self.menu.Locked))
	{
		if(!isDefined(self.menu.menuopt[self.menu.curMenu][self.menu.curs[self.menu.curMenu] - 3]) || self.menu.menuopt[self.menu.curMenu].size <= 7)
		{
	    	for(i = 0; i < 7; i++)
	    	{
		    	if(isDefined(self.menu.menuopt[self.menu.curMenu][i]))
					self.AIO.options[i] setSafeText(self.menu.menuopt[self.menu.curMenu][i]);
				else
					self.AIO.options[i] setSafeText("");
			}
		}
		else
		{
		    if(isDefined(self.menu.menuopt[self.menu.curMenu][self.menu.curs[self.menu.curMenu] + 3]))
		    {
				xePixTvx = 0;
				for(i = self.menu.curs[self.menu.curMenu] - 3; i < self.menu.curs[self.menu.curMenu] + 4; i++)
				{
				    if(isDefined(self.menu.menuopt[self.menu.curMenu][i]))
						self.AIO.options[xePixTvx] setSafeText(self.menu.menuopt[self.menu.curMenu][i]);
					else
						self.AIO.options[xePixTvx] setSafeText("");
	               		
					xePixTvx ++;
				}           
			}
			else
				for(i = 0; i < 7; i++)
					self.AIO.options[i] setSafeText(self.menu.menuopt[self.menu.curMenu][self.menu.menuopt[self.menu.curMenu].size + (i - 7)]);
		}
	}
}

overflowfix()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	
	test = level createServerFontString("default", 1);
	test.alpha = 0;
	test setText("xTUL");

	for(;;)
	{
		level waittill("clearStrings");
		test ClearAllTextAfterHudElem();
		level.strings = [];

		foreach(player in level.players)
		{
			if(isDefined(player.progressStarted) && isDefined(player.currentBarText))
				player.progressBarText setSafeText(player.currentBarText);
		
			if(isDefined(player.hasMenu) && player isVerified())
			{
				if(isDefined(player.RGBeditor))
				{
					player.RGBeditor["Default"] setSafeText(player.RGBeditorDefaultText);
					player.RGBeditor[5] setSafeText("^1R:");
					player.RGBeditor[6].label = &"Red: ";
					player.RGBeditor[9] setSafeText("^2G:");
					player.RGBeditor[10].label = &"Green: ";
					player.RGBeditor[13] setSafeText("^4B:");
					player.RGBeditor[14].label = &"Blue: ";
					if(isDefined(player.RGBeditor[15]))
						player.RGBeditor[15] setSafeText("Preview:");
				}
				if(isDefined(player.AIO.string["tabInfo"]) && !isDefined(player.menu.open))
				{
					player.AIO.string["tabInfo"] setSafeText("Press [{+speed_throw}] + [{+melee}] To Open Menu");
					player.AIO.string["entCount"].label = &"Entity Count: ";
				}
				if(isDefined(player.progressMenuText) && isDefined(player.dotDotHud))
					player.dotDotHud setSafeText(player.progressMenuText);

				if(isDefined(player.stringTest))
					player.stringTest setSafeText("^1Supports " + player.stringNum + " Strings");

				if(isDefined(player.menu.open))
					player recreateMenuText();
			}
		}
	}
}

setSafeText(text)
{
    if (!isInArray(level.strings, text))
    {
        level.strings[level.strings.size] = text;
        //iprintln(level.strings.size);
        self setText(text);
        if(level.strings.size >= 55)
			level notify("clearStrings");
    }
    else
        self setText(text);
}














