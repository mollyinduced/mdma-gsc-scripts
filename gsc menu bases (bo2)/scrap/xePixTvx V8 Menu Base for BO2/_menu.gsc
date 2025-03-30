_setUpMenu()
{
	self.Menu = spawnStruct();
	self.Hud = spawnStruct();
	self.Scroller = [];
	self.hasMenu = false;
	self thread _menu_Structure();
	self.MenuColor = [];
	self.MenuGlowColor = [];
	self.MenuColor["BG"] = (0,0,0);
	self.MenuColor["Title"] = (1,1,1);
	self.MenuColor["Text"] = (1,1,1);
	self.MenuColor["Scrollbar"] = (0,1,0);
	self.MenuGlowColor["Title"] = (0,1,0);
	self.MenuGlowColor["Text"] = (0,0,1);
	self.MenuTextGlowAlpha = 1;
	self.ScrollbarShader = "hud_us_grenade";
	self.MenuTheme = [];
	self.MenuTheme["New"] = false;
	self.MenuTheme["Old"] = true;
	self.MenuFreeze = true;
}
_giveMenu(client)
{
	if(client.hasMenu==true)
	{
		_removeMenu(client);
	}
	client.hasMenu = true;
	client _createMainHud();
	client thread _menuMain();
}
_removeMenu(client)
{
	if(client.Menu.Opened==true)
	{
		client _closeMenu();
		wait .2;
	}
	client _destroyMainHud();
	client notify("RemoveMenu");
	client.hasMenu = false;
}

_menuMain()
{
	self endon("disconnect");
	self endon("RemoveMenu");
	self.Menu.Opened = false;
	self.Menu.Locked = false;
	for(;;)
	{
		if(!self.Menu.Opened && !self.Menu.Locked)
		{
			if(self SecondaryOffHandButtonPressed())
			{
				self _openMenu();
				wait .3;
			}
		}
		else if(self.Menu.Opened && !self.Menu.Locked)
		{
			if(self MeleeButtonPressed())
			{
				if(self.Menu.Parent[self.Menu.CurrentMenu]=="Exit")
				{
					self _closeMenu();
				}
				else
				{
					self _loadMenu(self.Menu.Parent[self.Menu.CurrentMenu]);
				}
				wait .3;
			}
			if(self AdsButtonPressed()||self AttackButtonPressed())
			{
				self.Scroller[self.Menu.CurrentMenu] -= self AdsButtonPressed();
				self.Scroller[self.Menu.CurrentMenu] += self AttackButtonPressed();
				self _scrollUpdate();
				wait 0.124;
			}
			if(self UseButtonPressed())
			{
				input1 = self.Menu.Input1[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]];
				input2 = self.Menu.Input2[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]];
				input3 = self.Menu.Input3[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]];
				input4 = self.Menu.Input4[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]];
				if(isDefined(self.Menu.VerifyStatus[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]]))
				{
					if(self.Menu.VerifyStatus[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]]==getStatusInt(self)||self.Menu.VerifyStatus[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]]<getStatusInt(self))
					{
						self thread [[self.Menu.Func[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]]]](input1,input2,input3,input4);
					}
					else
					{
						self iprintlnbold("^1You dont Have Access for that!");
					}
				}
				else
				{
					self thread [[self.Menu.Func[self.Menu.CurrentMenu][self.Scroller[self.Menu.CurrentMenu]]]](input1,input2,input3,input4);
				}
				wait .3;
			}
		}
		else{}
		wait 0.05;
	}
	wait 0.05;
}
_openMenu()
{
	self thread deleteOffHand();
	self.Menu.Opened = true;
	if(self.MenuFreeze==true)
	{
		self freezeControls(true);
	}
	if(!isDefined(self.Menu.CurrentMenu))
	{
		self.Menu.CurrentMenu = "main";
	}
	self.Hud.BG scaleOverTime(.4,300,((self.Menu.Text[self.Menu.CurrentMenu].size*19)+45));
	self.Hud.Title changeFontScaleOverTimes(.4,2);
	self.Hud.Title moveOverTime(.4);
	self.Hud.Title.y += 5;
	wait .4;
	self _createMenuHud();wait 0.05;
	self _loadMenu(self.Menu.CurrentMenu);
}
_closeMenu()
{
	self.Menu.Opened = false;
	self freezeControls(false);
	self _destroyMenuHud();
	self.Hud.Title setSafeText("^5Press [{+smoke}] To Open Menu");
	self.Hud.Title changeFontScaleOverTimes(.4,1.5);
	self.Hud.Title moveOverTime(.4);
	self.Hud.Title.y -= 5;
	self.Hud.BG scaleOverTime(.4,300,30);
}
_loadMenu(menu)
{
	self thread _menu_Structure();
	self.Menu.CurrentMenu = menu;
	if(!isDefined(self.Scroller[self.Menu.CurrentMenu]))
	{
		self.Scroller[self.Menu.CurrentMenu] = 0;
	}
	self.Hud.Title setSafeText(self.Menu.Title[self.Menu.CurrentMenu]);
	string = "";
	for(i=0;i<self.Menu.Text[self.Menu.CurrentMenu].size;i++)
	{
		string += self.Menu.Text[self.Menu.CurrentMenu][i]+"\n";
	}
	self.Hud.Text setSafeText(string);
	self.Hud.BG scaleOverTime(.4,300,((self.Menu.Text[self.Menu.CurrentMenu].size*19)+45));
	self _scrollUpdate();
}
_scrollUpdate()
{
	if(self.Scroller[self.Menu.CurrentMenu]<0)
	{
		self.Scroller[self.Menu.CurrentMenu] = self.Menu.Text[self.Menu.CurrentMenu].size-1;
	}
	if(self.Scroller[self.Menu.CurrentMenu]>self.Menu.Text[self.Menu.CurrentMenu].size-1)
	{
		self.Scroller[self.Menu.CurrentMenu] = 0;
	}
	self.Hud.Scrollbar elemMoveOverTimeY(0.124,43.5+(17.98*self.Scroller[self.Menu.CurrentMenu]));
}
_createMainHud()
{
	self.Hud.BG = createRectangle("TOP","TOP",0,2,300,30,self.MenuColor["BG"],.7,1,"white");
	self.Hud.Title = createText("default",1.5,"TOP","TOP",0,8,2,self.MenuColor["Title"],1,self.MenuGlowColor["Title"],1,"^5Press [{+smoke}] To Open Menu");
}
_destroyMainHud()
{
	self.Hud.BG destroy();
	self.Hud.Title destroy();
}
_createMenuHud()
{
	self.Hud.Text = createText("default",1.5,"LEFT","TOP",-130,50,3,self.MenuColor["Text"],1,self.MenuGlowColor["Text"],self.MenuTextGlowAlpha,"");
	self.Hud.Scrollbar = createRectangle("TOP","TOP",0,43.5,300,15,self.MenuColor["Scrollbar"],.7,2,self.ScrollbarShader);//hud_us_grenade
}
_destroyMenuHud()
{
	self.Hud.Text destroy();
	self.Hud.Scrollbar destroy();
}



