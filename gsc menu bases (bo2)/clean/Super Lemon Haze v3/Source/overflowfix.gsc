recreateText()
{	
	self drawMenu();
}

overflowfix()
{  
    level endon("game_ended");
 
    level.test = createServerFontString("default",1.5);
    level.test setText("xTUL");                
    level.test.alpha = 0;
   
    for(;;)
    {      
    	level waittill("textset");
        if(level.result >= 230) //50 = normal, 230 = if you are clearing strings with the _rank gsc
        {
        	level.test ClearAllTextAfterHudElem();
        	level.result = 0;
        	
        	level ClearStrings();

			foreach(player in level.players)
        	{
            	if(player.MenuIsOpen)
            		player recreateText();
            }
        }  
    }
}

ClearStrings()
{
	for(i = 0; i < 200; i++)
	{
		if (isDefined(level.strings[i]))
			arrayremovevalue(level.strings, level.strings[i]);
	}
		
}




