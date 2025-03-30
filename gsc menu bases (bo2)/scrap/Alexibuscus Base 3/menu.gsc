CreateMenu()
{
	self add_menu("Main Menu", undefined, "Unverified");
	self add_option("Main Menu", "Main Mods", ::submenu, "main", "Main Mods");
	self add_option("Main Menu", "Menu Settings", ::submenu, "sett", "Menu Settings");
	self add_option("Main Menu", "Players Menu", ::submenu, "PlayersMenu", "Players Menu");
	self add_option("Main Menu", "SubMenu4");
	self add_option("Main Menu", "SubMenu5");
	self add_option("Main Menu", "SubMenu6");
	self add_option("Main Menu", "SubMenu7");
	self add_option("Main Menu", "SubMenu8");
	self add_option("Main Menu", "SubMenu9");
	self add_option("Main Menu", "SubMenu10");
	self add_option("Main Menu", "SubMenu11");
	self add_option("Main Menu", "SubMenu12");
	self add_option("Main Menu", "SubMenu13");
	self add_option("Main Menu", "SubMenu14");
	self add_option("Main Menu", "SubMenu15");
	self add_option("Main Menu", "SubMenu16");
	self add_option("Main Menu", "SubMenu17");
	self add_option("Main Menu", "SubMenu18");
	self add_option("Main Menu", "SubMenu19");
	self add_option("Main Menu", "SubMenu20");
	
	self add_menu("main", "Main Menu", "VIP");
	self add_option("main", "Godmode", ::godmode);
	self add_option("main", "SubOption2", ::test);
	self add_option("main", "SubOption3", ::test);
	self add_option("main", "SubOption4", ::test);
	self add_option("main", "SubOption5", ::test);
	self add_option("main", "SubOption6", ::test);

	self add_menu("sett", "Main Menu", "Verified");
	self add_option("sett", "Text Glow", ::submenu, "glowt", "Text Glow");
	self add_option("sett", "Menu Theme", ::submenu, "theme", "Menu Theme");
	self add_option("sett", "Header Shader", ::submenu, "head", "Header Shaders");
	self add_option("sett", "Menu Positioning", ::submenu, "posit", "Menu Position");
	self add_option("sett", "Text Colour", ::submenu, "textc", "Text Colour");
	self add_option("sett", "Tog Animation(stick)", ::initAnimDvar);
	self add_option("sett", "Tog Stealth(stick)", ::initStealthDvar);
	
	self add_menu("textc", "sett", "Verified");
	self add_option("textc", "White", ::textcolor, (1,1,1));
	self add_option("textc", "Red", ::textcolor, (1,0,0));
	self add_option("textc", "Orange", ::textcolor, (1,0.503,0));
	self add_option("textc", "Yellow", ::textcolor, (1,1,0));
	self add_option("textc", "Green", ::textcolor, (0,1,0));
	self add_option("textc", "Blue", ::textcolor, (0,0,1));
	self add_option("textc", "Aqua", ::textcolor, (0,0.4,1.2));
	self add_option("textc", "Pink", ::textcolor, (1,0,1));
	self add_option("textc", "Purple", ::textcolor, (0.7,0,0.7));
	self add_option("textc", "Black", ::textcolor, (0,0,0));
	self add_option("textc", "Random", ::textcolor, ((randomint(255)/255,randomint(255)/255,randomint(255)/255)));
	
	self add_menu("head", "sett", "Verified");
	self add_option("head", "Default", ::setheader, "emblem_bg_movie_star");
	self add_option("head", "Plain", ::setheader, "white");
	self add_option("head", "Bo2 Title", ::setheader, "menu_mp_title_screen");
	self add_option("head", "Aqua", ::setheader, "emblem_bg_aqua");
	self add_option("head", "PG Master", ::setheader, "emblem_bg_pg_game_master");
	self add_option("head", "Nuked Out", ::setheader, "emblem_bg_bo2_nuked_out");
	self add_option("head", "Nuketown Zombies", ::setheader, "emblem_bg_nuketown_z");
	self add_option("head", "CoD Ghosts", ::setheader, "emblem_bg_ghost");
	self add_option("head", "Smoke Equip", ::setheader, "emblem_bg_equip_smoke");
	self add_option("head", "TDM Vanquisher", ::setheader, "emblem_bg_tdm_vanquisher");
	self add_option("head", "FFA Vanquisher", ::setheader, "emblem_bg_ffa_vanquisher");
	self add_option("head", "Comics", ::setheader, "em_bg_ani_comics");
	self add_option("head", "Afterlife", ::setheader, "em_bg_ani_afterlife");
	self add_option("head", "Weaponized", ::setheader, "em_bg_ani_w115");
	self add_option("head", "Paladin", ::setheader, "em_bg_ani_armor");
	self add_option("head", "Octane", ::setheader, "em_bg_ani_octane");
	self add_option("head", "UK", ::setheader, "em_bg_flag_united_kingdom");
	self add_option("head", "-->Next Page", ::submenu, "head2", "Header Shaders");
	self add_menu("head2", "head", "Verified");
	self add_option("head2", "Prestige Master", ::setheader, "em_bg_prestige_11");
	self add_option("head2", "Prestige 10", ::setheader, "em_bg_prestige_10");
	self add_option("head2", "Prestige 9", ::setheader, "em_bg_prestige_9");
	self add_option("head2", "Prestige 8", ::setheader, "em_bg_prestige_8");
	
	self add_menu("theme", "sett", "Verified");
	self add_option("theme", "Default", ::settheme, (0,0.3,1.1));
	self add_option("theme", "Red", ::settheme, (1,0,0));
	self add_option("theme", "Blue", ::settheme, (0,0,1));
	self add_option("theme", "Green", ::settheme, (0,1,0));
	self add_option("theme", "Purple", ::settheme, (0.7,0,0.7));
	self add_option("theme", "Pink", ::settheme, (1,0,1));
	self add_option("theme", "Yellow", ::settheme, (1,1,0));
	self add_option("theme", "Orange", ::settheme, (1,0.503,0));
	self add_option("theme", "White", ::settheme, (1,1,1));
	self add_option("theme", "Black", ::settheme, (0,0,0));
	
	self add_menu("posit", "sett", "Verified");
	self add_option("posit", "Move Left", ::MoveMenuLeft);
	self add_option("posit", "Move Right", ::MoveMenuRight);
	
	self add_menu("glowt", "sett", "Verified");
	self add_option("glowt", "Default", ::settextglow, (0,0.4,1.2), "Default - ^5Aqua");
	self add_option("glowt", "Blue", ::settextglow, (0,0,1), "^4Blue");
	self add_option("glowt", "Yellow", ::settextglow, (1,1,0), "^3Yellow");
	self add_option("glowt", "Orange", ::settextglow, (1,0.503,0), "^3Orange");
	self add_option("glowt", "Green", ::settextglow, (0,1,0), "^2Green");
	self add_option("glowt", "Red", ::settextglow, (1,0,0), "^1Red");
	self add_option("glowt", "Purple", ::settextglow, (0.6,0,0.6), "^6Purple");
	self add_option("glowt", "Pink", ::settextglow, (1,0,1), "^6Pink");
	self add_option("glowt", "Black", ::settextglow, (0,0,0), "^0Black");
	self add_option("glowt", "White", ::settextglow, (1,1,1), "^7White");
	self add_option("glowt", "Random", ::settextglow, ((randomint(255)/255,randomint(255)/255,randomint(255)/255)), "Randomed!");

    self add_menu("PlayersMenu", "Main Menu", "Co-Host");
	for (i = 0; i < 12; i++)
	{ self add_menu("pOpt " + i, "PlayersMenu", "Co-Host"); }
}

