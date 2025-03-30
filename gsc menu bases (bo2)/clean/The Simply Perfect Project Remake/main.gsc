/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : YouViolateMe
*	 Project : The Simply Perfect Project Remake
*	 Mode : Multiplayer
*	 Date : 2015/07/25 - 11:26:49	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    level thread onPlayerConnect();
    
    level.result = 0;
    level.Verified = [];
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	
	if (self isHost())
		thread overflowfix();
		
	isFirstSpawn = true;
		
    for(;;)
    {
        self waittill("spawned_player");
        
        if (isFirstSpawn)
        {
        	isFirstSpawn = false;
        	self thread InitializeMenu();
        }
		
		// Will appear each time when the player spawn, that's just an exemple.
		self iprintln("Welcome to the Simply Perfect Project Remake!");
		self iprintln("AoKMiKeY and YouViolateMe <3");
    }
}

InitializeMenu()
{
	self.SimplyPerfect = spawnStruct();
	self.SimplyPerfect.options = [];
	self.SimplyPerfect.allmenus = [];
	self.SimplyPerfect.menus = [];
	self.SimplyPerfect.MenuOpen = false;
	self.SimplyPerfect.DoingAnim = false;
	self.SimplyPerfect.currentmenu = "";
	self.SimplyPerfect.cursorspacing = 36;
	self.SimplyPerfect.curs = 0;
	self.SimplyPerfect.scrollerpos = 0;
	self.SimplyPerfect.optionstoshow = 10;
	self.SimplyPerfect.optionstoshow_constant = self.SimplyPerfect.optionstoshow; //do not change this
	self.SimplyPerfect.cursorStartingYPos = -170;
	self.SimplyPerfect.SelectedPlayer = self;
	
	self.MenuAccess = "Unverified";
	
	if (self isHost())
		self.MenuAccess = "Host";
	
	self freezecontrols(false);
	
	self checkIfVerified();
	self SpawnBooleans();
	self CreateOptions();
	self DrawHUD();
	self thread MonitorControls();
	self thread WaitForDeath();
	self thread WaitForGameEnd();
}

openMenu()
{
	self.SimplyPerfect.background scaleOverTime(0.55, 300, 30); //width
	self.SimplyPerfect.background affectElement("x", 0.55, 200);
	self.SimplyPerfect.cursor scaleOverTime(0.65, 300, 30);
	self.SimplyPerfect.cursor affectElement("x", 0.65, 50);
	
	wait 0.65;
	
	self.SimplyPerfect.cursor scaleOverTime(0.55, 2, 30);
	self.SimplyPerfect.background scaleOverTime(0.55, 300, 400);
	
	wait 0.55;
	
	self.SimplyPerfect.MenuOpen = true;
	
	self callMenu(self.SimplyPerfect.allmenus[0]);
	
	self.SimplyPerfect.cursor affectElement("y", 0.55, self.SimplyPerfect.cursorStartingYPos);
	
	self updateTextEffects(3);
	
	self doOpeningAnim();
	
	self updateTextEffects(1);
}

closeMenu()
{
	self thread doClosingAnim();
	
	self.SimplyPerfect.cursor affectElement("y", 0.2, 0);
	
	wait 0.2; 
	
	self.SimplyPerfect.background scaleOverTime(0.6, 300, 30);
	
	wait .6;
	
	self.SimplyPerfect.cursor scaleOverTime(0.3, 300, 30);
	
	wait .3;
	
	self.SimplyPerfect.cursor affectElement("x", 0.2, 600);
	self.SimplyPerfect.background affectElement("x", 0.25, 600);
	
	wait .25;
	
	
	
	self.SimplyPerfect.MenuOpen = false;
}

WaitForDeath()
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		self waittill("death");
		
		if (self.SimplyPerfect.MenuOpen)
		{
			if (!self.SimplyPerfect.DoingAnim)
				closeMenu();
		}
	}
}

WaitForGameEnd()
{
	self endon("disconnect");
	
	for(;;)
	{
		level waittill("game_ended");
		
		if (self.SimplyPerfect.MenuOpen)
		{
			if (!self.SimplyPerfect.DoingAnim)
				closeMenu();
		}
	}
}










