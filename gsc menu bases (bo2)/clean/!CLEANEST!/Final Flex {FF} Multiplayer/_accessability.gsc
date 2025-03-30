verificationToColor(status)
{
	if (status == "Creator")
		return "^6Creator^7";
    if (status == "Host")
		return "^2Host^7";
    if (status == "Co-Host")
		return "^5Co-Host^7";
    if (status == "Admin")
		return "^1Admin^7";
    if (status == "VIP")
		return "^4VIP^7";
    if (status == "Verified")
		return "^3Verified^7";
    if (status == "None")
		return "None";
}

setPlayerVerification(player, which)
{
	if(player != self && !player isHost() && player.status != which)
	{	
		if(player isVerified())
			player destroyMenu();
			
		player.status = which;
		
		if(player isVerified())
		{
			player.hasMenu = true;
			player thread menuInit();
			player thread closeMenuOnDeath();
			player thread closeMenuOnGameEnd();
		}
		self iPrintlnBold(player.name+" Verification Set To "+verificationToColor(which));
		player iPrintlnBold("Verification Set To "+verificationToColor(which));
	}
	else if(player.status == which)
		self iPrintlnBold(player.name+" Verification Is Already Set To "+verificationToColor(which));
}

getPlayerName()
{
	name = self.name;
	if(name[0] != "[")
		return name;
	for(a = name.size - 1; a >= 0; a--)
		if(name[a] == "]")
			break;
	return(getSubStr(name, a + 1));
}

isVerified()
{
	if(self.status != "None")
		return true;
	return false;
}

coHostList(player, action)
{
	dvar = getDvar("coHostList");
	name = player getPlayerName();
	if(action == true)
	{
		if(dvar == "")
			dvar += name;
		else
			dvar += "," + name;
	}
	if(action == false)
	{
		array = strTok(dvar, ",");
		dvar = "";
		for(i = 0; i < array.size; i++)
		{
			if(array[i] != name)
			{
				if(i == 0)
					dvar += array[i];
				else
					dvar += "," + array[i];	
			}
		}
	}
	setDvar("coHostList", dvar);
	self refreshMenuAllPlayers();
}

isInCoHostList(who)
{
	if(getDvar("coHostList") == "")
		return false;
	array = strTok(getDvar("coHostList"), ",");
	for(i = 0; i < array.size; i++)
		if(array[i] == who getPlayerName())
			return true;
	return false;
}

