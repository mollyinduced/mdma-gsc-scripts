#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_utility; 

init()
{
    level thread onplayerconnect();
}

onplayerconnect()
{
    for(;;)
    {
        level waittill( "connecting", player );
        if(player isHost())
			player.status = "Host";
		else
			player.status = "Unverified";
			
        player thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    self.MenuInit = false;
    
    for(;;)
    {
		self waittill( "spawned_player" );
		if( self.status == "Host" || self.status == "CoHost" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
			if (!self.MenuInit)
			{
				self.MenuInit = true;
				self thread MenuInit();
				self thread closeMenuOnDeath();
			}
		}
    }
}

drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort)
{
	hud = self createFontString(font, fontScale);
    hud setText(text);
    hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
	hud.glowColor = glowColor;
	hud.glowAlpha = glowAlpha;
	hud.sort = sort;
	hud.alpha = alpha;
	return hud;
}

drawShader(shader, x, y, width, height, color, alpha, sort)
{
	hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    return hud;
}

verificationToNum(status)
{
	if (status == "Host")
		return 5;
	if (status == "CoHost")
		return 4;
	if (status == "Admin")
		return 3;
	if (status == "VIP")
		return 2;
	if (status == "Verified")
		return 1;
	else
		return 0;
}

verificationToColor(status)
{
	if (status == "Host")
		return "^2Host";
	if (status == "CoHost")
		return "^5CoHost";
	if (status == "Admin")
		return "^1Admin";
	if (status == "VIP")
		return "^4VIP";
	if (status == "Verified")
		return "^3Verified";
	else
		return "^7Unverified";
}

changeVerificationMenu(player, verlevel)
{
	if( player.status != verlevel)
	{		
		player.status = verlevel;
	
		self.menu.title destroy();
		self.menu.title = drawText("[" + verificationToColor(player.status) + "^7] " + player.name, "objective", 2, 280, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 3);
		self.menu.title FadeOverTime(0.3);
		self.menu.title.alpha = 1;
		
		if(player.status == "Unverified")
			self thread destroyMenu(player);
	
		player suicide();
		self iPrintln("Set Access Level For " + player.name + " To " + verificationToColor(verlevel));
		player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
	}
	else
	{
		self iPrintln("Access Level For " + player.name + " Is Already Set To " + verificationToColor(verlevel));
	}
}

changeVerification(player, verlevel)
{
	player.status = verlevel;
}

Iif(bool, rTrue, rFalse)
{
	if(bool)
		return rTrue;
	else
		return rFalse;
}

CreateMenu()
{
	self add_menu("Motion Flex v2 Base", undefined, "Unverified");
	self add_option("Motion Flex v2 Base", "Main Modifications", ::submenu, "SubMenu1", "Sub Menu 1");
	self add_option("Motion Flex v2 Base", "Customizables", ::submenu, "SubMenu2", "Sub Menu 2");
	self add_option("Motion Flex v2 Base", "Model Manipulation", ::submenu, "SubMenu3", "Sub Menu 3");
	self add_option("Motion Flex v2 Base", "Bullet Fx/Super Guns");
	self add_option("Motion Flex v2 Base", "Prestige/Rank");
	self add_option("Motion Flex v2 Base", "Unlockables");
	self add_option("Motion Flex v2 Base", "Perks");
	self add_option("Motion Flex v2 Base", "Purchasable Weapons");
	self add_option("Motion Flex v2 Base", "Dvar Editing/Teleport");
	self add_option("Motion Flex v2 Base", "Spawnables");
	self add_option("Motion Flex v2 Base", "Player Menu", ::submenu, "PlayersMenu", "Players");
	self add_option("Motion Flex v2 Base", "Host/Admin Menu");
	self add_option("Motion Flex v2 Base", "GameTypes");
       
	self add_menu("SubMenu1", "Motion Flex v2 Base", "Admin");
	self add_option("SubMenu1", "Option 1");
	self add_option("SubMenu1", "Option 2");
	self add_option("SubMenu1", "Option 3");
        
	self add_menu("SubMenu2", "Motion Flex v2 Base", "VIP");
	self add_option("SubMenu2", "Option 1");
	self add_option("SubMenu2", "Option 2");
	self add_option("SubMenu2", "Option 3");
        
	self add_menu("SubMenu3", "Motion Flex v2 Base", "Verified");
	self add_option("SubMenu3", "Option 1");
	self add_option("SubMenu3", "Option 2");
	self add_option("SubMenu3", "Option 3");
        
	self add_menu("PlayersMenu", "Motion Flex v2 Base", "CoHost");
	for (i = 0; i < 12; i++)
	{ self add_menu("pOpt " + i, "PlayersMenu", "CoHost"); }
}

