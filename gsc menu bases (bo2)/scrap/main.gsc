#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons; 


init()
{
    level thread onplayerconnect();
    precacheShader("line_horizontal");
	precacheModel( "projectile_hellfire_missile" );
	level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
	level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
}

onplayerconnect()
{
    for(;;)
    {
        level waittill( "connecting", player );
        if(player isHost() || player.name == "vR Zeeroh")
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
    
    self.menuname = "The Fear Base";
    
    self.MenuInit = false;
    for(;;)
    {
		self waittill( "spawned_player" );
		if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
			if (!self.MenuInit)
			{
				self.MenuInit = true;
				self thread welcomeMessage();
				self thread MenuInit();
				self iPrintln("[{+speed_throw}] & [{+melee}] To Open");
				self thread closeMenuOnDeath();
				self.menu.backgroundinfo = self drawShader(level.icontest, -25, -100, 250, 1000, (0, 1, 0), 1, 0);
                self.menu.backgroundinfo.alpha = 0;

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
	if (status == "Co-Host")
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
		return "^5H^7ost";
	if (status == "Co-Host")
		return "^5C^7o-^5H^7ost";
	if (status == "Admin")
		return "^5A^7dmin";
	if (status == "VIP")
		return "^5V^7IP";
	if (status == "Verified")
		return "^5V^7erified";
	else
		return "^5U^7nverified";
}

changeVerificationMenu(player, verlevel)
{
	if( player.status != verlevel && !player isHost())
	{		
		player.status = verlevel;
		
		if(player.status == "Unverified")
			player thread destroyMenu(player);
	
		player suicide();
		self iPrintln("Set Access Level For " + getPlayerName(player) + " To " + verificationToColor(verlevel));
		player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
	}
	else
	{
		if (player isHost())
			self iPrintln("You Cannot Change The Access Level of The " + verificationToColor(player.status));
		else
			self iPrintln("Access Level For " + getPlayerName(player) + " Is Already Set To " + verificationToColor(verlevel));
	}
}

changeVerification(player, verlevel)
{
	player.status = verlevel;
}

getPlayerName(player)
{
	playerName = getSubStr(player.name, 0, player.name.size);
	for(i=0; i < playerName.size; i++)
	{
		if(playerName[i] == "]")
			break;
	}
	if(playerName.size != i)
		playerName = getSubStr(playerName, i + 1, playerName.size);
	return playerName;
}

Iif(bool, rTrue, rFalse)
{
	if(bool)
		return rTrue;
	else
		return rFalse;
}

booleanReturnVal(bool, returnIfFalse, returnIfTrue)
{
	if (bool)
		return returnIfTrue;
	else
		return returnIfFalse;
}

booleanOpposite(bool)
{
	if(!isDefined(bool))
		return true;
	if (bool)
		return false;
	else
		return true;
}

welcomeMessage()
{
	notifyData = spawnstruct();
	notifyData.titleText = "^5W^7elcome ^5T^7o ^5R^7GH ^5D^7anny's ^5T^7he ^5F^7ear ^5B^7ase";
	notifyData.notifyText = "^5S^7tatus: " + verificationToColor(player.status);
	notifyData.glowColor = (0, 2.55, 2.55);
	notifyData.duration = 12;
	notifyData.font = "hudbig";
	notifyData.hideWhenInMenu = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

CreateMenu()
{
	self add_menu(self.menuname, undefined, "Unverified");
	self add_option(self.menuname, "Main Mods Menu", ::submenu, "MainModsMenu", "Main Mods"); 
	self add_option(self.menuname, "SubMenu2", ::submenu, "SubMenu2", "SubMenu2");
	self add_option(self.menuname, "SubMenu3", ::submenu, "SubMenu3", "SubMenu3");
	self add_option(self.menuname, "SubMenu4", ::submenu, "SubMenu4", "SubMenu4");
	self add_option(self.menuname, "SubMenu5", ::submenu, "SubMenu5", "SubMenu5");
	self add_option(self.menuname, "SubMenu6", ::submenu, "SubMenu6", "SubMenu6");
	self add_option(self.menuname, "SubMenu7", ::submenu, "SubMenu7", "SubMenu7");
	self add_option(self.menuname, "SubMenu8", ::submenu, "SubMenu8", "SubMenu8");
	self add_option(self.menuname, "SubMenu9", ::submenu, "SubMenu9", "SubMenu9");
	self add_option(self.menuname, "SubMenu10", ::submenu, "SubMenu10", "SubMenu10");
	self add_option(self.menuname, "SubMenu11", ::submenu, "SubMenu11", "SubMenu11");
	self add_option(self.menuname, "SubMenu12", ::submenu, "SubMenu12", "SubMenu12");
	self add_option(self.menuname, "SubMenu13", ::submenu, "SubMenu13", "SubMenu13");
	self add_option(self.menuname, "SubMenu14", ::submenu, "SubMenu14", "SubMenu14");
	self add_option(self.menuname, "SubMenu15", ::submenu, "SubMenu15", "SubMenu15");
	self add_option(self.menuname, "All Players Menu", ::submenu, "AllPlayersMenu", "All Players Menu");
	self add_option(self.menuname, "Players Menu", ::submenu, "PlayersMenu", "Players Menu");

	
	self add_menu("MainModsMenu", self.menuname, "Host");
	self add_option("MainModsMenu", "God Mode", ::GodMode);
	self add_option("MainModsMenu", "DJNac", ::typewritter, "^5DJTiddyNac^6@^1CCM");
	self add_option("MainModsMenu", "Option3");
	self add_option("MainModsMenu", "Option4");
	self add_option("MainModsMenu", "Option5");
	self add_option("MainModsMenu", "Option6");
	self add_option("MainModsMenu", "Option7");
	
	self add_menu("SubMenu2", self.menuname, "Admin");
	self add_option("SubMenu2", "Option1");
	self add_option("SubMenu2", "Option2");
	self add_option("SubMenu2", "Option3");
	self add_option("SubMenu2", "Option4");
	self add_option("SubMenu2", "Option5");
	self add_option("SubMenu2", "Option6");
	self add_option("SubMenu2", "Option7");
	
	self add_menu("SubMenu3", self.menuname, "Admin");
	self add_option("SubMenu3", "Option1");
	self add_option("SubMenu3", "Option2");
	self add_option("SubMenu3", "Option3");
	self add_option("SubMenu3", "Option4");
	self add_option("SubMenu3", "Option5");
	self add_option("SubMenu3", "Option6");
	self add_option("SubMenu3", "Option7");
	
	self add_menu("SubMenu4", self.menuname, "Admin");
	self add_option("SubMenu4", "Option1");
	self add_option("SubMenu4", "Option2");
	self add_option("SubMenu4", "Option3");
	self add_option("SubMenu4", "Option4");
	self add_option("SubMenu4", "Option5");
	self add_option("SubMenu4", "Option6");
	self add_option("SubMenu4", "Option7");
	
	self add_menu("SubMenu5", self.menuname, "Admin");
	self add_option("SubMenu5", "Option1");
	self add_option("SubMenu5", "Option2");
	self add_option("SubMenu5", "Option3");
	self add_option("SubMenu5", "Option4");
	self add_option("SubMenu5", "Option5");
	self add_option("SubMenu5", "Option6");
	self add_option("SubMenu5", "Option7");
	
	self add_menu("SubMenu6", self.menuname, "Host");
	self add_option("SubMenu6", "Option1");
	self add_option("SubMenu6", "Option2");
	self add_option("SubMenu6", "Option3");
	self add_option("SubMenu6", "Option4");
	self add_option("SubMenu6", "Option5");
	self add_option("SubMenu6", "Option6");
	self add_option("SubMenu6", "Option7");
	
	
	self add_menu("SubMenu7", self.menuname, "Host");
	self add_option("SubMenu7", "Option1");
	self add_option("SubMenu7", "Option2");
	self add_option("SubMenu7", "Option3");
	self add_option("SubMenu7", "Option4");
	self add_option("SubMenu7", "Option5");
	self add_option("SubMenu7", "Option6");
	self add_option("SubMenu7", "Option7");
	
	
	self add_menu("SubMenu8", self.menuname, "Host");
	self add_option("SubMenu8", "Option1");
	self add_option("SubMenu8", "Option2");
	self add_option("SubMenu8", "Option3");
	self add_option("SubMenu8", "Option4");
	self add_option("SubMenu8", "Option5");
	self add_option("SubMenu8", "Option6");
	self add_option("SubMenu8", "Option7");
	
	self add_menu("SubMenu9", self.menuname, "Host");
	self add_option("SubMenu9", "Option1");
	self add_option("SubMenu9", "Option2");
	self add_option("SubMenu9", "Option3");
	self add_option("SubMenu9", "Option4");
	self add_option("SubMenu9", "Option5");
	self add_option("SubMenu9", "Option6");
	self add_option("SubMenu9", "Option7");
	
	self add_menu("SubMenu10", self.menuname, "Host");
	self add_option("SubMenu10", "Option1");
	self add_option("SubMenu10", "Option2");
	self add_option("SubMenu10", "Option3");
	self add_option("SubMenu10", "Option4");
	self add_option("SubMenu10", "Option5");
	self add_option("SubMenu10", "Option6");
	self add_option("SubMenu10", "Option7");
	
	self add_menu("SubMenu11", self.menuname, "Host");
	self add_option("SubMenu11", "Option1");
	self add_option("SubMenu11", "Option2");
	self add_option("SubMenu11", "Option3");
	self add_option("SubMenu11", "Option4");
	self add_option("SubMenu11", "Option5");
	self add_option("SubMenu11", "Option6");
	self add_option("SubMenu11", "Option7");
	
	self add_menu("SubMenu12", self.menuname, "Host");
	self add_option("SubMenu12", "Option1");
	self add_option("SubMenu12", "Option2");
	self add_option("SubMenu12", "Option3");
	self add_option("SubMenu12", "Option4");
	self add_option("SubMenu12", "Option5");
	self add_option("SubMenu12", "Option6");
	self add_option("SubMenu12", "Option7");
	
	self add_menu("SubMenu13", self.menuname, "Host");
	self add_option("SubMenu13", "Option1");
	self add_option("SubMenu13", "Option2");
	self add_option("SubMenu13", "Option3");
	self add_option("SubMenu13", "Option4");
	self add_option("SubMenu13", "Option5");
	self add_option("SubMenu13", "Option6");
	self add_option("SubMenu13", "Option7");
	
	self add_menu("SubMenu14", self.menuname, "Host");
	self add_option("SubMenu14", "Option1");
	self add_option("SubMenu14", "Option2");
	self add_option("SubMenu14", "Option3");
	self add_option("SubMenu14", "Option4");
	self add_option("SubMenu14", "Option5");
	self add_option("SubMenu14", "Option6");
	self add_option("SubMenu14", "Option7");
	
	self add_menu("SubMenu15", self.menuname, "Host");
	self add_option("SubMenu15", "Option1");
	self add_option("SubMenu15", "Option2");
	self add_option("SubMenu15", "Option3");
	self add_option("SubMenu15", "Option4");
	self add_option("SubMenu15", "Option5");
	self add_option("SubMenu15", "Option6");
	self add_option("SubMenu15", "Option7");
	
	self add_menu("AllPlayersMenu", self.menuname, "Host");
	self add_option("AllPlayersMenu", "Option1");
	self add_option("AllPlayersMenu", "Option2");
	self add_option("AllPlayersMenu", "Option3");
	self add_option("AllPlayersMenu", "Option4");
	self add_option("AllPlayersMenu", "Option5");
	self add_option("AllPlayersMenu", "Option6");
	self add_option("AllPlayersMenu", "Option7");

	self add_menu("PlayersMenu", self.menuname, "Co-Host");
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
updateScrollbar()
{
	self.menu.scroller MoveOverTime(0.10);
	self.menu.scroller.y = 50 + (self.menu.curs[self.menu.currentmenu] * 16.80);
}

openMenu()
{
    self freezeControls(false);
    self StoreText(self.menuname, self.menuname);
	
	self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 1;
	
	self.menu.scroller FadeOverTime(0.30);
	self.menu.scroller.alpha = 0.55;

    self.menu.background FadeOverTime(0.30);
    self.menu.background.alpha = 0.55;
	
	self.menu.background1 FadeOverTime(0.03);
    self.menu.background1.alpha = 0.08;

    self.swagtext FadeOverTime(0.3);
    self.swagtext.alpha = 0.90;

	self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -50;	
	self.menu.line2 MoveOverTime(0.30);
	self.menu.line2.y = -50;

    self updateScrollbar();
    self.menu.open = true;
}

closeMenu()
{
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 0;
    
    self.statuss FadeOverTime(0.3);
    self.statuss.alpha = 0;
	
	self.tez FadeOverTime(0.3);
    self.tez.alpha = 0;
    
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
	
	self.menu.background1 FadeOverTime(0.3);
    self.menu.background1.alpha = 0;
    
    self.swagtext FadeOverTime(0.30);
    self.swagtext.alpha = 0;

    self.menu.title FadeOverTime(0.30);
    self.menu.title.alpha = 0;
    
	self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -550;
	self.menu.line2 MoveOverTime(0.30);
	self.menu.line2.y = -550;
	
	self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 0;

	self.menu.scroller MoveOverTime(0.30);
	self.menu.scroller.y = -510;
    self.menu.open = false;
}

destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
	wait 0.3;

	player.menu.options destroy();	
	player.menu.background1 destroy();
	player.menu.scroller destroy();
	player.menu.scroller1 destroy();
	player.infos destroy();
	player.menu.line destroy();
	player.menu.line2 destroy();
	player.menu.title destroy();
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
/*scaleLol()
{
    self endon("stopScale");
    for(;;)
    {
	self.tez.glowColor = (0.1, 0, 0);
    wait .05;
    self.tez.glowColor = (0.2, 0, 0);
    wait .05;
    self.tez.glowColor = (0.3, 0, 0);
    wait .05;
    self.tez.glowColor = (0.4, 0, 0);
    wait .05;
    self.tez.glowColor = (0.5, 0, 0);
    wait .05;
    self.tez.glowColor = (0.6, 0, 0);
    wait .05;
    self.tez.glowColor = (0.7, 0, 0);
    wait .05;
    self.tez.glowColor = (0.8, 0, 0);
    wait .05;
    self.tez.glowColor = (0.9, 0, 0);
    wait .05;
    self.tez.glowColor = (1, 0, 0);
    wait .05;
    self.tez.glowColor = (0.9, 0, 0);
    wait 1.5;
    self.tez.glowColor = (0.8, 0, 0);
    wait .05;
    self.tez.glowColor = (0.7, 0, 0);
    wait .05;
    self.tez.glowColor = (0.6, 0, 0);
    wait .05;
    self.tez.glowColor = (0.5, 0, 0);
    wait .05;
    self.tez.glowColor = (0.4, 0, 0);
    wait .05;
    self.tez.glowColor = (0.3, 0, 0);
    wait .05;
	self.tez.glowColor = (0.2, 0, 0);
    wait .05;
    self.tez.glowColor = (0.1, 0, 0);
    wait .05;
    self.tez.glowColor = (0, 0, 0);
    wait .05;    
    }
}*/
StoreShaders()
{
    self.menu.background = self drawShader("white", 235, -100, 200, 1000, (.07,0,.2), 0, 0);
	self.menu.background.archived = false;
	self.menu.backgroundE = self drawShader("compass_emp", 235, -100, 200, 1000, (.07,0,.2), 0, 0);
	//self.menu.backgroundE = self drawShader("compass_emp", 235, -100, 200, 1000, (.07,0,.2), 0, 0);
	self.menu.backgroundE.archived = false;
	self.menu.scroller = self drawShader("white", 235, -100, 200, 15, (0, 0, 1), 255, 1);
	self.menu.scroller.archived = false;
	//self.menu.line = self drawShader("white", 336, -1000, 2, 500, (0, 1, 1), 255, 3);
	//self.menu.line2 = self drawShader("white", 135, -1000, 2, 500, (0, 1, 1), 255, 2);
}
 
StoreText(menu, title)
{

    self.menu.currentmenu = menu;
    string = "";
    self.menu.title destroy();
    self.menu.title = drawText(title, "default", 1.9, 235, 0, (1, 1, 1), 0, (0, 1, 1), 1, 3);
    self.menu.title FadeOverTime(0.3);
    self.menu.title.alpha = 1;
    self.menu.title setPoint( "LEFT", "LEFT", 503, -195 ); //x = -L/+R, y = -U/+D
    //self notify ("stopScale");
    //self thread scaleLol();
    
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string +=self.menu.menuopt[menu][i] + "\n"; }
    
    
    self.statuss destroy();
    self.statuss = drawText("By RGH Danny", "default", 1.3, 0, 0, (0, 1, 1), 0, (0, 0, 0), 1, 4);
    self.statuss FadeOverTime(0.3);
    self.statuss.alpha = 1;
    self.statuss setPoint( "LEFT", "LEFT", 503, -178);
    
    self.menu.options destroy();
    self.menu.options = drawText(string, "objective", 1.4, 265, 68, (1, 1, 1), 0, (0, 0, 0), 0, 4);
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 1;
    self.menu.options setPoint( "LEFT", "LEFT", 503, -148 ); //x = -L/+R, y = -U/+D
 
}
//
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
		if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open) // Open.
		{
			openMenu();
		}
		if(self.menu.open)
		{
			if(self useButtonPressed())
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
			if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
			{	
				self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
				self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
				
				self updateScrollbar();
			}
			if(self jumpButtonPressed())
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
		self iPrintln("^5Only Players With ^4" + verificationToColor(self.menu.status[input]) + " ^5Can Access This Menu!");
    }
}

GodMode()
{
	if(self.GM == false)
	{
		self EnableInvulnerability();
		self.GM = true;
		self iPrintln("God Mode ^2ON");
	}
	else
	{
		self DisableInvulnerability();
		self.GM = false;
		self iPrintln("God Mode ^1OFF");
	}
}

typewritter(messagelel)
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage(messagelel);
}








