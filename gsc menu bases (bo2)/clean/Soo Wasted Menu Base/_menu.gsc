/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : _menu
*	 Description : 
*	 Date : 2015.07.30 - 05:12:01	
*
*/	

/* Some Default Settings of the menu */
_menuDefaultSettings()
{
	/* Used for Widescreen Mode */
	self.MainXPos = 350;//for widescreen mode 300
	self.MenuWideScreen = false;//for widescreen mode true
	
	/* Scrolling */
	self.MenuMaxSize = 20;
	self.MenuMaxSizeHalf = 10;
	self.MenuMaxSizeHalfOne = 11;
	self.Space = 18;
}


/* Gives the menu(only call that one time per game) */
initMenu()
{
	self.Menu = [];
	self.Scroller = [];
	self.Menu["Menu"]["Open"] = false;
	self.Menu["Menu"]["Locked"] = false;
	self thread _menuOpen();
}

/* Button Monitor for opening the menu */
_menuOpen()
{
	self endon("disconnect");
	for(;;)
	{
		if(!self.Menu["Menu"]["Open"] && !self.Menu["Menu"]["Locked"])
		{
			if(self ActionslotOneButtonPressed() && self.MenuAccess==true)
			{
				self thread _menuMain();
				wait .1;
				self notify("Menu_Is_Opened");
				wait .1;
			}
		}
		wait 0.05;
	}
	wait 0.05;
}

/* Button Monitor for opened menu */
_menuMain()
{
	self endon("disconnect");
	self endon("Menu_Is_Closed");
	
	self waittill("Menu_Is_Opened");
	_openMenu(self);
	
	while(self.Menu["Menu"]["Open"])
	{
		if(self AdsButtonPressed())//Scroll Up
		{
			self.Scroller[self.Menu["CurrentMenu"]] --;
			self _scrollUpdate();
			wait .1;
		}
		if(self AttackButtonPressed())//Scroll Down
		{
			self.Scroller[self.Menu["CurrentMenu"]] ++;
			self _scrollUpdate();
			wait .1;
		}
		if(self UseButtonPressed())//Select
		{
			input1 = self.FuZiioN[self.Menu["CurrentMenu"]].inp1[self.Scroller[self.Menu["CurrentMenu"]]];
			input2 = self.FuZiioN[self.Menu["CurrentMenu"]].inp2[self.Scroller[self.Menu["CurrentMenu"]]];
			input3 = self.FuZiioN[self.Menu["CurrentMenu"]].inp3[self.Scroller[self.Menu["CurrentMenu"]]];
			self thread [[self.FuZiioN[self.Menu["CurrentMenu"]].func[self.Scroller[self.Menu["CurrentMenu"]]]]](input1,input2,input3);
			self doSelectEffect();
			wait .3;
		}
		if(self MeleeButtonPressed())//Exit or Back
		{
			if(self.FuZiioN[self.Menu["CurrentMenu"]].parent=="Exit")
			{
				_closeMenu(self);
			}
			else
			{
				self _loadMenu(self.FuZiioN[self.Menu["CurrentMenu"]].parent);
			}
			wait .3;
		}
		wait 0.05;
	}
	wait 0.05;
}

/* loads sub menu */
_loadMenu(menu)
{
	self.Menu["CurrentMenu"] = menu;
	self thread getMenuStructures();
	if(!isDefined(self.Scroller[self.Menu["CurrentMenu"]]))
	{
		self.Scroller[self.Menu["CurrentMenu"]] = 0;
	}
	self.Menu["Text"] setPoint("LEFT","",self.MainXPos-85,(-1)*((getMenuSize()/2)*18));
	self _scrollUpdate();
}

