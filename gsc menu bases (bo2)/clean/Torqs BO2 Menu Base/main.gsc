// ,--------.                        ,------.  ,----.   ,--.  ,--. 
// '--.  .--',---. ,--.--. ,---.     |  .--. ''  .-./   |  '--'  | 
//   |  |  | .-. ||  .--'| .-. |    |  '--'.'|  | .---.|  .--.  | 
//   |  |  ' '-' '|  |   ' '-' |    |  |\  \ '  '--'  ||  |  |  | 
//   `--'   `---' `--'    `-|  |    `--' '--' `------' `--'  `--' 
//                          `--'                                  

//  BASE CREATED BY: TorqRGH
//  Add Me On Discord - Torq#0002


//  Inside this base, I will have some stuff outlined and explain what certain things do, etc!

//  Enjoy


#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    PrecacheShader("lui_loader_no_offset");
    PrecacheShader("compass_emp");
    PrecacheShader("gradient_fadein");
    PrecacheShader("gradient");
    PrecacheShader("black");
    level thread onPlayerConnect();
    level.clientid = 0;
    level.result = 0;
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player.MenuInit = false;
        
        if(player isHost())
             player.status = "Host";
        else
             player.status = "Unverified";
             
        if(player isVerified())
             player giveMenu();
             
        player thread onPlayerSpawned();
        player.clientid = level.clientid;
        level.clientid++;
    }
}

onPlayerSpawned()
{
     self endon("disconnect");
     level endon("game_ended");
     isFirstSpawn = true;
     self freezecontrols(false);
     for(;;)
     {
          self waittill("spawned_player");
          if(isFirstSpawn)
          {
               if (self isHost()) // The if (self isHost()) line is a self host checker, so any code that is in this fucntion it only shows for the host!
               {
                    self iprintln("[{+speed_throw}]+[{+melee}] ^6To Open"); // this shows a text on the left side 
                    self iprintln("^6Your Text Goes Here"); // this shows a text on the left side 
                    thread overflowfix();
                    self thread welcomeMessage();
               }
               isFirstSpawn = false;
          }
         
     }
}
welcomeMessage()
{
    notifyData = spawnstruct();
    notifyData.notifyText = "SUB TEXT GOES HERE"; // change the text to your sub text under the title text
    notifyData.glowColor = (128, 0, 128); // this is the glow color around the welcome message
    notifyData.duration = 12;
      self.welcomemsg setcod7decodefx( 80, 10000, 1000 );
        notifydata.titletext= "WELCOME MESSAGE GOES HERE"; // change the text to the title of your menu
    notifyData.font = "hudbig";
    notifyData.hideWhenInMenu = false;
    self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
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
          wait 0.01;
     }
}

recreateText()
{
     self endon("disconnect");
     self endon("death");
     
     input = self.CurMenu;
     title = self.CurTitle;
     
     self thread submenu(input, title);
}

giveMenu()
{
     if (self isVerified())
     {
          if (!self.MenuInit)
          {
               self.MenuInit = 1;
               self thread MenuInit();
          }
     }
}

isVerified()
{
     if (self.status == "Host" || self.status == "Verified" || self.status == "VIP" || self.status == "Admin" || self.status == "Co-Host")
     {
          return true;
     }
     else
     {
          return false;
     }
}

drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort)
{
    hud = self createFontString(font, fontScale);
    hud setText(text);
    hud.x = x;
    hud.y = y;
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    
    level.result += 1;
    hud setText(text);
    level notify("textset");
    
    return hud;
}

drawShader(shader, x, y, width, height, color, alpha, sort)
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    return hud;
}

