/* Referances ~ 
	How to add submenus;
		To add submenus you need to do the following. Add a Option under the 'main' submenu. for example like this.
			self addOpt("<OPTION NAME>", "<OPTION DESCRIPTION>",::newMenu,"<SUBMENU NAME>");
				Once you have done that you would need to add a 'addMenu' then add options underneath that, here is an example.
					self addMenu("<SUBMENU NAME>", "<SUBMENU TITLE>");
						If you would like a access level set on a certain sub menu you simply do the following
							self addMenu("<SUBMENU NAME>", "<SUBMENU TITLE>", "<ACCESS LEVELS>");
								if you would like to do a shader menu you would do the following
									self addMenu("<SUBMENU NAME>", "<SUBMENU TITLE>", "<ACCESS LEVELS>", "<SHADER WIDTH;SHADER HEIGHT>");//NOTE you need a semicolon inbetween the width and height
	How to add options;
		To add options you need to do the following, under your 'self addMenu("<SUBMENU NAME>", "<SUBMENU TITLE>");'
			self addOpt("<OPTION NAME>", "OPTION DESCRIPTION",<::FUNCTION CALL>); //NOTE: YOU CAN USE 5 PARAMETERS AFTER THE FUNCTION CALL 
			
	If you still need further help feel free to contact me on skype: Extinctxo
		Enjoy using my menu base!*/
menuOptions()
{
	self addMenu("main", level.menuName);
		self addOpt("Shader Menu Test", "",::newMenu,"shader");
		self addOpt("Toggle Tests", "",::newMenu,"toggle");
		self addOpt("Submenu 3", "",::newMenu,"sub3");
		self addOpt("Overflow Test", "",::newMenu,"overflow");
		self addOpt("Menu Customizations", "Change Menu Design",::newMenu,"customize");
		self addOpt("Client Options", "",::newMenu,"Client");
		self addOpt("giveMenuBots", "", ::giveMenuBots);
	
	self addMenu("shader", "Shader Menu Test");
		self addOpt("Prestige Icons", "",::newMenu,"prestige");
		self addOpt("Rank Icons", "",::newMenu,"rank");
	
	self addMenu("prestige", "Prestige Icons", undefined, "17;17");
		for(e=1;e<level.rankPrestige.size;e++) self addOpt(level.rankPrestige[e], "Sets Prestige To "+e);
	self addMenu("rank", "Rank Icons", undefined, "17;17");
		for(e=1;e<level.rankBadges.size;e++) self addOpt(level.rankBadges[e],"Sets Rank To "+e);
			
	self addMenu("overflow", "Overflow Test");
		for(e=1;e<100;e++) self addOpt("Testing "+e, "Current Opt Testing "+e, "");	
		
	self addMenu("toggle", "Toggle Test");
		self addOpt("Colour Toggle Test", "Colour Toggle Testing", ::testColourToggle);	
		self addOpt("Text Toggle Test", "Menu Text Toggle", ::testTextToggle);	
		
	self addMenu("customize", "Menu Customizations");
		menuNames = strTok("Main|Title & Info|Options|Options BG|Select|Cursor","|");
		varNames = strTok("Main_Colour|Title_Colour|Opt_Colour|Opt_BG_Colour|Select_Colour|Curs_Colour", "|");
		menuHuds = strTok("Background;Banner;InfoBox|Title;InfoTxt|OPT|OPT_BG|UPDATE|UPDATE", "|");
		colourNames = strTok("Royal Blue|Raspberry|Skyblue|Hot Pink|Green|Brown|Blue|Red|Orange|Purple|Cyan|Yellow|Black|White","|");
		colours = strTok("34|64|139|135|38|87|135|206|250|255|23|153|0|255|0|101|67|33|0|0|255|255|0|0|255|128|0|153|26|255|0|255|255|255|255|0|0|0|0|255|255|255","|");
		for(i=0;i<menuNames.size;i++)
			self addOpt(menuNames[i], "", ::newMenu, menuNames[i]);
		for(i=0;i<menuNames.size;i++)
		{
			self addMenu(menuNames[i], menuNames[i], "Host;Co-Host;Admin", "100;15");
			for(e=0;e<colours.size;e++)
				self addOpt(colours[3*e]+","+colours[(3*e)+1]+","+colours[(3*e)+2], "Sets Colour To "+colourNames[e], ::setMenuColours, varNames[i], menuHuds[i], divideColor(int(colours[3*e]), int(colours[(3*e)+1]), int(colours[(3*e)+2]))); 
		}
	self playerOptions();	
}

