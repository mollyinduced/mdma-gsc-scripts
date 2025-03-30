StoreHuds()
{
	self.Radiant["header"] = CreateRectangle("RIGHT", "TOPLEFT", 310, 50, 191, 50, (0.004,0.529,0.917), "white", 8, 0);
	self.Radiant["background"] = CreateRectangle("RIGHT", "TOPLEFT", 310, undefined, undefined, undefined, (0,0,0), undefined, 3, 0);
	self.Radiant["scrollbar"] = CreateRectangle("RIGHT", "TOPLEFT", 310, 103, 191, 18, (1,1,1), "white", 8, 0);
	self.Radiant["bartop"] = CreateRectangle("RIGHT", "TOPLEFT", 310, 84, 191, 20, (0,0,0), "white", 7, 0);
	self.Radiant["barbottom"] = CreateRectangle("RIGHT", "TOPLEFT", 310, 201, 191, 19, (0,0,0), "white", 7, 0);
	self.Radiant["arrowtop"] = CreateRectangle("RIGHT", "TOPLEFT", 218, 197, 7, 7, (1,1,1), "ui_scrollbar_arrow_up_a", 9, 0);
	self.Radiant["arrowbottom"] = CreateRectangle("RIGHT", "TOPLEFT", 218, 205, 7, 7, (1,1,1), "ui_scrollbar_arrow_dwn_a", 9, 0);
	
	self.Radiant["title"] = drawText("Menu Base", "bigfixed", 1.3, "LEFT", "TOPLEFT", 161, 48, (1,1,1), 0, 9);
	self.Radiant["slash"] = drawText("/", "objective", 1.4, "RIGHT", "TOPLEFT", 290, 83, (1,1,1), 0, 9);
	self.Radiant["root"] = drawText("", "objective", 1.4, "LEFT", "TOPLEFT", 126, 83, (1,1,1), 0, 9);
	
	self.Radiant["value"] = drawValue("", "objective", 1.4, "RIGHT", "TOPLEFT", 302, 83, (1,1,1), 0, 9);
	self.Radiant["value2"] = drawValue("", "objective", 1.4, "RIGHT", "TOPLEFT", 282, 83, (1,1,1), 0, 9);
}

backgroundsize(height, yValue)
{
	self.Radiant["background"] setShader("white", 191, height);
	self.Radiant["background"].y = 142 - yValue;
}

StoreText(menu, title)
{
	if(self.menu.menuopt[menu].size <= 5)
	{
		self.Radiant["barbottom"].alpha = 0;
		self.Radiant["arrowtop"].alpha = 0;
		self.Radiant["arrowbottom"].alpha = 0;
		
		height = (self.menu.menuopt[menu].size*20);
		
		if(self.menu.menuopt[menu].size == 5) self backgroundsize(height + 18, 9);
		else if(self.menu.menuopt[menu].size == 4) self backgroundsize(height + 18, 19);
		else if(self.menu.menuopt[menu].size == 3) self backgroundsize(height + 18, 29);
		else if(self.menu.menuopt[menu].size == 2) self backgroundsize(height + 18, 39);
		else if(self.menu.menuopt[menu].size == 1) self backgroundsize(height + 18, 49);
	}
	else
	{
		self.Radiant["barbottom"].alpha = 0.5;
		self.Radiant["arrowtop"].alpha = 1;
		self.Radiant["arrowbottom"].alpha = 1;
		self.Radiant["background"] setShader("white", 191, 136);
		self.Radiant["background"].y = 142;
	}
	
	self.Radiant["root"] setSafeText(title);
	self.Radiant["value"] setValue(self.menu.menuopt[menu].size);
	
	if(self.recreateOptions)
		for(i = 0; i < 5; i++)
		self.Radiant["options"][i] = drawText("", "objective", 1.4, "LEFT", "TOPLEFT", 126, 102 + (i*20), (1,1,1), 1, 9);
	else
		for(i = 0; i < 5; i++)
		self.Radiant["options"][i] setSafeText(self.menu.menuopt[menu][i]);
}

updateScrollbar()
{
	if(self.menu.curs[self.CurMenu]<0)
		self.menu.curs[self.CurMenu] = self.menu.menuopt[self.CurMenu].size-1;
		
	if(self.menu.curs[self.CurMenu]>self.menu.menuopt[self.CurMenu].size-1)
		self.menu.curs[self.CurMenu] = 0;
		
	if(!isDefined(self.menu.menuopt[self.CurMenu][self.menu.curs[self.CurMenu]-2])||self.menu.menuopt[self.CurMenu].size<=5)
	{
    	for(i = 0; i < 5; i++)
    	{
	    	if(isDefined(self.menu.menuopt[self.CurMenu][i]))
				self.Radiant["options"][i] setSafeText(self.menu.menuopt[self.CurMenu][i]);
			else
				self.Radiant["options"][i] setSafeText("");
					
			if(self.menu.curs[self.CurMenu] == i)
			{
				self.Radiant["value2"] setValue(i+1);
         		self.Radiant["options"][i].color = (0,0,0);
         	}
         	else
          		self.Radiant["options"][i].color = (1,1,1);
		}
		self.Radiant["scrollbar"].y = 103 + (20*self.menu.curs[self.CurMenu]);
	}
	else
	{
	    if(isDefined(self.menu.menuopt[self.CurMenu][self.menu.curs[self.CurMenu]+2]))
	    {
			xePixTvx = 0;
			for(i=self.menu.curs[self.CurMenu]-2;i<self.menu.curs[self.CurMenu]+3;i++)
			{
			    if(isDefined(self.menu.menuopt[self.CurMenu][i]))
					self.Radiant["options"][xePixTvx] setSafeText(self.menu.menuopt[self.CurMenu][i]);
				else
					self.Radiant["options"][xePixTvx] setSafeText("");
					
				if(self.menu.curs[self.CurMenu]==i)
				{
					self.Radiant["value2"] setValue(i+1);
					self.Radiant["options"][xePixTvx].color = (0,0,0);
           		}
              	else
               		self.Radiant["options"][xePixTvx].color = (1,1,1);
               		
				xePixTvx ++;
			}           
			self.Radiant["scrollbar"].y = 103 + (20*2);
		}
		else
		{
			for(i = 0; i < 5; i++)
			{
				self.Radiant["options"][i] setSafeText(self.menu.menuopt[self.CurMenu][self.menu.menuopt[self.CurMenu].size+(i-5)]);
				
				if(self.menu.curs[self.CurMenu]==self.menu.menuopt[self.CurMenu].size+(i-5))
				{
					self.Radiant["value2"] setValue((self.menu.menuopt[self.CurMenu].size+(i-5))+1);
             		self.Radiant["options"][i].color = (0,0,0);
             	}
         		else
             		self.Radiant["options"][i].color = (1,1,1);
			}
			self.Radiant["scrollbar"].y = 103 + (20*((self.menu.curs[self.CurMenu]-self.menu.menuopt[self.CurMenu].size)+5));
		}
	}
}

