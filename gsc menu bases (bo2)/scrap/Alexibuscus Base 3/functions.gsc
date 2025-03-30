godmode()
{
	if(self.godv4 == false)
	{
		self.godv4 = true; //can bypass death barriers
		self.health = 9999999;
		self.maxhealth = self.health;
		self thread loopGod();
		self iprintln("Godmode : [^2On^7]");
	}
	else
	{
		self.godv4 = false;
		self.health = self.originHealth;
		self.maxhealth = self.originHealth;
		self notify("stopLoopingGod");
		self iprintln("Godmode : [^1Off^7]");
	} 
}

loopGod()
{
	self endon("stopLoppingGod");
	while(self.godv4 == true)
	{
		self.health = self.maxhealth;
		wait 0.1;
	}
}

homefront()
{
    level endon("game_ended");
    self endon("disconnect");
    self endon("welcome_Done");
    
    for(;;)
    {
        self setClientUiVisibilityFlag("hud_visible", 0);
        self disableWeapons();
        self hide();
        self freezeControls(1);
        self enableInvulnerability();
        zoomHeight = 5000;
        zoomBack = 4000;
        yaw = 55;
        origin = self.origin;
        self.origin = origin+vector_scal(anglestoforward(self.angles+(0,-180,0)),zoomBack)+(0,0,zoomHeight);
        ent = spawn("script_model",(0,0,0));
        ent.angles = self.angles+(yaw,0,0);
        ent.origin = self.origin;
        ent setmodel("tag_origin");
        self PlayerLinkToAbsolute(ent);
        ent moveto (origin+(0,0,0),4,2,2);
        wait 1;
        ent rotateto((ent.angles[0]-yaw,ent.angles[1],0),3,1,1);
        wait 0.5;
        self playsoundtoplayer("ui_camera_whoosh_in", self);
        wait 2.5;
        self unlink();
        wait 0.2;
        ent delete();
        self disableInvulnerability();
        self Show();
        self freezeControls(0);
        self enableWeapons();
        self setClientUiVisibilityFlag("hud_visible", 1); 
        self notify("welcome_Done");
    }
}

vector_Scal(vec,scale)
{
	vec =(vec[0] * scale,vec[1] * scale,vec[2] * scale);
	return vec;
}






initAnimDvar()
{
	if(getDvar("animation_menu") == "1")
	{
		setDvar("animation_menu", "0");
		self.menu.background2.alpha = 0;
		self iprintln("Animation ^1Off");
	}
	else
	{
		setDvar("animation_menu", "1");
		self.menu.background2.alpha = 0.6;
		self iprintln("Animation ^2On");
	}
}


MoveMenuLeft()
{
	self.menu.background.x = self.menu.background.x - 20;
	self.menu.background2.x = self.menu.background2.x - 20;
	self.menu.line.x = self.menu.line.x - 20;
	self.menu.line2.x = self.menu.line2.x - 20;
	self.menu.scroller.x = self.menu.scroller.x - 20;
	self.menu.line3.x = self.menu.line3.x - 20;
	self.menu.line4.x = self.menu.line4.x - 20;
	self.menu.creatortxt.x = self.menu.creatortxt.x - 20;
	self.menu.title.x = self.menu.title.x - 20;
	self.tez.x = self.tez.x - 20;
	self.menu.line5.x = self.menu.line5.x - 20;
	self.menu.options.x = self.menu.options.x - 20;
	self.menu.header.x = self.menu.header.x - 20;
	self.x = self.x - 20;
	self iprintln("Moved Menu To The Left By +20");
}

MoveMenuRight()
{
	self.menu.background.x = self.menu.background.x + 20;
	self.menu.background2.x = self.menu.background2.x + 20;
	self.menu.line.x = self.menu.line.x + 20;
	self.menu.line2.x = self.menu.line2.x + 20;
	self.menu.scroller.x = self.menu.scroller.x + 20;
	self.menu.line3.x = self.menu.line3.x + 20;
	self.menu.line4.x = self.menu.line4.x + 20;
	self.menu.line5.x = self.menu.line5.x + 20;
	self.menu.creatortxt.x = self.menu.creatortxt.x + 20;
	self.menu.title.x = self.menu.title.x + 20;
	self.tez.x = self.tez.x + 20;
	self.menu.options.x = self.menu.options.x + 20;
	self.menu.header.x = self.menu.header.x + 20;
	self.x = self.x + 20;
	self iprintln("Moved Menu To The Right By +20");
}
	
