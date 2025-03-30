getOptions()
{
	options = [];
	
	m = "Account Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test); //the first option is always the title
	options[m][options[m].size] = AddOption(m, "Account Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Account Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Account Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Account Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Account Sub Option 5", ::test);
	
	m = "Infections Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Infections Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Infections Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Infections Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Infections Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Infections Sub Option 5", ::test);
	
	m = "Killstreaks Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Killstreaks Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Killstreaks Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Killstreaks Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Killstreaks Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Killstreaks Sub Option 5", ::test);
	
	m = "Weapons Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Weapons Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Weapons Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Weapons Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Weapons Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Weapons Sub Option 5", ::test);
	
	m = "Model Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Model Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Model Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Model Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Model Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Model Sub Option 5", ::test);
	
	m = "Fun Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Fun Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Fun Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Fun Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Fun Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Fun Sub Option 5", ::test);
	
	m = "Admin Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Admin Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Admin Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Admin Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Admin Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Admin Sub Option 5", ::test);
	
	m = "Host Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Host Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Host Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Host Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Host Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Host Sub Option 5", ::test);
	
	m = "Gamemode Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Gamemode Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Gamemode Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Gamemode Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Gamemode Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Gamemode Sub Option 5", ::test);
	
	m = "Game Settings Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Spawn 3 Bots", ::doBots, 3);
	options[m][options[m].size] = AddOption(m, "Game Settings Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Game Settings Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Game Settings Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Game Settings Sub Option 5", ::test);
	
	m = "Map Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Map Sub Option 1", ::test);
	options[m][options[m].size] = AddOption(m, "Map Sub Option 2", ::test);
	options[m][options[m].size] = AddOption(m, "Map Sub Option 3", ::test);
	options[m][options[m].size] = AddOption(m, "Map Sub Option 4", ::test);
	options[m][options[m].size] = AddOption(m, "Map Sub Option 5", ::test);
	
	m = "All Player Menu";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6" + m, ::test);
	options[m][options[m].size] = AddOption(m, "Verify All Players", ::AllVerified);
	options[m][options[m].size] = AddOption(m, "VIP All Players", ::AllVIP);
	options[m][options[m].size] = AddOption(m, "Admin All Players", ::AllAdmin);
	options[m][options[m].size] = AddOption(m, "Unverify All Players", ::AllUnverified);
	options[m][options[m].size] = AddOption(m, "Kick All", ::test);
	
	m = "Players";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6Players", ::test);
	
	for(i = 0; i < level.players.size; i++)
	{
		//no need to edit this part
		player = level.players[i];
		
		options[m][i + 1] = AddOption(m, verificationToColor(player.MenuAccess) + " ^7" + getName(player), ::callMenu, "Player Options 1");
		
		//no need to edit this part
		//do not add options here! all player options should be added in Player Options 1 or whatever you have defined to hold your player options!
	}
	
	pName = getName(self.SLH.SelectedPlayer); //this will update itself automatically
	
	m = "Players+";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "^6Players+", ::test);
	
	for(i = 0; i < level.players.size; i++)
	{
		//no need to edit this part
		player = level.players[i];
		
		options[m][i + 1] = AddOption(m, verificationToColor(player.MenuAccess) + " ^7" + getName(player), ::callMenu, "Player Options 2");
		
		//no need to edit this part
		//do not add options here! all player options should be added in Player Options 1 or whatever you have defined to hold your player options!
	}
	
	m = "Player Options 1";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "Player: ^1" + pName, ::test);
	options[m][options[m].size] = AddOption(m, "Make Verified", ::SetVerification, "Verified", undefined, true);
	options[m][options[m].size] = AddOption(m, "Make VIP", ::SetVerification, "VIP", undefined, true);
	options[m][options[m].size] = AddOption(m, "Make Admin", ::SetVerification, "Admin", undefined, true);
	options[m][options[m].size] = AddOption(m, "Make CoHost", ::SetVerification, "CoHost", undefined, true);
	
	
	m = "Player Options 2";
	options[m] = [];
	
	options[m][options[m].size] = AddOption(m, "Player: ^1" + pName, ::test);
	options[m][options[m].size] = AddOption(m, "Kick Player", ::test);
	options[m][options[m].size] = AddOption(m, "Remove Menu Access", ::SetVerification, "Unverified", undefined, true);
	
	return options;
}


