recreateText()
{
	self submenu(self.CurMenu, self.CurTitle);
	
	self.Radiant["title"] setSafeText("Menu Base");
	self.Radiant["slash"] setSafeText("/");
}

overflowfix()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	
	level.test = createServerFontString("default", 1);
	level.test setText("xTUL");
	level.test.alpha = 0;
	
	if(getDvar("g_gametype") == "sd")
		A = 45;
	else 
		A = 55;
		
	for(;;)
	{
		level waittill("textset");

		if(level.result >= A)
		{
			level.test ClearAllTextAfterHudElem();
			level.result = 0;

			foreach(player in level.players)
				if(player.menu.open && player isVerified())
					player recreateText();
		}
	}
}

