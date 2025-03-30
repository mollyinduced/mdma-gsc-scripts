getBooleanStatus(bool)
{
	if (!isDefined(bool))
		return "^1Disabled";
	
	if (bool)
		return "^2Enabled";
	else
		return "^1Disabled";
}

SpawnBooleans()
{
	self.testvar = false;
}

printplayername()
{
	player = self.SimplyPerfect.SelectedPlayer;
	
	self iprintln(player.name);
}
