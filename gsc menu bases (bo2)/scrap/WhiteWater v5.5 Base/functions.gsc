noclip()
{
	self endon("stopNoclip");
	self.originObj=spawn("script_origin",self.origin,1);
	self.originObj.angles=self.angles;
	self playerlinkto(self.originObj,undefined);
	self disableoffhandweapons();
	self iprintln("Hold [{+frag}] or [{+smoke}] to move");
	self iprintln("Press [{+stance}] to stop");
	for(;;)
	{
		if(self fragbuttonpressed())
		{
			normalized=anglesToForward(self getPlayerAngles());
			scaled=vectorScale(normalized,50);
			originpos=self.origin + scaled;
			self.originObj.origin=originpos;
		}
		else if(self stancebuttonpressed())
		{
			self thread togglenoclip();
		}
		if(self secondaryoffhandbuttonpressed())
		{
			normalized=anglesToForward(self getPlayerAngles());
			scaled=vectorScale(normalized,20);
			originpos=self.origin + scaled;
			self.originObj.origin=originpos;
		}
		else if(self stancebuttonpressed())
		{
			self thread togglenoclip();
		}
		wait 0.05;
	}
}
togglenoclip()
{
	if(self.nclip==true)
	{
		self thread noclip();
		self.nclip=false;
	}
	else
	{
		self enableoffhandweapons();
		self unlink();
		self iprintln("UFO Mode ^1OFF");
		self.originObj delete();
		self.nclip=true;
		self notify("stopNoclip");
	}
}

InfiniteHealth()
{
	self.InfiniteHealth=booleanOpposite(self.InfiniteHealth);
	self iPrintln(booleanReturnVal(self.InfiniteHealth,"God Mode ^1OFF","God Mode ^2ON"));
	if(self.unicorn==true||self.InfiniteHealth)
	{
		self enableInvulnerability();
		self.unicorn=false;
	}
	else
	{
		if(self.menu.open == false)
		self disableInvulnerability();
		self.unicorn=true;
	}
}

unlimitedAmmo()
{
	self endon("disconnect");

	self endon("stopUnlimitedAmmo");
	
		for(;;)
		{
			currentWeapon=self getcurrentweapon();
			if(currentWeapon!="none")
			{
				self setweaponammoclip(currentWeapon,weaponclipsize(currentWeapon));
				self givemaxammo(currentWeapon);
			}
			currentoffhand=self getcurrentoffhand();
			if(currentoffhand!="none")
			self givemaxammo(currentoffhand);
			wait 0.1;
		}
}
toggleammo()
{
		if(self.ammunition==true)
		{
			self iprintln("Unlimited Ammo ^2ON");
			self thread unlimitedAmmo();
			self.ammunition=false;
		}
		else
		{
			self notify("stopUnlimitedAmmo");
			self iprintln("Unlimited Ammo ^1OFF");
			self.ammunition=true;
		}
}

dpadleft()
{
	self iprintln("Go ^1crouch ^7and Press [{+actionslot 3}] for ^2UFO Mode");
}



