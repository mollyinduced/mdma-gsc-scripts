CreateMenu()
{
	if(self isVerified())
	{
		add_menu("Main Menu", undefined, "Main Menu");
		
			A="A";
			add_option("Main Menu", "Sub Menu 1", ::submenu, A, "Sub Menu 1");
				add_menu(A, "Main Menu", "Sub Menu 1");
					add_option(A, "God Mode", ::InfiniteHealth, true);
					add_option(A, "Debug Exit", ::debugexit);
					add_option(A, "Option 3", ::test);
					add_option(A, "Option 4", ::test);
					add_option(A, "Option 5", ::test);
					add_option(A, "Option 6", ::test);
					add_option(A, "Option 7", ::test);
					add_option(A, "Option 8", ::test);
					add_option(A, "Option 9", ::test);
					add_option(A, "Option 10", ::test);				
	}
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP")
	{
			B="B";
			add_option("Main Menu", "Sub Menu 2", ::submenu, B, "Sub Menu 2");
				add_menu(B, "Main Menu", "Sub Menu 2");
					add_option(B, "Option 1", ::test);
					add_option(B, "Option 2", ::test);
					add_option(B, "Option 3", ::test);
					add_option(B, "Option 4", ::test);
					add_option(B, "Option 5", ::test);
	}
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
	{
			C="C";
			add_option("Main Menu", "Sub Menu 3", ::submenu, C, "Sub Menu 3");
				add_menu(C, "Main Menu", "Sub Menu 3");
					add_option(C, "Option 1", ::test);
					add_option(C, "Option 2", ::test);
					add_option(C, "Option 3", ::test);
					add_option(C, "Option 4", ::test);
	}
	if(self.status == "Host" || self.status == "Co-Host")
	{
			D="D";
			add_option("Main Menu", "Sub Menu 4", ::submenu, D, "Sub Menu 4");
				add_menu(D, "Main Menu", "Sub Menu 4");
					add_option(D, "Option 1", ::test);
					add_option(D, "Option 2", ::test);
					add_option(D, "Option 3", ::test);
	}
	if(self isHost())
	{
			E="E";
			add_option("Main Menu", "Sub Menu 5", ::submenu, E, "Sub Menu 5");
				add_menu(E, "Main Menu", "Sub Menu 5");
					add_option(E, "Option 1", ::test);
					add_option(E, "Option 2", ::test);
	}
	if(self.status == "Host" || self.status == "Co-Host")
	{
			add_option("Main Menu", "Client Options", ::submenu, "PlayersMenu", "Client Options");
				add_menu("PlayersMenu", "Main Menu", "Client Options");
					for (i = 0; i < 18; i++)
					add_menu("pOpt " + i, "PlayersMenu", "");
					
			F="F";
			add_option("Main Menu", "All Clients", ::submenu, F, "All Clients");
				add_menu(F, "Main Menu", "All Clients");
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
						
		if(!player isHost())
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
	self enableInvulnerability();
	
	self thread StoreText(self.CurMenu, self.CurTitle);
	
	self.Radiant["title"].alpha = 1;
	self.Radiant["root"].alpha = 1;
	self.Radiant["value"].alpha = 1;
	self.Radiant["background"].alpha = 0.6;
	self.Radiant["scrollbar"].alpha = 1;
	self.Radiant["bartop"].alpha = 0.5;
	self.Radiant["value2"].alpha = 1;
	self.Radiant["slash"].alpha = 1;
	self.Radiant["header"].alpha = 1;
	
	if(!self.menu.menuopt[self.CurMenu].size <= 5)
	{
		self.Radiant["barbottom"].alpha = 0.5;
		self.Radiant["arrowtop"].alpha = 1;
		self.Radiant["arrowbottom"].alpha = 1;
	}
	
	self updateScrollbar();
	self.menu.open = true;
	self.recreateOptions = false;
}

_closeMenu()
{
	self freezeControlsallowlook(false);
	
	if(!self.InfiniteHealth) 
		self disableInvulnerability();
	
	self playsoundtoplayer("cac_grid_equip_item",self);
	
	if(isDefined(self.Radiant["options"]))
	{
		for(i = 0; i < self.Radiant["options"].size; i++)
			self.Radiant["options"][i] destroy();
	}
	
	self.Radiant["title"].alpha = 0;
	self.Radiant["slash"].alpha = 0;
	self.Radiant["value"].alpha = 0;
	self.Radiant["value2"].alpha = 0;
	self.Radiant["arrowtop"].alpha = 0;
	self.Radiant["arrowbottom"].alpha = 0;
	self.Radiant["bartop"].alpha = 0;
	self.Radiant["barbottom"].alpha = 0;
	self.Radiant["background"].alpha = 0;
	self.Radiant["header"].alpha = 0;
	self.Radiant["root"].alpha = 0;
	self.Radiant["scrollbar"].alpha = 0;
	
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
	
	if(isDefined(self.Radiant["options"]))
	{
		for(i = 0; i < self.Radiant["options"].size; i++)
			self.Radiant["options"][i] destroy();
	}

	self.menu.open = false;
	
	wait 0.01;
	self.Radiant["background"] destroyElem();
	self.Radiant["scrollbar"] destroyElem();
	self.Radiant["bartop"] destroyElem();
	self.Radiant["arrowtop"] destroyElem();
	self.Radiant["arrowbottom"] destroyElem();
	self.Radiant["barbottom"] destroyElem();
	self.Radiant["title"] destroy();
	self.Radiant["slash"] destroy();
	self.Radiant["value2"] destroy();
	self.Radiant["value"] destroy();
	self.Radiant["root"] destroy();
	self.Radiant["header"] destroyElem();
}

submenu(input, title)
{
	if (input == "Main Menu") 
		self thread StoreText(input, "Main Menu");
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
	
	self updateScrollbar();
}

