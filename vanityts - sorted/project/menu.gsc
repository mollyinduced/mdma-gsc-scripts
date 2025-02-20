buildMenu()
{
	title = "VanityTS";
	self.menu = [];
	self.menu["status"] = 0;
	self.menu["index"] = 0;
	self.menu["page"] = "";
	self.menu["options"] = [];
	self.menu["ui_options_string"] = "";
	self.menu["ui_title"] = self CreateString(title, "objective", 1.6, "CENTER", "CENTER", 0, -200, (1, 1, 1), 0, (0, 0, 0), 0.5, 5, 0);
	self.menu["ui_options"] = self CreateString("placeholder", "objective", 1.2, "LEFT", "CENTER", -40, -190, (1, 1, 1), 0, (0, 0, 0), 0.5, 5, 0);
	self.menu["ui_credits"] = self CreateString("Developed by ^5DoktorSAS", "objective", 1, "CENTER", "CENTER", 0, -100, (1, 1, 1), 0, (0, 0, 0), 0.8, 5, 0);

	self.menu["select_bar"] = self CreateShader("white", 0, 22.4, 125, 13, GetColor("lightblue"), 0, 4, "TOP", "TOP");
	self.menu["top_bar"] = self CreateShader("white", 0, -10, 125, 25, GetColor("cyan"), 0, 3, "TOP", "TOP");
	self.menu["background"] = self CreateShader("black", 0, -20, 125, 40, GetColor("cyan"), 0, 1, "TOP", "TOP");
	self.menu["bottom_bar"] = self CreateShader("white", 0, -20, 125, 18, GetColor("cyan"), 0, 3, "TOP", "TOP");

	self thread handleMenu();
	self thread onDeath();
}
showMenu()
{
	buildOptions();
	self.menu["status"] = 1;

	self.menu["background"] setShader("black", 125, 70 + int(self.menu["options"].size / 2) + (self.menu["options"].size * 14));

	self.menu["ui_credits"].y = -170 + (self.menu["options"].size * 14.4 + 5);
	self.menu["bottom_bar"].y = (self.menu["options"].size * 14.4) + 30;

	self.menu["ui_title"] affectElement("alpha", 0.4, 1);
	self.menu["ui_options"] affectElement("alpha", 0.4, 1);
	self.menu["select_bar"] affectElement("alpha", 0.4, 0.8);
	self.menu["top_bar"] affectElement("alpha", 0.4, 1);
	self.menu["background"] affectElement("alpha", 0.4, 0.4);
	self.menu["bottom_bar"] affectElement("alpha", 0.4, 1);
	self.menu["ui_credits"] affectElement("alpha", 0.4, 1);
}

hideMenu()
{
	self.menu["ui_title"] affectElement("alpha", 0.4, 0);
	self.menu["ui_options"] affectElement("alpha", 0.4, 0);
	self.menu["select_bar"] affectElement("alpha", 0.4, 0);
	self.menu["top_bar"] affectElement("alpha", 0.4, 0);
	self.menu["background"] affectElement("alpha", 0.4, 0);
	self.menu["bottom_bar"] affectElement("alpha", 0.4, 0);
	self.menu["ui_credits"] affectElement("alpha", 0.4, 0);
	self.menu["status"] = 0;
	wait 1;
}

goToNextOption()
{
	self.menu["index"]++;
	if (self.menu["index"] > self.menu["options"].size - 1)
	{
		self.menu["index"] = 0;
	}
	self.menu["select_bar"] affectElement("y", 0.1, 22.4 + (self.menu["index"] * 14.4));
	wait 0.1;
}

goToPreviusOption()
{
	self.menu["index"]--;
	if (self.menu["index"] < 0)
	{
		self.menu["index"] = self.menu["options"].size - 1;
	}
	self.menu["select_bar"] affectElement("y", 0.1, 22.4 + (self.menu["index"] * 14.4));
	wait 0.1;
}

