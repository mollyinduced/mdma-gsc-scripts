SetVerification(status, player, doPrint)
{
	if (!isDefined(player))
		player = self.SLH.SelectedPlayer;
		
	player endon("disconnect");
	
	if (!player isHost())
	{
        name = getName(player);
        
        if (isinarray(level.Verified, name + "_" + player.MenuAccess))
                arrayremovevalue(level.Verified, level.Verified[returnIndexNum(name + "_" + player.MenuAccess)]);
                
        player.MenuAccess = status;
        
        if (player.MenuIsOpen)
        	player thread exitMenu();
       
        if (status != "Unverified")
        {
                if (!isinarray(level.Verified, name + "_" + player.MenuAccess))
                        level.Verified[level.Verified.size] = name + "_" + player.MenuAccess;
                
                if (doPrint)
                {
                	self iPrintln("You gave " + name + " " + status + " access!");
                	player iPrintln("Your status has changed to: " + status);
                }
                
                if (!self.MenuInit)
                	player thread Verified(ToUpper(player.MenuAccess));
                else
                {
                	player thread Verified(ToUpper(player.MenuAccess));
                	player thread MonitorButtons();
                }
        }
        else
        {
                if (doPrint)
                	self iPrintln("Unverified that bitch!");
                	
                player iPrintln("The Host didn't like how you were using the menu! You've been ^1unverified!");
                
                player notify("stop_listening"); //stops the player's button monitoring
        }
    }
    else
    	self iprintln("Cannot change the host's status!");
}
 
returnIndexNum(string)
{
        index = 0;
        for(i = 0; i < level.Verified.size; i++)
        {
                if (level.Verified[i] == string)
                        index = i;
        }
        return index;
}
 
checkIfVerified()
{
        self endon("disconnect");
       
        foundValue = false;
       
        foreach(arrayvalue in level.Verified)
        {
                if (arrayvalue == getName(self) + "_Unverified" || arrayvalue == getName(self) + "_Verified" || arrayvalue == getName(self) + "_VIP" || arrayvalue == getName(self) + "_Admin" || arrayvalue == getName(self) + "_CoHost")
                {
                        string_name = getName(self);
                        MenuAccess = getSubStr(arrayvalue, string_name.size, arrayvalue.size);
                        foundValue = true;
                       
                        if (MenuAccess == "_Verified")
                                self.MenuAccess = "Verified";
                        if (MenuAccess == "_VIP")
                                self.MenuAccess = "VIP";
                        if (MenuAccess == "_Admin")
                                self.MenuAccess = "Admin";
                        if (MenuAccess == "_CoHost")
                                self.MenuAccess = "CoHost";
                }
        }
}

isVerified()
{
        if (self isHost() || self.MenuAccess == "Verified" || self.MenuAccess == "VIP" || self.MenuAccess == "Admin" || self.MenuAccess == "CoHost")
                return true;
        else
                return false;
}




