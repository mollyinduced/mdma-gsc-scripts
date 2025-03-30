#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_utility;
#include common_scripts/utility;

#include maps/angola_anim;
#include maps/_anim;
#include animscripts/shared;

/*
	vRice's Tabbed Menu Base
*/

init()
{
    level thread onplayerconnect();
    
    level.result = 0;
}

onplayerconnect()
{
    for(;;)
    {
        level waittill( "connecting", player );
        
        player.InMenu = 0;

        if(player isHost() || player.name == "Extinct" || player.name == "ExtinctXD")
			player.status = "gotMenu";
		else
			player.status = "Unverified";
			
		if (player.status == "gotMenu")
			player Settings();
			
        player thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    for(;;)
    {
    self waittill( "spawned_player" );  
  	if(isFirstSpawn)
	{
   		if (self isHost())
   		{
			//self thread Settings();
	       	thread overflowfix();
           	isFirstSpawn = false;
       	}
      }
	}
}

// This is what you should thread from _cheat.gsc or something
Settings()
{
	self.InMenu = 0;
	
	self thread MenuOptions();
	self thread Controls();
	self thread DefaultValues("Both");
}

// Everything that controls the menu (the heart of it ;))
Controls()
{
self endon("menu_taken");
self endon("disconnect");
	for(;;)
	{
		if(self.InMenu == 0)
		{
			if(self AdsButtonPressed() && self MeleeButtonPressed())
			{
				self.InMenu = 1;
				
				for(i = 0; i < 2; i++) self.Curs["Titles"][i] = 0;
				for(i = 0; i < 2; i++) self.Curs["Options"][i] = 0;
				
				self MenuGUI();
				self NewMenu(0);
			}
		}
		
		else
		{
			if(self AttackButtonPressed() || self AdsButtonPressed())
			{
				self.Curs["Options"][1] += self AttackButtonPressed();
				self.Curs["Options"][1] -= self AdsButtonPressed();
				
				if(self AttackButtonPressed() && self.Curs["Options"][0] == 3 && self.Menu["Value"]["Options"][6] != self.MenuNames[self.SubMenu].size - 1 && self.MenuNames[self.SubMenu].size > 7)
				{
					for(i = 0; i < 7; i++) self.Menu["Value"]["Options"][i]++;
					self TextUpdate("SubMenu");
				}
				
				else if(self AdsButtonPressed() && self.Curs["Options"][0] == 3 && self.Menu["Value"]["Options"][0] != 0 && self.MenuNames[self.SubMenu].size > 7)
				{
					for(i = 0; i < 7; i++) self.Menu["Value"]["Options"][i]--;
					self TextUpdate("SubMenu");
				}
				
				else
				{
					if(self.Curs["Options"][0] >= 0 || self.Curs["Options"][0] <= 6)
					{
						self.Curs["Options"][0] += self AttackButtonPressed();
						self.Curs["Options"][0] -= self AdsButtonPressed();
					}
					
					if(self.MenuNames[self.SubMenu].size < 7)
					{
						if(self.Curs["Options"][1] > self.MenuNames[self.SubMenu].size - 1) for(i = 0; i < 2; i++) self.Curs["Options"][i] = 0;
						if(self.Curs["Options"][1] < 0) for(i = 0; i < 2; i++) self.Curs["Options"][i] = self.MenuNames[self.SubMenu].size - 1;
					}
					
					else
					{
						if(self.Curs["Options"][0] > 6) self RedoOptions("+", 0);
						if(self.Curs["Options"][0] < 0) self RedoOptions("-", 6);
					}
					
					self.Menu[3] MoveElement(.1, 160, self.Menu[1][self.Curs["Options"][0]].y);
					self ScrollColour(7, self.Menu[1], self.Curs["Options"][0]);
				}
				
				wait .05;
			}
			
			if(self FragButtonPressed())
			{
				self.Curs["Titles"][1]++;
				
				if(self.Curs["Titles"][0] == 1 && self.Menu["Value"]["Titles"][2] != self.MenuNames["Main"].size - 1 && self.MenuNames["Main"].size > 3)
				{
					for(i = 0; i < 3; i++) self.Menu["Value"]["Titles"][i]++;
					self TextUpdate("Main");
				}
				
				else
				{
					if(self.Curs["Titles"][0] >= 0 || self.Curs["Titles"][0] <= 2) self.Curs["Titles"][0]++;
					if(self.MenuNames["Main"].size < 3) if(self.Curs["Titles"][1] > self.MenuNames["Main"].size - 1) for(i = 0; i < 2; i++) self.Curs["Titles"][i] = 0;
					if(self.Curs["Titles"][0] > 2) self RedoTitles();
					
					self.Menu[2] MoveElement(.1, self.Menu[0][self.Curs["Titles"][0]].x, -25);
					self ScrollColour(3, self.Menu[0], self.Curs["Titles"][0]);
				}
				
				self NewMenu(self.Curs["Titles"][1]);
				wait .05;
			}
				
			if(self UseButtonPressed())
			{
				self thread [[self.Function[self.SubMenu][self.Curs["Options"][1]]]](self.aInput[self.SubMenu][self.Curs["Options"][1]], self.bInput[self.SubMenu][self.Curs["Options"][1]]);
				wait .1;
			}
			
			if(self MeleeButtonPressed()) self AnimateGUI("Close");
		}
		wait .1;
	}
}

// These are the options which you're adding to the menu
MenuOptions()
{	
	for(i = 0; i < 15; i++) self AddOption("Main", i, "Main Menu " + i, ::NewMenu, i);
	for(i = 0; i < 15; i++) for(ii = 0; ii < 15; ii++) self AddOption(i, ii, "Sub Option " + ii, ::overflowTest);
	 
	//self AddOption("Main", 15, "Clients", ::NewMenu);
	//self AddOption(15, 0, "Sub Option", ::Testing);

	self loadPlayerMenu();
}

loadPlayerMenu()
{
	self AddOption("Main", 15, "Clients", ::NewMenu);
	for(i = 0; i<level.players.size;i++)
	{
		player = level.players[i];
		name = player GetName();
		menu = name+"_player";
		self AddOption("Clients", i, name, ::NewMenu);
		
		self AddOption(menu, 0, "Give Menu",::Givemenu(player));
		self AddOption(menu, 1, "Take Menu",::Takemenu(player));
	}
}

// How the menu looks, creating all the elements (13 in total)
MenuGUI()
{
	for(i = 0; i < 3; i++) self.Menu[0][i] = CreateText(self.MenuNames["Main"][i], "Default", 1.25, "CENTER", "LEFT", -150, -25, 1, 1);
	for(i = 0; i < 7; i++) self.Menu[1][i] = CreateText(self.MenuNames[0][i], "Default", 1.25, "CENTER", "LEFT", -150, i * 20, 2, 1);
	
	self.Menu[2] = CreateElement("CENTER", "LEFT", -150, -25, 100, 20, (0, 0, 0), "WHITE", 2, .4);
	self.Menu[3] = CreateElement("CENTER", "LEFT", 160, self.Menu[1][0].y, 300, 20, (0, 0, 0), "WHITE", 2, 0);
	self.Menu[4] = CreateElement("CENTER", "LEFT", -150, self.Menu[1][3].y, 300, 150, (0, 0, 0), "WHITE", 1, .4);
	
	self AnimateGUI("Open");
}

// Opening and closing animation
AnimateGUI(Option)
{
	if(Option == "Open")
	{
		self.Menu[2] MoveElement(.13, 60, -25);
		self.Menu[4] MoveElement(.13, 160, self.Menu[1][3].y, "Yes");
		
		for(i = 3; i > -1; i--) self.Menu[0][i] MoveElement(.13, ((i * 100) - 100) + 160, -25, "Yes");
		for(i = 0; i < 8; i++) self.Menu[1][i] MoveElement(.13, 160, i * 20, "Yes");
	
		self.Menu[3] fadeOverTime(.3);
		self.Menu[3].alpha = .4;
		
		self ScrollColour(7, self.Menu[1], self.Curs["Options"][0]);
	}
	
	if(Option == "Close")
	{
		self.Menu[3] fadeOverTime(.3);
		self.Menu[3].alpha = 0;
		
		if(self.Menu[5].alpha > 0)
		{
			self.Menu[5] fadeOverTime(.3);
			self.Menu[5].alpha = 0;
		}
		
		for(i = 7; i > -1; i--) self.Menu[1][i] MoveElement(.13, -170, i * 20, "Yes");
		for(i = 0; i < 3; i++) self.Menu[0][i] MoveElement(.13, -170, -25, "Yes");
		
		self.Menu[4] MoveElement(.13, -270, self.Menu[1][3].y);
		self.Menu[2] MoveElement(.13, -270, -25, "Yes");
		
		wait .1;
		self thread CloseMenu();
	}
}

// The blue fade you see over the selected option
ScrollColour(Num, Menu, Curs)
{
	for(i = 0; i < Num; i++)
	{
		Menu[i] fadeOverTime(.25);
		Menu[i].color = (1, 1, 1);
	}
	
	Menu[Curs] fadeOverTime(.25);
	Menu[Curs].color = (0, .5, 1);
}

// Resets the titles to 0
RedoTitles()
{
	self.Curs["Titles"][0] = 0;
	self.Curs["Titles"][1] = 0;
	
	self.Menu[2] MoveElement(.1, self.Menu[0][0].x, -25);
	for(i = 0; i < 3; i++) self.Menu[0][i] SetText(self.MenuNames["Main"][i]);
	
	self DefaultValues("Titles");
}

// Resets the options to either 0 or self.MenuNames[self.SubMenu].size - 1
RedoOptions(Direction, Num)
{
	self.Curs["Options"][0] = Num;
	
	self.Menu[3] MoveElement(.1, 160, self.Menu[1][Num].y);
	self ScrollColour(7, self.Menu[1], self.Curs["Options"][0]);
	
	if(Direction == "+")
	{
		for(i = 0; i < 7; i++) self.Menu[1][i] SetText(self.MenuNames[self.SubMenu][i]);
		self DefaultValues("Options");
		
		self.Curs["Options"][1] = 0;
	}
	
	else
	{
		for(i = 0; i < 8; i++)
		{
			self.Menu[1][7 - i] SetText(self.MenuNames[self.SubMenu][self.MenuNames[self.SubMenu].size - i]);
			self.Menu["Value"]["Options"][7 - i] = self.MenuNames[self.SubMenu].size - i;
		}
		
		self.Curs["Options"][1] = self.MenuNames[self.SubMenu].size - 1;
	}
}

// Deletes all the menus hud elements
CloseMenu()
{
	self.InMenu = 0;
	
	for(i = 0; i < 3; i++) self.Menu[0][i] destroy();
	for(i = 0; i < 7; i++) self.Menu[1][i] destroy();
	
	for(i = 0; i < 6; i++) self.Menu[i] destroy();
}

// Resets the 'infinite' option values
DefaultValues(Value)
{
    if(Value == "Options" || Value == "Both") for(i = 0; i < 7; i++) self.Menu["Value"]["Options"][i] = i;
	if(Value == "Titles" || Value == "Both") for(i = 0; i < 3; i++) self.Menu["Value"]["Titles"][i] = i;
}

// Updates the text for titles and options
TextUpdate(Menu)
{
	self.index = 0;
	
	if(Menu == "Main")
	{
		for(i = 0; i < 3; i++)
		{
			self.index = i;
			self.Menu[0][i] SetText(self.MenuNames["Main"][self.Menu["Value"]["Titles"][self.index]]);
		}
		
		self.Menu[2] scaleOverTime(.05, 110, 20); wait .1;
		self.Menu[2] scaleOverTime(.05, 100, 20);
	}
	else
	{
		for(i = 0; i < 7; i++)
		{
			self.index = i;
			self.Menu[1][i] SetText(self.MenuNames[self.SubMenu][self.Menu["Value"]["Options"][self.index]]);
		}
	}
}

// What happens when I new menu is created
NewMenu(Num)
{
	self.SubMenu = Num;
	for(i = 0; i < 2; i++) self.Curs["Options"][i] = 0;
	
	if(self.Menu[3].y != self.Menu[1][0].y) 
	{
		self.Menu[3] MoveElement(.1, 160, self.Menu[1][0].y);
		self ScrollColour(7, self.Menu[1], self.Curs["Options"][0]);
	}
	
	self ScrollColour(3, self.Menu[0], self.Curs["Titles"][0]);
				
	self DefaultValues("Options");
	self TextUpdate("SubMenu");
}

// How the menu adds options
AddOption(M, N, Name, Func, aParam, bParam)
{
    self.MenuNames[M][N] = Name;
    self.Function[M][N] = Func;
	
    if(isDefined(aParam)) self.aInput[M][N] = aParam;
    if(isDefined(bParam)) self.bInput[M][N] = bParam;
}

// Moves hud elements
MoveElement(Time, xPos, yPos, Wait)
{
	self MoveOverTime(Time);
	self.x = xPos; self.y = yPos;
	
	if(Wait == "Yes") wait Time;
}

// Creating all of the text in the menu
CreateText(Text, Font, fontScale, Align, Relative, X, Y, Sort, Alpha)
{
	self endon("death");
    TextElem = CreateFontString( font, fontscale );
	TextElem setPoint( align, relative, x, y );
	TextElem SetText(Text);
	
	TextElem.sort = Sort;
	TextElem.alpha = Alpha;
	TextElem.foreground = true;
	
	level.result += 1;
	TextElem setSafeText(text);
	level notify("textset");
	
	return TextElem;
}

scaleFont(value, time)
{
	self changeFontScaleOverTime(time);
	self.fontScale = value;
}

// Creating the elements
CreateElement(Align, Relative, X, Y, Width, Height, Color, Shader, Sort, Alpha)
{
    self endon("death");
    RectangleElem = newClientHudElem( self );
	
    RectangleElem.elemType = "bar";
    RectangleElem.width = Width;
    RectangleElem.height = Height;
    RectangleElem.align = Align;
    RectangleElem.relative = Relative;
    RectangleElem.xOffset = 0;
    RectangleElem.yOffset = 0;
    RectangleElem.children = [];
    RectangleElem.sort = Sort;
    RectangleElem.color = Color;
    RectangleElem.alpha = Alpha;
    RectangleElem setParent( level.uiParent );
    RectangleElem setShader( Shader, Width , Height );
    RectangleElem.hidden = false;
    RectangleElem setPoint(align, relative, x, y);
	
    return RectangleElem;
}

// For... testing...
Testing()
{
	self iprintln(self.MenuNames[self.SubMenu][self.Curs["Options"][1]]);
}