handleMenu()
{
	level endon("game_ended");
	self endon("disconnect");
	for (;;)
	{
		if (isDefined(self.menu["status"]))
		{
			if (self.menu["status"])
			{
				if (self meleeButtonPressed())
				{
					self hideMenu();
				}
				else if (!(self ActionSlotOneButtonPressed() && self attackbuttonpressed()) && (self ActionSlotOneButtonPressed() || self attackbuttonpressed()))
				{
					self goToNextOption();
				}
				else if (!(self ActionSlotTwoButtonPressed() && self attackbuttonpressed()) && (self ActionSlotTwoButtonPressed() || self adsbuttonpressed()))
				{
					self goToPreviusOption();
				}
				else if (self UseButtonPressed())
				{
					index = self.menu["index"];
					[[self.menu ["options"] [index].invoke]] (self.menu["options"][index].args);
					wait 0.4;
				}
				else if (self StanceButtonPressed())
				{
					self goToTheParent();
					wait 0.5;
				}
			}
			else
			{
				if (self meleeButtonPressed() && self AdsButtonPressed())
				{
					if (self.menu["page"] == "")
					{
						openSubmenu("default");
					}
					else
					{
						openSubmenu(self.menu["page"]);
					}
					self showMenu();
					wait 0.5;
				}
			}
		}
		wait 0.05;
	}
}

addOption(lvl, parent, option, function, args)
{
	if (self.__vars["level"] >= lvl)
	{
		i = self.menu["options"].size;
		self.menu["options"][i] = spawnStruct();
		self.menu["options"][i].page = self.menu["page"];
		self.menu["options"][i].parent = parent;
		self.menu["options"][i].label = option;
		self.menu["options"][i].invoke = function;
		self.menu["options"][i].args = args;
		self.menu["ui_options_string"] = self.menu["ui_options_string"] + "^7\n" + self.menu["options"][i].label;
	}
}

goToTheParent()
{
	if (!isInteger(self.menu["page"]) && self.menu["page"] == self.menu["options"][self.menu["index"]].parent)
	{
		self hideMenu();
		return;
	}
	self.menu["page"] = self.menu["options"][self.menu["index"]].parent;
	buildOptions();

	if (self.menu["index"] > self.menu["options"].size - 1)
	{
		self.menu["index"] = 0;
	}
	if (self.menu["index"] < 0)
	{
		self.menu["index"] = self.menu["options"].size - 1;
	}
	self.menu["select_bar"] affectElement("y", 0.1, 22.4 + (self.menu["index"] * 14.4));

	self.menu["ui_credits"] affectElement("y", 0.12, -170 + (self.menu["options"].size * 14.4 + 5));
	self.menu["bottom_bar"] affectElement("y", 0.12, (self.menu["options"].size * 14.4) + 30);
	wait 0.1;
	self.menu["background"] setShader("black", 125, 70 + int(self.menu["options"].size / 2) + (self.menu["options"].size * 14));

	self.menu["ui_options"] setText(self.menu["ui_options_string"]);
	if (self.menu["index"] > self.menu["options"].size - 1)
	{
		self.menu["index"] = 0;
	}
	if (self.menu["index"] < 0)
	{
		self.menu["index"] = self.menu["options"].size - 1;
	}
}

openSubmenu(page)
{
	self.menu["page"] = page;
	self.menu["index"] = 0;
	self.menu["select_bar"] affectElement("y", 0.1, 22.4 + (self.menu["index"] * 14.4));
	buildOptions();

	self.menu["ui_credits"] affectElement("y", 0.12, -170 + (self.menu["options"].size * 14.4 + 5));
	self.menu["bottom_bar"] affectElement("y", 0.12, (self.menu["options"].size * 14.4) + 30);
	wait 0.1;
	self.menu["background"] setShader("black", 125, 70 + int(self.menu["options"].size / 2) + (self.menu["options"].size * 14));

	self.menu["ui_options"] setText(self.menu["ui_options_string"]);
}

