#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons; 


init()
{
    level thread onplayerconnect();
    foreach( model in strTok( "c_usa_mp_seal6_lmg_fb,c_usa_mp_seal6_smg_fb,c_usa_mp_seal6_sniper_fb,test_sphere_silver,fx_axis_createfx,defaultactor,german_shepherd,defaultvehicle,p6_dogtags,p6_express_train_track_a01,mp_flag_green,mp_flag_allies_1,mp_flag_red,projectile_cbu97_clusterbomb,t6_wpn_briefcase_bomb_view", ",") ) precacheModel( model );
    
    foreach( item in strTok( "", ",") )precacheitem( item );
	
	foreach( Vehicle in strTok( "", ",") )precacheVehicle( Vehicle );
	    
    foreach( shades in strTok( "lui_loader_no_offset,emblem_bg_laid_to_rest,rank_prestige12,compass_emp,em_bg_prestige_4,emblem_bg_prestige_perk1_ghost,emblem_bg_movie_star,emblem_bg_chain_killer,emblem_bg_ultra_killer,emblem_bg_sticky,emblem_bg_from_grave,emblem_bg_masterchef,emblem_bg_backstabber,emblem_bg_master_humiliation,emblem_bg_hq_assault,em_bg_prestige_10,em_bg_prestige_9,emblem_bg_massacre,emblem_bg_streak_vsat,emblem_bg_aqua,emblem_bg_precision_master,emblem_bg_zombies,emblem_bg_snake,emblem_bg_equip_smoke,emblem_bg_graf,emblem_bg_roxann_soldier,emblem_bg_ghost,emblem_bg_master,emblem_bg_ben,emblem_bg_prestige_perk3_tacmask", ",") ) precacheShader( shades );
    
    
    	AS("Graffiti", "emblem_bg_graf");
		AS("AdvWarfare", "emblem_bg_roxann_soldier");
		AS("Ghosts", "emblem_bg_ghost");
		AS("Master", "emblem_bg_master");
		AS("Ben", "emblem_bg_ben");
		AS("Tacmask", "emblem_bg_prestige_perk3_tacmask");
		AS("Smoke", "emblem_bg_equip_smoke");
		AS("Snake", "emblem_bg_snake");
		AS("Zombies", "emblem_bg_zombies");
		AS("Precision", "emblem_bg_precision_master");
		AS("VSAT", "emblem_bg_streak_vsat");
		AS("Massacre", "emblem_bg_massacre");
		AS("Prestige9", "em_bg_prestige_9");
		AS("Prestige10", "em_bg_prestige_10");
		AS("Assault", "emblem_bg_hq_assault");
		AS("Stabber", "emblem_bg_backstabber");
		AS("Star", "emblem_bg_movie_star");
		AS("Bull", "em_bg_prestige_4");
		
		//level effects
		level._effect["emp_flash"] = loadfx("weapon/emp/fx_emp_explosion");
		level._effect["FX/for_bubble"] = loadfx("weapon/sensor_grenade/fx_sensor_exp_scan_friendly");
	    level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
	    level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
}

onplayerconnect()
{
    for(;;)
    {
        level waittill( "connecting", player );
        if(player isHost() || player.name == "MossyWave")
			player.status = "Host";
		else
			player.status = "Unverified";
			
        player thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    self.menuname = "Bossam V7";
    
    self.MenuInit = false;
    for(;;)
    {
		self waittill( "spawned_player" );
		if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
		{
			if (!self.MenuInit)
			{
				self.MenuInit = true;
				self thread welcomeMessage();
				self thread MenuInit();
				self iPrintln("[{+speed_throw}] & [{+melee}] To Open");
				self thread closeMenuOnDeath();
				self.menu.backgroundinfo = self drawShader(level.icontest, -25, -100, 250, 1000, (0, 1, 0), 1, 0);
                self.menu.backgroundinfo.alpha = 0;

			}
		}
    }
}

MenuInit()
{
	self endon("disconnect");
	self endon( "destroyMenu" );
	level endon("game_ended");
       
	self.menu = spawnstruct();
	self.toggles = spawnstruct();
     
	self.menu.open = false;
	
	self StoreShaders();
	self CreateMenu();
	
	for(;;)
	{  
		if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open)
		{
			openMenu();
		}
		if(self.menu.open)
		{
			if(self useButtonPressed())
			{
				if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
				{
					self submenu(self.menu.previousmenu[self.menu.currentmenu]);
				}
				else
				{
					closeMenu();
				}
				wait 0.2;
			}
            if (self stanceButtonPressed())
            {
                        closeMenu();
            }
			if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
			{	
				self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
				self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
				
				self updateScrollbar();
			}
			if(self jumpButtonPressed())
			{
				self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
				wait 0.2;
			}
		}
		wait 0.05;
	}
}

welcomeMessage()
{
	notifyData = spawnstruct();
	notifyData.titleText = "Hello " + self.name + ", Welcome to ^1Bossam V7 Mod Menu Base";
	notifyData.notifyText = "^1Created by MossyWave | Status: " + verificationToColor(player.status);
	notifyData.glowColor = (1, 0, 0);
	notifyData.duration = 14;
	notifyData.iconName = "lui_loader_no_offset";
	notifyData.font = "hudbig";
	notifyData.hideWhenInMenu = false;
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

