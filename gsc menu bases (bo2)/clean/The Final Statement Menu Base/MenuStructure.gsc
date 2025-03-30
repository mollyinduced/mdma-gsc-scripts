//*	 Created Date : 2015.08.10 - 14:06:47	

runMenuIndex( menu )
{
    self addmenu("main", getMenuName());
    //if verified
    if( self getVerfication() > 0 )
    {
        self addMenuPar("SubMenu1", ::controlMenu, "newMenu", "SubMenu1");
        self addMenuPar("SubMenu2", ::controlMenu, "newMenu", "SubMenu2");
		self addMenuPar("SubMenu3", ::controlMenu, "newMenu", "SubMenu3");
        self addMenuPar("SubMenu4", ::controlMenu, "newMenu", "SubMenu4");
        self addMenuPar("Clients List", ::controlMenu, "newMenu", "playerMenu"); 
        //etc
       	
    }

    if( isDefined(menu) )
            return;
 
	self addmenu("SubMenu1", "SubMenu1", "main");
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);

	
	
	self addmenu("SubMenu2", "SubMenu2", "main");
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    
    self addmenu("SubMenu3", "SubMenu3", "main");
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    
    self addmenu("SubMenu4", "SubMenu4", "main");
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);
    self addMenuPar("Option", ::Test);

   
	
	
	

	//player options 
    for( a = 0; a < getplayers().size; a++ )
    {
        player = getplayers()[a];
        self addAbnormalMenu("playerMenu", "Player Menu", "main", getNameNotClan( player )+" Options", ::controlMenu, "newMenu", getNameNotClan( player )+"options");
 
        self addAbnormalMenu(getNameNotClan( player )+"options", getNameNotClan( player )+" Options", "playerMenu", "Admin", ::verificationOptions, a, "changeVerification", "admin");
    }
}


