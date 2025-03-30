StoreShaders()
{   
    self.EPI["header"] = self drawShader("em_bg_prestige_4", 235, -34, 200, 70, (1, 1, 1), 0, 0);
    self.EPI["background"] = self drawShader("white", 235, -100, 200, 1000, (0, 0, 0), 0, 0);
    self.EPI["backgrounddesign"] = self drawShader("emblem_bg_laid_to_rest", 235, -100, 200, 1000, (1, 0, 0), 0, 0);
    self.EPI["animation"] = self drawShader("compass_emp", 235, -100, 200, 1000, (1, 0, 0), 0, 1);
    self.EPI["scroller"] = self drawShader("rank_prestige12", 235, -100, 200, 15, (1, 0, 0), 255, 1);
    self.EPI["line"] = self drawShader("white", 336, -1000, 2, 500, (1, 0, 0), 255, 3);
    self.EPI["line2"] = self drawShader("white", 135, -1000, 2, 500, (1, 0, 0), 255, 2);
    self.EPI["line3"] = self drawShader("white", 235, -100, 200, 1, (1, 0, 0), 255, 4);
    self.EPI["header"].foreground = true;
}
 
StoreText(menu, title)
{

    self.menu.currentmenu = menu;
    string = "";
    self.EPI["title"] destroy();
    self.EPI["title"] = drawText(title, "default", 1.9, 235, 0, (1, 1, 1), 0, (1, 0, 0), 1, 3);
    self.EPI["title"] FadeOverTime(0.3);
    self.EPI["title"].alpha = 1;
    self.EPI["title"].archived = true; //stealth
    self.EPI["title"] setPoint( "LEFT", "LEFT", 503, -205); //x = -L/+R, y = -U/+D
    self.EPI["title"].foreground = true;
    
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string +=self.menu.menuopt[menu][i] + "\n"; }
    
    self.EPI["status"] destroy();
    self.EPI["status"] = drawText("Made By MossyWave", "default", 1.3, 0, 0, (1, 1, 1), 0, (0, 0, 0), 1, 4);
    self.EPI["status"] FadeOverTime(0.3);
    self.EPI["status"].alpha = 1;
    self.EPI["staus"].archived = true; //stealth
    self.EPI["status"] setPoint( "LEFT", "LEFT", 503, -185);
    self.EPI["status"].foreground = true;
    
    self.EPI["options"] destroy();
    self.EPI["options"] = drawText(string, "objective", 1.6, 265, 68, (1, 1, 1), 0, (0, 0, 0), 0, 4);
    self.EPI["options"] FadeOverTime(0.3);
    self.EPI["options"].alpha = 1;
    self.EPI["options"].glowalpha = 0.03;
    self.EPI["options"].archived = true; //stealth
    self.EPI["options"] setPoint( "LEFT", "LEFT", 503, -148 ); //x = -L/+R, y = -U/+D
    self.EPI["options"].foreground = true;
    self notify ("stopScale");
    self thread scaleLol();
 }
 
updateScrollbar()
{
	self.EPI["scroller"] MoveOverTime(0.10);
	self.EPI["scroller"].y = 50 + (self.menu.curs[self.menu.currentmenu] * 18.90);
}

