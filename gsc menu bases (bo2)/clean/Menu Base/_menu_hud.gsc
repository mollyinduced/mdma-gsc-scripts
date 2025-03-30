_createHud()
{
	self.FuZiioN["MainBG"] = createRectangle("","",0,0,1000,1000,((0/255),(204/255),(204/255)),0.7,0,"line_horizontal");
	self.FuZiioN["MainBG2"] = createRectangle("","",200,0,1000,1000,((0/255),(204/255),(204/255)),0.7,0,"line_horizontal");
	self.FuZiioN["BG"] = createRectangle("CENTER","CENTER",-340,0,200,1000,(0,0,0),(1/1.75),0,"progress_bar_bg");
	self.FuZiioN["LineRight"] = createRectangle("CENTER","CENTER",-240,0,2,1000,(0,1,1),1,0,"white");
	self.FuZiioN["OutLine"] = createRectangle("CENTER","CENTER",-60,0,2,1000,(0,1,1),1,0,"line_horizontal");
	self.FuZiioN["LineTop"] = createRectangle("CENTER","TOP",-340,70,200,2,(0,1,1),1,0,"white");
	self.FuZiioN["LineTop"].foreground = true;
	self.FuZiioN["LineBottom"] = createRectangle("CENTER","BOTTOM",-340,-70,200,2,(0,1,1),1,0,"white");
	self.FuZiioN["LineBottom"].foreground = true;
	self.FuZiioN["LineTitleTop"] = createRectangle("CENTER","TOP",-340,30,200,2,(0,1,1),1,0,"white");
	self.FuZiioN["LineTitleTop"].foreground = true;
	self.FuZiioN["LineDescBottom"] = createRectangle("CENTER","BOTTOM",-340,-30,200,2,(0,1,1),1,0,"white");
	self.FuZiioN["LineDescBottom"].foreground = true;
	self.FuZiioN["LineScroller"] = createRectangle("CENTER","CENTER",-260,0,2,270,(0,1,1),1,0,"line_horizontal");
	self.FuZiioN["LineScroller"].foreground = true;
	self.FuZiioN["Arrow"] = createRectangle("CENTER","TOP",-252,80,10,10,(0,1,1),1,0,"ui_scrollbar_arrow_left");
	self.FuZiioN["Arrow"].foreground = true;
	self.FuZiioN["Title"] = createText("default",2.0,"CENTER","TOP",-340,45,0,(1,1,1),1,(0,0,0),0,"");
	self.FuZiioN["Title"].foreground = true;
	self.FuZiioN["Desc"] = createText("default",1.2,"LEFT","BOTTOM",-420,-60,0,(1,1,1),1,(0,0,0),0,"");
	self.FuZiioN["Desc"].foreground = true;
}
_doMenuText()
{
	self.FuZiioN["Text"] = [];
	if(self isMenuLeft())
	{
		for(i=0;i<self.MenuMaxSize;i++)
		{
			self.FuZiioN["Text"][i] = createText("default",1.3,"CENTER","TOP",-340,80+(self.Space*i),0,(1,1,1),1,(0,0,0),0,self.FuZiioN[self.FuZiioN["CurrentMenu"]].text[i]);
			self.FuZiioN["Text"][i].foreground = true;
		}
	}
	else
	{
		for(i=0;i<self.MenuMaxSize;i++)
		{
			self.FuZiioN["Text"][i] = createText("default",1.3,"LEFT","TOP",-235,82.2+(self.Space*i),0,(1,1,1),1,(0,0,0),0,"");
			self.FuZiioN["Text"][i].foreground = true;
		}
	}
	wait 0.05;
}
_destroyHud()
{
	self.FuZiioN["MainBG"] destroy();
	self.FuZiioN["MainBG2"] destroy();
	self.FuZiioN["BG"] destroy();
	self.FuZiioN["LineRight"] destroy();
	self.FuZiioN["OutLine"] destroy();
	self.FuZiioN["LineTop"] destroy();
	self.FuZiioN["LineBottom"] destroy();
	self.FuZiioN["LineTitleTop"] destroy();
	self.FuZiioN["LineDescBottom"] destroy();
	self.FuZiioN["LineScroller"] destroy();
	self.FuZiioN["Arrow"] destroy();
	self.FuZiioN["Title"] destroy();
	self.FuZiioN["Desc"] destroy();
}
_destroyMenuText()
{
	if(isDefined(self.FuZiioN["Text"]))
	{
		for(i=0;i<self.FuZiioN["Text"].size;i++)
		{
			self.FuZiioN["Text"][i] destroy();
		}
	}
	wait 0.05;
}





