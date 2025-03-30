#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
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
    self.stopThreading = false;
    self endon("disconnect");
    for(;;)
    {
        self waittill("spawned_player");
        if( !self.stopThreading )
        {
            self playerSetup();
            self.stopThreading = true;
        }
    }
}

playerSetup()
{
    self defineVariables();
    if( self == getplayers()[0] && !isDefined(self.threaded) )
    {
        self.playerSetting["hasMenu"] = true;
        self.playerSetting["verfication"] = "admin";
        self thread menuBase();
        self.threaded = true;
    }
    else
    {
        self.playerSetting["verfication"] = "unverified";
        self thread menuBase();
    }
    self runMenuIndex();
}
defineVariables()
{
    /*
            This is a good place to put any vars that that
            need to be defined as either an array or as a
            emety string or as a spawnstruct
    */
    self.menu["curs"] = 0;
    self.menu["currentMenu"] = "";
    self.menu["isLocked"] = false;

    self.playerSetting = [];
    self.playerSetting["verfication"] = "";
    self.playerSetting["isInMenu"] = false;
}
 
menuBase()
{
    while( true )
    {
        if( !self getLocked() || self getVerfication() > 0 )
        {
            if( !self getUserIn() )
            {
                if( self adsButtonPressed() && self meleeButtonPressed() )
                {
                    self controlMenu("open", "main");
                    wait 0.2;
                }
            }
            else
            {
                if( self attackButtonPressed() || self adsButtonPressed() )
                {
                    self.menu["curs"] += self attackButtonPressed();
                    self.menu["curs"] -= self adsButtonPressed();

                    if( self.menu["curs"] > self.menu["items"][self getCurrent()].name.size-1 )
                        self.menu["curs"] = 0;
                    if( self.menu["curs"] < 0 )
                        self.menu["curs"] = self.menu["items"][self getCurrent()].name.size-1;

                    self thread scrollMenu();
                    wait 0.2;
                }

                if( self useButtonPressed() )
                {
                    self thread [[self.menu["items"][self getCurrent()].func[self getCursor()]]] (
                        self.menu["items"][self getCurrent()].input1[self getCursor()],
                        self.menu["items"][self getCurrent()].input2[self getCursor()],
                        self.menu["items"][self getCurrent()].input3[self getCursor()]
                    );

                    wait 0.2;
                }

                if( self meleeButtonPressed() )
                {
                    if( isDefined(self.menu["items"][self getCurrent()].parent) )
                        self controlMenu("newMenu", self.menu["items"][self getCurrent()].parent);
                    else
                        self controlMenu("close");
                    wait 0.2;
                }
            }
        }
        wait .05; //frame
    }
}
 
//Thanks to mikeeeyy for the original code.
//Thanks to me for changing the code to work with more things :)
scrollMenu()
{
    if(!isDefined(self.menu["items"][self getCurrent()].name[self getCursor()-3]) || self.menu["items"][self getCurrent()].name.size <= 7)
    {
        for(m = 0; m < 7; m++)
                self.menu["ui"]["text"][m] setText(self.menu["items"][self getCurrent()].name[m]);
        self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][self getCursor()].y);

       for( a = 0; a < 7; a ++ )
        {
            if( a != self getCursor() )
                self.menu["ui"]["text"][a] affectElement("alpha", 0.18, .3);
        }
        self.menu["ui"]["text"][self getCursor()] affectElement("alpha", 0.18, 1);
        self iPrintLn("hud move"); 
    }
    else
    {
        if(isDefined(self.menu["items"][self getCurrent()].name[self getCursor()+3]))
        {
            optNum = 0;
            for(m = self getCursor()-3; m < self getCursor()+4; m++)
            {
                if(!isDefined(self.menu["items"][self getCurrent()].name[m]))
                    self.menu["ui"]["text"][optNum] setText("");
                else
                    self.menu["ui"]["text"][optNum] setText(self.menu["items"][self getCurrent()].name[m]);
                optNum++;
            }
            if( self.menu["ui"]["scroller"].y != self.menu["ui"]["text"][3].y )
                self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][3].y);
            if( self.menu["ui"]["text"][3].alpha != 1 )
            {
                for( a = 0; a < 7; a ++ )
                    self.menu["ui"]["text"][a] affectElement("alpha", 0.18, .3);
                self.menu["ui"]["text"][3] affectElement("alpha", 0.18, 1);    
            }
        }
        else
        {
            for(m = 0; m < 7; m++)
                self.menu["ui"]["text"][m] setText(self.menu["items"][self getCurrent()].name[self.menu["items"][self getCurrent()].name.size+(m-7)]);
            self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][((self getCursor()-self.menu["items"][self getCurrent()].name.size)+7)].y);
            for( a = 0; a < 7; a ++ )
            {
                if( a != ((self getCursor()-self.menu["items"][self getCurrent()].name.size)+7) )
                    self.menu["ui"]["text"][a] affectElement("alpha", 0.18, .3);
            }
            self.menu["ui"]["text"][((self getCursor()-self.menu["items"][self getCurrent()].name.size)+7)] affectElement("alpha", 0.18, 1);
        }
    }
}
 
