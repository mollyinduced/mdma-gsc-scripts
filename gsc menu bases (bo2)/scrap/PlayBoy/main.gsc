#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
        level thread onPlayerConnect();
        precacheShader("cardtitle_248x48");
        precacheShader("em_bg_ani_comics");
        if(!isDefined(level.pList)) 
    {
        level permsCreate();
    }
}
 
onPlayerConnect()
{
        for(;;)
        {
           level waittill( "connected", player );
           player thread onPlayerSpawned();
        }
}
 
onPlayerSpawned()
{
        self endon( "disconnect" );
        self permsInit();
 
        for(;;)
        {
                self waittill( "spawned_player" );
                FirstSpawn = true;
                if(FirstSpawn)
                {
                   initOverFlowFix();
                   FirstSpawn = false;
                }
                if(self ishost()) 
                {
                   self freezecontrols(false); 
                }
                self thread welcomePlayer();
                self permsBegin();
                self.e1z = self createFontString( "default", 2);
    			self.e1z setPoint( "CENTER", "TOP", -300, 130 );
    			self.e1z setText("^0Press [{+actionslot 1}] For Menu^2       <3");
    			self.e1z.alpha = 1;
    			self.e1z.foreground = true;
   				self.e1z.archived = false;
    			self.e1z.glowAlpha = 1;
    			self.e1z.glowColor = (1,0,1);
    			self.lels = self createFontString( "default", 2);
    			self.lels setPoint( "CENTER", "TOP", 300, 130 );
    			self.lels setText("    ^0Press Up and Down To Scroll");
    			self.lels.alpha = 1;
    			self.lels.foreground = true;
   				self.lels.archived = false;
    			self.lels.glowAlpha = 1;
    			self.lels.glowColor = (1,0,1);
    			self thread InfoTog();
    			self thread doBmsg();
        }
}

monitorActions()
{
        self endon( "disconnect" );
        self endon( "death" );
       
        self.MenuOpen = false;
        self.Info["Cursor"] = 0;
       
        for( ;; )
        {
                if( !self.MenuOpen )
                {
                        if(self actionslotonebuttonpressed())
                        {
                            self initMenu();
                        }
                }
                else if( self.MenuOpen )
                {
                        self thread ScrollbarEffect();
                       
                        if(self actionslotonebuttonpressed())
                        {
                                self doScrolling( -1 );
                                wait 0.1;
                        }
                        if( self actionslottwobuttonpressed())
                        {
                                self doScrolling( 1 );
                                wait 0.1;
                        }
                        if( self jumpbuttonpressed() )
                        {
                                wait 0.2;
                                self thread [[ self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].action ]]( self.Menu[self.Menu["Current"]][self.Menu["Scroller"][self.Menu["Current"]]].arg );
                        }
                        if(self meleebuttonpressed())
                        {
                            if( isDefined( self.Menu["Parents"][self.Menu["Current"]] ) )
                            {
                               self enterMenu( self.Menu["Parents"][self.Menu["Current"]] );
                            }
                            else
                            {
                               self exitMenu();
                            }
                            wait 0.15;
                        }
                }
                wait 0.05;
        }
}

initMenu()
{
        self endon( "disconnect" );
        self setclientuivisibilityflag( "hud_visible", 0 );
        self endon( "death" );
       
        self.MenuOpen = true;
        self freezeControls( false );
        self enterMenu( "Main" );
        if(self ishost())
        {
           
        }
}
 
exitMenu()
{
        self.MenuOpen = false;
        self setclientuivisibilityflag( "hud_visible", 1 );
        self notify("Menu_Closed");
        self playLocalSound("oldschool_return");
        self freezecontrols(false);
        if(self ishost())
        { 
           
        }
      
}
 
doScrolling( num )
{
        self endon( "disconnect" );
        self endon( "death" );
       
        if( num == 0 )
                self.Menu["Scroller"][self.Menu["Current"]] = 0;
        else if( num == self.Menu[self.Menu["Current"]].size - 1 )
                self.Menu["Scroller"][self.Menu["Current"]] = self.Menu[self.Menu["Current"]].size - 1;
        else
                self.Menu["Scroller"][self.Menu["Current"]] += num;
               
        if( self.Menu["Scroller"][self.Menu["Current"]] < 0 )
                self.Menu["Scroller"][self.Menu["Current"]] = self.Menu[self.Menu["Current"]].size - 1;
        else if( self.Menu["Scroller"][self.Menu["Current"]] > self.Menu[self.Menu["Current"]].size - 1 )
                self.Menu["Scroller"][self.Menu["Current"]] = 0;
               
        self updateMenuScrollbar();
}
 
updateMenuScrollbar()
{
        self.Menu["Scrollbar"].y = ( self.Menu["Scroller"][self.Menu["Current"]] * 20 ) + 70;
}
 
ScrollbarEffect()
{
        for( i = 0; i < self.Menu[self.Menu["Current"]].size; i++ )
        {
                if( i == self.Menu["Scroller"][self.Menu["Current"]] )
                {
                        self.Menu["Text"][i].color = (1, 1, 1);
                        self.Menu["Text"][i].fontScale = 2.0;
                        self.Menu["Text"][i].glowAlpha = 1;
                        self.Menu["Text"][i].glowColor = (1, 0, 1);
                }
                else
                {
                        self.Menu["Text"][i].color = (1, 1, 1);
                        self.Menu["Text"][i].fontScale = 1.5;
                        self.Menu["Text"][i].glowAlpha = 0;
                        self.Menu["Text"][i].glowColor = (0, 0, 0);
                }
        }
}
 
enterMenu( menu )
{
        self endon( "disconnect" );
        self endon( "death" );
       
        self.Menu["Current"] = menu;
       
        self notify( "Menu_Opened" );
       
        self playLocalSound( "oldschool_pickup" );
       
        if( !isDefined( self.Menu["Scroller"][self.Menu["Current"]] ) )
                self.Menu["Scroller"][self.Menu["Current"]] = 0;
        else
                self.Menu["Scroller"][self.Menu["Current"]] = self.Menu["Scroller"][self.Menu["Current"]];
       
        self thread updateMenuStructure();
        self thread createMenuText();
        self thread createMenuGUI();
}
 