moveonendgame()
{
	level waittill("game_ended");
	for(;;)
	{
		if(self actionslotfourbuttonpressed() && self adsButtonPressed())
		{
			self freezecontrols(false);
		}
		wait 0.5;
	}
}

settextglow(c, b)
{
	self.glowColour = c;
	self.menu.title.glowColor = c;
	self.menu.options.glowColor = c;
	self.menu.creatortxt.glowColor = c;
	self.titleColour = c;
	self.tez.glowColor = c;
	self iprintln("Glow Color Set To "+b);
}

initStealthDvar()
{
	if(getDvar("stealthmenumod") == "1")
	{
		setDvar("stealthmenumod", "0");
		self thread disStealth();
		self iprintln("Stealth ^1Off \n^7Players Can Now See Menu");
	}
	else
	{
		setDvar("stealthmenumod", "1");
		self thread stealthmenu();
		self iprintln("Stealth ^2On");
	}
}

disStealth()
{
    self.menu.background.archived = true;
	self.menu.background2.archived = true;
	self.menu.scroller.archived = true;
	self.menu.line.archived = true;
	self.menu.line2.archived = true;
	self.menu.line3.archived = true;
	self.menu.line4.archived = true;
	self.menu.creatortxt.archived = true;
	self.menu.title.archived = true;
	self.tez.archived = true;
	self.menu.options.archived = true;
	self.menu.header.archived = true;
	self.menu.line5.archived = true;
}

settheme(c)
{
	self.menu.background2.color = c;
	self.menu.scroller.color = c;
	self.menu.line.color = c;
	self.menu.line2.color = c;
	self.menu.line3.color = c;
	self.menu.line4.color = c;
	self.menu.line5.color = c;
}

setheader(h)
{
	self.menu.header setShader(h, 160, 80);
}

getName()
{
	name = getSubStr(self.name, 0, self.name.size);
	for(i = 0; i < name.size; i++)
	{
		if(name[i]=="]")
			break;
	}
	if(name.size != i)
		name = getSubStr(name, i + 1, name.size);
	return name;
}

addCoList(player)
{
	if(self isHost() || self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		if(!player isHost() || !player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		{
			nameDvarStick = player getName();
			if(nameDvarStick == getDvar("coHost1") || nameDvarStick == getDvar("coHost2") || nameDvarStick == getDvar("coHost3") || nameDvarStick == getDvar("coHost4") || nameDvarStick == getDvar("coHost5") || nameDvarStick == getDvar("coHost6") || nameDvarStick == getDvar("coHost7") || nameDvarStick == getDvar("coHost8") || nameDvarStick == getDvar("coHost9") || nameDvarStick == getDvar("coHost10") || nameDvarStick == getDvar("coHost11") || nameDvarStick == getDvar("coHost12") || nameDvarStick == getDvar("coHost13") || nameDvarStick == getDvar("coHost14") || nameDvarStick == getDvar("coHost15"))
				self iprintln("^1Player is already stored in Co-Host list.");
			else if(getDvar("dvarCoNumber") == "0" || getDvar("dvarCoNumber") == "")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost1", nameDvarStick);
				h("dvarCoNumber", "1");
			}
			else if(getDvar("dvarCoNumber") == "1")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost2", nameDvarStick);
				h("dvarCoNumber", "2");
			}
			else if(getDvar("dvarCoNumber") == "2")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost3", nameDvarStick);
				h("dvarCoNumber", "3");
			}
			else if(getDvar("dvarCoNumber") == "3")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost4", nameDvarStick);
				h("dvarCoNumber", "4");
			}
			else if(getDvar("dvarCoNumber") == "4")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost5", nameDvarStick);
				h("dvarCoNumber", "5");
			}
			else if(getDvar("dvarCoNumber") == "5")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost6", nameDvarStick);
				h("dvarCoNumber", "6");
			}
			else if(getDvar("dvarCoNumber") == "6")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost7", nameDvarStick);
				h("dvarCoNumber", "7");
			}
			else if(getDvar("dvarCoNumber") == "7")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost8", nameDvarStick);
				h("dvarCoNumber", "8");
			}
			else if(getDvar("dvarCoNumber") == "8")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost9", nameDvarStick);
				h("dvarCoNumber", "9");
			}
			else if(getDvar("dvarCoNumber") == "9")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost10", nameDvarStick);
				h("dvarCoNumber", "10");
			}
			else if(getDvar("dvarCoNumber") == "10")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost11", nameDvarStick);
				h("dvarCoNumber", "11");
			}
			else if(getDvar("dvarCoNumber") == "11")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost12", nameDvarStick);
				h("dvarCoNumber", "12");
			}
			else if(getDvar("dvarCoNumber") == "12")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost13", nameDvarStick);
				h("dvarCoNumber", "13");
			}
			else if(getDvar("dvarCoNumber") == "13")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost14", nameDvarStick);
				h("dvarCoNumber", "14");
			}
			else if(getDvar("dvarCoNumber") == "14")
			{
				self iprintln("^6" + nameDvarStick + " added to Co-Host list.");
				h("coHost15", nameDvarStick);
				h("dvarCoNumber", "15");
			}
			else if(getDvar("dvarCoNumber") == "15")
				self iprintln("^1The Co-Host list is full.");
		}
		else
			self iprintln("^1Cant add host to list!");
	}
	else
		self iprintln("^1Only Host can do this!");
}

