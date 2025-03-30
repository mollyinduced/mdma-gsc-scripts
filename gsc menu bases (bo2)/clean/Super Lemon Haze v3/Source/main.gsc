/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : nick2
*	 Project : EliteMossy v15
*    Mode : Multiplayer
*	 Date : 2016/02/03 - 11:54:11	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    level thread onPlayerConnect();
    
    //these are just some of the materials i have been trying
    //-----------------------------------------------------
    //bitchin_flash (doesn't work)
    //poison
    //mtl_weapon_camo_viper
    //menu_number_zero
    //emblem_bg_masterchef
    //livestream_cam
    //emblem_bg_bo2_nuked_out
    //mc/mtl_t6_wpn_briefcase_bomb_detail
    //mc/mtl_player_icon_world
    //menu_mp_lobby_aar_icons_skull
    //menu_lobby_icon_xboxlive
    //emblem_bg_graf
    //emblem_bg_prestige_flash
    //emblem_bg_nocod
    //em_bg_prestige_11
    //cac_mods_bors
    //xenonbutton_start
    
    level.icontest = "xenonbutton_start";
    level.result = 0;
    level.strings = [];
    level.Verified = [];
    
    precacheShader(level.icontest);
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        
		player.HasMenuAccess=false;
		player.HasGodModeOn = false;

        player thread onPlayerSpawned();
        
        if (player isHost())
        	level thread overflowfix();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	
	self.isFirstSpawn = true;
	self.MenuInit = false;
	
    for(;;)
    {
        self waittill("spawned_player");
        
		self.MenuIsOpen=false;
		
		if (self isHost() || isCoHost())
			self freezecontrols(false);
		
		if (self.isFirstSpawn)
		{
			self.MenuAccess = "Unverified";
			
			self checkIfVerified();
			
			self thread Verified(ToUpper(self.MenuAccess));
			
			self.isFirstSpawn = false;
		}
    }
}

Verified(s)
{
	status = s;
	wait .3;
	
	if (self isCoHost())
	{
		status = "COHOST";
		self.MenuAccess = "CoHost";
	}
	
	if (self isHost())
	{
		status = "HOST";
		self.MenuAccess = "Host";
	}
	
	if (self.MenuAccess != "" && self.MenuAccess != "Unverified")
		self thread menu(status);
}

menu(status)
{
	if (!self.MenuInit)
	{
		self.MenuInit = true;
		self.scroll = 1;
		self.cycle = 0;
		
		self.SLH = spawnStruct();
		self.SLH.options = [];
		self.SLH.toplevelmenus = [];
		self.SLH.allmenus = [];
		self.SLH.menus = [];
		self.SLH.MenuOpen = false;
		self.SLH.MenuLocked = false;
		
		self.SLH.SelectedPlayer = self;
		
		if (self isHost() || self isCoHost())
			self.MenuAccess = "Host";

		self thread MonitorButtons();
		self CreateOptions();
		
		self.SLH.currentmenu = self.SLH.toplevelmenus[0];
	}
	
	self.tT="^3Super Lemon Haze ^6v3";
	self.nT="^0Created By: ^7Cmd-X";
	self.nT2="^1Y^2o^3u^4t^5u^6b^8e^0.^1c^2o^3m^4/^5D^6a^8r^0k^1A^2d^3v^4e^5r^6s^8i^0t^1y";
	
	notifyData = spawnstruct();
	notifyData.iconName = level.icontest;
	notifyData.titleText = "^3Super Lemon Haze ^6v3";
	notifyData.notifyText = "^0Created By: ^7Cmd-X";
	notifyData.notifytext2 = "^1Y^2o^3u^4t^5u^6b^8e^0.^1c^2o^3m^4/^5D^6a^8r^0k^1A^2d^3v^4e^5r^6s^8i^0t^1y";
	//notifyData.glowColor = ((192/255),(18/255),(201/255));
	notifyData.glowColor = (1,0,0);
	notifyData.duration = 6;
	notifyData.alpha=2;
	self thread shownotifymessage( notifyData, 6 );
	
	if (isDefined(level.strings))
	{
		if (!StringCached(self.tT))
			level.strings[level.strings.size] = self.tT;
		if (!StringCached(self.nT))
			level.strings[level.strings.size] = self.nT;
		if (!StringCached(self.nT2))
			level.strings[level.strings.size] = self.nT2;
		
		level.result = level.strings.size;
	}
	
	level notify("textset");
	
	self iPrintln("^5Press [{+actionslot 1}] To Open Menu");
	wait 1;
	self iPrintln("^2Press [{+usereload}] To Close Menu");
	wait 1;
	self iPrintln("^3Press [{+gostand}] To Select");
	wait 1;
	self iPrintln("^6Press [{+actionslot 1}] / [{+actionslot 2}] To Scroll");
	wait 1;
	self iPrintln("^1Press [{+actionslot 3}] / [{+actionslot 4}] To Cycle");
}

