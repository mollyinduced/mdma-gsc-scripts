/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : menu
*	 Description : Includes functions related to menu options
*	 Date : 2015/06/21 - 12:22:31	
*
*/

AddOptions()
{
	self endon("disconnect");
	
	i = "main";
	self NewTopLevelMenu(i, undefined, "Main Mods", "Verified");
	self NewOption(i, "Test Option 1", ::test);
	self NewOption(i, "Test Option 2", ::test);
	self NewOption(i, "Test Option 3", ::test);
	self NewOption(i, "Test Option 4", ::test);
	self NewOption(i, "Test Option 5", ::test);
	self NewOption(i, "Test Option 6", ::test);
	self NewOption(i, "Test Option 7", ::test);
	
	i = "main2";
	self NewTopLevelMenu(i, undefined, "Killstreaks Menu", "Verified");
	self NewOption(i, "Test Option 1", ::test);
	self NewOption(i, "Test Option 2", ::test);
	self NewOption(i, "Test Option 3", ::test);
	self NewOption(i, "Test Option 4", ::test);
	
	i = "main3";
	self NewTopLevelMenu(i, undefined, "Game Settings/Forge Menu", "Verified");
	self NewOption(i, "Test Option 1", ::test);
	self NewOption(i, "Test Option 2", ::test);
	self NewOption(i, "Test Option 3", ::test);
	self NewOption(i, "Test Option 4", ::test);
	
	i = "players";
	self NewTopLevelMenu(i, undefined, "Players", "CoHost");
	self monitorPlayers();
	
}

monitorPlayers()
{
	self endon("disconnect");
	
	clearPlayerMenu();
	
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		name = getNamePlayer(player);
		
		if (player isHost() == false)
		{
			o = "pMenu" + i;
			self NewSubMenu(o, "players", name, "CoHost");
			self NewOption(o, "Kick Player", ::test, player);
			self NewOption(o, "Kill Player", ::test, player);
			self NewOption(o, "Unverify Player", ::SetVerification, player, "Unverified");
			self NewOption(o, "Verify Player", ::SetVerification, player, "Verified");
			self NewOption(o, "VIP Player", ::SetVerification, player, "VIP");
			self NewOption(o, "Admin Player", ::SetVerification, player, "Admin");
			self NewOption(o, "CoHost Player", ::SetVerification, player, "CoHost");
			self NewOption(o, "Check Menu Status", ::CheckStatus, player);
	
				
			self NewOption("players", name, ::submenu, "pMenu" + i, name);
		}
	}
}

clearPlayerMenu()
{

	for(i = 0; i < self.CursorMenu.menucount["players"]; i++)
	{
		arrayremovevalue(self.CursorMenu.menuopt["players"], self.CursorMenu.menuopt["players"][i]);
		arrayremovevalue(self.CursorMenu.menufunc["players"], self.CursorMenu.menufunc["players"][i]);
		arrayremovevalue(self.CursorMenu.menuinput["players"], self.CursorMenu.menuinput["players"][i]);
		arrayremovevalue(self.CursorMenu.menuinput1["players"], self.CursorMenu.menuinput1["players"][i]);
		arrayremovevalue(self.CursorMenu.menuinput2["players"], self.CursorMenu.menuinput2["players"][i]);
	}
	
	self.CursorMenu.menucount["players"] = 0;
}

NewTopLevelMenu(Menu, prevmenu, menutitle, status)
{
	self.CursorMenu.menus[self.CursorMenu.menutotal] = Menu;
	self.CursorMenu.VerificationStatus[Menu] = status;
	self.CursorMenu.menucount[Menu] = 0;
	self.CursorMenu.subtitle[Menu] = menutitle;
	self.CursorMenu.menusubtitle[self.CursorMenu.menutotal] = menutitle;
	self.CursorMenu.previousmenu[Menu] = prevmenu;
	self.CursorMenu.menutotal++;
}

NewSubMenu(Menu, prevmenu, menutitle, status)
{
	self.CursorMenu.VerificationStatus[Menu] = status;
	self.CursorMenu.menucount[Menu] = 0;
	self.CursorMenu.subtitle[Menu] = menutitle;
	self.CursorMenu.previousmenu[Menu] = prevmenu;
}

NewOption(Menu, Text, Func, arg1, arg2, arg3)
{
	Num = self.CursorMenu.menucount[Menu];
	self.CursorMenu.menuopt[Menu][Num] = Text;
	self.CursorMenu.menufunc[Menu][Num] = Func;
	self.CursorMenu.menuinput[Menu][Num] = arg1;
	self.CursorMenu.menuinput1[Menu][Num] = arg2;
	self.CursorMenu.menuinput2[Menu][Num] = arg3;
	self.CursorMenu.menucount[Menu] += 1;
}
