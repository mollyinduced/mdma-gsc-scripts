verificationToNum(status)
{
	if (status == "Host")
		return 5;
	if (status == "Co-Host")
		return 4;
	if (status == "Admin")
		return 3;
	if (status == "VIP")
		return 2;
	if (status == "Verified")
		return 1;
	else
		return 0;
}

verificationToColor(status)
{
	if (status == "Host")
		return "Host";
	if (status == "Co-Host")
		return "Co-Host";
	if (status == "Admin")
		return "Admin";
	if (status == "VIP")
		return "VIP";
	if (status == "Verified")
		return "Verified";
	else
		return "^7Unverified";
}

changeVerificationMenu(player, verlevel)
{
	if( player.status != verlevel && !player isHost())
	{		
		player.status = verlevel;
		
		if(player.status == "Unverified")
			player thread destroyMenu(player);
	
		player MenuInit();
		self iPrintln("Set Access Level For " + getPlayerName(player) + " To " + verificationToColor(verlevel));
		player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
	}
	else
	{
		if (player isHost())
			self iPrintln("You Cannot Change The Access Level of The " + verificationToColor(player.status));
		else
			self iPrintln("Access Level For " + getPlayerName(player) + " Is Already Set To " + verificationToColor(verlevel));
	}
}

changeVerification(player, verlevel)
{
	player.status = verlevel;
}

getPlayerName(player)
{
	playerName = getSubStr(player.name, 0, player.name.size);
	for(i=0; i < playerName.size; i++)
	{
		if(playerName[i] == "]")
			break;
	}
	if(playerName.size != i)
		playerName = getSubStr(playerName, i + 1, playerName.size);
	return playerName;
}