buildOptions()
{
	if ((self.menu["options"].size == 0) || (self.menu["options"].size > 0 && self.menu["options"][0].page != self.menu["page"]))
	{
		self.menu["ui_options_string"] = "";
		self.menu["options"] = [];
		switch (self.menu["page"])
		{
		case "players":
			for (i = 0; i < level.players.size; i++)
			{
				player = level.players[i];
				addOption(2, "default", player.name, ::openSubmenu, i + 1);
			}
			break;
		case "scorestreaks":
			addOption(0, "default", "Scorestreaks", ::giveScoreStreaks);
			addOption(0, "default", "Give RC-XD", ::giveScorestreak, "rcbomb_mp;RC-XD");
			addOption(0, "default", "Give UAV", ::giveScorestreak, "radar_mp;UAV");
			addOption(0, "default", "Give carepackage", ::giveScorestreak, "inventory_supply_drop_mp;Supply Drop");
			break;
		case "trickshot":
			// addOption("default", "Random TS Class", ::testFunc);
			addOption(0, "default", "^2Set ^7Spawn", ::SetSpawn);
			addOption(0, "default", "^1Clear ^7Spawn", ::ClearSpawn);
			addOption(0, "default", "Teleport to Spawn", ::LoadSpawn);
			if (!level.teambased || getDvar("g_gametype") == "tdm")
			{
				addOption(1, "default", "Fastlast", ::doFastLast);
				addOption(1, "default", "Fastlast 2 pieces", ::doFastLast2Pieces);
				// addOption(1, "default", "UFO", ::JoinUFO);
			}
			addOption(0, "default", "Drop weapon", ::dropCurrentWeapon);
			addOption(0, "default", "Canswap", ::dropCanswap);
			addOption(0, "default", "S&L Buttons", ::handleSNLChangeBtn);
			addOption(0, "default", "Suicide", ::kys);
			break;
		case "dlcmaps":
			mapsdata = getMapsData();
			addOption(2, "maps", "Nuketown 2025", ::changeMap, mapsdata["mp_nuketown_2020"].mapid);
			addOption(2, "maps", "Downhill", ::changeMap, mapsdata["mp_downhill"].mapid);
			addOption(2, "maps", "Mirage", ::changeMap, mapsdata["mp_mirage"].mapid);
			addOption(2, "maps", "Hydro", ::changeMap, mapsdata["mp_hydro"].mapid);
			addOption(2, "maps", "Grind", ::changeMap, mapsdata["mp_skate"].mapid);
			addOption(2, "maps", "Encore", ::changeMap, mapsdata["mp_concert"].mapid);
			addOption(2, "maps", "Magma", ::changeMap, mapsdata["mp_magma"].mapid);
			addOption(2, "maps", "Vertigo", ::changeMap, mapsdata["mp_vertigo"].mapid);
			addOption(2, "maps", "Studio", ::changeMap, mapsdata["mp_studio"].mapid);
			addOption(2, "maps", "Uplink", ::changeMap, mapsdata["mp_uplink"].mapid);
			addOption(2, "maps", "Detour", ::changeMap, mapsdata["mp_bridge"].mapid);
			addOption(2, "maps", "Cove", ::changeMap, mapsdata["mp_castaway"].mapid);
			addOption(2, "maps", "Rush", ::changeMap, mapsdata["mp_dig"].mapid);
			addOption(2, "maps", "Frost", ::changeMap, mapsdata["mp_frostbite"].mapid);
			addOption(2, "maps", "Pod", ::changeMap, mapsdata["mp_pod"].mapid);
			addOption(2, "maps", "Takeoff", ::changeMap, mapsdata["mp_takeoff"].mapid);
			break;
		case "maps":
			mapsdata = getMapsData();
			addOption(2, "default", "DLC", ::openSubmenu, "dlcmaps");
			addOption(2, "default", "Aftermath", ::changeMap, mapsdata["mp_la"].mapid);
			addOption(2, "default", "Meltdown", ::changeMap, mapsdata["mp_meltdown"].mapid);
			addOption(2, "default", "Overflow", ::changeMap, mapsdata["mp_overflow"].mapid);
			addOption(2, "default", "Plaza", ::changeMap, mapsdata["mp_nightclub"].mapid);
			addOption(2, "default", "Cargo", ::changeMap, mapsdata["mp_dockside"].mapid);
			addOption(2, "default", "Carrier", ::changeMap, mapsdata["mp_carrier"].mapid);
			addOption(2, "default", "Drone", ::changeMap, mapsdata["mp_drone"].mapid);
			addOption(2, "default", "Express", ::changeMap, mapsdata["mp_express"].mapid);
			addOption(2, "default", "Hijacked", ::changeMap, mapsdata["mp_hijacked"].mapid);
			addOption(2, "default", "Raid", ::changeMap, mapsdata["mp_raid"].mapid);
			addOption(2, "default", "Slums", ::changeMap, mapsdata["mp_slums"].mapid);
			addOption(2, "default", "Standoff", ::changeMap, mapsdata["mp_village"].mapid);
			addOption(2, "default", "Turbine", ::changeMap, mapsdata["mp_turbine"].mapid);
			addOption(2, "default", "Yemen", ::changeMap, mapsdata["mp_socotra"].mapid);
			addOption(2, "default", "Cargo", ::changeMap, mapsdata["mp_dockside"].mapid);
			break;
		case "teleports":
			mapname = getDvar("mapname");
			switch (mapname)
			{
			case "mp_nuketown_2020":
				addOption(0, "default", "Blue house roof", ::teleportto, (555, 477, 185));
				addOption(0, "default", "Green house roof", ::teleportto, (-1868, 1059, 75));
				addOption(0, "default", "Orange house handrail", ::teleportto, (-1179, 774, 115));
				addOption(0, "default", "Blue house handrail", ::teleportto, (1222, 532, 115));
				addOption(0, "default", "Blue house window ledge", ::teleportto, (484, 278, 87));
				addOption(0, "default", "Orange house window ledge", ::teleportto, (-434, 383, 75));
				break;
			case "mp_la":
				addOption(0, "default", "Out of map Car park", ::teleportto, (-1021, -2102, 115));
				break;
			case "mp_dockside":
				addOption(0, "default", "Out of map spot #1", ::teleportto, (-2167, 4482, 228));
				addOption(0, "default", "Docks Close in", ::teleportto, (-3189, 2976, -60));
				addOption(0, "default", "Docks Far out", ::teleportto, (-8475, 2974, -61));
				addOption(0, "default", "Container", ::teleportto, (-484, 456, 66));
				addOption(0, "default", "Spawn Back drop sui", ::teleportto, (434, -989, 69));
				addOption(0, "default", "Back drop sui", ::teleportto, (-1849, 1386, -60));
				addOption(0, "default", "Back drop", ::teleportto, (-1258, 2213, 68));
				addOption(0, "default", "Sui spot", ::teleportto, (-1841, 2548, -61));
				break;
			case "mp_carrier":
				addOption(0, "default", "Out of map spot #1", ::teleportto, (-2875, 1189, -65));
				addOption(0, "default", "1800 Spot", ::teleportto, (-6387, -741, 39));
				addOption(0, "default", "Top Of Jets", ::teleportto, (-5171, -817, 156));
				addOption(0, "default", "Ramp", ::teleportto, (-3227, 339, 114));
				addOption(0, "default", "Side of the Ship", ::teleportto, (-4095, -1945, -39));
				addOption(0, "default", "Back of the Ship", ::teleportto, (-5066, 1303, 44));
				break;
			case "mp_turbine":
				addOption(0, "default", "Out of map spot #1", ::teleportto, (-1291, -3218, 454));
				addOption(0, "default", "Inside Turbine", ::teleportto, (-850, 1474, 832));
				addOption(0, "default", "Top of Turbine", ::teleportto, (324, 803, 501));
				addOption(0, "default", "Top of Bridge", ::teleportto, (843, 3142, 230));
				addOption(0, "default", "Turret Room", ::teleportto, (1755, 2315, 210));
				addOption(0, "default", "Machine Room", ::teleportto, (-457, 1624, 457));
				addOption(0, "default", "Rock", ::teleportto, (637, -1392, 442));
				break;
			case "mp_raid":
				addOption(0, "default", "Out of map spot #1", ::teleportto, (-210, 3449, 259));
				addOption(0, "default", "Roof Slide", ::teleportto, (2784, 4458, 385));
				addOption(0, "default", "Main spot", ::teleportto, (2893, 4341, 148));
				addOption(0, "default", "Red Statue", ::teleportto, (2360, 1720, 193));
				addOption(0, "default", "Palm Tree", ::teleportto, (2712, 4764, 137));
				break;
			case "mp_drone":
				addOption(0, "default", "Out of map spot #1", ::teleportto, (2938, 715, 762));
				addOption(0, "default", "Rocks Spawnshot", ::teleportto, (78, 2840, 343));
				addOption(0, "default", "Helicopter", ::teleportto, (-173, -1072, 240));
				addOption(0, "default", "Mid map ledge", ::teleportto, (115, 1154, 267));
				addOption(0, "default", "Drone Parking", ::teleportto, (-5854, -748, 80));
				break;
			case "mp_socotra":
				addOption(0, "default", "Out of map spot", ::teleportto, (705, 2923, 1189));
				addOption(0, "default", "Ladder Balcony", ::teleportto, (33, 1408, 414));
				addOption(0, "default", "Mid map hole", ::teleportto, (183, -186, 165));
				addOption(0, "default", "Mid map hole high", ::teleportto, (381, 361, 246));
				addOption(0, "default", "Back of the map", ::teleportto, (-81, -2216, 241));
				addOption(0, "default", "High Balcony", ::teleportto, (1053, 771, 283));
				addOption(0, "default", "Inside building backdrop", ::teleportto, (-608, -1018, 424));
				break;
			case "mp_village":
				addOption(0, "default", "Out of map spot #1", ::teleportto, (-1983, -1020, 234));
				addOption(0, "default", "Out of map spot #2", ::teleportto, (-1389, 3736, 280));
				addOption(0, "default", "Window Shot #1", ::teleportto, (-240, 1073, 142));
				addOption(0, "default", "Window Shot #2", ::teleportto, (1096, 686, 144));
				addOption(0, "default", "Window Shot #3", ::teleportto, (-974, -1512, 144));
				addOption(0, "default", "Main spot", ::teleportto, (-1236, -1067, 153));
				addOption(0, "default", "Mid Balcony", ::teleportto, (56, -405, 164));
				break;
			case "mp_studio":
				addOption(0, "default", "Out of map spot #1", ::teleportto, (578, -1199, 219));
				addOption(0, "default", "Top of Castle", ::teleportto, (1211, 1449, 94));
				addOption(0, "default", "Top of Tower", ::teleportto, (449, 1009, 194));
				addOption(0, "default", "Wooden Barn", ::teleportto, (-69, 1256, 96));
				break;
			case "mp_vertigo":
				addOption(0, "default", "Spawn ledge #1", ::teleportto, (217, 3236, -20));
				addOption(0, "default", "Spawn ledge #2", ::teleportto, (-141, -3078, -35));
				addOption(0, "default", "Ladder spot", ::teleportto, (891, 8, 104));
				addOption(0, "default", "Mid map Hole", ::teleportto, (-211, 3, 8));
				break;
			}
			break;
		case "default":
		default:
			if (isInteger(self.menu["page"]))
			{
				pIndex = int(self.menu["page"]) - 1;
				if (isDefined(level.players[pIndex].pers["isBot"]) && level.players[pIndex].pers["isBot"])
				{
					addOption(2, "players", "Freeze", ::freeze, level.players[pIndex]);
					addOption(2, "players", "Unfreeze", ::unfreeze, level.players[pIndex]);
				}
				addOption(2, "players", "Teleport to", ::teleportto, level.players[pIndex]);
				addOption(2, "players", "Teleport me", ::teleportme, level.players[pIndex]);
			}
			else
			{
				if (self.menu["page"] == "")
				{
					self.menu["page"] = "default";
				}
				addOption(0, "default", "Trickshot", ::openSubmenu, "trickshot");
				addOption(0, "default", "Scorestreaks", ::openSubmenu, "scorestreaks");
				addOption(0, "default", "Teleports", ::openSubmenu, "teleports");
				addOption(2, "default", "Players", ::openSubmenu, "players");
				addOption(2, "default", "Maps", ::openSubmenu, "maps");
			}
			break;
		}
	}
}

changeMap(mapid)
{
	// Do not work on private matches
	IPrintLn("Changing map in ^3" + mapid + " ^7in 3 sec");
	wait 0.2;
	IPrintLn("Changing in ^33^7!");
	wait 1;
	IPrintLn("Changing in ^32^7!");
	wait 1;
	IPrintLn("Changing in ^31^7!");
	wait 1;
	setDvar("ls_mapname", mapid);
	setDvar("mapname", mapid);
	setDvar("party_mapname", mapid);
	setDvar("ui_mapname", mapid);
	setDvar("ui_currentMap", mapid);
	setDvar("ui_mapname", mapid);
	setDvar("ui_preview_map", mapid);
	setDvar("ui_showmap", mapid);

	SetDvar("sv_maprotationcurrent", "map " + mapid);
	SetDvar("sv_maprotation", "map " + mapid);

	map(mapid, true);
	// exitlevel( 0 );
}
testFunc()
{
	precachemodel("dest_nt_nuked_female_05");
	collision = spawn("script_model", self.origin);
	collision setmodel("dest_nt_nuked_female_05");
	collision.angles = self.angles;

	self iPrintLn("DoktorSAS!");
}