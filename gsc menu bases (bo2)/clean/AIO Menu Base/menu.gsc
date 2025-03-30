CreateMenu()
{
	if(self isVerified())//Verified Menu
	{
		add_menu(self.AIO["menuName"], undefined, self.AIO["menuName"]);
		
			A="A";
			add_option(self.AIO["menuName"], "Sub Menu 1", ::submenu, A, "Sub Menu 1");
				add_menu(A, self.AIO["menuName"], "Sub Menu 1");
					add_option(A, "God Mode", ::InfiniteHealth, true);
					add_option(A, "Debug Exit", ::debugexit);//for testing
					add_option(A, "Option 3", ::test);
					add_option(A, "Option 4", ::test);
					add_option(A, "Option 5", ::test);
					add_option(A, "Option 6", ::test);
					add_option(A, "Option 7", ::test);
					add_option(A, "Option 8", ::test);
					add_option(A, "Option 9", ::test);
					add_option(A, "Option 10", ::test);				
	}
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP")//VIP Menu
	{
			B="B";
			add_option(self.AIO["menuName"], "Sub Menu 2", ::submenu, B, "Sub Menu 2");
				add_menu(B, self.AIO["menuName"], "Sub Menu 2");
					add_option(B, "Option 1", ::test);
					add_option(B, "Option 2", ::test);
					add_option(B, "Option 3", ::test);
					add_option(B, "Option 4", ::test);
					add_option(B, "Option 5", ::test);
	}
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")//Admin Menu
	{
			C="C";
			add_option(self.AIO["menuName"], "Sub Menu 3", ::submenu, C, "Sub Menu 3");
				add_menu(C, self.AIO["menuName"], "Sub Menu 3");
					add_option(C, "Option 1", ::test);
					add_option(C, "Option 2", ::test);
					add_option(C, "Option 3", ::test);
					add_option(C, "Option 4", ::test);
	}
	if(self.status == "Host" || self.status == "Co-Host")//Co-Host Menu
	{
			D="D";
			add_option(self.AIO["menuName"], "Sub Menu 4", ::submenu, D, "Sub Menu 4");
				add_menu(D, self.AIO["menuName"], "Sub Menu 4");
					add_option(D, "Option 1", ::test);
					add_option(D, "Option 2", ::test);
					add_option(D, "Option 3", ::test);
	}
	if(self isHost())//Host only menu
	{
			E="E";
			add_option(self.AIO["menuName"], "Sub Menu 5", ::submenu, E, "Sub Menu 5");
				add_menu(E, self.AIO["menuName"], "Sub Menu 5");
					add_option(E, "Option 1", ::test);
					add_option(E, "Option 2", ::test);
	}
	if(self.status == "Host" || self.status == "Co-Host")//only co-host has access to the player menu 
	{
			add_option(self.AIO["menuName"], "Client Options", ::submenu, "PlayersMenu", "Client Options");
				add_menu("PlayersMenu", self.AIO["menuName"], "Client Options");
					for (i = 0; i < 18; i++)
					add_menu("pOpt " + i, "PlayersMenu", "");
					
			F="F";
			add_option(self.AIO["menuName"], "All Clients", ::submenu, F, "All Clients");
				add_menu(F, self.AIO["menuName"], "All Clients");
					add_option(F, "Unverify All", ::changeVerificationAllPlayers, "Unverified");
					add_option(F, "Verify All", ::changeVerificationAllPlayers, "Verified");
	}
}

