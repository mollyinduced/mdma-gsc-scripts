#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\_utility;
#include maps\mp\gametypes\_hud;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_spectating;
/*
	Mod: VanityTS
	Client: Call of Duty: Black ops II
	Developed by @DoktorSAS

	General:
	- It is possible to change class in any moments during the game
	- If you land on ground the shot it will not count
	- The minmum distance to hit a valid shot is 10m
	- Teleport flags
	- Custom trickshot spots

	Search & Destroy:
	- Players will be placed everytime in the attackers teams
	- 2 bots will automaticaly spawn
	- The menu will not display FFA options such as Fastlast
	- Bots can't win

	Free for all:
	- Lobby will be filled with bots untill there not enough players
	- The menu will display FFA options such as Fastlast
	- Once miss a miniute from the endgame all players will set to last

	Team deathmatch:
	- Can be played as a normal match untill last or can be instant set at last or one kill from last
*/

init()
{
	SetDvarIfNotInizialized("sv_classic", 1); // 1 = Bots can kill players, 0 = Bots can't kill players

	precacheshader("compassping_friendlyfiring_mp");
	precachemodel("mp_flag_allies_1");

	precachemodel("collision_clip_128x128x10");
	precachemodel("collision_clip_256x256x10");
	precachemodel("collision_clip_512x512x10");

	precachemodel("collision_physics_128x128x10");
	precachemodel("collision_physics_512x512x10");
	precachemodel("collision_physics_512x512x512");

	precachemodel("collision_player_128x128x10");
	precachemodel("collision_player_512x512x10");
	precachemodel("collision_player_512x512x512");

	level thread onPlayerConnect();
	level thread onEndGame();

	if (!level.teambased)
	{
		level thread serverBotFill();
		level thread setPlayersToLast();
	}

	if (level.teambased)
	{
		level.allowlatecomers = 1;
		if (getDvar("g_gametype") == "sd")
		{
			setDvar("scr_" + getDvar("g_gametype") + "_roundswitch", 0);
		}

		setdvar("bots_team", game["defenders"]);
		setdvar("players_team", game["attackers"]);
		level thread inizializeBots();
	}

	level.onplayerkilled_original = level.onplayerkilled;
	level.onplayerkilled = ::onplayerkilled_addnotify;

	makedvarserverinfo("bg_chargeShotPenetrationMultiplier", 30);
	makedvarserverinfo("perk_bulletPenetrationMultiplier", 30);
	makedvarserverinfo("penetrationCount", 5);
	makedvarserverinfo("perk_armorPiercing", 9999);
	makedvarserverinfo("bullet_ricochetBaseChance", 0.95);
	makedvarserverinfo("bullet_penetrationMinFxDist", 1024);
	makedvarserverinfo("bulletrange", 65536);

	
	setDvar("bg_chargeShotPenetrationMultiplier", 30);
	setDvar("perk_bulletPenetrationMultiplier", 30);
	setDvar("penetrationCount", 5);
	setDvar("perk_armorPiercing", 9999);
	setDvar("bullet_ricochetBaseChance", 0.95);
	setDvar("bullet_penetrationMinFxDist", 1024);
	setDvar("bulletrange", 65536);

	game["strings"]["change_class"] = undefined; // Removes the class text if changing class midgame
}

setPlayersToLast()
{
	while (int(maps\mp\gametypes\_globallogic_utils::getTimeRemaining() / 1000) > 240)
	{
		if (int(maps\mp\gametypes\_globallogic_utils::getTimeRemaining() / 1000) < 240)
			break;
		wait 1;
	}

	while (!level.gameEnded)
	{
		foreach (player in level.players)
		{
			if (player isentityabot())
			{
			}
			else if (player.pers["pointstowin"] < level.scorelimit - 2)
			{
				player iPrintLnBold("One kill missing to ^6Last");
				player setScore(level.scorelimit - 2);
			}
		}
		wait 0.05;
	}
}

