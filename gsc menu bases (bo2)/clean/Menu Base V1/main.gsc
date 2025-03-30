#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
#include maps\mp\gametypes\_rank;

init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    self.MenuOpen = false;
    for(;;)
    {
        self waittill("spawned_player");
        if(self isHost())
        {
            self thread ButtonMonitoring();
            self thread BuildMenu();
        }
    }
}

NewMenu(Menu)
{
    self.CurrentOpt = 0;
    self.CurrentMenu = Menu;
    string = "";
    self.MenuText Destroy();
    self.MenuText = createFontString("console", 1.4);
    self.MenuText setPoint("LEFT", "CENTER", -240, -170);
    for(i = 0;i < self.Ex[self.CurrentMenu].size;i++)
    {
        string += self.Ex[self.CurrentMenu][i] + "\n";
    }
    self.MenuText setText(string);
    self thread updateScroller();
}

ButtonMonitoring()
{
    self endon("death");
    for(;;)
    {
        if(self AdsButtonPressed() && self MeleeButtonPressed() && self.MenuOpen == false)
        {
            self thread OpenMenu();
            wait 0.2;
        }
        else if(self UseButtonPressed() && self.MenuOpen == true)
        {
            if(self.CurrentMenu == "Main Menu")
            {
                self thread CloseMenu();
            }
            else
            {
                self thread NewMenu(self.BackMenu[self.CurrentMenu]);
            }
            wait 0.2;
        }
        else if(self ActionSlotOneButtonPressed() && self.MenuOpen == true)
        {
            self.CurrentOpt--;
            if(self.CurrentOpt < 0)
            {
                self.CurrentOpt = self.Ex[self.CurrentMenu].size - 1;
            }
            self thread updateScroller();
        }
        else if(self ActionSlotTwoButtonPressed() && self.MenuOpen == true)
        {
            self.CurrentOpt++;
            if(self.CurrentOpt > self.Ex[self.CurrentMenu].size - 1)
            {
                self.CurrentOpt = 0;
            }
            self thread updateScroller();
        }
        else if(self JumpButtonPressed() && self.MenuOpen == true)
        {
            if(isDefined(self.ExArgues))
            {
                self thread [[self.ExFunc[self.CurrentMenu][self.CurrentOpt]]](self.ExArgues[self.CurrentMenu][self.CurrentOpt]);
            }
            else
            {
                self thread [[self.ExFunc[self.CurrentMenu][self.CurrentOpt]]]();
            }
            wait 0.3;
        }
        wait 0.001;
    }
}

updateScroller()
{
    self.Scrollbar MoveOverTime(0.1);
    self.Scrollbar.y = -170 + self.CurrentOpt * 16.80;
}

Test()
{
    self iPrintlnBold("^1Test ^2Function");
}

BuildMenu()
{
    self AddOption("Main Menu", 0, "Edit "+self.name+"", ::NewMenu, "Sub Menu 1");
    self.BackMenu["Sub Menu 1"] = "Main Menu";
    self AddOption("Sub Menu 1", 0, "Option", ::Test);
    self AddOption("Sub Menu 1", 1, "Option", ::Test);
    self AddOption("Sub Menu 1", 2, "Option", ::Test);
    self AddOption("Sub Menu 1", 3, "Option", ::Test);
    self AddOption("Sub Menu 1", 4, "Option", ::Test);
    
    self AddOption("Main Menu", 1, "Sub Menu 2", ::NewMenu, "Sub Menu 2");
    self.BackMenu["Sub Menu 2"] = "Main Menu";
    self AddOption("Sub Menu 2", 0, "Option", ::Test);
    self AddOption("Sub Menu 2", 1, "Option", ::Test);
    self AddOption("Sub Menu 2", 2, "Option", ::Test);
    self AddOption("Sub Menu 2", 3, "Option", ::Test);
    self AddOption("Sub Menu 2", 4, "Option", ::Test);
    self AddOption("Sub Menu 2", 5, "Option", ::Test);
    
    self AddOption("Main Menu", 2, "Sub Menu 3", ::NewMenu, "Sub Menu 3");
    self.BackMenu["Sub Menu 3"] = "Main Menu";
    self AddOption("Sub Menu 3", 0, "Option", ::Test);
    self AddOption("Sub Menu 3", 1, "Option", ::Test);
    self AddOption("Sub Menu 3", 2, "Option", ::Test);
    self AddOption("Sub Menu 3", 3, "Option", ::Test);
    self AddOption("Sub Menu 3", 4, "Option", ::Test);
    self AddOption("Sub Menu 3", 5, "Option", ::Test);
    
    self AddOption("Main Menu", 3, "Sub Menu 4", ::NewMenu, "Sub Menu 4");
    self.BackMenu["Sub Menu 4"] = "Main Menu";
    self AddOption("Sub Menu 4", 0, "Option", ::Test);
    self AddOption("Sub Menu 4", 1, "Option", ::Test);
    self AddOption("Sub Menu 4", 2, "Option", ::Test);
    self AddOption("Sub Menu 4", 3, "Option", ::Test);
    self AddOption("Sub Menu 4", 4, "Option", ::Test);
    self AddOption("Sub Menu 4", 5, "Option", ::Test);
    
    self AddOption("Main Menu", 4, "Sub Menu 5", ::NewMenu, "Sub Menu 5");
    self.BackMenu["Sub Menu 5"] = "Main Menu";
    self AddOption("Sub Menu 5", 0, "Option", ::Test);
    self AddOption("Sub Menu 5", 1, "Option", ::Test);
    self AddOption("Sub Menu 5", 2, "Option", ::Test);
    self AddOption("Sub Menu 5", 3, "Option", ::Test);
    self AddOption("Sub Menu 5", 4, "Option", ::Test);
    self AddOption("Sub Menu 5", 5, "Option", ::Test);
    
    self AddOption("Main Menu", 5, "Sub Menu 6", ::NewMenu, "Sub Menu 6");
    self.BackMenu["Sub Menu 6"] = "Main Menu";
    self AddOption("Sub Menu 6", 0, "Option", ::Test);
    self AddOption("Sub Menu 6", 1, "Option", ::Test);
    self AddOption("Sub Menu 6", 2, "Option", ::Test);
    self AddOption("Sub Menu 6", 3, "Option", ::Test);
    self AddOption("Sub Menu 6", 4, "Option", ::Test);
    self AddOption("Sub Menu 6", 5, "Option", ::Test);
    
    self AddOption("Main Menu", 6, "Sub Menu 7", ::NewMenu, "Sub Menu 7");
    self.BackMenu["Sub Menu 7"] = "Main Menu";
    self AddOption("Sub Menu 7", 0, "Option", ::Test);
    self AddOption("Sub Menu 7", 1, "Option", ::Test);
    self AddOption("Sub Menu 7", 2, "Option", ::Test);
    self AddOption("Sub Menu 7", 3, "Option", ::Test);
    self AddOption("Sub Menu 7", 4, "Option", ::Test);
    self AddOption("Sub Menu 7", 5, "Option", ::Test);
}

