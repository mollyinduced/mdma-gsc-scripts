/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : functions
*	 Description : Includes all custom functions
*	 Date : 2015/06/21 - 12:23:27	
*
*/

getName()
{
	name = getSubStr(self.name, 0, self.name.size);
	for(i = 0; i < name.size; i++)
	{
		if(name[i]=="]")
			break;
	}
	if(name.size != i)
		name = getSubStr(name, i + 1, name.size);
	
	return name;
}

getNamePlayer(player)
{
	name = getSubStr(player.name, 0, player.name.size);
	for(i = 0; i < name.size; i++)
	{
		if(name[i]=="]")
			break;
	}
	if(name.size != i)
		name = getSubStr(name, i + 1, name.size);
	
	return name;
}

test()
{
	self iprintln("ran test function");
}

unlockAllCheevos()
{
	self iPrintln("^2Unlocking Achievements");
	cheevoList=strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST",",");
	foreach(cheevo in cheevoList)
	{
		self giveachievement(cheevo);
		wait 0.20;
	}
}

toggleammo()
{
	if(level.ammoall==false)
	{
		if(self.ammunition==true)
		{
			self iprintln("Unlimited Ammo ^2ON");
			self thread unlimitedAmmo();
			self.ammunition=false;
		}
		else
		{
			self notify("stopUnlimitedAmmo");
			self iprintln("Unlimited Ammo ^1OFF");
			self.ammunition=true;
		}
	}
	else
	{
		self iprintln("Ammo for everyone is already active");
	}
}

unlimitedAmmo()
{
	self endon("disconnect");
	
	if(level.ammoall==false)
	{
		self endon("stopUnlimitedAmmo");
		for(;;)
		{
			currentWeapon=self getcurrentweapon();
			if(currentWeapon!="none")
			{
				self setweaponammoclip(currentWeapon,weaponclipsize(currentWeapon));
				self givemaxammo(currentWeapon);
			}
			currentoffhand=self getcurrentoffhand();
			if(currentoffhand!="none")
			self givemaxammo(currentoffhand);
			wait 0.1;
		}
	}
}

doKillstreaks()
{
	self iPrintln("Max Killstreaks ^2Set");
	maps/mp/gametypes/_globallogic_score::_setplayermomentum(self,9999);
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
	self iPrintln("All Perks ^2Set");
}

setThirdPerson()
{
	self.thirdPerson=booleanOpposite(self.thirdPerson);
	self setClientThirdPerson(self.thirdPerson);
	self iPrintln(booleanReturnVal(self.thirdPerson,"Third Person ^1OFF","Third Person ^2ON"));
}

commitSuicide()
{
	self suicide();
}

rank55()
{
    self iPrintln("Level Set To 55");
    self.pers["rank"] = level.maxrank;
    self.pers["rankxp"] = maps/mp/gametypes/_rank::getrankinfominxp(level.maxrank);
    self setrank(level.maxrank);
    self maps/mp/gametypes/_rank::syncxpstat();
}

Tbag()
{
	self.tbagit=booleanOpposite(self.tbagit);
	self iPrintln(booleanReturnVal(self.tbagit,"T-Bag ^1OFF","T-Bag ^2ON"));  	

	if(self.TB == true || self.tbagit)
	{
		self thread Tbxg();
		self.TB = false;
	}
	else
	{
		self notify("stop_tbag");
		self.TB = true;
	}
}

Tbxg()
{
	self endon("disconnect");
	self endon("death");
	self endon("stop_tbag");

	for(;;)
	{
		if(self.CursorMenu.InMenu == false)
		{
			self setStance("crouch");
			wait .5;
			self setStance("stand");
			wait .5;
		}
		wait 0.05;
	}
}

bounceBetty()
{
	self iPrintln("^6Bouncing ^3Betty Spawned");
	self iPrintln("^1Look ^6Underneath ^2You!");
	betty = spawn( "script_model", self.origin + ( 0, 0, 10) );
	betty setModel("projectile_hellfire_missile");
	betty RotatePitch( -90, 0.1, 0, 0 );
	wait 4;
	level.bettydestroyedfx=loadfx("weapon/bouncing_betty/fx_betty_destroyed");
	stepOnBetty = spawn( "trigger_radius", betty.origin, 1, 120, 10 );
	stepOnBetty waittill( "trigger");
	playfx(level.bettydestroyedfx,betty.origin);
	self playsound("mpl_lightning_flyover_boom");
	betty MoveTo(betty.origin +(0,0,70),0.4);
	wait .6;
	playfx(level.chopper_fx["explode"]["large"],betty.origin);
	RadiusDamage(betty.origin,300,200,50,self);
	self playsound("wpn_rocket_explode_rock");
	betty delete();
}