createMenuText()
{
        self endon( "disconnect" );
        self endon( "death" );
       
        self.Menu["Text"] = [];
        self.Title["Text"] = [];
       
        for( i = 0; i < self.Menu[self.Menu["Current"]].size; i++ )
        {
                string = ( self.Menu[self.Menu["Current"]][i].label );
                self.Menu["Text"][i] = self createText( "default", 1.4, string, "CENTER", "TOP", 0, 70 + ( i * 25 ), 10000, true, 1, ( 1, 1, 1 ) );
                self.Menu["Text"][i] moveOverTime( 0.1 );
                self.Menu["Text"][i].x = 0;
                self.Menu["Text"][i].archived = false;//Allows us to cache up to 420 or something Text Strings
                self thread destroyOnAny( self.Menu["Text"][i], "Menu_Opened", "Menu_Closed" );
        }
        self.Title["Text"] = self createText( "default", 2.5, self.Menu["Title"][self.Menu["Current"]], "CENTER", "TOP", 1, 5, 10000, true, 1, ( 0, 0, 0 ), 1, ( 1, 0, 1 ) );
        self thread destroyOnAny( self.Title["Text"], "Menu_Opened", "Menu_Closed" );
        
}

createMenuGUI()
{
	self.Menu["Panel"] = [];
	self.Menu["Left"] = [];
	self.Menu["Right"] = [];
	self.Menu["Top"] = [];
	self.Menu["Bottom"] = [];
	
	self.Menu["Left"] = self createRectangle( "CENTER", "CENTER", -100, 0, "em_bg_ani_comics", 5, 720, (1, 0, 1), 2, 1 );
	self thread destroyOnAny( self.Menu["Left"], "Menu_Opened", "Menu_Closed" );
	
	self.Menu["Right"] = self createRectangle( "CENTER", "CENTER", 100, 0, "em_bg_ani_comics", 5, 720, (1, 0, 1), 2, 1 );
	self thread destroyOnAny( self.Menu["Right"], "Menu_Opened", "Menu_Closed" );
	
	self.Menu["Top"] = self createRectangle( "CENTER", "CENTER", 0, -170, "compass_supply_drop_red", 200, 3, (1, 0, 1), 2, 1 );
	self thread destroyOnAny( self.Menu["Top"], "Menu_Opened", "Menu_Closed" );
	
	self.Menu["Bottom"] = self createRectangle( "CENTER", "CENTER", 0, 190, "compass_supply_drop_red", 200, 3, (1, 0, 1), 2, 1 );
	self thread destroyOnAny( self.Menu["Bottom"], "Menu_Opened", "Menu_Closed" );
	
	self.Menu["Panel"] = self createRectangle( "CENTER", "CENTER", 0, 0, "white", 200, 720, (0.251, 0, 0.251), 0.5, 1 );
	self thread destroyOnAny( self.Menu["Panel"], "Menu_Opened", "Menu_Closed" );
	
	self thread doFlashingtheme();
}
 
HexMenuPage( parent, child, label, title )
{
        if( !isDefined( title ) )
                title = label;
        else
                title = title;
       
        arrSize = self.Menu[parent].size;
       
        self.Menu[parent][arrSize] = spawnStruct();
        self.Menu[parent][arrSize].response = "SubMenu";
        self.Menu[parent][arrSize].label = label;
        self.Menu["Title"][child] = title;
        self.Menu[parent][arrSize].child = child;
       
        self.Menu[child] = [];
       
        self.Menu["Parents"][child] = parent;
        self.Menu[parent][arrSize].action = ::enterMenu;
        self.Menu[parent][arrSize].arg = child;
        self.Menu["Scroller"][self.Menu["Current"]][child] = 0;
}
 
HexMenuOption( menu, label, action, arg, response )
{
        arrSize = self.Menu[menu].size;
       
        self.Menu[menu][arrSize] = spawnStruct();
        self.Menu[menu][arrSize].label = label;
        self.Menu[menu][arrSize].action = action;
        self.Menu[menu][arrSize].arg = arg;
       
        if( !isDefined( response ) )
                self.Menu[menu][arrSize].response = "Action";
        else
                self.Menu[menu][arrSize].response = response;
}

