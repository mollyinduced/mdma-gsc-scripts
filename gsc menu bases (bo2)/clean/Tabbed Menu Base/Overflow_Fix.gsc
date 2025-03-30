overflowTest()
{
    display=createFontString("default",1.5);
    display setPoint("CENTER","RIGHT",0,0);
    i=0;
    for(;;)
    {
    display setText("Strings : ^1"+i);
    level.result += 1;
    level notify("textset");
    i++;
    wait 0.05;
    }
}

//credits to YouViolateMe
recreateText()
{
	self endon("disconnect");
	self endon("death");
		
	self thread NewMenu(self.SubMenu);
}

//Credits to dtx12, jwm614, and xTurntUpLobbies
overflowfix()
{  
    level.test = createServerFontString("default",1.5);
    level.test setText("xTUL");                
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
            	if(player.menu.open == true)
            	{
            		player recreateText();
            	}
            }
        }          
    }
}

setSafeText(text)
{
 level.result += 1;
 self setText(text);
 level notify("textset");
}






