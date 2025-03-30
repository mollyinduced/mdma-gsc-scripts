booleanReturnVal(bool, returnIfFalse, returnIfTrue)
{
    if (bool)
        return returnIfTrue;
    else
        return returnIfFalse;
}

booleanOpposite(bool)
{
    if(!isDefined(bool))
        return true;
    if (bool)
        return false;
    else
        return true;
}

isSelected(num)
{
	return self.UnboundUser.curs == num;
}

GetBooleanStatus(bool)
{
	if (isDefined(bool))
	{		
		if (bool)
			return "^2ON^7";
		else
			return "^1OFF^7";
	}
	else
		return "";
}

test(input1, input2, input3)
{
	self iprintln("This isn't an option, silly :p");
}

ResetBooleans()
{
	self.godmode = false;
	self.testvar = false;
	self.fov = false;
	self.isbuckshot = false;
	self.dropshot = false;
	self.hostonlyjump = false;
	self.uav = false;
	self.fps = false;
	self.explobullets = false;
	self.stalkerMode = false;
	self.thirdperson = false;
	self.emp = false;
	self.ev = false;
	self.lv = false;
	self.bw = false;
	self.aimassist = false;
	self.stealthaimassist = false;
	self.knifebot = false;
	self.across = false;
	self.invisiblegun = false;
	self.names = false;
	self.crosshair = false;
	self.flashammo = false;
	self.bignames = false;
	self.leftgun = false;
	self.killcam = false;
	self.superreload = false;
	self.martyrdom = "";
}

getPlayerName(player)
{
	if (isDefined(player))
	{
		playerName = getSubStr(player.name, 0, player.name.size);
		for(i=0;i < playerName.size;i++)
		{
			if(playerName[i] == "]") break;
		}
		if(playerName.size != i) playerName = getSubStr(playerName, i + 1, playerName.size);
		return playerName;
	}
	else
		return "Empty";
}







