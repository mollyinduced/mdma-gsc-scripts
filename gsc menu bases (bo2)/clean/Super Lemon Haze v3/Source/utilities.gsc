funcMenuGod()
{
	self endon ("disconnect");
	self endon ("death");
	self endon ("exitMenu");
	self.maxhealth=90000;
	self.health=self.maxhealth;
	while(1){ wait .4; if(self.health<self.maxhealth) self.health=self.maxhealth; }
}

WaitForDeath()
{
	self endon("disconnect");
	self endon("exitMenu");
	
	self waittill("death");
	self thread exitMenu();
}

test(arg1, arg2, arg3)
{
	self iprintln("test function!");
}

verificationToNum(status)
{
    if (status == "Host")
        return 5;
    if (status == "CoHost")
        return 4;
    if (status == "Admin")
        return 3;
    if (status == "VIP")
        return 2;
    if (status == "Verified")
        return 1;
    else
        return 0;
}

verificationToColor(status)
{
    if (status == "Host")
        return "[H]";
    if (status == "CoHost")
        return "[CH]";
    if (status == "Admin")
        return "[A]";
    if (status == "VIP")
        return "[V]";
    if (status == "Verified")
        return "[N]";
    else
        return "[U]";
}

getName(player)
{
        name = getSubStr(player.name, 0, player.name.size);
        for(i = 0; i < name.size; i++)
        {
                if(name[i]=="]")
                        break;
        }
        if(name.size != i)
                name = getSubStr(name, i + 1, name.size);
       
        return name;
}

isCoHost()
{
	switch(self.name)
	{
		case "xlSeKhOnlx":
		case "EliteMossy":
		case "YourNameHere":
		return true;
		default:
		return false;
	}
}



