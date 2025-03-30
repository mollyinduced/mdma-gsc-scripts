/*
Color Codes:

^1 - RED 
^2 - GREEN 
^3 - YELLOW 
^4 - BLUE 
^5 - CYAN 
^6 - PINK 
^7 - WHITE 
^8 - DEFAULT MAP COLOR 
^9 - GREY OR DEFAULT MAP COLOR 
^0 - BLACK 
^; - YALE BLUE 
^: - LIGHT YELLOW
*/


getOptions() //this is where we put our options; notice the format!
{
	self endon("disconnect");
	
	//Here is an example of how to add a new option
	/*
	num = 0; <-- always reset to 0 after every new menu
	m = "Host Menu"; <-- name of the menu we're adding options to

	options[m][num]["parent"] = m; <-- our parent menu, which in this case is Host Menu (will always be 'm')
	options[m][num]["Selected"] = "{ ^4Freeze Lobby^7 }"; <-- this is what will show up, if the text is SELECTED
	options[m][num]["NotSelected"] = "^7Freeze Lobby"; <-- this is what will show up, if the text is NOT SELECTED
	options[m][num]["func"] = ::test; <--- our function to call
	options[m][num]["input1"] = "" <-- parameter 1
	options[m][num]["input2"] = "" <-- parameter 2
	options[m][num]["input3"] = "" <-- parameter 3
	num++; <--add +1 to our current num
	
	Now let me show you an example of an option that is toggable:
	
	options[m][num]["parent"] = m; <-- our parent menu, which in this case is Host Menu (will always be 'm')
	options[m][num]["Selected"] = "{ ^4Test Toggle ^7[" + getBooleanStatus(self.testvar) + "^7] }"; <-- this is what will show up, if the text is SELECTED
	options[m][num]["NotSelected"] = "^7Test Toggle [" + getBooleanStatus(self.testvar) + "^7]"; <-- this is what will show up, if the text is NOT SELECTED
	options[m][num]["func"] = ::test; <--- our function to call
	options[m][num]["input1"] = "" <-- parameter 1
	options[m][num]["input2"] = "" <-- parameter 2
	options[m][num]["input3"] = "" <-- parameter 3
	num++; <--add +1 to our current num
	
	Get it?
	PM me if you need help adding options, or have questions. I'll be glad to help! :)
	
	*/
	
	options = []; //array only needs to be defined once
	
	num = 0;
	m = "Host Menu";

	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Freeze Lobby^7 }";
	options[m][num]["NotSelected"] = "^7Freeze Lobby";
	options[m][num]["func"] = ::freezeallplayers;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Unfreeze Lobby^7 }";
	options[m][num]["NotSelected"] = "^7Unfreeze Lobby";
	options[m][num]["func"] = ::unfreezeallplayers;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verification Menu^7 }";
	options[m][num]["NotSelected"] = "^0Verification Menu";
	options[m][num]["func"] = ::callMenu;
	options[m][num]["input1"] = "Verification Menu";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4XP Lobby^7 }";
	options[m][num]["NotSelected"] = "^7XP Lobby";
	options[m][num]["func"] = ::giveallxp;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Force Host ^7[" + getBooleanStatus(self.forcehost) + "^7] }";
	options[m][num]["NotSelected"] = "^7Force Host [" + getBooleanStatus(self.forcehost) + "^7]";
	options[m][num]["func"] = ::forceHost;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Anti Join ^7[" + getBooleanStatus(level.antijoin) + "^7] }";
	options[m][num]["NotSelected"] = "^7Anti Join [" + getBooleanStatus(level.antijoin) + "^7]";
	options[m][num]["func"] = ::antijoin;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Anti Quit ^7[" + getBooleanStatus(level.antiquit) + "^7] }";
	options[m][num]["NotSelected"] = "^7Anti Quit [" + getBooleanStatus(level.antiquit) + "^7]";
	options[m][num]["func"] = ::toggleAntiQuit;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Unlimited Time ^7[" + getBooleanStatus(level.unlimtime) + "^7] }";
	options[m][num]["NotSelected"] = "^7Unlimited Time [" + getBooleanStatus(level.unlimtime) + "^7]";
	options[m][num]["func"] = ::unlimtime;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4End Game^7 }";
	options[m][num]["NotSelected"] = "^7End Game";
	options[m][num]["func"] = ::endgame;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Restart^7 }";
	options[m][num]["NotSelected"] = "^7Restart";
	options[m][num]["func"] = ::restart;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Host Only Super Jump ^7[" + getBooleanStatus(self.hostonlyjump) + "^7] }";
	options[m][num]["NotSelected"] = "^7Host Only Super Jump [" + getBooleanStatus(self.hostonlyjump) + "^7]";
	options[m][num]["func"] = ::hostonlyjump;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Auto Drop Shot ^7[" + getBooleanStatus(self.dropshot) + "^7] }";
	options[m][num]["NotSelected"] = "^7Auto Drop Shot [" + getBooleanStatus(self.dropshot) + "^7]";
	options[m][num]["func"] = ::autodropshot;
	num++;
	
	num = 0;
	m = "Game Settings Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Super Jump ^7[" + getBooleanStatus(level.jump) + "^7] }";
	options[m][num]["NotSelected"] = "^7Super Jump [" + getBooleanStatus(level.jump) + "^7]";
	options[m][num]["func"] = ::superjump;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Super Speed ^7[" + getBooleanStatus(level.speed) + "^7] }";
	options[m][num]["NotSelected"] = "^7Super Speed [" + getBooleanStatus(level.speed) + "^7]";
	options[m][num]["func"] = ::superspeed;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Fast Timescale ^7[" + getBooleanStatus(level.timescale) + "^7] }";
	options[m][num]["NotSelected"] = "^7Fast Timescale [" + getBooleanStatus(level.timescale) + "^7]";
	options[m][num]["func"] = ::ToggleTimeScale;
	options[m][num]["input1"] = "fast";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Slow Timescale ^7[" + getBooleanStatus(level.timescale) + "^7] }";
	options[m][num]["NotSelected"] = "^7Slow Timescale [" + getBooleanStatus(level.timescale) + "^7]";
	options[m][num]["func"] = ::ToggleTimeScale;
	options[m][num]["input1"] = "slow";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Change Team^7 }";
	options[m][num]["NotSelected"] = "^7Change Team";
	options[m][num]["func"] = ::doTeamChange;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Change Class^7 }";
	options[m][num]["NotSelected"] = "^7Change Class";
	options[m][num]["func"] = ::ChangeClass;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4God Mode ^7[" + getBooleanStatus(self.godmode) + "^7] }";
	options[m][num]["NotSelected"] = "^7God Mode [" + getBooleanStatus(self.godmode) + "^7]";
	options[m][num]["func"] = ::godmode;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4No Fall Damage ^7[" + getBooleanStatus(level.falldamage) + "^7] }";
	options[m][num]["NotSelected"] = "^7No Fall Damage [" + getBooleanStatus(level.falldamage) + "^7]";
	options[m][num]["func"] = ::dofalldamage;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Bot Settings Menu ^7}";
	options[m][num]["NotSelected"] = "^0Bot Settings Menu";
	options[m][num]["func"] = ::callMenu;
	options[m][num]["input1"] = "Bot Settings Menu";
	num++;
	
	
	num = 0;
	m = "Infections Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Long Killcam ^7[" + getBooleanStatus(self.killcam) + "^7] }";
	options[m][num]["NotSelected"] = "^7Long Killcam [" + getBooleanStatus(self.killcam) + "^7]";
	options[m][num]["func"] = ::longkillcam;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Super Reload ^7[" + getBooleanStatus(self.superreload) + "^7] }";
	options[m][num]["NotSelected"] = "^7Super Reload [" + getBooleanStatus(self.superreload) + "^7]";
	options[m][num]["func"] = ::superreload;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Knockback Lobby ^7[" + getBooleanStatus(level.knock) + "^7] }";
	options[m][num]["NotSelected"] = "^7Knockback Lobby [" + getBooleanStatus(level.knock) + "^7]";
	options[m][num]["func"] = ::knock;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Sky Color ^7[" + getBooleanStatus(level.skycolor) + "^7] }";
	options[m][num]["NotSelected"] = "^7Sky Color [" + getBooleanStatus(level.skycolor) + "^7]";
	options[m][num]["func"] = ::DoSky;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Left Sided Gun ^7[" + getBooleanStatus(self.leftgun) + "^7] }";
	options[m][num]["NotSelected"] = "^7Left Sided Gun [" + getBooleanStatus(self.leftgun) + "^7]";
	options[m][num]["func"] = ::ToggleLeft;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Big Names ^7[" + getBooleanStatus(self.bignames) + "^7] }";
	options[m][num]["NotSelected"] = "^7Big Names [" + getBooleanStatus(self.bignames) + "^7]";
	options[m][num]["func"] = ::dobig;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Flashing Low Ammo ^7[" + getBooleanStatus(self.flashammo) + "^7] }";
	options[m][num]["NotSelected"] = "^7Flashing Low Ammo [" + getBooleanStatus(self.flashammo) + "^7]";
	options[m][num]["func"] = ::flashlowammo;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Crosshair Plus ^7[" + getBooleanStatus(self.crosshair) + "^7] }";
	options[m][num]["NotSelected"] = "^7Crosshair Plus [" + getBooleanStatus(self.crosshair) + "^7]";
	options[m][num]["func"] = ::togglecrosshair;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Names Through Walls ^7[" + getBooleanStatus(self.names) + "^7] }";
	options[m][num]["NotSelected"] = "^7Names Through Walls [" + getBooleanStatus(self.names) + "^7]";
	options[m][num]["func"] = ::NAMESTHROUGHWALLS;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Invisible Gun ^7[" + getBooleanStatus(self.invisiblegun) + "^7] }";
	options[m][num]["NotSelected"] = "^7Invisible Gun [" + getBooleanStatus(self.invisiblegun) + "^7]";
	options[m][num]["func"] = ::invisiblegun;
	num++;
	
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Across Map Weapons ^7[" + getBooleanStatus(self.across) + "^7] }";
	options[m][num]["NotSelected"] = "^7Across Map Weapons [" + getBooleanStatus(self.across) + "^7]";
	options[m][num]["func"] = ::acrossweapons;
	num++;
	
	num = 0;
	m = "Fun Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Infinite Ammo ^7[" + getBooleanStatus(self.infammo) + "^7] }";
	options[m][num]["NotSelected"] = "^7Infinite Ammo [" + getBooleanStatus(self.infammo) + "^7]";
	options[m][num]["func"] = ::infammo;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4UAV ^7[" + getBooleanStatus(self.uav) + "^7] }";
	options[m][num]["NotSelected"] = "^7UAV [" + getBooleanStatus(self.uav) + "^7]";
	options[m][num]["func"] = ::toggleUAV;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Wallhack ^7[" + getBooleanStatus(self.wallhack) + "^7] }";
	options[m][num]["NotSelected"] = "^7Wallhack [" + getBooleanStatus(self.wallhack) + "^7]";
	options[m][num]["func"] = ::toggleWallhack;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Chat Freely ^7[" + getBooleanStatus(level.chat) + "^7] }";
	options[m][num]["NotSelected"] = "^7Chat Freely [" + getBooleanStatus(level.chat) + "^7]";
	options[m][num]["func"] = ::hearallplayers;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Show FPS ^7[" + getBooleanStatus(self.fps) + "^7] }";
	options[m][num]["NotSelected"] = "^7Show FPS [" + getBooleanStatus(self.fps) + "^7]";
	options[m][num]["func"] = ::ShowFPS;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Stalker Pro ^7[" + getBooleanStatus(self.stalkerMode) + "^7] }";
	options[m][num]["NotSelected"] = "^7Stalker Pro [" + getBooleanStatus(self.stalkerMode) + "^7]";
	options[m][num]["func"] = ::stalkerMode;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Super Knife ^7[" + getBooleanStatus(level.melee) + "^7] }";
	options[m][num]["NotSelected"] = "^7Super Knife [" + getBooleanStatus(level.melee) + "^7]";
	options[m][num]["func"] = ::meleerange;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Third Person ^7[" + getBooleanStatus(self.thirdperson) + "^7] }";
	options[m][num]["NotSelected"] = "^7Third Person [" + getBooleanStatus(self.thirdperson) + "^7]";
	options[m][num]["func"] = ::ThirdPerson;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Aim Assist Menu ^7}";
	options[m][num]["NotSelected"] = "^0Aim Assist Menu";
	options[m][num]["func"] = ::callMenu;
	options[m][num]["input1"] = "Aim Assist Menu";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Vision Menu ^7}";
	options[m][num]["NotSelected"] = "^0Vision Menu";
	options[m][num]["func"] = ::callMenu;
	options[m][num]["input1"] = "Vision Menu";
	num++;
	
	num = 0;
	m = "Account Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Get 60,000 XP ^7}";
	options[m][num]["NotSelected"] = "^7Get 60,000 XP";
	options[m][num]["func"] = ::givexp;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Unlock All Camos ^7}";
	options[m][num]["NotSelected"] = "^7Unlock All Camos";
	options[m][num]["func"] = ::UnlockCamos;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Suicide ^7}";
	options[m][num]["NotSelected"] = "^7Suicide";
	options[m][num]["func"] = ::dosuicide;
	num++;
	
	num = 0;
	m = "Messages Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Welcome ^7}";
	options[m][num]["NotSelected"] = "^7Welcome";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^6Welcome to ^0" + getPlayerName(self) + "^6's Hacked Lobby";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verified ^7}";
	options[m][num]["NotSelected"] = "^7Verified";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^6In order to get ^0Verified ^6you have to pay!";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4$5 PayPal ^7}";
	options[m][num]["NotSelected"] = "^7$5 PayPal";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^6It's $5 PayPal. Message ^0" + getPlayerName(self) + " for more info!";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4LOL ^7}";
	options[m][num]["NotSelected"] = "^7LOL";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^6LOL KID! Are you ^0stupid?";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Bye ^7}";
	options[m][num]["NotSelected"] = "^7Bye";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^0Bye";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Add you If ^7}";
	options[m][num]["NotSelected"] = "^7Add you If";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^0Only ^6add me if you are willing to pay!";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4One & Only ^7}";
	options[m][num]["NotSelected"] = "^7One & Only";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^6The One & Only ^0UnboundUser^6!";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Yes ^7}";
	options[m][num]["NotSelected"] = "^7Yes";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^6Yes!";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4No ^7}";
	options[m][num]["NotSelected"] = "^7No";
	options[m][num]["func"] = ::domessage;
	options[m][num]["input1"] = "^6No!";
	num++;
	
	num = 0;
	m = "Airdrop/Killstreak Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give All Killstreaks ^7}";
	options[m][num]["NotSelected"] = "^7Give All Killstreaks";
	options[m][num]["func"] = ::doKillstreaks;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give UAV ^7}";
	options[m][num]["NotSelected"] = "^7Give UAV";
	options[m][num]["func"] = ::GiveUAV;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give RC-Car ^7}";
	options[m][num]["NotSelected"] = "^7Give RC-Car";
	options[m][num]["func"] = ::GiveRC;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Hunter Killer Drone ^7}";
	options[m][num]["NotSelected"] = "^7Give Hunter Killer Drone";
	options[m][num]["func"] = ::GiveHunt;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Care Package ^7}";
	options[m][num]["NotSelected"] = "^7Give Care Package";
	options[m][num]["func"] = ::GiveCare;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Counter UAV ^7}";
	options[m][num]["NotSelected"] = "^7Give Counter UAV";
	options[m][num]["func"] = ::GiveCUAV;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Guardian ^7}";
	options[m][num]["NotSelected"] = "^7Give Guardian";
	options[m][num]["func"] = ::GiveGuard;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Hellstorm Missle ^7}";
	options[m][num]["NotSelected"] = "^7Give Hellstorm Missle";
	options[m][num]["func"] = ::GiveHell;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Lightning Strike ^7}";
	options[m][num]["NotSelected"] = "^7Give Lightning Strike";
	options[m][num]["func"] = ::GiveLS;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Sentry Gun ^7}";
	options[m][num]["NotSelected"] = "^7Give Sentry Gun";
	options[m][num]["func"] = ::GiveSG;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give AGR^7}";
	options[m][num]["NotSelected"] = "^7Give AGR";
	options[m][num]["func"] = ::GiveAG;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Stealth Chopper ^7}";
	options[m][num]["NotSelected"] = "^7Give Stealth Chopper";
	options[m][num]["func"] = ::GiveSC;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give VSAT ^7}";
	options[m][num]["NotSelected"] = "^7Give VSAT";
	options[m][num]["func"] = ::GiveVSAT;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Escort Drone ^7}";
	options[m][num]["NotSelected"] = "^7Give Escort Drone";
	options[m][num]["func"] = ::GiveED;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give EMP ^7}";
	options[m][num]["NotSelected"] = "^7Give EMP";
	options[m][num]["func"] = ::GiveEMP;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Warthog ^7}";
	options[m][num]["NotSelected"] = "^7Give Warthog";
	options[m][num]["func"] = ::GiveWH;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Lodestar ^7}";
	options[m][num]["NotSelected"] = "^7Give Lodestar";
	options[m][num]["func"] = ::GiveLST;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give VTOL Warship ^7}";
	options[m][num]["NotSelected"] = "^7Give VTOL Warship";
	options[m][num]["func"] = ::GiveVW;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Dogs ^7}";
	options[m][num]["NotSelected"] = "^7Give Dogs";
	options[m][num]["func"] = ::GiveDogs;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Give Swarm ^7}";
	options[m][num]["NotSelected"] = "^7Give Swarm";
	options[m][num]["func"] = ::GiveSwarm;
	num++;
	
	num = 0;
	m = "Search & Destroy Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Plant Bomb ^7}";
	options[m][num]["NotSelected"] = "^7Plant Bomb";
	options[m][num]["func"] = ::PlantBomb;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Defuse Bomb ^7}";
	options[m][num]["NotSelected"] = "^7Defuse Bomb";
	options[m][num]["func"] = ::DefuseBomb;
	num++;
	
	num = 0;
	m = "Martyrdom Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Grenade ^7}";
	options[m][num]["NotSelected"] = "^7Grenade";
	options[m][num]["func"] = ::setmartyrdom;
	options[m][num]["input1"] = "m32_mp";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4RPG Explosion ^7}";
	options[m][num]["NotSelected"] = "^7RPG Explosion";
	options[m][num]["func"] = ::setmartyrdom;
	options[m][num]["input1"] = "usrpg_mp";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Smaw Rocket ^7}";
	options[m][num]["NotSelected"] = "^7Smaw Rocket";
	options[m][num]["func"] = ::setmartyrdom;
	options[m][num]["input1"] = "smaw_mp";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Swarm Drone ^7}";
	options[m][num]["NotSelected"] = "^7Swarm Drone";
	options[m][num]["func"] = ::setmartyrdom;
	options[m][num]["input1"] = "missile_swarm_projectile_mp";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Mortar Missile ^7}";
	options[m][num]["NotSelected"] = "^7Mortar Missile";
	options[m][num]["func"] = ::setmartyrdom;
	options[m][num]["input1"] = "remote_missile_bomblet_mp";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Strafe Run Rocket ^7}";
	options[m][num]["NotSelected"] = "^7Strafe Run Rocket";
	options[m][num]["func"] = ::setmartyrdom;
	options[m][num]["input1"] = "straferun_rockets_mp";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4AGR Rocket ^7}";
	options[m][num]["NotSelected"] = "^7AGR Rocket";
	options[m][num]["func"] = ::setmartyrdom;
	options[m][num]["input1"] = "ai_tank_drone_rocket_mp";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Disable Martyrdom ^7}";
	options[m][num]["NotSelected"] = "^7Disable Martyrdom";
	options[m][num]["func"] = ::setmartyrdom;
	options[m][num]["input1"] = "";
	num++;
	
	num = 0;
	m = "Perk Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Clear Perks ^7}";
	options[m][num]["NotSelected"] = "^7Clear Perks";
	options[m][num]["func"] = ::clearperks_self;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4All Perks ^7}";
	options[m][num]["NotSelected"] = "^7All Perks";
	options[m][num]["func"] = ::doPerks;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Explosive Bullets ^7[" + getBooleanStatus(self.explobullets) + "] ^7}";
	options[m][num]["NotSelected"] = "^7Explosive Bullets [" + getBooleanStatus(self.explobullets) + "^7]";
	options[m][num]["func"] = ::explobullets;
	num++;
	
	num = 0;
	m = "Maps Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Aftermath ^7}";
	options[m][num]["NotSelected"] = "^7Aftermath";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_la";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Cargo ^7}";
	options[m][num]["NotSelected"] = "^7Cargo";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_dockside";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Carrier ^7}";
	options[m][num]["NotSelected"] = "^7Carrier";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_carrier";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Drone ^7}";
	options[m][num]["NotSelected"] = "^7Drone";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_express";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Express ^7}";
	options[m][num]["NotSelected"] = "^7Express";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_express";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Hijacked ^7}";
	options[m][num]["NotSelected"] = "^7Hijacked";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_hijacked";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Meltdown ^7}";
	options[m][num]["NotSelected"] = "^7Meltdown";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_meltdown";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Nuketown ^7}";
	options[m][num]["NotSelected"] = "^7Nuketown";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_nuketown_2020";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Overflow ^7}";
	options[m][num]["NotSelected"] = "^7Overflow";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_overflow";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Plaza ^7}";
	options[m][num]["NotSelected"] = "^7Plaza";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_nightclub";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Raid ^7}";
	options[m][num]["NotSelected"] = "^7Raid";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_raid";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Slums ^7}";
	options[m][num]["NotSelected"] = "^7Slums";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_slums";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Standoff ^7}";
	options[m][num]["NotSelected"] = "^7Standoff";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_village";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Turbine ^7}";
	options[m][num]["NotSelected"] = "^7Turbine";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_turbine";
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Yemen ^7}";
	options[m][num]["NotSelected"] = "^7Yemen";
	options[m][num]["func"] = ::changemap;
	options[m][num]["input1"] = "mp_socotra";
	num++;
	
	num = 0;
	m = "Kick Menu";
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]) + "^7 }";
	options[m][num]["NotSelected"] = "^7Kick Client " + (num + 1) + " - " + getPlayerName(level.players[num + 1]);
	options[m][num]["func"] = ::kickclient;
	options[m][num]["input1"] = num + 1;
	num++;

	
	
	//here is where we add our sub menus, you can put them anywhere, but I do this so it can be organized
	
	num = 0;
	m = "Verification Menu";

	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify YouViolateMe ^7}";
	options[m][num]["NotSelected"] = "^7Verify YouViolateMe";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = "YouViolateMe"; //psn goes here
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify xTurntUpLobbies ^7}";
	options[m][num]["NotSelected"] = "^7Verify xTurntUpLobbies";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = "TurntUpLobbies"; //psn goes here
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify JokerRey ^7}";
	options[m][num]["NotSelected"] = "^7Verify JokerRey";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = "JokerRey"; //psn goes here
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify Friend 1 ^7}";
	options[m][num]["NotSelected"] = "^7Verify Friend 1";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = ""; //psn goes here, make sure to update Friend1 text above
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify Friend 2 ^7}";
	options[m][num]["NotSelected"] = "^7Verify Friend 2";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = ""; //psn goes here, make sure to update Friend2 text above
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify Friend 3 ^7}";
	options[m][num]["NotSelected"] = "^7Verify Friend 3";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = ""; //psn goes here, make sure to update Friend3 text above
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify Friend 4 ^7}";
	options[m][num]["NotSelected"] = "^7Verify Friend 4";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = ""; //psn goes here, make sure to update Friend4 text above
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify Friend 5 ^7}";
	options[m][num]["NotSelected"] = "^7Verify Friend 5";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = ""; //psn goes here, make sure to update Friend4 text above
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify Friend 6 ^7}";
	options[m][num]["NotSelected"] = "^7Verify Friend 6";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = ""; //psn goes here, make sure to update Friend4 text above
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Verify Friend 7 ^7}";
	options[m][num]["NotSelected"] = "^7Verify Friend 7";
	options[m][num]["func"] = ::verifyplayer;
	options[m][num]["input1"] = ""; //psn goes here, make sure to update Friend4 text above
	num++;
	
	num = 0;
	m = "Aim Assist Menu";

	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Stealth Aim Assist ^7[" + getBooleanStatus(self.stealthaimassist) + "^7] }";
	options[m][num]["NotSelected"] = "^7Stealth Aim Assist [" + getBooleanStatus(self.stealthaimassist) + "]";
	options[m][num]["func"] = ::toggleStealthAimAssist;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Unfair Aim Assist ^7[" + getBooleanStatus(self.aimassist) + "^7] }";
	options[m][num]["NotSelected"] = "^7Unfair Aim Assist [" + getBooleanStatus(self.aimassist) + "]";
	options[m][num]["func"] = ::toggleAimAssist;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Knifebot ^7[" + getBooleanStatus(self.knifebot) + "^7] }";
	options[m][num]["NotSelected"] = "^7Knifebot [" + getBooleanStatus(self.knifebot) + "]";
	options[m][num]["func"] = ::toggleKnifebot;
	num++;
	
	num = 0;
	m = "Vision Menu";

	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4EMP Vision ^7[" + getBooleanStatus(self.emp) + "^7] }";
	options[m][num]["NotSelected"] = "^7EMP Vision [" + getBooleanStatus(self.emp) + "]";
	options[m][num]["func"] = ::emp;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Enhanced Vision ^7[" + getBooleanStatus(self.ev) + "^7] }";
	options[m][num]["NotSelected"] = "^7Enhanced Vision [" + getBooleanStatus(self.ev) + "]";
	options[m][num]["func"] = ::EV;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Light Vision ^7[" + getBooleanStatus(self.lv) + "^7] }";
	options[m][num]["NotSelected"] = "^7Light Vision [" + getBooleanStatus(self.lv) + "]";
	options[m][num]["func"] = ::LVis;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{ ^4Black & White Vision ^7[" + getBooleanStatus(self.bw) + "^7] }";
	options[m][num]["NotSelected"] = "^7Black & White Vision [" + getBooleanStatus(self.bw) + "]";
	options[m][num]["func"] = ::BWV;
	num++;
	
	num = 0;
	m = "Bot Settings Menu";

	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{^4Add A Bot ^7}";
	options[m][num]["NotSelected"] = "^7Add A Bot";
	options[m][num]["func"] = ::SpawnBots;
	options[m][num]["input1"] = 1;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{^4Add 3 Bots ^7}";
	options[m][num]["NotSelected"] = "^7Add 3 Bots";
	options[m][num]["func"] = ::SpawnBots;
	options[m][num]["input1"] = 3;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{^4Add 6 Bots ^7}";
	options[m][num]["NotSelected"] = "^7Add 6 Bots";
	options[m][num]["func"] = ::SpawnBots;
	options[m][num]["input1"] = 6;
	num++;
	
	options[m][num]["parent"] = m;
	options[m][num]["Selected"] = "{^4Kick All Bots ^7}";
	options[m][num]["NotSelected"] = "^7Kick All Bots";
	options[m][num]["func"] = ::KickBots;
	num++;
	
	return options; //return our options as an array
}