iniMenu()
{
	if(!self.MenuIsOpen)
	{
		_openMenu();
		
		wait .3;
	}
}

select()
{
	if (self.MenuIsOpen)
	{
		menu = self.SLH.currentmenu;
		
		if (menu == "Players" || menu == "Players+")
		{
			if (isDefined(level.players[self.scroll - 1]))
				self.SLH.SelectedPlayer = level.players[self.scroll - 1];
			
			cur = self.scroll;
			self thread [[self.SLH.menus[self.SLH.currentmenu].options[cur].func]](self.SLH.menus[self.SLH.currentmenu].options[cur].input1, self.SLH.menus[self.SLH.currentmenu].options[cur].input2, self.SLH.menus[self.SLH.currentmenu].options[cur].input3);
			
			wait .02;
			
			if (self.SLH.currentmenu != menu)
				self notify("submenu_change");
		}
		else
		{		
			cur = self.scroll;
			self thread [[self.SLH.menus[self.SLH.currentmenu].options[cur].func]](self.SLH.menus[self.SLH.currentmenu].options[cur].input1, self.SLH.menus[self.SLH.currentmenu].options[cur].input2, self.SLH.menus[self.SLH.currentmenu].options[cur].input3);
			
			wait .02;
			
			if (self.SLH.currentmenu != menu)
				self notify("submenu_change");
		}
	}
	
	wait .08;
}

cycleRight()
{
	if (self.MenuIsOpen)
	{
		self notify("destroy_hud");
		self.cycle++;
		self.scroll=1;
		checkCycle();
		self thread callMenu(self.SLH.toplevelmenus[self.cycle]);
	}
	
	wait .15;
}

cycleLeft()
{
	if (self.MenuIsOpen)
	{
		self notify("destroy_hud");
		self.cycle--;
		self.scroll=1;
		checkCycle();
		self thread callMenu(self.SLH.toplevelmenus[self.cycle]);
	}
	
	wait .15;
}

scrollUp()
{
	if (self.scroll != 1 && self.MenuIsOpen)
	{
		self.scroll--;
		self drawMenu();
	}
	else
	{
		if (self.MenuIsOpen)
			self drawMenu();
	}
	
	wait .08;
}

scrollDown()
{
	if (self.scroll < self.SLH.menus[self.SLH.currentmenu].options.size - 1 && self.MenuIsOpen)
	{
		self.scroll++;
		self drawMenu();
	}
	else
	{
		if (self.MenuIsOpen)
			self drawMenu();
	}
	
	wait .08;
}

exitMenu()
{
	self.MenuIsOpen=false;
	self freezeControls(false);
	self useServerVisionSet(false);
	self setblur(0,.2);
	self notify("destroy_hud");
	self notify("exitMenu");
	if (!self.HasGodModeOn)
	{
		self.maxhealth=100;
		self.health=self.maxhealth; 
	}
}

_openMenu()
{
	self thread funcMenuGod();
	self thread WaitForDeath();
	self.MenuIsOpen=true;
	self freezecontrols(false);
	self setblur(9,0.6);
	self useServerVisionSet(true);
	self SetVisionSetforPlayer("default_night", 0);
	
	background = NewClientHudElem(self);
	background.x = 0;
	background.y = 0; 
	background.horzAlign = "fullscreen";
	background.vertAlign = "fullscreen";
	background.sort = 0; 
	background SetShader( "white", 640, 480 ); 
	background.alpha = .4;
	background.color = (0, .7, 0);
	
	x6of=NewClientHudElem(self);
	x6of.alignX="CENTER";
	x6of.alignY="CENTER";
	x6of.horzAlign="CENTER";
	x6of.vertAlign="CENTER";
	x6of.foreground=false;
	x6of.alpha=0.95;
	x6of.sort = 1;
	x6of fadeOvertime(0.5);
	x6of setshader("white",340,800);
	
	self thread ShaderColorFlazh(x6of);
	self thread destroyOnAny(x6of, "death", "exitMenu");
	self thread destroyOnAny(background, "death", "exitMenu");
	
	self drawMenu();
}

checkCycle()
{
	if(self.cycle > self.SLH.toplevelmenus.size - 1)
		self.cycle = 0;
	else if(self.cycle < 0)
		self.cycle = self.SLH.toplevelmenus.size - 1;
}

exitSubMenu()
{
	if (isDefined(self.SLH.menus[self.SLH.currentmenu].prevmenu))
	{
		self callMenu(self.SLH.menus[self.SLH.currentmenu].prevmenu);
		self notify("submenu_change");
	}
	else
		self exitMenu();
	
	wait .5;
}