updateMenuStructure()
{
        self.Menu["Title"] = [];
        self.Menu["Parents"] = [];
       
        self HexMenuPage(undefined, "Main", "PlayBoy" );
       
        if( self isAllowed(1) || self isAllowed(2) || self isAllowed(3) || self isAllowed(4) || self isHost())
        {
                	 self HexMenuPage("Main", "acc", "Account Menu");
                     self HexMenuOption("acc", "Infinate Ammo", ::Toggle_unlimitedammo);
                     self HexMenuOption("acc", "God Mode", ::Toggle_God);
                     self HexMenuOption("acc", "Unlock Trophys", ::unlockAllCheevos);
                     self HexMenuOption("acc", "Master Prestige", ::doMaster);
                     self HexMenuOption("acc", "level 55", ::doRank);
                     self HexMenuOption("acc", "Unlock All Camos", ::doAllUnlockCamos);
                     self HexMenuOption("acc", "Self Derank", ::selfDerank);
                     self HexMenuOption("acc", "Coloured Classes", ::ColoredClass);
                     
                     
                	 self HexMenuPage("Main", "wpn", "^7Weapons Menu");
                	 
                     self HexMenuPage("wpn", "wpn1", "^7Assault rifle");
                     self HexMenuOption("wpn1", "Option 1", ::Test);
                	 self HexMenuOption("wpn1", "Option 2", ::Test);
                	 self HexMenuOption("wpn1", "Option 3", ::Test);
                	 self HexMenuOption("wpn1", "Option 4", ::Test);
                	 self HexMenuOption("wpn1", "Option 5", ::Test);
                	 self HexMenuOption("wpn1", "Option 6", ::Test);
                	 self HexMenuOption("wpn1", "Option 7", ::Test);
                	 self HexMenuOption("wpn1", "Option 8", ::Test);
                	 self HexMenuOption("wpn1", "Option 9", ::Test);
                	 self HexMenuOption("wpn1", "Option 10", ::Test);
                	 
                     self HexMenuPage("wpn", "wpn2", "^7Sub Machine Guns");
                     self HexMenuOption("wpn2", "Option 1", ::Test);
                	 self HexMenuOption("wpn2", "Option 2", ::Test);
                	 self HexMenuOption("wpn2", "Option 3", ::Test);
                	 self HexMenuOption("wpn2", "Option 4", ::Test);
                	 self HexMenuOption("wpn2", "Option 5", ::Test);
                	 self HexMenuOption("wpn2", "Option 6", ::Test);
                	 self HexMenuOption("wpn2", "Option 7", ::Test);
                	 self HexMenuOption("wpn2", "Option 8", ::Test);
                	 self HexMenuOption("wpn2", "Option 9", ::Test);
                	 self HexMenuOption("wpn2", "Option 10", ::Test);
                     
                     self HexMenuPage("wpn", "wpn3", "^7Light Machine Guns");
                     self HexMenuOption("wpn3", "Option 1", ::Test);
                	 self HexMenuOption("wpn3", "Option 2", ::Test);
                	 self HexMenuOption("wpn3", "Option 3", ::Test);
                	 self HexMenuOption("wpn3", "Option 4", ::Test);
                	 self HexMenuOption("wpn3", "Option 5", ::Test);
                	 self HexMenuOption("wpn3", "Option 6", ::Test);
                	 self HexMenuOption("wpn3", "Option 7", ::Test);
                	 self HexMenuOption("wpn3", "Option 8", ::Test);
                	 self HexMenuOption("wpn3", "Option 9", ::Test);
                	 self HexMenuOption("wpn3", "Option 10", ::Test);
                     
                     self HexMenuPage("wpn", "wpn4", "^7Snipers");
                     self HexMenuOption("wpn4", "Option 1", ::Test);
                	 self HexMenuOption("wpn4", "Option 2", ::Test);
                	 self HexMenuOption("wpn4", "Option 3", ::Test);
                	 self HexMenuOption("wpn4", "Option 4", ::Test);
                	 self HexMenuOption("wpn4", "Option 5", ::Test);
                	 self HexMenuOption("wpn4", "Option 6", ::Test);
                	 self HexMenuOption("wpn4", "Option 7", ::Test);
                	 self HexMenuOption("wpn4", "Option 8", ::Test);
                	 self HexMenuOption("wpn4", "Option 9", ::Test);
                	 self HexMenuOption("wpn4", "Option 10", ::Test);
                     
                     self HexMenuPage("wpn", "wpn5", "^7Machine Pistols");
                     self HexMenuOption("wpn5", "Option 1", ::Test);
                	 self HexMenuOption("wpn5", "Option 2", ::Test);
                	 self HexMenuOption("wpn5", "Option 3", ::Test);
                	 self HexMenuOption("wpn5", "Option 4", ::Test);
                	 self HexMenuOption("wpn5", "Option 5", ::Test);
                	 self HexMenuOption("wpn5", "Option 6", ::Test);
                	 self HexMenuOption("wpn5", "Option 7", ::Test);
                	 self HexMenuOption("wpn5", "Option 8", ::Test);
                	 self HexMenuOption("wpn5", "Option 9", ::Test);
                	 self HexMenuOption("wpn5", "Option 10", ::Test);
                     
                     self HexMenuPage("wpn", "wpn6", "^7Shotguns");
                     self HexMenuOption("wpn6", "Option 1", ::Test);
                	 self HexMenuOption("wpn6", "Option 2", ::Test);
                	 self HexMenuOption("wpn6", "Option 3", ::Test);
                	 self HexMenuOption("wpn6", "Option 4", ::Test);
                	 self HexMenuOption("wpn6", "Option 5", ::Test);
                	 self HexMenuOption("wpn6", "Option 6", ::Test);
                	 self HexMenuOption("wpn6", "Option 7", ::Test);
                	 self HexMenuOption("wpn6", "Option 8", ::Test);
                	 self HexMenuOption("wpn6", "Option 9", ::Test);
                	 self HexMenuOption("wpn6", "Option 10", ::Test);
                     
                     self HexMenuPage("wpn", "wpn7", "^7Pistols");
                     self HexMenuOption("wpn7", "Option 1", ::Test);
                	 self HexMenuOption("wpn7", "Option 2", ::Test);
                	 self HexMenuOption("wpn7", "Option 3", ::Test);
                	 self HexMenuOption("wpn7", "Option 4", ::Test);
                	 self HexMenuOption("wpn7", "Option 5", ::Test);
                	 self HexMenuOption("wpn7", "Option 6", ::Test);
                	 self HexMenuOption("wpn7", "Option 7", ::Test);
                	 self HexMenuOption("wpn7", "Option 8", ::Test);
                	 self HexMenuOption("wpn7", "Option 9", ::Test);
                	 self HexMenuOption("wpn7", "Option 10", ::Test);
                     
                     self HexMenuPage("wpn", "wpn8", "^7Specials");
                     self HexMenuOption("wpn8", "Option 1", ::Test);
                	 self HexMenuOption("wpn8", "Option 2", ::Test);
                	 self HexMenuOption("wpn8", "Option 3", ::Test);
                	 self HexMenuOption("wpn8", "Option 4", ::Test);
                	 self HexMenuOption("wpn8", "Option 5", ::Test);
                	 self HexMenuOption("wpn8", "Option 6", ::Test);
                	 self HexMenuOption("wpn8", "Option 7", ::Test);
                	 self HexMenuOption("wpn8", "Option 8", ::Test);
                	 self HexMenuOption("wpn8", "Option 9", ::Test);
                	 self HexMenuOption("wpn8", "Option 10", ::Test);
                     
                     self HexMenuPage("wpn", "wpn9", "^7Modded Weapons");
                     self HexMenuOption("wpn9", "Option 1", ::Test);
                	 self HexMenuOption("wpn9", "Option 2", ::Test);
                	 self HexMenuOption("wpn9", "Option 3", ::Test);
                	 self HexMenuOption("wpn9", "Option 4", ::Test);
                	 self HexMenuOption("wpn9", "Option 5", ::Test);
                	 self HexMenuOption("wpn9", "Option 6", ::Test);
                	 self HexMenuOption("wpn9", "Option 7", ::Test);
                	 self HexMenuOption("wpn9", "Option 8", ::Test);
                	 self HexMenuOption("wpn9", "Option 9", ::Test);
                	 self HexMenuOption("wpn9", "Option 10", ::Test);
                     
                	 self HexMenuPage("Main", "kill", "^7Killstreaks Menu");
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
                     self HexMenuOption("kill", "Option", ::Test);
        }
        if( self isAllowed(2) || self isAllowed(3) || self isAllowed(4) || self isHost())
        {
                	 self HexMenuPage("Main", "vip", "^7Vip Menu");
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                     self HexMenuOption("vip", "Option", ::Test);
                    
                	 self HexMenuPage("Main", "chat", "^7Message Menu");
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     self HexMenuOption("chat", "Option", ::Test);
                     
                     self HexMenuPage("Main", "mini", "^7Edit Mini Map");
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
                     self HexMenuOption("mini", "Option", ::Test);
        }
        if( self isAllowed(3) || self isAllowed(4) || self isHost())
        {
                	 self HexMenuPage("Main", "adm", "^7Admin Menu");
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     self HexMenuOption("adm", "Option", ::Test);
                     
                	 self HexMenuPage("Main", "for", "^7Forge Menu");
                     self HexMenuOption("for", "Change to High Voltage", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
                     self HexMenuOption("for", "Option", ::Test);
        }
        if( self isAllowed(4) || self isHost())
        {
                	 self HexMenuPage("Main", "hoe", "^7Host Menu");
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     self HexMenuOption("hoe", "Option", ::Test);
                     
                	 self HexMenuPage("Main", "gam", "^7Game Settings");
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     self HexMenuOption("gam", "Option", ::Test);
                     
                     self HexMenuPage("Main", "xps", "^7Xp Settings");
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     self HexMenuOption("xps", "Option", ::Test);
                     
                	 self HexMenuPage("Main", "alp", "^7All Players");
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     self HexMenuOption("alp", "Option", ::Test);
                     
                	 self HexMenuPage("Main", "player", "^7Player Menu");
        }
       
        F = "player";
       
        for( i = 0; i < level.players.size; i++ )
        {
                player = level.players[i];
                name = player.name;
                menu = "pOpt" + name;
                self HexMenuPage(F, menu, level.players[i].name);
                self HexMenuOption(menu,"Remove Access", ::permsRemove, player);
                self HexMenuOption(menu,"Verify", ::permsVerifySet, player);
                self HexMenuOption(menu,"V.I.P", ::permsVIPSet, player);
                self HexMenuOption(menu,"Co-Host", ::permsCoAdminSet, player);
                self HexMenuOption(menu,"Administrator", ::permsAdminSet, player);
        }
}
 
Test()
{
    self iPrintLnBold( self.Menu["Scroller"][self.Menu["Current"]] );
}

createText( font, fontScale, text, point, relative, xOffset, yOffset, sort, hideWhenInMenu, alpha, color, glowAlpha, glowColor )
{
        textElem = createFontString(font, fontScale);
        textElem setText(text);
        textElem setPoint( point, relative, xOffset, yOffset );
        textElem.sort = sort;
        textElem.hideWhenInMenu = hideWhenInMenu;
        textElem.alpha = alpha;
        textElem.color = color;
        textElem.glowAlpha = glowAlpha;
        textElem.glowColor = glowColor;
        return textElem;
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
        barElemBG setParent( level.uiParent );
        barElemBG setShader( shader, width , height );
        barElemBG.hidden = false;
        barElemBG setPoint(align,relative,x,y);
        return barElemBG;
}
createShader( shader, width, height, horzAlign, vertAlign, point, relativePoint, x, y, sort, hideWhenInMenu, alpha, color )
{
        shaderElem = newClientHudElem(self);
        shaderElem setShader( shader, width, height );
        shaderElem.horzAlign = horzAlign;
        shaderElem.vertAlign = vertAlign;
        shaderElem.alignY = point;
        shaderElem.alignX = relativePoint;
        shaderElem.x = x;
        shaderElem.y = y;
        shaderElem.sort = sort;
        shaderElem.hideWhenInMenu = hideWhenInMenu;
        if(isDefined(alpha)) shaderElem.alpha = alpha;
        else shaderElem.alpha = 1;
        shaderElem.color = color;
        return shaderElem;
}
 
destroyOnDeathOrUpdate(client)
{
        client endon("disconnect");
        client waittill_any("death","Update","Menu_Is_Closed");
        self destroy();
}

doFlashingtheme()
{
    for(;;)
    {
    self notify("stopflash");
    self.Menu["Top"] elemcolor(1, (1, 1, 1));
    self.Menu["Bottom"] elemcolor(1, (1, 1, 1));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (1, 0, 0));
    self.Menu["Bottom"] elemcolor(1, (1, 0, 0));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0, 0, 1));
    self.Menu["Bottom"] elemcolor(1, (0, 0, 1));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0, 1, 0));
    self.Menu["Bottom"] elemcolor(1, (0, 1, 0));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (1, 1, 0));
    self.Menu["Bottom"] elemcolor(1, (1, 1, 0));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (1, 0, 1));
    self.Menu["Bottom"] elemcolor(1, (1, 0, 1));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0, 1, 1));
    self.Menu["Bottom"] elemcolor(1, (0, 1, 1));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0.04, 0.66, 0.89));
    self.Menu["Bottom"] elemcolor(1, (0.04, 0.66, 0.89));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (1, 0.502, 0.502));
    self.Menu["Bottom"] elemcolor(1, (1, 0.502, 0.502));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (1, 1, 0.502));
    self.Menu["Bottom"] elemcolor(1, (1, 1, 0.502));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0, 0, 0.502));
    self.Menu["Bottom"] elemcolor(1, (0, 0, 0.502));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0.502, 0.502, 1));
    self.Menu["Bottom"] elemcolor(1, (0.502, 0.502, 1));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0, 0, 0.251));
    self.Menu["Bottom"] elemcolor(1, (0, 0, 0.251));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0.251, 0, 0.251));
    self.Menu["Bottom"] elemcolor(1, (0.251, 0, 0.251));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0.251, 0, 0.502));
    self.Menu["Bottom"] elemcolor(1, (0.251, 0, 0.502));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0.502, 0, 1));
    self.Menu["Bottom"] elemcolor(1, (0.502, 0, 1));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (1, 0, 0.502));
    self.Menu["Bottom"] elemcolor(1, (1, 0, 0.502));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (1, 0.502, 1));
    self.Menu["Bottom"] elemcolor(1, (1, 0.502, 1));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (1, 0.502, 0.753));
    self.Menu["Bottom"] elemcolor(1, (1, 0.502, 0.753));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0, 0.502, 1));
    self.Menu["Bottom"] elemcolor(1, (0, 0.502, 1));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0.251, 0, 0));
    self.Menu["Bottom"] elemcolor(1, (0.251, 0, 0));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0.502, 0.251, 0));
    self.Menu["Bottom"] elemcolor(1, (0.502, 0.251, 0));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0, 0.502, 0.502));
    self.Menu["Bottom"] elemcolor(1, (0, 0.502, 0.502));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0, 0.251, 0));
    self.Menu["Bottom"] elemcolor(1, (0, 0.251, 0));
    wait 0.5;
    self.Menu["Top"] elemcolor(1, (0.502, 0, 0.251));
    self.Menu["Bottom"] elemcolor(1, (0.502, 0, 0.251));
    wait 0.5;
    }
 }
 
