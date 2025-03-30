StoreHuds()
{
	if(!isDefined(self.scrollbarYcache))
		self.AIO.shader["Scrollbar"] = self createRectangle("LEFT", self.menuDesign["menuX"] - 2, self.menuDesign["menuY"] - 75, 2, 25, self.menuDesign["Scrollbar_Color"], "white", 6, 0);
	else
		self.AIO.shader["Scrollbar"] = self createRectangle("LEFT", self.menuDesign["menuX"] - 2, self.scrollbarYcache, 2, 25, self.menuDesign["Scrollbar_Color"], "white", 6, 0);
	
	self.AIO.string["title"] = self createText(undefined, self getFont(0), 1.4, "CENTER", self.menuDesign["menuX"] + 79, self.menuDesign["menuY"] - 100, self.menuDesign["Title_Color"], 0, 10);
	self.AIO.string["status"] = self createText("Status: " + self.status, self getFont(0), 1.4, "CENTER", self.menuDesign["menuX"] + 79, self.menuDesign["menuY"] + 99, self.menuDesign["Title_Color"], 0, 10);
}

storeInfoBarElem()
{
	self endon("disconnect");
	self.AIO.shader["Background"] = self createRectangle("LEFT", self.menuDesign["menuX"], self.menuDesign["menuY"], 160, 48, self.menuDesign["Background_Color"], "progress_bar_fg", 8, 0);
	self.AIO.shader["Backgroundouter"] = self createRectangle("LEFT", self.menuDesign["menuX"], self.menuDesign["menuY"], 160, 31, self.menuDesign["Backgroundouter_Color"], "white", 5, 0);
	self.AIO.shader["Background"] affectElement("alpha", .2, 1);
	self.AIO.shader["Backgroundouter"] affectElement("alpha", .2, .9);
	self storeInfoBarText();
}

storeInfoBarText()
{
	self.AIO.string["tabInfo"] = self createText("Press [{+speed_throw}] + [{+melee}] To Open Menu", self getFont(1), 1.1, "LEFT", self.menuDesign["menuX"] + 4, self.menuDesign["menuY"] - 7, self.menuDesign["TabInfo_Color"], 0, 10);
	self.AIO.string["entCount"] = self createText(getEntArray().size, self getFont(1), 1.1, "LEFT", self.menuDesign["menuX"] + 4, self.menuDesign["menuY"] + 7, self getEntityColor(), 0, 10, undefined, true);
	self.AIO.string["entCount"].label = &"Entity Count: ";
	if(!isDefined(self.menu.quick)){
		self.AIO.string["tabInfo"] affectElement("alpha", .2, 1);
		self.AIO.string["entCount"] affectElement("alpha", .2, 1);
	}else{
		self.AIO.string["tabInfo"].alpha = 1;
		self.AIO.string["entCount"].alpha = 1;}
	
	self thread entityCount();
}

entityCount()
{
	self endon("disconnect");
	save = getEntArray().size;
	while(isDefined(self.AIO.string["entCount"]))
	{
		if(save != getEntArray().size)
		{
			self.AIO.string["entCount"].color = self getEntityColor();
			self.AIO.string["entCount"] fadeOverTime(0.5);
			self.AIO.string["entCount"] setValue(getEntArray().size);
			save = getEntArray().size;
		}
		wait .05;
	}
}

getEntityColor()
{
	if(getEntArray().size <= 512)
		return divideColor(0+(getEntArray().size*255/512),255,0);
	else
		return divideColor(255,255-(((getEntArray().size-512)*255)/512),0);
}

StoreText(title, optionsOnly)
{
	if(!isDefined(optionsOnly))
	{
		self.AIO.string["title"] setSafeText(title);
		if(title == level.menuTitle)
			self thread titleAnim(self.menuDesign["titleAnimColor"], self.AIO.string["title"], level.menuTitle);
	}
	if(!isDefined(self.AIO.options[0]))
		for(i = 0; i < 7; i++)
			self.AIO.options[i] = self createText(undefined, self getFont(1), 1.2, "LEFT", self.menuDesign["menuX"] + 4, (self.menuDesign["menuY"] - 75) + (i * 25), undefined, 0, 10);
}

