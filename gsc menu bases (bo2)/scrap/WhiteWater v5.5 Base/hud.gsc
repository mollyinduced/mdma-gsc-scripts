startMenu()
{
	self.menu.open = false;

	self.menu.Background = createRectangle("CENTER", "CENTER", 0, 0, 225, 500, 1, (0,0,0), 0, "white");
	self.menu.title = self createText("default", 2, "CENTER", "CENTER", 10, -185, 8, 0, (1, 1, 1), "^4Players\t\t\t\t\t\t\t\t^7[ White Water ]\t\t\t\t\t\t\t\t^4All Players");
	self.menu.scroller = self createRectangle("CENTER", "CENTER", 0, -150, 225, 18, 1, (0, 1, 1), 0, "line_horizontal");
	self.menu.titlescroller = self createRectangle("CENTER", "CENTER", -100, -185, 200, 30, 1, (0, 0, 0), 0, "line_horizontal");

	self thread closeMenu();
}

storeText(input, title)
{
	self endon("death");
	self endon("disconnect");
	
	self.menu.currentmenu = input;
	
	opts = "";
	
	for(i = 0; i < self.menu.menucount[input]; i++)
	{
		opts += self.menu.menuopt[input][i] + "\n";
	}
	
	self.menu.options = createText("objective", 1.7, "CENTER", "CENTER", 0, -150, 8, 0.75, (1, 1, 1), opts);

	self updateScrollbar();
}

updateScrollbar()
{
	cursorIndex = self.menu.curs[self.menu.currentmenu];
	
	self.menu.scroller MoveOverTime(0.15);
	self.menu.scroller.y = -150 + (self.menu.curs[self.menu.currentmenu] * level.cursor_spacing);
}

onDied()
{
	self endon("disconnect");
	
	for(;;)
	{
		self waittill("death");
		
		self.menu.open = false;
		
		self thread closeMenu();
		
		self.menu.Background destroy();
		
		self.menu.title destroy();
		
		self.menu.options destroy();
		
		self.menu.scroller destroy();
		
		self.menu.titlescroller destroy();
		
		self.menu.menutotal = 0;
		self.menu.curMenu = 1;
	}
}