_changeBGColor(color)
{
	if(isDefined(color))
	{
		self.MenuColor["BG"] = color;
	}
	self.Hud.BG elemFadeOverTime(.2,0);wait .2;
	self.Hud.BG.color = self.MenuColor["BG"];
	self.Hud.BG elemFadeOverTime(.2,.7);
}
_changeTitleColor(color)
{
	if(isDefined(color))
	{
		self.MenuColor["Title"] = color;
	}
	self.Hud.Title elemFadeOverTime(.2,0);wait .2;
	self.Hud.Title.color = self.MenuColor["Title"];
	self.Hud.Title elemFadeOverTime(.2,1);
}
_changeTitleGlowColor(color)
{
	if(isDefined(color))
	{
		self.MenuGlowColor["Title"] = color;
	}
	self.Hud.Title elemFadeOverTime(.2,0);wait .2;
	self.Hud.Title.glowColor = self.MenuGlowColor["Title"];
	self.Hud.Title elemFadeOverTime(.2,1);
}
_changeTextColor(color)
{
	if(isDefined(color))
	{
		self.MenuColor["Text"] = color;
	}
	self.Hud.Text elemFadeOverTime(.2,0);wait .2;
	self.Hud.Text.color = self.MenuColor["Text"];
	self.Hud.Text elemFadeOverTime(.2,1);
}
_changeTextGlowColor(color)
{
	if(isDefined(color))
	{
		self.MenuGlowColor["Text"] = color;
	}
	self.Hud.Text elemFadeOverTime(.2,0);wait .2;
	self.Hud.Text.glowColor = self.MenuGlowColor["Text"];
	self.Hud.Text elemFadeOverTime(.2,1);
}
_changeTextGlowAlpha(a)
{
	if(isDefined(a))
	{
		self.MenuTextGlowAlpha = a;
	}
	self.Hud.Text elemFadeOverTime(.2,0);wait .2;
	self.Hud.Text.glowAlpha = self.MenuTextGlowAlpha;
	self.Hud.Text elemFadeOverTime(.2,1);
}
_changeScrollbarColor(color)
{
	if(isDefined(color))
	{
		self.MenuColor["Scrollbar"] = color;
	}
	self.Hud.Scrollbar elemFadeOverTime(.2,0);wait .2;
	self.Hud.Scrollbar.color = self.MenuColor["Scrollbar"];
	self.Hud.Scrollbar elemFadeOverTime(.2,1);
}
_changeScrollbarShader(shader,w,h)
{
	self.ScrollbarShader = shader;
	self.Hud.Scrollbar elemFadeOverTime(.2,0);wait .2;
	self.Hud.Scrollbar setShader(self.ScrollbarShader,w,h);
	self.Hud.Scrollbar elemFadeOverTime(.2,1);
}
_changeMenuTheme(theme)
{
	if(theme=="New")
	{
		if(self.MenuTheme["New"]==true)
		{
			self iprintln("^1Menu is already in Remastered Theme!");
			return;
		}
		self.MenuGlowColor["Title"] = (0,0,1);
		self.MenuTextGlowAlpha = 0;
		self _changeTextGlowAlpha();wait .2;
		self _changeTitleGlowColor();wait .2;
		self _changeScrollbarShader("white",300,15);
		self.MenuTheme["Old"] = false;
		self.MenuTheme["New"] = true;
	}
	else if(theme=="Old")
	{
		if(self.MenuTheme["Old"]==true)
		{
			self iprintln("^1Menu is already in Original Theme!");
			return;
		}
		self.MenuGlowColor["Title"] = (0,1,0);
		self.MenuTextGlowAlpha = 1;
		self _changeTextGlowAlpha();wait .2;
		self _changeTitleGlowColor();wait .2;
		self _changeScrollbarShader("hud_us_grenade",300,15);
		self.MenuTheme["Old"] = true;
		self.MenuTheme["New"] = false;
	}
	else
	{
		self iprintln("^1WATTT???");
	}
}
ToggleMenuFreeze()
{
	if(!self.MenuFreeze)
	{
		self.MenuFreeze = true;
		self freezeControls(true);
		self iprintln("Menu Freeze: [^2ON^7]");
	}
	else
	{
		self.MenuFreeze = false;
		self freezeControls(false);
		self iprintln("Menu Freeze: [^1OFF^7]");
	}
}

