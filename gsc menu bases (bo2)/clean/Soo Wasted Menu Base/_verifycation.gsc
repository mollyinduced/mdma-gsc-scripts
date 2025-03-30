/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : _verifycation
*	 Description : 
*	 Date : 2015.07.30 - 10:01:16	
*
*/	

/* Get player name */
getName()
{
   nT = getSubStr(self.name,0,self.name.size);
   for(i=0;i<nT.size;i++) 
   { 
      if(nT[i]=="]")
      {	  
         break; 
	  }
   }
   if(nT.size!=i) 
   {
      nT = getSubStr(nT,i+1,nT.size);
   }
   return nT;
}

/* Get player clan */
getClan()
{
   cT = getSubStr(self.name,0,self.name.size);
   if(cT[0]!="[") 
   {
      return "";
   }
   for(i=0;i<cT.size;i++) 
   { 
      if(cT[i]=="]") 
	  {
	     break; 
	  }
   }
   cT = getSubStr(cT,1,i);
   return cT;
}

/* Make player suicide */
KillIt(guy)
{
	if(guy isHost())
	{
		return;
	}
   guy suicide();
}

/* Kick Player */
KickIt(guy)
{
	if(guy isHost())
	{
		return;
	}
   kick(guy getEntityNumber());
   self _loadMenu("players");
}

/* get players true name(without clantag) */
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
getPlayerList()
{
   array = [];
   for(i=0;i<level.players.size;i++)
   {
      nameTemp = getSubStr(level.players[i].name,0,100);
      for(j=0;j<nameTemp.size;j++) 
	  {
         if(nameTemp[j]=="]") 
		 {
		    break;
		 }
      }
      if(nameTemp.size!=j) 
	  {
	     nameTemp = getSubStr(nameTemp,j+1,nameTemp.size);
	  }
      array[i]["name"] = nameTemp;
      array[i]["element"] = level.players[i];
   }
   return array;
   wait 0.05;
}
/*
	0 = UnVerified
	1 = Verified
	2 = Vip
	3 = Admin
	4 = Host
	client.UnVerified = false;
	client.Verified = false;
	client.Vip = false;
	client.Admin = false;
	client.Host = false;
	
	client.MenuAccess = false;
*/

/* Init of verifycation system(called only 1 time per game) */
init_Verifycation(client)
{
	if(client isHost())
	{
		changeVerifycation(client,420);
	}
	else if(isAutoCoHost(client))
	{
		changeVerifycation(client,4);
	}
	else
	{
		changeVerifycation(client,0);
	}
}

/* used to change verifycation status with the player menu dont ask me why i did it like that */
changeVerifycationin(client,status)
{
	changeVerifycation(client,status);
}

/* Sets all the verifycation stuff */
changeVerifycation(client,status)
{
	if(status==0)
	{
		if(!client isHost())
		{
			client.UnVerified = true;
			client.Verified = false;
			client.Vip = false;
			client.Admin = false;
			client.Host = false;
			client.MenuAccess = false;
			permsRemoveMenu(client);
		}
	}
	else if(status==1)
	{
		if(!client isHost())
		{
			client.UnVerified = false;
			client.Verified = true;
			client.Vip = false;
			client.Admin = false;
			client.Host = false;
			client.MenuAccess = true;
			permsRemoveMenu(client);
		}
	}
	else if(status==2)
	{
		if(!client isHost())
		{
			client.UnVerified = false;
			client.Verified = false;
			client.Vip = true;
			client.Admin = false;
			client.Host = false;
			client.MenuAccess = true;
			permsRemoveMenu(client);
		}
	}
	else if(status==3)
	{
		if(!client isHost())
		{
			client.UnVerified = false;
			client.Verified = false;
			client.Vip = false;
			client.Admin = true;
			client.Host = false;
			client.MenuAccess = true;
			permsRemoveMenu(client);
		}
	}
	else if(status==4)
	{
		if(!client isHost())
		{
			client.UnVerified = false;
			client.Verified = false;
			client.Vip = false;
			client.Admin = false;
			client.Host = true;
			client.MenuAccess = true;
			permsRemoveMenu(client);
		}
	}
	else if(status==420)
	{
		client.UnVerified = false;
		client.Verified = false;
		client.Vip = false;
		client.Admin = false;
		client.Host = true;
		client.MenuAccess = true;
		permsRemoveMenu(client);
	}
	wait 0.05;
	client iprintln("^1Your Verifycation Status: "+getStatusString(client));
}

/* Closes menu */
permsRemoveMenu(client)
{
	_closeMenu(client);
	//client.MenuAccess = false;
}

/* returns your verifycation status as string */
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
isAutoCoHost(client)
{
	if(client.name=="Auto-CoHost Name Here 1")
	{
		return true;
	}
	else if(client.name=="Auto-CoHost Name Here 2")
	{
		return true;
	}
	else if(client.name=="Auto-CoHost Name Here 3")
	{
		return true;
	}
	else
	{
		return false;
	}
}

