/*
*	 Creator : Liam
*	 Project : iPrintln Menu Base
*    Mode : Multiplayer
*	 Date : 2016/01/11 - 12:58:31	
*
*/	

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;

init()
{
    level thread onPlayerConnect();
    precacheShader("gradiant_center");
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
    for(;;)
    {
        self waittill("spawned_player");
		
		// Will appear each time when the player spawn, that's just an exemple.
		//self iprintln("Black Ops 2 - GSC Studio | Project : ^2Menu Test1"); 
		self thread menu();
		self.Info = self createFontString("smallfixed", 1.5);
      	self.Info setText("iPrintln Menu: ^1Closed");
      	self.Info setPoint("CENTER", "TOP", -350, 100);
    }
}
menu()
{
self thread MenuConfig();
self.option = 1;
self.inmenu = 0;
}
test()
{
self iprintln("Test Function:: "+self.menu+"");
}
MenuText()
{
self endon("MenuClose");
self endon("RefreshMenu");
for(;;)
{
  if(self.menu == "Main")
  {
  self.menuTitle = "Main Menu";
  self.Text1 = "iprintln Menu";
  self.Text2 = "SubMenu1";
  self.Text3 = "SubMenu2";
  self.Text4 = "SubMenu3";
  self.Text5 = "SubMenu4";
  self.Text6 = "Verify";
  self.Func1 = :: SubMenu;
  self.Func2 = :: SubMenu;
  self.Func3 = :: SubMenu;
  self.Func4 = :: SubMenu;
  self.Func5 = :: SubMenu;
  self.Func6 = "";
  self.input1 = "SubMenu1";
  self.input2 = "SubMenu2";
  self.input3 = "SubMenu3";
  self.input4 = "SubMenu4";
  self.input5 = "SubMenu5";
  self.input6 = "verify";
  }
  else if(self.menu == "SubMenu1")
  {
  self.menuTitle = "SubMenu";
  self.Text1 = "test1";
  self.Text2 = "test2";
  self.Text3 = "test3";
  self.Text4 = "test4";
  self.Text5 = "test5";
  self.Text6 = "test6";
  self.Func1 = :: test;
  self.Func2 = :: test;
  self.Func3 = :: test;
  self.Func4 = :: test;
  self.Func5 = :: test;
  self.Func6 = :: test;
  self.input1 = "";
  self.input2 = "";
  self.input3 = "";
  self.input4 = "";
  self.input5 = "";
  self.input6 = "";
  }
  else if(self.menu == "SubMenu2")
  {
  self.menuTitle = "SubMenu";
  self.Text1 = "test1";
  self.Text2 = "test2";
  self.Text3 = "test3";
  self.Text4 = "test4";
  self.Text5 = "test5";
  self.Text6 = "test6";
  self.Func1 = :: test;
  self.Func2 = :: test;
  self.Func3 = :: test;
  self.Func4 = :: test;
  self.Func5 = :: test;
  self.Func6 = :: test;
  self.input1 = "";
  self.input2 = "";
  self.input3 = "";
  self.input4 = "";
  self.input5 = "";
  self.input6 = "";
  }
  else if(self.menu == "SubMenu3")
  {
  self.menuTitle = "SubMenu";
  self.Text1 = "test1";
  self.Text2 = "test2";
  self.Text3 = "test3";
  self.Text4 = "test4";
  self.Text5 = "test5";
  self.Text6 = "test6";
  self.Func1 = :: test;
  self.Func2 = :: test;
  self.Func3 = :: test;
  self.Func4 = :: test;
  self.Func5 = :: test;
  self.Func6 = :: test;
  self.input1 = "";
  self.input2 = "";
  self.input3 = "";
  self.input4 = "";
  self.input5 = "";
  self.input6 = "";
  }
  else if(self.menu == "SubMenu4")
  {
  self.menuTitle = "SubMenu";
  self.Text1 = "test1";
  self.Text2 = "test2";
  self.Text3 = "test3";
  self.Text4 = "test4";
  self.Text5 = "test5";
  self.Text6 = "test6";
  self.Func1 = :: test;
  self.Func2 = :: test;
  self.Func3 = :: test;
  self.Func4 = :: test;
  self.Func5 = :: test;
  self.Func6 = :: test;
  self.input1 = "";
  self.input2 = "";
  self.input3 = "";
  self.input4 = "";
  self.input5 = "";
  self.input6 = "";
  }
  else if(self.menu == "SubMenu5")
  {
  self.menuTitle = "SubMenu";
  self.Text1 = "test1";
  self.Text2 = "test2";
  self.Text3 = "test3";
  self.Text4 = "test4";
  self.Text5 = "test5";
  self.Text6 = "test6";
  self.Func1 = :: test;
  self.Func2 = :: test;
  self.Func3 = :: test;
  self.Func4 = :: test;
  self.Func5 = :: test;
  self.Func6 = :: test;
  self.input1 = "";
  self.input2 = "";
  self.input3 = "";
  self.input4 = "";
  self.input5 = "";
  self.input6 = "";
  }
  else if(self.menu == "verify")
  {
  self.menuTitle = "verify";
  self.Text1 = ""+get_players()[1].playername+" Unverify";
  self.Text2 = ""+get_players()[2].playername+" verify";
  self.Text3 = ""+get_players()[3].playername+" Unverify";
  self.Text4 = ""+get_players()[1].playername+" verify";
  self.Text5 = ""+get_players()[2].playername+" Unverify";
  self.Text6 = ""+get_players()[3].playername+" verify";
  /*self.Func1 = :: Lock;
  self.Func2 = :: unLock;
  self.Func3 = :: Lock;
  self.Func4 = :: unLock;
  self.Func5 = :: Lock;
  self.Func6 = :: unLock;*/
  self.input1 = 1;
  self.input2 = 1;
  self.input3 = 2;
  self.input4 = 2;
  self.input5 = 3;
  self.input6 = 3;
  }
  wait .01;
}
}
 
