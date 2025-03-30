SetVerification(player, status)
{
	name = player getName();
	if (isinarray(level.Verified, name + "_" + player.MenuAccess))
	{
		arrayremovevalue(level.Verified, level.Verified[returnIndexNum(name + "_" + player.MenuAccess)]);
	}
	player.MenuAccess = status;
	player thread closeMenu();
	player.menu.curMenu = 1;
	
	if (status != "Unverified")
	{
		if (isinarray(level.Verified, name + "_" + player.MenuAccess))
		{
		}
		else
		{
			level.Verified[level.Verified.size] = name + "_" + player.MenuAccess;
		}
		self iPrintln("You gave " + name + " " + status + " access!");
		player iPrintln("Your status has changed to: " + status);
		player suicide();
	}
	else
	{
		self iPrintln("Unverified that bitch!");
		player suicide();
	}
}

returnIndexNum(string)
{
	index = 0;
	for(i = 0; i < level.Verified.size; i++)
	{
		if (level.Verified[i] == string)
		{
			index = i;
		}
	}
	return index;
}

getName()
{
	name = getSubStr(self.name, 0, self.name.size);
	for(i = 0; i < name.size; i++)
	{
		if(name[i]=="]")
			break;
	}
	if(name.size != i)
		name = getSubStr(name, i + 1, name.size);
	
	return name;
}

getNamePlayer(player)
{
	name = getSubStr(player.name, 0, player.name.size);
	for(i = 0; i < name.size; i++)
	{
		if(name[i]=="]")
			break;
	}
	if(name.size != i)
		name = getSubStr(name, i + 1, name.size);
	
	return name;
}

checkIfVerified()
{
	self endon("disconnect");
	
	foundValue = false;
	
	foreach(arrayvalue in level.Verified)
	{
		if (arrayvalue == self getName() + "_Unverified" || arrayvalue == self getName() + "_Verified" || arrayvalue == self getName() + "_VIP" || arrayvalue == self getName() + "_Admin" || arrayvalue == self getName() + "_CoHost")
		{
			string_name = self getName();
			MenuAccess = getSubStr(arrayvalue, string_name.size, arrayvalue.size);
			foundValue = true;
			
			if (MenuAccess == "_Verified")
				self.MenuAccess = "Verified";
			if (MenuAccess == "_VIP")
				self.MenuAccess = "VIP";
			if (MenuAccess == "_Admin")
				self.MenuAccess = "Admin";
			if (MenuAccess == "_CoHost")
				self.MenuAccess = "CoHost";
		}
	}
}

isVerified()
{
	if (self isHost() || self.MenuAccess == "Verified" || self.MenuAccess == "VIP" || self.MenuAccess == "Admin" || self.MenuAccess == "CoHost")
	{
		return true;
	}
	else
	{
		return false;
	}
}

verificationToNum(status)
{
    if (status == "Host")
        return 5;
    if (status == "CoHost")
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
        return "^2Host";
    if (status == "CoHost")
        return "^5Co-Host";
    if (status == "Admin")
        return "^1Admin";
    if (status == "VIP")
        return "^4VIP";
    if (status == "Verified")
        return "^3Verified";
    else
        return "^1Unverified";
}