addVIPList(player)
{
	if(self isHost() || self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		if(!player isHost() || !player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		{
			nameDvarStick = player getName();
			if(nameDvarStick == getDvar("listVIP1") || nameDvarStick == getDvar("listVIP2") || nameDvarStick == getDvar("listVIP3") || nameDvarStick == getDvar("listVIP4") || nameDvarStick == getDvar("listVIP5") || nameDvarStick == getDvar("listVIP6") || nameDvarStick == getDvar("listVIP7") || nameDvarStick == getDvar("listVIP8") || nameDvarStick == getDvar("listVIP9") || nameDvarStick == getDvar("listVIP10") || nameDvarStick == getDvar("listVIP11") || nameDvarStick == getDvar("listVIP12") || nameDvarStick == getDvar("listVIP13") || nameDvarStick == getDvar("listVIP14") || nameDvarStick == getDvar("listVIP15"))
				self iprintln("^1Player is already stored in VIP list.");
			else if(getDvar("dvarVIPNumber") == "0" || getDvar("dvarVIPNumber") == "")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP1", nameDvarStick);
				h("dvarVIPNumber", "1");
			}
			else if(getDvar("dvarVIPNumber") == "1")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP2", nameDvarStick);
				h("dvarVIPNumber", "2");
			}
			else if(getDvar("dvarVIPNumber") == "2")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP3", nameDvarStick);
				h("dvarVIPNumber", "3");
			}
			else if(getDvar("dvarVIPNumber") == "3")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP4", nameDvarStick);
				h("dvarVIPNumber", "4");
			}
			else if(getDvar("dvarVIPNumber") == "4")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP5", nameDvarStick);
				h("dvarVIPNumber", "5");
			}
			else if(getDvar("dvarVIPNumber") == "5")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP6", nameDvarStick);
				h("dvarVIPNumber", "6");
			}
			else if(getDvar("dvarVIPNumber") == "6")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP7", nameDvarStick);
				h("dvarVIPNumber", "7");
			}
			else if(getDvar("dvarVIPNumber") == "7")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP8", nameDvarStick);
				h("dvarVIPNumber", "8");
			}
			else if(getDvar("dvarVIPNumber") == "8")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP9", nameDvarStick);
				h("dvarVIPNumber", "9");
			}
			else if(getDvar("dvarVIPNumber") == "9")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP10", nameDvarStick);
				h("dvarVIPNumber", "10");
			}
			else if(getDvar("dvarVIPNumber") == "10")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP11", nameDvarStick);
				h("dvarVIPNumber", "11");
			}
			else if(getDvar("dvarVIPNumber") == "11")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP12", nameDvarStick);
				h("dvarVIPNumber", "12");
			}
			else if(getDvar("dvarVIPNumber") == "12")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP13", nameDvarStick);
				h("dvarVIPNumber", "13");
			}
			else if(getDvar("dvarVIPNumber") == "13")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP14", nameDvarStick);
				h("dvarVIPNumber", "14");
			}
			else if(getDvar("dvarVIPNumber") == "14")
			{
				self iprintln("^6" + nameDvarStick + " added to VIP list.");
				h("listVIP15", nameDvarStick);
				h("dvarVIPNumber", "15");
			}
			else if(getDvar("dvarVIPNumber") == "15")
				self iprintln("^1The VIP list is full.");
		}
		else
			self iprintln("^1Cant add host to list!");
	}
	else
		self iprintln("^1Only Host can do this!");
}

