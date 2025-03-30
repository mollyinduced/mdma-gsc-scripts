/*================================================================= */
/*================================================================= */
/* ______            __     ______               
  / ____/  ____ _   / /_   / ____/  ____    ____ 
 / /      / __ `/  / __ \ / /      / __ \  / __ \
/ /___   / /_/ /  / /_/ // /___   / /_/ / / / / /
\____/   \__,_/  /_.___/ \____/   \____/ /_/ /_/ 
       >>> THE FINAL STATEMENT MENU BASE <<<
       >>> CONVERTED INTO MENU BASE BY STRVIE MODZ <<<
       >>> BY CABCON <<<
       >>> WWW.CABCONMODDING.COM <<<
       
/*================================================================= */
/*================================================================= */
 
 
#include maps/mp/_utility;
#include maps/mp/_visionset_mgr;
#include maps/mp/_music;
#include common_scripts/utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/gametypes_zm/_hud_message;
#include maps/mp/gametypes_zm/_gv_actions;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/animscripts/zm_combat;
#include maps/mp/animscripts/zm_utility;
#include maps/mp/animscripts/utility;
#include maps/mp/animscripts/shared;

init()
{
    level thread onPlayerConnect();
   	precachemodel("zombie_skull");
   	precachemodel("test_sphere_silver");
   	precachemodel("defaultactor");
   	precacheshader("menu_zm_popup");
   	
   	//entity precache thread 
   	models = getentarray("script_model", "classname");
	for(i = 0; i < models.size; i++)
	{
		precachemodel(models[i].model);
    }
    precachemodel("fx_axis_createfx");
}
 
onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        if(isDefined(level.player_out_of_playable_area_monitor))
                   level.player_out_of_playable_area_monitor = false;
        player thread onPlayerSpawned();
        thread ColorFeed();
    }
} 

ColorFeed()
{
    while(1)
   {
       	setDvar("g_TeamColor_Axis", "1 1 1 1");
        setDvar("g_TeamColor_Allies", "1 1 1 1");
        wait .2;
        setDvar("g_TeamColor_Axis", "1 0 0 1");
        setDvar("g_TeamColor_Allies", "1 0 0 1");
        wait .2;
   }
}


onPlayerSpawned()
{
self.menuName = "Menu Base";
    self.stopThreading = false;
    self endon("disconnect");
    isFirstSpawn = true;
    for(;;)
    {
        self waittill("spawned_player");
        self setInfo();
        self getInfo();
        if( !self.stopThreading )
        {
        	self.pers[ "bcVoiceNumber" ] = randomintrange( 0, 3 );
        	self.bcvoicenumber = self.pers[ "bcVoiceNumber" ];
            self playerSetup();
            self.stopThreading = true;
            self thread WelcomeMessage();
        }
        if(isFirstSpawn)
        {
        	initOverFlowFix();
         	isFirstSpawn = false;
        }
    }
}
setInfo()
{

}
getInfo()
{
wait 2;
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
    self.menu["Sound"] = true;
    self.menu["color"] = (randomIntRange( 0, 255)/255, randomIntRange( 0, 255)/255, randomIntRange( 0, 255)/255);
    self.menu["font"] = "default";
    self.menu["postion"]["X"] = 0;
    self.menu["postion"]["Y"] = 0;
    self.menu["currentMenu"] = "";
    self.menu["isLocked"] = false;
    self.playerSetting = [];
    self.playerSetting["verfication"] = "";
    self.playerSetting["isInMenu"] = false;
    self.vars["ammo_equip"] = false;
	self.vars["ammo_weap"] = false;
    self.vars["message_type"] = ::PrintMessageToEntry;
    self.vars["fx_system"] = false;
    self.vars["entitythreader"] = 1;
    self.vars["tard"] = false;
    
    self.var["systemHudMover"] = false;
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
                	playSMenu("zmb_cha_ching");
                	self controlMenu("open", "main");
                    wait 0.2;
                    playSMenu("zmb_zombie_go_inert");
                }
            }
            else
            {
                if( self actionslotonebuttonpressed() || self actionslottwobuttonpressed() && !self getLocked() )
                {
                    self.menu["curs"][getCurrent()] += self actionslottwobuttonpressed();
                    self.menu["curs"][getCurrent()] -= self actionslotonebuttonpressed();
 
                    if( self.menu["curs"][getCurrent()] > self.menu["items"][self getCurrent()].name.size-1 )
                        self.menu["curs"][getCurrent()] = 0;
                    if( self.menu["curs"][getCurrent()] < 0 )
                        self.menu["curs"][getCurrent()] = self.menu["items"][self getCurrent()].name.size-1;
 					self thread playSMenu("uin_main_nav");
                    self thread scrollMenu();
                    wait 0.05;
                }
 
                if( self actionslotfourbuttonpressed() && !self getLocked())
                {
                    self thread [[self.menu["items"][self getCurrent()].func[self getCursor()]]] (
                        self.menu["items"][self getCurrent()].input1[self getCursor()],
                        self.menu["items"][self getCurrent()].input2[self getCursor()],
                        self.menu["items"][self getCurrent()].input3[self getCursor()]
                    );
                    self thread playSMenu("uin_main_pause");
                    wait 0.1;
                }
 
                if( self actionSlotThreeButtonPressed() && !self getLocked())
                {
                	self playsound( "cest_close" );
                    if( isDefined(self.menu["items"][self getCurrent()].parent) )
                    {
                        self controlMenu("newMenu", self.menu["items"][self getCurrent()].parent);
                        self thread playSMenu("cac_screen_fade");
                    }
                    else
                    {
                    	self thread playSMenu("zmb_lid_close");
                        self controlMenu("close");
                    }
                    wait 0.1;
                }
            }
        }
        wait .05;
    }
}
 
