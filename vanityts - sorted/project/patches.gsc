main()
{
	if (getDvar("g_gametype") == "tdm")
	{
	}
	else if (getDvar("g_gametype") == "dm")
	{
		replaceFunc(maps\mp\gametypes\_globallogic_score::_setplayerscore, ::_setplayerscore);
		replaceFunc(maps\mp\gametypes\_globallogic_score::setpointstowin, ::setpointstowin);
	}
	replaceFunc(maps\mp\_scoreevents::processscoreevent, ::processscoreevent);
}
processscoreevent(event, player, victim, weapon)
{
	player.event = event;
	pixbeginevent("processScoreEvent");
	scoregiven = 0;
	if (!isplayer(player))
	{
		return scoregiven;
	}
	player thread maps\mp\_challenges::eventreceived(event);
	if (maps\mp\_scoreevents::isregisteredevent(event))
	{
		allowplayerscore = 0;
		if (!isDefined(weapon) || maps\mp\killstreaks\_killstreaks::iskillstreakweapon(weapon) == 0)
		{
			allowplayerscore = 1;
		}
		else
		{
			allowplayerscore = maps\mp\gametypes\_rank::killstreakweaponsallowedscore(event);
		}
		if (allowplayerscore)
		{
			scoregiven = maps\mp\gametypes\_globallogic_score::giveplayerscore(event, player, victim, weapon, undefined);
			isscoreevent = scoregiven > 0;
		}
	}
	if (maps\mp\_scoreevents::shouldaddrankxp(player))
	{
		player addrankxp(event, weapon, isscoreevent);
	}
	pixendevent();
	return scoregiven;
}

setpointstowin(points)
{
	if (self isentityabot() || self.event == "assisted_suicide")
	{
		self.event = "";
		return;
	}
	self.pers["pointstowin"] = clamp(points, 0, 65000);
	self.pointstowin = self.pers["pointstowin"];
	self thread maps\mp\gametypes\_globallogic::checkscorelimit();
	self thread maps\mp\gametypes\_globallogic::checkplayerscorelimitsoon();
	level thread maps\mp\gametypes\_globallogic_score::playtop3sounds();
}
_setplayerscore(player, score)
{
	if (score == player.pers["score"])
	{
		return;
	}
	else
	{
		if (player isentityabot())
		{
			score = score - 100;
		}

		if (score < 0)
			score = 0;
		if (!level.rankedmatch)
		{
			player thread maps\mp\gametypes\_rank::updaterankscorehud(score - player.pers["score"]);
		}
		player.pers["score"] = score;
		player.score = player.pers["score"];
		recordplayerstats(player, "score", player.pers["score"]);
		if (level.wagermatch)
		{
			player thread maps\mp\gametypes\_wager::playerscored();
		}
	}
}