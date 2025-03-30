openUnboundUserV4() //opens the menu
{
	if (isDefined(self.UnboundUser.patchname))
		self.UnboundUser.patchname.alpha = 1;
		
	if (isDefined(self.UnboundUser.title))
		self.UnboundUser.title.alpha = 1;
	
	foreach(option in self.UnboundUser.options)
	{
		if (isDefined(self.UnboundUser.options) && isDefined(option))
			option.alpha = 1;
	}
	
	if (isDefined(self.UnboundUser.openclose))
		self.UnboundUser.openclose.alpha = 0;
	
	self.UnboundUser.curs = 0;
	self.UnboundUser.toplevelmenucurs = 0;
	//reset menu positioning, when menu is opened
	
	self.UnboundUser.MenuOpen = true;
	
	self disableweapons();
	
	self thread callMenu(self.UnboundUser.toplevelmenus[0]);
}

closeUnboundUserV4() //closes the menu
{
	if (isDefined(self.UnboundUser.patchname))
		self.UnboundUser.patchname.alpha = 0;
	
	if (isDefined(self.UnboundUser.title))
		self.UnboundUser.title.alpha = 0;
	
	foreach(option in self.UnboundUser.options)
	{
		if (isDefined(self.UnboundUser.options) && isDefined(option))
			option.alpha = 0;
	}
	
	if (isDefined(self.UnboundUser.openclose))
		self.UnboundUser.openclose.alpha = 1;
	
	self.UnboundUser.MenuOpen = false;
	
	self enableweapons();
}

//AddMenu parmaters = Menu Title, Menu Subtitle, MenuType ("Top" or "Sub"), Previous Menu (Which is the Menu Title), and Options which is an array that we get from getOptions();
AddMenu(menutitle, menusubtitle, menutype, prevmenu, _options)
{
	self.UnboundUser.allmenus[self.UnboundUser.allmenus.size] = menutitle;
	
	self.UnboundUser.menus[menutitle] = spawnStruct();
	self.UnboundUser.menus[menutitle].options = [];
	
	if (menutype == "Top")
		self.UnboundUser.toplevelmenus[self.UnboundUser.toplevelmenucount] = menutitle;
	
	self.UnboundUser.menus[menutitle].menuname = menutitle;
	
	if (isDefined(menusubtitle))
		self.UnboundUser.menus[menutitle].subtitle = menusubtitle;
	
	if (isDefined(prevmenu))
		self.UnboundUser.menus[menutitle].prevmenu = prevmenu;
		
	self.UnboundUser.menus[menutitle].curs = 0;
	
	for(i = 0; i < _options.size; i++)
	{
		self.UnboundUser.menus[menutitle].options[i] = spawnStruct();
		
		self.UnboundUser.menus[menutitle].options[i].selectedtext = _options[i]["Selected"];
		self.UnboundUser.menus[menutitle].options[i].notselectedtext = _options[i]["NotSelected"];
		self.UnboundUser.menus[menutitle].options[i].func = _options[i]["func"];
		if (isDefined(_options[i]["input1"]))
			self.UnboundUser.menus[menutitle].options[i].input1 = _options[i]["input1"];
		if (isDefined(_options[i]["input2"]))
			self.UnboundUser.menus[menutitle].options[i].input2 = _options[i]["input2"];
		if (isDefined(_options[i]["input3"]))
			self.UnboundUser.menus[menutitle].options[i].input3 = _options[i]["input3"];
	}
	
	if (menutype == "Top")
		self.UnboundUser.toplevelmenucount++;

}

callMenu(menutitle) //this is where we open a new menu
{
	self.UnboundUser.currentmenu = menutitle;
	self.UnboundUser.curs = 0;
	
	self updateText(menutitle); //update option text
	
	
	self.UnboundUser.lastmenunum = self.UnboundUser.toplevelmenucount - 1;
	
	title1 = "^4" + self.UnboundUser.menus[self.UnboundUser.toplevelmenus[self.UnboundUser.lastmenunum]].subtitle + "^7-----^0";
	title2 = "";
	title3 = self.UnboundUser.menus[self.UnboundUser.toplevelmenus[0]].subtitle;
	
	
	
	if (isDefined(self.UnboundUser.toplevelmenus[self.UnboundUser.toplevelmenucurs - 1]))
	{
		self.UnboundUser.prevmenu = self.UnboundUser.toplevelmenucurs - 1;
		title1 = "^4" + self.UnboundUser.menus[self.UnboundUser.toplevelmenus[self.UnboundUser.prevmenu]].subtitle + "^7-----^0";
	}

	title2 = menutitle + "^7-----^4";
		
	if (isDefined(self.UnboundUser.toplevelmenus[self.UnboundUser.toplevelmenucurs + 1]))
	{
		self.UnboundUser.nextmenu = self.UnboundUser.toplevelmenucurs + 1;
		title3 = self.UnboundUser.menus[self.UnboundUser.toplevelmenus[self.UnboundUser.nextmenu]].subtitle; 
	}
	
	if (isDefined(self.UnboundUser.title))
		self.UnboundUser.title setSafeText(title1 + title2 + title3); //set title
}

WaitForDeath()
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		self waittill("death");
		
		if (isDefined(self.martyrdom) && self.martyrdom != "") //if user selected a martyrdom type, then martyrdom() is called
			self thread martyrdom();
		
		self.UnboundUser.MenuOpen = false;
		
		if (isDefined(self.UnboundUser.patchname))
			self.UnboundUser.patchname.alpha = 0;
			
		if (isDefined(self.UnboundUser.title))
			self.UnboundUser.title.alpha = 0;
		
		foreach(option in self.UnboundUser.options)
		{
			if (isDefined(self.UnboundUser.options) && isDefined(option))
			option destroy();
		}
		
		if (isDefined(self.UnboundUser.openclose))
			self.UnboundUser.openclose.alpha = 1;
		
		self.UnboundUser.toplevelmenucurs = 0;
		self.UnboundUser.curs = 0;
		
		
		ResetBooleans(); //reset player booleans
	}
}




