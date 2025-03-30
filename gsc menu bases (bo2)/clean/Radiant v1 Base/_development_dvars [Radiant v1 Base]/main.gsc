#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;

init()
{
	level.result = 1;
	
	level.firstHostSpawned = false;
	
	foreach(shader in strTok("ui_scrollbar_arrow_up_a,ui_scrollbar_arrow_dwn_a", ","))
		precacheshader(shader);
	
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		
		player.MenuInit = false;
		
		if(player isHost() || getPlayerName(player) == "Dynamacy") 
			player.status = "Host";
		else 
			player.status = "Unverified";
			
		if(player isVerified()) 
			player giveMenu();
			
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
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
			self iPrintln("Welcome to ^5Radiant "+self.Radiant["version"]+" ^7| Press [{+actionslot 1}] to Open Menu");
			
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
	
	self.menu = spawnstruct();
	self.menu.open = false;
	
	self.Radiant = [];
	self.Radiant["version"] = "v1";
	
	self.CurMenu = "Main Menu";
	self.CurTitle = "Main Menu";
	
	self StoreHuds();
	self CreateMenu();
	
	for(;;)
	{
		if(self actionSlotOneButtonPressed() && !self.menu.open)
			self _openMenu();
			
		if(self.menu.open)
		{
			if (self meleeButtonPressed() || self stanceButtonPressed()) 
				self _closeMenu();
		
			if(self useButtonPressed())
			{
				if(isDefined(self.menu.previousmenu[self.CurMenu]))
				{
					self submenu(self.menu.previousmenu[self.CurMenu], self.menu.subtitle[self.menu.previousmenu[self.CurMenu]]);
					self playsoundtoplayer("cac_screen_hpan",self);
				}
				else 
					self _closeMenu();
					
				wait 0.20;
			}
			if(self adsButtonPressed())
			{
				self.menu.curs[self.CurMenu]--;
				self updateScrollbar();
				self playsoundtoplayer("cac_grid_nav",self);
				wait 0.124;
			}
			if(self attackButtonPressed())
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

