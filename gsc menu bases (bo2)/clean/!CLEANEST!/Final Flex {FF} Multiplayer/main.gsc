/*
TODO
- Reduce Menu Strings
*/

//HACK - Origins: entitys stop spawning at 970 & game crashes at about 1,300<-----Find out what this is for multiplayer

#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_rank;

init()
{
	level.strings = [];
	level.menuTitle = "Final Flex";
		
	if(getDvar("stealthMenu") == "1")
		level.stealthMenu = true;
		
	shaders = strTok("progress_bar_fg",";");
	array_precache(shaders, "shader");

	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill("connected", player);
		
		if(player getPlayerName() == "vDynamacy")
			player.status = "Creator";
		else if(player isHost()) 
			player.status = "Host";
		else if(isInCoHostList(player))
			player.status = "Co-Host";
		else
			player.status = "None";	
			
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	level endon("game_ended");
	
	isFirstSpawn = false;
	self resetBooleans();
	
	for(;;)
	{
		self waittill("spawned_player");
		if(isDefined(level.superJump)) self setperk("specialty_fallheight");
		if(!isDefined(level.overflowFixThreaded))
		{
			level.overflowFixThreaded = true;
			level thread overflowFix();
		}
		if(!isDefined(self.hasMenu) && self isVerified())
		{
			self.hasMenu = true;
			self thread menuInit();
			self thread closeMenuOnDeath();
			self thread closeMenuOnGameEnd();
		}
		if(!isFirstSpawn)
		{
			isFirstSpawn = true;
			
			if(self isHost())
			{
				setDvar("sv_cheats", 1);
				setdvar("developer", 0);//1 or 2
				self resetDvars();
				//self enableInvulnerability();
			}
		}
		if(isDefined(level.superJump) && !isDefined(self.superJumpBool))
			self thread loopSuperJump();
	}
}

resetDvars()
{
	setdvar( "g_speed", 190 );
	setdvar( "player_MeleeRange", 64 );
	setDvar( "g_knockback", 5 );
}

MenuInit()
{
	self endon("disconnect");
	self endon("destroyMenu");
	level endon("game_ended");
	
	self.menu = spawnstruct();
	self.menu.curMenu = level.menuTitle;
	self.menu.curTitle = level.menuTitle;
	
	self.AIO = spawnstruct();
	self.AIO.shader = [];
	self.AIO.string = [];
	self.AIO.options = [];
	
	self initialMenuSetup();
	
	if(isDefined(self.stillLocked) && self.stillLocked)
	{
		self.stillLocked = false;
		self.menu.Locked = true;
	}
	
	self thread storeInfoBarElem();
	self CreateMenu();
	self thread menuPlayersInfo();
	
	for(;;)
	{
		if(isAlive(self) && !isDefined(self.menu.Locked))
		{
			if(self adsButtonPressed() && self meleeButtonPressed() && !isDefined(self.menu.open))
			{
				self _openMenu();
				wait .2;
			}	
			if(self inMenu())
			{
				if(self stanceButtonPressed()) 
                	self _closeMenu();
				else if(self meleebuttonpressed())
				{
					if(isDefined(self.menu.previousmenu[self.menu.curMenu]))
					{
						self submenu(self.menu.previousmenu[self.menu.curMenu], self.menu.subtitle[self.menu.previousmenu[self.menu.curMenu]]);
						self playlocalSound("fly_fnp45_mag_in");
					}
					else 
						self _closeMenu();
						
					wait .2;
				}
				else if(self adsButtonPressed() || self attackButtonPressed())
				{
					if(!self adsButtonPressed() || !self attackButtonPressed())
					{
						self playlocalSound("fly_shotgun_push");
						self.menu.curs[self.menu.curMenu] += self attackButtonPressed();
						self.menu.curs[self.menu.curMenu] -= self adsButtonPressed();
						self updateScrollbar();
						wait .13;
					}
				}
				else if(self useButtonPressed())
				{
					if(isDefined(self.menu.menuinput[self.menu.curMenu][self.menu.curs[self.menu.curMenu]]) && isDefined(self.menu.menuinput1[self.menu.curMenu][self.menu.curs[self.menu.curMenu]]))
						self thread [[self.menu.menufunc[self.menu.curMenu][self.menu.curs[self.menu.curMenu]]]](self.menu.menuinput[self.menu.curMenu][self.menu.curs[self.menu.curMenu]], self.menu.menuinput1[self.menu.curMenu][self.menu.curs[self.menu.curMenu]]);
					else if(isDefined(self.menu.menuinput[self.menu.curMenu][self.menu.curs[self.menu.curMenu]]))
						self thread [[self.menu.menufunc[self.menu.curMenu][self.menu.curs[self.menu.curMenu]]]](self.menu.menuinput[self.menu.curMenu][self.menu.curs[self.menu.curMenu]]);
					else
						self thread [[self.menu.menufunc[self.menu.curMenu][self.menu.curs[self.menu.curMenu]]]]();
					self playlocalSound("fly_beretta93r_slide_forward");
					wait .2;
				}
			}
		}
		wait .05;
	}
}

initialMenuSetup()
{
	self.menuDesign = [];

	col = strTok("^0|^1|^2|^3|^4|^5|^6|^7","|");
	self.menuDesign["titleAnimColor"] = col[1];
	
	self.menuDesign["menuX"] = 100;
	self.menuDesign["menuY"] = 0;
	
	self.menuDesign["Scrollbar_Color"] = divideColor(0,110,255);
	self.menuDesign["Background_Color"] = divideColor(255,255,255);
	self.menuDesign["Backgroundouter_Color"] = divideColor(0,0,0);
	self.menuDesign["Title_Color"] = divideColor(255,255,255);
	self.menuDesign["TabInfo_Color"] = divideColor(255,255,255);
	self.menuDesign["Options_Color"] = divideColor(255,255,255);
	
	/*
		ADD SAVED HUDS HERE (USING DVARS)
	*/
}












