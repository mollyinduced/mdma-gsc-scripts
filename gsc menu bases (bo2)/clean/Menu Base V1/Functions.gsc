getName()
{

	nT=getSubStr(self.name,0,self.name.size);

	for(i=0;i<nT.size;i++)

	{

		if(nT=="]")

			break;

	}

	if(nT.size!=i)

		nT=getSubStr(nT,i+1,nT.size);

	

	return nT;
	}
	
	LobbyInfo()
	{
		self.lobbyText = createFontString("console", 1.6);
 	         self.lobbyText setPoint("LEFT", "CENTER", -300, -30);
 	         self.lobbyText setText("Lobby Information:");
 	         
		self.mapText = createFontString("console", 1.6);
 	         self.mapText setPoint("LEFT", "CENTER", -300, -20);
 	         
 	         if (map( "mp_nuketown_2020"))
 	         {
    		self.mapText setText("Map: Nuketown");
    		}
    		
    		  if (map("mp_hijacked")) 
 	         {
    		self.mapText setText("Map: Hijacked");
    		}
	}
