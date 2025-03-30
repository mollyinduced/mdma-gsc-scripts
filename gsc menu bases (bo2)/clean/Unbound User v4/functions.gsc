
godmode()
{
	self.godmode = booleanOpposite(self.godmode);
	if (self.godmode)
	{
		self iprintln("GodMode: ^2ON");
		self EnableInvulnerability();
	}
	else
	{
		self iprintln("GodMode: ^1OFF");
		self DisableInvulnerability();
	}
}

infammo()
{
	self.infammo = booleanOpposite(self.infammo);
	if (self.infammo)
	{
		self iprintln("Infinite Ammo: ^2ON");
		self thread doAmmo();
	}
	else
	{
		self iprintln("Infinite Ammo: ^1OFF");
		self notify("stop_ammo");
	}
}

doAmmo()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("stop_ammo");
    for(;;)
    {
        wait 0.1;

        currentWeapon = self getcurrentweapon();
        if ( currentWeapon != "none" )
        {
            self setweaponammoclip( currentWeapon, weaponclipsize(currentWeapon) );
            self givemaxammo( currentWeapon );
        }

        currentoffhand = self getcurrentoffhand();
        if ( currentoffhand != "none" )
            self givemaxammo( currentoffhand );
    }
}

testvar()
{
	self.testvar = booleanOpposite(self.testvar);
}

dofov()
{
	self.fov = booleanOpposite(self.fov);
	if (self.fov)
		self setclientfov(90);
	else
		self setclientfov(60);
}

freezeallplayers()
{
	foreach(player in level.players)
	{
		if(player isHost() == false)
		{
				player iPrintln("^1Freeze Motherfucker");
				player freezecontrols(true);
		}
	}
}

unfreezeallplayers()
{
	foreach(player in level.players)
	{
		if(player isHost() == false)
		{
				player iPrintln("^2Carry on");
				player freezecontrols(false);
		}
	}
}

giveallxp()
{
	foreach(player in level.players)
	{
		if (player isHost() == false)
		{
			if (!player.ranked)
			{
				player addrankxpvalue("contract", 60000);
				player iPrintlnbold("^1XP ^2Given");
				player.ranked = true;
			}
		}
	}
}

givexp()
{
	if (!self.ranked)
	{
		self addrankxpvalue("contract", 60000);
		self iPrintlnbold("^1XP ^2Given");
		self.ranked = true;
	}
	else
		self iprintln("^1You can only give yourself 60,000 MAX XP per game!");
}

forceHost()
{
	self.forcehost = booleanOpposite(self.forcehost);
	if(self.forcehost)
	{
		setDvar("party_connectToOthers" , "0");
		setDvar("partyMigrate_disabled" , "1");
		setDvar("party_mergingEnabled" , "0");
		self iPrintln("Force Host: ^2ON");
	}
	else
	{
		setDvar("party_connectToOthers" , "1");
		setDvar("partyMigrate_disabled" , "0");
		setDvar("party_mergingEnabled" , "1");
		self iPrintln("Force Host: ^1OFF");
	}
}

antijoin()
{
	self endon("disconnect");
	self endon("stop_antijoin");
	
	level.antijoin = booleanOpposite(level.antijoin);
	if (level.antijoin)
		self iprintln("Anti Join: ^2ON");
	else
		self iprintln("Anti Join: ^1OFF");
}

unlimtime()
{
	level.unlimtime = booleanOpposite(level.unlimtime);
	if (level.unlimtime)
	{
		maps\mp\gametypes\_globallogic_utils::pausetimer();
    	self iPrintln("Unlimited Time: ^2ON");
	}
	else
	{
		maps\mp\gametypes\_globallogic_utils::resumetimer();
    	self iPrintln("Unlimited Time: ^1OFF");
	}
}

hostonlyjump()
{
	self.hostonlyjump = booleanOpposite(self.hostonlyjump);
}

autodropshot()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_drop");
	
	self.dropshot = booleanOpposite(self.dropshot);
	if (self.dropshot)
	{
		self iprintln("Auto Drop Shot: ^2ON");
		for(;;)
		{
			self waittill ("weapon_fired");
			self setStance("prone");
		}
	}
	else
	{
		self iprintln("Auto Drop Shot: ^1OFF");
		self notify("stop_drop");
	}
}

ToggleTimeScale(type)
{
	level.timescale = booleanOpposite(level.timescale);
    if(level.timescale)
    {
    	if (type == "slow")
    		setDvar("timescale", "0.5");
    	else if (type == "fast")
    		setDvar("timescale", "2");
    		
        self iPrintln("Timescale: ^2ON");
    }
    else
    {
        setDvar("timescale", "1");
        self iPrintln("Slow/Fast Timescale: ^1OFF");
    }
}

doTeamChange()
{
	if (self.pers["team"] == "axis")
		self changeteam("allies");
	else if (self.pers["team"] == "allies")
		self changeteam("axis");
}

ChangeClass()
{
	self endon("disconnect");
	self endon("death");
	
	self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
	for(;;)
	{
		if(self.pers[ "changed_class" ])
			self maps/mp/gametypes/_class::giveloadout( self.team, self.class );
		wait 0.05;
	}
}

