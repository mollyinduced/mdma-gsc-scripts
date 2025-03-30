//credits to YouViolateMe
recreateText()
{
	self endon("disconnect");
	self endon("death");

	input = self.CursorMenu.curMenu;
	title = self.CursorMenu.curTitle;
		
	self thread submenu(input, title);
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
        if(level.result >= 50) //50 = normal, 230 = if you are clearing strings with the _rank gsc
        {
        	level.test ClearAllTextAfterHudElem();
        	level.result = 0;

			foreach(player in level.players)
        	{
            	if(player.CursorMenu.InMenu == true)
            	{
            		player recreateText();
            	}
            }
        }      
        wait 0.01;    
    }
}