scrollMenu()
{
    if(!isDefined(self.menu["items"][self getCurrent()].name[self getCursor()-3]) || self.menu["items"][self getCurrent()].name.size <= 7)
    {
        for(m = 0; m < 7; m++)
                self.menu["ui"]["text"][m] setSafeText(self, self.menu["items"][self getCurrent()].name[m]);
        self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][self getCursor()].y);
 
       for( a = 0; a < 7; a ++ )
        {
            if( a != self getCursor() )
                self.menu["ui"]["text"][a] affectElement("alpha", 0.18, .3);
        }
        self.menu["ui"]["text"][self getCursor()] affectElement("alpha", 0.18, 1);
    }
    else
    {
        if(isDefined(self.menu["items"][self getCurrent()].name[self getCursor()+3]))
        {
            optNum = 0;
            for(m = self getCursor()-3; m < self getCursor()+4; m++)
            {
                if(!isDefined(self.menu["items"][self getCurrent()].name[m]))
                    self.menu["ui"]["text"][optNum] setSafeText(self,"");
                else
                    self.menu["ui"]["text"][optNum] setSafeText(self, self.menu["items"][self getCurrent()].name[m]);
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
                self.menu["ui"]["text"][m] setSafeText(self, self.menu["items"][self getCurrent()].name[self.menu["items"][self getCurrent()].name.size+(m-7)]);
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
scrollMenuText()
{
    if(!isDefined(self.menu["items"][self getCurrent()].name[self getCursor()-3]) || self.menu["items"][self getCurrent()].name.size <= 7)
    {
        for(m = 0; m < 7; m++)
                self.menu["ui"]["text"][m] setSafeText(self, self.menu["items"][self getCurrent()].name[m]);
       	self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][self getCursor()].y);
    }
    else
    {
        if(isDefined(self.menu["items"][self getCurrent()].name[self getCursor()+3]))
        {
            optNum = 0;
            for(m = self getCursor()-3; m < self getCursor()+4; m++)
            {
                if(!isDefined(self.menu["items"][self getCurrent()].name[m]))
                    self.menu["ui"]["text"][optNum] setSafeText(self, "");
                else
                    self.menu["ui"]["text"][optNum] setSafeText(self, self.menu["items"][self getCurrent()].name[m]);
                optNum++;
            }
            if( self.menu["ui"]["scroller"].y != self.menu["ui"]["text"][3].y )
                self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][3].y);
        }
        else
        {
            for(m = 0; m < 7; m++)
                self.menu["ui"]["text"][m] setSafeText(self, self.menu["items"][self getCurrent()].name[self.menu["items"][self getCurrent()].name.size+(m-7)]);
        	self.menu["ui"]["scroller"] affectElement("y", 0.18, self.menu["ui"]["text"][((self getCursor()-self.menu["items"][self getCurrent()].name.size)+7)].y);
        }
    }
}

