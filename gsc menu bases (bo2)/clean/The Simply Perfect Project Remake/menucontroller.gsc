MonitorControls()
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		if (self.SimplyPerfect.MenuOpen)
		{
			if (self MeleeButtonPressed())
			{
				closeMenu();
			}
			if (self ActionSlotOneButtonPressed())
			{
				optiontotal = self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].options.size - 1;
				
				if (self.SimplyPerfect.cursor.y == self.SimplyPerfect.cursorStartingYPos)
				{
					if (self.SimplyPerfect.curs == 0)
						self.SimplyPerfect.curs = optiontotal;
					else
						self.SimplyPerfect.curs--;
					
					self thread updateText();
				}
					
				self thread updateScroll(0 - self.SimplyPerfect.cursorspacing, -1);
					
				wait .14;
				
				
			}
			if (self ActionSlotTwoButtonPressed())
			{
				optiontotal = self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].options.size - 1;
				YPos = self.SimplyPerfect.cursorStartingYPos + (self.SimplyPerfect.cursorspacing * (self.SimplyPerfect.optionstoshow - 1));
				
				if (self.SimplyPerfect.cursor.y == YPos)
				{
					if (self.SimplyPerfect.curs == optiontotal)
						self.SimplyPerfect.curs = 0;
					else
						self.SimplyPerfect.curs++;
						
					self thread updateText();
				}
					
				self thread updateScroll(self.SimplyPerfect.cursorspacing, 1);
				
				wait .14;
					
			}
			if (self UseButtonPressed())
			{
				if (isDefined(self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].prevmenu))
				{
					self.SimplyPerfect.curs = 0;
					self.SimplyPerfect.scrollerpos = 0;
					
					self.SimplyPerfect.cursor scaleOverTime(0.3, 250, 30);
					
					foreach(option in self.SimplyPerfect.options)
						option affectElement("alpha", 0.3, 0);
					
					wait .3;
					
					self.SimplyPerfect.cursor scaleOverTime(0.3, 2, 30);
					
					self callMenu(self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].prevmenu);
					
					wait 0.2;
					
					foreach(option in self.SimplyPerfect.options)
						option affectElement("alpha", 0.3, 0.6);
					
					self updateTextEffects(1);
					
					wait 0.15;
					
					self.SimplyPerfect.cursor affectElement("y", 0.15, self.SimplyPerfect.cursorStartingYPos);
					
					wait 0.15;
					
					self updateTextEffects(2);
					
				}
				else
					closeMenu();

				wait .14;
			}
			if (self JumpButtonPressed())
			{
				menu = self.SimplyPerfect.currentmenu;
				
				foreach(option in self.SimplyPerfect.options)
						option affectElement("alpha", 0.3, 0);
				
				self.SimplyPerfect.cursor scaleOverTime(0.3, 250, 30);
				
				wait .3;
				
				if (menu == "Players Menu")
				{
					if (isDefined(level.players[self.SimplyPerfect.scrollerpos]))
						self.SimplyPerfect.SelectedPlayer = level.players[self.SimplyPerfect.scrollerpos];
				}
				
				self thread [[self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].options[self.SimplyPerfect.scrollerpos].func]](self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].options[self.SimplyPerfect.scrollerpos].input1, self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].options[self.SimplyPerfect.scrollerpos].input2, self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].options[self.SimplyPerfect.scrollerpos].input3);
				
				self notify("clicked_option");
				
				foreach(option in self.SimplyPerfect.options)
						option affectElement("alpha", 0.3, 0.6);
				
				self updateTextEffects(1);
				
				self.SimplyPerfect.cursor scaleOverTime(0.3, 2, 30);
				
				wait .3;
				
				if (menu != self.SimplyPerfect.currentmenu) //callMenu was called, update cursor
				{
					self.SimplyPerfect.cursor affectElement("y", 0.2, self.SimplyPerfect.cursorStartingYPos);
	
					wait 0.2;
					
					self updateTextEffects(2);
				}

			}
		}
		else
		{
			if (self isVerified())
			{
				if (self ADSButtonPressed() && self MeleeButtonPressed())
				{
					openMenu();
				}
			}
		}
		wait .05;
	}
}

updateScroll(val, newscroll)
{
		cur = self.SimplyPerfect.scrollerpos;
		last = self.SimplyPerfect.optionstoshow - 1;
		totaloptions = self.SimplyPerfect.menus[self.SimplyPerfect.currentmenu].options.size - 1;
		YPos = self.SimplyPerfect.cursorStartingYPos + (self.SimplyPerfect.cursorspacing * (self.SimplyPerfect.optionstoshow - 1));
		
		if (newscroll == 1)
		{
			if (self.SimplyPerfect.cursor.y != YPos)
					self.SimplyPerfect.cursor affectElement("y", .25, self.SimplyPerfect.cursor.y + val);
					
			if (cur < totaloptions)
				self.SimplyPerfect.scrollerpos += 1;
			else
				self.SimplyPerfect.scrollerpos = 0;
		}
		else if (newscroll == -1)
		{
			if (self.SimplyPerfect.cursor.y != self.SimplyPerfect.cursorStartingYPos)
				self.SimplyPerfect.cursor affectElement("y", .25, self.SimplyPerfect.cursor.y + val);
				
			if (cur != 0)
				self.SimplyPerfect.scrollerpos += -1;
			else
				self.SimplyPerfect.scrollerpos = totaloptions;
		}
		
		//self iprintln("Scroller Pos: " + self.SimplyPerfect.scrollerpos + " | Total Options: " + totaloptions + " | Curs: " + self.SimplyPerfect.curs);
		
		self updateTextEffects(2);
}