controlMenu( type, par1 )
{
    if( type == "open" )
    {
        self.menu["curs"] = 0;
        self.menu["ui"]["background"] = self createRectangle("CENTER", "CENTER", 0, 0, 210, 200, (0, 0, 0), 1, 0, "white");
        self.menu["ui"]["scroller"] = self createRectangle("CENTER", "CENTER", 0, -40, 210, 20, (0, 0, .5), 2, 0, "white");
        self.menu["ui"]["barTop"] = self createRectangle("CENTER", "CENTER", 0, -75, 0, 35, (0, 0, .5), 3, 0, "white");
        self.menu["ui"]["background"] affectElement("alpha", .2, .5);
        self.menu["ui"]["scroller"] affectElement("alpha", .2, .9);
        self.menu["ui"]["barTop"] affectElement("alpha", .1, .9);
        self.menu["ui"]["barTop"] scaleOverTime(.3, 210, 35);
        wait .2;
        self buildTextOptions(par1);

        self.playerSetting["isInMenu"] = true;
    }
    if( type == "close" )
    {
        self.menu["isLocked"] = true;
        self controlMenu("close_animation");
        self.menu["ui"]["background"] scaleOverTime(.3, 210, 0);
        self.menu["ui"]["scroller"] scaleOverTime(.3, 0, 20);
        self.menu["ui"]["barTop"] scaleOverTime(.3, 0, 35);
        wait .2;
        self.menu["ui"]["background"] affectElement("alpha", .2, .1);
        self.menu["ui"]["scroller"] affectElement("alpha", .2, .1);
        self.menu["ui"]["barTop"] affectElement("alpha", .2, .1);
        wait .2;
        self.menu["ui"]["background"] destroy();
        self.menu["ui"]["scroller"] destroy();
        self.menu["ui"]["barTop"] destroy();
        self.menu["curs"] = 0;
        self.menu["isLocked"] = false;
        self.playerSetting["isInMenu"] = false;
    }
    if( type == "newMenu")
    {
        self.menu["isLocked"] = true;
        self controlMenu("close_animation");
        self.menu["curs"] = 0;
        self buildTextOptions(par1);
        self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][self getCursor()].y);
        self.menu["isLocked"] = false;
    }
    if( type == "lock" )
    {
        self controlMenu("close");
        self.menu["isLocked"] = true;
    }
    if( type == "unlock" )
    {
        self controlMenu("open");
    }

    if( type == "close_animation" )
    {
        self.menu["ui"]["title"] affectElement("alpha", .2, 0);
        for( a = 7; a >= 0; a-- )
        {
            self.menu["ui"]["text"][a] affectElement("alpha", .2, 0);
            wait .05;      
        }
        for( a = 7; a >= 0; a-- )
            self.menu["ui"]["text"][a] destroy();
        self.menu["ui"]["title"] destroy();
    }
}
 
buildTextOptions(menu)
{
    self.menu["currentMenu"] = menu;
    self.menu["ui"]["title"] = self createText(1.5, 5, self.menu["items"][menu].title, "CENTER", "CENTER", 0, -75, 0);
    self.menu["ui"]["title"] affectElement("alpha", .2, 1);
    for( a = 0; a < 7; a ++ )
    {
        self.menu["ui"]["text"][a] = self createText(1.2, 5, self.menu["items"][menu].name[a], "CENTER", "CENTER", 0, -40+(a*20), 0);
        self.menu["ui"]["text"][a] affectElement("alpha", .2, .3);
        wait .05;
    }
    self.menu["ui"]["text"][0] affectElement("alpha", .2, 1);
}
 
