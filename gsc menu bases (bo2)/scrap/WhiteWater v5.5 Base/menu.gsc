MenuOptions()
{
		self endon("death");
		self endon("disconnect");
		
		a = "Player";
		self add_menu(a, undefined, "[ WhiteWater ]", "CoHost");
		self thread monitorPlayers();
		
		b = "Main"; //the first sub menu which opens
		self add_menu(b, undefined, "[ WhiteWater ]", "Verified");
			self add_option(b, "Sub Menu", ::submenu, "menu_sub", "Sub Menu");
			self add_option(b, "Option 1", ::test);
			self add_option(b, "Option 2", ::test);
			self add_option(b, "Option 3", ::test);
			self add_option(b, "Option 4", ::test);
			self add_option(b, "Option 5", ::test);
			self add_option(b, "Option 6", ::test);
			self add_option(b, "Option 7", ::test);
			self add_option(b, "Option 8", ::test);
			self add_option(b, "Option 9", ::test);
			self add_option(b, "Option 10", ::test);
			self add_option(b, "Option 11", ::test);
			self add_option(b, "Option 12", ::test);
			self add_option(b, "Option 13", ::test);
		
		c = "AllPlayers";
		self add_menu(c, undefined, "[ WhiteWater ]", "CoHost");
			self add_option(c, "Option 1", ::test);


		////////////////////submenus inside the main menus\\\\\\\\\\\\\\\\\

		d = "menu_sub";
		self add_menu_alt(d, "Main", "Sub Menu", "Verified");
			self add_option_alt(d, "God Mode", ::InfiniteHealth);
			self add_option_alt(d, "Infinite Ammo", ::toggleammo);
			self add_option_alt(d, "Bind No Clip", ::dpadleft);
}

monitorPlayers()
{
	self endon("disconnect");
	
	clearPlayerMenu();
	
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		name = getNamePlayer(player);
		
		if(player isHost() == false)
		{
		o = "pMenu" + i;
		self add_menu_alt(o, "Player", "[" + verificationToColor(player.MenuAccess) + "^7] " + name, "CoHost");
			self add_option_alt(o, "Make UnVerified", ::SetVerification, player, "Unverified");
			self add_option_alt(o, "Verify", ::SetVerification, player, "Verified");
			self add_option_alt(o, "VIP", ::SetVerification, player, "VIP");
			self add_option_alt(o, "Admin", ::SetVerification, player, "Admin");
			self add_option_alt(o, "Co-Host", ::SetVerification, player, "CoHost");
			self add_option_alt(o, "More Options", ::submenu, "pMenu" + i + "_2", "[" + verificationToColor(player.MenuAccess) + "^7] " + name);
		
		p = "pMenu" + i + "_2";
		self add_menu_alt(p, "pMenu" + i, "[" + verificationToColor(player.MenuAccess) + "^7] " + name, "CoHost");
			self add_option_alt(p, "Option 1", ::test);
			
		self add_option("Player", name, ::submenu, "pMenu" + i, "[" + verificationToColor(player.MenuAccess) + "^7] " + name);
		}
	}
}

clearPlayerMenu()
{

	for(i = 0; i < self.menu.menucount["Player"]; i++)
	{
		arrayremovevalue(self.menu.menuopt["Player"], self.menu.menuopt["Player"][i]);
		arrayremovevalue(self.menu.menufunc["Player"], self.menu.menufunc["Player"][i]);
		arrayremovevalue(self.menu.menuinput["Player"], self.menu.menuinput["Player"][i]);
		arrayremovevalue(self.menu.menuinput1["Player"], self.menu.menuinput1["Player"][i]);
	}
	
	self.menu.menucount["Player"] = 0;
	self.menu.curs["Player"] = 0;
}

openMenu()
{
	self freezecontrols(true);
	self setClientUiVisibilityFlag("hud_visible", 0);
	self enableInvulnerability();
	self thread feed();
	
	self.menu.open = true;
	
	self.menu.Background.alpha = 0.75;
	self.menu.title.alpha = 0.75;
	self.menu.options.alpha = 0.75;
	self.menu.scroller.alpha = 0.75;
	self.menu.titlescroller.alpha = 1;
	
	self thread submenu(self.menu.menus[self.menu.curMenu], self.menu.menusubtitle[self.menu.curMenu]);
}