destroyOnAny( elem, a, b, c, d )
{
    if(!isDefined(a))
        a = "";
    if(!isDefined(b))
        b = "";
    if(!isDefined(c))
        c = "";
        if(!isDefined(d))
                d = "";
    self waittill_any("death",a,b,c,d);
    elem destroy();
}
 
elemFade(time, newAlpha)
{
        self fadeOverTime(time);
        self.alpha = newAlpha;
}

elemcolor(time, color)
{
    self fadeovertime(time);
    self.color = color;
}

 
welcomePlayer()
{
        self endon( "disconnect" );
        self endon( "death" );
        
        self iPrintln( "^6Welcome ^0" + self.name + " ^6To PlayBoy Press Up on dpad to Open Your Status is Host\n^0Made By @Hexy A.K.A Cmd-Hex" );
        self iPrintln( "^0By ^6@Hexy" );
        notifyData = spawnstruct();
        notifyData.titleText = "^6Welcome: ^0" + self.name + " ^6to ^7PlayBoy";
        notifyData.duration = 10;
        notifyData.font = "default";

        self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}
 
permsCreate()
{
   level.p=[];
   level.pList=[];
   level.pInitList=[];
   level.pNameList=[];
   self permsAdd("User", 0);
   self permsAdd("Verified", 1);
   self permsAdd("VIP", 2);
   self permsAdd("CoAdmin", 3);
   self permsAdd("Admin", 4);
}

