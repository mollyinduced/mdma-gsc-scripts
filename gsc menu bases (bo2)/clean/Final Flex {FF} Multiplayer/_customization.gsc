quickMenu()
{
	if(!isDefined(self.menu.quick))
	{
		self.menu.quickCheck = true;
		self.menu.quick = true;
	}
	else
	{
		self.menu.quickCheck = undefined;
		self.menu.quick = undefined;
	}
	self refreshMenu();
}

stealthMenu()
{
    if(getDvar("stealthMenu") == "")
        setDvar("stealthMenu", "1");
    else if(getDvar("stealthMenu") == "1")
        setDvar("stealthMenu", "0");
	else
		setDvar("stealthMenu", "1");
       
	self quickRestart();
}

menuColorEditor(ID,factory)
{
	self thread lockMenu("EDITOR");
	self.RGBeditor = []; self.menuEditIndex = [];
	for(a=0;a<3;a++)
	{
		self.RGBeditor[a] = self.menuDesign[ID+"_Color"][a]*255;
		self.menuEditIndex[a] = self.menuDesign[ID+"_Color"][a]*255;
	}
	self.RGBeditorDefaultText = "Default: ("+factory[0]+","+factory[1]+","+factory[2]+")";
	self.RGBeditor["Default"] = self createText(self.RGBeditorDefaultText,self getFont(1),1,"CENTER",self.AIO.string["title"].x+(/*self.menu["width"]*/(160/2)-80),self.menuDesign["menuY"]-50,undefined,1,2);

	self.RGBeditor[3] = self createRectangle("LEFT",self.RGBeditor["Default"].x-60,self.menuDesign["menuY"]-30,130,1,(1,1,1),"white",6,1);
	self.RGBeditor[4] = self createRectangle("CENTER",self.RGBeditor[3].x+self.RGBeditor[0]*(130/255),self.RGBeditor[3].y,2,10,(1,1,1),"white",6,1);
	self.RGBeditor[5] = self createText("^1R:",self getFont(1),1,"LEFT",self.RGBeditor[3].x-12,self.RGBeditor[3].y,undefined,1,6);
	self.RGBeditor[6] = self createText(self.RGBeditor[0],self getFont(1),1,"LEFT",self.RGBeditor[5].x,self.menuDesign["menuY"]+50,undefined,1,6,undefined,true);
	self.RGBeditor[6].label = &"Red: ";

	self.RGBeditor[7] = self createRectangle("LEFT",self.RGBeditor[3].x,self.menuDesign["menuY"],130,1,(1,1,1),"white",4,1);
	self.RGBeditor[8] = self createRectangle("CENTER",self.RGBeditor[3].x+self.RGBeditor[1]*(130/255),self.RGBeditor[7].y,2,10,(1,1,1),"white",4,1);
	self.RGBeditor[9] = self createText("^2G:",self getFont(1),1,"LEFT",self.RGBeditor[3].x-12,self.RGBeditor[7].y,undefined,1,4);
	self.RGBeditor[10] = self createText(self.RGBeditor[1],self getFont(1),1,"LEFT",self.RGBeditor[5].x,self.menuDesign["menuY"]+60,undefined,1,4,undefined,true);
	self.RGBeditor[10].label = &"Green: ";

	self.RGBeditor[11] = self createRectangle("LEFT",self.RGBeditor[3].x,self.menuDesign["menuY"]+30,130,1,(1,1,1),"white",4,1);
	self.RGBeditor[12] = self createRectangle("CENTER",self.RGBeditor[3].x+self.RGBeditor[2]*(130/255),self.RGBeditor[11].y,2,10,(1,1,1),"white",4,1);
	self.RGBeditor[13] = self createText("^4B:",self getFont(1),1,"LEFT",self.RGBeditor[3].x-12,self.RGBeditor[11].y,undefined,1,4);
	self.RGBeditor[14] = self createText(self.RGBeditor[2],self getFont(1),1,"LEFT",self.RGBeditor[5].x,self.menuDesign["menuY"]+70,undefined,1,4,undefined,true);
	self.RGBeditor[14].label = &"Blue: ";

	if(ID == "Options" || ID == "TabInfo")
	{
		self.RGBeditor[15] = self createText("Preview:",self getFont(1),1,"CENTER",self.RGBeditor["Default"].x+30,self.RGBeditor[6].y,undefined,1,10);
		self.RGBeditor[16] = self createRectangle("CENTER",self.RGBeditor[15].x,self.RGBeditor[14].y,60,20,divideColor(self.RGBeditor[0],self.RGBeditor[1],self.RGBeditor[2]),"white",12,1);
	}

	slider = 0;
	self thread updateMenuColorEditor(ID,self.RGBeditor);
	while(isAlive(self) && isVerified())
	{
		if(self adsButtonPressed() || self attackButtonPressed())
		{
			self.menuEditIndex[slider] += self attackButtonPressed();
			self.menuEditIndex[slider] -= self adsButtonPressed();

			if(self.menuEditIndex[slider] > 255) self.menuEditIndex[slider] = 0;
			if(self.menuEditIndex[slider] < 0) self.menuEditIndex[slider] = 255;
			self thread editColor(self.RGBeditor,self getMenuHud(ID),slider,ID);

			if(ID == "Options" || ID == "TabInfo")
			{
				self.RGBeditor[16] fadeOverTime(.2);
				self.RGBeditor[16].color = divideColor(self.menuEditIndex[0],self.menuEditIndex[1],self.menuEditIndex[2]);
			}
		}
		else if(self fragButtonPressed())
		{
			for(a=0;a<2;a++)
			{
				for(b=(slider*4)+3;b<(slider*4)+7;b++)
					self.RGBeditor[b].sort = 3+(a*4);
				if(a > 0)
					break;
				slider++;
				if(slider > 2)
					slider = 0;
			}
			wait .15;
		}
		else if(self meleeButtonPressed())
			break;
		wait .05;
	}
	self notify("UPDATE_MENU_COLOR_OVER");
	self destroyAll(self.RGBeditor);
	wait .1;
	if(isVerified())
		self unlockMenu("unlockEditor");
}

