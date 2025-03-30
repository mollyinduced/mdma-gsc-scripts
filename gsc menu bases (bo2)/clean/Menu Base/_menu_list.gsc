_menuList()
{
	//Main Menu
	self CreateMenu("LEFT","main","Main Menu","Exit");
	self addOption("main","Developer Menu",::_loadMenu,"test");
	self addOption("main","Sub Menu Test Right",::_loadMenu,"subR");
	self addOption("main","Sub Menu Test Left",::_loadMenu,"subL");
	self addOption("main","Test Option 2",::Test);
	self addOption("main","Test Option 3",::Test);
	self addOption("main","Test Option 4",::Test);
	self addOption("main","Test Option 5",::Test,"","","","Desc Bitch");
	self addOption("main","Test Option 6",::Test,"","","","xePixTvx Is Boss!");
	self addOption("main","Test Option 7",::Test);
	self addOption("main","Test Option 8",::Test);
	self addOption("main","Test Option 9",::Test);
	self addToggleOption("main","Toggle Test Left",::TestToggle,self.ToggleTest,"","","","Just a Toggle Test");
	self addOption("main","Test Option 10",::Test);
	self addOption("main","Test Option 11",::Test);
	self addOption("main","Test Option 12",::Test);
	self addOption("main","Test Option 13",::Test);
	self addOption("main","Players",::_loadMenu,"players","","","Opens the Client Menu");
	
	//Developer Menu
	self CreateMenu("RIGHT","test","Developer Menu","main");
	self addOption("test","Exit Level",::debugExit);
	self addOption("test","Overflow Test",::OverflowTest);
	self addOption("test","Get Origin",::getLoc);
	self addOption("test","Test",::Test);
	self addOption("test","Input Test 1",::InputTest,"LOL");
	self addOption("test","Input Test 2",::InputTest,"LOL","LOL2");
	self addOption("test","Input Test 3",::InputTest,"LOL","LOL2","LOL3");
	self addOption("test","Input Test 4",::InputTest);
	self addOption("test","Description Test 1",::Test,"","","","LOLOLOLOLOLOLOLOLOLOLOLOLOL\nLOLOLOLOLOLOLOLOLOLOLOLOLOL");
	self addOption("test","Description Test 2",::Test,"","","","SourceCode - Source Engine <3\n Respect the Fallen");
	self addToggleOption("test","Toggle Test",::TestToggle,self.ToggleTest);
	for(i=0;i<31;i++){
		self addOption("test","Scrolling Test "+i,::Test);}
	
	//Sub Menu Right
	self CreateMenu("RIGHT","subR","Sub Menu Right","main");
	self addOption("subR","Test Right 1",::Test);
	self addOption("subR","Test Right 2",::Test);
	self addOption("subR","Test Right 3",::Test);
	self addOption("subR","Test Right 4",::Test);
	self addOption("subR","Test Right 5",::Test);
	self addOption("subR","Test Right 6",::Test);
	self addOption("subR","Test Right 7",::Test);
	self addOption("subR","Test Right 8",::Test);
	self addOption("subR","Test Right 9",::Test);
	self addOption("subR","Test Right 10",::Test);
	self addOption("subR","Test Right 11",::Test);
	self addOption("subR","Test Right 12",::Test);
	self addOption("subR","Test Right 13",::Test);
	
	//Sub Menu Left
	self CreateMenu("LEFT","subL","Sub Menu Left","main");
	self addOption("subL","Test Left 1",::Test);
	self addOption("subL","Test Left 2",::Test);
	self addOption("subL","Test Left 3",::Test);
	self addOption("subL","Test Left 4",::Test);
	self addOption("subL","Test Left 5",::Test);
	self addOption("subL","Test Left 6",::Test);
	self addOption("subL","Test Left 7",::Test);
	self addOption("subL","Test Left 8",::Test);
	self addOption("subL","Test Left 9",::Test);
	self addOption("subL","Test Left 10",::Test);
	self addOption("subL","Test Left 11",::Test);
	self addOption("subL","Test Left 12",::Test);
	self addOption("subL","Test Left 13",::Test);
	self addOption("subL","Test Left 14",::Test);
	self addOption("subL","Test Left 15",::Test);
	self addOption("subL","Test Left 16",::Test);
	self addOption("subL","Test Left 17",::Test);
	self addOption("subL","Test Left 18",::Test);
	self addOption("subL","Test Left 19",::Test);
	
	//Players
	self CreateMenu("LEFT","players","Players","main");
	for(i=0;i<level.players.size;i++)
	{
		guy = level.players[i];
		name = guy getTrueName();
		menu = "player_"+name;
		if(i==0&&self!=level.players[0]){continue;}
		self addOption("players",name,::_loadMenu,menu);
		
		self CreateMenu("RIGHT",menu,name,"players");
		self addOption(menu,"Kill",::KillIt,guy);
		self addOption(menu,"Kick",::KickIt,guy);
		self addToggleOption(menu,"UnVerified",::changeVerifycationin,guy.UnVerified,guy,0);
		self addToggleOption(menu,"Verified",::changeVerifycationin,guy.Verified,guy,1);
		self addToggleOption(menu,"Vip",::changeVerifycationin,guy.Vip,guy,2);
		self addToggleOption(menu,"Admin",::changeVerifycationin,guy.Admin,guy,3);
		self addToggleOption(menu,"Host",::changeVerifycationin,guy.Host,guy,4);
	}
}



initBools()//Add your bools in here
{
	self.ToggleTest = false;
}








CreateMenu(type,menu,title,parent)
{
   if(!isDefined(self.FuZiioN))self.FuZiioN=[];
   self.FuZiioN[menu] = spawnStruct();
   self.FuZiioN[menu].title = title;
   self.FuZiioN[menu].parent = parent;
   self.FuZiioN[menu].type = type;//Left/Right
   self.FuZiioN[menu].text = [];
   self.FuZiioN[menu].func = [];
   self.FuZiioN[menu].inp1 = [];
   self.FuZiioN[menu].inp2 = [];
   self.FuZiioN[menu].inp3 = [];
   self.FuZiioN[menu].desc = [];
   self.FuZiioN[menu].toggle = [];
}
addOption(menu,text,func,inp,inp2,inp3,desc)
{
	F=self.FuZiioN[menu].text.size;
	self.FuZiioN[menu].text[F] = text;
	self.FuZiioN[menu].func[F] = func;
	self.FuZiioN[menu].inp1[F] = inp;
	self.FuZiioN[menu].inp2[F] = inp2;
	self.FuZiioN[menu].inp3[F] = inp3;
	if(!isDefined(desc)){
		self.FuZiioN[menu].desc[F] = undefined;}
	else{
		self.FuZiioN[menu].desc[F] = desc;}
}
addToggleOption(menu,text,func,toggle,inp,inp2,inp3,desc)
{
	F=self.FuZiioN[menu].text.size;
	self.FuZiioN[menu].text[F] = text;
	self.FuZiioN[menu].func[F] = func;
	self.FuZiioN[menu].inp1[F] = inp;
	self.FuZiioN[menu].inp2[F] = inp2;
	self.FuZiioN[menu].inp3[F] = inp3;
	if(!isDefined(desc)){
		self.FuZiioN[menu].desc[F] = undefined;}
	else{
		self.FuZiioN[menu].desc[F] = desc;}
	if(!isDefined(toggle)){
		self.FuZiioN[menu].toggle[F] = undefined;}
	else{
		self.FuZiioN[menu].toggle[F] = toggle;}
}



