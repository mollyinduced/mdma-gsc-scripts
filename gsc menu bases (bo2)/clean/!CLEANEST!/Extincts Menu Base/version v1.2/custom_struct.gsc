menuOptions( menu )
{
	//WE'RE USING IF STATEMENTS TO SAVE VARIABLES. METHOD: WE'RE ONLY LOADING THE VARIABLES FOR THE MENU WE'RE CURRENTLY IN.
	if(menu == "main")
	{
		self addMenu("main", "Main Menu");
			self addOpt("SubMenu 1", undefined, ::newMenu, "submenu1");
			self addOpt("Dev Testing", "Developer Testing Menu", ::newMenu, "dev");
			self addOpt("Menu Customizations", "Change Menu Design",::newMenu, "customize");
			self addOpt("Client Options", undefined,::newMenu,"Client");
			self addOpt("Undefined Menu Test", undefined,::newMenu,"testing");
	}
	else if(menu == "submenu1")
	{
		self addMenu("submenu1", "SubMenu 1", "Host;Co-Host;Admin");
			for(e=0;e<10;e++) self addOpt("Option "+e);
	}
	else if(menu == "dev")
	{
		self addMenu("dev", "Dev Testing");
			self addOpt("Undefined Menu Test", undefined,::newMenu,"testing");
			self addOpt("Overflow Test", undefined, ::newMenu, "overflow");
			self addOpt("Shader Menu Test", undefined,::newMenu, "shader");
			self addOpt("Colour Toggle Test", undefined, ::testColourToggle);
			self addOpt("Text Toggle Test", "Menu Text Toggle", ::testTextToggle);	
			self addOptSlide("Speed [{+actionslot 3}] 1 [{+actionslot 4}]", undefined, ::testSlider, "Speed;1;2;3;4;5;6;7;8");
			self addOptSlide("Change Level [{+actionslot 3}] 1 [{+actionslot 4}]", undefined, ::spoofRanks, "Change Level;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55");
			self addOpt("All Godmode Test", undefined, ::allplayerFuncWrapper, ::godmode);
	}	
	else if(menu == "overflow")	
	{
		self addMenu("overflow", "Overflow Test");
			for(e=1;e<100;e++) 	self addOpt("Overflow "+e, "Current Overflow Test: ^2"+e);	
	}
	else if(menu == "shader")
	{
		self addMenu("shader", "Shader Menu Test");
			self addOpt("Prestige Icons", undefined,::newMenu,"prestige");
			self addOpt("Rank Icons", undefined,::newMenu,"rank");	
	}
	else if(menu == "prestige")
	{
		self addMenu("prestige", "Prestige Icons", undefined, "14;14");
			for(e=1;e<level.rankPrestige.size;e++) self addOpt(level.rankPrestige[e], "Sets Prestige To "+e);
	}
	else if(menu == "rank")
	{
		self addMenu("rank", "Rank Icons", undefined, "14;14");
			for(e=1;e<level.rankBadges.size;e++) self addOpt(level.rankBadges[e],"Sets Rank To "+e, ::spoofRanks, e);	
	}
	else if(menu == "customize")
	{
		self addMenu("customize", "Menu Customizations");
			menuNames = strTok("Main|Title & Info|Options|Select|Cursor|Background","|");
			varNames = strTok("Main_Colour|Title_Colour|Opt_Colour|Select_Colour|Curs_Colour|Bg_Colour", "|");
			menuHuds = strTok("Scroller;Banner;InfoBox|Title;InfoTxt;MenuName|OPT|UPDATE|UPDATE|Background", "|");
			colourNames = strTok("Royal Blue|Raspberry|Skyblue|Hot Pink|Green|Brown|Blue|Red|Orange|Purple|Cyan|Yellow|Black|White","|");
			colours = strTok("34|64|139|135|38|87|135|206|250|255|23|153|0|255|0|101|67|33|0|0|255|255|0|0|255|128|0|153|26|255|0|255|255|255|255|0|0|0|0|255|255|255","|");
			for(i=0;i<menuNames.size;i++)
				self addOpt(menuNames[i], undefined, ::newMenu, menuNames[i]);
			for(i=0;i<menuNames.size;i++)
			{
				self addMenu(menuNames[i], menuNames[i], "Host;Co-Host;Admin", "100;10");
				for(e=0;e<colours.size;e++)
					self addOpt(colours[3*e]+","+colours[(3*e)+1]+","+colours[(3*e)+2], "Sets Colour To "+colourNames[e], ::setMenuColours, varNames[i], menuHuds[i], divideColor(int(colours[3*e]), int(colours[(3*e)+1]), int(colours[(3*e)+2]))); 
			}
	}	
	self playerOptions( menu );	
}