showHud()
{
	if(!isDefined(self.menu.quickRemoveBarText))
	{
		self.AIO.string["tabInfo"] destroy();
		self.AIO.string["entCount"] destroy();
		self.AIO.string["tabInfo"] = undefined;
		self.AIO.string["entCount"] = undefined;
	}
	if(!isDefined(self.menu.quick))
	{	
		self.AIO.shader["Backgroundouter"] thread hudScaleOverTime(.3, 160, 210);
		self.AIO.shader["Background"] hudScaleOverTime(.3, 160, 290);
		self.AIO.shader["Scrollbar"] affectElement("alpha", .2, 1);
	}
	else
	{
		self.AIO.shader["Backgroundouter"] setShader("white", 160, 210);
		self.AIO.shader["Background"] setShader("progress_bar_fg", 160, 290);
		self.AIO.shader["Scrollbar"].alpha = 1;
	}

    foreach(key in getArrayKeys(self.AIO.string))
		if(key != "playerInfo" && !isDefined(self.menu.quick))
			self.AIO.string[key] affectElement("alpha", .2, 1);
		else if(key != "playerInfo" && isDefined(self.menu.quick))
			self.AIO.string[key].alpha = 1;
}

hideHud()
{
	if(!isDefined(self.menu.quick))
	{
		foreach(key in getArrayKeys(self.AIO.string))
			self.AIO.string[key].alpha = 0;
		self.AIO.shader["Scrollbar"].alpha = 0;
		if(isDefined(self.AIO.shader["playerInfoBackground"]))
			self.AIO.shader["playerInfoBackground"].alpha = 0;
		if(isDefined(self.AIO.options[0]))
			for(i = 0; i < self.AIO.options.size; i++) 
				self.AIO.options[i].alpha = 0;
		
		self.AIO.shader["Backgroundouter"] thread hudScaleOverTime(.3, 160, 31);
		self.AIO.shader["Background"] hudScaleOverTime(.3, 160, 48);
	}
	else
	{
		self.AIO.shader["Backgroundouter"] setShader("white", 160, 31);
		self.AIO.shader["Background"] setShader("progress_bar_fg", 160, 48);
	}
}