playerOptions()
{
	self addMenu("Client", "Client Options");
	foreach(player in level.players)
		self addOpt("[^2"+player.verStatus+"^7] "+player getName(), "",::newMenu,"Client "+player getEntityNumber());
	
	foreach(player in level.players)
	{
		self addMenu("Client "+player getEntityNumber(), "[^2"+player.verStatus+"^7] "+player getName());
			self addOpt("Verification System", "Gives people the menu",::newMenu,"verify "+player getEntityNumber());
			self addOpt("EXAMPLE MENU", "Example",::newMenu, "example "+player getEntityNumber());
		
		self addMenu("verify "+player getEntityNumber(), player getName()+" Verification");
		for(e=0;e<level.status.size-1;e++)
			self addOpt("Set Verification To "+level.status[e], "", ::initialSetUp[e], e, player, true);
			
		self addMenu("example "+player getEntityNumber(), "Example Menu");	
			self addOpt("EXAMPLE");
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
				
				self.eMenu["OPT_BG"][ curs ] fadeOverTime(.2);
				self.eMenu["OPT_BG"][ curs ].color = self.eMenu["Opt_BG_Colour"];
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
		else if( self useButtonPressed() )
		{
			curs = self getCursor();
			menu = self getCurrentMenu();
			
			if(self getCurrentMenu() == "main")
			{
				if(!isDefined(self.eMenu_A[ self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ] ][ "access" ]))
					self.eMenu_A[ self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ] ][ "access" ] = "VIP;Admin;Co-Host;Host";	
				
				accessLevels = strTok(self.eMenu_A[ self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ] ][ "access" ], ";");
				for(e=0;e<accessLevels.size;e++)
				{
					if(accessLevels[e] == self.verStatus)
						self thread [[ self buildFromMenu().eMenu_F[ menu ][ "function" ][ curs ] ]]( self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ], self buildFromMenu().eMenu_I2[ menu ][ "i2" ][ curs ], self buildFromMenu().eMenu_I3[ menu ][ "i3" ][ curs ], self buildFromMenu().eMenu_I4[ menu ][ "i4" ][ curs ], self buildFromMenu().eMenu_I5[ menu ][ "i5" ][ curs ]);
				}
				if(self getCurrentMenu() == "main")
					self iprintln("^1Error^7: Your access level is not high enough to access this submenu.");
			}
			else self thread [[ self buildFromMenu().eMenu_F[ menu ][ "function" ][ curs ] ]]( self buildFromMenu().eMenu_I[ menu ][ "i1" ][ curs ], self buildFromMenu().eMenu_I2[ menu ][ "i2" ][ curs ], self buildFromMenu().eMenu_I3[ menu ][ "i3" ][ curs ], self buildFromMenu().eMenu_I4[ menu ][ "i4" ][ curs ], self buildFromMenu().eMenu_I5[ menu ][ "i5" ][ curs ]);
			wait .2;
		}
		else if(self meleeButtonPressed())
		{
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
	self setCurrentMenu("main");
	self thread drawMenu();
	wait .2;
	self thread menuHandler();
}

closeMenu()
{
	self.eMenu["inMenu"] = undefined;
	self destroyMenu( true );
	self thread watchOpenMenu();
}

drawMenu()
{
	if(!isDefined( self.eMenu["OPT"]))
		self.eMenu["OPT"] = [];
	if(!isDefined( self.eMenu["OPT_BG"] ))
		self.eMenu["OPT_BG"] = [];
	if(!isDefined( self.eMenu["HUDS"]))
		self.eMenu["HUDS"] = [];	
		
	//self.eMenu["HUDS"]["Scroller"] = self createRectangle("CENTER", "CENTER", 0, -115, 135, 15, (0,0,0), "white", 1, .8);	
	self.eMenu["HUDS"]["Background"] = self createRectangle("TOP", "CENTER", 0, -145, 135, 0, self.eMenu["Main_Colour"], "white", 2, .6);
	self.eMenu["HUDS"]["Title"] = self createOtherText("small", 1.3, "TOP", "CENTER", 0, -145, 11, 1, "", self.eMenu["Title_Colour"]);
	self.eMenu["HUDS"]["Banner"] = self createRectangle("TOP", "CENTER", 0, -145, 135, 15, self.eMenu["Main_Colour"], "white", 10, 1);
	self.eMenu["HUDS"]["InfoBox"] = self createRectangle("TOP", "CENTER", 0, -145, 135, 15, self.eMenu["Main_Colour"], "white", 10, 1);
	self.eMenu["HUDS"]["InfoTxt"] = self createOtherText("small", 1, "TOP", "CENTER", 0, -145, 11, 1, "", self.eMenu["Title_Colour"]);
	
	self resizeMenuBg();
	self drawText(0, 0);	
	self setMenuTitle();
}