changeVerificationMenu(player, verlevel)
{
     if (player.status != verlevel && !player isHost())
     {
          player notify("statusChanged");
          player.status = verlevel;
          wait 0.05;
          player giveMenu();
          
          if(player.status == "Unverified")
          {
               player thread destroyMenu(player);
          }
          if(player isVerified())
          {
               self iprintln("^7 " + getPlayerName(player) + " Is Now " + verificationToColor(verlevel));
               player iPrintln("^6You Are Now" + verificationToColor(verlevel));
               player iprintln("^6Press [{+speed_throw}]+[{+melee}] ^6To Open The Menu^7");
          }
     }
     else
     {
          if (player isHost())
              self iPrintln("You Cannot Change The Access Level of The " + verificationToColor(player.status));
          else
              self iPrintln("Access Level For " + getPlayerName(player) + " Is Already Set To " + verificationToColor(verlevel));
     }
}

changeVerification(player, verlevel)
{
     player notify("statusChanged");
     player.status = verlevel;
     wait 0.05;
     player giveMenu();
     
     if(player.status == "Unverified")
     {
          player thread destroyMenu(player);
          player iPrintln("^6You Are Now Unverified!");
     }
     if(player isVerified())
     {
          player iPrintln("^6You Are Now" + verificationToColor(verlevel));
          player iprintln("^6Press^7 [{+speed_throw}]+[{+melee}] ^6To Open The Menu^7");
     }
}

getPlayerName(player)
{
    playerName = getSubStr(player.name, 0, player.name.size);
    for(i=0; i < playerName.size; i++)
    {
        if(playerName[i] == "]")
            break;
    }
    if(playerName.size != i)
        playerName = getSubStr(playerName, i + 1, playerName.size);
    return playerName;
}

verificationToNum(status)
{
    if (status == "Host") //HOST
        return 5;
    if (status == "Co-Host") // Co-Host
        return 4;
    if (status == "Admin") // Admin
        return 3;
    if (status == "VIP") // VIP
        return 2;
    if (status == "Verified") // Verified
        return 1;
    else
        return 0;
}

verificationToColor(status)
{
    if (status == "Host")
        return "^6Host";
    if (status == "Co-Host")
        return "^6Co-Host";
    if (status == "Admin")
        return "^6Admin";
    if (status == "VIP")
        return "^6VIP";
    if (status == "Verified")
        return "^6Verified";
    else
        return "^6Unverified";
}

Iif(bool, rTrue, rFalse)
{
    if(bool)
        return rTrue;
    else
        return rFalse;
}

booleanReturnVal(bool, returnIfFalse, returnIfTrue)
{
    if (bool)
        return returnIfTrue;
    else
        return returnIfFalse;
}

booleanOpposite(bool)
{
    if(!isDefined(bool))
        return true;
    if (bool)
        return false;
    else
        return true;
}