toggleAntiQuit()
{
	level.antiquit = booleanOpposite(level.antiquit);
    if(level.antiquit)
    {
        foreach(player in level.players)
        {
           player thread doAntiQuit();
        }
        self iPrintln("Anti Quit: ^2ON");
    }
    else
    {
        foreach(player in level.players)
        {
            player notify("EndAntiQuit");
        }
        self iPrintln("Anti Quit: ^1OFF");
    }
}

doAntiQuit()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("EndAntiQuit");
	
	for(;;)
	{
		self maps/mp/gametypes/_globallogic_ui::closemenus();
		wait 0.05;
	}
}

superspeed()
{
	level.speed = booleanOpposite(level.speed);
	if (level.speed)
	{
		self iPrintln("Super Speed: ^2ON");
		setDvar("g_speed", "500");
	}
 	else
 	{
	 	self iPrintln("Super Speed: ^1OFF");
	 	setDvar("g_speed", "200");
 	}
}

superjump()
{
	level.jump = booleanOpposite(level.jump);
	if(level.jump)
    {
    	self iprintln("Super Jump: ^2ON");
        for(i = 0; i < level.players.size; i++)
        	level.players[i] thread SuperJumpEnable();
    }
    else
    {
    	self iprintln("Super Jump: ^1OFF");
        for(x = 0; x < level.players.size; x++)
        	level.players[x] notify("StopJump");
    }
}

SuperJumpEnable()
{
	level endon("game_ended");
    self endon("disconnect");
    self endon("StopJump");
    for(;;)
    {
        if(self JumpButtonPressed() && !isDefined(self.allowedtopress))
        {
        	if (level.players[0].hostonlyjump == false)
        	{
	            for(i = 0; i < 20; i++)
	            {
	                self.allowedtopress = false;
	                self setVelocity(self getVelocity()+(0, 0, 999));
	                wait 0.05;
	            }
	          	self.allowedtopress = undefined;
           }
           else
           {
           		if (self isHost())
           		{
           			for(i = 0; i < 20; i++)
		            {
		                self.allowedtopress = false;
		                self setVelocity(self getVelocity()+(0, 0, 999));
		                wait 0.05;
		            }
		          	self.allowedtopress = undefined;
           		}
           }
        }
        wait 0.05;
    }
}

dofalldamage()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_falldamage");
	
	level.falldamage = booleanOpposite(level.falldamage);
	if (level.falldamage)
	{
		self iprintln("No Fall Damage: ^2ON");
		
		for(;;)
		{
			foreach(player in level.players)
				player setperk("specialty_fallheight");
				
			wait 0.05;
		}
	}
	else
	{
		self iprintln("No Fall Damage: ^1OFF");
		
		foreach(player in level.players)
			player unsetperk("specialty_fallheight");
			
		self notify("stop_falldamage");
	}
}

toggleUAV()
{
	self.uav = booleanOpposite(self.uav);
	if (self.uav)
	{
		self iPrintln("UAV: ^2ON");
		self setclientuivisibilityflag("g_compassShowEnemies",1);
	}
	else
	{
		self iPrintln("UAV: ^1OFF");
		self setclientuivisibilityflag("g_compassShowEnemies",0);
	}
}

meleerange()
{
	level.melee = booleanOpposite(level.melee);
	if(level.melee)
	{
		setDvar("player_meleeRange", "999");
		self iPrintln("Super Melee: ^2ON");
	}
	else
	{
		setDvar("player_meleeRange", "1");
		self iPrintln("Super Melee: ^1OFF");
	}
}

toggleWallhack()
{
	self.wallhack = booleanOpposite(self.wallhack);
	if (self.wallhack)
	{
		self iprintln("Wallhack: ^2ON");
		self thread enableESP();
	}
	else
	{
		self iprintln("Wallhack: ^1OFF");
		self thread disableESP();
	}
}

enableESP()
{
    self thread getTargets();
}
 
disableESP()
{
    self notify("esp_end");
    for(i=0;i<self.esp.targets.size;i++)
    {
    	if (isDefined(esp.targets[i]))
    		self.esp.targets[i].hudbox destroy();
    }
}
 
getTargets()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("esp_end");
	
    for(;;)
    {
        self.esp = spawnStruct();
        self.esp.targets = [];
        a = 0;
        for(i=0; i<level.players.size; i++)
        {
            if(self != level.players[i])
            {
                self.esp.targets[a] = spawnStruct();
                self.esp.targets[a].player = level.players[i];
                self.esp.targets[a].hudbox = self createBox(self.esp.targets[a].player.origin,1);
                self thread monitorTarget( self.esp.targets[a] );
                a++;
            }
        }
        level waittill("connected", player );
        self notify("esp_target_update");
    }
}
 
