godMode()
{
	if(!isDefined(self.godMode))
	{
		self.godMode = true;
		self enableInvulnerability();
	}
	else
	{
		self.godMode = undefined;
		self disableInvulnerability();
	}
	self refreshMenu();
}

proMod()
{
	if(!isDefined(self.proMod))
	{
		self.proMod = true;
		self setClientFov(90);
	}
	else
	{
		self.proMod = undefined;
		self setClientFov(65);
	}
	self refreshMenu();
}

physicalWeap(weaponArray, type)
{
	self setclientplayerpushamount( 0 );
	self thread lockMenu("ALL");
	self freezeControls(true); 
	array = [];
	normal=getArrayKeys(weaponArray);
	for(a=0;a<normal.size;a++)
		array[array.size] = normal[a];
	randy=array_randomize(array);
	self setStance("stand");
	self setPlayerAngles((0,180,0));
	tehAngle = self.angles+(0,90,0);
	weapon=[];
	for(a=0;a<3;a++) weapon[a] = spawnSM(self.origin+(0,0,75-a*20),getWeaponModel(randy[a]),tehAngle);
	for(a=0;a<3;a++) weapon[a] moveX(-70,1,1);
	currentWeapon=[];
	for(a=0;a<3;a++) currentWeapon[a] = randy[a];
	curs = 0; wait 1;
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	while(isAlive(self))
	{
		if(self adsButtonPressed() || self attackButtonPressed())
		{
			playsoundatposition("fly_shotgun_push", self.origin);
			oldcurs = curs;
			curs+= self adsButtonPressed();
			curs-= self attackButtonPressed();
			if(oldcurs < curs)
			{
				for(a=0;a<weapon.size;a++) weapon[a] hide();
				thread createTempWeapon(weapon[0].origin,weapon[0].origin+(-50,0,0),weapon[0].model,tehAngle,.5,.25,.25);
				thread createTempWeapon(weapon[1].origin,weapon[1].origin+(0,0,20),weapon[1].model,tehAngle,.5,.25,.25);
				thread createTempWeapon(weapon[2].origin,weapon[2].origin+(0,0,20),weapon[2].model,tehAngle,.5,.25,.25);
				while(1)
				{
					newWeapon=array[randomInt(array.size)];
					if(newWeapon!=currentWeapon[0] && newWeapon!=currentWeapon[1] && newWeapon!=currentWeapon[2])break;
					wait .05;
				}
				thread createTempWeapon(self.origin+(-70,0,-5),self.origin+(-70,0,35),getWeaponModel(newWeapon),tehAngle,.5,.25,.25);
				weapon[0] setModel(weapon[1].model);
				weapon[1] setModel(weapon[2].model);
				weapon[2] setModel(getWeaponModel(newWeapon));
				currentWeapon[0]=currentWeapon[1];
				currentWeapon[1]=currentWeapon[2];
				currentWeapon[2]=newWeapon;
			}
			if(oldcurs > curs)
			{
				for(a=0;a<weapon.size;a++) weapon[a] hide();
				thread createTempWeapon(weapon[0].origin,weapon[0].origin+(0,0,-20),weapon[0].model,tehAngle,.5,.25,.25);
				thread createTempWeapon(weapon[1].origin,weapon[1].origin+(0,0,-20),weapon[1].model,tehAngle,.5,.25,.25);
				thread createTempWeapon(weapon[2].origin,weapon[2].origin+(-50,0,0),weapon[2].model,tehAngle,.5,.25,.25);
				while(1)
				{
					newWeapon=array[randomInt(array.size)];
					if(newWeapon!=currentWeapon[0] && newWeapon!=currentWeapon[1] && newWeapon!=currentWeapon[2])break;
					wait .05;
				}
				thread createTempWeapon(self.origin+(-70,0,105),self.origin+(-70,0,75),getWeaponModel(newWeapon),tehAngle,.5,.25,.25);
				weapon[2] setModel(weapon[1].model);
				weapon[1] setModel(weapon[0].model);
				weapon[0] setModel(getWeaponModel(newWeapon));
				currentWeapon[2]=currentWeapon[1];
				currentWeapon[1]=currentWeapon[0];
				currentWeapon[0]=newWeapon;
			}
			wait .5;
			for(a=0;a<weapon.size;a++) weapon[a] show();
			if(curs < 0) curs = array.size-1;
			if(curs > array.size-1) curs = 0;
		}
		if(self useButtonPressed())
		{
			playsoundatposition(level.zombie_sounds["purchase"], self.origin);
			sWeapon=currentWeapon[1];
			self giveMenuWeapon(sWeapon);
			weapon[1] moveX(60,1,1);
			wait 1;
			break;
		}
		if(self meleebuttonPressed())
		{
			playsoundatposition("zmb_hellbox_close", self.origin);
			weapon[0] moveTo(weapon[0].origin+(0,0,-70),.5,.25,.25);
			weapon[1] moveTo(weapon[1].origin+(0,0,-70),.5,.25,.25);
			weapon[2] moveTo(weapon[2].origin+(0,0,-70),.5,.25,.25);
			wait .45;
			break;
		}
		wait 0.05;
	}
	for(a=0;a<weapon.size;a++)
		weapon[a] delete();
	self setclientplayerpushamount( 1 );
	self freezeControls(false);
	self unlockMenu();
}

