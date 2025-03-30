/*
^1 - RED 
^2 - GREEN 
^3 - YELLOW 
^4 - BLUE 
^5 - CYAN 
^6 - PINK 
^7 - WHITE 
^8 - DEFAULT MAP COLOR 
^9 - GREY OR DEFAULT MAP COLOR 
^0 - BLACK 
^; - YALE BLUE 
^: - LIGHT YELLOW
*/


getOptions()
{
	self endon("disconnect");
	
	options = [];
	
	m = "Main";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "Sub Menu 1", ::callMenu, "Sub Menu 1");
	options[m][options[m].size] = AddOption(m, "Players Menu", ::callMenu, "Players Menu");
	options[m][options[m].size] = AddOption(m, "Test Var " + getBooleanStatus(self.testvar), ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	
	m = "Sub Menu 1";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	options[m][options[m].size] = AddOption(m, "Test Opt " + options[m].size + 1, ::test);
	
	m = "Players Menu";
	options[m] = [];
	
	for(i = 0; i < level.players.size; i++)
	{
		//no need to edit this part
		player = level.players[i];
		
		options[m][i] = AddOption(m, "[" + player.MenuAccess + "] " + getName(player), ::callMenu, "Player Options 1");
		
		//no need to edit this part
		//do not add options here! all player options should be added in Player Options 1 or whatever you have defined to hold your player options!
	}
	
	pName = getName(self.SimplyPerfect.SelectedPlayer);
	
	m = "Player Options 1";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "Change Verification of " + pName, ::callMenu, "Verification Options");
	options[m][options[m].size] = AddOption(m, "Kill " + pName, ::test);
	options[m][options[m].size] = AddOption(m, "Kick " + pName, ::test);
	options[m][options[m].size] = AddOption(m, "Print " + pName + "'s Name", ::printplayername);
	
	m = "Verification Options";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "Set " + pName + "'s status as ^1Unverified", ::SetVerification, "Unverified");
	options[m][options[m].size] = AddOption(m, "Set " + pName + "'s status as ^2Verified", ::SetVerification, "Verified");
	options[m][options[m].size] = AddOption(m, "Set " + pName + "'s status as ^2VIP", ::SetVerification, "VIP");
	options[m][options[m].size] = AddOption(m, "Set " + pName + "'s status as ^2Admin", ::SetVerification, "Admin");
	options[m][options[m].size] = AddOption(m, "Set " + pName + "'s status as ^2CoHost", ::SetVerification, "CoHost");
	
	return options;
}

clearMenu(m)
{
	if (isDefined(self.SimplyPerfect.menus[m]))
	{
		for(i = 0; i < self.SimplyPerfect.menus[m].options.size; i++)
		{
			arrayremovevalue(self.SimplyPerfect.menus[m].options[i], self.SimplyPerfect.menus[m].options[i].text);
			arrayremovevalue(self.SimplyPerfect.menus[m].options[i], self.SimplyPerfect.menus[m].options[i].func);
			arrayremovevalue(self.SimplyPerfect.menus[m].options[i], self.SimplyPerfect.menus[m].options[i].input1);
			arrayremovevalue(self.SimplyPerfect.menus[m].options[i], self.SimplyPerfect.menus[m].options[i].input2);
			arrayremovevalue(self.SimplyPerfect.menus[m].options[i], self.SimplyPerfect.menus[m].options[i].input3);
		}
	}
}

CreateOptions()
{
	options = getOptions();
	
	self AddMenu("Main", "Verified", undefined, options["Main"]);
	
	self AddMenu("Sub Menu 1", "Verified", "Main", options["Sub Menu 1"]);
	self AddMenu("Players Menu", "CoHost", "Main", options["Players Menu"]);
	
	self AddMenu("Player Options 1", "CoHost", "Players Menu", options["Player Options 1"]);
	self AddMenu("Verification Options", "CoHost", "Player Options 1", options["Verification Options"]);
	
	self thread waitForMenuClick();
	self thread updateMenuOptionsLoop();
}

updateMenuOptionsLoop()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		options = getOptions();
		foreach(menu in self.SimplyPerfect.allmenus)
		{
			self updateOptions(options[menu]);
		}
		
		wait .1;
	}
}

waitForMenuClick()
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		self waittill("clicked_option");
		options = getOptions();
		
		self updateOptions(options[self.SimplyPerfect.currentmenu]);
		
		self updateText();
	}
}

updateOptions(_options)
{
	if (isDefined(_options))
	{
		for(i = 0; i < _options.size; i++)
		{
			menutitle = _options[i].parent;
			
			if (menutitle == "Players Menu")
				self.SimplyPerfect.menus[menutitle].options[i] = spawnStruct();
				
			self.SimplyPerfect.menus[menutitle].options[i].text = _options[i].text;
			self.SimplyPerfect.menus[menutitle].options[i].func = _options[i].func;
			if (isDefined(_options[i].input1))
				self.SimplyPerfect.menus[menutitle].options[i].input1 = _options[i].input1;
			if (isDefined(_options[i].input2))
				self.SimplyPerfect.menus[menutitle].options[i].input2 = _options[i].input2;
			if (isDefined(_options[i].input3))
				self.SimplyPerfect.menus[menutitle].options[i].input3 = _options[i].input3;
		}
	}
}

updateText() //updates current text that's on screen
{
	menutitle = self.SimplyPerfect.currentmenu;
	
	optionnum = 0;
    optionnum2 = 0;
    
    cur = self.SimplyPerfect.curs;
    scrollerpos = self.SimplyPerfect.scrollerpos;
    
    for(i = cur; i < cur + self.SimplyPerfect.optionstoshow; i++)
    {
    		
    	if (isDefined(self.SimplyPerfect.menus[menutitle].options[i]))
    	{
			option = getOptionText(menutitle, i);
			self.SimplyPerfect.options[optionnum] setSafeText(option);
    	}
    	else
    	{
    		if (isDefined(self.SimplyPerfect.menus[menutitle].options[0 + optionnum2]))
    		{
				option = getOptionText(menutitle, 0 + optionnum2);
				self.SimplyPerfect.options[optionnum] setSafeText(option);
    		}
    		else
    		{
    			optionnum2 = 0;
    			
    			option = getOptionText(menutitle, 0 + optionnum2);
				self.SimplyPerfect.options[optionnum] setSafeText(option);
    		}
    		
    		optionnum2++;
    	}
    	optionnum++;
    }
}

getOptionText(menutitle, num)
{
	if (isDefined(self.SimplyPerfect.menus[menutitle].options[num]))
		return self.SimplyPerfect.menus[menutitle].options[num].text;
	else
		return "";
}

isSelected(num)
{
	return self.SimplyPerfect.scrollerpos == num;
}








