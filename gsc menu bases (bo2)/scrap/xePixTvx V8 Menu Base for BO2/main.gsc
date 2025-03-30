#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
	PrecacheShader("hud_us_grenade");
	level.result = 0;
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
    	level thread RemovedeathTriggers();
        level waittill("connected", player);
        player _setUpMenu();//Load Settings for the menu base
        player thread onPlayerSpawned();
        init_Verifycation(player);//Do Verifycation
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	self.isFristSpawn = true;
    for(;;)
    {
        self waittill("spawned_player");
        if(self.isFristSpawn==true)
        {
        	if(self isHost())
        	{
        		thread overflowfix();
        	}
        }
    }
}

