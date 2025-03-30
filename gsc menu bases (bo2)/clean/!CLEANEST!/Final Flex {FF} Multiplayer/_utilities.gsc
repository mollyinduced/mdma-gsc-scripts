resetBooleans()
{
	self.godMode = undefined;
}

array_precache(array, type)
{
	for(m = 0; m < array.size; m++)
	{
		if(type == "model")
			precacheModel(array[m]);
		if(type == "shader")
			precacheShader(array[m]);
		if(type == "item")
			precacheItem(array[m]);
	}
}

kickAllBots()
{
	foreach(player in level.players) 
		if(isDefined(player.pers["isBot"]) && player.pers["isBot"]) 
			kick(player._player_entnum, "EXE_PLAYERKICKED");
}

test()
{
	self iprintlnBold("Test");
}

handsOffHost()
{
	self iPrintlnBold("Don't Touch The Host");
}

debugexit()
{
	exitlevel(false);
}

inMap()
{
	playableArea = getEntArray( "player_volume", "script_noteworthy" );
	for(a=0;a<playableArea.size;a++)
		if(self isTouching(playableArea[a]))
			return true;
	return false;
}

spawnSM(origin,model,angles)
{
	bog = spawn("script_model",origin);
	bog setModel(model);
	bog.angles = angles;
	if(!isSolo()) wait .05;
	return bog;
}

isSolo()
{
	if(getPlayers().size <= 1)
		return true;
	return false;
}

boolToText(bool, string1, string2)
{
	if(isDefined(bool) && bool)
		return string1;
	return string2;
}

dvarToText(bool)
{
	if(bool == "1")
		return "^2On";
	return "^1Off";
}

toggleTest()
{
	if(!isDefined(self.testToggle))
		self.testToggle = true;
	else
		self.testToggle = undefined;
		
	self refreshMenu();
}

play_Local_Sound(sound)
{
	self stopSounds();
	self playSound(sound);
}

stringTest()
{  
	if(!isDefined(self.stringTestThreaded))
	{
		self endon("disconnect");
		level endon("game_ended");
		self endon("stringTestEnd");
		
		self.stringTestThreaded = true;
		
	    self.stringTest = self createfontstring("default", 1.5);
	    self.stringTest setPoint("CENTER", "CENTER", 0, 0);
	    
	    self.stringNum = 0;
		for( ;; )
		{  
			self.stringTest setSafeText("^1Supports " + self.stringNum + " Strings");
			self.stringNum++;
			wait .05;
		} 
	}
	else
	{
		self notify("stringTestEnd");
		self.stringTest destroy();
		self.stringTestThreaded = undefined;
	}
} 

/*resetDvar(dvar)
{
	setDvar(dvar, "");
}

SetClientDvar(player, dvar, dvar_value)
{
	dvarstring = "";
	
	if (isDefined(getDvar(dvar)))
		dvarstring = getDvar(dvar);
	
	valuearray = strTok(dvarstring, ";");
	dvarstring = "";
	
	foreach(value in valuearray)
		if (!StringContains(value, player getPlayerName()))
			dvarstring += value + ";";
	
	if (isDefined(dvar_value))
		dvarstring += player getPlayerName() + "=" + dvar_value + ";";
	
	valuearray = undefined;
	setDvar(dvar, dvarstring);
}

GetClientDvar(player, dvar, type)
{
	if (!isDefined(getDvar(dvar)))
		return undefined;
	
	dvarvalue = getDvar(dvar);
	values = strTok(dvarvalue, ";");
	
	foreach(value in values)
	{
		name = player getPlayerName();
		
		if (StringContains(value, name))
		{
			string_value = getSubStr(value, getIndexof(value, "=", 0) + 1, value.size);
			
			if (type == "int")
				return int(string_value);
			else if (type == "string")
				return string_value;
		}
	}
	values = undefined;
	return undefined;
}

StringContains(string, value)
{
	index = 0;
	while( index <= string.size - value.size - 1)
	{
		if (!isDefined(string[index + value.size - 1]))
			return false;
		
		if (getSubStr(string, index, index + value.size) == value)
		{
			return true;
			break;
		}
		else
			index++;
	}
	
	return false;
}

getIndexOf(string, value, startingIndex)
{
	index = startingIndex;
	while( index <= string.size - value.size - 1)
	{
		if (!isDefined(string[index + value.size - 1]))
			return -1;
		
		if (getSubStr(string, index, index + value.size) == value)
			return index;
		else
			index++;
	}
	
	return -1;
}*/