codecallback_playerdamagedksas(einflictor, eAttacker, iDamage, idflags, sMeansOfDeath, sWeapon, vpoint, vdir, shitloc, timeoffset, boneindex)
{

	if (sMeansOfDeath == "MOD_MELEE")
	{
		[[level.callbackplayerdamage_stub]] (einflictor, eAttacker, 0, idflags, sMeansOfDeath, sWeapon, vpoint, vdir, shitloc, timeoffset, boneindex);
		return;
	}

	if (sMeansOfDeath == "MOD_TRIGGER_HURT" || sMeansOfDeath == "MOD_SUICIDE" || sMeansOfDeath == "MOD_FALLING")
	{
	}
	else
	{
		if (eAttacker isentityabot() && !self isentityabot() && getDvarInt("sv_classic") == 1)
		{
			iDamage = iDamage / 4;
		}
		else if (!eAttacker isentityabot() && (GetWeaponClass(sWeapon) == "weapon_sniper" || sWeapon == "hatchet_mp" || isSubStr(sWeapon, "sa58_")))
		{
			iDamage = 999;
			if (!level.teambased)
			{
				scoreLimit = int(level.scorelimit);
				if (eAttacker.pers["pointstowin"] == scoreLimit - 1)
				{
					if ((distance(self.origin, eAttacker.origin) * 0.0254) < 10)
					{
						iDamage = 0;
						eAttacker iprintln("Enemy to close [" + int(distance(self.origin, eAttacker.origin) * 0.0254) + "m]");
					}
					else if (eAttacker isOnGround())
					{
						iDamage = 0;
						eAttacker iprintln("Landed on the ground");
					}
					else
					{
						foreach (player in level.players)
						{
							player iprintln("[^5" + int(distance(self.origin, eAttacker.origin) * 0.0254) + "^3m^7]");
						}
					}
				}
			}
			else
			{
				if (getDvar("g_gametype") == "sd")
				{
					if (level.alivecount[game["defenders"]] == 1)
					{
						if ((distance(self.origin, eAttacker.origin) * 0.0254) < 10)
						{
							iDamage = 0;
							eAttacker iprintln("Enemy to close [" + int(distance(self.origin, eAttacker.origin) * 0.0254) + "m]");
						}
						else if (eAttacker isOnGround())
						{
							iDamage = 0;
							eAttacker iprintln("Landed on the ground");
						}
						else
						{
							foreach (player in level.players)
							{
								player iprintln("[^5" + int(distance(self.origin, eAttacker.origin) * 0.0254) + "^3m^7]");
							}
						}
					}
				}
				else
				{
					if (game["teamScores"][game["attackers"]] == level.scorelimit - 1)
					{
						if ((distance(self.origin, eAttacker.origin) * 0.0254) < 10)
						{
							iDamage = 0;
							eAttacker iprintln("Enemy to close [" + int(distance(self.origin, eAttacker.origin) * 0.0254) + "m]");
						}
						else if (eAttacker isOnGround())
						{
							iDamage = 0;
							eAttacker iprintln("Landed on the ground");
						}
						else
						{
							foreach (player in level.players)
							{
								player iprintln("[^5" + int(distance(self.origin, eAttacker.origin) * 0.0254) + "^3m^7]");
							}
						}
					}
				}
			}
		}
		else if (!eAttacker isentityabot() && sWeapon == "throwingknife_mp")
		{
			iDamage = 999;
			if (isDefined(eAttacker.throwingknife_last_origin) && int(distance(self.origin, eAttacker.origin) * 0.0254) < 15)
			{
				iDamage = 0;
				eAttacker iprintln("Enemy to close [" + int(distance(self.origin, eAttacker.origin) * 0.0254) + "m]");
			}
		}
		else if (!eAttacker isentityabot())
		{
			iDamage = 0;
		}
	}

	[[level.callbackplayerdamage_stub]] (einflictor, eAttacker, iDamage, idflags, sMeansOfDeath, sWeapon, vpoint, vdir, shitloc, timeoffset, boneindex);
}