playerOptions( menu )
{
	if(menu == "Client")
	{
		self addMenu("Client", "Client Options");
		foreach(player in level.players)
			self addOpt("[^2"+player.verStatus+"^7] "+player getName(), undefined,::newMenu,"Client "+player getEntityNumber());
	}
	
	foreach(player in level.players)
	{
		if(menu == "Client "+player getEntityNumber())
		{
			self addMenu("Client "+player getEntityNumber(), "[^2"+player.verStatus+"^7] "+player getName());
				self addOpt("Verification System", "Gives people the menu",::newMenu,"verify "+player getEntityNumber());
				self addOpt("EXAMPLE MENU", "Example",::newMenu, "example "+player getEntityNumber());
		}
		else if(menu == "verify "+player getEntityNumber())
		{
			self addMenu("verify "+player getEntityNumber(), player getName()+" Verification");
				self addOpt("Add From Co-Host List", undefined, ::coHostList, player, true);
				self addOpt("Remove From Co-Host List", undefined, ::coHostList, player, false);
				for(e=0;e<level.status.size-1;e++)
					self addOpt("Set Verification To "+level.status[e], undefined, ::initialSetUp[e], e, player, true);
		}	
		else if(menu == "example "+player getEntityNumber())
		{
			self addMenu("example "+player getEntityNumber(), "Example Menu");	
				self addOpt("EXAMPLE");
		}
	}
}

watchOpenMenu()
{
	self endon( "end_Menu" );
	self endon( "disconnect" );
	level endon( "game_ended" );

	while(!isDefined( self.eMenu["inMenu"] ))
	{
		if(self adsButtonPressed() && self meleeButtonPressed())
		{
			self thread openMenu();
			self playsoundtoplayer("", self);//MENU OPENING SOUND
			break;
		}
		wait .05;
	}
}