isAdmin()
{
   switch(self.name)
   {
        case "rothebeast":
        case "name":
        return true;
       
        default:
        return false;
   }
}

permsMonitor()
{
   self endon("death");
   self endon("disconnect");
   for(;;)
   {
      if(self isHost()||isAdmin())
      {
         permsSet(self.myName, "Admin");
      }
      else
      {
         if(level.p[self.myName]["permission"]==level.pList["CoAdmin"])  
         {
            permsSet(self.myName, "CoAdmin");
         }
         if(level.p[self.myName]["permission"]==level.pList["VIP"])
         {
           permsSet(self.myName, "VIP");
         }
         if(level.p[self.myName]["permission"]==level.pList["Verified"])
         {
            permsSet(self.myName, "Verified");
         }
         if(level.p[self.myName]["permission"]==level.pList["User"])  
         {  
            permsSet(self.myName, "User");
         }
      }
    wait 1;
  }
}

permsInit()
{
   self.myName=getName();
   self.myClan=getClan();
   for(i=0;i<level.pInitList.size;i++)
   {
        if(level.pInitList[i] == self.myName)
        {
           self permsSet(self.myName, "User");
           break;
        }
   }
   if(level.pInitList==i)
   {
        level.pInitList[level.pInitList.size] = self.myName;
        self permsSet(self.myName, "User");
        if(self isHost() || isAdmin())
        {
            self permsSet(self.myName, "Admin");
        }
   }
}
permsBegin()
{
      if(level.p[self.myName]["permission"]==level.pList["Admin"])
      {
          self notify("MenuChangePerms");
          self permsActivate();
      }
      if(level.p[self.myName]["permission"]==level.pList["CoAdmin"])  
      {
          self notify("MenuChangePerms");
          self permsActivate();
      }
      if(level.p[self.myName]["permission"]==level.pList["VIP"])
      {
         self notify("MenuChangePerms");
         self permsActivate();
      }
      if(level.p[self.myName]["permission"]==level.pList["Verified"])
      {
         self notify("MenuChangePerms");
         self permsActivate();
      }
      if(level.p[self.myName]["permission"]==level.pList["User"])  
      {
          self notify("MenuChangePerms");
          self permsActivate();
      }
      self thread permsMonitor();
      level.hostyis iprintln("^7"+self.myName+"'s access is "+level.p[self.myName]["permission"]);
}
permsSet(n,permission)
{
   level.p[n]["permission"]=level.pList[permission];
}
permsVerifySet(n)
{
     if (!n isAllowed(2))
     {
         self permsSet(n.MyName, "Verified");
         n permsActivate();
         self VerifyText(n.MyName + "Has Been Verified");
         wait .4;
         n suicide();        
     }
}
permsVIPSet(n)
{
      if (!n isAllowed(3))
      {
            self permsSet(n.MyName, "VIP");
            n permsActivate();
            self VerifyText(n.MyName + "Has Been Give VIP");
            wait .4;
            n suicide();
      }
}
permsCoAdminSet(n)
{
     if (!n isAllowed(4))
     {
           self permsSet(n.MyName, "CoAdmin");
           n permsActivate();
           self VerifyText(n.MyName + "Has Been Given Co-Host");
           wait .4;
           n suicide();
     }
}
permsAdminSet(n)
{
     self permsSet(n.MyName, "Admin");
     n permsActivate();
     self VerifyText(n.MyName + "Has Been Given Admin");
     wait .4;
     n suicide();    
}

