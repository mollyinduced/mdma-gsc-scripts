CreateMenu()
{
	self add_menu(level.menuTitle, undefined, level.menuTitle);
		
	if(self.status == "Creator")
	{
		self add_option(level.menuTitle, "Dev Options", ::submenu, "_dev", "Dev Options");
			self add_menu("_dev", level.menuTitle, "Dev Options");
				self add_option("_dev", "Debug Exit", ::debugexit);
				self add_option("_dev", "Overflow Test", ::stringTest);
				self add_option("_dev", "Kick All Bots", ::kickAllBots);
				self add_option("_dev", "Progress Menu", ::testmenu);
				self add_option("_dev", "Test Progress Bar", ::testProgressBar);
				self add_option("_dev", "Toggle Test " + boolToText(self.testToggle, "^2On", "^1Off"), ::toggleTest);
				self add_option("_dev", "Quick Restart", ::quickRestart);
	}
		
		self add_option(level.menuTitle, "Environment Menu");
		
		F="F";G="G";H="H";I="I";J="J";
		self add_option(level.menuTitle, "Weaponry", ::submenu, F, "Weaponry");
			self add_menu(F, level.menuTitle, "Weaponry");
				self add_option(F, "Take Current Weapon", ::takeCurrentWeapon);
			
		self add_option(level.menuTitle, "Music Playlist");
		self add_option(level.menuTitle, "Teleport Menu");
	
		A="A";
		self add_option(level.menuTitle, "Basic Scripts", ::submenu, A, "Basic Scripts");
			self add_menu(A, level.menuTitle, "Basic Scripts");
				self add_option(A, "God Mode", ::godMode, undefined, undefined, self.godMode);
				self add_option(A, "Pro Mod", ::proMod, undefined, undefined, self.proMod);
				self add_option(A, "Third Person", ::thirdPerson, undefined, undefined, self.thirdPerson);
				self add_option(A, "Return To Spawn", ::returnToSpawn);
				self add_option(A, "Anti-Leave", ::antiLeave, undefined, undefined, level.antiLeave);
				
	if(self.status != "Verified")//VIP Menu
	{
		B="B";K="K";L="L";M="M";N="N";Background="Background";Scrollbar="Scrollbar";Backgroundouter="Backgroundouter";
		proper = strTok("Royal Blue|Raspberry|Skyblue|Hot Pink|Green|Brown|Blue|Red|Orange|Purple|Cyan|Yellow|Black|White","|");
		colors = strTok("34|64|139|135|38|87|135|206|250|255|23|153|0|255|0|101|67|33|0|0|255|255|0|0|255|128|0|153|26|255|0|255|255|255|255|0|0|0|0|255|255|255","|");
		self add_option(level.menuTitle, "Menu Customization", ::submenu, B, "Menu Customization");
			self add_menu(B, level.menuTitle, "Menu Customization");
				self add_option(B, "Menu Instant Open", ::quickMenu, undefined, undefined, self.menu.quick);
				if(self isHost()) self add_option(B, boolToText(level.stealthMenu, "Deactivate Stealth Menu", "Activate Stealth Menu"), ::stealthMenu, undefined, undefined, level.stealthMenu);
				self add_option(B, "Menu Colors", ::submenu, K, "Menu Colors");
					self add_menu(K, B, "Menu Colors");
						self add_option(K, Background, ::submenu, L, Background);
							self add_menu(L, K, Background);
								self add_option(L, "RGB Editor", ::menuColorEditor, Background, (255,255,255));
								for(a=0;a<proper.size;a++)
									self add_option(L, proper[a], ::setHudColor, self getMenuHud(Background),divideColor(int(colors[3*a]),int(colors[(3*a)+1]),int(colors[(3*a)+2])));
								self add_option(L, "^3Reset", ::setHudColor,self getMenuHud(Background),divideColor(255,255,255));
						self add_option(K, Backgroundouter, ::submenu, N, Backgroundouter);
							self add_menu(N, K, Backgroundouter);
								self add_option(N, "RGB Editor", ::menuColorEditor, Backgroundouter, (0,0,0));
								for(a=0;a<proper.size;a++)
									self add_option(N, proper[a], ::setHudColor, self getMenuHud(Backgroundouter),divideColor(int(colors[3*a]),int(colors[(3*a)+1]),int(colors[(3*a)+2])));
								self add_option(N, "^3Reset", ::setHudColor,self getMenuHud(Backgroundouter),divideColor(0,0,0));
						self add_option(K, Scrollbar, ::submenu, M, Scrollbar);
							self add_menu(M, K, Scrollbar);
								self add_option(M, "RGB Editor", ::menuColorEditor, Scrollbar, (0,110,255));
								for(a=0;a<proper.size;a++)
									self add_option(M, proper[a], ::setHudColor, self getMenuHud(Scrollbar),divideColor(int(colors[3*a]),int(colors[(3*a)+1]),int(colors[(3*a)+2])));
								self add_option(M, "^3Reset", ::setHudColor,self getMenuHud(Scrollbar),divideColor(0,110,255));
	
		self add_option(level.menuTitle, "Equipment Add-ons");
		self add_option(level.menuTitle, "Model Manipulation");
	}
	if(self.status != "Verified" && self.status != "VIP")//Admin Menu
	{
		C="C";
		self add_option(level.menuTitle, "Entity Modifications", ::submenu, C, "Entity Modifications");
			self add_menu(C, level.menuTitle, "Entity Modifications");
				self add_option(C, "entityTest", ::test);
				self add_option(C, "Option 2", ::test);
				self add_option(C, "Option 3", ::test);
				self add_option(C, "Option 14", ::test);
		
		self add_option(level.menuTitle, "Zombie Modifications");
		self add_option(level.menuTitle, "Profile Management");
		self add_option(level.menuTitle, "Advanced Scripts");
	}
	if(self.status != "Verified" && self.status != "VIP" && self.status != "Admin")//Co-Host Menu
	{
		D="D";
		self add_option(level.menuTitle, "Server Modifications", ::submenu, D, "Server Modifications");
			self add_menu(D, level.menuTitle, "Server Modifications");
				self add_option(D, "Super Jump", ::toggleSuperJump, undefined, undefined, level.superJump);
				if(self isHost()) self add_option(D, "Force Host " + dvarToText(getDvar("partyMigrate_disabled")), ::forceHost);
				self add_option(D, "Option 17", ::test);
				self add_option(D, "Option 18", ::test);
				self add_option(D, "Option 19", ::test);
		
		self add_option(level.menuTitle, "Spawnables");
		
		self add_option(level.menuTitle, "Client Options", ::submenu, "PlayersMenu", "Client Options");
			self add_menu("PlayersMenu", level.menuTitle, "Client Options");
			
		self add_option(level.menuTitle, "Administration");
		self add_option(level.menuTitle, "Game Modes");
	}
	if(self isHost())//Host only menu
	{
		E="E";
		self add_option(level.menuTitle, "Dvar Debugging", ::submenu, E, "Dvar Debugging");
			self add_menu(E, level.menuTitle, "Dvar Debugging");
				self add_option(E, "Option 20", ::test);
				self add_option(E, "Option 21", ::test);
	}
}