menuHandler()
{
	self endon( "end_Menu" );
	self endon( "disconnect" );
	level endon( "game_ended" );
	
	while(isDefined( self.eMenu["inMenu"] ))
	{
		if(self adsButtonPressed() || self attackButtonPressed())
		{
			if(!self adsButtonPressed() || !self attackButtonPressed())
			{
				self.eMenu["isScrolling"] = true;
				curs = self.eMenu_C[ self getCurrentMenu()+"_Cursor" ];
				
				self playsoundtoplayer("", self);//MENU SCROLLING SOUND
				
				self.eMenu["OPT"][ curs ] fadeOverTime(.2);
				self.eMenu["OPT"][ curs ].color = self grabMenuColour( curs );
				
				if(!self adsButtonPressed()) 
					self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] += self attackButtonPressed();
				if(!self attackButtonPressed())
					self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] -= self adsButtonPressed();
					
				if(curs != self.eMenu_C[ self getCurrentMenu()+"_Cursor" ])
				{
					if(self adsButtonPressed()) 
						self thread revalueScrolling(-1);
					else self thread revalueScrolling(1);
				}
				wait .2;
				self.eMenu["isScrolling"] = undefined;
				self notify("SCROLLING_OVER");
			}
		}
		else if(self actionslotthreebuttonpressed() || self actionslotfourbuttonpressed())
		{
			if(!self actionslotthreebuttonpressed() || !self actionslotfourbuttonpressed())
			{
				curMenu = self getCurrentMenu();
				curs = self.eMenu_C[ self getCurrentMenu()+"_Cursor" ];
				
				if(isDefined(self.eMenu_S1[ curMenu ][ "slider" ][ curs ]))
				{
					if(!isDefined(self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ]))
						self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ] = 1;
					
					if(!self actionslotthreebuttonpressed())
						self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ]++;
					if(!self actionslotfourbuttonpressed())
						self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ]--;
						
					if(self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ] > self.eMenu_S1[ curMenu ][ "slider" ][ curs ].size-1)
						self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ] = 1;
					if(self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ] < 1)
						self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ] = self.eMenu_S1[ curMenu ][ "slider" ][ curs ].size-1;
						
					self updateMenu(self.eMenu_S1[ curMenu ][ "slider" ][ curs ][ 0 ] + " [{+actionslot 3}] " + self.eMenu_S1[ curMenu ][ "slider" ][ curs ][ self.eMenu_SS[ curMenu+"_Slider_Cursor_"+curs ] ] + " [{+actionslot 4}]");
					wait .2;
				}
			}
		}
		else if( self useButtonPressed() )
		{
			curs = self getCursor();
			menu = self getCurrentMenu();
			
			self playsoundtoplayer("", self);//MENU SELECT SOUND
			
			if(isDefined(self buildFromMenu().eMenu_F[ menu ][ "function" ][ curs ]) && self buildFromMenu().eMenu_F[ menu ][ "function" ][ curs ] == ::newMenu)
			{
				nextMenu = self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ];
				self menuOptions(nextMenu);
				if(isDefined(self.eMenu_A[ nextMenu ][ "access" ]))
					list = self.eMenu_A[ nextMenu ][ "access" ];
				else list = "VIP;Admin;Co-Host;Host";
				accessLevels = strTok(list, ";");
				for(e=0;e<accessLevels.size;e++)
				{
					if(accessLevels[e] == self.verStatus)
					{
						self initializeMenuArrays(self.previousSubMenu[ self.previousSubMenu.size-1 ]);
						self thread [[ self buildFromMenu().eMenu_F[ menu ][ "function" ][ curs ] ]]( self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ], self buildFromMenu().eMenu_I2[ menu ][ "i2" ][ curs ], self buildFromMenu().eMenu_I3[ menu ][ "i3" ][ curs ], self buildFromMenu().eMenu_I4[ menu ][ "i4" ][ curs ], self buildFromMenu().eMenu_I5[ menu ][ "i5" ][ curs ]);
					}
				}
				if(self getCurrentMenu() != nextMenu)
					self iprintln("^1Error^7: Your access level is not high enough to access this submenu.");
			}
			else if(isDefined(self.eMenu_S1[ menu ][ "slider" ][ curs ]))
			{
				if(!isDefined(self.eMenu_SS[ menu+"_Slider_Cursor_"+curs ]))
					self.eMenu_SS[ menu+"_Slider_Cursor_"+curs ] = 1;
				self thread [[ self buildFromMenu().eMenu_F[ menu ][ "function" ][ curs ] ]]( self.eMenu_S1[ menu ][ "slider" ][ curs ][ self.eMenu_SS[ menu+"_Slider_Cursor_"+curs ] ], self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ], self buildFromMenu().eMenu_I2[ menu ][ "i2" ][ curs ], self buildFromMenu().eMenu_I3[ menu ][ "i3" ][ curs ], self buildFromMenu().eMenu_I4[ menu ][ "i4" ][ curs ], self buildFromMenu().eMenu_I5[ menu ][ "i5" ][ curs ]);
			}
			else self thread [[ self buildFromMenu().eMenu_F[ menu ][ "function" ][ curs ] ]]( self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ], self buildFromMenu().eMenu_I2[ menu ][ "i2" ][ curs ], self buildFromMenu().eMenu_I3[ menu ][ "i3" ][ curs ], self buildFromMenu().eMenu_I4[ menu ][ "i4" ][ curs ], self buildFromMenu().eMenu_I5[ menu ][ "i5" ][ curs ]);
			wait .2;
		}
		else if(self meleeButtonPressed())
		{
			self playsoundtoplayer("", self);//MENU CLOSING SOUND
			if(self getCurrentMenu() == "main")
			{
				self thread closeMenu();
				break;
			}
			else
				self newMenu();
			wait .2;
		}
		wait .05;
	}
}