drawText( x, alpha )
{
	self destroyAll(self.eMenu["OPT"]);
	self destroyAll(self.eMenu["OPT_BG"]);

	start = 0;
	text = self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"];
	
	if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] > 3 && self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] < text.size-4 && text.size > 7)
		start = self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]-3;
	if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] > text.size-5 && text.size > 7)
		start = text.size-7;
	
	if(isDefined( level.eShader[ self getCurrentMenu() ]))
		sizes = strTok(level.eShader[ self getCurrentMenu() ],";");
	
	numOpts = text.size;
	if(numOpts >= 7)
		numOpts = 7;
	
	for(e=0;e<numOpts;e++)
	{
		if(isDefined( text ) && isDefined( level.eShader[ self getCurrentMenu() ] ))
		{
			if(IsSubStr(self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"][e+start], ","))
			{
				colour = strTok(self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"][e+start], ",");
				shader = "white";
			}
			else 
			{
				shader = self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"][e+start];
				colour = strTok("255,255,255", ",");
			}
			self.eMenu["OPT"][e+start] = self createRectangle("CENTER","CENTER",0,-115 + (e*16),int(sizes[0]), int(sizes[1]), divideColor(int(colour[0]), int(colour[1]), int(colour[2])), shader, 9, alpha);
			//self.eMenu["OPT_BG"][e+start] = self createRectangle("CENTER","CENTER",0,-115 + (e*16),100, 15, self.eMenu["Opt_BG_Colour"],"white", 8, alpha);
		}
		else if(isDefined( text ))
		{
			self.eMenu["OPT"][e+start] = self createOtherText("small",1,"CENTER","CENTER",0,-115 + (e*16),9,alpha,self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"][e+start],self grabMenuColour(e+start));
			self.eMenu["OPT_BG"][e+start] = self createRectangle("CENTER","CENTER",0,-115 + (e*16),100, 15, self.eMenu["Opt_BG_Colour"],"white", 8, alpha);
			self.eMenu["OPT_BG"][e+start] thread hudFade(1,.25);
		}
		self.eMenu["OPT"][e+start] thread hudFade(1,.25);
	}	
		
	self.scrolling["def"] = self.eMenu_C[ self getCurrentMenu()+"_Cursor" ];
	self thread menuScrollColors( self getCursor() );
	//self.eMenu["HUDS"]["Scroller"] thread hudMoveY(self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y-0,.16);
}

scrollingSystem(dir,ary)
{
	max = 7;
	center = 3;
	centerBig = 4;

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
			self destroyAll(self.eMenu["OPT_BG"]);
			curs = 0;
			if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] != 0) 
				curs = (ary.size)-max;
			for(e=0;e<max;e++)
			{
				if(isDefined( level.eShader[ self getCurrentMenu() ] ))
				{
					if(IsSubStr(ary[e+curs], ","))
					{
						colour = strTok(ary[e+curs], ",");
						shader = "white";
					}
					else 
					{
						shader = ary[e+curs];
						colour = strTok("255,255,255", ",");
					}
					self.eMenu["OPT"][e+curs] = self createRectangle("CENTER","CENTER",0,-115 + (e*16),int(sizes[0]), int(sizes[1]), divideColor(int(colour[0]), int(colour[1]), int(colour[2])), shader, 9, 1);
					//self.eMenu["OPT_BG"][e+curs] = self createRectangle("CENTER","CENTER",0,-115 + (e*16),100, 15, (0,0,0),"white", 8, 1);
				}
				else
				{
					self.eMenu["OPT"][e+curs] = self createOtherText("small",1,"CENTER","CENTER",0,-115 + (e*16),9,1,ary[e+curs],self grabMenuColour(e+curs));
					self.eMenu["OPT_BG"][e+curs] = self createRectangle("CENTER","CENTER",0,-115 + (e*16),100, 15, self.eMenu["Opt_BG_Colour"],"white", 8, 1);
				}
			}
		}
	}
	if(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] < ary.size-centerBig && self.scrolling["def"] > center || self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] > center && self.scrolling["def"] < ary.size-centerBig)
	{
		for(e=0;e<ary.size;e++) self.eMenu["OPT"][e] thread hudMoveY(self.eMenu["OPT"][e].y-16*dir,.16);
		for(e=0;e<ary.size;e++) self.eMenu["OPT_BG"][e] thread hudMoveY(self.eMenu["OPT_BG"][e].y-16*dir,.16);
		
		self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+centerBig*dir*-1] thread hudFadenDestroy(0,.15);
		self.eMenu["OPT_BG"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+centerBig*dir*-1] thread hudFadenDestroy(0,.15);
		
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
			self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] = self createRectangle("CENTER","CENTER",0,self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y+center*16*dir,int(sizes[0]), int(sizes[1]), divideColor(int(colour[0]), int(colour[1]), int(colour[2])), shader, 9, 0);
			//self.eMenu["OPT_BG"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] = self createRectangle("CENTER","CENTER",0,self.eMenu["OPT_BG"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y+center*16*dir,100, 15, (0,0,0),"white", 8, 0);
		}
		else
		{
			self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] = self createOtherText("small",1,"CENTER","CENTER",0,self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y+center*16*dir,9,0,ary[self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir],self grabMenuColour(self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir));
			self.eMenu["OPT_BG"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] = self createRectangle("CENTER","CENTER",0,self.eMenu["OPT_BG"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y+center*16*dir,100, 15, self.eMenu["Opt_BG_Colour"],"white", 8, 0);
		}
		wait .05;
		self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] thread hudFade(1,.18);
		self.eMenu["OPT_BG"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ]+center*dir] thread hudFade(1,.18);
	}	
	//else
	//	self.eMenu["HUDS"]["Scroller"] thread hudMoveY(self.eMenu["OPT"][self.eMenu_C[ self getCurrentMenu()+"_Cursor" ] ].y-0,.16);
	
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
	self.eMenu["HUDS"]["Title"] = self createOtherText("small", 1.3, "TOP", "CENTER", 0, -145, 11, 1, "", self.eMenu["Title_Colour"]);
	self setMenuTitle();
	self resizeMenuBg();
}