monitorTarget(target)
{
	self endon("disconnect");
	level endon("game_ended");
    self endon("esp_target_update");
    self endon("esp_end");
    
    for(;;)
    {
        target.hudbox destroy();
        h_pos = target.player.origin;
        t_pos = target.player.origin;
        
        if(bulletTracePassed(self getTagOrigin("j_spine4"), target.player getTagOrigin("j_spine4"), false, self))
        {
                if(distance(self.origin,target.player.origin)<=1800)
                {
                      if(level.teamBased && target.player.pers["team"] != self.pers["team"])
                      {
	                  	  target.hudbox = self createBox(h_pos, 900);
	                  	  
	                  	  if (isDefined(target.hudbox))
	                      	target.hudbox.color = (0,1,0);
                      }
                      if(!level.teamBased)
                      {
                         	target.hudbox = self createBox(h_pos, 900);
                    
                        	if (isDefined(target.hudbox))
                        		target.hudbox.color = (0,1,0); 
                	  }
               }
                else
                        target.hudbox = self createBox(t_pos,900);
        }
        else
                target.hudbox = self createBox(t_pos,100);
       
        if(!isAlive(target.player))
        {
        		if (isDefined(target.hudbox))
                	target.hudbox destroy();
                	
                if(level.teamBased && target.player.pers["team"] != self.pers["team"])
                {
                       target.hudbox = self createBox(t_pos, 900);
                       
                       if (isDefined(target.hudbox))
                       		target.hudbox setShader(level.deads, 6, 6);
                }
               else if(!level.teamBased)
               {
               	target.hudbox = self createBox(t_pos, 900);
               	
               	if (isDefined(target.hudbox))
                	target.hudbox setShader(level.deads, 6, 6);
               }
        }
       
       if(self.pers["team"] == target.player.pers["team"] && level.teamBased)
       {
       			if (isDefined(target.hudbox))
               		target.hudbox destroy();
               		
               if(distance(target.player.origin,self.origin) < 3)
                       target.hudbox = self createBox(t_pos, 900);

       }
       
        wait 0.01;
	}
}
 
createBox(pos,type)
{
    shader = newClientHudElem( self );
    shader.sort = 0;
    shader.archived = false;
    shader.x = pos[0];
    shader.y = pos[1];
    shader.z = pos[2] + 30;
    shader setShader(level.esps, 6, 6);
    shader setWaypoint(true,true);
    shader.alpha = 0.80;
    shader.color = (1,0,0);
    return shader;
}

ShowFPS()
{
	self.fps = booleanOpposite(self.fps);
	if(self.fps)
	{
		self iPrintln("FPS ^2ON");
		setDvar("cg_drawFPS","1");
		setDvar("cg_drawBigFPS","1");
	}
	else
	{
		self iPrintln("FPS ^1OFF");
		setDvar("cg_drawFPS","0");
		setDvar("cg_drawBigFPS","0");
	}
}

hearallplayers()
{
	 level.chat = booleanOpposite(level.chat);
	 if(level.chat)
	 {
		  setmatchtalkflag("EveryoneHearsEveryone",1);
		  iPrintln("Hear All Clients ^2ON");
	 }
	 else
	 {
		  setmatchtalkflag("EveryoneHearsEveryone",0);
		  iPrintln("Hear All Clients ^1OFF");
	 }
}

setmartyrdom(type)
{
	if (type != "")
		self iprintln(type + " ^2set as martyrdom type!");
	else
		self iprintln("Martyrdom ^1disabled!");
		
	self.martyrdom = type;
}

martyrdom()
{
	if (isDefined(self.martyrdom) && self.martyrdom != "")
	{
		//martyrload = LoadFx(self.martyrdom);
		//RadiusDamage(self.origin, 500, 120, 60, self);
		//martyr = PlayFX(martyrload, self.origin);
		//self playsound("wpn_rocket_explode");
		
		
		martyrdom = MagicBullet(self.martyrdom, self.origin, self.origin + (0, 0, 1), self);
	}
}

clearperks_self()
{
	self clearperks();
	self iprintln("Perks ^1Cleared!");
}

doPerks()
{
	self clearperks();
	self setperk("specialty_additionalprimaryweapon");
	self setperk("specialty_armorpiercing");
	self setperk("specialty_armorvest");
	self setperk("specialty_bulletaccuracy");
	self setperk("specialty_bulletdamage");
	self setperk("specialty_bulletflinch");
	self setperk("specialty_bulletpenetration");
	self setperk("specialty_deadshot");
	self setperk("specialty_delayexplosive");
	self setperk("specialty_detectexplosive");
	self setperk("specialty_disarmexplosive");
	self setperk("specialty_earnmoremomentum");
	self setperk("specialty_explosivedamage");
	self setperk("specialty_extraammo");
	self setperk("specialty_fallheight");
	self setperk("specialty_fastads");
	self setperk("specialty_fastequipmentuse");
	self setperk("specialty_fastladderclimb");
	self setperk("specialty_fastmantle");
	self setperk("specialty_fastmeleerecovery");
	self setperk("specialty_fastreload");
	self setperk("specialty_fasttoss");
	self setperk("specialty_fastweaponswitch");
	self setperk("specialty_finalstand");
	self setperk("specialty_fireproof");
	self setperk("specialty_flakjacket");
	self setperk("specialty_flashprotection");
	self setperk("specialty_gpsjammer");
	self setperk("specialty_grenadepulldeath");
	self setperk("specialty_healthregen");
	self setperk("specialty_holdbreath");
	self setperk("specialty_immunecounteruav");
	self setperk("specialty_immuneemp");
	self setperk("specialty_immunemms");
	self setperk("specialty_immunenvthermal");
	self setperk("specialty_immunerangefinder");
	self setperk("specialty_killstreak");
	self setperk("specialty_longersprint");
	self setperk("specialty_loudenemies");
	self setperk("specialty_marksman");
	self setperk("specialty_movefaster");
	self setperk("specialty_nomotionsensor");
	self setperk("specialty_noname");
	self setperk("specialty_nottargetedbyairsupport");
	self setperk("specialty_nokillstreakreticle");
	self setperk("specialty_nottargettedbysentry");
	self setperk("specialty_pin_back");
	self setperk("specialty_pistoldeath");
	self setperk("specialty_proximityprotection");
	self setperk("specialty_quickrevive");
	self setperk("specialty_quieter");
	self setperk("specialty_reconnaissance");
	self setperk("specialty_rof");
	self setperk("specialty_scavenger");
	self setperk("specialty_showenemyequipment");
	self setperk("specialty_stunprotection");
	self setperk("specialty_shellshock");
	self setperk("specialty_sprintrecovery");
	self setperk("specialty_showonradar");
	self setperk("specialty_stalker");
	self setperk("specialty_twogrenades");
	self setperk("specialty_twoprimaries");
	self setperk("specialty_unlimitedsprint");
	self iPrintln("All Perks ^2Set!");
}

