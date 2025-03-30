/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Creator : YouViolateMe
*	 Project : Cursor Controlled Menu
*    Mode : Multiplayer
*	 Date : 2015/06/18 - 11:42:01	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    level thread onPlayerConnect();
    
    level.result = 0;
    level.cursor_spacing = 20.54; //spacing for menu options
    level.Verified = []; //holds verified user data
    
    precacheShader("rank_prestige08");
    precacheShader("rank_prestige09");
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	
	self checkIfVerified();
	
	if (self isHost())
	{
		thread overflowfix(); //should only be called once
	}
	
	self.CursorMenu = spawnStruct();
	self thread BuildMenu(); //should only be called once
	self thread MonitorPulse(); //should only be called once
	self thread MonitorDeath();
	        
    for(;;)
    {
        self waittill("spawned_player");
		
		// Will appear each time when the player spawn, that's just an exemple.
		self iprintln("Black Ops 2 - GSC Studio | Project : ^2Cursor Controlled Menu Base");
		
		self freezecontrols(false);
		
		if (self isHost() || self isVerified())
		{
			self thread monitorButtons();
		}
    }
}

BuildMenu()
{
	self endon("disconnect");
	
	self.CursorMenu.InMenu = false;
	
	if (self isHost())
		self.CursorMenu.MenuAccess = "Host";
	else
		self.CursorMenu.MenuAccess = "Unverified";
	
	self.CursorMenu.menutotal = 0;
	self.CursorMenu.ival = 0;
	self.CursorMenu.LeftRightScroll = 0;
	
	self.CursorMenu.OptionElements = [];
	
	self.CursorMenu.menuopt = [];
	self.CursorMenu.menufunc = [];
	self.CursorMenu.menuinput = [];
	self.CursorMenu.menuinput1 = [];
	self.CursorMenu.menuinput2 = [];
	
	self.CursorMenu.menus = [];
	self.CursorMenu.menucount = [];
	self.CursorMenu.subtitle = [];
	self.CursorMenu.menusubtitle = [];
	self.CursorMenu.previousmenu = [];
	self.CursorMenu.VerificationStatus = [];
	
	self AddOptions();
	
	self.CursorMenu.curMenu = self.CursorMenu.menus[0];
	self.CursorMenu.curTitle = self.CursorMenu.menusubtitle[0];
			
	self.CursorMenu.MainElements = [];
	
	self.CursorMenu.MainElements["Background"] = newclienthudelem(self);
	self.CursorMenu.MainElements["Background"].x = 0;
	self.CursorMenu.MainElements["Background"].y = 0; 
	self.CursorMenu.MainElements["Background"].horzAlign = "fullscreen";
	self.CursorMenu.MainElements["Background"].vertAlign = "fullscreen";
	self.CursorMenu.MainElements["Background"].sort = 0; 
	self.CursorMenu.MainElements["Background"] SetShader( "black", 640, 480 ); 
	self.CursorMenu.MainElements["Background"].alpha = 0;
	self.CursorMenu.MainElements["Background"].hideWhenInMenu = true;
	
	self.CursorMenu.MainElements["SelectionDot"] = self createRectangle("CENTER", "CENTER", 0, 0, 20, 20, 10, (1, 1, 1), 0, "rank_prestige10");
	
	self.CursorMenu.MainElements["LeftTitle"] = self createText("default", 1, "CENTER", "CENTER", -110, -170, 8, 0, (1, 1, 1), "");
	self.CursorMenu.MainElements["MidTitle"] = self createText("default", 1.4, "CENTER", "CENTER", 0, -170, 8, 0, (1, 1, 1), self.CursorMenu.menusubtitle[0]);
	self.CursorMenu.MainElements["RightTitle"] = self createText("default", 1, "CENTER", "CENTER", 110, -170, 8, 0, (1, 1, 1), self.CursorMenu.menusubtitle[1]);
	
	self.CursorMenu.MainElements["LeftArrow"] = self createRectangle("CENTER", "CENTER", -190, -170, 20, 20, 4, (1, 1, 1), 0, "rank_prestige08");
	self.CursorMenu.MainElements["RightArrow"] = self createRectangle("CENTER", "CENTER", 190, -170, 20, 20, 4, (1, 1, 1), 0, "rank_prestige09");
}