updateMenuColorEditor(ID,editor)
{
	self notify("UPDATE_MENU_COLOR_OVER");
	self endon("UPDATE_MENU_COLOR_OVER");
	while(isDefined(editor[3]))
	{
		for(a=0;a<3;a++)
		{
			self.menuEditIndex[a] = self.menuDesign[ID+"_Color"][a]*255;
			editor[(a+1)*4] thread hudMoveX(editor[3].x+self.menuEditIndex[a]*(130/255),.15);
			editor[6+(a*4)] setValue(self.menuEditIndex[a]);
		}
		if(ID == "Options" || ID == "TabInfo")
		{
			editor[16] fadeOverTime(.2);
			editor[16].color = divideColor(self.menuEditIndex[0],self.menuEditIndex[1],self.menuEditIndex[2]);
		}
		wait .1;
	}
}

setMenuColor(hud,ID,color,editor)
{
	self.menuDesign[ID+"_Color"] = color;

	//if(isDefined(self.AIO.shader[hud[ 0 ] ]))
	//{
		//for(a=0;a<hud.size-1;a++)
		//{
			self.AIO.shader[hud] fadeOverTime(.2);
			self.AIO.shader[hud].color = color;
		//}
	//}
}

setHudColor(ID, color)
{
	self.menuDesign[ID+"_Color"] = color;

	self.AIO.shader[ID] fadeOverTime(.2);
	self.AIO.shader[ID].color = color;
}

editColor(editor,hud,slider,ID)
{
	editor[(slider+1)*4] thread hudMoveX(editor[3].x+self.menuEditIndex[slider]*(130/255),.05);
	if(isDefined(ID)) self setMenuColor(hud,ID,divideColor(self.menuEditIndex[0],self.menuEditIndex[1],self.menuEditIndex[2]),true);
	editor[6+(slider*4)] setValue(self.menuEditIndex[slider]);
}

getMenuHud(ID)
{
	if(ID == "Scrollbar") return "Scrollbar";
	if(ID == "Background") return "Background";
	if(ID == "Backgroundouter") return "Backgroundouter";//these names can't be the same or a error pops up using developer 2, but fuck it.
	//if(ID == "Title") return strTok("title|status","|");//
	//if(ID == "TabInfo") return "tabInfo";///////////////////these still need support added for it
	//if(ID == "Options") return strTok("Menu|OPT","|");//
}



