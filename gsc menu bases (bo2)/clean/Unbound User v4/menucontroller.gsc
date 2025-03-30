MonitorButtons() //button monitoring
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		if (!self.UnboundUser.MenuOpen)
		{
			if (self ActionSlotOneButtonPressed())
			{
				self thread openUnboundUserV4();
			}
			if (self ActionSlotTwoButtonPressed() && self getStance() == "prone")
			{
				self notify("dpad_down");
			}
			if (self ActionSlotThreeButtonPressed() && self getStance() == "prone")
			{
				self notify("dpad_left");
			}
		}
		else
		{
			if (self ActionSlotOneButtonPressed())
			{
				optiontotal = self.UnboundUser.menus[self.UnboundUser.currentmenu].options.size - 1;
				if (self.UnboundUser.curs == 0)
					self.UnboundUser.curs = optiontotal;
				else
					self.UnboundUser.curs--;
					
				self updateText_DontCreate(); //updateText creates Text, we want to call updateText_DontCreate, because it DOESNT create new text elements
					
				wait .14;
				
				
			}
			if (self ActionSlotTwoButtonPressed())
			{
				optiontotal = self.UnboundUser.menus[self.UnboundUser.currentmenu].options.size - 1;
				if (self.UnboundUser.curs == optiontotal)
					self.UnboundUser.curs = 0;
				else
					self.UnboundUser.curs++;
					
				self updateText_DontCreate(); //updateText creates Text, we want to call updateText_DontCreate, because it DOESNT create new text elements
				
				wait .14;
					
			}
			if (self ActionSlotThreeButtonPressed())
			{
				menutotal = self.UnboundUser.toplevelmenucount - 1; //change left/right menu
				if (self.UnboundUser.toplevelmenucurs == 0)
					self.UnboundUser.toplevelmenucurs = menutotal;
				else
					self.UnboundUser.toplevelmenucurs--;
					
				self thread callMenu(self.UnboundUser.toplevelmenus[self.UnboundUser.toplevelmenucurs]);
				wait .1;
			}
			if (self ActionSlotFourButtonPressed())
			{
				menutotal = self.UnboundUser.toplevelmenucount - 1; //change left/right menu
				if (menutotal == self.UnboundUser.toplevelmenucurs)
					self.UnboundUser.toplevelmenucurs = 0;
				else
					self.UnboundUser.toplevelmenucurs++;
					
				self thread callMenu(self.UnboundUser.toplevelmenus[self.UnboundUser.toplevelmenucurs]);
				wait .1;
			}
			if (self MeleeButtonPressed())
			{
				self thread closeUnboundUserV4();
				wait .15;
			}
			if (self UseButtonPressed())
			{
				if (isDefined(self.UnboundUser.menus[self.UnboundUser.currentmenu].prevmenu))
					self thread callMenu(self.UnboundUser.menus[self.UnboundUser.currentmenu].prevmenu);
				else
					self thread closeUnboundUserV4();

				wait .14;
			}
			if (self JumpButtonPressed())
			{
				self thread [[self.UnboundUser.menus[self.UnboundUser.currentmenu].options[self.UnboundUser.curs].func]](self.UnboundUser.menus[self.UnboundUser.currentmenu].options[self.UnboundUser.curs].input1, self.UnboundUser.menus[self.UnboundUser.currentmenu].options[self.UnboundUser.curs].input2, self.UnboundUser.menus[self.UnboundUser.currentmenu].options[self.UnboundUser.curs].input3);
				
				self notify("clicked_option");
				
				wait 0.2;
			}
		}
		
		wait 0.05;
	}
}