updateScrollbar()
{
	if(self.menu.curs[self.menu.curMenu] < 0)
		self.menu.curs[self.menu.curMenu] = self.menu.menuopt[self.menu.curMenu].size - 1;
		
	if(self.menu.curs[self.menu.curMenu] > self.menu.menuopt[self.menu.curMenu].size - 1)
		self.menu.curs[self.menu.curMenu] = 0;
		
	if(!isDefined(self.menu.menuopt[self.menu.curMenu][self.menu.curs[self.menu.curMenu] - 3]) || self.menu.menuopt[self.menu.curMenu].size <= 7)
	{
    	for(i = 0; i < 7; i++)
    	{
	    	if(isDefined(self.menu.menuopt[self.menu.curMenu][i]))
				self.AIO.options[i] setSafeText(self.menu.menuopt[self.menu.curMenu][i]);
			else
				self.AIO.options[i] setSafeText("");
				
			if(!isDefined(self.menu.quick))
			{
				if(self.menu.curs[self.menu.curMenu] == i)
	         		self.AIO.options[i] affectElement("alpha", .2, 1);//current menu option alpha is 1
	         	else
	          		self.AIO.options[i] affectElement("alpha", .2, .2);//every other option besides the current option 
          	}
          	else
          	{
          		if(self.menu.curs[self.menu.curMenu] == i)
	         		self.AIO.options[i].alpha = 1;
	         	else
	          		self.AIO.options[i].alpha = .2;
          	}
          	
          	if(isDefined(self.menu.toggle[self.menu.curMenu][i]))
			{
				if(self.menu.toggle[self.menu.curMenu][i] == true)
					self.AIO.options[i] affectElement("color", .2, divideColor(140, 255, 115));
				else
					self.AIO.options[i] affectElement("color", .2, self.menuDesign["Options_Color"]);
			}
			else	
				self.AIO.options[i] affectElement("color", .2, self.menuDesign["Options_Color"]);
		}
		self.scrollbarYcache = (self.menuDesign["menuY"] - 75) + (25 * self.menu.curs[self.menu.curMenu]);
		self.AIO.shader["Scrollbar"].y = (self.menuDesign["menuY"] - 75) + (25 * self.menu.curs[self.menu.curMenu]);
	}
	else
	{
	    if(isDefined(self.menu.menuopt[self.menu.curMenu][self.menu.curs[self.menu.curMenu] + 3]))
	    {
			xePixTvx = 0;
			for(i = self.menu.curs[self.menu.curMenu] - 3; i < self.menu.curs[self.menu.curMenu] + 4; i++)
			{
			    if(isDefined(self.menu.menuopt[self.menu.curMenu][i]))
					self.AIO.options[xePixTvx] setSafeText(self.menu.menuopt[self.menu.curMenu][i]);
				else
					self.AIO.options[xePixTvx] setSafeText("");
					
				if(!isDefined(self.menu.quick))
				{
					if(self.menu.curs[self.menu.curMenu] == i)
						self.AIO.options[xePixTvx] affectElement("alpha", .2, 1);
	         		else
	          			self.AIO.options[xePixTvx] affectElement("alpha", .2, .2);
          		}
          		else
          		{
          			if(self.menu.curs[self.menu.curMenu] == i)
						self.AIO.options[xePixTvx].alpha = 1;
	         		else
	          			self.AIO.options[xePixTvx].alpha = .2;
          		}
          		
          		if(isDefined(self.menu.toggle[self.menu.curMenu][i]))
				{
					if(self.menu.toggle[self.menu.curMenu][i] == true)
						self.AIO.options[xePixTvx] affectElement("color", .2, divideColor(140, 255, 115));
					else
						self.AIO.options[xePixTvx] affectElement("color", .2, self.menuDesign["Options_Color"]);
				}
				else
					self.AIO.options[xePixTvx] affectElement("color", .2, self.menuDesign["Options_Color"]);
               		
				xePixTvx ++;
			}
			self.scrollbarYcache = (self.menuDesign["menuY"] - 75) + (25 * 3);
			self.AIO.shader["Scrollbar"].y = (self.menuDesign["menuY"] - 75) + (25 * 3);
		}
		else
		{
			for(i = 0; i < 7; i++)
			{
				self.AIO.options[i] setSafeText(self.menu.menuopt[self.menu.curMenu][self.menu.menuopt[self.menu.curMenu].size + (i - 7)]);
				
				if(!isDefined(self.menu.quick))
				{
					if(self.menu.curs[self.menu.curMenu] == self.menu.menuopt[self.menu.curMenu].size + (i - 7))
             			self.AIO.options[i] affectElement("alpha", .2, 1);
         			else
          				self.AIO.options[i] affectElement("alpha", .2, .2);
          		}
          		else
          		{
          			if(self.menu.curs[self.menu.curMenu] == self.menu.menuopt[self.menu.curMenu].size + (i - 7))
             			self.AIO.options[i].alpha = 1;
         			else
          				self.AIO.options[i].alpha = .2;
          		}
          		
          		if(isDefined(self.menu.toggle[self.menu.curMenu][self.menu.menuopt[self.menu.curMenu].size + (i - 7)]))
				{
					if(self.menu.toggle[self.menu.curMenu][self.menu.menuopt[self.menu.curMenu].size + (i - 7)] == true)
						self.AIO.options[i] affectElement("color", .2, divideColor(140, 255, 115));
					else
						self.AIO.options[i] affectElement("color", .2, self.menuDesign["Options_Color"]);
				}
				else
					self.AIO.options[i] affectElement("color", .2, self.menuDesign["Options_Color"]);
			}
			self.scrollbarYcache = (self.menuDesign["menuY"] - 75) + (25 * ((self.menu.curs[self.menu.curMenu] - self.menu.menuopt[self.menu.curMenu].size) + 7));
			self.AIO.shader["Scrollbar"].y = (self.menuDesign["menuY"] - 75) + (25 * ((self.menu.curs[self.menu.curMenu] - self.menu.menuopt[self.menu.curMenu].size) + 7));
		}
	}
	self playerInfoHuds();
}