destroyMenu( all )
{	
	self destroyAll( self.eMenu[ "OPT" ] );
	self destroyAll( self.eMenu[ "OPT_BG" ] );
	
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

resizeMenuBg()
{
	text = self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"];
	numOpts = text.size;
	if(numOpts >= 7)
		numOpts = 7;
	self.eMenu["HUDS"]["Background"] scaleOverTime(.1, 135, ((numOpts*16) + 30));
	self.eMenu["HUDS"]["InfoBox"] thread hudMoveY(((numOpts*16) - 116) ,.1);
	self.eMenu["HUDS"]["InfoTxt"] thread hudMoveY(((numOpts*16) - 116) ,.1);
}

menuScrollColors( curs )
{
	if(self.eMenu_D[ self getCurrentMenu() ][ "description" ][ curs ].size != 0)
		self.eMenu["HUDS"]["InfoTxt"] setSafeText(self.eMenu_D[ self getCurrentMenu() ][ "description" ][ curs ]);
	else 
		self.eMenu["HUDS"]["InfoTxt"] setSafeText("Developer - "+level.developer);

	if(isDefined( level.eShader[ self getCurrentMenu() ] ))
	{
		for(e=0;e<self buildFromMenu().eMenu_O[ self getCurrentMenu() ]["option"].size;e++)
		{
			self.eMenu["OPT"][e] fadeOverTime(.3);
			self.eMenu["OPT"][e].alpha = .2;
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
	
	self.eMenu_O[ menu ][ "option" ][ curs ] = text;
		
	if(self isInMenu() && self getCurrentMenu() == menu && isDefined( self.eMenu[ "OPT" ][ curs ] ))
		self.eMenu[ "OPT" ][ curs ] setSafeText(text);
}

setMenuColours(var, huds, colour)
{
	self.eMenu[ var ] = colour;
	
	if(huds == "Background;Banner;InfoBox" || huds == "Title;InfoTxt")
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
	self.eMenu["HUDS"]["Welcome0"] = self createOtherText("small",1.6,"TOP","TOP",0,0,9,1,"Welcome To ^2"+level.menuName+"^7 Your Access Level Is ^2"+self.verStatus,(1,1,1));
	self.eMenu["HUDS"]["Welcome1"] = self createOtherText("small",1.6,"TOP","TOP",0,16,9,1,"^2"+level.menuName+"^7 Developed By ^2"+level.developer,(1,1,1));
	self.eMenu["HUDS"]["Welcome0"] setTypeWriterFx(50, 4500, 700);
	self.eMenu["HUDS"]["Welcome1"] setTypeWriterFx(50, 4500, 700);
	wait 8;
	for(e=0;e<2;e++)
		if(isDefined(self.eMenu["HUDS"]["Welcome"+e]))
			self.eMenu["HUDS"]["Welcome"+e] destroy();
}

