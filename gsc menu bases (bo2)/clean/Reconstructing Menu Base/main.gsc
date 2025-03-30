//Dont add stupid text just because you want credits, all you did is make a fucked up edit that i had to fix, thanks.
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;

init()
{
	level.result = 1;
	level.firstHostSpawned = false;
	level thread onMenuConnect();
	foreach( Items in strTok( "level.fx_smokegrenade_single", ",") )
    precacheitem( Items );
    foreach( Models in strTok( "mp_flag_red,mp_flag_green,map_mortar_selector,t6_wpn_supply_drop_axis,t6_wpn_supply_drop_ally,t6_wpn_tablet_view,german_shepherd,defaultactor,", ",") )
    level.H4x = "M"+"e"+"n"+"u"+"B"+"a"+"s"+"e";
    precacheModel( Models );
    foreach( shades in strTok( "ui_sliderbutt_1,emblem_bg_prestige05,emblem_bg_movie_star,rank_prestige05,hud_remote_missile_target,headicon_dead,progress_bar_bg,compass_emp,menu_camo_tiger_blue_pattern,em_bg_flag_united_states,lui_loader_no_offset,overlay_low_health,hud_infinity,em_bg_ani_octane,hud_remote_missile_target,headicon_dead,em_bg_ani_w115,hud_team_emp,em_bg_ani_anarchy,menu_camo_diamond_pattern,script_model,compass_static,rank_prestige12,rank_prestige13,rank_prestige14,rank_prestige11,rank_prestige15,line_horizontal,gradient,gradient_center,ui_scrollbar_arrow_right,headicon_dead,emblem_bg_ghost,emblem_bg_roxann_soldier,emblem_bg_graf,emblem_bg_dayofdead,emblem_bg_kawaii,emblem_bg_partyrock,emblem_bg_ben,emblem_bg_snake,emblem_bg_zombies,emblem_bg_aqua,emblem_bg_breach,emblem_bg_dcoyote,emblem_bg_zulu,emblem_bg_massacre,emblem_bg_pap,em_bg_prestige_9,em_bg_prestige_10,em_bg_prestige_11", ",") )
	precacheShader( shades );
}
onMenuConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		player.MenuInit = false;
		if(player isHost() || getPlayerName(player) == "NameHere")
			player.status = "Host";
		else 
			player.status = "Unverified";
		level.AIOTitle = level.H4x;	
		if(player isVerified()) 
			player giveMenu();
			
		player thread onMenuSpawned();
	}
}
onMenuSpawned()
{
	self endon("disconnect");
	level endon("game_ended");
	isFirstSpawn = false;
	for(;;)
	{
		self waittill("spawned_player");
		if(!level.firstHostSpawned && self.status == "Host")
		{
			thread overflowfix();
			level.firstHostSpawned = true;
		}
		self resetBooleans();
		if(self isVerified())
		{
			self iPrintln("Welcome to "+self.AIO["menuName"]);
			if(self.menu.open)
				self freezeControlsallowlook(true);
		}
		if(!isFirstSpawn)
		{
			if(self isHost())
			self freezecontrols(false);
			isFirstSpawn = true;
		}
	}
}
MenuInit()
{
	self endon("disconnect");
	self endon("destroyMenu");
	level endon("game_ended");
	
	self.isOverflowing = false;
	
	self.menu = spawnstruct();
	self.menu.open = false;
	
	self.AIO = [];
	self.AIO["menuName"] = level.AIOTitle;
	
	self.CurMenu = self.AIO["menuName"];
	self.CurTitle = self.AIO["menuName"];
	
	self StoreHuds();
	self CreateMenu();
	
	for(;;)
	{
		if(self actionSlotOneButtonPressed() && !self.menu.open)
			self OnMenuOpen();
			
		if(self.menu.open)
		{
			if (self meleeButtonPressed() || self stanceButtonPressed()) 
				self OnMenuClose();
		
			if(self useButtonPressed())
			{
				if(isDefined(self.menu.previousmenu[self.CurMenu]))
				{
					self submenu(self.menu.previousmenu[self.CurMenu], self.menu.subtitle[self.menu.previousmenu[self.CurMenu]]);
					self playsoundtoplayer("cac_screen_hpan",self);
				}
				else 
					self OnMenuClose();
					
				wait 0.20;
			}
			if(self adsButtonPressed())
			{
				self.menu.curs[self.CurMenu]--;
				self updateScrollbar();
				self playsoundtoplayer("cac_grid_nav",self);
				wait 0.124;
			}
			if(self attackButtonPressed())//scrolls down
			{
				self.menu.curs[self.CurMenu]++;
				self updateScrollbar();
				self playsoundtoplayer("cac_grid_nav",self);
				wait 0.124;
			}
			if(self jumpButtonPressed())
			{
				self thread [[self.menu.menufunc[self.CurMenu][self.menu.curs[self.CurMenu]]]](self.menu.menuinput[self.CurMenu][self.menu.curs[self.CurMenu]], self.menu.menuinput1[self.CurMenu][self.menu.curs[self.CurMenu]]);
				wait 0.20;
			}
		}
		wait 0.05;
	}
}
CreateMenu()
{
	if(self isVerified())
	{
		AM(self.AIO["menuName"], undefined, self.AIO["menuName"]);
		AO(self.AIO["menuName"], "Sub Menu 1", ::submenu, J1, "Sub Menu 1");	
		AO(self.AIO["menuName"], "Sub Menu 2", ::submenu, J2, "Sub Menu 2");
		AO(self.AIO["menuName"], "Sub Menu 3", ::submenu, J3, "Sub Menu 3");
		AO(self.AIO["menuName"], "Sub Menu 4", ::submenu, J4, "Sub Menu 4");	
	}
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP")
	{
		AO(self.AIO["menuName"], "Sub Menu 5", ::submenu, J5, "Sub Menu 5");
		AO(self.AIO["menuName"], "Sub Menu 6", ::submenu, J6, "Sub Menu 6");
		AO(self.AIO["menuName"], "Sub Menu 7", ::submenu, J6, "Sub Menu 7");
		AO(self.AIO["menuName"], "Sub Menu 8", ::submenu, J6, "Sub Menu 8");
		AO(self.AIO["menuName"], "Sub Menu 9", ::submenu, J6, "Sub Menu 9");		
	}
	if(self.status == "Host" || self.status == "Co-Host" || self.status == "Admin")
	{
		AO(self.AIO["menuName"], "Sub Menu 10", ::submenu, J6, "Sub Menu 10");
		AO(self.AIO["menuName"], "Sub Menu 11", ::submenu, J6, "Sub Menu 11");
		AO(self.AIO["menuName"], "Sub Menu 12", ::submenu, J6, "Sub Menu 12");
		AO(self.AIO["menuName"], "Sub Menu 13", ::submenu, J6, "Sub Menu 13");
		AO(self.AIO["menuName"], "Sub Menu 14", ::submenu, J6, "Sub Menu 14");		
	}
	if(self.status == "Host" || self.status == "Co-Host")//Co-Host Menu
	{
		AO(self.AIO["menuName"], "Sub Menu 15", ::submenu, J6, "Sub Menu 15");
		AO(self.AIO["menuName"], "Sub Menu 16", ::submenu, J6, "Sub Menu 16");
		AO(self.AIO["menuName"], "Sub Menu 17", ::submenu, J6, "Sub Menu 17");
		AO(self.AIO["menuName"], "Sub Menu 18", ::submenu, J6, "Sub Menu 18");		
	}
	if(self.status == "Host" || self.status == "Co-Host")
	{
		AO(self.AIO["menuName"], "Sub Menu 19", ::submenu, J6, "Sub Menu 19");
		AO(self.AIO["menuName"], "Sub Menu 20", ::submenu, J6, "Sub Menu 20");
		AO(self.AIO["menuName"], "Sub Menu 21", ::submenu, J6, "Sub Menu 21");
		AO(self.AIO["menuName"], "Sub Menu 22", ::submenu, J6, "Sub Menu 22");		
		AO(self.AIO["menuName"], "Client Options", ::submenu, "PlayersMenu", "Client Options");
	}
		J1="SubX1";
		AM(J1, self.AIO["menuName"], "Sub Menu 1");
		AO(J1, "God Mode", ::InfiniteHealth, true);
		AO(J1, "Debug Exit", ::debugexit);

		J2="SubX2";
		AM(J2, self.AIO["menuName"], "Sub Menu 2");
		AO(J2, "Option 1", ::test);

		J3="SubX3";
		AM(J3, self.AIO["menuName"], "Sub Menu 3");
		AO(J3, "Option 1", ::test);

		J4="SubX4";
		AM(J4, self.AIO["menuName"], "Sub Menu 4");
		AO(J4, "Option 1", ::test);
		
		J5="SubX5";
		AM(J5, self.AIO["menuName"], "Sub Menu 5");
		AO(J5, "Option 1", ::test);		

		AM("PlayersMenu", self.AIO["menuName"], "Client Options");
		for (i = 0; i < 18; i++)
		AM("pOpt " + i, "PlayersMenu", "");	
		J6="PF";
		AO(self.AIO["menuName"], "All Clients", ::submenu, J6, "All Clients");
		AM(J6, self.AIO["menuName"], "All Clients");
		AO(J6, "Unverify All", ::changeVerificationAllPlayers, "Unverified");
		AO(J6, "Verify All", ::changeVerificationAllPlayers, "Verified");		
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
		
		AO("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
			AM("pOpt " + i, "PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName);
				AO("pOpt " + i, "Status", ::submenu, "pOpt " + i + "_3", "[" + verificationToColor(player.status) + "^7] " + playerName);
					AM("pOpt " + i + "_3", "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
						AO("pOpt " + i + "_3", "Unverify", ::changeVerificationMenu, player, "Unverified");
						AO("pOpt " + i + "_3", "Verify", ::changeVerificationMenu, player, "Verified");
						AO("pOpt " + i + "_3", "VIP", ::changeVerificationMenu, player, "VIP");
						AO("pOpt " + i + "_3", "Admin", ::changeVerificationMenu, player, "Admin");
						AO("pOpt " + i + "_3", "Co-Host", ::changeVerificationMenu, player, "Co-Host");
						
		if(!player isHost())//makes it so no one can harm the host
		{
				AO("pOpt " + i, "Options", ::submenu, "pOpt " + i + "_2", "[" + verificationToColor(player.status) + "^7] " + playerName);
					AM("pOpt " + i + "_2", "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
						AO("pOpt " + i + "_2", "Kill Player", ::killPlayer, player);
		}
	}
}
AM(Menu, prevmenu, menutitle)
{
    self.menu.getmenu[Menu] = Menu;
    self.menu.scrollerpos[Menu] = 0;
    self.menu.curs[Menu] = 0;
    self.menu.menucount[Menu] = 0;
    self.menu.subtitle[Menu] = menutitle;
    self.menu.previousmenu[Menu] = prevmenu;
}
AO(Menu, Text, Func, arg1, arg2)
{
    Menu = self.menu.getmenu[Menu];
    Num = self.menu.menucount[Menu];
    self.menu.menuopt[Menu][Num] = Text;
    self.menu.menufunc[Menu][Num] = Func;
    self.menu.menuinput[Menu][Num] = arg1;
    self.menu.menuinput1[Menu][Num] = arg2;
    self.menu.menucount[Menu] += 1;
}
OnMenuOpen()
{
	self.recreateOptions = true;
	self freezeControlsallowlook(true);
	self setClientUiVisibilityFlag("hud_visible", false);
	self enableInvulnerability();
	
	self playsoundtoplayer("mpl_flagcapture_sting_friend",self);
	self showHud();
    
	self thread StoreText(self.CurMenu, self.CurTitle);
	self updateScrollbar();
	
	self.menu.open = true;
	self.recreateOptions = false;
}
OnMenuClose()
{
	self freezeControlsallowlook(false);
	
	//do not remove
	if(!self.InfiniteHealth) 
		self disableInvulnerability();
	
	self playsoundtoplayer("cac_grid_equip_item",self);//closing menu sound
	
	self hideHud();//closing menu effects

	self setClientUiVisibilityFlag("hud_visible", true);
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
	
	if(isDefined(self.AIO["options"]))//do not remove this
	{
		for(i = 0; i < self.AIO["options"].size; i++)
			self.AIO["options"][i] destroy();
	}

	self setClientUiVisibilityFlag("hud_visible", true);
	self.menu.open = false;
	
	wait 0.01;//do not remove this
	//destroys hud elements
	self.AIO["backgroundouter"] destroyElem();
	self.AIO["barclose"] destroyElem();
	self.AIO["background"] destroyElem();
	self.AIO["scrollbar"] destroyElem();
	self.AIO["bartop"] destroyElem();
	self.AIO["barbottom"] destroyElem();
	self.AIO["InfoBox0"] destroyElem();
    self.AIO["InfoBox1"] destroyElem();
	self.AIO["InfoBox2"] destroyElem();
	//destroys text elements
	self.AIO["title"] destroy();
	self.AIO["closeText"] destroy();
	self.AIO["status"] destroy();
}
submenu(input, title)
{
	if(!self.isOverflowing)
	{
		if(isDefined(self.AIO["options"]))//do not remove this
		{		
			for(i = 0; i < self.AIO["options"].size; i++)
				self.AIO["options"][i] affectElement("alpha", 0, 0);
		}
		self.AIO["title"] affectElement("alpha", 0, 0);
	}

	if (input == self.AIO["menuName"]) 
		self thread StoreText(input, self.AIO["menuName"]);
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
	
	if(!self.isOverflowing)
	{
		if(isDefined(self.AIO["options"]))//do not remove this
		{		
			for(i = 0; i < self.AIO["options"].size; i++)
				self.AIO["options"][i] affectElement("alpha", .2, 1);
		}
		self.AIO["title"] affectElement("alpha", .2, 1);
	}
	
	self updateScrollbar();
	self.isOverflowing = false;
}