openMenu()
{
	self.eMenu["inMenu"] = true;
	if(isDefined(self.eMenu[ "CurrentMenu" ]))
		menu = self getCurrentMenu();
	else menu = "main";
	
	self setCurrentMenu(menu);
	self menuOptions(menu);
	self drawMenu();
	self thread menuHandler();
}

closeMenu()
{
	foreach(text in self.eMenu["OPT"])
	{
		text thread hudMoveY(0, .35);
		text thread hudFade(0, .35);
	}
	
	self.eMenu["HUDS"]["Background"] ScaleOverTime(.35, 155, 0);
	
	foreach(hud in self.eMenu["HUDS"])
	{
		hud thread hudFade(0, .35);
		hud thread hudMoveY(0, .35);
	}
	wait .35;
	
	self destroyMenu( true );
	self.eMenu["inMenu"] = undefined;
	self thread watchOpenMenu();
}

drawMenu()
{
	if(!isDefined( self.eMenu["OPT"]))
		self.eMenu["OPT"] = [];
	if(!isDefined( self.eMenu["HUDS"]))
		self.eMenu["HUDS"] = [];	
		
	self.eMenu["HUDS"]["Background"] = self createRectangle("CENTER", "CENTER", 0, -38, 155, 0, self.eMenu["Bg_Colour"], "white", 2, 0);
	self.eMenu["HUDS"]["Background"] thread hudFade(.6, .35);
	self.eMenu["HUDS"]["Background"] ScaleOverTime(.35, 155, 176);
	
	self.eMenu["HUDS"]["Banner"] = self createRectangle("TOP", "CENTER", 0, 0, 155, 40, self.eMenu["Main_Colour"], "white", 10, 0);	
	self.eMenu["HUDS"]["Banner"] thread hudFade(.7, .35);
	self.eMenu["HUDS"]["Banner"] thread hudMoveY(-165, .35);
	
	self.eMenu["HUDS"]["MenuName"] = self createOtherText("big", 2, "TOP", "CENTER", 0, 0, 11, 0, level.menuName, self.eMenu["Title_Colour"]);
	self.eMenu["HUDS"]["MenuName"] thread hudFade(1, .35);
	self.eMenu["HUDS"]["MenuName"] thread hudMoveY(-155, .35);
	
	self.eMenu["HUDS"]["InfoBox"] = self createRectangle("BOTTOM", "CENTER", 0, -15, 155, 15, self.eMenu["Main_Colour"], "white", 10, 0);
	self.eMenu["HUDS"]["InfoBox"] thread hudFade(.7, .35);
	self.eMenu["HUDS"]["InfoBox"] thread hudMoveY(65, .35);
	
	self.eMenu["HUDS"]["InfoTxt"] = self createText("small", 1, "LEFT", "CENTER", -70, -15, 11, 0, "by "+level.developer, self.eMenu["Title_Colour"]);
	self.eMenu["HUDS"]["InfoTxt"] thread hudFade(1, .35);
	self.eMenu["HUDS"]["InfoTxt"] hudMoveY(57, .35);
	
	self.eMenu["HUDS"]["Title"] = self createOtherText("small", 1.2, "CENTER", "CENTER", 0, -118, 11, 0, "", self.eMenu["Title_Colour"]);
	self.eMenu["HUDS"]["Scroller"] = self createRectangle("CENTER", "CENTER", 0, -100, 155, 13, self.eMenu["Main_Colour"], "white", 11, 0);
	
	self drawText(0, 0);
	self setMenuTitle();
}

