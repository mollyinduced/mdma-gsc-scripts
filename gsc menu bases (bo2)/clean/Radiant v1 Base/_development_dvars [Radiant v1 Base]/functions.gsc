InfiniteHealth(print)
{
	self.InfiniteHealth = booleanOpposite(self.InfiniteHealth);
	if(print) self iPrintln(booleanReturnVal(self.InfiniteHealth, "God Mode ^1OFF", "God Mode ^2ON"));
	
	if(self.InfiniteHealth)
		self enableInvulnerability();
	else 
		if(!self.menu.open)
			self disableInvulnerability();
}

killPlayer(player)
{
	if(player!=self)
	{
		if(isAlive(player))
		{
			if(!player.InfiniteHealth && player.menu.open)
			{	
				self iPrintln(getPlayerName(player) + " ^1Was Killed!");
				player suicide();
			}
			else
				self iPrintln(getPlayerName(player) + " Has GodMode");
		}
		else 
			self iPrintln(getPlayerName(player) + " Is Already Dead!");
	}
	else
		self iprintln("Your protected from yourself");
}

