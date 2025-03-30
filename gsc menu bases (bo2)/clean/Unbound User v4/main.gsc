/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : YouViolateMe
*	 Project : Unbound User v4
*    Mode : Multiplayer
*	 Date : 2015/07/20 - 21:53:31	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
#include maps\mp\gametypes\_globallogic_score;
#include maps\mp\gametypes\_rank;
#include maps\mp\teams\_teams;

init()
{    
    level thread onPlayerConnect();
    	
    level.result = 0;
    
    /*
    Down below is the requirements for the wallhack function
    */
    precacheShader("hud_remote_missile_target");
	precacheShader("headicon_dead");
	level.deads = "headicon_dead";
	level.esps = "hud_remote_missile_target";
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        
        if (isDefined(level.antijoin)) //custom antijoin
        {
        	if (level.antijoin)
        		kickclientent(player); //kick client if antijoin is enabled
        	else
        		player thread onPlayerSpawned();
        }
        else
        {
        	player thread onPlayerSpawned();
        }
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	
	isFirstSpawn = true;
	
    for(;;)
    {
        self waittill("spawned_player");
        
        self freezecontrols(false);
        
        if (isFirstSpawn && self isHost())
        {
        	self iprintln("^4Unbound User v4 ^4Remake");
			self iprintln("^4By ^4YouViolateMe");
			
            isFirstSpawn = false;
			thread overflowfix();
        	self thread InitializeMenu(); 
        }
    }
}

InitializeMenu() //contains all the functions/arrays/structs/variables for our menu
{
	self.UnboundUser = spawnstruct();
	self.UnboundUser.options = [];
	self.UnboundUser.allmenus = [];
	self.UnboundUser.toplevelmenus = [];
	self.UnboundUser.MenuOpen = false;
	self.UnboundUser.currentmenu = "";
	self.UnboundUser.curs = 0;
	self.UnboundUser.toplevelmenucount = 0;
	self.UnboundUser.toplevelmenucurs = 0;
	self.UnboundUser.optionstoshow = 6;
	
	self.godmode = false;
	self.infammo = false;
	self.testvar = false;
	self.fov = false;
	self.isbuckshot = false;
	self.forcehost = false;
	self.ranked = false;
	self.dropshot = false;
	self.hostonlyjump = false;
	self.uav = false;
	self.wallhack = false;
	self.fps = false;
	self.explobullets = false;
	self.stalkerMode = false;
	self.thirdperson = false;	
	self.emp = false;
	self.ev = false;
	self.lv = false;
	self.bw = false;
	self.aimassist = false;
	self.stealthaimassist = false;
	self.knifebot = false;
	self.across = false;
	self.invisiblegun = false;
	self.names = false;
	self.crosshair = false;
	self.flashammo = false;
	self.bignames = false;
	self.leftgun = false;
	self.killcam = false;
	self.superreload = false;
	
	self.martyrdom = "";
	
	//level variables
	if (self isHost()) //only set variables for the level once
	{
		level.antijoin = false;
		level.unlimtime = false;
		level.speed = false;
		level.jump = false;
		level.falldamage = false;
		level.chat = false;
		level.timescale = false;
		level.antiquit = false;
		level.melee = false;
		level.knock = false;
		level.skycolor = false;
	}
	
	self DrawHUD(); //creates our HUD text
	self CreateOptions(); //spawns the options, check options.gsc to edit the options
	self thread MonitorButtons(); //button monitoring, check menucontroller.gsc to edit button monitoring
	self thread WaitForDeath(); //checks for death, and resets HUD text
	self thread updateMenuOptionsLoop(); //constantly updates menu options
	self thread maps\mp\gametypes\_hud_message::hintMessage("Press [{+actionslot 1}] to open the menu!", 4);
}


/*
^1 - RED 
^2 - GREEN 
^3 - YELLOW 
^4 - BLUE 
^5 - CYAN 
^6 - PINK 
^7 - WHITE 
^8 - DEFAULT MAP COLOR 
^9 - GREY OR DEFAULT MAP COLOR 
^0 - BLACK 
^; - YALE BLUE 
^: - LIGHT YELLOW
*/