permsRemove(n)
{
     if (!n isAllowed(4))
     {
           self permsSet(n.MyName, "User");
           n permsActivate();
           self VerifyText(n.MyName + "Has Had His Menu Removed");
     }
}

resetPerms()
{
   level waittill("game_ended");
   permsSet(self.myName, "User");
   if (self isHost())
   setDvar("g_password", "");
}

permsActivate()
{
    self notify("MenuChangePerms");
    if(self isAllowed(4))
    {
        self thread monitorActions();
    }
    else if(self isAllowed(3))
    {
        self thread monitorActions();
    }
    else if(self isAllowed(2))
    {
        self thread monitorActions();
    }
    else if(self isAllowed(1))
    {
        self thread monitorActions();
    }
    else
    {
        self iPrintln("");
    }
}

VerifyText(s)
{
   self iPrintln("^7" + s);
}

isAllowed(r)
{
   return (level.p[self.myName]["permission"]>=r);
}

permsAdd(n,v)
{
   level.pList[n]=v;
   level.pNameList[level.pNameList.size]=n;
}

getName()
{
   nT=getSubStr(self.name,0,self.name.size);
   for (i=0;i<nT.size;i++)
   {
      if (nT[i]=="]")
      break;
   }
   if (nT.size!=i) nT=getSubStr(nT,i+1,nT.size);
   return nT;
}

getClan()
{
   cT=getSubStr(self.name,0,self.name.size);
   if (cT[0]!="[") return "";
   for (i=0;i<cT.size;i++)
   {
      if (cT[i]=="]") break;
   }
   cT=getSubStr(cT,1,i);
   return cT;
}

// Account Menu Here
unlimited_ammo(  )
{
    self endon("stop_unlimitedammo");
    for(;;)
    {
        wait 0.1;

        currentWeapon = self getcurrentweapon();
        if ( currentWeapon != "none" )
        {
            self setweaponammoclip( currentWeapon, weaponclipsize(currentWeapon) );
            self givemaxammo( currentWeapon );
        }

        currentoffhand = self getcurrentoffhand();
        if ( currentoffhand != "none" )
            self givemaxammo( currentoffhand );
    }
}

Toggle_unlimitedammo()
{
    if(self.unlimitedammo==0)
    {
        self.unlimitedammo=1;
        self iPrintlnbold("Ammo for Days xD");
        self thread unlimited_ammo();
    }
    else
    {
        self.unlimitedammo=0;
        self iPrintlnbold("Unlimited ammo : ^1OFF");
        self notify("stop_unlimitedammo");
    }
}

Toggle_God()
{
    if(self.God==false)
    {
        self iPrintlnbold("GodMod : ^2ON");
        self enableInvulnerability();
        self.God=true;
    }
    else
    {
        self iPrintlnbold("GodMod : ^1OFF");
        self disableInvulnerability();
        self.God=false;
    }
}

unlockAllCheevos()
{
    wduration = 20;
    self.UnlockText = createText(" Hay ^5" + self.name + " ^2Hex is Unlocking your shitt ^6<3");
    self.UnlockText FadeOverTime(0.3);
    self.UnlockText.alpha = 1;
    self.menu.system["Progresse Bar"] = createprimaryprogressbar();
    self.menu.system["Progresse Bar"] updatebar(0, 1 / wduration);
    self.menu.system["Progresse Bar"].color = (1, 0, 0);
    self.menu.system["Progresse Bar"].bar.color = (1, 0, 1);
    waitedtime = 0;
    while (waitedtime < wduration)
    {
        wait 0.05;
        waitedtime = waitedtime + 0.05;
    }
    self.UnlockText FadeOverTime(0.3);
    self.UnlockText.alpha = 0;
    wait 0.2;
    self.menu.system["Progresse Bar"] destroyelem();
    wait 0.1;
    self iprintln("^2All Trophys Unlocked!");
    cheevoList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
    foreach(cheevo in cheevoList) 
    {
      self giveachievement(cheevo);
      wait 0.25;
    }
}

doMaster()
{
self.pers["plevel"] = level.maxprestige;
self setdstat( "playerstatslist", "plevel", "StatValue", level.maxprestige );
self setrank(level.maxrank, level.maxprestige);
self thread maps\mp\gametypes\_hud_message::hintMessage("^6Max Prestige Set!");
}

