#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    level thread onPlayerConnect();
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
    for(;;)
    {
        self waittill("spawned_player");
		self thread nay1995s_Menu();
    }
}

CreateMenu_Text( menu )
{
	self.Menu["Current"] = menu;
	self.Menu["Cursor"] = 0;
	Text = "";
	string = "";
	Descs = "";
	
	self.Menu["Text"] = self CreateText("console", 1.8, "LEFT","LEFT", 550, -175,1,1000, "" );
	self.Menu["Top"] = self CreateText("console", 2.5, "LEFT","LEFT", 550, -210,1,1000, "" );
	self.Menu["Description"] = self CreateText("console", 1.8, "CENTER","CENTER", -100, -110,1,1000, "Information" );

// The below lines are needed, without them the player menu wont run correctly.
// Player Menu (No need to touch this)
for(i=0;i < level.players.size;i++)
{
player=level.players[i];
addItem(2,i,player.name, ::Sub, 3, "Player");
self.Menu["Title"][2] = "Player Menu";
}
// End Of Player Menu
	
	if(self.Menu["Current"] == 2)
	{
		for(i=0;i < level.players.size;i++)
		{
			player=level.players[i];
			Text += "[^1" +player.status + "^7] " + player.name + "\n";
			//self.MenuFunc[2][i]=::Sub;
			//self.MenuInput[2][i]=3;
		}
	}
	else for( i = 0; i < self.Menu[MenuReturn()].size; i++ ) 
	{
	Text += self.Menu[MenuReturn()][i]+ "\n";
	self.Menu["Text"] setText( Text );
	}
	
	self endon("disconnect");
	self endon("ClosedM");

    for (i = 0; i < self.Menu["Title"][MenuReturn()].size; i ++)
    {
	string += self.Menu["Title"][MenuReturn()][i];
	self.Menu["Top"] setText( string );
    }
	
	self.Menu["Information"][0] = self.Menu["Desc"][MenuReturn()][self.Menu["Cursor"]];
	for(i=0;i<self.Menu["Information"].size;i++)
	{
	self.Menu["Information"][i] = self CreateText("console",1.8,"LEFT","LEFT",175,-90,1,1000,self.Menu["Desc"][i]);
	}

	wait 0.05;
}
nay1995s_Menu()
{
self endon("StopModMenu");
self endon("disconnect");
self thread CreateMenu_ini();
self thread CreateMenu_Hud();

for(;;)
{
if(self.Menu["Current"] == 2)self.PlayerCurs=self.Menu["Cursor"];
    if(self FragButtonPressed() && self.menuOpen == false)
    {
    self freezecontrols(true);
    self.menuOpen = true;
	self.Menu["Cursor"] = 0;
    self thread CreateMenu_Text(0); // loads main menu
	self.Menu["ScrollBar"].alpha = 1;
	self.Menu["BackGround"].alpha = 0.5;
	self.Menu["InfoBox"].alpha = 0.5;
	self.Menu["InfoBoxLine"].alpha = 1;
	self.Menu["ScrollStar"].alpha = 1;
	self.Menu["ScrollBar"].y = -175;
	self.Menu["ScrollStar"].y = -175;
	self iPrintln("Subscribe to: www.YouTube.com/nay1995x \n He is the creator of this menu!"); // dont remove please.
    }
	if(self UseButtonPressed() && self.menuOpen == true && self.stopSQ == false)
	{
	self thread [[self.MenuFunc[self.Menu["Current"]][self.Menu["Cursor"]]]](self.MenuInput[self.Menu["Current"]][self.Menu["Cursor"]]);
	}
	if(self AttackButtonPressed() && self.menuOpen == true && self.stopR1 == false)
	{
	self.Menu["Cursor"]++;
	if(self.Menu["Cursor"]>self.Menu[MenuReturn()].size-1) self.Menu["Cursor"]=0;
	self.Menu["ScrollBar"] MoveElem("y", .3, (self.Menu["Cursor"]*22)-175);
	self.Menu["ScrollStar"] MoveElem("y", .3, (self.Menu["Cursor"]*22)-175);
	}
	if(self AdsButtonPressed() && self.menuOpen == true && self.stopL1 == false)
	{
    self.Menu["Cursor"]--;
	if(self.Menu["Cursor"]<0) self.Menu["Cursor"]=self.Menu[MenuReturn()].size-1;
	self.Menu["ScrollBar"] MoveElem("y", .3, (self.Menu["Cursor"]*22)-175);
	self.Menu["ScrollStar"] MoveElem("y", .3, (self.Menu["Cursor"]*22)-175);
	}
    if(self MeleeButtonPressed() && self.menuOpen == true && self.stopR3 == false)
    {
	if(self.Menu["Current"] == 0)
	{
	wait .05;
	self.Menu["Cursor"] = 0;
	self.menuOpen = false;
	self notify("ClosedM");
	self.Menu["ScrollBar"].alpha = 0;
	self.Menu["BackGround"].alpha = 0;
	self.Menu["InfoBox"].alpha = 0;
	self.Menu["InfoBoxLine"].alpha = 0;
	self.Menu["ScrollStar"].alpha = 0;
	self freezecontrols(false);
	}
	else if(isDefined(self.Menu["Parent"][MenuReturn()])) self thread Sub(self.Menu["Parent"][MenuReturn()]);
	else self thread Sub(0); // Sub default menu if parent isnt defined.
    }
	else if(self.menuOpen == false)
	{
	}
	// The below line shouldnt overflow the menu but 'if in doubt take it out' see below line for details :)
	self.Menu["Information"][0] setText(self.Menu["Desc"][MenuReturn()][self.Menu["Cursor"]]); // This needs to be looped as the cursor is always changing, if you fear this may overflow your menu just remove this line (This will remove the menu information)
	if(self.Menu["Current"] == 2)
	{
	PC = level.players[self.PlayerCurs];
	if(PC.status == "Host") self.Menu["ScrollStar"].color = (1,0,0);
	else if(PC.status == "Verified") self.Menu["ScrollStar"].color = (0,0,1);
	else if(PC.status == "VIP") self.Menu["ScrollStar"].color = (0,1,0);
	else if(PC.status == "Admin") self.Menu["ScrollStar"].color = (1,0,1);
	else if(PC.status == "None") self.Menu["ScrollStar"].color = (1,1,1);
	else self iPrintln("Error: Status isn't defined!");
	}
	else self.Menu["ScrollStar"].color = (1,1,1);
	wait .25;
}
}
CreateMenu_Hud()
{
self.Menu["ScrollBar"] = createRectangle("RIGHT", "RIGHT", 0, -175, 220, 20, (0.6,0,0.6), "progress_bar_bg", 2, 0);
self.Menu["ScrollStar"] = createRectangle("RIGHT", "RIGHT", -220, -175, 15, 15, (1,1,1), "ui_host", 10, 0);
self.Menu["ScrollStar"].color = (1,1,1);
self.Menu["BackGround"] = createRectangle("RIGHT", "RIGHT", 0, 0, 220, 650, (0,0,0), "progress_bar_bg", 1, 0);
self.Menu["InfoBox"] = createRectangle("RIGHT", "RIGHT", -250, -50, 300, 200, (0,0,0), "progress_bar_bg", 1, 0);
self.Menu["InfoBoxLine"] = createRectangle("RIGHT", "RIGHT", -250, -110, 300, 20, (0.6,0,0.6), "progress_bar_bg", 2, 0);
}
Sub(Menu)
{
	self notify("ClosedM");
	self thread CreateMenu_Text(Menu);
	self.Menu["Cursor"] = 0;
	self.Menu["ScrollBar"] MoveElem("y", .3, (self.Menu["Cursor"]*22)-175);
	self.Menu["ScrollStar"] MoveElem("y", .3, (self.Menu["Cursor"]*22)-175);
}
MenuReturn()
{
	return self.Menu["Current"];
}
CursReturn()
{
	return self.Menu["Cursor"];
}
CreateMenu_ini()
{
self.Menu["Title"][0] = "Main";
addItem(0,0,"Account Menu", ::Sub, 5, "Edit, Prestige, Rank, Leaderboard etc.");
addItem(0,1,"Test Clients", ::Test, "", "Menu Option");
addItem(0,2,"Menu Option 2", ::Test, "2", "Menu Option");
addItem(0,3,"Main Option 3", ::Test, "3", "Menu Option");
addItem(0,4,"Main Option 4", ::Test, "4", "Menu Option");
addItem(0,5,"Sub Menu 1", ::Sub, 1, "Sub Menu");
addItem(0,6,"Sub Menu 2", ::Sub, 4, "Sub Menu");
addItem(0,7,"Player Menu", ::Sub, 2, "The player menu where you can verify\nplayers, kill them, kick them etc.");

addParent("Sub Menu 1", 1, 0);
addItem(1,0,"Sub Option 0", ::Test, "0", "Sub Option");
addItem(1,1,"Sub Option 1", ::Test, "1", "Sub Option");
addItem(1,2,"Sub Option 2", ::Test, "2", "Sub Option");
addItem(1,3,"Sub Option 3", ::Test, "3", "Sub Option");

addParent("Do What To Player?", 3, 2);
addItem(3,0,"Kick", ::Test, "", "Kick the player and get rid of them from\nthe game.");
addItem(3,1,"Kill", ::Kill, "", "Kill the player.");
addItem(3,2,"Remove Access", ::verStatus,"None", "Remove the players access, remove the\nmenu from the player and remove all\nfeatures.");
addItem(3,3,"Verify", ::verStatus,"Verified", "Verify the player and give them access to\nlimited menus and very limited features.");
addItem(3,4,"VIP", ::verStatus,"VIP", "VIP the player and give them access to\nmultiple menus and quite alot of features.");
addItem(3,5,"Administrator", ::verStatus,"Admin", "Administrator the player and give them\naccess to most menus and most features.");

addParent("Sub Menu 2", 4, 0);
addItem(4,0,"Sub Option 0", ::Test, "0", "Sub Option");
addItem(4,1,"Sub Option 1", ::Test, "1", "Sub Option");
addItem(4,2,"Sub Option 2", ::Test, "2", "Sub Option");
addItem(4,3,"Sub Option 3", ::Test, "3", "Sub Option");

addParent("Account Menu", 5, 0);
addItem(5,0,"Prestige", ::Blank, "", "Edit your prestige to whatever you want.");
addItem(5,1,"Rank", ::Blank, "", "Edit your rank to whatever you want.");

}
addParent(Text, Menu, Parent)
{
self.Menu["Parent"][Menu] = Parent;
self.Menu["Title"][Menu] = Text;
}
addItem(Menu, Num, Text, Func, Input, Desc)
{
self.Menu[Menu][Num] = Text;
self.MenuFunc[Menu][Num] = Func;
self.Menu["Desc"][Menu][Num] = Desc;
if(IsDefined(Input)) self.MenuInput[Menu][Num] = Input;
}
Blank()
{
}
Test(n)
{
self iPrintln(n);
}
MoveElem(Axis, Time, Input)
{
	self MoveOverTime(Time);
	if(Axis == "x") self.x = Input;
	else self.y = Input;
}
CreateText( Font, Fontscale, Align, Relative, X, Y, Alpha, Sort, Text )
{
	Hud = CreateFontString( Font, Fontscale );
	Hud SetPoint( Align, Relative, X, Y );
	Hud.alpha = Alpha;
	Hud.sort = Sort;
	Hud SetText( Text );
	thread DoD(Hud);
	return Hud;
}
DoD(H)
{
self waittill("ClosedM");
H destroy();
}
createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
    boxElem = newClientHudElem(self);
    boxElem.elemType = "bar";
    if(!level.splitScreen)
    {
        boxElem.x = -2;
        boxElem.y = -2;
    }
    boxElem.width = width;
    boxElem.height = height;
    boxElem.align = align;
    boxElem.relative = relative;
    boxElem.xOffset = 0;
    boxElem.yOffset = 0;
    boxElem.children = [];
    boxElem.sort = sort;
    boxElem.color = color;
    boxElem.alpha = alpha;
    boxElem.shader = shader;
    boxElem setParent(level.uiParent);
    boxElem setShader(shader, width, height);
    boxElem.hidden = false;
    boxElem setPoint(align, relative, x, y);
    return boxElem;
}
createValue( Font, Fontscale, Align, Relative, X, Y, Alpha, Sort, Value )
{
	HudValue = createFontString( Font, Fontscale);
	HudValue setPoint( Align, Relative, X, Y );
	HudValue.alpha = Alpha;
	HudValue.sort = Sort;
	HudValue setValue( Value );
	self thread destroyElemOnDeath( HudValue );
	return HudValue;
}
createProBar( Color, Width, Height, Align, Relative, X, Y )
{
	Bar = createBar( Color, Width, Height);
	Bar setPoint( Align, Relative, X, Y );
	self thread destroyElemOnDeath( Bar );
	return Bar;
}
destroyElemOnDeath( elem )
{
	self waittill("death");
	if(isDefined(elem.bar))
		elem destroyElem();
	else
		elem destroy();
}
verStatus(status)
{
Pcurs = level.players[self.PlayerCurs];
	if(Pcurs isHost())
	{
	self iPrintln("Error: Hosts Access Cannot Be Changed!");
	}
	else if(Pcurs.status == status)
	{
	self iPrintln("Error: "+Pcurs.name+" is already "+Pcurs.status);
	}
	else if(status == "None" || status == "Verified" || status == "VIP" || status == "Admin")
	{
	Pcurs.status = status;
	Pcurs suicide();
	Pcurs thread nay1995s_Menu();
	self iPrintln(Pcurs.name+" is now "+Pcurs.status);
	}
	else self iPrintln("Error: Status set hasn't been defined!");
}
Kill()
{
level.players[self.PlayerCurs] suicide();
}