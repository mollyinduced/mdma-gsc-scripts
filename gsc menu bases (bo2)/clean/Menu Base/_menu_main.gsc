/*
	_setUpMenu() = default Settings
	_menuOpener() + _menuMain() = Button Monitoring
	_openMenu(client) = Open Menu
	_closeMenu(client) = Close Menu
	_loadMenu(menu) = Load Menu
	_cursorWatcher() = Scrolling/Description/Toggle
	That are the main functions of this file(_menu_main.gsc)
*/
_setUpMenu()
{
	self.Space = 17.5;
	self.MenuMaxSize = 13;
	self.MenuMaxSizeHalf = 6;
	self.MenuMaxSizeHalfOne = 7;
}
init_menu()
{
	self.FuZiioN = [];
	self.FuZiioN["Menu"]["Open"] = false;
	self.FuZiioN["Menu"]["Locked"] = false;
	self thread _menuOpener();
}
_menuOpener()
{
	self endon("disconnect");
	self endon("death");
	for(;;)
	{
		if(!self.FuZiioN["Menu"]["Open"] && !self.FuZiioN["Menu"]["Locked"])
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
_menuMain()
{
	self endon("disconnect");
	self endon("death");
	self endon("Menu_Is_Closed");
	
	self waittill("Menu_Is_Opened");
	_openMenu(self);
	while(self.FuZiioN["Menu"]["Open"])
	{
		if(self AdsButtonPressed())
		{
			self.Scroller[self.FuZiioN["CurrentMenu"]] --;
			self _cursorWatcher();
			wait .1;
		}
		if(self AttackButtonPressed())
		{
			self.Scroller[self.FuZiioN["CurrentMenu"]] ++;
			self _cursorWatcher();
			wait .1;
		}
		if(self UseButtonPressed())
		{
			input1 = self.FuZiioN[self.FuZiioN["CurrentMenu"]].inp1[self.Scroller[self.FuZiioN["CurrentMenu"]]];
			input2 = self.FuZiioN[self.FuZiioN["CurrentMenu"]].inp2[self.Scroller[self.FuZiioN["CurrentMenu"]]];
			input3 = self.FuZiioN[self.FuZiioN["CurrentMenu"]].inp3[self.Scroller[self.FuZiioN["CurrentMenu"]]];
			self thread [[self.FuZiioN[self.FuZiioN["CurrentMenu"]].func[self.Scroller[self.FuZiioN["CurrentMenu"]]]]](input1,input2,input3);
			self _doSelectUpdate();
			wait .2;
		}
		if(self MeleeButtonPressed())
		{
			if(self.FuZiioN[self.FuZiioN["CurrentMenu"]].parent=="Exit")
			{
				_closeMenu(self);
			}
			else
			{
				self _loadMenu(self.FuZiioN[self.FuZiioN["CurrentMenu"]].parent);
			}
			wait .2;
		}
		wait 0.05;
	}
	wait 0.05;
}
_loadMenu(menu)
{
	self _destroyMenuText();
	if(self isMenuLeft() && self.FuZiioN[menu].type!="LEFT"||self.FuZiioN[menu].type!="LEFT"){
		self.FuZiioN["Arrow"].alpha = 0;
		self.FuZiioN["Arrow"] setShader("ui_scrollbar_arrow_right",10,10);
		wait .2;
		self.FuZiioN["Arrow"].alpha = 1;
		self.FuZiioN["Arrow"] elemMoveOverTimeY(.4,185);}
	if(!self isMenuLeft() && self.FuZiioN[menu].type=="LEFT"||self.FuZiioN[menu].type=="LEFT"){
		self.FuZiioN["Arrow"].alpha = 0;
		self.FuZiioN["Arrow"] setShader("ui_scrollbar_arrow_left",10,10);
		wait .2;
		self.FuZiioN["Arrow"].alpha = 1;}
	self.FuZiioN["CurrentMenu"] = menu;
	self thread _menuList();
	if(!isDefined(self.Scroller[self.FuZiioN["CurrentMenu"]])){
		self.Scroller[self.FuZiioN["CurrentMenu"]] = 0;}
	self.FuZiioN["Title"] setText(self.FuZiioN[self.FuZiioN["CurrentMenu"]].title);
	self _doMenuText();
	self _doSelectUpdate();
}
_openMenu(client)
{
	client.FuZiioN["Menu"]["Open"] = true;
	client freezeControls(true);
	if(!isDefined(client.FuZiioN["CurrentMenu"])){
		client.FuZiioN["CurrentMenu"] = "main";}
	client setclientuivisibilityflag("hud_visible",0);
	client SetBlur(4,.2);
	client _createHud();
	client _loadMenu(client.FuZiioN["CurrentMenu"]);
}
_closeMenu(client)
{
	client.FuZiioN["Menu"]["Open"] = false;
	client freezeControls(false);
	client _destroyMenuText();
	client _destroyHud();
	client setclientuivisibilityflag("hud_visible",1);
	client SetBlur(0,.2);
	client notify("Menu_Is_Closed");
}
_doSelectUpdate()
{
	self thread _menuList();
	self _cursorWatcher();
}
_cursorWatcher()
{
	if(self isMenuLeft()){
		if(self.Scroller[self.FuZiioN["CurrentMenu"]]<0){
			self.Scroller[self.FuZiioN["CurrentMenu"]] = self.FuZiioN[self.FuZiioN["CurrentMenu"]].text.size-1;}
		if(self.Scroller[self.FuZiioN["CurrentMenu"]]>self.FuZiioN[self.FuZiioN["CurrentMenu"]].text.size-1){
			self.Scroller[self.FuZiioN["CurrentMenu"]] = 0;}
		if(!isDefined(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[self.Scroller[self.FuZiioN["CurrentMenu"]]-self.MenuMaxSizeHalf])||self.FuZiioN[self.FuZiioN["CurrentMenu"]].text.size<=self.MenuMaxSize){
			for(i=0;i<self.MenuMaxSize;i++){
				if(isDefined(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[i])){
					self.FuZiioN["Text"][i] setText(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[i]);}
				else{
					self.FuZiioN["Text"][i] setText("");}}
			self.FuZiioN["Arrow"] elemMoveOverTimeY(.1,80+(self.Space*self.Scroller[self.FuZiioN["CurrentMenu"]]));}
		else{
			if(isDefined(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[self.Scroller[self.FuZiioN["CurrentMenu"]]+self.MenuMaxSizeHalf])){
				xePixTvx = 0;
				for(i=self.Scroller[self.FuZiioN["CurrentMenu"]]-self.MenuMaxSizeHalf;i<self.Scroller[self.FuZiioN["CurrentMenu"]]+self.MenuMaxSizeHalfOne;i++){
					if(isDefined(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[i])){
						self.FuZiioN["Text"][xePixTvx] setText(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[i]);}
					else{
						self.FuZiioN["Text"][xePixTvx] setText("");}
					xePixTvx ++;}           
				self.FuZiioN["Arrow"] elemMoveOverTimeY(.1,80+(self.Space*self.MenuMaxSizeHalf));}
			else{
				for(i=0;i<self.MenuMaxSize;i++){
					self.FuZiioN["Text"][i] setText(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[self.FuZiioN[self.FuZiioN["CurrentMenu"]].text.size+(i-self.MenuMaxSize)]);}
				self.FuZiioN["Arrow"] elemMoveOverTimeY(.1,80+(self.Space*((self.Scroller[self.FuZiioN["CurrentMenu"]]-self.FuZiioN[self.FuZiioN["CurrentMenu"]].text.size)+self.MenuMaxSize)));}}
	}
	else{
		if(self.Scroller[self.FuZiioN["CurrentMenu"]]<0){
			self.Scroller[self.FuZiioN["CurrentMenu"]] = self.FuZiioN[self.FuZiioN["CurrentMenu"]].text.size-1;}
		if(self.Scroller[self.FuZiioN["CurrentMenu"]]>self.FuZiioN[self.FuZiioN["CurrentMenu"]].text.size-1){
			self.Scroller[self.FuZiioN["CurrentMenu"]] = 0;}
		if(isDefined(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[self.Scroller[self.FuZiioN["CurrentMenu"]]])){
			xePixTvx = 0;
			for(i=self.Scroller[self.FuZiioN["CurrentMenu"]]-6;i<self.Scroller[self.FuZiioN["CurrentMenu"]]+7;i++){
				if(isDefined(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[i])){
					self.FuZiioN["Text"][xePixTvx] setText(self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[i]);}
				else{
					self.FuZiioN["Text"][xePixTvx] setText("");}
				xePixTvx ++;}}}
	if(isDefined(self.FuZiioN[self.FuZiioN["CurrentMenu"]].desc[self.Scroller[self.FuZiioN["CurrentMenu"]]])){
		self.FuZiioN["Desc"] setText(self.FuZiioN[self.FuZiioN["CurrentMenu"]].desc[self.Scroller[self.FuZiioN["CurrentMenu"]]]);
		self.FuZiioN["Desc"] elemFadeOverTime(.2,1);}
	else{
		self.FuZiioN["Desc"] elemFadeOverTime(.2,0);
		self.FuZiioN["Desc"] setText("");}
	if(isDefined(self.FuZiioN[self.FuZiioN["CurrentMenu"]].toggle[self.Scroller[self.FuZiioN["CurrentMenu"]]])){
		if(self.FuZiioN[self.FuZiioN["CurrentMenu"]].toggle[self.Scroller[self.FuZiioN["CurrentMenu"]]]==true){
			self.FuZiioN["Arrow"].color = (0,1,0);}
		else{
			self.FuZiioN["Arrow"].color = (1,0,0);}}
	else{
		self.FuZiioN["Arrow"].color = (0,1,1);}
	level.result += 1;
	level notify("textset");
}