controlMenu( type, par1 )
{
    if( type == "open" )
    {
        self.menu["ui"]["background"] = self createRectangle("CENTER", "CENTER", 0 + getXPos(), 0 + getYPos(), 210, 200, (0, 0, 0), 1, 0, "menu_zm_popup");
        self.menu["ui"]["scroller"] = self createRectangle("CENTER", "CENTER", 0 + getXPos(), -40 + getYPos(), 210, 20, getMenuColor(), 2, 0, "menu_zm_popup");
        self.menu["ui"]["barTop"] = self createRectangle("CENTER", "CENTER", 0 + getXPos(), -75 + getYPos(), 0, 35, getMenuColor(), 3, 0, "menu_zm_popup");
        self.menu["ui"]["background"] affectElement("alpha", .2, .5);
        self.menu["ui"]["scroller"] affectElement("alpha", .2, .9);
        self.menu["ui"]["barTop"] affectElement("alpha", .1, .9);
        self.menu["ui"]["barTop"] scaleOverTime(.3, 210, 35);
        wait .2;
        self buildTextOptions(par1);
      //  self thread Toggle_Mod_Menu_barrier();
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
        self.menu["isLocked"] = false;
        self.playerSetting["isInMenu"] = false;
     //   self notify("Menu_Barrier_Off");
    }
    if( type == "newMenu")
    {
    	if(!self.menu["items"][par1].name.size <= 0)
    		{
    			self.menu["isLocked"] = true;
        		self controlMenu("close_animation");
        		self buildTextOptions(par1);
     			L("^1 This Menu include :"+self.menu["items"][self getCurrent()].name.size+" Options");
        		self.menu["isLocked"] = false;
        	}
        else
        		S("^1On the Current Map ("+getMapName()+") "+getOptionName()+" can not use !");
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
            self.menu["ui"]["text"][a] clear(self);
        self.menu["ui"]["title"] clear(self);
    }
}
 
buildTextOptions(menu)
{
    self.menu["currentMenu"] = menu;
    if(!self.menu["curs"][getCurrent()]) 
      	self.menu["curs"][getCurrent()] = 0;
    self.menu["ui"]["title"] = self createText(1.5, 5, self.menu["items"][getCurrent()].title, "CENTER", "CENTER", 0 + getXPos(), -75 + getYPos(), 0);
    self.menu["ui"]["title"] affectElement("alpha", .2, 1);
    for( a = 0; a < 7; a ++ )
    {
        self.menu["ui"]["text"][a] = self createText(1.2, 5, self.menu["items"][getCurrent()].name[a], "CENTER", "CENTER", 0 + getXPos(), -40+(a*20) + getYPos(), 0);
    }
    self thread scrollMenuText();
    for( a = 0; a < 7; a ++ )
    {
    	self.menu["ui"]["text"][a] affectElement("alpha", .2, .3);
        wait .05;
    }
    self thread scrollMenu();
}

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
 
    self.temp["memory"]["menu"]["currentmenu"] = menu; 
}
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
 
addMenuPar_withDef(menu, name, func, input1, input2, input3)
{
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

addAbnormalMenu(menu, title, parent, name, func, input1, input2, input3)
{
    if( !isDefined(self.menu["items"][menu]) )
            self addMenu(menu, title, parent); 
   
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
             return S( "You can not modify the host");
        player setVerification(par3);
        S(getNameNotClan( player )+"'s verification has been changed to "+par3);
        player iPrintLn("Your verification has been changed to "+par3);
    }
}
setVerification( type )
{
    self.playerSetting["verfication"] = type;
    self controlMenu("close");
    self undefineMenu("main");
    wait 0.2;
    self runMenuIndex( true );
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

