AddMenu(menutitle, status, prevmenu, _options)
{
	
	self.SimplyPerfect.menus[menutitle] = spawnStruct();
	self.SimplyPerfect.menus[menutitle].options = [];
	
	self.SimplyPerfect.menus[menutitle].menuname = menutitle;
	self.SimplyPerfect.menus[menutitle].status = status;
	
	self.SimplyPerfect.allmenus[self.SimplyPerfect.allmenus.size] = menutitle;
	
	if (isDefined(prevmenu))
		self.SimplyPerfect.menus[menutitle].prevmenu = prevmenu;
		
	self.SimplyPerfect.menus[menutitle].curs = 0;
	
	if (isDefined(_options))
	{
		for(i = 0; i < _options.size; i++)
		{
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

AddOption(menutitle, text, func, input1, input2, input3)
{
		
		option = spawnStruct();
		
		option.parent = menutitle;
		option.text = text;
		option.func = func;
		option.input1 = isDefined(input1) ? input1 : undefined;
		option.input2 = isDefined(input2) ? input2 : undefined;
		option.input3 = isDefined(input3) ? input3 : undefined;
		
		return option;
}

callMenu(menu)
{
	if (verificationToNum(self.MenuAccess) >= verificationToNum(self.SimplyPerfect.menus[menu].status))
	{
		if (isDefined(self.SimplyPerfect.menus[menu]))
		{
			self.SimplyPerfect.currentmenu = menu;
			
			self.SimplyPerfect.curs = 0;
			self.SimplyPerfect.scrollerpos = 0;
			
			if (menu == "Players Menu")
			{
				self clearMenu(menu);
				
				options = getOptions();
				self updateOptions(options[menu]);
			}
			
			if (self.SimplyPerfect.menus[menu].options.size >= self.SimplyPerfect.optionstoshow_constant)
				self.SimplyPerfect.optionstoshow = self.SimplyPerfect.optionstoshow_constant;
			else
				self.SimplyPerfect.optionstoshow = self.SimplyPerfect.menus[menu].options.size;
			
			self StoreText(menu);
		}
		else
			self iprintln("Menu error! Unknown menu!");
	}
	else
		self iprintln("You are not allowed to enter this menu! Insufficient Privileges!");
}

StoreText(menutitle)
{
    
    optionnum = 0;
    optionnum2 = 0;
    
    cur = self.SimplyPerfect.curs;
    scrollerpos = self.SimplyPerfect.scrollerpos;
    
    
    foreach(option in self.SimplyPerfect.options)
	{
		if (isDefined(self.SimplyPerfect.options) && isDefined(option))
			option destroy();
	}
	
    for(i = 0; i < self.SimplyPerfect.optionstoshow; i++)
    {
    	self.SimplyPerfect.options[i] = createText("default", 1.5, "LEFT", "CENTER", 70, -170 + (i * self.SimplyPerfect.cursorspacing), 1, 0.6, (128, 128, 128), "");
    }
    
    self updateText();
}













