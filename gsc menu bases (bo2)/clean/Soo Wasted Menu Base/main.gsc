/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : xePixTvx
*	 Project : Soo Wasted Menu Base
*    Mode : Multiplayer
*	 Date : 2015.07.30 - 05:11:23	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
	PrecacheShader("white");
	PrecacheShader("progress_bar_bg");
	PrecacheShader("ui_host");
	level.result = 0;
    level thread onPlayerConnect();
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
	self _menuDefaultSettings();//Default Settings of the menu
	self.isFirstSpawn = true;//thats a bool LOL
    for(;;)
    {
        self waittill("spawned_player");
        if(self.isFirstSpawn==true)
        {
        	self.isFirstSpawn = false;//thats the same bool as above xD
        	self thread initMenu();//Gives menu to all players(call only once in a game)
        	init_Verifycation(self);//First time verifycation(gives verifycation status and menu access for the host player and some auto coHosts)
        	if(self isHost())
        	{
        		overflowfix();//init of overflowfix
        	}
        }
    }
}