openMenu()
{
	self.StartingAngles = self getplayerangles();
	self.StartingPos = self.origin;
	
	elem = self.CursorMenu.MainElements["SelectionDot"];
	elem SetPoint("", "", 0, 0);
			
	self setClientUiVisibilityFlag("hud_visible", 0);
	self.CursorMenu.MainElements["SelectionDot"].alpha = 1;
	self.CursorMenu.MainElements["Background"].alpha = 1;
	
	self.CursorMenu.MainElements["LeftTitle"].alpha = 1;
	self.CursorMenu.MainElements["MidTitle"].alpha = 1;
	self.CursorMenu.MainElements["RightTitle"].alpha = 1;
	
	self.CursorMenu.MainElements["LeftArrow"].alpha = 1;
	self.CursorMenu.MainElements["RightArrow"].alpha = 1;
	
	self SetBlur( 15.3, 0.2 );
	self useServerVisionSet(true);
    self SetVisionSetforPlayer("mpintro", 0);
    
    self disableweapons();
    self freezecontrolsallowlook(1);
    
    setDvar("cg_crosshairAlpha", 0);
    
    self iprintln("Menu ^2Opened");
	self.CursorMenu.InMenu = true;
    
	self thread MonitorPosition();
	self thread submenu(self.CursorMenu.curMenu, self.CursorMenu.curTitle);
}

closeMenu()
{
	self setClientUiVisibilityFlag("hud_visible", 1);
	self.CursorMenu.MainElements["SelectionDot"].alpha = 0;
	self.CursorMenu.MainElements["Background"].alpha = 0;
	
	self.CursorMenu.MainElements["LeftTitle"].alpha = 0;
	self.CursorMenu.MainElements["MidTitle"].alpha = 0;
	self.CursorMenu.MainElements["RightTitle"].alpha = 0;
	
	self.CursorMenu.MainElements["LeftArrow"].alpha = 0;
	self.CursorMenu.MainElements["RightArrow"].alpha = 0;
	
	foreach(element in self.CursorMenu.OptionElements)
	{
		element stopPulse();
		element.alpha = 0;
	}
	
	self SetBlur( 0, 0.2 );
	self useServerVisionSet(false);
    self SetVisionSetforPlayer("default", 1);
    
    self enableweapons();
    self freezecontrolsallowlook(0);
    
    setDvar("cg_crosshairAlpha", 1);
    
    self iprintln("Menu ^1Closed");
	self.CursorMenu.InMenu = false;
    
	self notify("closedMenu");
}

buttonPressed(button)
{
	if(button == "[]")
		return self useButtonPressed();
		
	if(button == "X")
		return self jumpButtonPressed();
		
	if(button == "O")
		return self stanceButtonPressed();
		
	if(button == "DPAD_UP")
		return self actionSlotOneButtonPressed();

	if(button == "DPAD_DOWN")
		return self actionSlotTwoButtonPressed();

	if(button == "R2")
		return self attackButtonPressed();

	if(button == "L2")
		return self adsButtonPressed();

	if(button == "R3")
		return self meleeButtonPressed();
}

monitorButtons()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		if(self isVerified())
		{
			if(self.CursorMenu.InMenu)
			{
				if(buttonPressed("X"))
				{
					select();
					wait 0.25;
				}
				
				if(buttonPressed("[]"))
				{
					if(isDefined(self.CursorMenu.previousmenu[self.CursorMenu.curMenu]))
					{
						self submenu(self.CursorMenu.previousmenu[self.CursorMenu.curMenu], self.CursorMenu.subtitle[self.CursorMenu.previousmenu[self.CursorMenu.curMenu]]);
					}
					else
					{
						self thread closeMenu();
					}
					wait 0.25;
				}
				
				if(buttonPressed("R2"))
				{
					nextMenu();
					wait 0.25;
				}
	
				if(buttonPressed("L2"))
				{
					prevMenu();
					wait 0.25;
				}
				
				if(buttonPressed("R3"))
				{
					self thread closeMenu();
					self notify("closedMenu");
				}
			}
			else
			{
				if(buttonPressed("DPAD_UP"))
				{
					self thread openMenu();
					wait 0.25;
				}
			}
		}

		wait 0.05;
	}
}

MonitorPosition() //this monitor's the cursor's position on your screen
{
	self endon("death");
	self endon("closedMenu");
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		
		if (!self.CursorMenu.InMenu)
			break;
		
		if (self.StartingAngles != self GetPlayerAngles())
		{
			cursorChangeX = (self getplayerangles()[1] - self.StartingAngles[1]) * 3;
			cursorChangeY = (self getplayerangles()[0] - self.StartingAngles[0]) * 3;
			
			elem = self.CursorMenu.MainElements["SelectionDot"];
			
			
			//below checks to see whether the cursor is going out of bounds
			if (elem.x >= 315)
				elem SetPoint("", "", 314, elem.y);
			else if (elem.x <= -315)
				elem SetPoint("", "", -314, elem.y);
			else if (elem.y >= 220)
				elem SetPoint("", "", elem.x, 219);
			else if (elem.y <= -220)
				elem SetPoint("", "", elem.x, -219);
			else
				elem SetPoint("", "", elem.x-cursorChangeX, elem.y+cursorChangeY );
			
			self SetPlayerAngles(self.StartingAngles); //resets player angles, this is MANDATORY/REQUIRED!
		}
		
		
		wait 0.0005;
	}
}