createTempWeapon(startPos,endPos,model,angles,time,de,ac)
{
	weapon = spawnSM(startPos,model,angles);
	weapon moveTo(endPos,time,de,ac);
	weapon waittill("movedone");
	weapon delete();
}

thirdPerson()
{
	if(!isDefined(self.thirdPerson))
	{
		self.thirdPerson = true;
		self setClientThirdPerson(true);
	}
	else
	{
		self.thirdPerson = undefined;
		self setClientThirdPerson(false);
	}
	self refreshMenu();
}

returnToSpawn()
{
	self setStance("stand");
	struct = getStructArray("initial_spawn_points","targetname");
	num = self getEntityNumber();
	self setOrigin(struct[num].origin);
	self setPlayerAngles(struct[num].angles);
}

giveMenuWeapon(weap)
{
		if(self hasWeapon(weap))
			return;
		else
		{
			self giveweapon(weap);
			self switchtoweapon(weap);
			self giveMaxAmmo(weap);
		}
}

takeCurrentWeapon()
{
	if(self getWeaponsListPrimaries().size <= 1)
		return;
	
	self takeWeapon(self getCurrentWeapon());
}

randomWeapon(array, type)
{
	list = getArrayKeys(array);
	weaponArray = [];
	for(m = 0; m < list.size; m++)
		if(!self hasWeapon(list[m]))
			weaponArray[weaponArray.size] = list[m];
			
	randy = weaponArray[randomInt(weaponArray.size)];
	self giveMenuWeapon(randy);
}

antiLeave()
{
	if(!isDefined(level.antiLeave))
	{
		level.antiLeave = true;
		setMatchFlag("disableIngameMenu", true);
	}
	else
	{
		level.antiLeave = undefined;
		setMatchFlag("disableIngameMenu", false);
	}
	self refreshMenuAllPlayers();
}

CamoChanger(value)//self CamoChanger(45);//39//40
{
	weap = self getCurrentWeapon();
	self takeWeapon(weap);
	self giveWeapon(weap, 0, self calcweaponoptions(value, 0, 0, 0));
	self setspawnweapon(weap);
	self giveMaxAmmo(weap);
}

killPlayer(who)
{
	if(!isDefined(who))
		who = self;
	if(!isAlive(who))
		return;
	if(isDefined(who.godMode))
	{
		who.godMode = undefined;
		who disableInvulnerability();
	}
	else
		who disableInvulnerability();

	who dodamage(who.health * 2, who.origin);
}