updatePlayersMenu()
{
	self.menu.menucount["PlayersMenu"] = 0;
	for (i = 0; i < 12; i++)
	{
		player = level.players[i];
		playerName = getPlayerName(player);
		
		playersizefixed = level.players.size - 1;
		if(self.menu.curs["PlayersMenu"] > playersizefixed)
		{ 
			self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
			self.menu.curs["PlayersMenu"] = playersizefixed;
		}
		
		self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
	
		self add_menu_alt("pOpt " + i, "PlayersMenu");
		self add_option("pOpt " + i, "Player Status", ::submenu, "pOpt " + i + "_S", "Player Status");
		if(!self isHost()) //no one can mod host :P
			self add_option("pOpt " + i, "Player Options", ::submenu, "pOpt " + i + "_O", "Player Options");
		if(self isHost())
		{
			self add_option("pOpt " + i, "Clear Co-Host List", ::clearCoList);
			self add_option("pOpt " + i, "Clear VIP List", ::clearVIPList);
			self add_option("pOpt " + i, "Clear Blacklist", ::clearBlackList);
		}
		
		self add_menu("pOpt " + i + "_S", "pOpt " + i);
		self add_option("pOpt " + i + "_S", "Give Co-Host", ::changeVerificationMenu, player, "Co-Host");
		self add_option("pOpt " + i + "_S", "Give Admin", ::changeVerificationMenu, player, "Admin");
		self add_option("pOpt " + i + "_S", "Give VIP", ::changeVerificationMenu, player, "VIP");
		self add_option("pOpt " + i + "_S", "Verify", ::changeVerificationMenu, player, "Verified");
		self add_option("pOpt " + i + "_S", "Unverify", ::changeVerificationMenu, player, "Unverified");
		self add_option("pOpt " + i + "_S", "+Co-Host List", ::addCoList, player);
		self add_option("pOpt " + i + "_S", "+VIP List", ::addVIPList, player); 
		self add_option("pOpt " + i + "_S", "+Blacklist", ::addBlackList, player);
		
		self add_menu("pOpt " + i + "_O", "pOpt " + i);
		self add_option("pOpt " + i + "_O", "Option 1");
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












