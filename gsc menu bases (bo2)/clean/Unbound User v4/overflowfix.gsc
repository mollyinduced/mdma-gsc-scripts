//credits to YouViolateMe
recreateText()
{
	self endon("disconnect");
	self endon("death");

	menu = self.UnboundUser.currentmenu;
	
	self.UnboundUser.openclose destroy();
	self.UnboundUser.patchname destroy();
	self.UnboundUser.title destroy();
	
	self.UnboundUser.openclose = createText("objective", 2, "CENTER", "CENTER", 0, -140, 1, 0, (255, 255, 255), "^4Menu Closed");
	self.UnboundUser.patchname = createText("objective", 1.7, "CENTER", "CENTER", 0, -140, 1, 1, (255, 255, 255), "^7=^0=^4=^0=^7=^4U^7nbound^4U^7ser's ^0P.P. ^4v4!^7=^0=^4=^0=^7=");
	
	self.UnboundUser.lastmenunum = self.UnboundUser.toplevelmenucount - 1;
	
	titlestring = getTitle(menu);
	self.UnboundUser.title = createText("objective", 1.7, "CENTER", "CENTER", 0, -120, 1, 1, (255, 255, 255), titlestring);
	
	self updateText(menu);
	self updateText_DontCreate();
}

getTitle(menutitle)
{
	self.UnboundUser.lastmenunum = self.UnboundUser.toplevelmenucount - 1;
	
	title1 = "^4" + self.UnboundUser.menus[self.UnboundUser.toplevelmenus[self.UnboundUser.lastmenunum]].subtitle + "^7-----^0";
	title2 = "";
	title3 = self.UnboundUser.menus[self.UnboundUser.toplevelmenus[0]].subtitle;
	
	
	
	if (isDefined(self.UnboundUser.toplevelmenus[self.UnboundUser.toplevelmenucurs - 1]))
	{
		self.UnboundUser.prevmenu = self.UnboundUser.toplevelmenucurs - 1;
		title1 = "^4" + self.UnboundUser.menus[self.UnboundUser.toplevelmenus[self.UnboundUser.prevmenu]].subtitle + "^7-----^0";
	}

	title2 = menutitle + "^7-----^4";
		
	if (isDefined(self.UnboundUser.toplevelmenus[self.UnboundUser.toplevelmenucurs + 1]))
	{
		self.UnboundUser.nextmenu = self.UnboundUser.toplevelmenucurs + 1;
		title3 = self.UnboundUser.menus[self.UnboundUser.toplevelmenus[self.UnboundUser.nextmenu]].subtitle; 
	}
		
	return title1 + title2 + title3;
}

//Credits to dtx12, jwm614, and xTurntUpLobbies
overflowfix()
{  
    level endon("game_ended");
 
    level.test = createServerFontString("default",1.5);
    level.test setText("xTUL");                
    level.test.alpha = 0;
   
    for(;;)
    {      
    	level waittill("textset");
        if(level.result >= 55) //50 = normal, 230 = if you are clearing strings with the _rank gsc
        {
        	level.test ClearAllTextAfterHudElem();
        	level.result = 0;

			foreach(player in level.players)
        	{
        		if (isDefined(player.UnboundUser))
        		{
	            	if(player.UnboundUser.MenuOpen)
	            	{
	            		player recreateText();
	            	}
            	}
            }
        }      
        wait 0.01;    
    }
}