closeMenu()
{
	self notify("menu_exit");
	self freezecontrols(false);
	self setClientUiVisibilityFlag("hud_visible", 1);
	
	if(self.unicorn == true)
		self disableInvulnerability();
	
	self.menu.open = false;
	
	self.menu.Background.alpha = 0;

	self.menu.title.alpha = 0;
	self.menu.options.alpha = 0;
	self.menu.scroller.alpha = 0;
	self.menu.titlescroller.alpha = 0;
}

submenu(input, title)
{
	self endon("disconnect");
	self endon("death");

	if (verificationToNum(self.MenuAccess) >= verificationToNum(self.menu.VerificationStatus[input]))
	{
	
		self.CurMenu = input;
		self.CurTitle = title;
		
		self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
		self.menu.curs[input] = self.menu.scrollerpos[input];
		
		if (self.menu.curMenu == 0)
		{
			self.menu.titlescroller ScaleOverTime(0.15, 100, 30);
			self.menu.titlescroller moveOverTime(0.15);
			self.menu.titlescroller.x = -170;
		}
		else if(self.menu.curMenu == 1)
		{
			self.menu.titlescroller ScaleOverTime(0.15, 200, 30);
			self.menu.titlescroller moveOverTime(0.15);
			self.menu.titlescroller.x = 0;
		}
		else if(self.menu.curMenu == 2)
		{
			self.menu.titlescroller ScaleOverTime(0.15, 100, 30);
			self.menu.titlescroller moveOverTime(0.15);
			self.menu.titlescroller.x = 170;
		}

		self.menu.options destroy();
		
		if (input == "Player") //this is the name of the players menu
		{
			self monitorPlayers();
		}
		
		self.menu.title setText("^4Players\t\t\t\t\t\t\t\t^7" + title + "\t\t\t\t\t\t\t\t^4All Players");
		level.result += 1;
		level notify("textset");
		
		self thread StoreText(input, title);
		
		self updateScrollbar();
	}
	else
	{
		self iPrintln("Sorry you can not access this menu with your current verification status");
	}
}

add_menu(Menu, prevmenu, menutitle, status)
{
	self.menu.menus[self.menu.menutotal] = Menu;
	self.menu.VerificationStatus[Menu] = status;
	self.menu.getmenu[Menu] = Menu;
	self.menu.scrollerpos[Menu] = 0;
	self.menu.curs[Menu] = 0;
	self.menu.menucount[Menu] = 0;
	self.menu.subtitle[Menu] = menutitle;
	self.menu.menusubtitle[self.menu.menutotal] = menutitle;
	self.menu.previousmenu[Menu] = prevmenu;
	self.menu.menutotal++;
}

add_menu_alt(Menu, prevmenu, menutitle, status)
{
	self.menu.getmenu_sub[Menu] = Menu;
	self.menu.VerificationStatus[Menu] = status;
	self.menu.scrollerpos[Menu] = 0;
	self.menu.curs[Menu] = 0;
	self.menu.menucount[Menu] = 0;
	self.menu.subtitle[Menu] = menutitle;
	self.menu.previousmenu[Menu] = prevmenu;
}

add_option(Menu, Text, Func, arg1, arg2)
{
	Menu = self.menu.getmenu[Menu];
	Num = self.menu.menucount[Menu];
	self.menu.menuopt[Menu][Num] = Text;
	self.menu.menufunc[Menu][Num] = Func;
	self.menu.menuinput[Menu][Num] = arg1;
	self.menu.menuinput1[Menu][Num] = arg2;
	self.menu.menucount[Menu] += 1;
}

add_option_alt(Menu, Text, Func, arg1, arg2)
{
	Menu = self.menu.getmenu_sub[Menu];
	Num = self.menu.menucount[Menu];
	self.menu.menuopt[Menu][Num] = Text;
	self.menu.menufunc[Menu][Num] = Func;
	self.menu.menuinput[Menu][Num] = arg1;
	self.menu.menuinput1[Menu][Num] = arg2;
	self.menu.menucount[Menu] += 1;
}





