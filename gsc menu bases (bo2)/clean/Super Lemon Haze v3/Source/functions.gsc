doBots(a)
{
    for(i = 0; i < a; i++)
    {
		self thread maps\mp\bots\_bot::spawn_bot("autoassign");
		wait 1;
    }
}

AllUnverified()
{
	foreach(player in level.players)
	{
		if (!player isHost() && !player isCoHost())
			self SetVerification("Unverified", player, false);
	}
	
	self iprintln("^1Unverified all players!");
}

AllVerified()
{
	foreach(player in level.players)
	{
		if (!player isHost() && !player isCoHost())
			self SetVerification("Verified", player, false);
	}
	
	self iprintln("Gave all players ^2Verified!");
}

AllVIP()
{
	foreach(player in level.players)
	{
		if (!player isHost() && !player isCoHost())
			self SetVerification("VIP", player, false);
	}
	
	self iprintln("Gave all players ^2VIP!");
}

AllAdmin()
{
	foreach(player in level.players)
	{
		if (!player isHost() && !player isCoHost())
			self SetVerification("Admin", player, false);
	}
	
	self iprintln("Gave all players ^2Admin!");
}