/* Controls the Scrolling and sets all the texts */
_scrollUpdate()
{
	if(self.Scroller[self.Menu["CurrentMenu"]]<0)
	{
		self.Scroller[self.Menu["CurrentMenu"]] = self.FuZiioN[self.Menu["CurrentMenu"]].text.size-1;
	}
	if(self.Scroller[self.Menu["CurrentMenu"]]>self.FuZiioN[self.Menu["CurrentMenu"]].text.size-1)
	{
		self.Scroller[self.Menu["CurrentMenu"]] = 0;
	}
	string = "";
	if(!isDefined(self.FuZiioN[self.Menu["CurrentMenu"]].text[self.Scroller[self.Menu["CurrentMenu"]]-self.MenuMaxSizeHalf])||self.FuZiioN[self.Menu["CurrentMenu"]].text.size<=self.MenuMaxSize)
	{
	    for(i=0;i<self.MenuMaxSize;i++)
	    {
		    if(isDefined(self.FuZiioN[self.Menu["CurrentMenu"]].text[i]))
			{
				string += self.FuZiioN[self.Menu["CurrentMenu"]].text[i]+"\n";
			}
			else
			{
				string += "\n";
			}
	    }
		self.Menu["Text"] setSafeText(self,string);
		self.Menu["Scrollbar"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Scroller[self.Menu["CurrentMenu"]]*self.Space));
		self.Menu["Star"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Scroller[self.Menu["CurrentMenu"]]*self.Space));
		self.Menu["Line"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Scroller[self.Menu["CurrentMenu"]]*self.Space));
	}
    else
	{
	    if(isDefined(self.FuZiioN[self.Menu["CurrentMenu"]].text[self.Scroller[self.Menu["CurrentMenu"]]+self.MenuMaxSizeHalf]))
	    {
			for(i=self.Scroller[self.Menu["CurrentMenu"]]-self.MenuMaxSizeHalf;i<self.Scroller[self.Menu["CurrentMenu"]]+self.MenuMaxSizeHalfOne;i++)
			{
				if(isDefined(self.FuZiioN[self.Menu["CurrentMenu"]].text[i]))
				{
					string += self.FuZiioN[self.Menu["CurrentMenu"]].text[i]+"\n";
				}
				else
				{
					string += "\n";
				}
			}    
			self.Menu["Text"] setSafeText(self,string);
			self.Menu["Scrollbar"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Space*self.MenuMaxSizeHalf));
			self.Menu["Star"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Space*self.MenuMaxSizeHalf));
			self.Menu["Line"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Space*self.MenuMaxSizeHalf));
		}
		else
		{
		    for(i=0;i<self.MenuMaxSize;i++)
		    {
		    	if(isDefined(self.FuZiioN[self.Menu["CurrentMenu"]].text[self.FuZiioN[self.Menu["CurrentMenu"]].text.size+(i-self.MenuMaxSize)]))
		    	{
					string += self.FuZiioN[self.Menu["CurrentMenu"]].text[self.FuZiioN[self.Menu["CurrentMenu"]].text.size+(i-self.MenuMaxSize)]+"\n";
				}
				else
				{
					string += "\n";
				}
			}
			self.Menu["Text"] setSafeText(self,string);
			self.Menu["Scrollbar"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Space*((self.Scroller[self.Menu["CurrentMenu"]]-self.FuZiioN[self.Menu["CurrentMenu"]].text.size)+self.MenuMaxSize)));
			self.Menu["Star"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Space*((self.Scroller[self.Menu["CurrentMenu"]]-self.FuZiioN[self.Menu["CurrentMenu"]].text.size)+self.MenuMaxSize)));
			self.Menu["Line"] elemMoveOverTimeY(.1,((-1)*((getMenuSize()/2)*18))+(self.Space*((self.Scroller[self.Menu["CurrentMenu"]]-self.FuZiioN[self.Menu["CurrentMenu"]].text.size)+self.MenuMaxSize)));
		}
	}
}

/* Menu Open Function */
_openMenu(client)
{
	client.Menu["Menu"]["Open"] = true;
	client freezeControls(true);
	if(!isDefined(client.Menu["CurrentMenu"]))
	{
		client.Menu["CurrentMenu"] = "main";
	}
	client setclientuivisibilityflag("hud_visible",0);
	client SetBlur(4,.2);
	client _createHud();
	client _loadMenu(client.Menu["CurrentMenu"]);
}

/* Menu Closing Function */
_closeMenu(client)
{
	client.Menu["Menu"]["Open"] = false;
	client freezeControls(false);
	client _destroyHud();
	client _destroyMenuText();
	client SetBlur(0,.2);
	client setclientuivisibilityflag("hud_visible",1);
	client notify("Menu_Is_Closed");
}

/* Widescreen Toggle Function */
toggleWidescreenMode()
{
	if(!self.MenuWideScreen)
	{
		self.MainXPos = 300;
		_closeMenu(self);
		wait 0.05;
		self thread _menuMain();
		wait .1;
		self notify("Menu_Is_Opened");
		self iprintln("Widescreen Mode: ^2ON");
		self.MenuWideScreen = true;
	}
	else
	{
		self.MainXPos = 350;
		_closeMenu(self);
		wait 0.05;
		self thread _menuMain();
		wait .1;
		self notify("Menu_Is_Opened");
		self iprintln("Widescreen Mode: ^1OFF");
		self.MenuWideScreen = false;
	}
}