MenuConfig()
{
self endon("death");
for(;;)
{
  if(self AdsButtonPressed() && self MeleeButtonPressed() && self.inmenu == 0 && self.menuLock == 0 )
  {
      self.Info setText("iPrintln Menu: ^2Open");
      self.option = 1;
      self.menu = "Main";
      wait .01;
      self thread MenuText();
      wait .01;
      self thread MyText();
      self.Title = self createFontString("objective", 2);
      self.Title setText(""+self.menuTitle+"");
      self.Title setPoint("CENTER", "TOP", 0, 50);
      wait .5;
      self.inmenu = 1;
  }
  else if(self MeleeButtonPressed() && self.inmenu == 1 )
  {
      self thread closemenu();
      self.Title Destroy();
  }
  else if(self AttackButtonPressed() && self.inmenu == 1 )
  {
      if( self.option == 6 )
      {
        self.option = 1;
        self thread RefreshMenu();
      }
      else
      {
        self.option = self.option + 1;
        self thread RefreshMenu();
      }
      wait 0.5;
  }
  else if(self AdsButtonPressed() && self.inmenu == 1 )
  {
      if( self.option == 1 )
      {
        self.option = 6;
        self thread RefreshMenu();
      }
      else
      {
        self.option = self.option - 1;
        self thread RefreshMenu();
      }
      wait 0.5;
    }
    else if(self useButtonPressed() && self.inmenu == 1 )
    {
      self thread FunctionInput();
    }
    else if(self FragButtonPressed() && self.inmenu == 1 )
    {
      self thread SubMenu("Main");
    }
    wait .01;
}
}
 
closemenu()
{
self.inmenu = 0;
self thread spam();
self notify("MenuClose");
self.Info setText("iPrintln Menu: ^1Closed");
}
spam()
{
self iprintln(" ");
wait .01;
self iprintln(" ");
wait .01;
self iprintln(" ");
wait .01;
self iprintln(" ");
wait .01;
self iprintln(" ");
wait .01;
self iprintln(" ");
wait .01;
self iprintln(" ");
}
 