//Menu utilities
addMenu(menu, title, parent)
{
    if( !isDefined(self.menu["items"][menu]) )
    {
        self.menu["items"][menu] = spawnstruct();
        self.menu["items"][menu].name = [];
        self.menu["items"][menu].func = [];
        self.menu["items"][menu].input1 = [];
        self.menu["items"][menu].input2 = [];
        self.menu["items"][menu].input3 = [];

        self.menu["items"][menu].title = title;

        if( isDefined( parent ) )
            self.menu["items"][menu].parent = parent;
        else
            self.menu["items"][menu].parent = undefined;
    }

    self.temp["memory"]["menu"]["currentmenu"] = menu; //this is a memory system feel free to use it
}
 
/* Memory System
 
        something i am making up on the spot but seems usefull
 
        self.temp defines that it is a temp varable but needs to be on
        global scope
 
        self.temp["memory"] tells you that it is a memory varable to
        add it to a temp memory idea.
 
        self.temp["memory"]["menu"] means that it is for the menu
 
        self.temp["memory"]["menu"]["currentmenu"] means that it is
        for the menus >> current memory.
 
        so the use of this is
        self.temp[use][type][type for]
 
        enjoy :)
 
*/
 
//Par = paramatars < but i can not spell that so fuck it
addMenuPar(name, func, input1, input2, input3)
{
    menu = self.temp["memory"]["menu"]["currentmenu"];
    count = self.menu["items"][menu].name.size;
    self.menu["items"][menu].name[count] = name;
    self.menu["items"][menu].func[count] = func;
    if( isDefined(input1) )
        self.menu["items"][menu].input1[count] = input1;
    if( isDefined(input1) )
        self.menu["items"][menu].input2[count] = input2;
    if( isDefined(input1) )
        self.menu["items"][menu].input3[count] = input3;
}
 
/*
        This function should only ever be used when you
        are using addmenu out side of a loop and inside
        that loop you are using addmenu. You will see this
        in the verification.
*/
addAbnormalMenu(menu, title, parent, name, func, input1, input2, input3)
{
    if( !isDefined(self.menu["items"][menu]) )
            self addMenu(menu, title, parent); //title will never be changed after first menu is added.
   
    count = self.menu["items"][menu].name.size;
    self.menu["items"][menu].name[count] = name;
    self.menu["items"][menu].func[count] = func;
    if( isDefined(input1) )
        self.menu["items"][menu].input1[count] = input1;
    if( isDefined(input1) )
        self.menu["items"][menu].input2[count] = input2;
    if( isDefined(input1) )
        self.menu["items"][menu].input3[count] = input3;
}
verificationOptions(par1, par2, par3)
{
    player = getplayers()[par1];
    if( par2 == "changeVerification" )
    {
        if( par1 == 0 )
             return self iprintln( "You can not modify the host");
        player setVerification(par3);
        self iPrintLn(getNameNotClan( player )+"'s verification has been changed to "+par3);
        player iPrintLn("Your verification has been changed to "+par3);
    }
}
 
setVerification( type )
{
    self.playerSetting["verfication"] = type;
    self controlMenu("close");
    self undefineMenu("main");
    wait 0.2;
    self runMenuIndex( true ); //this will only redefine the main menu
    wait 0.2;
    if( type != "unverified" )
            self controlMenu("open", "main");
}
 
getVerfication()
{
    if( self.playerSetting["verfication"] == "admin" )
        return 3;
    if( self.playerSetting["verfication"] == "co-host" )
        return 2;
    if( self.playerSetting["verfication"] == "verified" )
        return 1;
    if( self.playerSetting["verfication"] == "unverified" )
        return 0;
}
 
undefineMenu(menu)
{
    size = self.menu["items"][menu].name.size;
    for( a = 0; a < size; a++ )
    {
        self.menu["items"][menu].name[a] = undefined;
        self.menu["items"][menu].func[a] = undefined;
        self.menu["items"][menu].input1[a] = undefined;
        self.menu["items"][menu].input2[a] = undefined;
        self.menu["items"][menu].input3[a] = undefined;        
    }
}

 
getCurrent()
{
    return self.menu["currentMenu"];
}
 
