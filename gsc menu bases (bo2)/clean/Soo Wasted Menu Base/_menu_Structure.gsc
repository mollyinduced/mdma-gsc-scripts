/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : _menu_Structure
*	 Description : 
*	 Date : 2015.07.30 - 05:11:51	
*
*/	

/* loads all the menu structures(called at _loadMenu()) */
getMenuStructures()
{
	self _mainMenuStruct();
	self _playerMenuStruct();
}

/* this stores all your main menus/options and all the other shit */
/*
	self CreateMenu(menu, parent);
	self addOption(menu, text, function, input1, input2, input3);
*/
_mainMenuStruct()
{
	//Main Menu
	self CreateMenu("main","Exit");
	self addOption("main","Widescreen Mode",::toggleWidescreenMode);
	self addOption("main","Debug Exit",::debugExit);
	self addOption("main","Sub Menu",::_loadMenu,"sub1");
	self addOption("main","Scroll Test Menu",::_loadMenu,"subinf");
	self addOption("main","Player Menu",::_loadMenu,"players");
	
	//Sub Menu 1
	self CreateMenu("sub1","main");
	self addOption("sub1","Option 1",::Test,"","","");
	self addOption("sub1","Option 2",::Test,"","","");
	self addOption("sub1","Option 3",::Test,"","","");
	self addOption("sub1","Option 4",::Test,"","","");
	self addOption("sub1","Option 5",::Test,"","","");
	self addOption("sub1","Option 6",::Test,"","","");
	self addOption("sub1","Option 7",::Test,"","","");
	self addOption("sub1","Option 8",::Test,"","","");
	self addOption("sub1","Option 9",::Test,"","","");
	self addOption("sub1","Option 10",::Test,"","","");
	self addOption("sub1","Option 11",::Test,"","","");
	self addOption("sub1","Option 12",::Test,"","","");
	self addOption("sub1","Option 13",::Test,"","","");
	self addOption("sub1","Option 14",::Test,"","","");
	self addOption("sub1","Option 15",::Test,"","","");
	self addOption("sub1","Option 16",::Test,"","","");
	self addOption("sub1","Option 17",::Test,"","","");
	self addOption("sub1","Option 18",::Test,"","","");
	
	//Unlimited Scroll Menu Test
	self CreateMenu("subinf","main");
	self addOption("subinf","Option 1",::Test,"","","");
	self addOption("subinf","Option 2",::Test,"","","");
	self addOption("subinf","Option 3",::Test,"","","");
	self addOption("subinf","Option 4",::Test,"","","");
	self addOption("subinf","Option 5",::Test,"","","");
	self addOption("subinf","Option 6",::Test,"","","");
	self addOption("subinf","Option 7",::Test,"","","");
	self addOption("subinf","Option 8",::Test,"","","");
	self addOption("subinf","Option 9",::Test,"","","");
	self addOption("subinf","Option 10",::Test,"","","");
	self addOption("subinf","Option 11",::Test,"","","");
	self addOption("subinf","Option 12",::Test,"","","");
	self addOption("subinf","Option 13",::Test,"","","");
	self addOption("subinf","Option 14",::Test,"","","");
	self addOption("subinf","Option 15",::Test,"","","");
	self addOption("subinf","Option 16",::Test,"","","");
	self addOption("subinf","Option 17",::Test,"","","");
	self addOption("subinf","Option 18",::Test,"","","");
	self addOption("subinf","Option 19",::Test,"","","");
	self addOption("subinf","Option 20",::Test,"","","");
	self addOption("subinf","Option 21",::Test,"","","");
	self addOption("subinf","Option 22",::Test,"","","");
	self addOption("subinf","Option 23",::Test,"","","");
	self addOption("subinf","Option 24",::Test,"","","");
	self addOption("subinf","Option 25",::Test,"","","");
	self addOption("subinf","Option 26",::Test,"","","");
	self addOption("subinf","Option 27",::Test,"","","");
	self addOption("subinf","Option 28",::Test,"","","");
	self addOption("subinf","Option 29",::Test,"","","");
	self addOption("subinf","Option 30",::Test,"","","");
	self addOption("subinf","Option 31",::Test,"","","");
	self addOption("subinf","Option 32",::Test,"","","");
	self addOption("subinf","Option 33",::Test,"","","");
	self addOption("subinf","Option 34",::Test,"","","");
	self addOption("subinf","Option 35",::Test,"","","");
	self addOption("subinf","Option 36",::Test,"","","");
	self addOption("subinf","Option 37",::Test,"","","");
	self addOption("subinf","Option 38",::Test,"","","");
	self addOption("subinf","Option 39",::Test,"","","");
	self addOption("subinf","Option 40",::Test,"","","");
}

/* same as above just with players */
_playerMenuStruct()
{
	//Players
	self CreateMenu("players","main");
	for(i=0;i<level.players.size;i++)
	{
		guy = level.players[i];
		name = guy getTrueName();
		menu = "player_"+name;
		if(i==0&&self!=level.players[0]){continue;}
		self addOption("players",name,::_loadMenu,menu);
		
		//Player Options
		self CreateMenu(menu,"players");
		self addOption(menu,"Kill",::KillIt,guy);
		self addOption(menu,"Kick",::KickIt,guy);
		self addOption(menu,"UnVerify",::changeVerifycationin,guy,0);
		self addOption(menu,"Verify",::changeVerifycationin,guy,1);
		self addOption(menu,"Vip",::changeVerifycationin,guy,2);
		self addOption(menu,"Admin",::changeVerifycationin,guy,3);
		self addOption(menu,"Host",::changeVerifycationin,guy,4);
	}
}


/* Functions used to store your menus or what ever */
CreateMenu(menu,parent)
{
   if(!isDefined(self.FuZiioN))self.FuZiioN=[];
   self.FuZiioN[menu] = spawnStruct();
   self.FuZiioN[menu].parent = parent;
   self.FuZiioN[menu].text = [];
   self.FuZiioN[menu].func = [];
   self.FuZiioN[menu].inp1 = [];
   self.FuZiioN[menu].inp2 = [];
   self.FuZiioN[menu].inp3 = [];
}
addOption(menu,text,func,inp,inp2,inp3)
{
	F=self.FuZiioN[menu].text.size;
	self.FuZiioN[menu].text[F] = text;
	self.FuZiioN[menu].func[F] = func;
	self.FuZiioN[menu].inp1[F] = inp;
	self.FuZiioN[menu].inp2[F] = inp2;
	self.FuZiioN[menu].inp3[F] = inp3;
}


