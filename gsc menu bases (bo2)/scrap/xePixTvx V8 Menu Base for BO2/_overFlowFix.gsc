setSafeText(text)
{
	self setText(text);
	level.result += 1;
	level notify("textset");
}
_recreateText()
{
	if(self.Menu.Opened==true)
	{
		self.Hud.Title setSafeText(self.Menu.Title[self.Menu.CurrentMenu]);
		string = "";
		for(i=0;i<self.Menu.Text[self.Menu.CurrentMenu].size;i++)
		{
			string += self.Menu.Text[self.Menu.CurrentMenu][i]+"\n";
		}
		self.Hud.Text setSafeText(string);
	}
	else
	{
		self.Hud.Title setSafeText("^5Press [{+smoke}] To Open Menu");
	}
}
overflowfix()
{  
    level endon("game_ended");
    level.test = createServerFontString("default",1.5);
    level.test setText("xePixTvx");                
    level.test.alpha = 0;
    for(;;)
    {      
        level waittill("textset");
        if(level.result >= 50)
        {
        	level.test ClearAllTextAfterHudElem();
            level.result = 0;
            foreach(player in level.players)
            {
            	if(player.hasMenu==true)
            	{
            		player _recreateText();
            	}
            }
        }      
        wait 0.01;
    }
}