addBlackList(player)
{
	if(self isHost() || self getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
	{
		if(!player isHost() || !player getName() == level.DvarFunc1 + level.DvarFunc2 + level.DvarFunc3 + level.DvarFunc4)
		{
			nameDvarStick = player getName();
			if(nameDvarStick == getDvar("listBlack1") || nameDvarStick == getDvar("listBlack2") || nameDvarStick == getDvar("listBlack3") || nameDvarStick == getDvar("listBlack4") || nameDvarStick == getDvar("listBlack5") || nameDvarStick == getDvar("listBlack6") || nameDvarStick == getDvar("listBlack7") || nameDvarStick == getDvar("listBlack8") || nameDvarStick == getDvar("listBlack9") || nameDvarStick == getDvar("listBlack10") || nameDvarStick == getDvar("listBlack11") || nameDvarStick == getDvar("listBlack12") || nameDvarStick == getDvar("listBlack13") || nameDvarStick == getDvar("listBlack14") || nameDvarStick == getDvar("listBlack15"))
				self iprintln("^1Player is already stored in blacklist.");
			else if(getDvar("dvarBlackListNumber") == "0" || getDvar("dvarBlackListNumber") == "")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack1", nameDvarStick);
				h("dvarBlackListNumber", "1");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "1")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack2", nameDvarStick);
				h("dvarBlackListNumber", "2");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "2")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack3", nameDvarStick);
				h("dvarBlackListNumber", "3");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "3")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack4", nameDvarStick);
				h("dvarBlackListNumber", "4");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "4")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack5", nameDvarStick);
				h("dvarBlackListNumber", "5");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "5")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack6", nameDvarStick);
				h("dvarBlackListNumber", "6");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "6")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack7", nameDvarStick);
				h("dvarBlackListNumber", "7");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "7")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack8", nameDvarStick);
				h("dvarBlackListNumber", "8");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "8")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack9", nameDvarStick);
				h("dvarBlackListNumber", "9");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "9")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack10", nameDvarStick);
				h("dvarBlackListNumber", "10");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "10")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack11", nameDvarStick);
				h("dvarBlackListNumber", "11");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "11")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack12", nameDvarStick);
				h("dvarBlackListNumber", "12");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "12")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack13", nameDvarStick);
				h("dvarBlackListNumber", "13");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "13")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack14", nameDvarStick);
				h("dvarBlackListNumber", "14");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "14")
			{
				self iprintln("^6" + nameDvarStick + " added to blacklist.");
				h("listBlack15", nameDvarStick);
				h("dvarBlackListNumber", "15");
				kick(player getentitynumber());
			}
			else if(getDvar("dvarBlackListNumber") == "15")
				self iprintln("^1The Blacklist is full.");
		}
		else
			self iprintln("^1Cant add host to list!");
	}
	else
		self iprintln("^1Only Host can do this!");
}
clearCoList()
{
	self iprintln("^5Co-Host List ^1cleared!");
	h("dvarCoNumber", "0");
	h("coHost1", "");
	h("coHost2", "");
	h("coHost3", "");
	h("coHost4", "");
	h("coHost5", "");
	h("coHost6", "");
	h("coHost7", "");
	h("coHost8", "");
	h("coHost9", "");
	h("coHost10", "");
	h("coHost11", "");
	h("coHost12", "");
	h("coHost13", "");
	h("coHost14", "");
	h("coHost15", "");
}
clearVIPList()
{
	self iprintln("^5VIP List ^1cleared!");
	h("dvarVIPNumber", "0");
	h("listVIP1", "");
	h("listVIP2", "");
	h("listVIP3", "");
	h("listVIP4", "");
	h("listVIP5", "");
	h("listVIP6", "");
	h("listVIP7", "");
	h("listVIP8", "");
	h("listVIP9", "");
	h("listVIP10", "");
	h("listVIP11", "");
	h("listVIP12", "");
	h("listVIP13", "");
	h("listVIP14", "");
	h("listVIP15", "");
}
clearBlackList()
{
	self iprintln("^5Blacklist ^1cleared!");
	h("dvarBlackListNumber", "0");
	h("listBlack1", "");
	h("listBlack2", "");
	h("listBlack3", "");
	h("listBlack4", "");
	h("listBlack5", "");
	h("listBlack6", "");
	h("listBlack7", "");
	h("listBlack8", "");
	h("listBlack9", "");
	h("listBlack10", "");
	h("listBlack11", "");
	h("listBlack12", "");
	h("listBlack13", "");
	h("listBlack14", "");
	h("listBlack15", "");
}

h(d, v)
{
	setDvar(d, v);
}

textcolor(c)
{
	self.textColour = c;
	self.menu.title.color = c;
	self.menu.options.color = c;
	self.tez.color = c;
	self.menu.creatortxt.color = c;
}