updatePlayersMenu()
{
	self endon("disconnect");
	
	self.menu.menucount["PlayersMenu"] = 0;
	
	for (i = 0; i < 18; i++)
	{
		player = level.players[i];
		playerName = getPlayerName(player);
		playersizefixed = level.players.size - 1;
		
        if(self.menu.curs["PlayersMenu"] > playersizefixed)
        {
            self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
            self.menu.curs["PlayersMenu"] = playersizefixed;
        }
		
		add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
			add_menu("pOpt " + i, "PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName);
				add_option("pOpt " + i, "Status", ::submenu, "pOpt " + i + "_3", "[" + verificationToColor(player.status) + "^7] " + playerName);
					add_menu("pOpt " + i + "_3", "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
						add_option("pOpt " + i + "_3", "Unverify", ::changeVerificationMenu, player, "Unverified");
						add_option("pOpt " + i + "_3", "^3Verify", ::changeVerificationMenu, player, "Verified");
						add_option("pOpt " + i + "_3", "^4VIP", ::changeVerificationMenu, player, "VIP");
						add_option("pOpt " + i + "_3", "^1Admin", ::changeVerificationMenu, player, "Admin");
						add_option("pOpt " + i + "_3", "^5Co-Host", ::changeVerificationMenu, player, "Co-Host");
						
		if(!player isHost())//makes it so no one can harm the host
		{
				add_option("pOpt " + i, "Options", ::submenu, "pOpt " + i + "_2", "[" + verificationToColor(player.status) + "^7] " + playerName);
					add_menu("pOpt " + i + "_2", "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
						add_option("pOpt " + i + "_2", "Kill Player", ::killPlayer, player);
		}
	}
}

add_menu(Menu, prevmenu, menutitle)
{
    self.menu.getmenu[Menu] = Menu;
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

_openMenu()
{
	self.recreateOptions = true;
	self freezeControlsallowlook(true);
	self setClientUiVisibilityFlag("hud_visible", false);
	self enableInvulnerability();//do not remove
	
	self playsoundtoplayer("mpl_flagcapture_sting_friend",self);//opening menu sound
	self showHud();//opening menu effects
    
	self thread StoreText(self.CurMenu, self.CurTitle);
	self updateScrollbar();
	
	self.menu.open = true;
	self.recreateOptions = false;
}

_closeMenu()
{
	self freezeControlsallowlook(false);
	
	//do not remove
	if(!self.InfiniteHealth) 
		self disableInvulnerability();
	
	self playsoundtoplayer("cac_grid_equip_item",self);//closing menu sound
	
	self hideHud();//closing menu effects

	self setClientUiVisibilityFlag("hud_visible", true);
	self.menu.open = false;
}

giveMenu()
{
	if(self isVerified())
	{
		if(!self.MenuInit)
		{
			self.MenuInit = true;
			self thread MenuInit();
		}
	}
}

destroyMenu()
{
	self.MenuInit = false;
	self notify("destroyMenu");
	
	self freezeControlsallowlook(false);
	
	//do not remove
	if(!self.InfiniteHealth) 
		self disableInvulnerability();
	
	if(isDefined(self.AIO["options"]))//do not remove this
	{
		for(i = 0; i < self.AIO["options"].size; i++)
			self.AIO["options"][i] destroy();
	}

	self setClientUiVisibilityFlag("hud_visible", true);
	self.menu.open = false;
	
	wait 0.01;//do not remove this
	//destroys hud elements
	self.AIO["backgroundouter"] destroyElem();
	self.AIO["barclose"] destroyElem();
	self.AIO["background"] destroyElem();
	self.AIO["scrollbar"] destroyElem();
	self.AIO["bartop"] destroyElem();
	self.AIO["barbottom"] destroyElem();
	
	//destroys text elements
	self.AIO["title"] destroy();
	self.AIO["closeText"] destroy();
	self.AIO["status"] destroy();
}

submenu(input, title)
{
	if(!self.isOverflowing)
	{
		if(isDefined(self.AIO["options"]))//do not remove this
		{		
			for(i = 0; i < self.AIO["options"].size; i++)
				self.AIO["options"][i] affectElement("alpha", 0, 0);
		}
		self.AIO["title"] affectElement("alpha", 0, 0);
	}

	if (input == self.AIO["menuName"]) 
		self thread StoreText(input, self.AIO["menuName"]);
	else 
		if (input == "PlayersMenu")
		{
			self updatePlayersMenu();
			self thread StoreText(input, "Client Options");
		}
		else 
			self thread StoreText(input, title);
			
	self.CurMenu = input;
	self.CurTitle = title;
	
	self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
	self.menu.curs[input] = self.menu.scrollerpos[input];
	
	if(!self.isOverflowing)
	{
		if(isDefined(self.AIO["options"]))//do not remove this
		{		
			for(i = 0; i < self.AIO["options"].size; i++)
				self.AIO["options"][i] affectElement("alpha", .2, 1);
		}
		self.AIO["title"] affectElement("alpha", .2, 1);
	}
	
	self updateScrollbar();
	self.isOverflowing = false;
}



