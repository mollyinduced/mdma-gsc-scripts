#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_scoreevents;
#include maps/mp/_utility;
#include common_scripts/utility;
init()
{
	level.scoreinfo = [];
	level.xpscale = getDvarFloat( "scr_xpscale" );
	level.codpointsxpscale = getDvarFloat( "scr_codpointsxpscale" );
	level.codpointsmatchscale = getDvarFloat( "scr_codpointsmatchscale" );
	level.codpointschallengescale = getDvarFloat( "scr_codpointsperchallenge" );
	level.rankxpcap = getDvarInt( "scr_rankXpCap" );
	level.codpointscap = getDvarInt( "scr_codPointsCap" );
	level.usingmomentum = 1;
	level.usingscorestreaks = getDvarInt( "scr_scorestreaks" ) != 0;
	level.scorestreaksmaxstacking = getDvarInt( "scr_scorestreaks_maxstacking" );
	level.maxinventoryscorestreaks = getdvarintdefault( "scr_maxinventory_scorestreaks", 3 );
	if ( isDefined( level.usingscorestreaks ) )
	{
		level.usingrampage = !level.usingscorestreaks;
	}
	level.rampagebonusscale = getDvarFloat( "scr_rampagebonusscale" );
	level.ranktable = [];
	precacheshader( "white" );
	if ( !sessionmodeiszombiesgame() )
	{
		initscoreinfo();
	}
	level.maxrank = int( tablelookup( "mp/rankTable.csv", 0, "maxrank", 1 ) );
	level.maxprestige = int( tablelookup( "mp/rankIconTable.csv", 0, "maxprestige", 1 ) );
	pid = 0;
	rid = 0;
	pid = 0;
	while ( pid <= level.maxprestige )
	{
		rid = 0;
		while ( rid <= level.maxrank )
		{
			precacheshader( tablelookup( "mp/rankIconTable.csv", 0, rid, pid + 1 ) );
			rid++;
		}
		pid++;
	}
	rankid = 0;
	rankname = tablelookup( "mp/ranktable.csv", 0, rankid, 1 );
	while ( isDefined( rankname ) && rankname != "" )
	{
		level.ranktable[ rankid ][ 1 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 1 );
		level.ranktable[ rankid ][ 2 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 2 );
		level.ranktable[ rankid ][ 3 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 3 );
		level.ranktable[ rankid ][ 7 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 7 );
		level.ranktable[ rankid ][ 14 ] = tablelookup( "mp/ranktable.csv", 0, rankid, 14 );
		rankid++;
		rankname = tablelookup( "mp/ranktable.csv", 0, rankid, 1 );
	}
	level thread onplayerconnect();
}
initscoreinfo()
{
	scoreinfotableid = getscoreeventtableid();
	if ( !isDefined( scoreinfotableid ) )
	{
		return;
	}
	scorecolumn = getscoreeventcolumn( level.gametype );
	xpcolumn = getxpeventcolumn( level.gametype );
	if ( scorecolumn < 0 )
	{
		return;
	}
	if ( xpcolumn < 0 )
	{
		return;
	}
	row = 1;
	while ( row < 512 )
	{
		type = tablelookupcolumnforrow( scoreinfotableid, row, 0 );
		if ( type != "" )
		{
			labelstring = tablelookupcolumnforrow( scoreinfotableid, row, 1 );
			label = undefined;
			if ( labelstring != "" )
			{
				label = tablelookupistring( scoreinfotableid, 0, type, 1 );
			}
			scorevalue = int( tablelookupcolumnforrow( scoreinfotableid, row, scorecolumn ) );
			registerscoreinfo( type, scorevalue, label );
			if ( maps/mp/_utility::getroundsplayed() == 0 )
			{
				xpvalue = float( tablelookupcolumnforrow( scoreinfotableid, row, xpcolumn ) );
				setddlstat = tablelookupcolumnforrow( scoreinfotableid, row, 5 );
				addplayerstat = 0;
				if ( setddlstat == "TRUE" )
				{
					addplayerstat = 1;
				}
				ismedal = 0;
				istring = tablelookupistring( scoreinfotableid, 0, type, 2 );
				if ( isDefined( istring ) && istring != &"" )
				{
					ismedal = 1;
				}
				demobookmarkpriority = int( tablelookupcolumnforrow( scoreinfotableid, row, 6 ) );
				if ( !isDefined( demobookmarkpriority ) )
				{
					demobookmarkpriority = 0;
				}
				registerxp( type, xpvalue, addplayerstat, ismedal, demobookmarkpriority, row );
			}
			allowkillstreakweapons = tablelookupcolumnforrow( scoreinfotableid, row, 4 );
			if ( allowkillstreakweapons == "TRUE" )
			{
				level.scoreinfo[ type ][ "allowKillstreakWeapons" ] = 1;
			}
		}
		row++;
	}
}
getrankxpcapped( inrankxp )
{
	if ( isDefined( level.rankxpcap ) && level.rankxpcap && level.rankxpcap <= inrankxp )
	{
		return level.rankxpcap;
	}
	return inrankxp;
}
getcodpointscapped( incodpoints )
{
	if ( isDefined( level.codpointscap ) && level.codpointscap && level.codpointscap <= incodpoints )
	{
		return level.codpointscap;
	}
	return incodpoints;
}
registerscoreinfo( type, value, label )
{
	overridedvar = "scr_" + level.gametype + "_score_" + type;
	if ( getDvar( overridedvar ) != "" )
	{
		value = getDvarInt( overridedvar );
	}
	if ( type == "kill" )
	{
		multiplier = getgametypesetting( "killEventScoreMultiplier" );
		level.scoreinfo[ type ][ "value" ] = int( ( multiplier + 1 ) * value );
	}
	else
	{
		level.scoreinfo[ type ][ "value" ] = value;
	}
	if ( isDefined( label ) )
	{
		precachestring( &"MP_PLUS" );
		level.scoreinfo[ type ][ "label" ] = &"MP_PLUS";
		level.scoreinfo[ type ][ "label" ] = &"";
	}
}
getscoreinfovalue( type )
{
	if ( isDefined( level.scoreinfo[ type ] ) )
	{
		return level.scoreinfo[ type ][ "value" ];
	}
}
getscoreinfolabel( type )
{
	return level.scoreinfo[ type ][ "label" ];
}
killstreakweaponsallowedscore( type )
{
	if ( isDefined( level.scoreinfo[ type ][ "allowKillstreakWeapons" ] ) && level.scoreinfo[ type ][ "allowKillstreakWeapons" ] == 1 )
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
doesscoreinfocounttowardrampage( type )
{
	if ( isDefined( level.scoreinfo[ type ][ "rampage" ] ) )
	{
		return level.scoreinfo[ type ][ "rampage" ];
	}
}
getrankinfominxp( rankid )
{
	return int( level.ranktable[ rankid ][ 2 ] );
}
getrankinfoxpamt( rankid )
{
	return int( level.ranktable[ rankid ][ 3 ] );
}
getrankinfomaxxp( rankid )
{
	return int( level.ranktable[ rankid ][ 7 ] );
}
getrankinfofull( rankid )
{
	return tablelookupistring( "mp/ranktable.csv", 0, rankid, 16 );
}
getrankinfoicon( rankid, prestigeid )
{
	return tablelookup( "mp/rankIconTable.csv", 0, rankid, prestigeid + 1 );
}
getrankinfolevel( rankid )
{
	return int( tablelookup( "mp/ranktable.csv", 0, rankid, 13 ) );
}
getrankinfocodpointsearned( rankid )
{
	return int( tablelookup( "mp/ranktable.csv", 0, rankid, 17 ) );
}
shouldkickbyrank()
{
	if ( self ishost() )
	{
		return 0;
	}
	if ( level.rankcap > 0 && self.pers[ "rank" ] > level.rankcap )
	{
		return 1;
	}
	if ( level.rankcap > 0 && level.minprestige == 0 && self.pers[ "plevel" ] > 0 )
	{
		return 1;
	}
	if ( level.minprestige > self.pers[ "plevel" ] )
	{
		return 1;
	}
	return 0;
}
getcodpointsstat()
{
	codpoints = self getdstat( "playerstatslist", "CODPOINTS", "StatValue" );
	codpointscapped = getcodpointscapped( codpoints );
	if ( codpoints > codpointscapped )
	{
		self setcodpointsstat( codpointscapped );
	}
	return codpointscapped;
}
setcodpointsstat( codpoints )
{
	self setdstat( "PlayerStatsList", "CODPOINTS", "StatValue", getcodpointscapped( codpoints ) );
}
getrankxpstat()
{
	rankxp = self getdstat( "playerstatslist", "RANKXP", "StatValue" );
	rankxpcapped = getrankxpcapped( rankxp );
	if ( rankxp > rankxpcapped )
	{
		self setdstat( "playerstatslist", "RANKXP", "StatValue", rankxpcapped );
	}
	return rankxpcapped;
}
onplayerconnect()
{
	for (;;)
	{
		level waittill( "connected", player );
		player.pers[ "rankxp" ] = player getrankxpstat();
		player.pers[ "codpoints" ] = player getcodpointsstat();
		player.pers[ "currencyspent" ] = player getdstat( "playerstatslist", "currencyspent", "StatValue" );
		rankid = player getrankforxp( player getrankxp() );
		player.pers[ "rank" ] = rankid;
		player.pers[ "plevel" ] = player getdstat( "playerstatslist", "PLEVEL", "StatValue" );
		if ( player shouldkickbyrank() )
		{
			kick( player getentitynumber() );
			continue;
		}
		else
		{
			if ( !isDefined( player.pers[ "participation" ] ) || level.gametype == "twar" && game[ "roundsplayed" ] >= 0 && player.pers[ "participation" ] >= 0 )
			{
				player.pers[ "participation" ] = 0;
			}
			player.rankupdatetotal = 0;
			player.cur_ranknum = rankid;
			prestige = player getdstat( "playerstatslist", "plevel", "StatValue" );
			player setrank( rankid, prestige );
			player.pers[ "prestige" ] = prestige;
			if ( !isDefined( player.pers[ "summary" ] ) )
			{
				player.pers[ "summary" ] = [];
				player.pers[ "summary" ][ "xp" ] = 0;
				player.pers[ "summary" ][ "score" ] = 0;
				player.pers[ "summary" ][ "challenge" ] = 0;
				player.pers[ "summary" ][ "match" ] = 0;
				player.pers[ "summary" ][ "misc" ] = 0;
				player.pers[ "summary" ][ "codpoints" ] = 0;
			}
			if ( !level.rankedmatch || level.wagermatch && level.leaguematch )
			{
				player setdstat( "AfterActionReportStats", "lobbyPopup", "none" );
			}
			if ( level.rankedmatch )
			{
				player setdstat( "playerstatslist", "rank", "StatValue", rankid );
				player setdstat( "playerstatslist", "minxp", "StatValue", getrankinfominxp( rankid ) );
				player setdstat( "playerstatslist", "maxxp", "StatValue", getrankinfomaxxp( rankid ) );
				player setdstat( "playerstatslist", "lastxp", "StatValue", getrankxpcapped( player.pers[ "rankxp" ] ) );
			}
			player.explosivekills[ 0 ] = 0;
			player thread onplayerspawned();
			player thread onjoinedteam();
			player thread onjoinedspectators();
		}
	}
}
onjoinedteam()
{
	self endon( "disconnect" );
	for (;;)
	{
		self waittill( "joined_team" );
		self thread removerankhud();
	}
}
onjoinedspectators()
{
	self endon( "disconnect" );
	for (;;)
	{
		self waittill( "joined_spectators" );
		self thread removerankhud();
	}
}
onplayerspawned()
{
	self endon( "disconnect" );
	for (;;)
	{
		self waittill( "spawned_player" );
		if ( !isDefined( self.hud_rankscroreupdate ) )
		{
			self.hud_rankscroreupdate = newscorehudelem( self );
			self.hud_rankscroreupdate.horzalign = "center";
			self.hud_rankscroreupdate.vertalign = "middle";
			self.hud_rankscroreupdate.alignx = "center";
			self.hud_rankscroreupdate.aligny = "middle";
			self.hud_rankscroreupdate.x = 0;
			if ( self issplitscreen() )
			{
				self.hud_rankscroreupdate.y = -15;
			}
			else
			{
				self.hud_rankscroreupdate.y = -60;
			}
			self.hud_rankscroreupdate.font = "default";
			self.hud_rankscroreupdate.fontscale = 2;
			self.hud_rankscroreupdate.archived = 0;
			self.hud_rankscroreupdate.color = ( 1, 1, 0.5 );
			self.hud_rankscroreupdate.alpha = 0;
			self.hud_rankscroreupdate.sort = 50;
			self.hud_rankscroreupdate maps/mp/gametypes/_hud::fontpulseinit();
		}		
	} 			
} 			
inccodpoints( amount )
{
	if ( !isrankenabled() )
	{
		return;
	}
	if ( !level.rankedmatch )
	{
		return;
	}
	newcodpoints = getcodpointscapped( self.pers[ "codpoints" ] + amount );
	if ( newcodpoints > self.pers[ "codpoints" ] )
	{
		self.pers[ "summary" ][ "codpoints" ] += newcodpoints - self.pers[ "codpoints" ];
	}
	self.pers[ "codpoints" ] = newcodpoints;
	setcodpointsstat( int( newcodpoints ) );
}
atleastoneplayeroneachteam()
{
	foreach( team in level.teams )
	{
		if ( !level.playerCount[team] )
	    	return false;
	}
	return true; 
}
giverankxp( type, value, devadd )
{
	self endon( "disconnect" );
	if ( sessionmodeiszombiesgame() )
	{
		return;
	}
	if ( level.teambased && !atleastoneplayeroneachteam() && !isDefined( devadd ) )
	{
		return;
	}
	else
	{
		if ( !level.teambased && maps/mp/gametypes/_globallogic::totalplayercount() < 2 && !isDefined( devadd ) )
		{
			return;
		}
	}
	if ( !isrankenabled() )
	{
		return;
	}
	pixbeginevent( "giveRankXP" );
	if ( !isDefined( value ) )
	{
		value = getscoreinfovalue( type );
	}
	if ( level.rankedmatch )
	{
		bbprint( "mpplayerxp", "gametime %d, player %s, type %s, delta %d", getTime(), self.name, type, value );
	}
	switch( type )
	{
		case "assault": case "assault_assist": case "assist": case "assist_25": case "assist_50": case "assist_75": case "capture": case "defend": case "defuse": case "destroyer": case "dogassist": case "dogkill": case "headshot": case "helicopterassist": case "helicopterassist_25": case "helicopterassist_50": case "helicopterassist_75": case "helicopterkill": case "kill": case "medal": case "pickup": case "plant": case "rcbombdestroy": case "return": case "revive": case "spyplaneassist": case "spyplanekill": value = int( value * level.xpscale );
		break;
		default: if ( level.xpscale == 0 )
		{
			value = 0;
		}
		break;
	}
	xpincrease = self incrankxp( value );
	if ( level.rankedmatch )
	{
		self updaterank();
	}
	if ( value != 0 )
	{
		self syncxpstat();
	}
	if ( isDefined( self.enabletext ) && self.enabletext && !level.hardcoremode )
	{
		if ( type == "teamkill" )
		{
			self thread updaterankscorehud( 0 - getscoreinfovalue( "kill" ) );
		}
		else
		{
			self thread updaterankscorehud( value );
		}
	}
	switch( type )
	{
		case "assault": case "assist": case "assist_25": case "assist_50": case "assist_75": case "capture": case "defend": case "headshot": case "helicopterassist": case "helicopterassist_25": case "helicopterassist_50": case "helicopterassist_75": case "kill": case "medal": case "pickup": case "return": case "revive": case "suicide": case "teamkill": self.pers[ "summary" ][ "score" ] += value;
		inccodpoints( round_this_number( value * level.codpointsxpscale ) );
		break;
		case "loss": case "tie": case "win": self.pers[ "summary" ][ "match" ] += value;
		inccodpoints( round_this_number( value * level.codpointsmatchscale ) );
		break;
		case "challenge": self.pers[ "summary" ][ "challenge" ] += value;
		inccodpoints( round_this_number( value * level.codpointschallengescale ) );
		break;
		default: self.pers[ "summary" ][ "misc" ] += value;
		self.pers[ "summary" ][ "match" ] += value;
		inccodpoints( round_this_number( value * level.codpointsmatchscale ) );
		break;
	}
	self.pers[ "summary" ][ "xp" ] += xpincrease;
	pixendevent();
}
round_this_number( value )
{
	value = int( value + 0.5 );
	return value;
}
updaterank()
{
	newrankid = self getrank();
	if ( newrankid == self.pers[ "rank" ] )
	{
		return 0;
	}
	oldrank = self.pers[ "rank" ];
	rankid = self.pers[ "rank" ];
	self.pers[ "rank" ] = newrankid;
	while ( rankid <= newrankid )
	{
		self setdstat( "playerstatslist", "rank", "StatValue", rankid );
		self setdstat( "playerstatslist", "minxp", "StatValue", int( level.ranktable[ rankid ][ 2 ] ) );
		self setdstat( "playerstatslist", "maxxp", "StatValue", int( level.ranktable[ rankid ][ 7 ] ) );
		self.setpromotion = 1;
		if ( level.rankedmatch && level.gameended && !self issplitscreen() )
		{
			self setdstat( "AfterActionReportStats", "lobbyPopup", "promotion" );
		}
		if ( rankid != oldrank )
		{
			codpointsearnedforrank = getrankinfocodpointsearned( rankid );
			inccodpoints( codpointsearnedforrank );
			if ( !isDefined( self.pers[ "rankcp" ] ) )
			{
				self.pers[ "rankcp" ] = 0;
			}
			self.pers[ "rankcp" ] += codpointsearnedforrank;
		}
		rankid++;
	}
	self logstring( "promoted from " + oldrank + " to " + newrankid + " timeplayed: " + self getdstat( "playerstatslist", "time_played_total", "StatValue" ) );
	self setrank( newrankid );
	return 1;
}
codecallback_rankup( rank, prestige, unlocktokensadded )
{
	if ( rank > 8 )
	{
		self giveachievement( "MP_MISC_1" );
	}
	self luinotifyevent( &"rank_up", 3, rank, prestige, unlocktokensadded );
	self luinotifyeventtospectators( &"rank_up", 3, rank, prestige, unlocktokensadded );
}
getitemindex( refstring )
{
	itemindex = int( tablelookup( "mp/statstable.csv", 4, refstring, 0 ) );
	return itemindex;
}
endgameupdate()
{
	player = self;
}
updaterankscorehud( amount )
{
	self endon( "disconnect" );
	self endon( "joined_team" );
	self endon( "joined_spectators" );
	if ( isDefined( level.usingmomentum ) && level.usingmomentum )
	{
		return;
	}
	if ( amount == 0 )
	{
		return;
	}
	self notify( "update_score" );
	self endon( "update_score" );
	self.rankupdatetotal += amount;
	wait 0.05;
	if ( isDefined( self.hud_rankscroreupdate ) )
	{
		if ( self.rankupdatetotal < 0 )
		{
			self.hud_rankscroreupdate.label = &"";
			self.hud_rankscroreupdate.color = ( 0.73, 0.19, 0.19 );
		}
		else
		{
			self.hud_rankscroreupdate.label = &"MP_PLUS";
			self.hud_rankscroreupdate.color = ( 1, 1, 0.5 );
		}
		self.hud_rankscroreupdate setvalue( self.rankupdatetotal );
		self.hud_rankscroreupdate.alpha = 0.85;
		self.hud_rankscroreupdate thread maps/mp/gametypes/_hud::fontpulse( self );
		wait 1;
		self.hud_rankscroreupdate fadeovertime( 0.75 );
		self.hud_rankscroreupdate.alpha = 0;
		self.rankupdatetotal = 0;
	}
}
updatemomentumhud( amount, reason, reasonvalue )
{
	self endon( "disconnect" );
	self endon( "joined_team" );
	self endon( "joined_spectators" );
	if ( amount == 0 )
	{
		return;
	}
	self notify( "update_score" );
	self endon( "update_score" );
	self.rankupdatetotal += amount;
	if ( isDefined( self.hud_rankscroreupdate ) )
	{
		if ( self.rankupdatetotal < 0 )
		{
			self.hud_rankscroreupdate.label = &"";
			self.hud_rankscroreupdate.color = ( 0.73, 0.19, 0.19 );
		}
		else
		{
			self.hud_rankscroreupdate.label = &"MP_PLUS";
			self.hud_rankscroreupdate.color = ( 1, 1, 0.5 );
		}
		self.hud_rankscroreupdate setvalue( self.rankupdatetotal );
		self.hud_rankscroreupdate.alpha = 0.85;
		self.hud_rankscroreupdate thread maps/mp/gametypes/_hud::fontpulse( self );
		if ( isDefined( self.hud_momentumreason ) )
		{
			if ( isDefined( reason ) )
			{
				if ( isDefined( reasonvalue ) )
				{
					self.hud_momentumreason.label = reason;
					self.hud_momentumreason setvalue( reasonvalue );
				}
				else
				{
					self.hud_momentumreason.label = reason;
					self.hud_momentumreason setvalue( amount );
				}
				self.hud_momentumreason.alpha = 0.85;
				self.hud_momentumreason thread maps/mp/gametypes/_hud::fontpulse( self );
			}
			else
			{
				self.hud_momentumreason fadeovertime( 0.01 );
				self.hud_momentumreason.alpha = 0;
			}
		}
		wait 1;
		self.hud_rankscroreupdate fadeovertime( 0.75 );
		self.hud_rankscroreupdate.alpha = 0;
		if ( isDefined( self.hud_momentumreason ) && isDefined( reason ) )
		{
			self.hud_momentumreason fadeovertime( 0.75 );
			self.hud_momentumreason.alpha = 0;
		}
		wait 0.75;
		self.rankupdatetotal = 0;
	}
}
removerankhud()
{
	if ( isDefined( self.hud_rankscroreupdate ) )
	{
		self.hud_rankscroreupdate.alpha = 0;
	}
	if ( isDefined( self.hud_momentumreason ) )
	{
		self.hud_momentumreason.alpha = 0;
	}
}
getrank()
{
	rankxp = getrankxpcapped( self.pers[ "rankxp" ] );
	rankid = self.pers[ "rank" ];
	if ( rankxp < ( getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) ) )
	{
		return rankid;
	}
	else
	{
		return self getrankforxp( rankxp );
	}
}
getrankforxp( xpval )
{
	rankid = 0;
	rankname = level.ranktable[ rankid ][ 1 ];
	while ( isDefined( rankname ) && rankname != "" )
	{
		if ( xpval < ( getrankinfominxp( rankid ) + getrankinfoxpamt( rankid ) ) )
		{
			return rankid;
		}
		rankid++;
		if ( isDefined( level.ranktable[ rankid ] ) )
		{
			rankname = level.ranktable[ rankid ][ 1 ];
			continue;
		}
		else
		{
			rankname = undefined;
		}
	}
	rankid--;
	return rankid;
}
getspm()
{
	ranklevel = self getrank() + 1;
	return ( 3 + ( ranklevel * 0.5 ) ) * 10;
}
getrankxp()
{
	return getrankxpcapped( self.pers[ "rankxp" ] );
}
incrankxp( amount )
{
	if ( !level.rankedmatch )
	{
		return 0;
	}
	xp = self getrankxp();
	newxp = getrankxpcapped( xp + amount );
	if ( self.pers[ "rank" ] == level.maxrank && newxp >= getrankinfomaxxp( level.maxrank ) )
	{
		newxp = getrankinfomaxxp( level.maxrank );
	}
	xpincrease = getrankxpcapped( newxp ) - self.pers[ "rankxp" ];
	if ( xpincrease < 0 )
	{
		xpincrease = 0;
	}
	self.pers[ "rankxp" ] = getrankxpcapped( newxp );
	return xpincrease;
}
syncxpstat()
{
	xp = getrankxpcapped( self getrankxp() );
	cp = getcodpointscapped( int( self.pers[ "codpoints" ] ) );
	self setdstat( "playerstatslist", "rankxp", "StatValue", xp );
	self setdstat( "playerstatslist", "codpoints", "StatValue", cp );
}


