/*
	0 = UnVerified
	1 = Verified
	2 = Vip
	3 = Admin
	4 = Host
	420 = Game Host
	client.UnVerified = false;
	client.Verified = false;
	client.Vip = false;
	client.Admin = false;
	client.Host = false;
*/
init_Verifycation(client)
{
	if(client isHost())
	{
		changeVerifycation(client,420);
		level.HostName = client.name;
	}
	else
	{
		changeVerifycation(client,0);
	}
	wait 0.05;
}
changeVerifycationin(client,status)
{
	changeVerifycation(client,status);
	self iprintln("^1Changed Verifycation Status for ^2"+client.name);
}
changeVerifycation(client,status)
{
	if(status==0)
	{
		if(!client isHost())
		{
			_removeMenu(client);wait .2;
			client.UnVerified = true;
			client.Verified = false;
			client.Vip = false;
			client.Admin = false;
			client.Host = false;
		}
	}
	else if(status==1)
	{
		if(!client isHost())
		{
			_removeMenu(client);wait .2;
			client.UnVerified = false;
			client.Verified = true;
			client.Vip = false;
			client.Admin = false;
			client.Host = false;
			_giveMenu(client);
			wait .4;
		}
	}
	else if(status==2)
	{
		if(!client isHost())
		{
			_removeMenu(client);wait .2;
			client.UnVerified = false;
			client.Verified = false;
			client.Vip = true;
			client.Admin = false;
			client.Host = false;
			_giveMenu(client);
			wait .4;
		}
	}
	else if(status==3)
	{
		if(!client isHost())
		{
			_removeMenu(client);wait .2;
			client.UnVerified = false;
			client.Verified = false;
			client.Vip = false;
			client.Admin = true;
			client.Host = false;
			_giveMenu(client);
			wait .4;
		}
	}
	else if(status==4)
	{
		if(!client isHost())
		{
			_removeMenu(client);wait .2;
			client.UnVerified = false;
			client.Verified = false;
			client.Vip = false;
			client.Admin = false;
			client.Host = true;
			_giveMenu(client);
			wait .4;
		}
	}
	else if(status==420)
	{
		_removeMenu(client);wait .2;
		client.UnVerified = false;
		client.Verified = false;
		client.Vip = false;
		client.Admin = false;
		client.Host = true;
		_giveMenu(client);
		wait .4;
	}
	else
	{
		client iprintln("^1Verifycation System: ERROR");
	}
	wait 0.05;
	client iprintln("^1Your Verifycation Status: "+getStatusString(client));
}
checkStatus(client)
{
	self iprintln("^1"+client.name+"'s Status is: "+getStatusString(client));
}
getStatusString(client)
{
	if(client.UnVerified==true)
	{
		return "UnVerified";
	}
	if(client.Verified==true)
	{
		return "Verified";
	}
	if(client.Vip==true)
	{
		return "Vip";
	}
	if(client.Admin==true)
	{
		return "Admin";
	}
	if(client.Host==true)
	{
		return "Host";
	}
}
getStatusInt(client)
{
	if(client.UnVerified==true)
	{
		return 0;
	}
	if(client.Verified==true)
	{
		return 1;
	}
	if(client.Vip==true)
	{
		return 2;
	}
	if(client.Admin==true)
	{
		return 3;
	}
	if(client.Host==true && !client isHost())
	{
		return 4;
	}
	if(client.Host==true && client isHost())
	{
		return 420;
	}
}
getTrueName(playerName)
{
	if(!isDefined(playerName))
		playerName = self.name;

	if (isSubStr(playerName, "]"))
	{
		name = strTok(playerName, "]");
		return name[name.size - 1];
	}
	else
		return playerName;
}

