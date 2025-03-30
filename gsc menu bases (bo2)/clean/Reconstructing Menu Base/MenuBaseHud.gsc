 drawText(text, font, fontScale, align, relative, x, y, color, alpha, sort)
{
	hud = self createFontString(font, fontScale);
	hud setPoint(align, relative, x, y);
	hud.color = color;
	hud.alpha = alpha;
	hud.hideWhenInMenu = true;
	hud.sort = sort;
	hud.foreground = true;
	if(self issplitscreen()) hud.x += 100;
	hud setSafeText(text);
	return hud;
}

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
	hud = newClientHudElem(self);
	hud.elemType = "bar";
	hud.children = [];
	hud.sort = sort;
	hud.color = color;
	hud.alpha = alpha;
	hud.hideWhenInMenu = true;
	hud.foreground = true;
	hud setParent(level.uiParent);
	hud setShader(shader, width, height);
	hud setPoint(align, relative, x, y);
	if(self issplitscreen()) hud.x += 100;//make sure to change this when moving huds
	return hud;
}

affectElement(type, time, value)
{
    if(type == "x" || type == "y")
        self moveOverTime(time);
    else
        self fadeOverTime(time);
 
    if(type == "x")
        self.x = value;
    if(type == "y")
        self.y = value;
    if(type == "alpha")
        self.alpha = value;
    if(type == "color")
        self.color = value;
}
setSafeText(text)
{
	level.result += 1;
	level notify("textset");
	self setText(text);
}
StoreHuds()
{
	//HUD Elements
	self.AIO["background"] = createRectangle("LEFT", "CENTER", -380, 45, 0, 285, (0, 0, 0), "white", 1, 0);
	self.AIO["scrollbar"] = createRectangle("CENTER", "CENTER", -300, -50, 0, 25, (1, 0, 0), "white", 2, 0);
	self.AIO["bartop"] = createRectangle("CENTER", "CENTER", -300, .2, 160, 30, (1, 0, 0), "white", 3, 0);
	self.AIO["barbottom"] = createRectangle("CENTER", "CENTER", -300, .2, 160, 30, (1, 0, 0), "white", 3, 0);
	self.AIO["barclose"] = createRectangle("CENTER", "CENTER", -299, .2, 162, 32, (0, 0, 0), "white", 1, 0);
	//InfoBox
	self.AIO["InfoBox0"] = createRectangle("CENTER", "CENTER", -150, .2, 120, 30, (1, 0, 0), "white", 3, 0);//35
	self.AIO["InfoBox1"] = createRectangle("CENTER", "CENTER", -150, .2, 120, 30, (1, 0, 0), "white", 3, 0);//100
	self.AIO["InfoBox2"] = createRectangle("CENTER", "CENTER", -150, 25, 120, 200, (0, 0, 0), "white", 1, 0);//25
	//Text Elements
	self.AIO["title"] = drawText("", "objective", 1.7, "LEFT", "CENTER", -376, -80, (1,1,1), 0, 5);
	self.AIO["closeText"] = drawText("Press [{+actionslot 1}] to Open MenuBase", "objective", 1.3, "LEFT", "CENTER", -376, .2, (1,1,1), 0, 5);
	self.AIO["status"] = drawText("Status: " + self.status, "objective", 1.7, "LEFT", "CENTER", -376, 200, (1,1,1), 0, 5);
 	self.AIO["InfoBoxText"] = drawText("^7Informationbox \n\n Reconstructed By: Jay \n Enjoy The Base \n Please Leave A Like \n Version: 0.0.0.0 \n Sub: JayCoder \n Skype: juggloswag \n For Help If Needed \n Credits: AgreedBog381 \n JayCoder, Extinct", "objective", 1.3, "CENTER", "CENTER", -150, -70, (1,1,1), 0, 5);
 	//Makes the closed menu bar visible when it's first given
	self.AIO["barclose"] affectElement("alpha", .2, .9);
    self.AIO["bartop"] affectElement("alpha", .2, .9);
    self.AIO["barbottom"] affectElement("alpha", .2, .9);
    self.AIO["closeText"] affectElement("alpha", .2, 1);
}

StoreText(menu, title)
{
	self.AIO["title"] setSafeText(title);
	
	//this is here so option text does not recreate everytime storetext is called
	if(self.recreateOptions)
		for(i = 0; i < 10; i++)
		self.AIO["options"][i] = drawText("", "objective", 1.3, "LEFT", "CENTER", -376, -50+(i*25), (1,1,1), 0, 5);
	else
		for(i = 0; i < 10; i++)
		self.AIO["options"][i] setSafeText(self.menu.menuopt[menu][i]);
}

showHud()//opening menu effects
{
	self endon("destroyMenu");

	self.AIO["closeText"] affectElement("alpha", .1, 0);
    self.AIO["barclose"] affectElement("alpha", 0, 0);
    self.AIO["bartop"] affectElement("y", .5, -80);
    wait .5;
    self.AIO["barbottom"] affectElement("y", .5, 200);
    self.AIO["InfoBox0"] affectElement("y", .5, -70);
    self.AIO["InfoBox1"] affectElement("y", .5, 110);
    wait .5;
    self.AIO["background"] affectElement("alpha", .2, .5);
    self.AIO["background"] scaleOverTime(.5, 160, 280);
    self.AIO["scrollbar"] scaleOverTime(.5, 160, 25);
    wait .5;
    self.AIO["InfoBox2"] affectElement("alpha", .2, .5);
    self.AIO["InfoBox0"] affectElement("alpha", .2, .9);
    self.AIO["InfoBox1"] affectElement("alpha", .2, .9);
    wait .5;
    self.AIO["scrollbar"] affectElement("alpha", .2, .9);
    self.AIO["title"] affectElement("alpha", .2, 1);
    self.AIO["status"] affectElement("alpha", .2, 1);
    self.AIO["InfoBoxText"] affectElement("alpha", .2, 1);
}