CreateOptions() //here is where we create our options
{
	options = getOptions(); //get options
	
	//top level menus
	//example how to add a menu:
	//self AddMenu(MenuTitle, MenuSubTitle, MenuType, PreviousMenu, options);
	self AddMenu("Host Menu", "HOST", "Top", undefined, options["Host Menu"]);
	self AddMenu("Game Settings Menu", "GS", "Top", undefined, options["Game Settings Menu"]);
	self AddMenu("Infections Menu", "INFE", "Top", undefined, options["Infections Menu"]);
	self AddMenu("Fun Menu", "FUN", "Top", undefined, options["Fun Menu"]);
	self AddMenu("Account Menu", "ACCO", "Top", undefined, options["Account Menu"]);
	self AddMenu("Messages Menu", "MESS", "Top", undefined, options["Messages Menu"]);
	self AddMenu("Airdrop/Killstreak Menu", "AIRD", "Top", undefined, options["Airdrop/Killstreak Menu"]);
	self AddMenu("Search & Destroy Menu", "S&D", "Top", undefined, options["Search & Destroy Menu"]);
	self AddMenu("Martyrdom Menu", "MART", "Top", undefined, options["Martyrdom Menu"]);
	self AddMenu("Perk Menu", "PERK", "Top", undefined, options["Perk Menu"]);
	self AddMenu("Maps Menu", "MAPS", "Top", undefined, options["Maps Menu"]);
	self AddMenu("Kick Menu", "KICK", "Top", undefined, options["Kick Menu"]);
	
	//sub menus
	self AddMenu("Verification Menu", undefined, "Sub", "Host Menu", options["Verification Menu"]);
	self AddMenu("Aim Assist Menu", undefined, "Sub", "Fun Menu", options["Aim Assist Menu"]);
	self AddMenu("Vision Menu", undefined, "Sub", "Fun Menu", options["Vision Menu"]);
	self AddMenu("Bot Settings Menu", undefined, "Sub", "Game Settings Menu", options["Bot Settings Menu"]);
	
	self thread waitForMenuClick(); //updates menu options/text when option is clicked
}

