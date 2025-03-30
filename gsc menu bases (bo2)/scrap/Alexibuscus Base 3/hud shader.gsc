updateScrollbar()
{
	self.menu.scroller MoveOverTime(0.10);
	self.menu.scroller.y = 60 + (self.menu.curs[self.menu.currentmenu] * 15.6);
}

openMenu()
{
    self freezeControls(false);
    self StoreText("Main Menu", "Main Menu");


    self.menu.background FadeOverTime(0.30);
    self.menu.background.alpha = 0.7;
    	
	if(getDvar("animation_menu") == "1")
	{
	self.menu.background2 FadeOverTime(0.30);
	self.menu.background2.alpha = 0.6;
	}

	self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -50;	
	self.menu.line2 MoveOverTime(0.30);
	self.menu.line2.y = -50;
	self.menu.line3 FadeOverTime(0.30);
	self.menu.line3.alpha = 1;
	self.menu.line4 FadeOverTime(0.30);
	self.menu.line4.alpha = 1;
	self.menu.line5 FadeOverTime(0.30);
	self.menu.line5.alpha = 1.1;
	self.menu.creatortxt FadeOverTime(0.30);
	self.menu.creatortxt.alpha = 1;
	self.menu.header FadeOverTime(0.30);
	self.menu.header.alpha = 1.3;

    self updateScrollbar();
    self.menu.open = true;
}

closeMenu()
{
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 0;
	
	self.tez FadeOverTime(0.3);
    self.tez.alpha = 0;
    
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
    

    self.menu.title FadeOverTime(0.30);
    self.menu.title.alpha = 0;
    
	self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -550;
	self.menu.line2 MoveOverTime(0.30);
	self.menu.line2.y = -550;
	self.menu.line3 FadeOverTime(0.30);
	self.menu.line3.alpha = 0;
	self.menu.line4 FadeOverTime(0.30);
	self.menu.line4.alpha = 0;
	self.menu.line5 FadeOverTime(0.30);
	self.menu.line5.alpha = 0;
	
    self.menu.creatortxt FadeOverTime(0.30);
	self.menu.creatortxt.alpha = 0;

	if(getDvar("animation_menu") == "1")
	{
	self.menu.background2 FadeOverTime(0.30);
	self.menu.background2.alpha = 0;
	}
	self.menu.header FadeOverTime(0.30);
	self.menu.header.alpha = 0;

	self.menu.scroller MoveOverTime(0.30);
	self.menu.scroller.y = -510;
    self.menu.open = false;
}

destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
	wait 0.3;

	player.menu.options destroy();	
	player.menu.background destroy();
	player.menu.background2 destroy();
	player.menu.scroller destroy();
	player.menu.scroller1 destroy();
	player.menu.header destroy();
	player.infos destroy();
	player.menu.line destroy();
	player.menu.line2 destroy();
	player.menu.line3 destroy();
	player.menu.line4 destroy();
	player.menu.line5 destroy();
	player.menu.title destroy();
	player.menu.creatortxt destroy();
	player notify("destroyMenu");
}

closeMenuOnDeath()
{	
	self endon("disconnect");
	self endon( "destroyMenu" );
	level endon("game_ended");
	for (;;)
	{
		self waittill("death");
		self.menu.closeondeath = true;
		self submenu("Main Menu", "Main Menu");
		closeMenu();
		self.menu.closeondeath = false;
	}
}

