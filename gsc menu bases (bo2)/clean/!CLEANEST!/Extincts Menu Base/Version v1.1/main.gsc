#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    level thread onPlayerConnect();
    level thread precacheHuds();
    
    level.strings = [];
    level.status = strTok("None;VIP;Admin;Co-Host;Host",";");
    level.developer = "Extinct";
    level.menuName = "Extincts Menu Base";
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
    for(;;)
    {
        self waittill("spawned_player");
		if( self ishost() && !isDefined(self.initialThreads))
		{
			self.initialThreads = true;
			self thread initialSetUp( 4, self );
			thread fixOverFlow();
		}
		else if(!isDefined(self.verStatus))
			self.verStatus = "None";
    }
}

fixOverFlow()
{
	fix = level createServerFontString("default", 1);
	fix.alpha = 0;
	fix setText("OVERFLOWFIX");
	
	if(level.script == "sd")
		A = 45; //A = 220;
	else 				  
		A = 45; //A = 230; 55
	
	while(true)
	{
		level waittill("CHECK_OVERFLOW");
		if(level.strings.size >= A)
		{
			if(isDefined(self.AIO["IS_SCROLLING"]))
			{
				self waittill("SCROLLING_OVER");
				wait .05;
			}
			fix ClearAllTextAfterHudElem();
			level.strings = [];
			level notify("FIX_OVERFLOW");
			foreach(player in level.players)
			{
				player iprintln("^6OVERFLOW");
				if(player isInMenu())
				{
					player thread drawText(0, 1);
					player thread refreshTitle();
				}
			}
		}
	}
}