drawText( x, alpha )
{
	self destroyAll(self.eMenu["OPT"]);

	start = 0;
	text = self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"];
	
	max = 11;
	center = 5;
	centerBig = 6;
	
	if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] > center && self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] < text.size-centerBig && text.size > max)
		start = self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]-center;
	if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] > text.size-(centerBig + 1) && text.size > max)
		start = text.size-max;
	
	if(isDefined( level.eShader[ self getCurrentMenu() ]))
		sizes = strTok(level.eShader[ self getCurrentMenu() ],";");
	
	numOpts = text.size;
	if(numOpts >= max)
		numOpts = max;
	
	for(e=0;e<numOpts;e++)
	{
		if(isDefined(self.eMenu_ST[ self getCurrentMenu() ][ e+start ]))
			text = self buildFromMenu().eMenu_ST[ self getCurrentMenu() ];
		else text = self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"];
		
		if(isDefined( text ) && isDefined( level.eShader[ self getCurrentMenu() ] ))
		{
			if(IsSubStr(text[e+start], ","))
			{
				colour = strTok(text[e+start], ",");
				shader = "white";
			}
			else 
			{
				shader = text[e+start];
				colour = strTok("255,255,255", ",");
			}
			self.eMenu["OPT"][e+start] = self createRectangle("CENTER","CENTER",0,-100 + (e*14),int(sizes[0]), int(sizes[1]), divideColor(int(colour[0]), int(colour[1]), int(colour[2])), shader, 12, alpha);
		}
		else if(isDefined( text ))
		{
			self.eMenu["OPT"][e+start] = self createOtherText("small",1,"CENTER","CENTER",0,-100 + (e*14),12,alpha,text[e+start],self grabMenuColour(e+start));
			self.eMenu["OPT"][e+start] thread hudFade(1,.25);
		}
	}	
		
	self.scrolling["def"] = self.eMenu_C[ self getCurrentMenu()+"_Cursor" ];
	self.eMenu["HUDS"]["Scroller"] thread hudMoveY(self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y-0,.16);
	self.eMenu["HUDS"]["Scroller"] thread hudFade(.6,.16);
	self.eMenu["HUDS"]["Title"] hudFade(1,.16);
	self thread menuScrollColors( self getCursor() );
}

scrollingSystem(dir,ary)
{
	max = 11;
	center = 5;
	centerBig = 6;

	if(isDefined( level.eShader[ self getCurrentMenu() ]))
		sizes = strTok(level.eShader[ self getCurrentMenu() ],";");

	if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] < 0 || self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] > ary.size-1)
	{
		if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] < 0)
			self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] = ary.size-1;
		else
			self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] = 0;
			
		self.scrolling["def"] = self.eMenu_C[ self getCurrentMenu()+"_Cursor" ];
		if(ary.size > max)
		{
			self destroyAll(self.eMenu["OPT"]);
			curs = 0;
			if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] != 0) 
				curs = (ary.size)-max;
				
			for(e=0;e<max;e++)
			{
				if(isDefined(self.eMenu_ST[ self getCurrentMenu() ][ e+curs ]))
					ary1 = self buildFromMenu().eMenu_ST[ self getCurrentMenu() ];
				else ary1 = ary;
				
				if(isDefined( level.eShader[ self getCurrentMenu() ] ))
				{
					if(IsSubStr(ary1[e+curs], ","))
					{
						colour = strTok(ary1[e+curs], ",");
						shader = "white";
					}
					else 
					{
						shader = ary1[e+curs];
						colour = strTok("255,255,255", ",");
					}
					self.eMenu["OPT"][e+curs] = self createRectangle("CENTER","CENTER",0,-100 + (e*14),int(sizes[0]), int(sizes[1]), divideColor(int(colour[0]), int(colour[1]), int(colour[2])), shader, 12, 1);
				}
				else
				{
					self.eMenu["OPT"][e+curs] = self createOtherText("small",1,"CENTER","CENTER",0,-100 + (e*14),12,1,ary1[e+curs],self grabMenuColour(e+curs));
				}
			}
		}
	}
	if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] < ary.size-centerBig && self.scrolling["def"] > center || self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] > center && self.scrolling["def"] < ary.size-centerBig)
	{
		for(e=0;e<ary.size;e++) self.eMenu["OPT"][e] thread hudMoveY(self.eMenu["OPT"][e].y-14*dir,.16);
		self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+centerBig*dir*-1] thread hudFadenDestroy(0,.15);
		
		if(isDefined(self.eMenu_ST[ self getCurrentMenu() ][ self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir ]))
			ary = self buildFromMenu().eMenu_ST[ self getCurrentMenu() ];
		
		if(isDefined( level.eShader[ self getCurrentMenu() ] ))
		{
			if(IsSubStr(ary[self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir], ","))
			{
				colour = strTok(ary[self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir], ",");
				shader = "white";
			}
			else 
			{
				shader = ary[self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir];
				colour = strTok("255,255,255", ",");
			}
			self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] = self createRectangle("CENTER","CENTER",0,self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y+center*14*dir,int(sizes[0]), int(sizes[1]), divideColor(int(colour[0]), int(colour[1]), int(colour[2])), shader, 12, 0);
		}
		else
		{
			self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] = self createOtherText("small",1,"CENTER","CENTER",0,self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y+center*14*dir,12,0,ary[self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir],self grabMenuColour(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir));
		}
		wait .05;
		self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] thread hudFade(1,.18);
	}	
	else
		self.eMenu["HUDS"]["Scroller"] thread hudMoveY(self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y-0,.16);
	
	self.scrolling["def"] = self.eMenu_C[ self getCurrentMenu()+"_Cursor" ];
	self thread menuScrollColors( self getCursor() );
}

