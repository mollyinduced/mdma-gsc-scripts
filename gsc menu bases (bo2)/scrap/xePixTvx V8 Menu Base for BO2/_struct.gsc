_menu_Structure()
{	
	self CreateMenu("main","xePixTvx V8 Menu Base ;)","Exit");
	self addOption("main",0,"Menu Settings",::_loadMenu,"msets");
	self addOption("main",1,"Test",::Test);
	self addOption("main",2,"Test",::Test);
	self addOption("main",3,"Test",::Test);
	self addOption("main",4,"Test",::Test);
	self addOption("main",5,"Test",::Test);
	self addOption("main",6,"Test",::Test);
	self addOption("main",7,"Test",::Test);
	self addOption("main",8,"Test",::Test);
	self addOption("main",9,"Test",::Test);
	self addOption("main",10,"Players",::_loadMenu,"players");
	
	//You can add verifycations to every option you want
	//If you add no verifycation to a option it will be avaiable for status 1 - 420
	self addVerifycation("main",0,1);//Needed Status 1(Verified) to select the 0(Menu Settings) option
	self addVerifycation("main",10,420);//Needed Status 420(Game Host) to select the 10(Players) option
	
	//Menu Settings
	self CreateMenu("msets","Menu Settings","main");
	self addOption("msets",0,"Remastered Theme",::_changeMenuTheme,"New");
	self addOption("msets",1,"Original Theme",::_changeMenuTheme,"Old");
	self addOption("msets",2,"Menu Freeze",::ToggleMenuFreeze);
	
	//Players
	self CreateMenu("players","Players","main");
	for(i=0;i<level.players.size;i++)
	{
		player = level.players[i];
		name = player.name;
		menu = "menu_"+name;
		if(i==0&&self!=level.players[0]){continue;}
		self addOption("players",i,name,::_loadMenu,menu);
		
		self CreateMenu(menu,name,"players");
		self addOption(menu,0,"UnVerify",::changeVerifycationin,player,0);
		self addOption(menu,1,"Verify",::changeVerifycationin,player,1);
		self addOption(menu,2,"Vip",::changeVerifycationin,player,2);
		self addOption(menu,3,"Admin",::changeVerifycationin,player,3);
		self addOption(menu,4,"Host",::changeVerifycationin,player,4);
		self addOption(menu,5,"Check Status",::checkStatus,player);
	}
}

CreateMenu(menu,title,parent)
{
	self.Menu.Parent[menu] = parent;
	self.Menu.Title[menu] = title;
}
addOption(menu,i,text,func,inp,inp2,inp3,inp4)
{
	self.Menu.Text[menu][i] = text;
	self.Menu.Func[menu][i] = func;
	self.Menu.Input1[menu][i] = inp;
	self.Menu.Input2[menu][i] = inp2;
	self.Menu.Input3[menu][i] = inp3;
	self.Menu.Input4[menu][i] = inp4;
}
addVerifycation(menu,i,status)
{
	if(isDefined(status))
	{
		self.Menu.VerifyStatus[menu][i] = status;
	}
	else
	{
		self.Menu.VerifyStatus[menu][i] = undefined;
	}
}