explobullets()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_explo");
	self.explobullets = booleanOpposite(self.explobullets);
	if (self.explobullets)
	{
		self iprintln("Explosive Bullets: ^2ON");
		level.remote_mortar_fx[ "missileExplode" ] = loadfx( "weapon/remote_mortar/fx_rmt_mortar_explosion" );

		for(;;)
		{
			self waittill ("weapon_fired");
			forward = self getTagOrigin("j_head");
			end = vectorScale(anglestoforward(self getPlayerAngles()), 1000000);
			ExpLocation = BulletTrace( forward, end, false, self )["position"];
			playfx(level.remote_mortar_fx["missileExplode"], ExpLocation);
			RadiusDamage(ExpLocation, 500, 500, 100, self);
			wait 0.05;
		}
	}
	else
	{
		self iprintln("Explosive Bullets: ^1OFF");
		self notify("stop_explo");
	}
}

GiveKillstreak(killstreak)
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak(maps/mp/killstreaks/_killstreaks::getkillstreakbymenuname( killstreak ) , 5594, true, 5594);
}
GiveUAV()
{
    self GiveKillstreak("killstreak_spyplane");
    self iPrintln("UAV Given");
}
GiveRC()
{
    self GiveKillstreak("killstreak_rcbomb");
    self iPrintln("RC-XD Given");
}
GiveHunt()
{
    self giveWeapon( "missile_drone_mp" );
    self switchToWeapon( "missile_drone_mp" );
    self iPrintln("Hunter Killer Drone Given");
}
GiveCare()
{
    self giveWeapon( "supplydrop_mp" );
    self switchToWeapon( "supplydrop_mp" );
    self iPrintln("Care Package Given");
}
GiveCUAV()
{
    self GiveKillstreak("killstreak_counteruav");
    self iPrintln("Counter UAV Given");
}
GiveGuard()
{
    self GiveWeapon("microwaveturret_mp");
    self switchToWeapon( "microwaveturret_mp" );
    self iPrintln("Gaurdian Given");
}
GiveHell()
{
    self GiveKillstreak("killstreak_remote_missile");
    self iPrintln("Hellstorm Missle Given");
}
GiveLS()
{
    self GiveKillstreak("killstreak_planemortar");
    self iPrintln("Lightning Strike Given");
}
GiveSG()
{
    self GiveWeapon("autoturret_mp");
    self switchToWeapon( "autoturret_mp" );
    self iPrintln("Sentry Gun Given");
}
GiveAG()
{
    self giveWeapon( "ai_tank_drop_mp" );
    self switchToWeapon( "ai_tank_drop_mp" );
    self iPrintln("A.G.R Given");
}
GiveSC()
{
    self GiveKillstreak("killstreak_helicopter_comlink");
    self iPrintln("Stealth Chopper Given");
}
GiveVSAT()
{
    self GiveKillstreak("killstreak_spyplane_direction");
    self iPrintln("Orbital VSAT Given");
}
GiveED()
{
    self GiveKillstreak("killstreak_helicopter_guard");
    self iPrintln("Escort Drone Given");
}
GiveEMP()
{
    self giveWeapon( "emp_mp" );
    self switchToWeapon( "emp_mp" );
    self iPrintln("EMP System Given");
}
GiveWH()
{
    self GiveKillstreak("killstreak_straferun");
    self iPrintln("Warthog Given");
}
GiveLST()
{
    self GiveKillstreak("killstreak_remote_mortar");
    self iPrintln("Lodestar Given");
}
GiveVW()
{
    self giveWeapon( "helicopter_player_gunner_mp" );
    self switchToWeapon( "helicopter_player_gunner_mp" );
    self iPrintln("VTOL Warship Given");
}
GiveDogs()
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak("dogs_mp", 5594, true, 5594);
    self iPrintln("Dogs Given");
}

GiveSwarm()
{
    self GiveKillstreak("killstreak_missile_swarm");
    self iPrintln("Swarm Given");
}

SpawnBots(numtospawn)
{
	for(i = 0; i < numtospawn; i++)
    	maps/mp/bots/_bot::spawn_bot();
    
    self iprintln("Bot(s) spawned!");
}

KickBots()
{
	foreach(player in level.players)
	{
		if(isDefined(player.pers["isBot"]) && player.pers["isBot"])
			kickclientent(player);
	}
	
	self iprintln("Bot(s) kicked!");
}

