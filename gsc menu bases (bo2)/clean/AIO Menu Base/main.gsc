#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;

init()
{
	level.result = 1;//set to 1 for the overflow fix string
	
	level.firstHostSpawned = false;
	
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connecting", player);
		
		player.MenuInit = false;
		
		if(player isHost() || getPlayerName(player) == "Dynamacy")//here you can add host players
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
		
		if(!level.firstHostSpawned && self.status == "Host")//the first host player that spawns calls on the overflow fix
		{
			thread overflowfix();
			level.firstHostSpawned = true;
		}
		
		self resetBooleans();//resets variable bools

		if(self isVerified())
		{
			self iPrintln("Welcome to "+self.AIO["menuName"]);
			
			if(self.menu.open)//if the menu is open when you spawn
				self freezeControlsallowlook(true);
		}
		if(!isFirstSpawn)//First official spawn
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
	self.AIO["menuName"] = "AIO Menu Base";//Put your menu name here
	
	//Setting the menu position for when it's first open
	self.CurMenu = self.AIO["menuName"];
	self.CurTitle = self.AIO["menuName"];
	
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
					self playsoundtoplayer("cac_screen_hpan",self);//back button menu sound
				}
				else 
					self _closeMenu();
					
				wait 0.20;
			}
			if(self adsButtonPressed())//scrolls up
			{
				self.menu.curs[self.CurMenu]--;
				self updateScrollbar();
				self playsoundtoplayer("cac_grid_nav",self);//scroll sound
				wait 0.124;
			}
			if(self attackButtonPressed())//scrolls down
			{
				self.menu.curs[self.CurMenu]++;
				self updateScrollbar();
				self playsoundtoplayer("cac_grid_nav",self);//scroll sound
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



