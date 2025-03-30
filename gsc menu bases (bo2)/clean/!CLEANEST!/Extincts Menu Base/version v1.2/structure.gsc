initialSetUp( num, player, update )
{
	if( level.status[ num ] != player.verStatus )
	{	
		if(isDefined( update ) && player.verStatus == level.status[ 4 ])
		{
			player iprintln("You can not edit players with verification level ^2Host");
			return;
		}
		player.verStatus = level.status[num];
		if(isDefined( update ))
		{
			self playerOptions();
			self refreshTitle();
		}
		if( self.verStatus == "None" )
		{
			player destroyMenu( true );
			player.eMenu["inMenu"] = undefined;
			player endon("end_Menu");
			return;
		}
		if(player isInMenu())
		{
			player destroyMenu( true ); 
			player.eMenu["inMenu"] = undefined;
		}
		player.previousSubMenu = [];
		player loadClientVars();
		player setCurrentMenu("main");
		player menuOptions("main");
		player thread watchOpenMenu();
		player thread welcomeMessage();
	}
}

initializeMenuArrays( menu )
{
	if(!isDefined(self.eMenu_ST[ menu ]))
		self.eMenu_ST[ menu ] = [];
	self.eMenu_T[ menu ] = [];//Menu Title
	self.eMenu_S[ menu ] = [];//Menu Save Curs
	self.eMenu_O[ menu ] = [];//Menu Options
	self.eMenu_F[ menu ] = [];//Menu Function
	self.eMenu_S1[ menu ] = [];//Menu Slider
	self.eMenu_I[ menu ] = [];//Menu Input 1
	self.eMenu_I2[ menu ] = [];//Menu Input 2
	self.eMenu_I3[ menu ] = [];//Menu Input 3
	self.eMenu_C[ menu ] = [];//Menu Cursor
	if(!isDefined(self.eMenu_C1[ menu ]))
		self.eMenu_C1[ menu ] = [];//Menu Colour Toggle
	self.eMenu_D[ menu ] = [];//Menu Description
	self.eMenu_A[ menu ] = [];//Menu Access Level
}

addMenu( menu, title, access, shader )
{	
	self initializeMenuArrays( menu );
	if(isDefined( title ))
		self.eMenu_T[ menu ][ "Title" ] = title;
	if(isDefined( shader ))
		level.eShader[ menu ] = shader;	
	if(isDefined( access ))	
		self.eMenu_A[ menu ][ "access" ] = access;
	else 
		self.eMenu_A[ menu ][ "access" ] = "VIP;Admin;Co-Host;Host";	
		
	self.eMenu_S[ "save" ] = menu;
	
	if(!isDefined( self.eMenu_O[ menu ][ "option" ]))
		self.eMenu_O[ menu ][ "option" ] = [];
	if(!isDefined( self.eMenu_F[ menu ][ "function" ]))
		self.eMenu_F[ menu ][ "function" ] = [];
	if(!isDefined( self.eMenu_S1[ menu ][ "slider" ] ))
		self.eMenu_S1[ menu ][ "slider" ] = [];
	if(!isDefined( self.eMenu_I[ menu ][ "i1" ]))
		self.eMenu_I[ menu ][ "i1" ] = [];
	if(!isDefined( self.eMenu_I2[ menu ][ "i2" ]))
		self.eMenu_I2[ menu ][ "i2" ] = [];	
	if(!isDefined( self.eMenu_I3[ menu ][ "i3" ]))
		self.eMenu_I3[ menu ][ "i3" ] = [];	
	if(!isDefined( self.eMenu_I4[ menu ][ "i4" ]))
		self.eMenu_I4[ menu ][ "i4" ] = [];	
	if(!isDefined( self.eMenu_I5[ menu ][ "i5" ]))
		self.eMenu_I5[ menu ][ "i5" ] = [];	
	if(!isDefined( self.eMenu_C[ menu+"_Cursor" ]))
		self.eMenu_C[ menu+"_Cursor" ] = 0;
	if(!isDefined( self.eMenu_C1[ menu ][ "colour" ] ))
		self.eMenu_C1[ menu ][ "colour" ] = [];
	if(!isDefined( self.eMenu_D[ menu ][ "description" ] ))	
		self.eMenu_D[ menu ][ "description" ] = [];
}

addOpt( opt, text, func, i1, i2, i3, i4, i5, menu )
{
	if(!isDefined(menu))
		menu = self.eMenu_S[ "save" ];
	optSize = self.eMenu_O[ menu ][ "option" ].size;
	
	self.eMenu_O[ menu ][ "option" ][ optSize ] = opt;
	self.eMenu_F[ menu ][ "function" ][ optSize ] = func;
	self.eMenu_I[ menu ][ "i1" ][ optSize ] = i1;
	self.eMenu_I2[ menu ][ "i2" ][ optSize ] = i2;
	self.eMenu_I3[ menu ][ "i3" ][ optSize ] = i3;
	self.eMenu_I4[ menu ][ "i4" ][ optSize ] = i4;
	self.eMenu_I5[ menu ][ "i5" ][ optSize ] = i5;
	self.eMenu_D[ menu ][ "description" ][ optSize ] = text;
}

addOptSlide( opt, text, func, slider, i1, i2, i3, i4, i5, menu )
{
	if(!isDefined(menu))
		menu = self.eMenu_S[ "save" ];
	optSize = self.eMenu_O[ menu ][ "option" ].size;
	if(isDefined(slider))
		self.eMenu_S1[ menu ][ "slider" ][ optSize ] = strTok(slider, ";");
		
	self.eMenu_O[ menu ][ "option" ][ optSize ] = opt;
	self.eMenu_F[ menu ][ "function" ][ optSize ] = func;
	self.eMenu_I[ menu ][ "i1" ][ optSize ] = i1;
	self.eMenu_I2[ menu ][ "i2" ][ optSize ] = i2;
	self.eMenu_I3[ menu ][ "i3" ][ optSize ] = i3;
	self.eMenu_I4[ menu ][ "i4" ][ optSize ] = i4;
	self.eMenu_I5[ menu ][ "i5" ][ optSize ] = i5;
	self.eMenu_D[ menu ][ "description" ][ optSize ] = text;	
}

newMenu( menu )
{ 
	if(!isDefined( menu ))
	{	
		menu = self.previousSubMenu[ self.previousSubMenu.size-1 ];
		self.previousSubMenu[ self.previousSubMenu.size-1 ] = undefined;
	}
	else
	{
		self.previousSubMenu[ self.previousSubMenu.size ] = self getCurrentMenu();
		self initializeMenuArrays(self.previousSubMenu[ self.previousSubMenu.size-1 ]);
	}
	
	self setCurrentMenu(menu);
	self menuOptions(menu);

	self destroyMenu();
	if(isDefined(self.eMenu_T[ menu ][ "Title" ]))
 	 	self thread drawText(0, 0);
  	self refreshTitle();
}