stalkerMode()
{
	self endon("death");
	self endon("disconnect");
	self endon("stopstalkerMode");
	
	self.stalkerMode = booleanOpposite(self.stalkerMode);
	if(self.stalkerMode)
	{
		self iprintln("Stalker Pro Mode: ^2ON");
		self iprintln("Aim and walk");
		
		for(;;)
		{
			if(self adsButtonpressed())
			{
				self SetMoveSpeedScale(4);
			}
			else
				self SetMoveSpeedScale(1);
			wait 0.01;
		}
	}
	else
	{
		self iprintln("Stalker Pro Mode: ^1OFF");
		self SetMoveSpeedScale(1);
		self notify("stopstalkerMode");
	}
}

domessage(message)
{
	foreach(player in level.players)
	{
		player thread maps\mp\gametypes\_hud_message::hintMessage(message, 6);
	}
}

changemap(mapname)
{
	self endon("dpad_left");
	for (i = 4; i > 0; i--)
	{
		self iPrintln("Changing map in " + i + " second(s)! Press [{+actionslot 3}] + prone to cancel!");
		wait 1;
	}
	self iprintln("Map changing to " + mapname);
	wait 1;
	map(mapname);
}

restart(type)
{
	//map_restart(false);
}

endgame()
{
	self endon("dpad_left");
	for (i = 4; i > 0; i--)
	{
		self iPrintln("Ending the game in " + i + " second(s)! Press [{+actionslot 3}] + prone to cancel!");
		wait 1;
	}
	level thread maps/mp/gametypes/_globallogic::forceend();
}

UnlockCamos()
{
	self camonlock();
	self thread maps\mp\gametypes\_hud_message::hintMessage("^2Weapon Camos Unlocked!", 5);
}

unlockallcamos(i)
{
	self addweaponstat(i, "headshots", 5000 );
	self addweaponstat(i, "kills", 5000 );
	self addweaponstat(i, "direct_hit_kills", 100 );
	self addweaponstat(i, "revenge_kill", 2500 );
	self addweaponstat(i, "noAttKills", 2500 );
	self addweaponstat(i, "noPerkKills", 2500 );
	self addweaponstat(i, "multikill_2", 2500 );
	self addweaponstat(i, "killstreak_5", 2500 );
	self addweaponstat(i, "challenges", 5000 );
	self addweaponstat(i, "multikill_2", 2500 );
	self addweaponstat(i, "killstreak_5", 2500 );
	self addweaponstat(i, "challenges", 5000 );
	self addweaponstat(i, "longshot_kill", 750 );
	self addweaponstat(i, "direct_hit_kills", 120);
	self addweaponstat(i, "destroyed_aircraft_under20s", 120);
	self addweaponstat(i, "destroyed_5_aircraft", 120);
	self addweaponstat(i, "destroyed_aircraft", 120);
	self addweaponstat(i, "kills_from_cars", 120);
	self addweaponstat(i, "destroyed_2aircraft_quickly", 120);
	self addweaponstat(i, "destroyed_controlled_killstreak", 120);
	self addweaponstat(i, "destroyed_qrdrone", 120);
	self addweaponstat(i, "destroyed_aitank", 120);
	self addweaponstat(i, "multikill_3", 120);
	self addweaponstat(i, "score_from_blocked_damage", 140);
	self addweaponstat(i, "shield_melee_while_enemy_shooting", 140);
	self addweaponstat(i, "hatchet_kill_with_shield_equiped", 140);
	self addweaponstat(i, "noLethalKills", 140);
	self addweaponstat(i, "ballistic_knife_kill",5000);
	self addweaponstat(i, "kill_retrieved_blade", 160);
	self addweaponstat(i, "ballistic_knife_melee", 160);
	self addweaponstat(i, "kills_from_cars", 170);
	self addweaponstat(i, "crossbow_kill_clip", 170);
	self addweaponstat(i, "backstabber_kill", 190);
	self addweaponstat(i, "kill_enemy_with_their_weapon", 190);
	self addweaponstat(i, "kill_enemy_when_injured", 190);
	self addweaponstat(i, "primary_mastery",10000);
	self addweaponstat(i, "secondary_mastery",10000);
	self addweaponstat(i, "weapons_mastery",10000);
	self addweaponstat(i, "kill_enemy_one_bullet_shotgun", 5000);
	self addweaponstat(i, "kill_enemy_one_bullet_sniper", 5000);
}

