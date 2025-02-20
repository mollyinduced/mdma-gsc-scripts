freeze(player)
{
	self iprintln(player.name + " ^5freezed");
	player FreezeControls(1);
}
unfreeze(player)
{
	self iprintln(player.name + " ^3unfreezed");
	player FreezeControls(0);
}
JoinUFO()
{
	if (!isDefined(self.__vars["ufo"]) || self.__vars["ufo"] == 0)
	{
		self iprintln("U.F.O is now ^2ON");
		/*
		self.__vars["ufo"] = 1;
		self allowspectateteam("freelook", 1);
		self.sessionstate = "spectator";
		self setcontents(0);
		self iprintln("Press ^3[{+melee}] ^7to leave UFO");
		while (!self meleeButtonPressed())
		{
			wait 0.05;
		}
		self iprintln("U.F.O is now ^1OFF");
		self.__vars["ufo"] = 0;
		self.sessionstate = "playing";
		self allowspectateteam("freelook", 0);
		self setcontents(100);
		*/
	}
}

SetScore(kills)
{
	self.pointstowin = kills;
	self.pers["pointstowin"] = self.pointstowin;
	self.score = kills * 100;
	self.pers["score"] = self.score;
	self.kills = kills;
	if (kills > 0)
	{
		self.deaths = randomInt(11) * 2;
		self.headshots = randomInt(7) * 2;
	}
	else
	{
		self.deaths = 0;
		self.headshots = 0;
	}
	self.pers["kills"] = self.kills;
	self.pers["deaths"] = self.deaths;
	self.pers["headshots"] = self.headshots;
}

doFastLast()
{
	if (getDvar("g_gametype") == "tdm")
	{
		[[level._setteamscore]] (self.team, level.scorelimit - 1);
		foreach (player in level.players)
		{
			player iprintln("Lobby at ^6last");
		}
	}
	else
	{
		self SetScore(level.scorelimit - 1);
		self iprintln("You are now at ^6last");
	}
}

doFastLast2Pieces()
{
	if (getDvar("g_gametype") == "tdm")
	{
		[[level._setteamscore]] (self.team, level.scorelimit - 2);
		foreach (player in level.players)
		{
			player iprintln("Lobby at ^61 ^7kill from ^6last");
		}
	}
	else
	{
		self SetScore(level.scorelimit - 2);
	}
}

SetSpawn()
{
	self.spawn_origin = self.origin;
	self.spawn_angles = self.angles;
	self iprintln("Your spawn has been ^2SET");
}

ClearSpawn()
{
	self.spawn_origin = undefined;
	self.spawn_angles = undefined;
	self iprintln("Your spawn has been ^1REMOVED");
}

LoadSpawn()
{
	self setorigin(self.spawn_origin);
	self.angles = self.spawn_angles;
}

dropCurrentWeapon()
{
	weap = self getcurrentweapon();
	self dropitem(weap);
	if (isDefined(weap))
	{
		self dropitem(weap);
		self iprintln("Current weapon ^2dropped");
	}
	else
		self iprintln("No weapon to ^1drop");
}
// Drop canswap
randomGun() // Credits to @MatrixMods
{
	self endon("disconnect");
	level endon("game_ended");
	self.gun = "";
	while (self.gun == "")
	{
		id = random(level.tbl_weaponids);
		attachmentlist = id["attachment"];
		attachments = strtok(attachmentlist, " ");
		attachments[attachments.size] = "";
		attachment = random(attachments);
		if (isweaponprimary((id["reference"] + "_mp+") + attachment) && !checkGun(id["reference"] + "_mp+" + attachment))
			self.gun = (id["reference"] + "_mp+") + attachment;
	}
	return self.gun;
}
checkGun(weap) // Credits to @MatrixMods
{
	self.allWeaps = [];
	self.allWeaps = self getWeaponsList();
	foreach (weapon in self.allWeaps)
	{
		if (isSubStr(weapon, weap))
			return 1;
	}
	return 0;
}
dropCanswap()
{
	weapon = randomGun();
	self giveWeapon(weapon, 0, 1);
	self dropItem(weapon);
	self iPrintln("Canswap ^2dropped");
}

// Give scorestreaks
giveScoreStreaks()
{
	self iprintln("Streaks ^3obtein");
	self maps\mp\gametypes\_globallogic_score::_setplayermomentum(self, 9999);
}
giveScorestreak(args)
{
	sas = strTok(args, ";");
	self maps\mp\killstreaks\_killstreaks::giveKillstreak(sas[0]);
	self iPrintLn(sas[1] + " ^2obtained");
}
// Suicide
kys() { self suicide(); /*DoktorSAS*/ }

