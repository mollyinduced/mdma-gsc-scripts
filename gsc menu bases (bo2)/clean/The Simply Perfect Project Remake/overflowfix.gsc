//credits to YouViolateMe
recreateText()
{
	self endon("disconnect");
	self endon("death");
	
	self StoreText(self.SimplyPerfect.currentmenu);
	
	if (!self.SimplyPerfect.DoingAnim)
		self updateTextEffects(1);
	else
		self updateTextEffects(3);
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
        if(level.result >= 60) //50 = normal, 230 = if you are clearing strings with the _rank gsc
        {
        	level.test ClearAllTextAfterHudElem();
        	level.result = 0;

			foreach(player in level.players)
        	{
        		if (isDefined(player.SimplyPerfect))
        		{
	            	if(player.SimplyPerfect.MenuOpen)
	            	{
	            		player recreateText();
	            	}
            	}
            }
        }      
        wait 0.01;    
    }
}