camonlock()
{
	self endon("disconnect");
	
	self thread unlockallcamos("870mcs_mp");
	self thread unlockallcamos("an94_mp");
	self thread unlockallcamos("as50_mp");
	self thread unlockallcamos("ballista_mp");
	self thread unlockallcamos("beretta93r_dw_mp");
	self thread unlockallcamos("beretta93r_lh_mp");
	self thread unlockallcamos("beretta93r_mp");
	self thread unlockallcamos("crossbow_mp");
	self thread unlockallcamos("dsr50_mp");
	self thread unlockallcamos("evoskorpion_mp");
	self thread unlockallcamos("fiveseven_dw_mp");
	self thread unlockallcamos("fiveseven_lh_mp");
	self thread unlockallcamos("fiveseven_mp");
	self thread unlockallcamos("fhj18_mp");
	self thread unlockallcamos("fnp45_dw_mp");
	self thread unlockallcamos("fnp45_lh_mp");
	self thread unlockallcamos("fnp45_mp");
	self thread unlockallcamos("hamr_mp");
	self thread unlockallcamos("hk416_mp");
	self thread unlockallcamos("insas_mp");
	self thread unlockallcamos("judge_dw_mp");
	self thread unlockallcamos("judge_lh_mp");
	self thread unlockallcamos("judge_mp");
	self thread unlockallcamos("kard_dw_mp");
	self thread unlockallcamos("kard_lh_mp");
	self thread unlockallcamos("kard_mp");
	self thread unlockallcamos("kard_wager_mp");
	self thread unlockallcamos("knife_ballistic_mp");
	self thread unlockallcamos("knife_held_mp");
	self thread unlockallcamos("knife_mp");
	self thread unlockallcamos("ksg_mp");
	self thread unlockallcamos("lsat_mp");
	self thread unlockallcamos("mk48_mp");
	self thread unlockallcamos("mp7_mp");
	self thread unlockallcamos("pdw57_mp");
	self thread unlockallcamos("peacekeeper_mp");
	self thread unlockallcamos("qbb95_mp");
	self thread unlockallcamos("qcw05_mp");
	self thread unlockallcamos("riotshield_mp");
	self thread unlockallcamos("sa58_mp");
	self thread unlockallcamos("saiga12_mp");
	self thread unlockallcamos("saritch_mp");
	self thread unlockallcamos("scar_mp");
	self thread unlockallcamos("sig556_mp");
	self thread unlockallcamos("smaw_mp");
	self thread unlockallcamos("srm1216_mp");
	self thread unlockallcamos("svu_mp");
	self thread unlockallcamos("tar21_mp");
	self thread unlockallcamos("type95_mp");
	self thread unlockallcamos("usrpg_mp");
	self thread unlockallcamos("vector_mp");
	self thread unlockallcamos("xm8_mp");
}

verifyplayer(playername)
{
	foreach(player in level.players)
	{
		if (getPlayerName(player) == playername)
		{
			player notify("stop_ammo");
			player thread explobullets();
			player thread doAmmo();
			player iprintln("You've been ^2verified! ^7Enjoy unlimited ammo and explosive bullets");
		}
	}
}

PlantBomb()
{
	if(getDvar("g_gametype")=="sd")
	{
		if ( !level.bombplanted )
		{
			level thread maps/mp/gametypes/sd::bombplanted(level.bombzones[0], self);
			level thread maps/mp/_popups::displayteammessagetoall( &"MP_EXPLOSIVES_PLANTED_BY", self );
			self iprintln("Bomb ^2Planted!");
		}
		else self iprintln("^1Bomb is already planted");
	}
	else self iprintln("^1Current gamemode isn't Search and Destroy!");
}
DefuseBomb()
{
	if(getDvar("g_gametype")=="sd")
	{
		if ( level.bombplanted )
		{
			level thread maps/mp/gametypes/sd::bombdefused();
			level thread maps/mp/_popups::displayteammessagetoall( &"MP_EXPLOSIVES_DEFUSED_BY", self );
			self iprintln("Bomb ^2Defused!");
		}
		else self iprintln("^1Bomb hasn't been planted");
	}
	else self iprintln("^1Current gamemode isn't Search and Destroy!");
}

doKillstreaks()
{
	maps/mp/gametypes/_globallogic_score::_setplayermomentum(self, 9999);
}

dosuicide()
{
	self suicide();
}

ThirdPerson()
{
	self.thirdperson = booleanOpposite(self.thirdperson);
	if (self.thirdperson)
    {
        self setclientthirdperson(1);
        self iPrintln("Third Person: ^2ON");
    }
    else
    {
        self setclientthirdperson(0);
        self iPrintln("Third Person: ^1OFF");
    }
}

toggleStealthAimAssist()
{
	self.stealthaimassist = booleanOpposite(self.stealthaimassist);
	if (self.stealthaimassist)
	{
		self iprintln("Stealth Aim Assist: ^2ON");
		self notify("stop_knifebot");
		self notify("stop_aimassist");
		self thread autoAim();
	}
	else
	{
		self iprintln("Stealth Aim Assist: ^1OFF");
		self notify("stop_stealthaimassist");
	}
}

autoAim()
{
	self endon("death");
	self endon("disconnect");
	self endon("stop_stealthaimassist");
	lo=-1;
	self.fire=0;
	self thread WSh();
	//self iPrintln("^2Aimbot ON");
	self.ABo="j_mainroot";
	for(;;)
	{
		wait 0.05;
		if(self AdsButtonPressed())
		{
			for(i=0;i<level.players.size;i++)
			{
				if(getdvar("g_gametype")!="dm")
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin(self.ABo),0,self)) lo=level.players[i] gettagorigin(self.ABo);
					else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin(self.ABo),0,self)) lo=level.players[i] gettagorigin("j_ankle_ri");
				}
				else
				{
					if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin(self.ABo),0,self)) lo=level.players[i] gettagorigin(self.ABo);
					else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin(self.ABo),0,self)) lo=level.players[i] gettagorigin("j_ankle_ri");
				}
			}
			if(lo!=-1) self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_head"))));
			if(self.fire==1) MagicBullet(self getcurrentweapon(),lo+(0,0,5),lo,self);
		}
		lo=-1;
	}
}
WSh()
{
	self endon("death");
	self endon("stop_stealthaimassist");
	for(;;)
	{
		self waittill("weapon_fired");
		self.fire=1;
		wait 0.05;
		self.fire=0;
	}
}