MyText()
{
self endon("MenuClose");
self endon("RefreshMenu");
for(;;)
{
  if( self.option == 1 )
  {
      self iprintln("^2"+self.Text1+"");
      self iprintln(""+self.Text2+"");
      self iprintln(""+self.Text3+"");
      self iprintln(""+self.Text4+"");
      self iprintln(""+self.Text5+"");
      self iprintln(""+self.Text6+"");
      wait 4;
  }
  else if( self.option == 2 )
  {
      self iprintln(""+self.Text1+"");
      self iprintln("^2"+self.Text2+"");
      self iprintln(""+self.Text3+"");
      self iprintln(""+self.Text4+"");
      self iprintln(""+self.Text5+"");
      self iprintln(""+self.Text6+"");
      wait 4;
  }
  else if( self.option == 3 )
  {
      self iprintln(""+self.Text1+"");
      self iprintln(""+self.Text2+"");
      self iprintln("^2"+self.Text3+"");
      self iprintln(""+self.Text4+"");
      self iprintln(""+self.Text5+"");
      self iprintln(""+self.Text6+"");
      wait 4;
  }
  else if( self.option == 4 )
  {
      self iprintln(""+self.Text1+"");
      self iprintln(""+self.Text2+"");
      self iprintln(""+self.Text3+"");
      self iprintln("^2"+self.Text4+"");
      self iprintln(""+self.Text5+"");
      self iprintln(""+self.Text6+"");
      wait 4;
  }
  else if( self.option == 5 )
  {
      self iprintln(""+self.Text1+"");
      self iprintln(""+self.Text2+"");
      self iprintln(""+self.Text3+"");
      self iprintln(""+self.Text4+"");
      self iprintln("^2"+self.Text5+"");
      self iprintln(""+self.Text6+"");
      wait 4;
  }
  else if( self.option == 6 )
  {
      self iprintln(""+self.Text1+"");
      self iprintln(""+self.Text2+"");
      self iprintln(""+self.Text3+"");
      self iprintln(""+self.Text4+"");
      self iprintln(""+self.Text5+"");
      self iprintln("^2"+self.Text6+"");
      wait 4;
  }
}
}
Functioninput()
{
if(self.option == 1)
{
self thread [[self.Func1]](self.input1);
}
else if(self.option == 2)
{
self thread [[self.Func2]](self.input2);
}
else if(self.option == 3)
{
self thread [[self.Func3]](self.input3);
}
else if(self.option == 4)
{
self thread [[self.Func4]](self.input4);
}
else if(self.option == 5)
{
self thread [[self.Func5]](self.input5);
}
else if(self.option == 6)
{
self thread [[self.Func6]](self.input6);
}
}
 
SubMenu(TehMenu)
{
self.option = 1;
self.menu = ""+TehMenu+"";
wait .1;
self thread RefreshMenu();
}
 
RefreshMenu()
{
self notify("RefreshMenu");
wait .01;
self thread MenuText();
wait .01;
self thread MyText();
self.Title setText(""+self.menuTitle+"");
}

Lock(pnum)
{
get_players()[pnum] thread closemenu();
wait 2;
get_players()[pnum].menuLock = 1;
}
Unlock(pnum)
{
getplayers()[pnum].menuLock = 0;
}

createRectangle(align, relative, x, y, width, height, sort, shader)
{
	shaderElem = newClientHudElem(self);
	shaderElem.elemType = "bar";
	shaderElem.children = [];
	shaderElem.sort = sort;
	shaderElem setParent(level.uiParent);
	shaderElem setShader(shader, width , height);
	shaderElem.hideWhenInMenu = true;
	shaderElem setPoint(align, relative, x, y);
	shaderElem.type = "shader";
	
	return shaderElem;
}
drawShaders()
{
	self.menuBackground = createRectangle("CENTER", "CENTER", -310, 300, 100, 100, 1, "gradiant_center");
	self.menuBackground setColor(0, 0, 0, 0);
}
setColor(r, g, b, a)
{
	self.color = (r, g, b);
	self.alpha = a;
}

setGlow(r, g, b, a)
{
	self.glowColor = (r, g, b);
	self.glowAlpha = a;
}
remShaders()
{
	self.menuBackground = createRectangle("CENTER", "CENTER", -350, 300, 0, 0, 1, "gradiant_center");
	self.menuBackground setColor(0, 0, 0, 0);
}