updatePlayersMenu()
{
	self.menu.menucount["PlayersMenu"] = 0;
	
	for (i = 0; i < 8; i++)
	{
		if(isDefined(level.players[i]))
		{
			player = level.players[i];
			playerName = player getPlayerName();
			playersizefixed = level.players.size - 1;
			
	        if(self.menu.curs["PlayersMenu"] > playersizefixed)
	        {
	            self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
	            self.menu.curs["PlayersMenu"] = playersizefixed;
	        }
			
			if((player.status == "Creator" || player.status == "Host") && player != self)
				self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::handsOffHost);
			else if(player == self)
				self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "PlayersMenu" + i + "optmenu", "Options Menu");
			else
				self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "PlayersMenu" + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
					self add_menu("PlayersMenu" + i, "PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName);
						
			self add_option("PlayersMenu" + i, "Verification Menu", ::submenu, "PlayersMenu" + i + "vermenu", "Verification Menu");
				self add_menu("PlayersMenu" + i + "vermenu", "PlayersMenu" + i, "Verification Menu");
				if(self isHost() && !player isHost()){
					self add_option("PlayersMenu" + i + "vermenu", boolToText(!isInCoHostList(player), "Add To Co-Host List", "Remove From Co-Host List"), ::coHostList, player, !isInCoHostList(player) ? true : false);}
					self add_option("PlayersMenu" + i + "vermenu", "Unverify", ::setPlayerVerification, player, "None");
					self add_option("PlayersMenu" + i + "vermenu", "Verify", ::setPlayerVerification, player, "Verified");
					self add_option("PlayersMenu" + i + "vermenu", "VIP", ::setPlayerVerification, player, "VIP");
					self add_option("PlayersMenu" + i + "vermenu", "Admin", ::setPlayerVerification, player, "Admin");
					self add_option("PlayersMenu" + i + "vermenu", "Co-Host", ::setPlayerVerification, player, "Co-Host");

				self add_option("PlayersMenu" + i, "Options Menu", ::submenu, "PlayersMenu" + i + "optmenu", "Options Menu");
				if(player == self)
					self add_menu("PlayersMenu" + i + "optmenu", "PlayersMenu", "Options Menu");
				else
					self add_menu("PlayersMenu" + i + "optmenu", "PlayersMenu" + i, "Options Menu");
						self add_option("PlayersMenu" + i + "optmenu", "Kill Player", ::killPlayer, player);
		}
	}
}

