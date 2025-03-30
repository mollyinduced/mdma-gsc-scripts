loadClientVars()
{
	self.eMenu["Select_Colour"] = (0,1,0);
	self.eMenu["Curs_Colour"] = (1,1,1);
	self.eMenu["Main_Colour"] = (1,0,0);
	self.eMenu["Bg_Colour"] = (0,0,0);
	self.eMenu["Opt_Colour"] = (1,1,1);
	self.eMenu["Opt_BG_Colour"] = (0,0,0);
	self.eMenu["Title_Colour"] = (1,1,1);
}

precacheHuds()
{
	level.rankPrestige = [];
	level.rankBadges = [];

	for(e=0;e<10;e++) level.rankPrestige[level.rankPrestige.size] = "rank_prestige0"+e;
	for(e=10;e<16;e++) level.rankPrestige[level.rankPrestige.size] = "rank_prestige"+e;
	for(e=0;e<55;e++) level.rankBadges[level.rankBadges.size] = tableLookup("mp/rankIconTable.csv",0,e,1);
	
	array_precache(level.rankPrestige,"shader");
	array_precache(level.rankBadges,"shader");
}

array_precache(array, type)
{
	for(e = 0; e < array.size; e++)
	{
		if(type == "model")
			precacheModel(array[e]);
		if(type == "shader")
			precacheShader(array[e]);
		if(type == "item")	
			precacheItem(array[e]);		
		if(type == "effect")
			level._effect[ array[e] ] = loadFx(array[e]);	
	}
}



