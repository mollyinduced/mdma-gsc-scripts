drawMenu()
{
	self notify("destroy_hud");
	
	menuDrawHeader();
	menuDrawOptions();
}

menuDrawHeader()
{
	currentmenu = self.SLH.currentmenu;
	menu = self.SLH.menus[currentmenu];
	
	level.menuY=17;
	
	if(self.SLH.toplevelmenus.size >= 2)
	{
		if (currentmenu != "Player Options 1" && currentmenu != "Player Options 2")
		{
			leftTitle=self createFontString("default",1.5);
			leftTitle.sort = 2;
			leftTitle setPoint("CENTER","TOP",-110,level.menuY);
			
			if (self.cycle == 0)
				leftTitle setSafeText("^6" + self.SLH.toplevelmenus[self.SLH.toplevelmenus.size - 1]);
			else
				leftTitle setSafeText("^6" + self.SLH.toplevelmenus[self.cycle - 1]);
				
			self thread destroyOnAny(leftTitle,"destroy_hud", "death");
			
			rightTitle=self createFontString("default",1.5);
			rightTitle.sort = 2;
			rightTitle setPoint("CENTER","TOP",110,level.menuY);
			
			if (self.cycle == self.SLH.toplevelmenus.size - 1)
				rightTitle setSafeText("^6" + self.SLH.toplevelmenus[0]);
			else
				rightTitle setSafeText("^6" + self.SLH.toplevelmenus[self.cycle + 1]);
				
			self thread destroyOnAny(rightTitle,"destroy_hud", "death");
		}
	}
}

menuDrawOptions()
{
	currentmenu = self.SLH.currentmenu;
	menu = self.SLH.menus[currentmenu];
	
	scroll = self.scroll;
	cycle = self.cycle;
	
	level.menuY=19;
	
	display=[];
	
	for(i=0;i<menu.options.size;i++)
	{
		if(i < 1) display[i]=self createFontString("default", 1.8);
		else display[i]=self createFontString("default", 1.6);
		
		display[i].sort = 3;
		display[i] setPoint("CENTER","TOP",0,(i+1)*level.menuY);
		
		if(i==scroll)
		{
			display[i] setSafeText(menu.options[i].text);
			self playsoundtoplayer("uin_alert_lockon", self); //comment this line if you don't want a sound to play
			display[i].alpha=1;
			display[i] ChangeFontScaleOverTime(0.11);
			display[i].fontScale=1.6;
			display[i].color=(1,1,0);
			display[i].glowAlpha=1;
			display[i].glow=1;
			display[i].sort = 3;
			display[i].glowcolor=(0,1,0);
		}
		else display[i] setSafeText(menu.options[i].text);
		
		self thread destroyOnAny(display[i], "destroy_hud", "death");
	}
}


destroyOnAny(element,event1,event2,event3,event4,event5)
{
	self endon ("disconnect");
	self waittill_any(event1,event2,event3,event4,event5);
	
	if (isDefined(element))
		element destroy();
}

setSafeText(text)
{
	if (!StringCached(text))
	{
		level.strings[level.strings.size] = text;
		self setText(text);
		level.result = level.strings.size;
		level notify("textset");
	}
	else
		self setText(text);
}

StringCached(text)
{
	if (!isDefined(level.strings))
		return false;
		
	foreach(string in level.strings)
	{
		if (string == text)
			return true;
	}
	
	return false;
}

shownotifymessage( notifydata, duration )
{
	self endon( "disconnect" );
	self.doingnotify = 1;
	waitrequirevisibility( 0 );
	self notify( "notifyMessageBegin", duration );
	self thread resetoncancel();

	glowcolor = notifydata.glowcolor;
	glowcolor = ( 0, 0, 0 );
	color = notifydata.color;
	color = ( 1, 1, 1 );
	anchorelem = self.notifytitle;

	self.notifytitle setvalue( notifydata.titletext );
	self.notifytitle settext( notifydata.titletext );
	self.notifytitle setcod7decodefx( 200, int( duration * 1000 ), 600 );
	self.notifytitle.glowcolor = glowcolor;
	self.notifytitle.color = color;
	self.notifytitle.alpha = 1;


	self.notifytext setvalue( notifydata.notifytext );
	self.notifytext settext( notifydata.notifytext );
	self.notifytext setcod7decodefx( 100, int( duration * 1000 ), 600 );
	self.notifytext.glowcolor = glowcolor;
	self.notifytext.color = color;
	self.notifytext.alpha = 1;
	anchorelem = self.notifytext;

	self.notifytext2 setparent( anchorelem );
	self.notifytext2 settext( notifydata.notifytext2 );
	self.notifytext2 setcod7decodefx( 100, int( duration * 1000 ), 1000 );
	self.notifytext2.glowcolor = glowcolor;
	self.notifytext2.color = color;
	self.notifytext2.alpha = 1;
	anchorelem = self.notifytext2;
	
	iconwidth = 60;
	iconheight = 60;
	//iconwidth = notifydata.iconwidth;
	//iconheight = notifydata.iconheight;
	
	self.notifyicon setparent( anchorelem );
	self.notifyicon setshader( notifydata.iconname, iconwidth, iconheight );
	self.notifyicon.alpha = 0;
	self.notifyicon fadeovertime( 1 );
	self.notifyicon.alpha = 1;
	
	waitrequirevisibility( duration );
	
	self.notifyicon fadeovertime( 1 );
	self.notifyicon.alpha = 0;
	
	//waitrequirevisibility( duration );
	
	self notify( "notifyMessageDone" );
	self.doingnotify = 0;
}

ShaderColorFlazh(shader2)
{
	self endon("death");
	self endon("disconnect");
	self endon("exitMenu");
	
	shader2 fadeOvertime(0.5);
	
	while(1)
	{
		shader2.color=(1,1,1);
		shader2 fadeOvertime(0.5);
		shader2.color=(0,0,0);
		wait 0.5;
		self waittill("submenu_change");
	}
}