add_menu(Menu, prevmenu, menutitle)
{
    self.menu.scrollerpos[Menu] = 0;
    self.menu.curs[Menu] = 0;
    self.menu.menucount[Menu] = 0;
    self.menu.subtitle[Menu] = menutitle;
    self.menu.previousmenu[Menu] = prevmenu;
}

add_option(Menu, Text, Func, arg1, arg2, toggle)
{
    Num = self.menu.menucount[Menu];
    self.menu.menuopt[Menu][Num] = Text;
    self.menu.menufunc[Menu][Num] = Func;
    self.menu.menuinput[Menu][Num] = arg1;
    self.menu.menuinput1[Menu][Num] = arg2;
    if(isDefined(toggle))
    	self.menu.toggle[Menu][Num] = toggle;
    else
    	self.menu.toggle[Menu][Num] = undefined;
    self.menu.menucount[Menu]++;
}

_openMenu()
{
	self.menu.open = true;
	self StoreHuds();
	self StoreText(self.menu.curTitle);
	self showHud();
	self updateScrollbar();
	self thread continueTitleAnim(true);
}

_closeMenu()
{
	self.menu.open = undefined;
	self playlocalSound("fly_fnp45_mag_in");
	self continueTitleAnim(false);
	self hideHud();
	if(!isDefined(self.menu.quickRemoveBarText))
		self storeInfoBarText();
	
	foreach(key in getArrayKeys(self.AIO.string))
	{
		if(!isDefined(self.menu.quickRemoveBarText))
		{
			if(key != "tabInfo" && key != "entCount")
				self.AIO.string[key] destroy();	
		}
		else
			self.AIO.string[key] destroy();
	}
	if(isDefined(self.AIO.options[0]))
		for(i = 0; i < self.AIO.options.size; i++) 
			self.AIO.options[i] destroy();
	self.AIO.shader["Scrollbar"] destroy();
	if(isDefined(self.AIO.shader["playerInfoBackground"]))
		self.AIO.shader["playerInfoBackground"] destroy();
}

destroyMenu()
{
	self notify("destroyMenu");
	self.hasMenu = undefined;
	if(isDefined(self.menu.open))
		self _closeMenu();

	self.AIO.shader["Background"] thread hudFadenDestroy(0, .2);
	self.AIO.shader["Backgroundouter"] thread hudFadenDestroy(0, .2);
	if(isDefined(self.progressMenuText) && isDefined(self.dotDotHud))
		self.dotDotHud thread hudFadenDestroy(0, .2);
	else
	{
		self.AIO.string["tabInfo"] thread hudFadenDestroy(0, .2);
		self.AIO.string["entCount"] thread hudFadenDestroy(0, .2);
	}
}

