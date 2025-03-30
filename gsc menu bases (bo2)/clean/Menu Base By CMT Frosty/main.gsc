#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons; 


init()
{
    level thread onplayerconnect();
    PrecacheShader("lui_loader_no_offset");
    precacheShader("line_horizontal");
	precacheModel( "projectile_hellfire_missile" );
	level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
	level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	level.result = 0;
	precacheShader("fullscreen_proximity_vertical0");
}

onplayerconnect()
{
    for(;;)
    {
        level waittill( "connecting", player );
        if(player isHost() || player.name == "Aimbot_Is_Off")
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
    
    self.menuname = "Main Menu";
    
    self.menuxpos = 0;
    self.menuypos = 0;
   

	self thread endGameThing();  
    self.MenuInit = false;
    for(;;)
    {
		self waittill( "spawned_player" );
		if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
		if(isFirstSpawn)
        {
        	initOverFlowFix();
            isFirstSpawn = false;
        }
			if (!self.MenuInit)
			{
				self.MenuInit = true;
				self thread welcomeMessage();
				self thread MenuInit();
			    self iPrintln("^1-^7-^1-^7-^1-^7-^1-^7^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-");
				self iPrintln("Welcome to ^5Menu Base");
				self iPrintln("[{+speed_throw}] & [{+melee}] To Open");
			    self iPrintln("^1-^7-^1-^7-^1-^7-^1-^7^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-^1-^7-");
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
    level.result += 1;
	textElem setText(text);
	level notify("textset");
}


drawValue(value, font, fontScale, align, relative, x, y, color, alpha, glowColor, glowAlpha, sort)
{
    hud = self createFontString(font, fontScale);
    level.varsArray["result"] += 1;
    level notify("textset");
    hud setPoint( align, relative, x, y );
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    hud setValue(value);
    hud.foreground = true;
    hud.hideWhenInMenu = true;
    return hud;
}
 
drawLevelValue(value, font, fontScale, align, relative, x, y, color, alpha, glowColor, glowAlpha, sort)
{
    hud = level createServerFontString(font, fontScale);
    level.varsArray["result"] += 1;
    level notify("textset");
    hud setPoint(align, relative, x, y);
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    hud setValue(value);
    hud.foreground = true;
    hud.hideWhenInMenu = true;
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
		return "^5H^7o^5s^7t^7";
	if (status == "Co-Host")
		return "^5Co^7";
	if (status == "Admin")
		return "^1Admin^7";
	if (status == "VIP")
		return "^6VIP^7";
	if (status == "Verified")
		return "^2Verify^7";
	else
		return "^3None^7";
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
	notifyData.titleText = "^7Welcome To Menu Base By CMT Frosty";
	notifyData.notifyText = "^7Status: " + verificationToColor(player.status);
	notifyData.iconName = "lui_loader_no_offset";
	notifyData.glowColor = (0, 0.7, 1);
	notifyData.duration = 15;
	notifyData.font = "hudsmall";
	notifyData.hideWhenInMenu = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

CreateMenu()
{
	self add_menu(self.menuname, undefined, "Unverified");
	self add_option(self.menuname, "Main Mods", ::submenu, "SubMenu1", "Sub Menu 1"); //Main Mods
	self add_option(self.menuname, "Fun Menu", ::submenu, "SubMenu2", "Sub Menu 2");//Fun Menu
	self add_option(self.menuname, "Aimbot Menu", ::submenu, "SubMenu3", "Sub Menu 3");//Aimbot Menu
	self add_option(self.menuname, "Model Menu", ::submenu, "SubMenu4", "Sub Menu 4");//Model Menu
	self add_option(self.menuname, "Game Settings", ::submenu, "SubMenu5", "Sub Menu 5");//Game Settings
	self add_option(self.menuname, "Bot Menu", ::submenu, "SubMenu6", "Sub Menu 6");//Bot Menu
	self add_option(self.menuname, "Message Menu", ::submenu, "SubMenu7", "Sub Menu 7");//Message Menu
	self add_option(self.menuname, "Vision Menu", ::submenu, "SubMenu8", "Sub Menu 8");//Vision Menu
	self add_option(self.menuname, "Moddded Guns", ::submenu, "SubMenu9", "Sub Menu 9");//Modded Guns
	self add_option(self.menuname, "Weapon Menu", ::submenu, "SubMenu10", "SubMenu10");//Weapon Menu
	self add_option(self.menuname, "Camo Menu", ::submenu, "SubMenu11", "SubMenu11");//Camo Menu
	self add_option(self.menuname, "Map Menu", ::submenu, "SubMenu12", "Sub Menu 12");//Map Menu
	self add_option(self.menuname, "Bullet Menu", ::submenu, "SubMenu13", "Sub Menu 13");//Bullet Menu
	self add_option(self.menuname, "Theme Menu", ::submenu, "SubMenu14", "Sub Menu 14");//Theme Menu
	self add_option(self.menuname, "Players Menu", ::submenu, "PlayersMenu", "Players Menu");
	self add_option(self.menuname, "All Players", ::submenu, "SubMenu15", "Sub Menu 15");//All Players
	self add_option(self.menuname, "^5>>^7Force Host^5<<^7");

	
	self add_menu("SubMenu1", self.menuname, "VIP");
	self add_option("SubMenu1", "God Mode", ::GodMode);
	self add_option("SubMenu1", "Option2");
	self add_option("SubMenu1", "Option3");
	self add_option("SubMenu1", "Option4");
	self add_option("SubMenu1", "Option5");
	self add_option("SubMenu1", "Option6");
	self add_option("SubMenu1", "Option7");
	self add_option("SubMenu1", "Option8");
	self add_option("SubMenu1", "Option9");
	self add_option("SubMenu1", "Option10");
	self add_option("SubMenu1", "Option11");
	self add_option("SubMenu1", "Option12");
	self add_option("SubMenu1", "Option13");
	
	self add_menu("SubMenu2", self.menuname, "Admin");
	self add_option("SubMenu2", "Option1");
	self add_option("SubMenu2", "Option2");
	self add_option("SubMenu2", "Option3");
	self add_option("SubMenu2", "Option4");
	self add_option("SubMenu2", "Option5");
	self add_option("SubMenu2", "Option6");
	self add_option("SubMenu2", "Option7");
	self add_option("SubMenu2", "Option8");
	self add_option("SubMenu2", "Option9");
	self add_option("SubMenu2", "Option10");
	self add_option("SubMenu2", "Option11");
	self add_option("SubMenu2", "Option12");
	self add_option("SubMenu2", "Option13");
	
	self add_menu("SubMenu3", self.menuname, "Admin");
	self add_option("SubMenu3", "Option1");
	self add_option("SubMenu3", "Option2");
	self add_option("SubMenu3", "Option3");
	self add_option("SubMenu3", "Option4");
	self add_option("SubMenu3", "Option5");
	self add_option("SubMenu3", "Option6");
	self add_option("SubMenu3", "Option7");
	self add_option("SubMenu3", "Option8");
	self add_option("SubMenu3", "Option9");
	self add_option("SubMenu3", "Option10");
	self add_option("SubMenu3", "Option11");
	self add_option("SubMenu3", "Option12");
	self add_option("SubMenu3", "Option13");
	
	self add_menu("SubMenu4", self.menuname, "Admin");
	self add_option("SubMenu4", "Option1");
	self add_option("SubMenu4", "Option2");
	self add_option("SubMenu4", "Option3");
	self add_option("SubMenu4", "Option4");
	self add_option("SubMenu4", "Option5");
	self add_option("SubMenu4", "Option6");
	self add_option("SubMenu4", "Option7");
	self add_option("SubMenu4", "Option8");
	self add_option("SubMenu4", "Option9");
	self add_option("SubMenu4", "Option10");
	self add_option("SubMenu4", "Option11");
	self add_option("SubMenu4", "Option12");
	self add_option("SubMenu4", "Option13");
	
	self add_menu("SubMenu5", self.menuname, "Admin");
	self add_option("SubMenu5", "Option1");
	self add_option("SubMenu5", "Option2");
	self add_option("SubMenu5", "Option3");
	self add_option("SubMenu5", "Option4");
	self add_option("SubMenu5", "Option5");
	self add_option("SubMenu5", "Option6");
	self add_option("SubMenu5", "Option7");
	self add_option("SubMenu5", "Option8");
	self add_option("SubMenu5", "Option9");
	self add_option("SubMenu5", "Option10");
	self add_option("SubMenu5", "Option11");
	self add_option("SubMenu5", "Option12");
	self add_option("SubMenu5", "Option13");
	
	self add_menu("SubMenu6", self.menuname, "Admin");
	self add_option("SubMenu6", "Option1");
	self add_option("SubMenu6", "Option2");
	self add_option("SubMenu6", "Option3");
	self add_option("SubMenu6", "Option4");
	self add_option("SubMenu6", "Option5");
	self add_option("SubMenu6", "Option6");
	self add_option("SubMenu6", "Option7");
	self add_option("SubMenu6", "Option8");
	self add_option("SubMenu6", "Option9");
	self add_option("SubMenu6", "Option10");
	self add_option("SubMenu6", "Option11");
	self add_option("SubMenu6", "Option12");
	self add_option("SubMenu6", "Option13");
	
	
	self add_menu("SubMenu7", self.menuname, "Admin");
	self add_option("SubMenu7", "Option1");
	self add_option("SubMenu7", "Option2");
	self add_option("SubMenu7", "Option3");
	self add_option("SubMenu7", "Option4");
	self add_option("SubMenu7", "Option5");
	self add_option("SubMenu7", "Option6");
	self add_option("SubMenu7", "Option7");
	self add_option("SubMenu7", "Option8");
	self add_option("SubMenu7", "Option9");
	self add_option("SubMenu7", "Option10");
	self add_option("SubMenu7", "Option11");
	self add_option("SubMenu7", "Option12");
	self add_option("SubMenu7", "Option13");
	
	
	self add_menu("SubMenu8", self.menuname, "Admin");
	self add_option("SubMenu8", "Option1");
	self add_option("SubMenu8", "Option2");
	self add_option("SubMenu8", "Option3");
	self add_option("SubMenu8", "Option4");
	self add_option("SubMenu8", "Option5");
	self add_option("SubMenu8", "Option6");
	self add_option("SubMenu8", "Option7");
	self add_option("SubMenu8", "Option8");
	self add_option("SubMenu8", "Option9");
	self add_option("SubMenu8", "Option10");
	self add_option("SubMenu8", "Option11");
	self add_option("SubMenu8", "Option12");
	self add_option("SubMenu8", "Option13");
	
	self add_menu("SubMenu9", self.menuname, "Admin");
	self add_option("SubMenu9", "Option1");
	self add_option("SubMenu9", "Option2");
	self add_option("SubMenu9", "Option3");
	self add_option("SubMenu9", "Option4");
	self add_option("SubMenu9", "Option5");
	self add_option("SubMenu9", "Option6");
	self add_option("SubMenu9", "Option7");
	self add_option("SubMenu9", "Option8");
	self add_option("SubMenu9", "Option9");
	self add_option("SubMenu9", "Option10");
	self add_option("SubMenu9", "Option11");
	self add_option("SubMenu9", "Option12");
	self add_option("SubMenu9", "Option13");
	
	self add_menu("SubMenu10", self.menuname, "Admin");
	self add_option("SubMenu10", "Option1");
	self add_option("SubMenu10", "Option2");
	self add_option("SubMenu10", "Option3");
	self add_option("SubMenu10", "Option4");
	self add_option("SubMenu10", "Option5");
	self add_option("SubMenu10", "Option6");
	self add_option("SubMenu10", "Option7");
	self add_option("SubMenu10", "Option8");
	self add_option("SubMenu10", "Option9");
	self add_option("SubMenu10", "Option10");
	self add_option("SubMenu10", "Option11");
	self add_option("SubMenu10", "Option12");
	self add_option("SubMenu10", "Option13");
	
	self add_menu("SubMenu11", self.menuname, "Admin");
	self add_option("SubMenu11", "Option1");
	self add_option("SubMenu11", "Option2");
	self add_option("SubMenu11", "Option3");
	self add_option("SubMenu11", "Option4");
	self add_option("SubMenu11", "Option5");
	self add_option("SubMenu11", "Option6");
	self add_option("SubMenu11", "Option7");
	self add_option("SubMenu11", "Option8");
	self add_option("SubMenu11", "Option9");
	self add_option("SubMenu11", "Option10");
	self add_option("SubMenu11", "Option11");
	self add_option("SubMenu11", "Option12");
	self add_option("SubMenu11", "Option13");
	
	self add_menu("SubMenu12", self.menuname, "Admin");
	self add_option("SubMenu12", "Option1");
	self add_option("SubMenu12", "Option2");
	self add_option("SubMenu12", "Option3");
	self add_option("SubMenu12", "Option4");
	self add_option("SubMenu12", "Option5");
	self add_option("SubMenu12", "Option6");
	self add_option("SubMenu12", "Option7");
	self add_option("SubMenu12", "Option8");
	self add_option("SubMenu12", "Option9");
	self add_option("SubMenu12", "Option10");
	self add_option("SubMenu12", "Option11");
	self add_option("SubMenu12", "Option12");
	self add_option("SubMenu12", "Option13");
	
	self add_menu("SubMenu13", self.menuname, "Admin");
	self add_option("SubMenu13", "Option1");
	self add_option("SubMenu13", "Option2");
	self add_option("SubMenu13", "Option3");
	self add_option("SubMenu13", "Option4");
	self add_option("SubMenu13", "Option5");
	self add_option("SubMenu13", "Option6");
	self add_option("SubMenu13", "Option7");
	self add_option("SubMenu13", "Option8");
	self add_option("SubMenu13", "Option9");
	self add_option("SubMenu13", "Option10");
	self add_option("SubMenu13", "Option11");
	self add_option("SubMenu13", "Option12");
	self add_option("SubMenu13", "Option13");
	
	self add_menu("SubMenu14", self.menuname, "Admin");
	self add_option("SubMenu14", "Move Menu Right", ::MenuMoveRight);
	self add_option("SubMenu14", "Move Menu Left", ::MenuMoveLeft);
	self add_option("SubMenu14", "Option3");
	self add_option("SubMenu14", "option4");
	self add_option("SubMenu14", "Option5");
	self add_option("SubMenu14", "Option6");
	self add_option("SubMenu14", "Option7");
	self add_option("SubMenu14", "Option8");
	self add_option("SubMenu14", "Option9");
	self add_option("SubMenu14", "Option10");
	self add_option("SubMenu14", "Option11");
	self add_option("SubMenu14", "Option12");
	self add_option("SubMenu14", "Option13");
	
	self add_menu("SubMenu15", self.menuname, "Admin");
	self add_option("SubMenu15", "Option1");
	self add_option("SubMenu15", "Option2");
	self add_option("SubMenu15", "Option3");
	self add_option("SubMenu15", "Option4");
	self add_option("SubMenu15", "Option5");
	self add_option("SubMenu15", "Option6");
	self add_option("SubMenu15", "Option7");
	self add_option("SubMenu15", "Option8");
	self add_option("SubMenu15", "Option9");
	self add_option("SubMenu15", "Option10");
	self add_option("SubMenu15", "Option11");
	self add_option("SubMenu15", "Option12");
	self add_option("SubMenu15", "Option13");
	
	
	self add_menu("PlayersMenu", self.menuname, "Co-Host");
	for (i = 0; i < 17; i++)
	{ self add_menu("pOpt " + i, "PlayersMenu", "Co-Host"); }
}

updatePlayersMenu()
{
	self.menu.menucount["PlayersMenu"] = 0;
	for (i = 0; i < 17; i++)
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
		self add_option("pOpt " + i, "Give ^5Co-Host^7", ::changeVerificationMenu, player, "Co-Host");
		self add_option("pOpt " + i, "Give ^1Admin^7", ::changeVerificationMenu, player, "Admin");
		self add_option("pOpt " + i, "Give ^6VIP^7", ::changeVerificationMenu, player, "VIP");
		self add_option("pOpt " + i, "^2Verify^7", ::changeVerificationMenu, player, "Verified");
		self add_option("pOpt " + i, "^3Unverify^7", ::changeVerificationMenu, player, "Unverified");		
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
	self.menu.scroller.y = 50 + (self.menu.curs[self.menu.currentmenu] * 14.40);
	
}

openMenu()
{
    
           self.menu.backgroundMain thread moveTo("y", 10, .4);
    self.menu.backgroundMain2 thread moveTo("y", 296, .4);
    
        self.menu.background thread moveTo("x", 263+self.menuxpos, .4);
        self.menu.scroller thread moveTo("x", 263+self.menuxpos, .4);
        
            self.menu.background FadeOverTime(0.6);
    self.menu.background.alpha = 0.55;
    
    	self.menu.scroller FadeOverTime(0.6);
	self.menu.scroller.alpha = 1;
    
     self.menu.backgroundMain FadeOverTime(0.6);
     self.menu.backgroundMain.alpha = 0.55;
          self.menu.backgroundMain2 FadeOverTime(0.6);
   self.menu.backgroundMain2.alpha = 0.55;
   
	
	self.menu.background1 FadeOverTime(0.6);
    self.menu.background1.alpha = 0.08;
    
    wait 0.5;
    
    
    
        self freezeControls(false);
    self StoreText(self.menuname, self.menuname);
    
        self.menu.title2 FadeOVerTime(0.3);
    self.menu.title2.alpha = 1;
	
	self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 1;
	
	
	self.menu.title FadeOverTime(0.3);


    self.swagtext.alpha = 0.90;
    
    
        self.menu.counter FadeOverTime(0.3);
    self.menu.counter1 FadeOverTime(0.3);
    self.menu.counter.alpha = 1;
    self.menu.counter1.alpha = 1;
    self.menu.counterSlash FadeOverTime(0.3);
    self.menu.counterSlash.alpha = 1;

	self.menu.line MoveOverTime(0.3);
	self.menu.line.y = -50;	
	self.menu.line2 MoveOverTime(0.3);
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
    
        self.menu.counter FadeOverTime(0.3);
    self.menu.counter1 FadeOverTime(0.3);
    self.menu.counter.alpha = 0;
    self.menu.counter1.alpha = 0;
    
    self.menu.counterSlash FadeOverTime(0.3);
    self.menu.counterSlash.alpha = 0;
    
  
     
    
    self.swagtext FadeOverTime(0.30);
    self.swagtext.alpha = 0;
    
    self.menu.title2 FadeOVerTime(0.3);
    self.menu.title2.alpha = 0;

    self.menu.title FadeOverTime(0.30);
    self.menu.title.alpha = 0;
    
	self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -550;
	self.menu.line2 MoveOverTime(0.30);
	self.menu.line2.y = -550;
	
	self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 0;

    self.menu.open = false;
   
   wait 0.3;
   
    
         self.menu.backgroundMain2 FadeOverTime(0.3);
    self.menu.backgroundMain2.alpha = 0;
	
	self.menu.background1 FadeOverTime(0.3);
    self.menu.background1.alpha = 0;
    
       self.menu.scroller FadeOverTime(0.3);
	self.menu.scroller.alpha = 0;
    
    
     self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
    
     self.menu.backgroundMain FadeOverTime(0.3);
    self.menu.backgroundMain.alpha = 0;
     
       self.menu.backgroundMain thread moveTo("y", -500, .4);
    self.menu.backgroundMain2 thread moveTo("y", 500, .4);
    
    self.menu.background thread moveTo("x", 800, .4);
    self.menu.scroller thread moveTo("x", 800, .4);
}

destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
	wait 0.3;

	player.menu.options destroy();	
	player.menu.background1 destroy();
	 player.menu.backgroundMain destroy();
	  player.menu.backgroundMain2 destroy();
	player.menu.scroller destroy();
	player.menu.scroller1 destroy();
	player.infos destroy();
	
	self.menu.title2 destroy();
	
	player.menu.counter destroy();
    player.menu.counter1 destroy();
	player.menu.line destroy();
	player.menu.line2 destroy();
	player.menu.counterSlash destroy();
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
    self.menu.background = self drawShader("white", 800, 35, 155, 262, (0, 0, 0), 0, 0);//263, 20
    self.menu.backgroundMain = self drawShader("white", 263+self.menuxpos, -500, 155, 25, (0, 0.7, 1), 0, 0);//263, 20
    self.menu.backgroundMain2 = self drawShader("white", 263+self.menuxpos, 500, 155, 14, (0, 0.7, 1), 0, 0);//263 296
    self.menu.scroller = self drawShader("white", 800, -100, 155, 12, (0, 0.7, 1), 255, 1);//263, -100
}

titleFlash(){
  for(;;)
    {
    self endon ("stopflash");
    self.menu.title.glowcolor = (1, 0, 0);
    wait 0.7;
    self.menu.title.glowcolor = (0, 1, 0);
    wait 0.7;
    self.menu.title.glowcolor = (0, 0, 1);
    }
}
 
StoreText(menu, title)
{
    self.menu.currentmenu = menu;
    string = "";
    self.menu.title destroy();
    self.menu.title = drawText("Menu Base", "default", 1.5, 235+self.menuxpos, 0, (1, 1, 1), 0, (0, 0.7, 1), 1, 3);
    self.menu.title FadeOverTime(0);
    self.menu.title.alpha = 1;
    self.menu.title setPoint( "LEFT", "LEFT", 590+self.menuxpos, -182 );
   
    
    self.menu.currentmenu = menu;
    string = "";
    self.menu.title2 destroy();
    self.menu.title2 = drawText(title, "default", 1.2, 255+self.menuxpos, 0, (1, 1, 1), 0, (0, 0.7, 1), 1, 3);
    self.menu.title2 FadeOverTime(0);
    self.menu.title2.alpha = 1;
    self.menu.title2 setPoint( "LEFT", "LEFT", 550+self.menuxpos, -161);
    
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string +=self.menu.menuopt[menu][i] + "\n"; }
    
    self.menu.counter destroy();
	self.menu.counter = drawValue(self.menu.curs[menu] + 1, "objective", 1.2, "RIGHT", "CENTER", 325+self.menuxpos, -161, (1, 1, 1), 0, 1, 3);
	self.menu.counter.alpha = 1;				
	
	self.menu.counter1 destroy();
	self.menu.counter1 = drawValue(self.menu.menuopt[menu].size, "objective", 1.2, "RIGHT", "CENTER", 338+self.menuxpos, -161, (1, 1, 1), 0, 1, 3);
	self.menu.counter1.alpha = 1;	
    
    
    self.statuss destroy();
    self.statuss = drawText("Created by: CMT Frosty", "default", 1.1, 0+self.menuxpos, 0, (1, 1, 1), 0, (0, 0.7, 1), 1, 4);
    self.statuss FadeOverTime(0);
    self.statuss.alpha = 1;
    self.statuss setPoint( "LEFT", "LEFT", 550+self.menuxpos, 99);
    
    self.menu.options destroy();
    self.menu.options = drawText(string, "objective", 1.2, 290+self.menuxpos, 90, (1, 1, 1), 0, (0, 0, 0), 0, 4);
    self.menu.options FadeOverTime(0.5);
    self.menu.options.alpha = 1;
    self.menu.options setPoint( "LEFT", "LEFT", 550+self.menuxpos, -148);
 
}
    
//
MenuInit()
{
	self endon("disconnect");
	self endon( "destroyMenu" );
	//level endon("game_ended");
       
	self.menu = spawnstruct();
	self.toggles = spawnstruct();
     
	self.menu.open = false;
	
	self StoreShaders();
	self CreateMenu();
	
	for(;;)
	{  
		if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open) 
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
				
				self.menu.counter setValue(self.menu.curs[self.menu.currentmenu] + 1);
self.menu.counter1 setValue(self.menu.menuopt[self.menu.currentmenu].size);
				
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






