updateMenuOptionsLoop() //constantly updates menu options
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		_options = getOptions();
		foreach(menu in self.UnboundUser.allmenus)
		{
			self updateOptions(_options[menu]);
		}
		
		wait .1;
	}
}

waitForMenuClick()
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		self waittill("clicked_option");
		_options = getOptions();
		
		self updateOptions(_options[self.UnboundUser.currentmenu]); //updates options for currentmenu
		
		updateText_DontCreate(); //updates menu text
	}
}

updateOptions(_options)
{
	for(i = 0; i < _options.size; i++)
	{
		menutitle = _options[i]["parent"];
		self.UnboundUser.menus[menutitle].options[i].selectedtext = _options[i]["Selected"];
		self.UnboundUser.menus[menutitle].options[i].notselectedtext = _options[i]["NotSelected"];
		self.UnboundUser.menus[menutitle].options[i].func = _options[i]["func"];
		if (isDefined(_options[i]["input1"]))
			self.UnboundUser.menus[menutitle].options[i].input1 = _options[i]["input1"];
		if (isDefined(_options[i]["input2"]))
			self.UnboundUser.menus[menutitle].options[i].input2 = _options[i]["input2"];
		if (isDefined(_options[i]["input3"]))
			self.UnboundUser.menus[menutitle].options[i].input3 = _options[i]["input3"];
	}
	
	//just sets values into our arrays
}

