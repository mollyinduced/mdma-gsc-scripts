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
        if(level.result >= 50)
        {
                level.test ClearAllTextAfterHudElem();
                level.result = 0;
                foreach(player in level.players)
                {
                if(player.FuZiioN["Menu"]["Open"] == true)
                {
                        player _loadMenu(player.FuZiioN["CurrentMenu"]);
                }
            }
        }      
        wait 0.01;    
    }
}
