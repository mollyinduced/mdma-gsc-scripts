//Working But the problem was with the player menu...

Givemenu(owner)
{
	if(!owner isHost())
	{
		owner thread Settings();
	}
	else { owner iprintln("You cant change the Access level of the ^2Host"); }
}

TakeMenu(owner)
{
	if(!owner isHost())
	{
		if(owner.inMenu == 1)
		{
			owner CloseMenu();
		}
		wait .15;
		owner notify("menu_taken");
	}
	else { owner iprintln("You cant change the Access level of the ^2Host"); }
}

GetName(name)// sry i was away :D
{
	if(!isDefined(name))
	{
		name = self.name;
	}
	if(isSubStr(name, "]"))
	{
		name = strTok(name, "]");
		return name[name.size - 1];
	}
	else { return name; }
}