updateText(menutitle) //create text options, only called from callMenu
{
	string = "";
	
	for(i = 0; i < self.UnboundUser.options.size; i++)
	{
		if (isDefined(self.UnboundUser.options) && isDefined(self.UnboundUser.options[i]))
			self.UnboundUser.options[i] destroy();
	}
	
	for(i = 0; i < self.UnboundUser.optionstoshow; i++)
    {
    	if (isDefined(self.UnboundUser.menus[menutitle].options[i]))
    	{
    		string = isSelected(i) ? self.UnboundUser.menus[menutitle].options[i].selectedtext : self.UnboundUser.menus[menutitle].options[i].notselectedtext; //ternary operators, look em up
    		
    		self.UnboundUser.options[i] = createText("objective", 1.6, "CENTER", "CENTER", 0, -100 + (i * 20.54), 1, 1, (255, 255, 255), string);
    	}
    }
}

updateText_DontCreate() //updates current text that's on screen
{
	menutitle = self.UnboundUser.currentmenu;
	
	cur = self.UnboundUser.curs;
	
	optionnum = 0;
	if (cur >= self.UnboundUser.optionstoshow)
	{
		for(i = cur - (self.UnboundUser.optionstoshow - 1); i < cur + 1; i++)
		{
			option = getOptionText(menutitle, i);
			
			if (isDefined(self.UnboundUser.options) && isDefined(self.UnboundUser.options[optionnum]))
				self.UnboundUser.options[optionnum] setSafeText(option);
				
			optionnum++;
		}
	}
	else
	{
		for(i = 0; i < self.UnboundUser.optionstoshow; i++)
		{
			option = getOptionText(menutitle, i);
			
			if (isDefined(self.UnboundUser.options) && isDefined(self.UnboundUser.options[i]))
				self.UnboundUser.options[i] setSafeText(option);
				
		}
	}
}

getOptionText(menutitle, num)
{
	if (isDefined(self.UnboundUser.menus[menutitle].options[num]))
		return isSelected(num) ? self.UnboundUser.menus[menutitle].options[num].selectedtext : self.UnboundUser.menus[menutitle].options[num].notselectedtext;
	else
		return "";
}