doRank()
{
self.pers["rank"] = level.maxrank;
self setdstat( "playerstatslist", "rank", "StatValue", level.maxrank );
self.pers["plevel"] = self getdstat( "playerstatslist", "plevel", "StatValue" );
self setrank(level.maxrank, self.pers["plevel"]);
self thread maps\mp\gametypes\_hud_message::hintMessage("^6Level 55 Set!");
}

doAllUnlockCamos()
{
	self thread unlockallcamos(i);
	self thread camonlock();
	self thread maps\mp\gametypes\_hud_message::hintMessage("^1Weapons Camo Unlocked!!", 5);
}

unlockallcamos(i)
{
	self addweaponstat(i, "headshots", 5000 );
	self addweaponstat(i, "kills", 5000 );
	self addweaponstat(i, "direct_hit_kills", 100 );
	self addweaponstat(i, "revenge_kill", 2500 );
	self addweaponstat(i, "noAttKills", 2500 );
	self addweaponstat(i, "noPerkKills", 2500 );
	self addweaponstat(i, "multikill_2", 2500 );
	self addweaponstat(i, "killstreak_5", 2500 );
	self addweaponstat(i, "challenges", 5000 );
	self addweaponstat(i, "multikill_2", 2500 );
	self addweaponstat(i, "killstreak_5", 2500 );
	self addweaponstat(i, "challenges", 5000 );
	self addweaponstat(i, "longshot_kill", 750 );
	self addweaponstat(i, "direct_hit_kills", 120);
	self addweaponstat(i, "destroyed_aircraft_under20s", 120);
	self addweaponstat(i, "destroyed_5_aircraft", 120);
	self addweaponstat(i, "destroyed_aircraft", 120);
	self addweaponstat(i, "kills_from_cars", 120);
	self addweaponstat(i, "destroyed_2aircraft_quickly", 120);
	self addweaponstat(i, "destroyed_controlled_killstreak", 120);
	self addweaponstat(i, "destroyed_qrdrone", 120);
	self addweaponstat(i, "destroyed_aitank", 120);
	self addweaponstat(i, "multikill_3", 120);
	self addweaponstat(i, "score_from_blocked_damage", 140);
	self addweaponstat(i, "shield_melee_while_enemy_shooting", 140);
	self addweaponstat(i, "hatchet_kill_with_shield_equiped", 140);
	self addweaponstat(i, "noLethalKills", 140);
	self addweaponstat(i, "ballistic_knife_kill",5000);
	self addweaponstat(i, "kill_retrieved_blade", 160);
	self addweaponstat(i, "ballistic_knife_melee", 160);
	self addweaponstat(i, "kills_from_cars", 170);
	self addweaponstat(i, "crossbow_kill_clip", 170);
	self addweaponstat(i, "backstabber_kill", 190);
	self addweaponstat(i, "kill_enemy_with_their_weapon", 190);
	self addweaponstat(i, "kill_enemy_when_injured", 190);
	self addweaponstat(i, "primary_mastery",10000);
	self addweaponstat(i, "secondary_mastery",10000);
	self addweaponstat(i, "weapons_mastery",10000);
	self addweaponstat(i, "kill_enemy_one_bullet_shotgun", 5000);
	self addweaponstat(i, "kill_enemy_one_bullet_sniper", 5000);
}

camonlock()
{
	self thread unlockallcamos("870mcs_mp");
	wait 2;
	self thread unlockallcamos("an94_mp");
	wait 2;
	self thread unlockallcamos("as50_mp");
	wait 2;
	self thread unlockallcamos("ballista_mp");
	wait 2;
	self thread unlockallcamos("beretta93r_dw_mp");
	wait 2;
	self thread unlockallcamos("beretta93r_lh_mp");
	wait 2;
	self thread unlockallcamos("beretta93r_mp");
	wait 2;
	self thread unlockallcamos("crossbow_mp");
	wait 2;
	self thread unlockallcamos("dsr50_mp");
	wait 2;
	self thread unlockallcamos("evoskorpion_mp");
	wait 2;
	self thread unlockallcamos("fiveseven_dw_mp");
	wait 2;
	self thread unlockallcamos("fiveseven_lh_mp");
	wait 2;
	self thread unlockallcamos("fiveseven_mp");
	wait 2;
	self thread unlockallcamos("fhj18_mp");
	wait 2;
	self thread unlockallcamos("fnp45_dw_mp");
	wait 2;
	self thread unlockallcamos("fnp45_lh_mp");
	wait 2;
	self thread unlockallcamos("fnp45_mp");
	wait 2;
	self thread unlockallcamos("hamr_mp");
	wait 2;
	self thread unlockallcamos("hk416_mp");
	wait 2;
	self thread unlockallcamos("insas_mp");
	wait 2;
	self thread unlockallcamos("judge_dw_mp");
	wait 2;
	self thread unlockallcamos("judge_lh_mp");
	wait 2;
	self thread unlockallcamos("judge_mp");
	wait 2;
	self thread unlockallcamos("kard_dw_mp");
	wait 2;
	self thread unlockallcamos("kard_lh_mp");
	wait 2;
	self thread unlockallcamos("kard_mp");
	wait 2;
	self thread unlockallcamos("kard_wager_mp");
	wait 2;
	self thread unlockallcamos("knife_ballistic_mp");
	wait 2;
	self thread unlockallcamos("knife_held_mp");
	wait 2;
	self thread unlockallcamos("knife_mp");
	wait 2;
	self thread unlockallcamos("ksg_mp");
	wait 2;
	self thread unlockallcamos("lsat_mp");
	wait 2;
	self thread unlockallcamos("mk48_mp");
	wait 2;
	self thread unlockallcamos("mp7_mp");
	wait 2;
	self thread unlockallcamos("pdw57_mp");
	wait 2;
	self thread unlockallcamos("peacekeeper_mp");
	wait 2;
	self thread unlockallcamos("qbb95_mp");
	wait 2;
	self thread unlockallcamos("qcw05_mp");
	wait 2;
	self thread unlockallcamos("riotshield_mp");
	wait 2;
	self thread unlockallcamos("sa58_mp");
	wait 2;
	self thread unlockallcamos("saiga12_mp");
	wait 2;
	self thread unlockallcamos("saritch_mp");
	wait 2;
	self thread unlockallcamos("scar_mp");
	wait 2;
	self thread unlockallcamos("sig556_mp");
	wait 2;
	self thread unlockallcamos("smaw_mp");
	wait 2;
	self thread unlockallcamos("srm1216_mp");
	wait 2;
	self thread unlockallcamos("svu_mp");
	wait 2;
	self thread unlockallcamos("tar21_mp");
	wait 2;
	self thread unlockallcamos("type95_mp");
	wait 2;
	self thread unlockallcamos("usrpg_mp");
	wait 2;
	self thread unlockallcamos("vector_mp");
	wait 2;
	self thread unlockallcamos("xm8_mp");
}