StoreShaders() 
{
	self.menu.background = self drawShader("black", -300+self.x, -79, 160, 1000, (0, 0, 0), 0, 0);
	self.menu.background2 = self drawShader("compass_emp", -300+self.x, -79, 160,1000,(0,0.3,0.8),0,0);
	self.menu.scroller = self drawShader("ui_slider2", -300+self.x, -505, 160, 14, (0, 1, 1), 255, 1);
	self.menu.line = self drawShader("white", -380+self.x, -550, 3, 500, (0, 0, 1), 255, 3);
	self.menu.line2 = self drawShader("white", -220+self.x, -550, 3, 500, (0, 0, 1), 255, 3);
	self.menu.line3 = self drawShader("white", -300+self.x, 43.11, 160, 3, (0, 0, 1), 0, 0);
	self.menu.line4 = self drawShader("white", -300+self.x, 56.11, 160, 3, (0, 0, 1), 0, 0);
	self.menu.creatortxt = self drawText("Developed By: ^5Alexibuscus","Objective",1.2, -307+self.x, 44, self.textColour, 0, self.glowColour, 1, 3);
	self.menu.header = self drawShader("emblem_bg_movie_star", -300+self.x, -36.5, 160, 80, (1,1,1), 0, 0);
	self.menu.line5 = self drawShader("white", -300+self.x, 370.63, 160, 3, (0,0,1), 0, 0);
} 

StoreText(menu, title)
{
	self.menu.currentmenu = menu;
	string = "";
    self.menu.title destroy();
	self.menu.title = drawText(title, "objective", 2, -300+self.x, 10, self.textColour, 0, self.glowColour, 1, 5);
	self.menu.title FadeOverTime(0.3);
	self.menu.title.alpha = 1;
	self.menu.title.glowAlpha = 1;
	self notify ("stopScale");
    self.tez destroy();
    self.tez = self createFontString( "default", 2.3);
    self.tez setPoint( "CENTER", "TOP", -300+self.x, -10 );
    self.tez setText("Alexibuscus Base");
    self.tez FadeOverTime(0.3);
    self.tez.alpha = 1;
    self.tez.foreground = true;
    self.tez.archived = false;
    self.tez.glowAlpha = 1;
    self.tez.glowColor = self.titleColour;
    self.tez.color = self.textColour;
	
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string += self.menu.menuopt[menu][i] + "\n"; }

    self.menu.options destroy(); 
	self.menu.options = drawText(string, "objective", 1.3, -300+self.x, 59, self.textColour, -20, self.glowColour, -20, 59);
	self.menu.options FadeOverTime(0.3);
	self.menu.options.alpha = 1;
	self.menu.options.glowAlpha = 1;
}

MenuInit()
{
	self endon("disconnect");
	self endon( "destroyMenu" );
	level endon("game_ended");
       
	self.menu = spawnstruct();
	self.toggles = spawnstruct();
     
	self.menu.open = false;
	
	self StoreShaders();
	self CreateMenu();
	
	for(;;)
	{  
		if(self actionslotfourbuttonpressed() && self adsButtonPressed() && !self.menu.open)
		{
			openMenu();
			self setClientUiVisibilityFlag("hud_visible", 0);
		}
		if(self.menu.open)
		{
			if(self meleeButtonPressed())
			{
				if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
				{
					self submenu(self.menu.previousmenu[self.menu.currentmenu]);
				}
				else
				{
					closeMenu();
					self setClientUiVisibilityFlag("hud_visible", 1);
					self.tez destroy();
				}
				wait 0.2;
			}
			if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
			{	
				self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
				self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
				
				self updateScrollbar();
			}
			if(self jumpButtonPressed())
			{
				self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
				wait 0.2;
			}
		}
		wait 0.05;
	}
}
 
submenu(input, title)
{
	if (verificationToNum(self.status) >= verificationToNum(self.menu.status[input]))
	{
		self.menu.options destroy();

		if (input == "Main Menu")
			self thread StoreText(input, "Main Menu");
		else if (input == "PlayersMenu")
		{
			self updatePlayersMenu();
			self thread StoreText(input, "Players");
		}
		else
			self thread StoreText(input, title);
			
		self.CurMenu = input;
		
		self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
		self.menu.curs[input] = self.menu.scrollerpos[input];
		
		if (!self.menu.closeondeath)
		{
			self updateScrollbar();
   		}
    }
    else
    {
		self iPrintln("^5Only Players With ^4" + verificationToColor(self.menu.status[input]) + " ^5Can Access This Menu!");
    }
}


elemcolor(time, color)
{
    self fadeovertime(time);
    self.color = color;
}