CreateMenu()
{
     self add_menu("Main Menu", undefined, "Unverified");
     self add_option("Main Menu", "Sub Option 1", ::submenu, "Sub Option 1", "Sub Option 1");
     self add_option("Main Menu", "Sub Option 2", ::submenu, "Sub Option 2", "Sub Option 2");
     self add_option("Main Menu", "Sub Option 3", ::submenu, "Sub Option 3", "Sub Option 3");
     self add_option("Main Menu", "Sub Option 4", ::submenu, "Sub Option 4", "Sub Option 4");
     self add_option("Main Menu", "Sub Option 5", ::submenu, "Sub Option 5", "Sub Option 5");
     self add_option("Main Menu", "Sub Option 6", ::submenu, "Sub Option 6", "Sub Option 6");
     self add_option("Main Menu", "Sub Option 7", ::submenu, "Sub Option 7", "Sub Option 7");
     self add_option("Main Menu", "Sub Option 8", ::submenu, "Sub Option 8", "Sub Option 8");
     self add_option("Main Menu", "Sub Option 9", ::submenu, "Sub Option 9", "Sub Option 9");
     self add_option("Main Menu", "Sub Option 10", ::submenu, "Sub Option 10", "Sub Option 10");
     self add_option("Main Menu", "Sub Option 11", ::submenu, "Sub Option 11", "Sub Option 11");
     self add_option("Main Menu", "Sub Option 12", ::submenu, "Sub Option 12", "Sub Option 12");
     self add_option("Main Menu", "Players Menu", ::submenu, "PlayersMenu", "Players Menu");
     
     self add_menu("Sub Option 1", "Main Menu", "VIP");
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     self add_option("Sub Option 1", "Option", ::test);
     
     self add_menu("Sub Option 2", "Main Menu", "VIP");
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     self add_option("Sub Option 2", "Option", ::test);
     
     
     self add_menu("Sub Option 3", "Main Menu", "VIP");
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     self add_option("Sub Option 3", "Option", ::test);
     
     
     self add_menu("Sub Option 4", "Main Menu", "VIP");
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     self add_option("Sub Option 4", "Option", ::test);
     
     
     self add_menu("Sub Option 5", "Main Menu", "VIP");
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     self add_option("Sub Option 5", "Option", ::test);
     
     
     self add_menu("Sub Option 6", "Main Menu", "VIP");
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     self add_option("Sub Option 6", "Option", ::test);
     
     
     self add_menu("Sub Option 7", "Main Menu", "VIP");
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     self add_option("Sub Option 7", "Option", ::test);
     
     
     self add_menu("Sub Option 8", "Main Menu", "VIP");
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     self add_option("Sub Option 8", "Option", ::test);
     
     
     self add_menu("Sub Option 9", "Main Menu", "VIP");
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     self add_option("Sub Option 9", "Option", ::test);
     
     
     self add_menu("Sub Option 10", "Main Menu", "VIP");
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     self add_option("Sub Option 10", "Option", ::test);
     
     
     self add_menu("Sub Option 11", "Main Menu", "VIP");
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     self add_option("Sub Option 11", "Option", ::test);
     
     self add_menu("Sub Option 12", "Main Menu", "VIP");
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
     self add_option("Sub Option 12", "Option", ::test);
   
     
     self add_menu("PlayersMenu", "Main Menu", "Co-Host");
     for (i = 0;i < level.players.size;i++)
     { self add_menu("pOpt " + i, "PlayersMenu", "Co-Host"); }
}

updatePlayersMenu()
{
     self.menu.menucount["PlayersMenu"] = 0;
     for (i = 0;i < level.players.size;i++)
     {
          player = level.players[i];
          playerName = getPlayerName(player);
          
          playersizefixed = level.players.size - 1;
          if(self.menu.curs["PlayersMenu"] > playersizefixed)
          {
               self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
               self.menu.curs["PlayersMenu"] = playersizefixed;
          }
          
          self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName); // Dont change or remove this
          self add_menu_alt("pOpt " + i, "PlayersMenu");
          self add_option("pOpt " + i, "Give Co-Host", ::changeVerificationMenu, player, "Co-Host"); // Dont change or remove this
          self add_option("pOpt " + i, "Give Admin", ::changeVerificationMenu, player, "Admin"); // Dont change or remove this
          self add_option("pOpt " + i, "Give VIP", ::changeVerificationMenu, player, "VIP"); // Dont change or remove this
          self add_option("pOpt " + i, "Verify", ::changeVerificationMenu, player, "Verified"); // Dont change or remove this
          self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified"); // Dont change or remove this
     }
}

add_menu_alt(Menu, prevmenu)
{
     self.menu.getmenu[Menu] = Menu;
     self.menu.menucount[Menu] = 0;
     self.menu.previousmenu[Menu] = prevmenu;
}

add_menu(Menu, prevmenu, status)
{
     self.menu.status[Menu] = status;
     self.menu.getmenu[Menu] = Menu;
     self.menu.scrollerpos[Menu] = 0;
     self.menu.curs[Menu] = 0;
     self.menu.menucount[Menu] = 0;
     self.menu.previousmenu[Menu] = prevmenu;
}