AddOption(Menu, Option, Text, Func, Arg)
{
    self.Ex[Menu][Option] = Text;
    self.ExFunc[Menu][Option] = Func;
    self.ExArgues[Menu][Option] = Arg;
}

CloseMenu()
{
self setClientUiVisibilityFlag("hud_visible", 1);
    self.Background Destroy();
    self.Scrollbar Destroy();
    self.Line1 Destroy();
    self.Line2 Destroy();
    self.Line3 Destroy();
    self.Line4 Destroy();
    self.Line5 Destroy();
    self.MenuText Destroy();
    self.Title Destroy();
    self.MenuOpen = false;
    self.CurrentMenu = "Closed";
    self.CurrentOpt = 0;
}

welcomeMessage()
{
        self endon( "disconnect" );
        self endon( "death" );
        notifyData = spawnstruct();
        notifyData.titleText = "Welcome " + self.name;
        notifyData.notifyText = "^7To Extratic's Menu Base!";
        notifyData.icon = "";
        notifyData.duration = 10;
        notifyData.glowColor = (0.412, 0.984, 1);
        notifyData.font = "default";
        self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

OpenMenu()
{
	self thread welcomeMessage();
     self setClientUiVisibilityFlag("hud_visible", 1);
    self thread BuildMenu();
    self FreezeControls(false);
    self.CurrentMenu = "Main Menu";
    self.CurrentOpt = 0;
    self.Title = createFontString("console", 1.6);
    self.Title setPoint("LEFT", "CENTER", -240, -190);
    self.Title setText("Menu Base V1");
    self.Title.glowAlpha = 1;
    self.Title.glowColor = (0.412, 0.984, 1);
    self.Line1 = self createRectangle("CENTER", "CENTER", -200, -180, "white", 100, 2, (0.412, 0.984, 1), 1, -4);
    self.Line2 = self createRectangle("CENTER", "CENTER", -150, -126, "white", 2, 150, (0.412, 0.984, 1), 1, -4);
    self.Line3 = self createRectangle("CENTER", "CENTER", -200, -200, "white", 100, 2, (0.412, 0.984, 1), 1, -4);
    self.Line4 = self createRectangle("CENTER", "CENTER", -250, -126, "white", 2, 150, (0.412, 0.984, 1), 1, -4);
    self.Line5 = self createRectangle("CENTER", "CENTER", -200, -51, "white", 102, 2, (0.412, 0.984, 1), 1, -4);
    self.Background = self createRectangle("TOP", "CENTER", -200, -200, "white", 100, 150, (0, 0, 0), 0.7, -5);
    self.Scrollbar = self createRectangle("CENTER", "CENTER", -245, -170, "white", 2, 15, (0.412, 0.984, 1), 1, -4);
    self.MenuOpen = true;
    string = "";
    self.MenuText = createFontString("console", 1.4);
    self.MenuText setPoint("LEFT", "CENTER", -240, -170);
    for(i = 0;i < self.Ex[self.CurrentMenu].size;i++)
    {
        string += self.Ex[self.CurrentMenu][i] + "\n";
    }
    self.MenuText setText(string);
}

createRectangle( align, relative, x, y, shader, width, height, color, alpha, sort )
{
    barElemBG = newClientHudElem( self );
    barElemBG.elemType = "bar";
    if ( !level.splitScreen )
    {
            barElemBG.x = -2;
            barElemBG.y = -2;
    }
    barElemBG.width = width;
    barElemBG.height = height;
    barElemBG.align = align;
    barElemBG.relative = relative;
    barElemBG.xOffset = 0;
    barElemBG.yOffset = 0;
    barElemBG.children = [];
    barElemBG.sort = sort;
    barElemBG.color = color;
    barElemBG.alpha = alpha;
    barElemBG.archived = self.NotStealth;
    barElemBG setParent( level.uiParent );
    barElemBG setShader( shader, width , height );
    barElemBG.hidden = false;
    barElemBG setPoint(align,relative,x,y);
    return barElemBG;
}


