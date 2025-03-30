CreateMenu()
{
	self add_menu(self.menuname, undefined, "Unverified");
	self add_option(self.menuname, "Self Menu", ::submenu, "SubMenu1", "Self Menu");
	self add_option(self.menuname, "Menu Settings", ::submenu, "SubMenu18", "Menu Settings");
	self add_option(self.menuname, "Lobby Menu", ::submenu, "SubMenu2", "Lobby Menu");
	self add_option(self.menuname, "Fun Menu", ::submenu, "SubMenu3", "Fun Menu");
	self add_option(self.menuname, "Sky Menu", ::submenu, "SubMenu4", "Sky Menu");
	self add_option(self.menuname, "Sound Menu", ::submenu, "SubMenu5", "Sound Menu");
	self add_option(self.menuname, "Spawnables", ::submenu, "SubMenu6", "Spawnables");
	self add_option(self.menuname, "Forge Menu", ::submenu, "SubMenu7", "Forge Menu");
	self add_option(self.menuname, "Model Menu", ::submenu, "SubMenu8", "Model Menu");
	self add_option(self.menuname, "XP Menu", ::submenu, "SubMenu9", "XP Menu");
	self add_option(self.menuname, "Aimbot Menu", ::submenu, "SubMenu10", "Aimbot Menu");
	self add_option(self.menuname, "Modded Killstreaks", ::submenu, "SubMenu11", "Modded Killstreaks");
	self add_option(self.menuname, "Weapons Menu", ::submenu, "SubMenu12", "Weapons Menu");
	self add_option(self.menuname, "Messages Menu", ::submenu, "SubMenu13", "Messages Menu");
	self add_option(self.menuname, "Camo Menu", ::submenu, "SubMenu14", "Camo Menu");
	self add_option(self.menuname, "Bullets Menu", ::submenu, "SubMenu15", "Bullets Menu");
	self add_option(self.menuname, "Maps Menu", ::submenu, "SubMenu16", "Maps Menu");
	self add_option(self.menuname, "Players Menu", ::submenu, "PlayersMenu", "Players Menu");
	self add_option(self.menuname, "Killstreaks Menu", ::submenu, "SubMenu17", "All Clients");
	self add_option(self.menuname, "All Players Menu", ::submenu, "AllPlayersMenu", "All Players Menu");

	
	self add_menu("SubMenu1", self.menuname, "Host");// Change Verification
	self add_option("SubMenu1", "Option 1");
	self add_option("SubMenu1", "Option 2");
	self add_option("SubMenu1", "Option 3");
	
	self add_menu("SubMenu2", self.menuname, "Admin");// Change Verification
	self add_option("SubMenu2", "Option1");
	self add_option("SubMenu2", "Option2");
	self add_option("SubMenu2", "Option3");
	self add_option("SubMenu2", "Option4");
	self add_option("SubMenu2", "Option5");
	self add_option("SubMenu2", "Option6");
	self add_option("SubMenu2", "Option7");

	self add_menu("SubMenu3", self.menuname, "Admin");// Change Verification
	self add_option("SubMenu3", "Option1");
	self add_option("SubMenu3", "Option2");
	self add_option("SubMenu3", "Option3");
	self add_option("SubMenu3", "Option4");
	self add_option("SubMenu3", "Option5");
	self add_option("SubMenu3", "Option6");
	self add_option("SubMenu3", "Option7");

	
	self add_menu("SubMenu4", self.menuname, "Admin");// Change Verification
	self add_option("SubMenu4", "Option1");
	self add_option("SubMenu4", "Option2");
	self add_option("SubMenu4", "Option3");
	self add_option("SubMenu4", "Option4");
	self add_option("SubMenu4", "Option5");
	self add_option("SubMenu4", "Option6");
	self add_option("SubMenu4", "Option7");
	
	self add_menu("SubMenu5", self.menuname, "Admin");// Change Verification
	self add_option("SubMenu5", "Option1");
	self add_option("SubMenu5", "Option2");
	self add_option("SubMenu5", "Option3");
	self add_option("SubMenu5", "Option4");
	self add_option("SubMenu5", "Option5");
	self add_option("SubMenu5", "Option6");
	self add_option("SubMenu5", "Option7");
	
	self add_menu("SubMenu6", self.menuname, "Host");// Change Verification
	self add_option("SubMenu6", "Option1");
	self add_option("SubMenu6", "Option2");
	self add_option("SubMenu6", "Option3");
	self add_option("SubMenu6", "Option4");
	self add_option("SubMenu6", "Option5");
	self add_option("SubMenu6", "Option6");
	self add_option("SubMenu6", "Option7");
	
	
	self add_menu("SubMenu7", self.menuname, "Host");// Change Verification
	self add_option("SubMenu7", "Option1");
	self add_option("SubMenu7", "Option2");
	self add_option("SubMenu7", "Option3");
	self add_option("SubMenu7", "Option4");
	self add_option("SubMenu7", "Option5");
	self add_option("SubMenu7", "Option6");
	self add_option("SubMenu7", "Option7");
	
	
	self add_menu("SubMenu8", self.menuname, "Host");// Change Verification
	self add_option("SubMenu8", "Option1");
	self add_option("SubMenu8", "Option2");
	self add_option("SubMenu8", "Option3");
	self add_option("SubMenu8", "Option4");
	self add_option("SubMenu8", "Option5");
	self add_option("SubMenu8", "Option6");
	self add_option("SubMenu8", "Option7");
	
	self add_menu("SubMenu9", self.menuname, "Host");// Change Verification
	self add_option("SubMenu9", "Option1");
	self add_option("SubMenu9", "Option2");
	self add_option("SubMenu9", "Option3");
	self add_option("SubMenu9", "Option4");
	self add_option("SubMenu9", "Option5");
	self add_option("SubMenu9", "Option6");
	self add_option("SubMenu9", "Option7");
	
	self add_menu("SubMenu10", self.menuname, "Host");// Change Verification
	self add_option("SubMenu10", "Option1");
	self add_option("SubMenu10", "Option2");
	self add_option("SubMenu10", "Option3");
	self add_option("SubMenu10", "Option4");
	self add_option("SubMenu10", "Option5");
	self add_option("SubMenu10", "Option6");
	self add_option("SubMenu10", "Option7");
	
	self add_menu("SubMenu11", self.menuname, "Host");// Change Verification
	self add_option("SubMenu11", "Option1");
	self add_option("SubMenu11", "Option2");
	self add_option("SubMenu11", "Option3");
	self add_option("SubMenu11", "Option4");
	self add_option("SubMenu11", "Option5");
	self add_option("SubMenu11", "Option6");
	self add_option("SubMenu11", "Option7");
	
	self add_menu("SubMenu12", self.menuname, "Host");// Change Verification
	self add_option("SubMenu12", "Option1");
	self add_option("SubMenu12", "Option2");
	self add_option("SubMenu12", "Option3");
	self add_option("SubMenu12", "Option4");
	self add_option("SubMenu12", "Option5");
	self add_option("SubMenu12", "Option6");
	self add_option("SubMenu12", "Option7");
	
	self add_menu("SubMenu13", self.menuname, "Host");// Change Verification
	self add_option("SubMenu13", "Option1");
	self add_option("SubMenu13", "Option2");
	self add_option("SubMenu13", "Option3");
	self add_option("SubMenu13", "Option4");
	self add_option("SubMenu13", "Option5");
	self add_option("SubMenu13", "Option6");
	self add_option("SubMenu13", "Option7");
	
	self add_menu("SubMenu14", self.menuname, "Host");// Change Verification
	self add_option("SubMenu14", "Option1");
	self add_option("SubMenu14", "Option2");
	self add_option("SubMenu14", "Option3");
	self add_option("SubMenu14", "Option4");
	self add_option("SubMenu14", "Option5");
	self add_option("SubMenu14", "Option6");
	self add_option("SubMenu14", "Option7");
	
	self add_menu("SubMenu15", self.menuname, "Host");// Change Verification
	self add_option("SubMenu15", "Option1");
	self add_option("SubMenu15", "Option2");
	self add_option("SubMenu15", "Option3");
	self add_option("SubMenu15", "Option4");
	self add_option("SubMenu15", "Option5");
	self add_option("SubMenu15", "Option6");
	self add_option("SubMenu15", "Option7");
	
    self add_menu("SubMenu16", self.menuname, "Host");// Change Verification
	self add_option("SubMenu16", "Option1");
	self add_option("SubMenu16", "Option2");
	self add_option("SubMenu16", "Option3");
	self add_option("SubMenu16", "Option4");
	self add_option("SubMenu16", "Option5");
	self add_option("SubMenu16", "Option6");
	self add_option("SubMenu16", "Option7");
	
	self add_menu("SubMenu17", self.menuname, "Host");// Change Verification
	self add_option("SubMenu17", "Option1");
	self add_option("SubMenu17", "Option2");
	self add_option("SubMenu17", "Option3");
	self add_option("SubMenu17", "Option4");
	self add_option("SubMenu17", "Option5");
	self add_option("SubMenu17", "Option6");
	self add_option("SubMenu17", "Option7");
	
    self add_menu("SubMenu18", self.menuname, "Admin");// Change Verification
	
	self add_option("SubMenu18", "Header Shaders", ::submenu, "HeadShade", "Header Shaders");
    self add_menu("HeadShade", "SubMenu18", "Verified");// Change Verification
    
    self add_option("HeadShade", "Ephipany", ::changeShader, shader("Bull"));
    self add_option("HeadShade", "Snake", ::changeShader, shader("Snake"));
    self add_option("HeadShade", "Advanced Warfare", ::changeShader, shader("AdvWarfare"));
    self add_option("HeadShade", "Ghosts", ::changeShader, shader("Ghosts"));
    self add_option("HeadShade", "Zombies", ::changeShader, shader("Zombies"));
    self add_option("HeadShade", "100$", ::changeShader, shader("Ben"));
    self add_option("HeadShade", "Stabber", ::changeShader, shader("Stabber"));
    self add_option("HeadShade", "Graffiti", ::changeShader, shader("Graffiti"));
    self add_option("HeadShade", "Prestige 9", ::changeShader, shader("Prestige9"));
    self add_option("HeadShade", "Prestige 10", ::changeShader, shader("Prestige10"));
    self add_option("HeadShade", "Smoke", ::changeShader, shader("Smoke"));
    self add_option("HeadShade", "Tac Mask", ::changeShader, shader("Tacmask"));
    self add_option("HeadShade", "Precision", ::changeShader, shader("Precision"));
    self add_option("HeadShade", "VSAT", ::changeShader, shader("VSAT"));
    self add_option("HeadShade", "Movie Star", ::changeShader, shader("Star"));
    self add_option("HeadShade", "Master Killer", ::changeShader, shader("Master"));
    self add_option("HeadShade", "Assault", ::changeShader, shader("Assault"));
             
	
    self add_option("SubMenu18", "Menu Colors", ::submenu, "SubColors", "Menu Colors");
    self add_menu("SubColors", "SubMenu18", "Verified");// Change Verification
	
	
	self add_option("SubColors", "Red", ::setMenuColor, (1, 0, 0));
	self add_option("SubColors", "Blue", ::setMenuColor, (0, 0, 1));
	self add_option("SubColors", "Cool Blue", ::setMenuColor, (0, 0.502, 1));
	self add_option("SubColors", "Light Blue", ::setMenuColor, (0.157, 0.804, 0.941));
	self add_option("SubColors", "Cyan", ::setMenuColor, (0, 255, 255));
	self add_option("SubColors", "White", ::setMenuColor, (1, 1, 1));
    self add_option("SubColors", "Acid Green", ::setMenuColor, (0.047, 0.910, 0));
	self add_option("SubColors", "Purple", ::setMenuColor, (0.502, 0, 1));
	self add_option("SubColors", "Orange", ::setMenuColor, (1, 0.502, 0));
	self add_option("SubColors", "Gray", ::setMenuColor, (0.502, 0.502, 0.502));
	self add_option("SubColors", "Pink", ::setMenuColor, (1, 0, 1));
	self add_option("SubColors", "Yellow", ::setMenuColor, (1, 1, 0));
	
	self add_option("SubMenu18", "Scrollbar Style", ::ToggleScroll);
	self add_option("SubMenu18", "Toggle Animation", ::ToggleAni);
	
	self add_menu("AllPlayersMenu", self.menuname, "Host");// Change Verification
	self add_option("AllPlayersMenu", "Option1");
	self add_option("AllPlayersMenu", "Option2");
	self add_option("AllPlayersMenu", "Option3");
	self add_option("AllPlayersMenu", "Option4");
	self add_option("AllPlayersMenu", "Option5");
	self add_option("AllPlayersMenu", "Option6");
	self add_option("AllPlayersMenu", "Option7");

	self add_menu("PlayersMenu", self.menuname, "Co-Host");// Change Verification
	for (i = 0; i < 15; i++)
	{ self add_menu("pOpt " + i, "PlayersMenu", "Co-Host"); }
}