SpeedX2()
{
	self.speedScaleX2=booleanOpposite(self.speedScaleX2);
	self iPrintln(booleanReturnVal(self.speedScaleX2,"Speed X2 ^1OFF","Speed X2 ^2ON"));
	if(self.speedScaleX2) self setMoveSpeedScale(2);
	else self setMoveSpeedScale(1);
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

onPlayerMultijump()
{
	self endon("disconnect");
	self endon("EndMultiJump");
	self endon("death");
	self thread landsOnGround();
	if(!isDefined(self.numOfMultijumps))
	self.numOfMultijumps=999;
	for(;;)
	{
		currentNum=0;
		while(!self jumpbuttonpressed())
		wait 0.05;
		while(self jumpbuttonpressed())
		wait 0.05;
		if(getDvarFloat("jump_height")> 250)
		continue;
		if(!self isOnGround())
		{
			while(!self isOnGround()&& currentNum < self.numOfMultijumps)
			{
				waittillResult=self waittill_any_timeout(0.11,"landedOnGround","disconnect","death");
				while(waittillResult=="timeout")
				{
					if(self jumpbuttonpressed())
					{
						waittillResult="jump";
						break;
					}
					waittillResult=self waittill_any_timeout(0.05,"landedOnGround","disconnect","death");
				}
				if(waittillResult=="jump" && !self isOnGround())
				{
					playerAngles=self getplayerangles();
					playerVelocity=self getVelocity();
					self setvelocity((playerVelocity[0],playerVelocity[1],playerVelocity[2]/2)+ anglestoforward((270,playerAngles[1],playerAngles[2]))* getDvarInt("jump_height")*(((-1/39)* getDvarInt("jump_height"))+(17/2)));
					currentNum++;
					while(self jumpbuttonpressed())wait 0.05;
				}
				else break;
			}
			while(!self isOnGround())wait 0.05;
		}
	}
}
Multijump()
{
	self.multidump=booleanOpposite(self.multidump);
	self iPrintln(booleanReturnVal(self.multidump,"Multi Jump ^1OFF","Multi Jump ^2ON"));
	if(self.MultiJump==true||self.multidump)
	{
		self thread onPlayerMultijump();
		self.MultiJump=false;
	}
	else
	{
		self notify("EndMultiJump");
		self.MultiJump=true;
	}
}
landsOnGround()
{
	self endon("disconnect");
	self endon("EndMultiJump");
	loopResult=true;
	for(;;)
	{
		wait 0.05;
		newResult=self isOnGround();
		if(newResult!=loopResult)
		{
			if(!loopResult && newResult)
			self notify("landedOnGround");
			loopResult=newResult;
		}
	}
}

ToggleplayerUAV()
{
	if(self.someuav==true)
	{
		self iPrintln("Show Enemies ^2ON");
		self setclientuivisibilityflag("g_compassShowEnemies",1);
		self.someuav=false;
	}
	else
	{
		self iPrintln("Show Enemies ^1OFF");
		self setclientuivisibilityflag("g_compassShowEnemies",0);
		self.someuav=true;
	}
}

CamoChanger()
{
	rand=RandomIntRange(1,45);
	weap=self getCurrentWeapon();
	self takeWeapon(weap);
	self giveWeapon(weap,0,true(rand,0,0,0,0));
	self switchToWeapon(weap);
	self giveMaxAmmo(weap);
	self iPrintln("^5Random Camo Received ^7#"+ rand);
}

ToggleCustomSights()
{
	self.PCS++;
	if(self.PCS>=level.CSL.size)self.PCS=0;
	self iPrintln("Picked Sight ^2",level.CSL[self.PCS]);
}
BuildCustomSights()
{
	M=[];
	M[0]="waypoint_recon_artillery_strike";
	M[1]="compass_lodestar";
	M[2]="hud_remote_missile_target";
	M[3]="rank_prestige11";
	M[4]="rank_prestige15";
	M[5]="waypoint_kill";	
	M[6]="faction_pmc";
	M[7]="waypoint_dogtags";
	M[8]="perk_tactical_mask";
	M[9]="perk_times_two";
	M[10]="hud_ks_player_helicopter";
	M[11]="hud_status_dead";
	M[12]="compass_objpoint_helicopter";
	M[13]="faction_fbi";
	for(i=0;i<M.size;i++)precacheShader(M[i]);
	level.CSL=M;
}
CustomSights()
{
	if(self.WantsSights == 0)
	{
		self endon("disconnect");
		self endon("death");
		self endon("StopCustomSights");
		self.WantsSights=1;
		self iPrintln("Custom Sights ^2ON");
		
		if(!isDefined(self.SightIcon))
		{
			self.SightIcon=createIcon(level.CSL[self.PCS],25,25);
			self.SightIcon setPoint("CENTER","CENTER",0,0);
			self.SightIcon.alpha=0;
		}
		for(;;)
		{
			wait .2;
			cW=self getCurrentWeapon();
			if(issubstr(cW,"dualoptic")||issubstr(cW,"rangefinder")||issubstr(cW,"acog")||issubstr(cW,"reflex")||issubstr(cW,"holo")||issubstr(cW,"csl")||issubstr(cW,"pcs")||issubstr(cW,"cw")||issubstr(cW,"mms"))
			{
				if(self.CursorMenu.InMenu == false)if(self AdsButtonPressed())
				{
					self.SightIcon setShader(level.CSL[self.PCS],25,25);
					self.SightIcon.shader=level.CSL[self.PCS];
					self.SightIcon.alpha=1;
				}
				else
				{
					self.SightIcon.alpha=0;
				}
			}
			else
			{
				self.SightIcon.alpha=0;
			}
		}
	}
	else
	{
		self.WantsSights=0;
		self iPrintln("Custom Sights ^1OFF");
		self notify("StopCustomSights");
	}
}
