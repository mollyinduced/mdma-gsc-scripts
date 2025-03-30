test()
{self iprintln(self.name+" has selected a test function");}

testColourToggle()
{
	if(!isDefined(self.colourToggle))
	{
		self.colourToggle = true;
		self setColour(self.colourToggle);
		iprintln("on");
	}
	else
	{
		self.colourToggle = undefined;
		self setColour(self.colourToggle);
		iprintln("off");
	}
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

giveMenuBots()
{

	/*while( true )
	{
		foreach(player in level.players)
		{
			player.eMenu["isScrolling"] = true;
			curs = player.eMenu_C[ player getCurrentMenu()+"_Cursor" ];
			
			player.eMenu["OPT_BG"][ curs ] fadeOverTime(.2);
			player.eMenu["OPT_BG"][ curs ].color = player.eMenu["Opt_BG_Colour"];
			player.eMenu["OPT"][ curs ] fadeOverTime(.2);
			player.eMenu["OPT"][ curs ].color = player grabMenuColour( curs );
			
			if(!player adsButtonPressed()) 
				player.eMenu_C[ player getCurrentMenu()+"_Cursor" ] += player attackButtonPressed();
			if(!player attackButtonPressed())
				player.eMenu_C[ player getCurrentMenu()+"_Cursor" ] -= player adsButtonPressed();
				
			if(curs != player.eMenu_C[ player getCurrentMenu()+"_Cursor" ])
			{
				player thread revalueScrolling(-1);
			}
			wait .2;
			player.eMenu["isScrolling"] = undefined;
			player notify("SCROLLING_OVER");
		}
		wait .2;
	}*/
}
