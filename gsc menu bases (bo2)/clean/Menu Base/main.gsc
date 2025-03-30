/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : Mario
*	 Project : Menu Base
*    Mode : Multiplayer
*	 Date : 2015.06.25 - 07:07:52	
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
    PrecacheShader("ui_scrollbar_arrow_right");
    PrecacheShader("ui_scrollbar_arrow_left");
    PrecacheShader("gradient");
    PrecacheShader("gradient_center");
    PrecacheShader("scorebar_fadein");
    PrecacheShader("line_horizontal");
    level.result = 0;
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
        wait 0.05;
    }
    wait 0.05;
}

onPlayerSpawned()
{
    self endon("disconnect");
    self _setUpMenu();
    self initBools();
	isFirstSpawn = true;
    for(;;)
    {
        self waittill("spawned_player");
        _closeMenu(self);
        self thread init_menu();
        if(isFirstSpawn==true)
        {
        	init_Verifycation(self);
        	if(self isHost())
        	{
        		overflowfix();
        	}
        	isFirstSpawn = false;
        }
        wait 0.05;
    }
    wait 0.05;
}