revalueScrolling(X)
{
	self scrollingSystem(X,self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"]);
}

setMenuTitle( text )
{
	if(!isDefined(self buildFromMenu().eMenu_T[ self getCurrentMenu() ][ "Title" ]))
		self.eMenu["HUDS"]["Title"] setText("^1Undefined Menu");
	else if(!isDefined( text ))
		self.eMenu["HUDS"]["Title"] setText(self buildFromMenu().eMenu_T[ self getCurrentMenu() ][ "Title" ]);
	else 
		self.eMenu["HUDS"]["Title"] setText( text );
}

refreshTitle()
{
	if(isDefined(self.eMenu["HUDS"]["Title"]))
		self.eMenu["HUDS"]["Title"] destroy();
	if(isDefined(self.eMenu["HUDS"]["MenuName"]))
		self.eMenu["HUDS"]["MenuName"] destroy();	
		
	self.eMenu["HUDS"]["Title"] = self createOtherText("small", 1.2, "CENTER", "CENTER", 0, -115, 11, 1, "", self.eMenu["Title_Colour"]);
	self.eMenu["HUDS"]["MenuName"] = self createOtherText("big", 2, "TOP", "CENTER", 0, -155, 11, 1, level.menuName, self.eMenu["Title_Colour"]);
	self setMenuTitle();
}

destroyMenu( all )
{	
	self destroyAll( self.eMenu[ "OPT" ] );
	
	if(isDefined(all))
	{
		if(isDefined(self.eMenu[ "OPT" ])) 
			self destroyAll(self.eMenu[ "OPT" ]);
		if(isDefined(self.eMenu[ "HUDS" ]))
			self destroyAll(self.eMenu[ "HUDS" ]);
		if(isDefined(self.eMenu[ "OPT_BG" ]))
			self destroyAll(self.eMenu[ "OPT_BG" ]);
	}
}

menuScrollColors( curs )
{
	if(isDefined(self.eMenu_D[ self getCurrentMenu() ][ "description" ][ curs ]))
		self.eMenu["HUDS"]["InfoTxt"] setSafeText(self.eMenu_D[ self getCurrentMenu() ][ "description" ][ curs ]);
	else 
		self.eMenu["HUDS"]["InfoTxt"] setSafeText("by "+level.developer);

	if(isDefined( level.eShader[ self getCurrentMenu() ] ))
	{
		for(e=0;e<self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"].size;e++)
		{
			self.eMenu["OPT"][e] fadeOverTime(.3);
			self.eMenu["OPT"][e].alpha = .25;
		}
		self.eMenu["OPT"][curs] fadeOverTime(.3);
		self.eMenu["OPT"][curs].alpha = 1;
		return;
	}
	
	self.eMenu["OPT_BG"][ curs ] fadeOverTime(.3);
	self.eMenu["OPT_BG"][ curs ].color = self.eMenu["Opt_Colour"];
	
	colour = self grabMenuColour( curs );
	if(!isDefined(self.eMenu_C1[ self getCurrentMenu() ][ "colour" ][ curs ]))
		colour = self.eMenu["Curs_Colour"];
		
	self.eMenu["OPT"][ curs ] fadeOverTime(.3);
	self.eMenu["OPT"][ curs ].color = colour;
}

SetColour( Var, Menu, Opt )
{
	if(self hasMenu())
	{
		if(isDefined(Menu))
		{
			if(isDefined(Var))
				self setOptionColor(self.eMenu["Select_Colour"],Menu,Opt);
			else
				self setOptionColor(self.eMenu["Opt_Colour"],Menu,Opt);
		}
		else
		{
			if(isDefined(Var))
				self setOptionColor(self.eMenu["Select_Colour"]);
			else
				self setOptionColor(self.eMenu["Opt_Colour"]);
		}
	}	
}

setOptionColor( colour, menu, curs )
{
	if(!isDefined( menu ))
		menu = self getCurrentMenu();
	if(!isDefined( curs ))
		curs = self getCursor();

	self.eMenu_C1[ menu ][ "colour" ][ curs ] = colour;
	
	if(colour == self.eMenu["Opt_Colour"])
	{
		if(self getCurrentMenu() == menu)
		{
			self.eMenu[ "OPT" ][ curs ] fadeOverTime(.1);
			self.eMenu[ "OPT" ][ curs ].color = self.eMenu["Curs_Colour"];
		}
		self.eMenu_C1[ menu ][ "colour" ][ curs ] = undefined;
	}
	if(colour == self.eMenu["Select_Colour"])
	{
		if(self getCurrentMenu() == menu)
		{
			self.eMenu[ "OPT" ][ curs ] fadeOverTime(.15);
			self.eMenu[ "OPT" ][ curs ].color = self.eMenu["Select_Colour"];
		}
	}
}

updateMenu( text, menu, curs )
{
	if( !isDefined( menu ) ) 
		menu = self getCurrentMenu();
	if( !isDefined( curs ) )
		curs = self getCursor();
	
	//self.eMenu_O[ menu ][ "option" ][ curs ] = text;
	self.eMenu_ST[ menu ][ curs ] = text;
		
	if(self isInMenu() && self getCurrentMenu() == menu && isDefined( self.eMenu[ "OPT" ][ curs ] ))
		self.eMenu[ "OPT" ][ curs ] setSafeText(text);
}

setMenuColours(var, huds, colour)
{
	self.eMenu[ var ] = colour;
	
	if(huds == "Scroller;Banner;InfoBox" || huds == "Title;InfoTxt;MenuName" || huds == "Background")
	{
		hud = strTok(huds, ";");
		for(e=0;e<huds.size;e++)
		{
			self.eMenu["HUDS"][ hud[e] ] fadeOverTime(.2);
			self.eMenu["HUDS"][ hud[e] ].color = colour;
		}	
	}
}

welcomeMessage()
{
	self.eMenu["HUDS"]["Welcome0"] = self createText("small",1.6,"TOP","TOP",0,0,9,1,"Welcome To ^2"+level.menuName+"^7 Your Access Level Is ^2"+self.verStatus,(1,1,1));
	self.eMenu["HUDS"]["Welcome1"] = self createText("small",1.6,"TOP","TOP",0,16,9,1,"^2"+level.menuName+"^7 Developed By ^2"+level.developer,(1,1,1));
	self.eMenu["HUDS"]["Welcome0"] setTypeWriterFx(50, 4500, 700);
	self.eMenu["HUDS"]["Welcome1"] setTypeWriterFx(50, 4500, 700);
	wait 8;
	for(e=0;e<2;e++)
		if(isDefined(self.eMenu["HUDS"]["Welcome"+e]))
			self.eMenu["HUDS"]["Welcome"+e] destroy();
}









