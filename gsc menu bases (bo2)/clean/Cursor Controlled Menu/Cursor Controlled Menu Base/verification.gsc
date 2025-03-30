/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : verification
*	 Description : Includes verification related functions
*	 Date : 2015/06/21 - 13:11:16	
*
*/	

SetVerification(player, status)
{
	name = player getName();
	
	if (isinarray(level.Verified, name + "_" + player.CursorMenu.MenuAccess))
		arrayremovevalue(level.Verified, level.Verified[returnIndexNum(name + "_" + player.CursorMenu.MenuAccess)]);
		
	player.CursorMenu.MenuAccess = status;
	player thread closeMenu();
	player.CursorMenu.curMenu = player.CursorMenu.menus[0];
	player.CursorMenu.curTitle = player.CursorMenu.menusubtitle[0];
	
	if (status != "Unverified")
	{
		if (isinarray(level.Verified, name + "_" + player.CursorMenu.MenuAccess))
		{
		}
		else
			level.Verified[level.Verified.size] = name + "_" + player.CursorMenu.MenuAccess;
			
		self iPrintln("You gave " + name + " " + status + " access!");
		player iPrintln("Your status has changed to: " + status);
	}
	else
	{
		self iPrintln("Unverified that bitch!");
		player closeMenu();
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
			break;
		}
	}
	return index;
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
				self.CursorMenu.MenuAccess = "Verified";
			if (MenuAccess == "_VIP")
				self.CursorMenu.MenuAccess = "VIP";
			if (MenuAccess == "_Admin")
				self.CursorMenu.MenuAccess = "Admin";
			if (MenuAccess == "_CoHost")
				self.CursorMenu.MenuAccess = "CoHost";
		}
	}
}

isVerified()
{
	if (self isHost() || self.CursorMenu.MenuAccess == "Verified" || self.CursorMenu.MenuAccess == "VIP" || self.CursorMenu.MenuAccess == "Admin" || self.CursorMenu.MenuAccess == "CoHost")
		return true;
	else
		return false;
}

CheckStatus(player)
{
	self iprintln(player.name + "'s menu access is " + player.CursorMenu.MenuAccess);
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