lockMenu(type)
{
	self endon("disconnect");
	self endon("destroyMenu");
	level endon("game_ended");
	
	if(!isDefined(self.hasMenu)) return;
	self.menu.Locked = true;
	if(type == "HALF")
	{
		self.stillLocked = true;
		self waittill("unlockHalf");
	}
	if(type == "ALL")
	{
		self.stillLocked = true;
		if(isDefined(self.menu.open))
			self _closeMenu();
		self waittill("unlockMenu");
		if(isAlive(self) && !isDefined(self.menu.open))
			self _openMenu();
		wait .25;
	}
	if(type == "QUICK" || type == "QUICKREMOVEBARTEXT")
	{
		if(type == "QUICK")
			self.stillLocked = true;
		self.menu.quick = true;
		if(type == "QUICKREMOVEBARTEXT")
			self.menu.quickRemoveBarText = true;
		if(isDefined(self.menu.open))
			self _closeMenu();
		self waittill("unlockQuick");
		if(isAlive(self) && !isDefined(self.menu.open))
			self _openMenu();
		if(!isDefined(self.menu.quickCheck))
			self.menu.quick = undefined;
		self.menu.quickRemoveBarText = undefined;
	}
	if(type == "EDITOR")
	{
		for(i = 0; i < self.AIO.options.size; i++) 
			self.AIO.options[i] destroy();
		self waittill("unlockEditor");
		self StoreText(undefined, true);
		self updateScrollbar();
	}
	self.menu.Locked = undefined;
}

unlockMenu(menu)
{
	if(isDefined(self.hasMenu))
	{
		if(!isDefined(menu))
			self notify("unlockMenu");
		else
			self notify(menu);
		
		if(isDefined(self.stillLocked) && !self.stillLocked)
			self.menu.Locked = undefined;
	}
	self.stillLocked = undefined;
}

inMenu()
{
	if(isDefined(self.hasMenu) && isDefined(self.menu.open))
		return true;
	return false;
}

closeMenuOnDeath()
{	
	self endon("disconnect");
	self endon("destroyMenu");
	level endon("game_ended");
	
	for(;;)
	{
		self waittill("death");
		//if(isLastAlive())
			wait .15;
	
		//self notify("died");
		if(self inMenu())
			self _closeMenu();
		self resetBooleans();
		self refreshMenu();
	}
}

closeMenuOnGameEnd()
{
	self endon("disconnect");
    self endon("destroyMenu");
	
	level waittill("game_ended");
	self thread destroyMenu();
}

submenu(input, title)
{	
	self.menu.curMenu = input;
	self.menu.curTitle = title;

	for(i = 0; i < self.AIO.options.size; i++)
		self.AIO.options[i].alpha = 0;
	self.AIO.string["title"].alpha = 0;
	
	if(input == "PlayersMenu")
		self updatePlayersMenu();
	
	if(title != level.menuTitle)
		self continueTitleAnim(false);
	self StoreText(title);
	
	self.menu.scrollerpos[input] = self.menu.curs[input];
	self.menu.curs[input] = self.menu.scrollerpos[input];
	
	for(i = 0; i < self.AIO.options.size; i++)
		self.AIO.options[i] affectElement("alpha", .2, 1);
	self.AIO.string["title"] affectElement("alpha", .2, 1);

	self updateScrollbar();
}

refreshMenu()
{
	savedCurs = [];
	foreach(key in getArrayKeys(self.menu.curs))
		savedCurs[key] = self.menu.curs[key];
	self createMenu();
	if(self.status != "Verified" && self.status != "VIP" && self.status != "Admin")
		self updatePlayersMenu();
	foreach(key in getArrayKeys(savedCurs))
		self.menu.curs[key] = savedCurs[key];
	if(self inMenu())
		self updateScrollbar();
}

refreshMenuAllPlayers()
{
	foreach(player in level.players)
		if(isDefined(player.hasMenu) && player isVerified())
			player refreshMenu();
}