toggleAimAssist()
{
	self.aimassist = booleanOpposite(self.aimassist);
	if (self.aimassist)
	{
		self iprintln("Unfair Aim Assist: ^2ON");
		self notify("stop_knifebot");
		self notify("stop_stealthaimassist");
		self thread aimBot();
	}
	else
	{
		self iprintln("Unfair Aim Assist: ^1OFF");
		self notify("stop_aimassist");
	}
}

aimBot()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_aimassist");
	
	for(;;)
	{
		aimAt = undefined;
		foreach(player in level.players)
		{
			if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
				continue;
			if(isDefined(aimAt))
			{
				if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
					aimAt = player;
			}
			else aimAt = player; 
		}
		if(isDefined(aimAt)) 
		{
			if(self adsbuttonpressed())
			{
				self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head")))); 
				if(self attackbuttonpressed())
					aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getCurrentWeapon(), (0,0,0), (0,0,0), "head", 0, 0 );
			}
		}
		wait 0.01;
	}
}

toggleKnifebot()
{
	self.knifebot = booleanOpposite(self.knifebot);
	if (self.knifebot)
	{
		self iprintln("Knifebot: ^2ON");
		self notify("stop_stealthaimassist");
		self notify("stop_aimassist");
		self thread knifeBot();
	}
	else
	{
		self iprintln("Knifebot: ^1OFF");
		self notify("stop_knifebot");
	}
}

knifeBot()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_knifebot");
	
	for(;;)
	{
		aimAt = undefined;
		foreach(player in level.players)
		{
			if((player == self) || (!isAlive(player)) || (level.teamBased && self.pers["team"] == player.pers["team"]))
				continue;
			if(isDefined(aimAt))
			{
				if(closer(self getTagOrigin("j_head"), player getTagOrigin("j_head"), aimAt getTagOrigin("j_head")))
					aimAt = player;
			}
			else aimAt = player; 
		}
		if(isDefined(aimAt)) 
		{
			if(self meleebuttonpressed())
			{
				self setplayerangles(VectorToAngles((aimAt getTagOrigin("j_head")) - (self getTagOrigin("j_head")))); 
				//if(self attackbuttonpressed())
					aimAt thread [[level.callbackPlayerDamage]]( self, self, 100, 0, "MOD_MELEE", "knife_mp", (0,0,0), (0,0,0), "head", 0, 0 );
			}
		}
		wait 0.02;
	}
}

kickclient(num)
{
	kick(level.players[num] getEntityNumber());
}

kickclientent(player)
{
	kick(player getEntityNumber());
}

//visions

emp()
{
	self.emp = booleanOpposite(self.emp);
    if(self.emp)
    {
        self setempjammed(1);
        self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
        self iPrintln("EMP Vision: ^2ON");
    }
    else
    {
        self setempjammed(0);
        self iPrintln("EMP Vision: ^1OFF");
    }
}
EV()
{
    self.ev = booleanOpposite(self.ev);
    if(self.ev)
    {
        self useServerVisionSet(true);
        self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
        self iPrintln("Enhanced Vision: ^2ON");
    }
    else
    {
        self useServerVisionSet(false);
        self iPrintln("Enhanced Vision: ^1OFF");
    }
}
LVis()
{
    self.lv = booleanOpposite(self.lv);
    if(self.lv)
    {
        self useServerVisionSet(true);
        self SetVisionSetforPlayer("taser_mine_shock", 0);
        self iPrintln("Light Vision: ^2ON");
    }
    else
    {
        self useServerVisionSet(false);
        self iPrintln("Light Vision: ^1OFF");
    }
}
BWV()
{
    self.bw = booleanOpposite(self.bw);
    if(self.bw)
    {
        self useServerVisionSet(true);
        self SetVisionSetforPlayer("mpintro", 0);
        self iPrintln("Black and White Vision: ^2ON");
    }
    else
    {
        self useServerVisionSet(false);
        self iPrintln("Black and White Vision: ^1OFF");
    }
}


//

//infections

longkillcam()
{
	self.killcam = booleanOpposite(self.killcam);
	if(self.killcam)
	{
		self iprintln("15 Sec Killcam: ^2ON");
		setDvar("scr_killcam_time", 15);
	}
	else
	{
		
		self iprintln("15 Sec Killcam: ^1OFF");
		setDvar("scr_killcam_time", 5);
	}
}

superreload()
{
	self.superreload = booleanOpposite(self.superreload);
	if(self.superreload)
	{
		self iprintln("Super Reload: ^2ON");
		setDvar("perk_weapReloadMultiplier", 0.001);
		self setperk("specialty_fastreload");
	}
	else
	{		
		self iprintln("Super Reload: ^1OFF");
		setDvar("perk_weapReloadMultiplier", 0.5);
		self unsetperk("specialty_fastreload");
	}
}

knock()
{
	level.knock = booleanOpposite(level.knock);
	if(level.knock)
	{
		setDvar("g_knockback","99999");
		self iPrintln("Knockback Lobby: ^2ON");
	}
	else
	{
		setDvar("g_knockback","5");
		self iPrintln("Knockback Lobby: ^1OFF");
	}
}

DoSky()
{
	level.skycolor = booleanOpposite(level.skycolor);
	if(level.skycolor)
	{
		self iPrintln("Sunset: ^2ON");
		setdvar("r_skyColorTemp","2345");
	}
	else
	{
		self iPrintln("Sunset: ^1OFF");
		setdvar("r_skyColorTemp","5678");
	}
}

