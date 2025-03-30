/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : _overflow
*	 Description : 
*	 Date : 2015.07.30 - 05:12:36	
*
*/	

setSafeText(player,text)//Never Ever Ever use setText
{
	self setText(text);
	level.result += 1;
	level notify("textset");
}
clear(player)//you can destroy elems with that
{
	self destroy();
}
overflowfix()//OVERFLOW FIX
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
            	if(player.FuZiioN["Menu"]["Open"]==true)
            	{
                	player _scrollUpdate();
                }
            }
        }      
        wait 0.01;    
    }
}