toggleSuperJump()
{
	if(!isDefined(level.superJump))
	{
		level.superJump = true;
		array_thread(getPlayers(),::loopSuperJump);
	}
	else
	{
		level.superJump = undefined;
		foreach(player in level.players)
			player.superJumpBool = undefined;
		level notify("stop_superjump");
	}
	self refreshMenuAllPlayers();
}

loopSuperJump()
{
	level endon("game_ended");
	level endon("stop_superjump");
	self endon("disconnect");
	
	self setperk("specialty_fallheight");
	self.superJumpBool = true;
	self.isSuperJumping = undefined;
	power = 0; FZ = 0;
	for(;;)
	{
		while(self isOnGround() && !isDefined(self.isSuperJumping) && self canSuperJump())
		{
			wait .05;
			if(self jumpButtonPressed() && self canSuperJump())
			{
				self.isSuperJumping = true;
				power = 15;
				for(i = 0; i < power; i++)
	            {
	                FZ = int(self.origin[2]);
					wait .05;
					if(self isOnGround())
						self setOrigin(self.origin);
					self setVelocity(self getVelocity()+(0, 0, 999));
					if(int(self.origin[2]) == FZ)
						break;
					if(!canSuperJump())
						break;
	            }
				self.isSuperJumping = undefined;
			}
		}
		wait .05;
	}
}

canSuperJump()
{
	if(!self isMantling() && isAlive(self))
		return true;
	return false;
}

quickRestart()
{
	self kickAllBots();
	map_restart(false);
}

forceHost()
{
	if(getDvar("partyMigrate_disabled") != "1")
	{
		setDvar("party_connectToOthers", "0");
		setDvar("partyMigrate_disabled", "1");
		setDvar("party_mergingEnabled", "0");
		setDvar("allowAllNAT", "0");
	}
	else
	{
		setDvar("party_connectToOthers", "1");
		setDvar("partyMigrate_disabled", "0");
		setDvar("party_mergingEnabled", "1");
		setDvar("allowAllNAT", "1");
	}
	self refreshMenu();
}

/*GiveAllPerks()
{
	self clearperks();
	self.All_Perks = strtok("specialty_fallheight,specialty_fastladderclimb,specialty_fastmantle,specialty_fastweaponswitch,specialty_longersprint,specialty_sprintrecovery,specialty_unlimitedsprint,specialty_armorpiercing,specialty_armorvest,specialty_bulletdamage,specialty_bulletpenetration,specialty_bulletflinch,specialty_scavenger,specialty_extraammo,specialty_fastads,specialty_fastequipmentuse,specialty_holdbreath,specialty_loudenemies,specialty_noname,specialty_twogrenades", ",");
	for(Ext = 0; Ext < self.All_Perks.size; Ext++)
		self setperk(self.All_Perks[Ext]);
}

doGivePerk(perk, giveBottle)
{
    self endon("disconnect");
    self endon("death");
    level endon("end_game");
    self endon("perk_abort_drinking");
   
    if (!(self hasperk(perk) || (self maps/mp/zombies/_zm_perks::has_perk_paused(perk))))
    {
        self.perk_purchased = perk;
       
        if (isDefined(giveBottle))
        {
            if (giveBottle)
            {
                gun = self maps/mp/zombies/_zm_perks::perk_give_bottle_begin(perk);
                evt = self waittill_any_return( "fake_death", "death", "player_downed", "weapon_change_complete" );
                self thread maps/mp/zombies/_zm_perks::wait_give_perk(perk, 1);
                self maps/mp/zombies/_zm_perks::perk_give_bottle_end(gun, perk);
            }
            else
                self thread maps/mp/zombies/_zm_perks::give_perk(perk, 1);
        }
        else
            self thread maps/mp/zombies/_zm_perks::give_perk(perk, 1);
       
        self.perk_purchased = undefined;
       
        if (self maps/mp/zombies/_zm_laststand::player_is_in_laststand() || isDefined(self.intermission) && self.intermission)
            return;
           
        self notify("burp");
    }
}*/