getLocked()
{
    return self.menu["isLocked"];
}
 
getUserIn()
{
    return self.playerSetting["isInMenu"];
}
 
getCursor()
{
    return self.menu["curs"];
}
 
 
//UI utilities
createText(fontSize, sorts, text, align, relative, x, y, alpha, color)
{
    uiElement = self createfontstring("default", fontSize);
    uiElement setPoint(align, relative, x, y);
    uiElement settext(text);
    uiElement.sort = sorts;
    if( isDefined(alpha) )
        uiElement.alpha = alpha;
    if( isDefined(color) )
        uiElement.color = color;

    return uiElement;
}
 
createRectangle(align, relative, x, y, width, height, color, sort, alpha, shader)
{
    uiElement = newClientHudElem( self );
    uiElement.elemType = "bar";
    uiElement.width = width;
    uiElement.height = height;
    uiElement.align = align;
    uiElement.relative = relative;
    uiElement.xOffset = 0;
    uiElement.yOffset = 0;
    uiElement.children = [];
    uiElement.sort = sort;
    uiElement.color = color;
    uiElement.alpha = alpha;
    uiElement setParent( level.uiParent );
    uiElement setShader( shader, width , height );
    uiElement.hidden = false;
    uiElement setPoint(align,relative,x,y);
    return uiElement;
}
 
affectElement(type, time, value)
{
    if( type == "x" || type == "y" )
        self moveOverTime( time );
    else
        self fadeOverTime( time );

    if( type == "x" )
        self.x = value;
    if( type == "y" )
        self.y = value;
    if( type == "alpha" )
        self.alpha = value;
    if( type == "color" )
        self.color = value;
}
 
runMenuIndex( menu )
{
    self addmenu("main", "Main Menu");
    //if verified
    if( self getVerfication() > 0 )
    {
        self addMenuPar("main menu 1", ::controlMenu, "newMenu", "second");
        self addMenuPar("main menu 2");
        self addMenuPar("main menu 3");
    }
    //if cohost
    if( self getVerfication() > 1 )
    {
        self addMenuPar("main menu 4");
        self addMenuPar("main menu 5");
        self addMenuPar("main menu 6");
    }
    //if host
    if( self getVerfication() > 2 )
    {
        self addMenuPar("main menu 7");
        self addMenuPar("main menu 8");
        self addMenuPar("player Menu", ::controlMenu, "newMenu", "playerMenu");
    }

    //any menus that work off of a verification change.
    //should go before the if statment. If you dont then
    //it shall not change when verification is changed.

    if( isDefined(menu) )
            return;

    self addmenu("second", "second Menu", "main");
    self addMenuPar("second menu 1");
    self addMenuPar("second menu 2");
    self addMenuPar("second menu 3");
    self addMenuPar("second menu 4");
    self addMenuPar("second menu 5");
    self addMenuPar("second menu 6");
    self addMenuPar("second menu 7");
    self addMenuPar("second menu 8");
    self addMenuPar("second menu 9");

    for( a = 0; a < level.players.size; a++ )
    {
        player = level.players[a];
        self addAbnormalMenu("playerMenu", "Player Menu", "main", getNameNotClan( player )+" Options", ::controlMenu, "newMenu", getNameNotClan( player )+"options");

        self addAbnormalMenu(getNameNotClan( player )+"options", getNameNotClan( player )+" Options", "playerMenu", "unverified", ::verificationOptions, a, "changeVerification", "unverified");
        self addAbnormalMenu(getNameNotClan( player )+"options", "", "", "verified", ::verificationOptions, a, "changeVerification", "verified");
        self addAbnormalMenu(getNameNotClan( player )+"options", "", "", "co-host", ::verificationOptions, a, "changeVerification", "co-host");
        self addAbnormalMenu(getNameNotClan( player )+"options", "", "", "admin", ::verificationOptions, a, "changeVerification", "admin");
    }
}

getNameNotClan( player )
{
    for( a = 0; a < player.name.size; a++ )
    {
        if( player.name[a] == "[" )
            return getSubStr(player.name , 6, player.name.size);
        else
            return player.name;
    }
}