test()
{self iprintln(self.name+" has selected a test function");}

testSlider( text )
{
	self iprintln( "Speed Set To: ^2"+text);
	self setmovespeedscale(int( text ));
}

testColourToggle()
{
	if(!isDefined(self.colourToggle))
		self.colourToggle = true;
	else
		self.colourToggle = undefined;
	self setColour(self.colourToggle);
}

testTextToggle()
{
	if(!isDefined(self.textToggle))
	{
		self.textToggle = true;
		self updateMenu( "Testing: Enabled" );
	}
	else
	{
		self.textToggle = undefined;
		self updateMenu( "Testing: Disabled" );
	}
}

spoofRanks( rank, prestige )
{
	if(!isDefined( rank ))
		rank = self getRank();
		
 	if(!isDefined( prestige )) 
  		self setRank(int(rank) - 1);
 	else
 		self setRank(int(rank) - 1, int(prestige));
}


allplayerFuncWrapper( func, host, arg1, arg2, arg3 )
{
	if(!isDefined(func))
		return self iprintln("function is not defined.");
	foreach(player in level.players)
	{
		if(isDefined(host) && !player isHost())
			player thread [[ func ]]();	
		if(!isDefined(host))
			player thread [[ func ]]();	
	}
}

godmode()
{
	if(!isDefined(self.godmode))
	{
		self.godmode = true;
		self EnableInvulnerability();
	}
	else
	{
		self.godmode = undefined;
		self DisableInvulnerability();
	}
	self setColour(self.godmode);
}