ToggleLeft()
{
	self.leftgun = booleanOpposite(self.leftgun);
	if(self.leftgun)
	{
		self iPrintln("Left Sided Gun ^2ON");
		setDvar("cg_gun_y","7");
	}
	else
	{
		self iPrintln("Left Sided Gun ^1OFF");
		setDvar("cg_gun_y","0");
	}
}

dobig()
{
	self.bignames = booleanOpposite(self.bignames);
	if(self.bignames)
	{
		self iPrintln("Big Names: ^2ON");
		setDvar("cg_overheadnamessize","2.0");
	}
	else
	{
		self iPrintln("Big Names: ^1OFF");
		setDvar("cg_overheadnamessize","0.65");
	}
}

flashlowammo()
{
	self.flashammo = booleanOpposite(self.flashammo);
	if(self.flashammo)
	{
        self thread lowammoflash();
        self iPrintln("Flashing Low Ammo: ^2ON");
    }
    else
    {
        self notify("StopFlash");
        self iPrintln("Flashing Low Ammo: ^1OFF");
        setDvar("lowAmmoWarningColor1","1 1 1 1");
		setDvar("lowAmmoWarningNoAmmoColor1","1 1 1 1");
		setDvar("lowAmmoWarningNoReloadColor1","1 1 1 1");
    }
}

lowammoflash()
{
	self endon("death");
	self endon("disconnect");
	self endon("StopFlash");
	
	while(true)
	{
		setDvar("lowAmmoWarningColor1","1 0 0 1");
		setDvar("lowAmmoWarningNoAmmoColor1","1 0 0 1");
		setDvar("lowAmmoWarningNoReloadColor1","1 0 0 1");
		wait .2;
		setDvar("lowAmmoWarningColor1","1 0.7 0 1");
		setDvar("lowAmmoWarningNoAmmoColor1","1 0.7 0 1");
		setDvar("lowAmmoWarningNoReloadColor1","1 0.7 0 1");
		wait .2;
		setDvar("lowAmmoWarningColor1","1 1 0 1");
		setDvar("lowAmmoWarningNoAmmoColor1","1 1 0 1");
		setDvar("lowAmmoWarningNoReloadColor1","1 1 0 1");
		wait .2;
		setDvar("lowAmmoWarningColor1","0 1 0 1");
		setDvar("lowAmmoWarningNoAmmoColor1","0 1 0 1");
		setDvar("lowAmmoWarningNoReloadColor1","0 1 0 1");
		wait .2;
		setDvar("lowAmmoWarningColor1","0 0 1 1");
		setDvar("lowAmmoWarningNoAmmoColor1","0 0 1 1");
		setDvar("lowAmmoWarningNoReloadColor1","0 0 1 1");
		wait .2;
		setDvar("lowAmmoWarningColor1","1 0 1 1");
		setDvar("lowAmmoWarningNoAmmoColor1","1 0 1 1");
		setDvar("lowAmmoWarningNoReloadColor1","1 0 1 1");
		wait .2;
		setDvar("lowAmmoWarningColor1","0 1 1 1");
		setDvar("lowAmmoWarningNoAmmoColor1","0 1 1 1");
		setDvar("lowAmmoWarningNoReloadColor1","0 1 1 1");
		wait .2;
	}
}

togglecrosshair()
{
	self.crosshair = booleanOpposite(self.flashammo);
	if(self.crosshair)
	{
		self iprintln("Crosshair+: ^2ON");
		setDvar("perk_weapSpreadMultiplier", 0.001);
		self setperk("specialty_bulletaccuracy");
	}
	else
	{
		
		self iprintln("Crosshair+: ^1OFF");
		setDvar("perk_weapSpreadMultiplier", 1);
	}
}

NAMESTHROUGHWALLS()
{
	self.names = booleanOpposite(self.names);
	if(self.names)
	{
		self iprintln("Names Through Walls: ^2ON");
		self iprintln("^1AIM IN TO SEE NAMES!");
		setDvar("cg_enemyNameFadeOut", 900000);
		setDvar("cg_enemyNameFadeIn", 0);
		setDvar("cg_drawThroughWalls", 1);
		self setperk("specialty_marksman");
	}
	else
	{
		
		self iprintln("Names Through Walls: ^1OFF");
		setDvar("cg_enemyNameFadeOut", 250);
		setDvar("cg_enemyNameFadeIn", 250);
		setDvar("cg_drawThroughWalls", 0);
		self unsetperk("specialty_marksman");
	}
}

invisiblegun()
{
	self.invisiblegun = booleanOpposite(self.invisiblegun);
	if(self.invisiblegun)
	{
		self iprintln("Invisible Gun: ^2ON");
		setDvar("cg_gun_x", -50);
	}
	else
	{
		
		self iprintln("Invisible Gun: ^1OFF");
		setDvar("cg_gun_x", 0);
	}
}

acrossweapons()
{
	self.across = booleanOpposite(self.across);
	if(self.across)
	{
		self iprintln("Across Map Weapons: ^2ON");
		setDvar("player_useRadius", 999999999);
	}
	else
	{
		
		self iprintln("Across Map Weapons: ^1OFF");
		setDvar("player_useRadius", 5);
	}
}


/*martyrdom(test)
{
}

kickclientent(player)
{
	kick(player getEntityNumber());
}*/