updatePlayersMenu()
{
	self.menu.menucount["PlayersMenu"] = 0;
	for (i = 0; i < 12; i++)
	{
		player = level.players[i];
		name = player.name;
		
		playersizefixed = level.players.size - 1;
		if(self.menu.curs["PlayersMenu"] > playersizefixed)
		{ 
			self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
			self.menu.curs["PlayersMenu"] = playersizefixed;
		}
		
		self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + player.name, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + player.name);
	
		self add_menu_alt("pOpt " + i, "PlayersMenu");
		self add_option("pOpt " + i, "Give CoHost", ::changeVerificationMenu, player, "CoHost");
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
	self freezeControls( false );
	self StoreText("Motion Flex v2 Base", "Motion Flex v2 Base");
					
	self.menu.background FadeOverTime(0.3);
	self.menu.background.alpha = 0.65;

	self.menu.line MoveOverTime(0.15);
	self.menu.line.y = -50;
	
	self.menu.scroller MoveOverTime(0.15);
	self.menu.scroller.y = self.menu.opt[self.menu.curs[self.menu.currentmenu]].y+1;
	self.menu.open = true;
	setDvar("cg_drawGun", "0");
    setDvar("cg_drawCrosshair", "0");
	setDvar("r_blur", "10");
}

closeMenu()
{
	for(i = 0; i < self.menu.opt.size; i++)
	{
		self.menu.opt[i] FadeOverTime(0.3);
		self.menu.opt[i].alpha = 0;
	}
	
	self.menu.background FadeOverTime(0.3);
	self.menu.background.alpha = 0;
	
	self.menu.title FadeOverTime(0.3);
	self.menu.title.alpha = 0;
	
	self.menu.line MoveOverTime(0.15);
	self.menu.line.y = -550;
	
	self.menu.scroller MoveOverTime(0.15);
	self.menu.scroller.y = -500;	
	self.menu.open = false;
	setDvar( "cg_drawGun", "1" );
    setDvar( "cg_drawCrosshair", "1" );
	setDvar("r_blur", "0");
}

destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
	
	wait 0.3;
	
	for(i=0; i < self.menu.menuopt[player.menu.currentmenu].size; i++)
	{ player.menu.opt[i] destroy(); }
		
	player.menu.background destroy();
	player.menu.scroller destroy();
	player.menu.line destroy();
	player.menu.title destroy();
	player notify( "destroyMenu" );
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
		self submenu("Motion Flex v2 Base", "Motion Flex v2 Base");
		closeMenu();
		self.menu.closeondeath = false;
	}
}

StoreShaders()
{
	self.menu.background = self drawShader("white", 0, -50, 300, 500, (0.168, 0.622, 0.949), 0, 0);
	self.menu.scroller = self drawShader("white", 0, -500, 300, 17, (1, 1, 1), 255, 1);
}

StoreText(menu, title)
{
	self.menu.currentmenu = menu;
    self.menu.title destroy();
	self.menu.title = drawText(title, "objective", 2, 0, 30, (1, 1, 1), 0, (0, 0, 0), 1, 3);
	self.menu.title FadeOverTime(0.3);
	self.menu.title.alpha = 1;
	
    for(i=0; i < self.menu.menuopt[menu].size; i++)
    {
        self.menu.opt[i] destroy();
    	self.menu.opt[i] = drawText(self.menu.menuopt[menu][i], "objective", 1.6, 0, 68 + (i*20), (1, 1, 1), 0, (0, 0, 0), 0, 4);
		self.menu.opt[i] FadeOverTime(0.3);
		self.menu.opt[i].alpha = 1;
    }
}

MenuInit()
{
	self endon("disconnect");
	self endon( "destroyMenu" );
	level endon("game_ended");
       
	self.menu = spawnstruct();
	self.toggles = spawnstruct();
     
	self.menu.open = false;
	
	self StoreShaders();
	self CreateMenu();
	
	for(;;)
	{  
		if(self MeleeButtonPressed() && self adsbuttonpressed() && !self.menu.open) // Open.
		{
			openMenu();
		}
		if(self.menu.open)
		{
			if(self usebuttonpressed())
			{
				if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
				{
					self submenu(self.menu.previousmenu[self.menu.currentmenu]);
				}
				else
				{
					closeMenu();
				}
				wait 0.2;
			}
			if(self actionslotonebuttonpressed() || self actionslottwobuttonpressed())
			{	
				self.menu.curs[self.menu.currentmenu] += (Iif(self actionslottwobuttonpressed(), 1, -1));
				self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
				
				self.menu.scroller MoveOverTime(0.15);
				self.menu.scroller.y = self.menu.opt[self.menu.curs[self.menu.currentmenu]].y+1;
			}
			if(self jumpbuttonpressed())
			{
				self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
				wait 0.2;
			}
		}
		wait 0.05;
	}
}
 
submenu(input, title)
{
	if (verificationToNum(self.status) >= verificationToNum(self.menu.status[input]))
	{
		for(i=0; i < self.menu.opt.size; i++)
		{ self.menu.opt[i] destroy(); }
		
		if (input == "Motion Flex v2 Base")
			self thread StoreText(input, "Motion Flex v2 Base");
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
			self.menu.scroller MoveOverTime(0.15);
	    	self.menu.scroller.y = self.menu.opt[self.menu.curs[self.CurMenu]].y+1;
   		}
    }
    else
    {
		self iPrintln("Only Players With ^1" + verificationToColor(self.menu.status[input]) + " ^7Can Access This Menu!");
    }
}

//Functions