CreateOptions()
{
	options = getOptions();
	
	//if prevmenu == undefined then it is a toplevel menu
	self AddMenu("Account Menu", "Verified", undefined, options["Account Menu"]);
	self AddMenu("Infections Menu", "Verified", undefined, options["Infections Menu"]);
	self AddMenu("Killstreaks Menu", "Verified", undefined, options["Killstreaks Menu"]);
	self AddMenu("Weapons Menu", "VIP", undefined, options["Weapons Menu"]);
	self AddMenu("Model Menu", "VIP", undefined, options["Model Menu"]);
	self AddMenu("Fun Menu", "VIP", undefined, options["Fun Menu"]);
	self AddMenu("Admin Menu", "Admin", undefined, options["Admin Menu"]);
	self AddMenu("Host Menu", "Admin", undefined, options["Host Menu"]);
	self AddMenu("Gamemode Menu", "Admin", undefined, options["Gamemode Menu"]);
	self AddMenu("Game Settings Menu", "Admin", undefined, options["Game Settings Menu"]);
	self AddMenu("Map Menu", "CoHost", undefined, options["Map Menu"]);
	self AddMenu("All Player Menu", "Admin", undefined, options["All Player Menu"]);
	self AddMenu("Players", "Host", undefined, options["Players"]);
	self AddMenu("Players+", "Host", undefined, options["Players+"]);
	
	
	//these are all submenus
	self AddMenu("Player Options 1", "CoHost", "Players", options["Player Options 1"]);
	self AddMenu("Player Options 2", "CoHost", "Players+", options["Player Options 2"]);
	
	self thread updateMenuOptionsLoop();
}

clearMenu(m)
{
	if (isDefined(self.SLH.menus[m]))
	{
		for(i = 0; i < self.SLH.menus[m].options.size; i++)
			arrayremovevalue(self.SLH.menus[m].options, self.SLH.menus[m].options[i]);
	}
}

updateMenuOptionsLoop()
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		self waittill_any("clicked_option", "exit_submenu", "update");
		
		options = getOptions();
		foreach(menu in self.SLH.allmenus)
		{	
			self clearMenu(menu);
			self updateOptions(options[menu]);
		}
		
		self notify("updated_options");
	}
}

updateOptions(_options)
{
	level endon("disconnect");
	
	if (isDefined(_options))
	{
		for(i = 0; i < _options.size; i++)
		{
			menutitle = _options[i].parent;
			
			if (!isDefined(self.SLH.menus[menutitle].options[i]))
				self.SLH.menus[menutitle].options[i] = spawnStruct();
				
			self.SLH.menus[menutitle].options[i].text = _options[i].text;
			self.SLH.menus[menutitle].options[i].func = _options[i].func;
			if (isDefined(_options[i].input1))
				self.SLH.menus[menutitle].options[i].input1 = _options[i].input1;
			if (isDefined(_options[i].input2))
				self.SLH.menus[menutitle].options[i].input2 = _options[i].input2;
			if (isDefined(_options[i].input3))
				self.SLH.menus[menutitle].options[i].input3 = _options[i].input3;
		}
	}
}

AddMenu(menutitle, status, prevmenu, _options)
{
	if (!isDefined(self.SLH.menus[menutitle]))
	{
		self.SLH.menus[menutitle] = spawnStruct();
		self.SLH.menus[menutitle].options = [];
		
		self.SLH.menus[menutitle].menuname = menutitle;
		self.SLH.menus[menutitle].status = status;
		
		if (!isDefined(prevmenu)) //only adds top level menus to the all menus array and not sub menus
			self.SLH.toplevelmenus[self.SLH.toplevelmenus.size] = menutitle;
		
		self.SLH.allmenus[self.SLH.allmenus.size] = menutitle;
		
		self.SLH.menus[menutitle].prevmenu = isDefined(prevmenu) ? prevmenu : undefined;
			
		//self.SLH.menus[menutitle].curs = 0; //not needed
		//self.SLH.menus[menutitle].scrollerpos = 0; //not needed
		
		if (isDefined(_options))
		{
			for(i = 0; i < _options.size; i++)
			{
				self.SLH.menus[menutitle].options[i] = spawnStruct();
				
				if (isDefined(_options[i].text))
					self.SLH.menus[menutitle].options[i].text = _options[i].text;
				if (isDefined(_options[i].func))
					self.SLH.menus[menutitle].options[i].func = _options[i].func;
				if (isDefined(_options[i].input1))
					self.SLH.menus[menutitle].options[i].input1 = _options[i].input1;
				if (isDefined(_options[i].input2))
					self.SLH.menus[menutitle].options[i].input2 = _options[i].input2;
				if (isDefined(_options[i].input3))
					self.SLH.menus[menutitle].options[i].input3 = _options[i].input3;
			}
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
	self notify("update");
	
	self waittill("updated_options");
	
	if (verificationToNum(self.MenuAccess) >= verificationToNum(self.SLH.menus[menu].status))
	{
		if (isDefined(self.SLH.menus[menu]))
		{
			self.SLH.currentmenu = menu;
			self.scroll = 1;
			
			self drawMenu();
    			
		}
		else
			self iprintln("Menu error! Unknown menu: " + menu);
	}
	else
		self iprintln("You are not allowed to enter this menu! Insufficient Privileges!");
}





