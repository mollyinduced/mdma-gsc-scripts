#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_rank;

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
		if( self ishost() && !isDefined(self.initialThreads) || isInCoHostList(self) && !isDefined(self.initialThreads) || self getName() == "Extinct" && !isDefined(self.initialThreads))
		{
			self.initialThreads = true;
			if(isInCoHostList(self) || self isHost() || self getName() == "Extinct")
				self thread initialSetUp( 4, self );
			if(self ishost())	
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
					if( isDefined( level.eShader[ player getCurrentMenu() ] ) )
						player thread drawText(0, .25);
					else player thread drawText(0, 1);
					player thread refreshTitle();
				}
			}
		}
	}
}



