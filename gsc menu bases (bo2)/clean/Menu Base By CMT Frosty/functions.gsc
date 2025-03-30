moveTo(axis, position, time)
{
	self moveOverTime(time);

	if(axis=="x")
		self.x = position;
	else
		self.y = position;
}

GodMode()
{
	if(self.GM == false)
	{
		self EnableInvulnerability();
		self.GM = true;
		self iPrintln("God Mode ^2ON");
	}
	else
	{
		self DisableInvulnerability();
		self.GM = false;
		self iPrintln("God Mode ^1OFF");
	}
}

endGameThing(){
self endon( "disconnect" );
	self endon( "destroyMenu" );
	self endon( "gameEndInfo" );
	for(;;)
	{
	level waittill( "game_ended" );
	if( self ishost() )
	{
		setdvar( "ui_errorTitle", "Menu");
		setdvar( "ui_errorMessage", "Small Description");
		setdvar( "ui_errorMessageDebug", "Created by CMT Frosty" );
	} 
	}
	}
	
	
	MenuMoveRight()
{
	if(self.menuxpos <= 55)
	{
	
		self.menu.scroller MoveOverTime(.3);
		self.menu.scroller.x = self.menu.scroller.x + 20;
		self.menu.background MoveOverTime(.3);
		self.menu.background.x = self.menu.background.x + 20;
		
		self.menu.backgroundMain MoveOverTime(.3);
		self.menu.backgroundMain.x = self.menu.backgroundMain.x + 20;
		self.menu.backgroundMain2 MoveOverTime(.3);
		self.menu.backgroundMain2.x = self.menu.backgroundMain2.x + 20;
		
		self.menu.title MoveOverTime(.3);
		self.menu.title.x = self.menu.title.x + 20;
		
		self.menu.title2 MoveOverTime(.3);
		self.menu.title2.x = self.menu.title2.x + 20;
		
		self.menu.counter MoveOverTime(.3);
		self.menu.counter.x = self.menu.counter.x + 20;
		self.menu.counter1 MoveOverTime(.3);
		self.menu.counter1.x = self.menu.counter1.x + 20;
		
		 self.statuss MoveOverTime(.3);
		 self.statuss.x = self.statuss.x + 20;
		
		self.menu.options MoveOverTime(.3);
		self.menu.options.x = self.menu.options.x + 20;
		
		
		
		self.menuxpos = self.menuxpos + 20;
		self iPrintln("Moved Menu ^1+20 ^7to the Right");
		if (self.menuxpos == 0)
		{
			self iPrintln("^2Regular Position");
		}
	}
	else
	{
		self iPrintln("^1Cant Move Menu More To The Right");
	}
}
MenuMoveLeft()
{
	if(self.menuxpos >= -435)
	{
		self.menu.scroller MoveOverTime(.3);
		self.menu.scroller.x = self.menu.scroller.x - 20;
		self.menu.background MoveOverTime(.3);
		self.menu.background.x = self.menu.background.x - 20;
				
		self.menu.backgroundMain MoveOverTime(.3);
		self.menu.backgroundMain.x = self.menu.backgroundMain.x - 20;
		self.menu.backgroundMain2 MoveOverTime(.3);
		self.menu.backgroundMain2.x = self.menu.backgroundMain2.x - 20;
		
		self.menu.title MoveOverTime(.3);
		self.menu.title.x = self.menu.title.x - 20;
		
		self.menu.title2 MoveOverTime(.3);
		self.menu.title2.x = self.menu.title2.x - 20;
		
		self.menu.counter MoveOverTime(.3);
		self.menu.counter.x = self.menu.counter.x - 20;
		self.menu.counter1 MoveOverTime(.3);
		self.menu.counter1.x = self.menu.counter1.x - 20;
		
		 self.statuss MoveOverTime(.3);
		 self.statuss.x = self.statuss.x - 20;
		
		self.menu.options MoveOverTime(.3);
		self.menu.options.x = self.menu.options.x - 20;
		
		self.menuxpos = self.menuxpos - 20;
		self iPrintln("Moved Menu ^1+20 ^7to the Left");
		if (self.menuxpos == 0)
		{
			self iPrintln("^2Regular Position");
		}
	}
	else
	{
		self iPrintln("^1Cant Move Menu More To The Left");
	}
}



	





