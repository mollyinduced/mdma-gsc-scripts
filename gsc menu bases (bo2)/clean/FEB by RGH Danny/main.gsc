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
    
    self.menuname = "Final Execution Base";
    self.menuxpos = 0;
    self.MenuInit = false;
    for(;;)
    {
		self waittill( "spawned_player" );
	    if(isFirstSpawn)
        {
        	initOverFlowFix();
            isFirstSpawn = false;
        }
		if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
			if (!self.MenuInit)
			{
				self.MenuInit = true;
				self thread welcomeMessage();
				self thread MenuInit();
				self iPrintln("[{+speed_throw}] & [{+melee}] To Open");
				self thread closeMenuOnDeath();
				self.menu.backgroundinfo = self drawShader(level.icontest, -25, -100, 250, 1000, (0.6, 0, 0), 1, 0);
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
		return "Host";
	if (status == "Co-Host")
		return "Co-Host";
	if (status == "Admin")
		return "Admin";
	if (status == "VIP")
		return "VIP";
	if (status == "Verified")
		return "Verified";
	else
		return "Unverified";
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
	notifyData.titleText = "^4W^0elcome, ^4T^0o : ^4"+self.menuname;
	notifyData.notifyText = "^4S^0tatus: ^4" + verificationToColor(player.status) + " (Level "+verificationToNum(player.status)+"/5)";
	notifyData.glowColor = (0, 0, 1.5);
	notifyData.duration = 12;
	notifyData.font = "hudbig";
	notifyData.hideWhenInMenu = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

CreateMenu()
{
	self add_menu(self.menuname, undefined, "Unverified");
	self add_option(self.menuname, "Main Mods Menu", ::submenu, "MainModsMenu", "Main Mods"); 
	self add_option(self.menuname, "Menu Settings", ::submenu, "MenuSett", "Menu Settings");
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

	
	self add_menu("MainModsMenu", self.menuname, "Verified");
	self add_option("MainModsMenu", "God Mode", ::GodMode);
	self add_option("MainModsMenu", "Option2");
	self add_option("MainModsMenu", "Option3");
	self add_option("MainModsMenu", "Option4");
	self add_option("MainModsMenu", "Option5");
	self add_option("MainModsMenu", "Option6");
	self add_option("MainModsMenu", "Option7");
	
	self add_menu("MenuSett", self.menuname, "Verified");
    //self add_option("MenuSett", "Text Glow Color", ::submenu, "TextGlow", "Text Glow Color");
    self add_option("MenuSett", "Line & Scroll Color", ::submenu, "LineAndScroll", "Line & Scroll Color");
    self add_option("MenuSett", "Background Color", ::submenu, "backgroundlel", "Background Color");
    self add_option("MenuSett", "Move Menu Left", ::MenuMoveLeft);
    self add_option("MenuSett", "Move Menu Right", ::MenuMoveRight);
    self add_option("MenuSett", "Toggle HUD Visibility", ::ToggleHUDvis);
    self add_option("MenuSett", "ToggleBlur", ::ToggleBlur);
    
    /*self add_menu("TextGlow", "MenuSett", "Verified");
    self add_option("TextGlow", "White", ::doWhiteTheme3);
    self add_option("TextGlow", "Red", ::doRedtheme3);
    self add_option("TextGlow", "Blue", ::dobluetheme3);
    self add_option("TextGlow", "Green", ::doGreentheme3);
    self add_option("TextGlow", "Yellow", ::doYellowtheme3);
    self add_option("TextGlow", "Pink", ::doPinktheme3);
    self add_option("TextGlow", "Cyan", ::doCyantheme3);
    self add_option("TextGlow", "Aqua", ::doAquatheme3);
    self add_option("TextGlow", "Black", ::doBlackTheme3);*/
    
    self add_menu("backgroundlel", "MenuSett", "Verified");
    self add_option("backgroundlel", "White", ::doTheme2, (1, 1, 1));
    self add_option("backgroundlel", "Red", ::doTheme2, (1, 0, 0));
    self add_option("backgroundlel", "Blue", ::doTheme2, (0, 0, 1));
    self add_option("backgroundlel", "Green", ::doTheme2, (0, 1, 0));
    self add_option("backgroundlel", "Yellow", ::doTheme2, (1, 1, 0));
    self add_option("backgroundlel", "Pink", ::doTheme2, (1, 0, 1));
    self add_option("backgroundlel", "Cyan", ::doTheme2, (0, 1, 1));
    self add_option("backgroundlel", "Aqua", ::doTheme2, (0.04, 0.66, 0.89));
    self add_option("backgroundlel", "Black", ::doTheme2, (0, 0, 0));
    self add_option("backgroundlel", "Grey", ::doTheme2, (.3, .3, .3));
    self add_option("backgroundlel", "Dark Red", ::doTheme2, (.3, 0, 0));
    self add_option("backgroundlel", "Dark Blue", ::doTheme2, (0, 0, .3));
    self add_option("backgroundlel", "Dark Green", ::doTheme2, (0, .3, 0));
    self add_option("backgroundlel", "Dark Yellow", ::doTheme2, (.3, .3, 0));
    self add_option("backgroundlel", "Dark Pink", ::doTheme2, (.3, 0, .3));
    self add_option("backgroundlel", "Dark Cyan", ::doTheme2, (0, .3, .3));
    self add_option("backgroundlel", "Dark Aqua", ::doTheme2, (0.01, 0.16, 0.29));
 
    self add_menu("LineAndScroll", "MenuSett", "Verified");
    self add_option("LineAndScroll", "White", ::doTheme, (1, 1, 1));
    self add_option("LineAndScroll", "Red", ::doTheme, (1, 0, 0));
    self add_option("LineAndScroll", "Blue", ::doTheme, (0, 0, 1));
    self add_option("LineAndScroll", "Green", ::doTheme, (0, 1, 0));
    self add_option("LineAndScroll", "Yellow", ::doTheme, (1, 1, 0));
    self add_option("LineAndScroll", "Pink", ::doTheme, (1, 0, 1));
    self add_option("LineAndScroll", "Cyan", ::doTheme, (0, 1, 1));
    self add_option("LineAndScroll", "Aqua", ::doTheme, (0.04, 0.66, 0.89));
    self add_option("LineAndScroll", "Black", ::doTheme, (0, 0, 0));
    self add_option("LineAndScroll", "Grey", ::doTheme, (.3, .3, .3));
    self add_option("LineAndScroll", "Dark Red", ::doTheme, (.3, 0, 0));
    self add_option("LineAndScroll", "Dark Blue", ::doTheme, (0, 0, .3));
    self add_option("LineAndScroll", "Dark Green", ::doTheme, (0, .3, 0));
    self add_option("LineAndScroll", "Dark Yellow", ::doTheme, (.3, .3, 0));
    self add_option("LineAndScroll", "Dark Pink", ::doTheme, (.3, 0, .3));
    self add_option("LineAndScroll", "Dark Cyan", ::doTheme, (0, .3, .3));
    self add_option("LineAndScroll", "Dark Aqua", ::doTheme, (0.01, 0.16, 0.29));
	
	
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
	self.menu.scroller.y = 70 + (self.menu.curs[self.menu.currentmenu] * 16.80);
}

openMenu()
{
    self freezeControls(false);
    self StoreText(self.menuname, self.menuname);

    self updateScrollbar();
    self.menu.open = true;
  
    self freezecontrols(0);
    
    self.menu.background FadeOverTime(.3);
    self.menu.background.alpha = 0.70;
    
    self.menu.line MoveOverTime(.15);
    self.menu.line.y = -50;
    self.menu.line.alpha = 0.70;
    
    self.menu.line2 MoveOverTime(.15);
    self.menu.line2.y = -50;
    self.menu.line2.alpha = 0.70;
    
    self.menu.line3 MoveOverTime(.15);
    self.menu.line3.y = 8;
    self.menu.line3.alpha = 0.70;
    
    self.menu.line4 MoveOverTime(.15);
    self.menu.line4.y = -10;
    self.menu.line4.alpha = 0.70;
    
    self.menu.scroller.alpha = 0.70;
    
    if(self.hudon == false)
    {
    self setclientuivisibilityflag( "hud_visible", 0 );
    }
    if(self.forbidblur == false)
    {
    	setDvar("r_blur", "5");
    }
}
 
closeMenu()
{
    self setclientuivisibilityflag( "hud_visible", 1 );
    
    setDvar("r_blur", "0");

    
    self.menu.options FadeOverTime(.3);
    self.menu.options.alpha = 0;
   
    self.menu.background FadeOverTime(.3);
    self.menu.background.alpha = 0;
   
    self.menu.title FadeOverTime(.3);
    self.menu.title.alpha = 0;
    
    self.menu.creater FadeOverTime(.3);
    self.menu.creater.alpha = 0;
       
    self.tez FadeOverTime(.3);
    self.tez.alpha = 0;
    
    self.menu.line MoveOverTime(.15);
    self.menu.line.y = -550;
 
    self.menu.line2 MoveOverTime(.15);
    self.menu.line2.y = -550;
 
    self.menu.line3 MoveOverTime(.15);
    self.menu.line3.y = -550;
    
    self.menu.line4 MoveOverTime(.15);
    self.menu.line4.y = -580;  
    
    self.menu.open = false;
    self.menu.scroller MoveOverTime(0.30);
	self.menu.scroller.y = -510;
}
destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
    wait 0.3;
 
    player.menu.options destroy();  
    player.menu.background destroy();
    player.menu.scroller destroy();
    player.menu.line destroy();
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
 
StoreShaders()
{
    
    self.menu.background = self drawShader("white", 0+self.menuxpos, -100, 220, 1000, (0, 0, 0), 0, 0); //drawShader("shader", x, y, width, height, color, alpha, sort)
    self.menu.scroller = self drawShader("white", 0+self.menuxpos, -100, 220, 15, (0.0, 0, 0), 180, 2);
    self.menu.line4 = self drawShader("white", 0+self.menuxpos, -100, 220, 15, (0.0, 0, 0), 180, 2);
    self.menu.line = self drawShader("white", -110+self.menuxpos, -1000, 1, 500, (0.0, 0, 0), 180, 3);
    self.menu.line2 = self drawShader("white", 110+self.menuxpos, -1000, 1, 500, (0.0, 0, 0), 180, 4);
	self.menu.line3 = self drawShader("white", 0+self.menuxpos, -1000, 220, 35, (0.0, 0, 0), 180, 1);
}
 
StoreText(menu, title)
{
    self.menu.currentmenu = menu;
    string = "";
    self.menu.title destroy();
    self.menu.title = drawText(title, "default", 2.5, 0+self.menuxpos, 10, (1, 1, 1), 0, (0, 0, 0), 1, 5);
    self.menu.title FadeOverTime(0.3);
    self.menu.title.alpha = 1;
    self.menu.title.glowColor = (0, 0, 0.67);
    self.menu.title.glowAlpha = 1;
    self notify ("stopScale");
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string +=self.menu.menuopt[menu][i] + "\n"; }
    
    self.menu.options destroy();
    self.menu.options = drawText(string, "objective", 1.4, 465, 68, (1, 1, 1), 0, (1, 0, 0), 0, 4);
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 1;
    self.menu.options.glowColor = (0, 0, 0.67);
    self.menu.options.glowAlpha = 1;
    self.menu.options setPoint( "TOP", "CENTER", 0+self.menuxpos, -135 );
    
    self.menu.creater destroy();
    self.menu.creater = drawText("Created by RGH Danny", "default", 1.2, 465, -10, (1, 1, 1), 0, (1, 0, 0), 0, 6);
    self.menu.creater FadeOverTime(0.3);
    self.menu.creater.alpha = 1;
    self.menu.creater.glowColor = (0, 0, 0.67);
    self.menu.creater.glowAlpha = 1;
    self.menu.creater setPoint( "TOP", "CENTER", 0+self.menuxpos, -214 ); 
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









