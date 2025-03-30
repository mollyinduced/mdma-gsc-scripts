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
		return "^4Host";
	if (status == "Co-Host")
		return "^5Co-Host";
	if (status == "Admin")
		return "^4Admin";
	if (status == "VIP")
		return "^5VIP";
	if (status == "Verified")
		return "^4Verified";
	else
		return "";
}

changeVerificationMenu(player, verlevel)
{
	if( player.status != verlevel && !player isHost())
	{		
		player.status = verlevel;
	
		self.menu.title destroy();
		self.menu.title = drawText("[" + verificationToColor(player.status) + "^7] " + getPlayerName(player), "objective", 2, -100, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 3);
		self.menu.title FadeOverTime(0.3);
		self.menu.title.alpha = 1;
		
		if(player.status == "Unverified")
			player thread destroyMenu(player);
	
		player thread giveMenuAccess();
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



test()
{
	self iprintlnbold("Menubase ^5Created By: ^1A^7l^1e^7x^1i^7b^1u^7s^1c^7u^1s");
}



giveMenuAccess()
{
	self thread MenuInit();
	self thread welcomeMessage();
	self iprintln("Press [{+speed_throw}] + [{+actionslot 4}]");
}



