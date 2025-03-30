/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : functions
*	 Description : Includes all custom functions
*	 Date : 2015/06/21 - 12:23:27	
*
*/

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

getNamePlayer(player)
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

test()
{
	self iprintln("ran test function");
}
