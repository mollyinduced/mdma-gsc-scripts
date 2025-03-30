
//Menu Position Mover <> by cabcon
moveHudSet(valueX,valueY)
{
	if(getYPos() == valueY && getXPos() == valueX)
		return;
	if(!valueY == "undefined")
		self setYPos(valueY);
	if(!valueX == "undefined")
		self setXPos(valueX);
	self moveHudofMenu(.5);
}
moveHudAmmount(valueX,valueY)
{
	self setYPos(getYPos() + valueY);
	self setXPos(getXPos() + valueX);
	self moveHudofMenu(.2);
}
moveHudofMenu(time)
{
	self.menu["isLocked"] = true;
	self.menu["ui"]["background"] affectElement("y", time, getYPos());
	self.menu["ui"]["barTop"] affectElement("y", time, -75 + getYPos()); 
	self.menu["ui"]["title"] affectElement("y", time, -75 + getYPos());
	for( a = 0; a < 7; a ++ )
	{
		self.menu["ui"]["text"][a] affectElement("y", time, -40+(a*20) + getYPos());
	}
	self thread scrollScroller(time,"y");
	wait time;
	self.menu["ui"]["background"] affectElement("x", time, getXPos());
	self.menu["ui"]["barTop"] affectElement("x", time, getXPos());
	self.menu["ui"]["title"] affectElement("x", time, getXPos());
	for( a = 0; a < 7; a ++ )
	{
		self.menu["ui"]["text"][a] affectElement("x", time, getXPos());
	}
	self thread scrollScroller(time,"x");
	wait time + .1;
	if(self.var["systemHudMover"] == false)
	{
		self.menu["isLocked"] = false;
		S("Y Position ^2"+getYPos()+"^7 | X Position ^2"+getXPos());
	}
}
scrollScroller(time,type)
{
    if(!isDefined(self.menu["items"][self getCurrent()].name[self getCursor()-3]) || self.menu["items"][self getCurrent()].name.size <= 7)
    {
    	if(type == "y")
    		self.menu["ui"]["scroller"] affectElement("y", time, self.menu["ui"]["text"][self getCursor()].y);
    	else
        	self.menu["ui"]["scroller"] affectElement("x", time, self.menu["ui"]["text"][self getCursor()].x);
    }
    else
    {
        if(isDefined(self.menu["items"][self getCurrent()].name[self getCursor()+3]))
        {
            if( self.menu["ui"]["scroller"].y != self.menu["ui"]["text"][3].y || self.menu["ui"]["scroller"].x != self.menu["ui"]["text"][3].x )
            {
            	if(type == "y")
                	self.menu["ui"]["scroller"] affectElement("y", time, self.menu["ui"]["text"][3].y);
                else
                	self.menu["ui"]["scroller"] affectElement("x", time, self.menu["ui"]["text"][3].x);
            }
        }
        else
        {
        	if(type == "y")
            	self.menu["ui"]["scroller"] affectElement("y", time, self.menu["ui"]["text"][((self getCursor()-self.menu["items"][self getCurrent()].name.size)+7)].y);
            else
            	self.menu["ui"]["scroller"] affectElement("x", time, self.menu["ui"]["text"][((self getCursor()-self.menu["items"][self getCurrent()].name.size)+7)].x);
       }
    }
}

systemHudMover()
{
	self.menu["isLocked"] = true;
	self.var["systemHudMover"] = true;
	L("hud Mover Starting...");
	S("Press [{+actionslot 1}]/[{+actionslot 2}] To Move the Hud Up/Down | [{+actionslot 3}]/[{+actionslot 4}] Left/Right | [{+melee}] To Close");
	self.menu["ui"]["hud_mover_text"] = self createText(1.5, 5, "Press [{+actionslot 1}]/[{+actionslot 2}] To Move the Hud Up/Down\nPress [{+actionslot 3}]/[{+actionslot 4}] To Move the Hud Left/Right\n    [{+melee}] To Close", "CENTER", "CENTER", 0, 100, 1);
	for(;;)
	{
		if(self actionslotonebuttonpressed()) //up
		{
			moveHudAmmount(50,0);
		}
		else if(self actionslottwobuttonpressed()) //DOWN
		{
			moveHudAmmount(-50,0);
		}
		else if(self actionslotthreebuttonpressed()) //LEFT
		{
			moveHudAmmount(0,-50);
		}
		else if(self actionslotfourbuttonpressed()) //RIGHT
		{
			moveHudAmmount(0,50);
		}
		else if(self meleebuttonpressed()) //RIGHT
		{
			self.menu["ui"]["hud_mover_text"] destroy();
			self.menu["isLocked"] = false;
			self.var["systemHudMover"] = false;
			return;
		}
		wait .025;
	}
}

//sounds
toggleSoundAlllowedInMenu()
{
	if(self.menu["Sound"]== true)
		self.menu["Sound"]= false;
	else
		self.menu["Sound"]= true;
	S("Menu Sounds " + self.menu["Sound"] ? "^2ON" : "^1OFF");
}

//messages 
PrintMessageToEntry_theader(String)
{	
	self [[self.vars["message_type"]]](String);
}
PrintMessageToEntry_system(i)
{
	if(self.vars["message_type"]==::PrintMessageToEntry)
		self.vars["message_type"] = ::S;
	else if(self.vars["message_type"]==::S)
		self.vars["message_type"] = ::Sb;
	else if(self.vars["message_type"]==::Sb)
		self.vars["message_type"] = ::PrintMessageToEntry;
	S("Print Methode ^2Changed");
	
}
PrintMessageToEntry(String,timeplus)
{
	if(!isDefined(level.message_spwan))
	{
        level.message_spwan = spawnstruct();
        level.message_spwan = self createText(1.5, 5, String, "CENTER", "CENTER", 0, -120, 1);
        level.message_spwan.glow = true;
        level.message_spwan.glowColor = getMenuColor();
    	level.message_spwan.hideWhenInMenu = true;
        level.message_spwan setCOD7DecodeFX( 100, int(10*1000), 600 );
        level.message_spwan setPulseFX( 100, int(10*1000), 1000 );
        if(isEmpty(timeplus))
        	timeplus = 0;
        L(String.size+" | Print Duration : "+(3+(String.size/10*3))+timeplus);
        wait 3+(String.size/3)+timeplus;
        level.message_spwan affectElement("alpha", 1, 0);
        wait 1;
        level.message_spwan clear(self);
        level.message_spwan = undefined;
        self notify("MessageSpawnNew");
        L("PrintMessageToEntry() say --> notify MessageSpawnNew");
    }
    else
    {
    	L("PrintMessageToEntry() say --> waittill for MessageSpawnNew");
    	self waittill("MessageSpawnNew");
    	self PrintMessageToEntry(String);
    }
}

WelcomeMessage()
{
 		S("Welcome ^7"+getNameNotClan(self)+ "^7. Press [{+speed_throw}] and [{+melee}]");
 		S("www.cabconmodding.com");
 		self PrintMessageToEntry("^1The ^4Final ^1Statement ^4Menu ^1Base^4!\n^1E^4n^1j^4o^1y^4!");
 		// 	\n goes down a line :D
}










Test()
{
self iPrintlnbold("TEST");
}



