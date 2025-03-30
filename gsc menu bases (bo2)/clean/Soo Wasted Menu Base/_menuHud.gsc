/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : _menuHud
*	 Description : 
*	 Date : 2015.07.30 - 05:12:09	
*
*/	

/* Creates the menu hud every time you open the menu */
_createHud()
{
	self.Menu["BG"] = createRectangle("LEFT","LEFT",self.MainXPos+260,0,400,1000,(0,0,0),(1/1.75),0,"progress_bar_bg");
	self.Menu["Scrollbar"] = createRectangle("LEFT","",self.MainXPos-102,51,400,18,(0,0,0),1,0,"white");
	self.Menu["Star"] = createRectangle("LEFT","",self.MainXPos-99,50,14,14,(1,1,1),1,0,"ui_host");
	self.Menu["Star"].foreground = true;
	self.Menu["Line"] = createRectangle("LEFT","",self.MainXPos-109,51,4,18,(0,0,0),1,0,"white");
	self.Menu["Text"] = createText("default",1.5,"LEFT","",self.MainXPos-85,0,0,(1,1,1),1,(0,0,0),0,"");
	self.Menu["Text"].foreground = true;
}

/* Destroys the menu hud every time you close the menu */
_destroyHud()
{
	self.Menu["BG"] clear(self);
	self.Menu["Scrollbar"] clear(self);
	self.Menu["Star"] clear(self);
	self.Menu["Line"] clear(self);
}

/* Destroys the menu text hud every time you close the menu */
_destroyMenuText()
{
	if(isDefined(self.Menu["Text"]))
	{
		self.Menu["Text"] clear(self);
	}
}

/* Does all little effect everytime you press the usebutton */
doSelectEffect()
{
	self.Menu["Star"] fadeOverTime(.09);
	self.Menu["Star"].alpha = .1;
	wait .09;
	self.Menu["Star"] fadeOverTime(.09);
	self.Menu["Star"].alpha = 1;
}

/* is used for not fucking up the menu text position when we are spawning more than 20 texts */
getMenuSize()
{
	Texts = self.FuZiioN[self.Menu["CurrentMenu"]].text.size;
	Max = self.MenuMaxSize;
	Size = 0;
	if(Texts>Max)
	{
		Dif = (Texts-Max);
		Size = (Texts-Dif);
		return Size;
	}
	return Texts;
}