updatePlayersMenu()
{
	self.menu.menucount["PlayersMenu"] = 0;
	for (i = 0; i < 14; i++)
	{
		player = level.players[i];
		playerName = getPlayerName(player);

		playersizefixed = level.players.size - 1;
		if(self.menu.curs["PlayersMenu"] > playersizefixed)
		{
			self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
			self.menu.curs["PlayersMenu"] = playersizefixed;
		}

		self add_option("PlayersMenu", playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
	
		self add_menu_alt("pOpt " + i, "PlayersMenu");
		self add_option("pOpt " + i, "Give Co-Host", ::changeVerificationMenu, player, "Co-Host");
		self add_option("pOpt " + i, "Give Admin", ::changeVerificationMenu, player, "Admin");
		self add_option("pOpt " + i, "Give VIP", ::changeVerificationMenu, player, "VIP");
		self add_option("pOpt " + i, "Verify", ::changeVerificationMenu, player, "Verified");
		self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");		
	}
}
add_menu_alt(Menu, prevmenu)
{
	self.menu.getmenu[Menu] = Menu;
	self.menu.menucount[Menu] = 0;
	self.menu.previousmenu[Menu] = prevmenu;
}

add_menu(Menu, prevmenu, status)
{
    self.menu.status[Menu] = status;
	self.menu.getmenu[Menu] = Menu;
	self.menu.scrollerpos[Menu] = 0;
	self.menu.curs[Menu] = 0;
	self.menu.menucount[Menu] = 0;
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

openMenu()
{
    self freezeControls(false);
    self StoreText(self.menuname, self.menuname);
    
    self.EPI["animation"] FadeOverTime(0.30);
    self.EPI["animation"].alpha = 1;
	
	self.EPI["scroller"] FadeOverTime(0.30);
	self.EPI["scroller"].alpha = 1;

    self.EPI["background"] FadeOverTime(0.30);
    self.EPI["background"].alpha = 0.8;
    
    self.EPI["backgrounddesign"] FadeOverTime(0.30);
    self.EPI["backgrounddesign"].alpha = 0.50;
    
    self.EPI["header"] FadeOverTime(0.30);
    self.EPI["header"].alpha = 1;
    
    self.Private["header"] FadeOverTime(0.30);
    self.Private["header"].alpha = 1;
	
	self.EPI["line"] MoveOverTime(0.30);
	self.EPI["line"].y = -50;	
	
	self.EPI["line2"] MoveOverTime(0.30);
	self.EPI["line2"].y = -50;
	
    self.EPI["line3"] MoveOverTime(0.30);
	self.EPI["line3"].y = 37; //15
	
	//STEALTH MENU
	
	self.EPI["background"].archived = false;
	self.EPI["scroller"].archived = false;
	self.EPI["header"].archived = false;
	self.EPI["line"].archived = false;
	self.EPI["line2"].archived = false;
	self.EPI["line3"].archived = false;
	self.EPI["animation"].archived = false;

    self updateScrollbar();
    self.menu.open = true;
}

closeMenu()
{
   
    self.EPI["options"] FadeOverTime(0.3);
    self.EPI["options"].alpha = 0;
    
    self.EPI["status"] FadeOverTime(0.3);
    self.EPI["status"].alpha = 0;
    
    self.EPI["background"] FadeOverTime(0.3);
    self.EPI["background"].alpha = 0;
    
    self.EPI["backgrounddesign"] FadeOverTime(0.3);
    self.EPI["backgrounddesign"].alpha = 0;
    
    self.EPI["header"] FadeOverTime(0.3);
    self.EPI["header"].alpha = 0;
    
    self.Private["header"] FadeOverTime(0.3);
    self.Private["header"].alpha = 0;
    
    self.EPI["animation"] FadeOverTime(0.3);
    self.EPI["animation"].alpha = 0;

    self.EPI["title"] FadeOverTime(0.30);
    self.EPI["title"].alpha = 0;
    
	self.EPI["line"] MoveOverTime(0.30);
	self.EPI["line"].y = -550;
	
	self.EPI["line2"] MoveOverTime(0.30);
	self.EPI["line2"].y = -550;
	
	self.EPI["line3"] MoveOverTime(0.30);
	self.EPI["line3"].y = -550;

	self.EPI["scroller"] MoveOverTime(0.30);
	self.EPI["scroller"].y = -510;
	
    self.menu.open = false;
}

destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
	wait 0.3;

	player notify("destroyMenu");
}

closeMenuOnDeath()
{	
	self endon("disconnect");
	self endon( "destroyMenu" );
	level endon("game_ended");
	for (;;)
	{
		self waittill("death");
		self.menu.closeondeath = true;
		self submenu(self.menuname, self.menuname);
		closeMenu();
		self.menu.closeondeath = false;
	}
}

submenu(input, title)
{
	if (verificationToNum(self.status) >= verificationToNum(self.menu.status[input]))
	{
		self.menu.options destroy();

		if (input == self.menuname)
			self thread StoreText(input, self.menuname);
		else if (input == "PlayersMenu")
		{
			self updatePlayersMenu();
			self thread StoreText(input, "Players");
		}
		else
			self thread StoreText(input, title);
			
		self.CurMenu = input;
		
		self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
		self.menu.curs[input] = self.menu.scrollerpos[input];
		
		if (!self.menu.closeondeath)
		{
			self updateScrollbar();
   		}
    }
    else
    {
		self iPrintln("^1Only Players With ^1" + verificationToColor(self.menu.status[input]) + "^1Can Access This Menu!");
    }
}

