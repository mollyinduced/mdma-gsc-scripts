#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons; 
#include maps/_cooplogic;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_rank;

/*
Thank You For Downloading Alexibuscus's Menu Base!
Hope You Like It and Please Leave Credits for Him.
        __   _   __  __  __  _______
       //_\ | | | _| \ \/ /  \(0_0)/
      / __ \| |_| _| / /\ \  /(0_0)\
     /_/  \_\___|__|/_/  \_\ \(0_0)/
*/


init()
{
    level thread onplayerconnect();
	foreach(sh in strTok("em_bg_prestige_9,em_bg_prestige_10,em_bg_prestige_11,em_bg_prestige_8,em_bg_flag_united_kingdom,em_bg_ani_octane,em_bg_ani_armor,em_bg_ani_comics,em_bg_ani_w115,em_bg_ani_afterlife,emblem_bg_tdm_vanquisher,emblem_bg_ffa_vanquisher,emblem_bg_equip_smoke,emblem_bg_nuketown_z,emblem_bg_ghost,emblem_bg_bo2_nuked_out,emblem_bg_pg_game_master,menu_mp_title_screen,emblem_bg_aqua,emblem_bg_movie_star,black,white,compass_emp,compass_static,gradient_center,gradient,ui_slider2",","))
	precacheShader(sh);
	level.icontest = "line_horizontal";
	//do not remove VV
	setDvar("whoosing_mod", "0");
	if(getDvar("animation_menu") == "0" || getDvar("animation_menu") == "")
		setDvar("animation_menu", "1");
	if(getDvar("stealthmenumod") == "0" || getDvar("stealthmenumod") == "")
		setDvar("stealthmenumod", "1");
	//do not remove ^^
	
	level.result=0;
	models = getentarray("script_model", "classname"); //precaches every single model.
	for(i = 0; i < models.size; i++)
	{
		precachemodel(models[i].model);
    }
    precachemodel("fx_axis_createfx");
}

onplayerconnect()
{
    for(;;)
    {
        level waittill( "connecting", player );
        if(player isHost() || player getName() == "TheIronDragonz21")
			player.status = "Host";
		else if(player getName() == getDvar("coHost1") || player getName() == getDvar("coHost2") || player getName() == getDvar("coHost3") || player getName() == getDvar("coHost4") || player getName() == getDvar("coHost5") || player getName() == getDvar("coHost6") || player getName() == getDvar("coHost7") || player getName() == getDvar("coHost8") || player getName() == getDvar("coHost9") || player getName() == getDvar("coHost10") || player getName() == getDvar("coHost11") || player getName() == getDvar("coHost12") || player getName() == getDvar("coHost13") || player getName() == getDvar("coHost14") || player getName() == getDvar("coHost15"))
			player.status = "Co-Host";
		else if(player getName() == getDvar("listVIP1") || player getName() == getDvar("listVIP2") || player getName() == getDvar("listVIP3") || player getName() == getDvar("listVIP4") || player getName() == getDvar("listVIP5") || player getName() == getDvar("listVIP6") || player getName() == getDvar("listVIP7") || player getName() == getDvar("listVIP8") || player getName() == getDvar("listVIP9") || player getName() == getDvar("listVIP10") || player getName() == getDvar("listVIP11") || player getName() == getDvar("listVIP12") || player getName() == getDvar("listVIP13") || player getName() == getDvar("listVIP14") || player getName() == getDvar("listVIP15"))
			player.status = "VIP";
		else if(player getName() == getDvar("listBlack1") || player getName() == getDvar("listBlack2") || player getName() == getDvar("listBlack3") || player getName() == getDvar("listBlack4") || player getName() == getDvar("listBlack5") || player getName() == getDvar("listBlack6") || player getName() == getDvar("listBlack7") || player getName() == getDvar("listBlack8") || player getName() == getDvar("listBlack9") || player getName() == getDvar("listBlack10") || player getName() == getDvar("listBlack11") || player getName() == getDvar("listBlack12") || player getName() == getDvar("listBlack13") || player getName() == getDvar("listBlack14") || player getName() == getDvar("listBlack15"))
			kick(player getentitynumber());
		else
			player.status = "Unverified";
			
        player thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.MenuInit = false;

    isFirstSpawn = true;
    self.glowColour = (0,0.4,1.2);
    self.titleColour = (0,0.4,1.2);
    self.originHealth = self.maxhealth; //original health on first spawn
    self.textColour = (1,1,1);
    self.x = 0;

    for(;;)
    {
		self waittill( "spawned_player" );
		
				if(isFirstSpawn && self.status == "Host")
                {
                        thread overflowfix();
                        isFirstSpawn = false;
                }
                
		if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
			if (!self.MenuInit)
			{
				self.MenuInit = true;
				self thread welcomeMessage();
				self thread MenuInit();
				self freezecontrols(false);
				self thread closeMenuOnDeath();
				self iprintln("^0Welcome ^2"+self.name+"\n^5Press [{+speed_throw}] + [{+actionslot 4}] Open");
				self thread moveonendgame(); //on end gane press menu controls to move.
			}
			//do not remove
			if(getDvar("whooshing_mod") == "" || getDvar("whoosing_mod") == "0")
			{
			 setDvar("whoosing_mod", "1");
			 self thread homefront();
			}
			//do not remove
			if(getDvar("stealthmenumod") == "1")
			{
				self thread stealthmenu();
			}
		}
    }
}

stealthmenu()
{
	self.menu.background.archived = false;
	self.menu.background2.archived = false;
	self.menu.scroller.archived = false;
	self.menu.line.archived = false;
	self.menu.line2.archived = false;
	self.menu.line3.archived = false;
	self.menu.line4.archived = false;
	self.menu.creatortxt.archived = false;
	self.menu.title.archived = false;
	self.tez.archived = false;
	self.menu.options.archived = false;
	self.menu.header.archived = false;
	self.menu.line5.archived = false;
}



welcomeMessage()
{
	self.msg = [];
	self.msg["text"] = self drawText("^5Welcome To Alexibuscus Menu Base \n Your Status: "+self.status, "Objective", 2.5, 0, 0, (1,1,1), 0, (0,0,0), 0, 3);
	self.msg["text"].glowColor = ((randomint(255)/255,randomint(255)/255,randomint(255)/255));
	self thread welcomeFlash();
	self.msg["text"].alpha = 1;
	self.msg["text"].glowAlpha = 1;
	self.msg["text"] setTypewriterFX(50,99999,99999);
	wait 13;
	self.msg["text"] destroy();
	self notify("endflashwm");
}


welcomeFlash()
{
self endon("endflashwm");
	for(;;)
	{
		self.msg["text"].glowColor = ((randomint(255)/255,randomint(255)/255,randomint(255)/255));
		wait 0.3;
	}
}









