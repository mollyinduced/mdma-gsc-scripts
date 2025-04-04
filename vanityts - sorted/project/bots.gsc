inizializeBots()
{
	level waittill("connected", idc);
	wait 10;
	bots = 0;
	foreach (player in level.players)
	{
		if (player isentityabot())
		{
			bots++;
		}
	}

	if (bots == 0 && (getDvar("g_gametype") == "sd" || getDvar("g_gametype") == "sr"))
	{
		spawnTeamBots(2, game["defenders"]);
	}
	else if (bots == 0)
	{
		spawnTeamBots(getDvarInt("sv_maxclients") / 2, game["defenders"]);
	}
}
isentityabot()
{
	return (isDefined(self.pers["isBot"]) && self.pers["isBot"]);
}
serverBotFill()
{
	level endon("game_ended");
	level waittill("prematch_over");
	while (1)
	{
		while (level.players.size < 14 && !level.gameended)
		{
			spawnBots(1);
			wait 1;
		}
		if (level.players.size >= 17 && contBots() > 0)
		{
			kickbot();
		}
		wait 0.05;
	}
}

contBots()
{
	bots = 0;
	foreach (player in level.players)
	{
		if (player isentityabot())
		{
			bots++;
		}
	}
	return bots;
}

spawnBots(n)
{
	for (i = 0; i < n; i++)
	{
		maps\mp\bots\_bot::spawn_bot("autoassign");
	}
}
spawnTeamBots(n, team)
{
	for (i = 0; i < n; i++)
	{
		maps\mp\bots\_bot::spawn_bot("autoassign");
	}
}
kickbot()
{
	level endon("game_ended");
	foreach (player in level.players)
	{
		if (player isentityabot())
		{
			kick(player getEntityNumber());
			break;
		}
	}
}

kickBotOnJoin()
{
	level endon("game_ended");
	foreach (player in level.players)
	{
		if (player isentityabot())
		{
			kick(player getEntityNumber());
			break;
		}
	}
}