add_option(Menu, Text, Func, arg1, arg2)
{
     Menu = self.menu.getmenu[Menu];
     Num = self.menu.menucount[Menu];
     self.menu.menuopt[Menu][Num] = Text;
     self.menu.menufunc[Menu][Num] = Func;
     self.menu.menuinput[Menu][Num] = arg1;
     self.menu.menuinput1[Menu][Num] = arg2;
     self.menu.menucount[Menu] += 1;
}

updateScrollbar()
{
     self.menu.scroller MoveOverTime(0.10);
     self.menu.scroller.y = 68 + (self.menu.curs[self.menu.currentmenu] * 15.49);
     self.menu.scroller.archived = false;
}

openMenu()
{
    self freezeControls(false);
    self enableInvulnerability();
    self setClientUiVisibilityFlag("hud_visible", 0);
    self StoreText("Main Menu", "Main Menu");
    
    
    self.menu.background FadeOverTime(0.30);
    self.menu.background.alpha = 0.9;
    self.menu.background.archived = false;
    
    self.menu.background1 FadeOverTime(0.30);
    self.menu.background1.alpha = 0.9;
    self.menu.background1.archived = false;
    
    
    self.menu.line MoveOverTime(0.10);
	self.menu.line.y = 45;	
	self.menu.line.archived = false;
	self.menu.line.alpha = 1;
    
    self.swagtext FadeOverTime(0.3);
    self.swagtext.alpha = 0.90;

   

    self updateScrollbar();
    self.menu.open = true;
}

closeMenu()
{
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 0;
    self setClientUiVisibilityFlag("hud_visible", 1);
    
    self.subtext1 FadeOverTime(0.3);
    self.subtext1.alpha = 0;
    
    
    self.subtext2 FadeOverTime(0.3);
    self.subtext2.alpha = 0;
    
    self.torq FadeOverTime(0.3);
    self.torq.alpha = 0;
    
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
    
    self.menu.background1 FadeOverTime(0.3);
    self.menu.background1.alpha = 0;
    
    
    self.swagtext FadeOverTime(0.30);
    self.swagtext.alpha = 0;

    self.menu.title FadeOverTime(0.30);
    self.menu.title.alpha = 0;
    
   self.menu.line MoveOverTime(0.30);
	self.menu.line.y = -550;
	self.menu.line.alpha = 0;
    
    self.menu.backgroundinfo FadeOverTime(0.3);
    self.menu.backgroundinfo.alpha = 0;

    self.menu.scroller MoveOverTime(0.30);
    self.menu.scroller.y = -510;
    self.menu.open = false;
}

destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
    wait 0.3;

    player.menu.options destroy();  
    player.menu.background destroy();
    player.menu.background1 destroy();
    player.menu.scroller destroy();
    player.menu.scroller1 destroy();
    player.infos destroy();
    player.menu.line destroy();
    player.menu.title destroy();
    player notify("destroyMenu");
}

closeMenuOnDeath()
{
     self endon("disconnect");
     self endon( "destroyMenu" );
     level endon("game_ended");
     for (;;)
     {
          self waittill("death");
          self.menu.closeondeath = true;
          self submenu("Main Menu", "Main Menu");
          closeMenu();
          self.menu.closeondeath = false;
     }
}
scaleLol()
{
    self endon("stopScale");
    for(;;)
    {
    self.torq.glowColor = (0.196078431372549,0.803921568627451,0.196078431372549);
    wait .05;
    self.torq.glowColor = (0.196078431372549,0.803921568627451,0.196078431372549);
    }
}
StoreShaders()
{
   self.menu.background = self drawShader("gradient_fadein", 235, 0, 170, 273, (128,0,128), 0, 0); // this is the pink backrgound shader
   self.menu.background1 = self drawShader("gradient", 235, 0, 170, 273, (0,0,0), 0, 1); // this is the black background shader
   self.menu.line = self drawShader("gradient_fadein", 235, 45, 170, 17, (128,0,128), 0, 3); // this is the pink line shader, where your subtext is
   self.menu.scroller = self drawShader("gradient", 235, -100, 170, 17, (0,0,0), 255, 3); // this is the scrollbar shader
    
}