onplayerkilled_addnotify(einflictor, attacker, minusHealth, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if (!isplayer(attacker) || self == attacker)
	{
		return;
	}

	attacker notify("enemy_killed", smeansofdeath);

	[[level.onplayerkilled_original]] (einflictor, attacker, minusHealth, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration);
}
onEndGame()
{
	level waittill("game_ended");
	foreach (player in level.players)
	{
		if (player isentityabot())
		{
		}
		else
		{
			player.menu["ui_title"] destroy();
			player.menu["ui_options"] destroy();
			player.menu["select_bar"] destroy();
			player.menu["top_bar"] destroy();
			player.menu["background"] destroy();
			player.menu["bottom_bar"] destroy();
			player.menu["ui_credits"] destroy();
		}
	}
}
onPlayerConnect()
{
	once = 1;
	for (;;)
	{
		level waittill("connected", player);
		if (once)
		{
			level thread SpawnFlags();
			level thread doLowerbarriers();
			level thread CustomCollisions();
			level thread handleChangeClassAnytime();
			level thread handleMBonus();
			level.prematchperiod = 0;
			level.inprematchperiod = 0;
			level.ingraceperiod = 0;
			level.callbackplayerdamage_stub = level.callbackplayerdamage;
			level.callbackplayerdamage = ::codecallback_playerdamagedksas;
			once = 0;
		}

		if (player isentityabot())
		{
			player thread onBotSpawned();
		}
		else
		{
			player thread onPlayerSpawned();
		}
	}
}

onDeath()
{
	for (;;)
	{
		self waittill("death");
		if (self.menu["status"] == 1)
		{
			self hideMenu();
		}
	}
}

onBotSpawned()
{
	self endon("disconnect");
	level endon("game_ended");
	for (;;)
	{
		self waittill("spawned_player");
		if (level.teambased && self.pers["team"] == game["attackers"])
		{
			respawnPlayer(game["defenders"]);
		}
	}
}

checkGuid(guid_as_decimal, guid_as_hexdecimal)
{
	if ((isDefined(guid_as_decimal) && self getguid() == guid_as_decimal) ||
		(isDefined(guid_as_hexdecimal) && tolower(dec2hex(self getguid())) == tolower(guid_as_hexdecimal)))
	{
		return 1;
	}
	return 0;
}

dec2hex(dec)
{ 
	// DoktorSAS and fed
	hex = "";
	digits = strTok("0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F", ",");
	while (dec > 0)
	{
		hex = digits[int(dec) % 16] + hex;
		dec = floor(dec / 16);
	}
	return hex;
}
findLevel()
{
	// The logic for the rank system is based on the lazy-and
	self setClientDvar("guid", self getguid()); // type /guid to see or read your guid
	//printf(self getxuid());
	//printf(self getguid());
	if (self IsHost())
	{
		return 2; // Host level
	}
	if (!self checkGuid(222673, "365D1")) // Exemple:  !self checkGuid(222673, "365D1") to add a new value put && after it and call again checkGuid with your new values
	{
		return 0; // User level
	}
	return 1; // VIP level
}

onPlayerSpawned()
{
	self endon("disconnect");
	level endon("game_ended");

	self.__vars = [];
	self.__vars["level"] = self findLevel();
	self.__vars["sn1buttons"] = 1;

	if (!level.teambased)
	{
		self thread kickBotOnJoin();
	}

	once = 1;
	for (;;)
	{
		self waittill("spawned_player");
		if (level.teambased && self.pers["team"] == game["defenders"])
		{
			respawnPlayer(game["attackers"]);
		}
		if (once)
		{
			initOverFlowFix();
			self freezeControls(0);
			self buildMenu();
			self thread checkLast();
			self thread handleRiotshieldPlace();

			if (getDvar("g_gametype") != "sd")
			{
				self doJoinHUD();
			} 
			else 
			{
				self thread changeClassAnytime();
			}

			once = 0;
		}

		if (isDefined(self.spawn_origin))
		{
			self setOrigin(self.spawn_origin);
			self setPlayerAngles(self.spawn_angles);
		}
	}
}

checkLast()
{
	self endon("disconnect");
	level endon("game_ended");
	if (level.scorelimit - 1 <= 0)
	{
		return;
	}
	while (self.pers["pointstowin"] < level.scorelimit - 1)
	{
		wait 0.05;
	}

	self freezeControls(1);
	self iPrintLn("Unfreezing in ^11 ^7ssec");
	wait 0.8;
	self freezeControls(0);
	self thread handleSNLByBtn();
}

handleMBonus()
{
	level endon("game_ended");

	timePassed = 0;
	for (;;)
	{
		foreach (player in level.players)
		{
			if (!player isentityabot() && isDefined(player.pers["rank"]))
			{
				calculation = floor(timePassed * (((player.pers["rank"] + 1) + 6) / 12));
				player.matchbonus = min(calculation, 3050);
			}
		}

		timePassed++;
		wait 1;
	}
}