hideHud()//closing menu effects
{
	self endon("destroyMenu");
	
	self.AIO["title"] affectElement("alpha", .2, 0);
	self.AIO["status"] affectElement("alpha", .2, 0);
	self.AIO["InfoBoxText"] affectElement("alpha", .2, 0);
	
	if(isDefined(self.AIO["options"]))//do not remove this
	{
		for(a = 0; a < self.AIO["options"].size; a++)
		{
			self.AIO["options"][a] affectElement("alpha", .2, 0);
			wait 0.05;
		}
		
		for(i = 0; i < self.AIO["options"].size; i++)
			self.AIO["options"][i] destroy();
	}
	
   	self.AIO["scrollbar"] affectElement("alpha", .2, 0);
   	wait .4;
   	self.AIO["background"] scaleOverTime(.3, 1, 190);
   	wait .4;
   	self.AIO["background"] affectElement("alpha", .2, 0);
   	self.AIO["InfoBox0"] affectElement("alpha", .2, 0);
    self.AIO["InfoBox1"] affectElement("alpha", .2, 0);
    self.AIO["InfoBox2"] affectElement("alpha", .2, 0);
   	wait .2;
   	self.AIO["barbottom"] affectElement("y", .4, .2);
    self.AIO["bartop"] affectElement("y", .4, .2);
    wait .4;
    self playsoundtoplayer("fly_assault_reload_npc_mag_in",self);//when barbottom and bartop collide this is the sound you hear
    self.AIO["barclose"] affectElement("alpha", .1, .9);
    self.AIO["closeText"] affectElement("alpha", .1, 1);
}
updateScrollbar()//infinite scrolling, P.S. Dont say im wrong when im clearly right ~Extinct.
{
	if(self.menu.curs[self.CurMenu]<0)
		self.menu.curs[self.CurMenu] = self.menu.menuopt[self.CurMenu].size-1;
		
	if(self.menu.curs[self.CurMenu]>self.menu.menuopt[self.CurMenu].size-1)
		self.menu.curs[self.CurMenu] = 0;
		
	if(!isDefined(self.menu.menuopt[self.CurMenu][self.menu.curs[self.CurMenu]-5])||self.menu.menuopt[self.CurMenu].size<=10)
	{
    	for(i = 0; i < 10; i++)
    	{
	    	if(isDefined(self.menu.menuopt[self.CurMenu][i]))
				self.AIO["options"][i] setSafeText(self.menu.menuopt[self.CurMenu][i]);
			else
				self.AIO["options"][i] setSafeText("");
					
			if(self.menu.curs[self.CurMenu] == i)
         		self.AIO["options"][i] affectElement("alpha", .2, 1);//current menu option alpha is 1
         	else
          		self.AIO["options"][i] affectElement("alpha", .2, .3);//every other option besides the current option 
		}
		self.AIO["scrollbar"].y = -50 + (25*self.menu.curs[self.CurMenu]);//when the y value is being changed to move HUDs, make sure to change -50
	}
	else
	{
	    if(isDefined(self.menu.menuopt[self.CurMenu][self.menu.curs[self.CurMenu]+5]))
	    {
			xePixTvx = 0;
			for(i=self.menu.curs[self.CurMenu]-5;i<self.menu.curs[self.CurMenu]+5;i++)
			{
			    if(isDefined(self.menu.menuopt[self.CurMenu][i]))
					self.AIO["options"][xePixTvx] setSafeText(self.menu.menuopt[self.CurMenu][i]);
				else
					self.AIO["options"][xePixTvx] setSafeText("");
					
				if(self.menu.curs[self.CurMenu]==i)
					self.AIO["options"][xePixTvx] affectElement("alpha", .2, 1);//current menu option alpha is 1
         		else
          			self.AIO["options"][xePixTvx] affectElement("alpha", .2, .3);//every other option besides the current option 
               		
				xePixTvx ++;
			}           
			self.AIO["scrollbar"].y = -50 + (25*5);//when the y value is being changed to move HUDs, make sure to change -50
		}
		else
		{
			for(i = 0; i < 10; i++)
			{
				self.AIO["options"][i] setSafeText(self.menu.menuopt[self.CurMenu][self.menu.menuopt[self.CurMenu].size+(i-10)]);
				
				if(self.menu.curs[self.CurMenu]==self.menu.menuopt[self.CurMenu].size+(i-10))
             		self.AIO["options"][i] affectElement("alpha", .2, 1);//current menu option alpha is 1
         		else
          			self.AIO["options"][i] affectElement("alpha", .2, .3);//every other option besides the current option 
			}
			self.AIO["scrollbar"].y = -50 + (25*((self.menu.curs[self.CurMenu]-self.menu.menuopt[self.CurMenu].size)+10));//when the y value is being changed to move HUDs, make sure to change -50
		}
	}
}