MonitorDeath()
{
	self endon("disconnect");
	level endon("game_ended");
	
	for(;;)
	{
		self waittill("death");
		
		self thread closeMenu();
		
		self thread resetBooleans();
	}
}

select()
{
	cursor = self.CursorMenu.MainElements["SelectionDot"];
	prevArrow = self.CursorMenu.MainElements["LeftArrow"];
	nextArrow = self.CursorMenu.MainElements["RightArrow"];
	
	menu1 = self.CursorMenu.MainElements["LeftTitle"];
	menu2 = self.CursorMenu.MainElements["MidTitle"];
	menu3 = self.CursorMenu.MainElements["RightTitle"];
	
	if (is_touching(nextArrow, cursor)) //check if cursor is touching "right arrow"
		nextMenu();
	else if (is_touching(prevArrow, cursor)) //check if cursor is touching "left arrow"
		prevMenu();
	else
	{
		for(i = 0; i < self.CursorMenu.menucount[self.CursorMenu.curMenu]; i++)
		{
			self.CursorMenu.ival = i;
			if (is_touching(self.CursorMenu.OptionElements[i], cursor)) //checks to see if cursor is touching any options
			{
				self thread [[self.CursorMenu.menufunc[self.CursorMenu.curMenu][self.CursorMenu.ival]]](self.CursorMenu.menuinput[self.CursorMenu.curMenu][i], self.CursorMenu.menuinput1[self.CursorMenu.curMenu][i], self.CursorMenu.menuinput2[self.CursorMenu.curMenu][i]);
				break;
			}
		}
	}
	
	self PlaySoundToPlayer( "wpn_satchel_plant_water", self );
}

is_touching(elem, cursor) //my custom function, checks to see whether or not 2 HUD elements are touching
{
	
	xval = elem.x;
	yval = elem.y;
	
	xtest = cursor.x - xval;
	ytest = cursor.y - yval;
	
	if ((xtest > -20 && xtest < 20) && (ytest > -10 && ytest < 10))
		return true;
	else
		return false;
}

nextMenu()
{
	self clearPlayerMenu();
	
	if (self.CursorMenu.LeftRightScroll == self.CursorMenu.menutotal - 1)
	{
		self.CursorMenu.LeftRightScroll = 0;
			
		self thread submenu(self.CursorMenu.menus[self.CursorMenu.LeftRightScroll], self.CursorMenu.menusubtitle[self.CursorMenu.LeftRightScroll]);
		
	}
	else
	{
		self.CursorMenu.LeftRightScroll++;
			
		self thread submenu(self.CursorMenu.menus[self.CursorMenu.LeftRightScroll], self.CursorMenu.menusubtitle[self.CursorMenu.LeftRightScroll]);
	}
}

prevMenu()
{
	self clearPlayerMenu();
	
	if (self.CursorMenu.LeftRightScroll == 0)
	{
		self.CursorMenu.LeftRightScroll = self.CursorMenu.menutotal - 1;
			
		self thread submenu(self.CursorMenu.menus[self.CursorMenu.LeftRightScroll], self.CursorMenu.menusubtitle[self.CursorMenu.LeftRightScroll]);
		
	}
	else
	{
		self.CursorMenu.LeftRightScroll--;
			
		self thread submenu(self.CursorMenu.menus[self.CursorMenu.LeftRightScroll], self.CursorMenu.menusubtitle[self.CursorMenu.LeftRightScroll]);
	}
}

submenu(input, title)
{
	self.CursorMenu.curMenu = input;
	self.CursorMenu.curTitle = title;
	
	if (input == "players")
		self monitorPlayers();
	
	if (verificationToNum(self.CursorMenu.MenuAccess) >= verificationToNum(self.CursorMenu.VerificationStatus[input]))
	{
	    foreach(element in self.CursorMenu.OptionElements)
	    {
	    	element destroy();
	    }
	    
		self thread StoreText(input, title);
	}
	else
		self iPrintln("Sorry, you don't have access to this menu!");
}

StoreText(input, title)
{
	self endon("death");
	self endon("disconnect");
	
	for(i = 0; i < self.CursorMenu.menucount[input]; i++)
    {
    	self.CursorMenu.OptionElements[i] = self createText("default", 1.2, "CENTER", "CENTER", 0, -140 + (i * level.cursor_spacing), 8, 0, (1, 1, 1), self.CursorMenu.menuopt[input][i]);
    }
    
    level.result += 1;
    self.CursorMenu.MainElements["LeftTitle"] setText(self.CursorMenu.menusubtitle[self.CursorMenu.LeftRightScroll - 1]);
    level notify("textset");
    
    level.result += 1;
    self.CursorMenu.MainElements["MidTitle"] setText(title);
    level notify("textset");
    
    level.result += 1;
    self.CursorMenu.MainElements["RightTitle"] setText(self.CursorMenu.menusubtitle[self.CursorMenu.LeftRightScroll + 1]);
    level notify("textset");
    
}









