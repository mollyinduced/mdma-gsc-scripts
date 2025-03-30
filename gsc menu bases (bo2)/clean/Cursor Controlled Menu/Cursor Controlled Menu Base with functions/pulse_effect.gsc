/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : pulse_effect
*	 Description : Inlcudes the functions for pulse effects
*	 Date : 2015/06/21 - 12:26:29	
*
*/	

MonitorPulse()
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		if (self.CursorMenu.InMenu)
		{
			cursor = self.CursorMenu.MainElements["SelectionDot"];
			prevArrow = self.CursorMenu.MainElements["LeftArrow"];
			nextArrow = self.CursorMenu.MainElements["RightArrow"];
			
			menu1 = self.CursorMenu.MainElements["LeftTitle"];
			menu2 = self.CursorMenu.MainElements["MidTitle"];
			menu3 = self.CursorMenu.MainElements["RightTitle"];
			
				
			if (is_touching(menu1, cursor))
				menu1 pulse(self);
			else
				menu1 stopPulse(self);
				
			if (is_touching(menu2, cursor))
				menu2 pulse(self);
			else
				menu2 stopPulse(self);
				
			if (is_touching(menu3, cursor))
				menu3 pulse(self);
			else
				menu3 stopPulse(self);
				
			foreach(element in self.CursorMenu.OptionElements)
			{
				if (is_touching(element, cursor))
					element pulse(self);
				else
					element stopPulse(self);
			}
		}
		wait 0.02;
	}
}

pulse(player)
{
	self notify("stop_pulse");
	self endon("stop_pulse");
	player endon("death");
	player endon("closedMenu");
	
	self.pulsing = true;
	self scaleFont(1.8, 0.1);
	
	self fadeovertime( 0.1 );
	self.alpha = 1;
}

stopPulse(player)
{
	if(self.pulsing)
	{
		self notify("stop_pulse");
		self.alpha = 1;
		self.Color = (1,1,1);
		
		if (self == player.CursorMenu.MainElements["MidTitle"])
			self scaleFont(1.4, 0.1);
		else
			self scaleFont(1, 0.1);
			
		self.pulsing = false;
		self.glowAlpha = 0;
	}
}

scaleFont(value, time)
{
	self changeFontScaleOverTime(time);
	self.fontScale = value;
}