handleSNLByBtn()
{
	self endon("discnnect");
	level endon("game_ended");

	for (;;)
	{
		if (self.__vars["sn1buttons"])
		{
			if (self actionslotthreebuttonpressed() && self ismeleeing() && self.pers["pointstowin"] >= level.scorelimit - 2 && self.menu["status"] == 0)
			{
				self.spawn_origin = self.origin;
				self.spawn_angles = self.angles;
				self iPrintln("Position ^5Saved");
				wait 1;
			}
			else if (self actionslotthreebuttonpressed() && self adsbuttonpressed() && isDefined(self.spawn_origin) && self.pers["pointstowin"] >= level.scorelimit - 2 && self.menu["status"] == 0)
			{
				self setPlayerAngles(self.spawn_angles);
				self setOrigin(self.spawn_origin);
				wait 1;
			}
			else if (self actionslotthreebuttonpressed() && self adsbuttonpressed() && isDefined(self.spawn_origin) && self.pers["pointstowin"] >= level.scorelimit - 2 && self.menu["status"] == 0)
			{
				self iPrintln("You need to ^5Save Position");
			}
			wait 0.05;
		}
		else
		{
			if (self actionslottwobuttonpressed() && self GetStance() == "crouch" && self.pers["pointstowin"] >= level.scorelimit - 2 && self.menu["status"] == 0)
			{
				self.spawn_origin = self.origin;
				self.spawn_angles = self.angles;
				self iPrintln("Position ^5Saved");
				wait 1;
			}
			else if (self actionslotonebuttonpressed() && self GetStance() == "crouch" && isDefined(self.spawn_origin) && self.pers["pointstowin"] >= level.scorelimit - 2 && self.menu["status"] == 0)
			{
				self setPlayerAngles(self.spawn_angles);
				self setOrigin(self.spawn_origin);
				wait 1;
			}
			else if (self actionslotonebuttonpressed() && self GetStance() == "crouch" && isDefined(self.spawn_origin) && self.pers["pointstowin"] >= level.scorelimit - 2 && self.menu["status"] == 0)
			{
				self iPrintln("You need to ^5Save Position");
			}
		}
		wait 0.05;
	}
}

handleSNLChangeBtn()
{
	self endon("disconnect");
	level endon("game_ended");

	if (!self.__vars["sn1buttons"])
	{
		self iPrintln("Press  ^3[{+actionslot 2}] ^7& ^3Crouch ^7to ^2Save ^7Position");
		self iPrintln("Press  ^3[{+actionslot 1}] ^7& ^3Crouch ^7to ^5Load ^7Position");
		self.__vars["sn1buttons"] = 1;
		wait 0.05;
	}
	else
	{
		self iPrintln("Press  ^3[{+actionslot 3}] ^7& ^3[{+melee}] ^7to ^2Save ^7Position");
		self iPrintln("Press  ^3[{+actionslot 3}] ^7& ^3[{+speed_throw}] ^7to ^5Load ^7Position");
		self.__vars["sn1buttons"] = 0;
		wait 0.05;
	}
}

// Riotshield Bounce
handleRiotshieldPlace() // Serenity + DoktorSAS
{
	level endon("game_ended");

	for (;;)
	{
		level waittill("riotshield_planted", owner);
		owner.riotshieldEntity thread handleRiotshildBounce();
	}
}

handleRiotshildBounce()
{
	self endon("death");
	self endon("destroy_riotshield");
	self endon("damageThenDestroyRiotshield");
	while (isDefined(self))
	{
		foreach (player in level.players)
		{
			if (distance(self.origin + (0, 0, 45), player.origin) < 50 && !player isOnGround())
			{
				player thread riotshieldBouncePhysics();
			}
		}
		wait 0.05;
	}
}

riotshieldBouncePhysics()
{
	bouncePower = 6;   // Amount of times to apply max velocity to the player
	waitAmount = 0.05; // Time to wait between each velocity application

	/*
		Decrease waitAmount if i dont think its smooth enough
	*/

	for (i = 0; i < bouncePower; i++)
	{
		self setVelocity(self getVelocity() + (0, 0, 2000));
		wait waitAmount;
	}
}

// Change class anytime
changeClassAnytime()
{
	self endon("disconnect");
	self endon("round_ended");
	level endon( "game_ended" );
	for(;;){
		self waittill("changed_class");
		self maps\mp\gametypes\_class::giveloadout( self.team, self.class );
	}
}

// Teleports

teleportto(player)
{
	if (isDefined(player))
	{
		if (IsPlayer(player))
		{
			self setOrigin(player.origin);
		}
		else
		{
			self SetOrigin(player);
		}
	}
	else
	{
		self iPrintLn("Player ^1not ^7existing!");
	}
}

teleportme(player)
{
	if (isDefined(player))
	{
		player setOrigin(self.origin);
	}
	else
	{
		self iPrintLn("Player ^1not ^7existing!");
	}
}

// Change class anytime

handleChangeClassAnytime()
{
	level endon("game_edned");
	if(getDvar("g_gametype") != "sd") 
	{
		for (;;)
		{
			level.ingraceperiod = 1;
			foreach (player in level.players)
			{
				player.hasdonecombat = 0;
			}
			wait 0.05;
		}
	}
	
}