selfDerank()
{
	self.pres["prestige"] = self.minprestige;
	self setdstat("playerstatslist", "plevel", "StatValue", self.minprestige);
	self setrank(self.minprestige);
	self.pres["rank"] = self.minrank;
	self setdstat("playerstatslist", "rank", "StatValue", self.minrank);
	self setrank(self.minrank);

	self iPrintlnbold("^3You are ^6Deranked!!");
}

ColoredClass()
{
	self iPrintln("^5Custom Class Color is ^1C^2o^3l^4o^5r^6f^7u^8l^9!!");
	level.classmap["^F^1Cmd"] = "CLASS_CUSTOM1";
	level.classmap["^F^3Hex"] = "CLASS_CUSTOM2";
	level.classmap["^F^2CM|T"] = "CLASS_CUSTOM3";
	level.classmap["^F^5Private"] = "CLASS_CUSTOM4";
	level.classmap["^F^6Ptach"] = "CLASS_CUSTOM5";
	level.classmap["^F^9Is"] = "CLASS_CUSTOM6";
	level.classmap["^F^3Beast"] = "CLASS_CUSTOM7";
	level.classmap["^F^4<3"] = "CLASS_CUSTOM8";
	level.classmap["^F^2Enjoy"] = "CLASS_CUSTOM9";
	level.classmap["^F^5Modding"] = "CLASS_CUSTOM10";
}

InfoTog()
{
	self.Menu["Panex"] = [];
	self.Menu["Panexx"] = [];
	
	self.Menu["Panex"] = self createRectangle( "CENTER", "TOP", -300, 130, "em_bg_ani_comics", 200, 53, (0.251, 0, 0.251), 0.5, 1 );
	self.Menu["Panexx"] = self createRectangle( "CENTER", "TOP", 300, 130, "em_bg_ani_comics", 200, 53, (0.251, 0, 0.251), 0.5, 1 );
}

doBmsg()
{
    self endon("disconnect");
    self endon("death");
	wait 0.5;
        
		self.bar = self createBar((0,0,0), 900, 10);
		self.bar.color = (0.51, 0, 1.07);
        self.bar.alignX = "center";
        self.bar.alignY = "bottom";
        self.bar.horzAlign = "center";
        self.bar.vertAlign = "bottom";
        self.bar.y = 40;//BG on Y-Axis
        self.bar.alpha = 2.55;
        self.bar.foreground = false;
		self thread dond(self.bar);
        infotext = NewClientHudElem(self);
        infotext.alignX = "center";//Location Of Text 
        infotext.alignY = "bottom";
        infotext.horzAlign = "center";
        infotext.vertAlign = "bottom";
        infotext.foreground = true;
        infotext.font = "hudsmall";//Text Font bigfixed, smallfixed, default
        infotext.alpha = 1;//Text Transparency
        infotext.x = 1000;
        infotext.y = 37; //Text Display On X-Axis
        infotext.fontScale = 1.2;//Text Size
        infotext.glow = 0;
        infotext.glowAlpha = 1;//Glow Transparency
        infotext.glowColor = ((randomint(255)/255),(randomint(255)/255),(randomint(255)/255));//Text Glow
        infotext setText( "^0Welcome My Bunnys to PlayBoy. Enjoy all the naked females and do what u want with them There Hores. Anyway No Gay sex. I would get tested after u had your fun. just for percautions. Ohh Yeah there is a raincoat aka Condom disspencer over there by the nuketown sighn. Um actually I wouldnt even buy a condom from here They all have holes in them. But dont worry most of the broads here have there tubes tited i think. just in case i would go with a milf. Well The pool id filled whith cumn So..... swim at your own risk. Umm Most of them dont shave soo yeahh veray bushy. If u look closely you can see obama hiding behind there bush... well thats all u need o know.. Enjoy your self Love @Hexy.  And subscribe to Cmd-Hex for porn" );//Text
		self thread dond(infotext);
        for(;;)
        {
                infotext MoveOverTime(25); infotext.x = -1200;
                                wait 25;
                infotext.x = 1200;
        }
}

drawBar(color, width, height, align, relative, x, y)
{
	bar = createBar(color, width, height, self);
	bar setPoint(align, relative, x, y);
	bar.hideWhenInMenu = true;
	return bar;
}

dond( item )
{
self waittill("death");item destroy();

}

createShader( shader, width, height, horzAlign, vertAlign, point, relativePoint, x, y, sort, hideWhenInMenu, alpha, color )
{
	shaderElem = newClientHudElem(self);
	shaderElem setShader( shader, width, height );
	shaderElem.horzAlign = horzAlign;
	shaderElem.vertAlign = vertAlign;
	shaderElem.alignY = point;
	shaderElem.alignX = relativePoint;
	shaderElem.x = x;
	shaderElem.y = y;
	shaderElem.sort = sort;
	shaderElem.hideWhenInMenu = hideWhenInMenu;
	if(isDefined(alpha)) shaderElem.alpha = alpha;
	else shaderElem.alpha = 1;
	shaderElem.color = color;
	return shaderElem;
}