titleAnim(color,hud,text)
{
	self endon("ENDtitleAnim");
	self endon("disconnect");
	self.menuDesign["titleAnimColor"] = color;
	for(;;)
	{
		if(self.menuDesign["titleAnimColor"] == "^7") hud setSafeText("^7"+text);
		while(self.menuDesign["titleAnimColor"] == "^7")
			wait .05;
		for(a=0;a<text.size;a++)
		{
			string = "";
			for(b=0;b<text.size;b++)
			{
				if(b == a)
					string += self.menuDesign["titleAnimColor"]+""+text[b]+"^7";
				else
					string += text[b];
			}
			if(isDefined(self.titleAnimWait))
				self waittill("titleAnim");
			hud setSafeText(string);
			wait .05;
		}
		wait .05;
		for(a=text.size-1;a>=0;a--)
		{
			string = "";
			for(b=0;b<text.size;b++)
			{
				if(b == a)
					string += self.menuDesign["titleAnimColor"]+""+text[b]+"^7";
				else
					string += text[b];
			}
			if(isDefined(self.titleAnimWait))
				self waittill("titleAnim");
			hud setSafeText(string);
			wait .05;
		}
		wait .05;
	}
}

continueTitleAnim(isMainTitle)
{
	if(isMainTitle == true)
	{
		self.titleAnimWait = true;
		if(!isDefined(self.menu.quick))
			wait .2;
		else
			wait .1;
		self.titleAnimWait = undefined;
		self notify("titleAnim");
	}
	else
	{
		self.titleAnimWait = undefined;
		self notify("ENDtitleAnim");
	}
}

playerInfoHuds()
{
	if(self.menu.curMenu == "PlayersMenu")
	{
		if(!isDefined(self.AIO.string["playerInfo"]) && !isDefined(self.AIO.shader["playerInfoBackground"]))
		{
			self.AIO.shader["playerInfoBackground"] = self createRectangle("LEFT", self.menuDesign["menuX"] + 160, self.AIO.shader["Scrollbar"].y+29, 150, 111, self.menuDesign["Background_Color"], "progress_bar_fg", 4, 1);
			self.AIO.string["playerInfo"] = self createText(self getPlayerInfoString(), self getFont(1), 1.2, "LEFT", self.menuDesign["menuX"] + 163, self.AIO.shader["Scrollbar"].y, self.menuDesign["Options_Color"], 1, 10);
		}
		else
		{
			self.AIO.string["playerInfo"].y = self.AIO.shader["Scrollbar"].y;
			self.AIO.shader["playerInfoBackground"].y = self.AIO.shader["Scrollbar"].y+29;
		}
	}
	else
	{
		if(isDefined(self.AIO.string["playerInfo"]) && isDefined(self.AIO.shader["playerInfoBackground"]))
		{
			self.AIO.string["playerInfo"] destroy();
			self.AIO.shader["playerInfoBackground"] destroy();
			self.AIO.string["playerInfo"] = undefined;
			self.AIO.shader["playerInfoBackground"] = undefined;
		}
	}
}

menuPlayersInfo()
{
	self endon("disconnect");
	self endon("destroyMenu");
	level endon("game_ended");
	
	oldString = "";
	for(;;)
	{
		if(self inMenu() && self.menu.curMenu == "PlayersMenu")
		{
			string = self getPlayerInfoString();
			if(isDefined(self.AIO.string["playerInfo"]))
			{
				if(string != oldString)
				{
					self.AIO.string["playerInfo"] setSafeText(string);
					oldString = string;
				}
			}
		}
		wait .05;
	}
}

getPlayerInfoString()
{
	player = level.players[self.menu.curs[self.menu.curMenu]];
	if(isDefined(player))
	{
		gun = player getCurrentWeapon();
		return "Gun : " + getWeaponDisplayName(gun) + player isInMenuStringCheck() + player godStringCheck() + player validStringCheck();
	}
	else
		return "n/a";
}

godStringCheck()
{
	if(isDefined(self.godMode))
		return "\nGodmode : ^2True^7";
	return "\nGodmode : ^1False^7";
}

isInMenuStringCheck()
{
	if(self inMenu())
		return "\nInside Menu : ^2True^7";
	return "\nInside Menu : ^1False^7";
}

validStringCheck()
{
	if(isAlive(self))
		return "\nisAlive : ^2True^7";
	return "\nisAlive : ^1False^7";
}