StoreText(menu, title)
{
    self.menu.currentmenu = menu;
    string = "";
    self.menu.currentmenu = input;
    self.menu.title destroy();
    self.menu.title = drawText(title, "default", 1.6, 235, 35, (1, 1, 1), 0, 4);
    self.menu.title FadeOverTime(0.3);
    self.menu.title.archived = false;
    self notify ("stopScale");
    self thread scaleLol();
    self.torq destroy();
    self.torq = self createFontString( "default", 2.0);
    self.torq setPoint( "CENTER", "TOP", 235, 15);
    self.torq setText("MENU BASE"); // this is the title of the menu, so change it to the name of your menu
    self.torq FadeOverTime(0.3);
    self.torq.alpha = 1;
    self.torq.foreground = true;
    self.torq.archived = false;
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string +=self.menu.menuopt[menu][i] + "\n"; }
    
    self.subtext1 destroy();
    self.subtext1 = self createFontString( "default", 1.4);
    self.subtext1 setPoint( "CENTER", "TOP", 235, 35);
    self.subtext1 setText("Made By: TorqRGH"); // change this to what ever, this is below your title text
    self.subtext1 FadeOverTime(0.3);
    self.subtext1.alpha = 1;
    self.subtext1.foreground = true;
    self.subtext1.archived = false;
    
    
    self.subtext2 destroy();
    self.subtext2 = self createFontString( "default", 1.3);
    self.subtext2 setPoint( "CENTER", "TOP", 235, 53);
    self.subtext2 setText("SubText Goes Here"); //  change this text to what ever
    self.subtext2 FadeOverTime(0.3);
    self.subtext2.alpha = 1;
    self.subtext2.foreground = true;
    self.subtext2.archived = false;
    
    
    self.menu.options destroy();
    self.menu.options = drawText(string, "objective", 1.3, 265, 68, (1, 1, 1), 0, (0, 0, 0), 0, 4);
    self.menu.options FadeOverTime(0.3);
    self.menu.options.archived = false;
    self.menu.options.alpha = 1;
    self.menu.options setPoint( "LEFT", "LEFT", 517, -128 ); 
 
}

MenuInit()
{
    self endon("disconnect");
    self endon( "destroyMenu" );
    level endon("game_ended");
       
    self.menu = spawnstruct();
    self.toggles = spawnstruct();
     
    self.menu.open = false;
    
    self StoreShaders();
    self CreateMenu();
    
    for(;;)
    {  
        if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open) // Open.
        {
            openMenu();
        }
        if(self.menu.open)
        {
            if(self useButtonPressed())
            {
                if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
                {
                    self submenu(self.menu.previousmenu[self.menu.currentmenu]);
                }
                else
                {
                    closeMenu();
                }
                wait 0.2;
            }
            if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
            {   
                self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
                self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
                
                self updateScrollbar();
            }
            if(self jumpButtonPressed())
            {
                self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
                wait 0.2;
            }
        }
        wait 0.05;
    }
}
 
submenu(input, title)
{
    if (verificationToNum(self.status) >= verificationToNum(self.menu.status[input]))
    {
        self.menu.options destroy();

        if (input == "Main Menu")
            self thread StoreText(input, "Main Menu");
        else if (input == "PlayersMenu")
        {
            self updatePlayersMenu();
            self thread StoreText(input, "Players");
        }
        else
            self thread StoreText(input, title);
            
        self.CurMenu = input;
        self.CurTitle = title;
        
        self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
        self.menu.curs[input] = self.menu.scrollerpos[input];
        
        level.result += 1;
        level notify("textset");
        
        if (!self.menu.closeondeath)
        {
            self updateScrollbar();
        }
    }
    else
    {
        player iPrintln("^5Only Players With ^4" + verificationToColor(self.menu.status[input]) + " ^5Can Access This Menu!");
    }
}






