//*	 Created Date : 2015.08.10 - 14:05:52	

//shorter

S(i)
{
	if(i=="ar")
		i="^1In the Alpha Version is the "+getOptionName()+" not possible !";
	self iprintln(i);
}
Sb(i)
{
	if(i=="ar")
		i="^1In the Alpha Version is the "+getOptionName()+" not possible !";
	self iprintlnbold(i);
}
L(i)
{
	//self iprintln("                                  ^9*#* ^7"+i+"^7");
}
playSMenu(i)
{
	if(self.menu["Sound"]== true)
		self playsound(i);
}
playSRef(i)
{
	if ( !isDefined( level.zmb_music_states[ i ] ) )
		self playsound( level.zmb_music_states[ i ].music );
	else
		self playsound( level.zombie_sounds[ i ] );
	S("Sound ("+getOptionName()+") ^2Played");
}
playS(i)
{
	self playsound(i);
	S("Sound ("+getOptionName()+") ^2Played");
}
StopSoundsAtSelf()
{
	self stopsounds();
	S("Sound ^2Stoped");
}
setO(i)
{
	self setOrigin(i);
}
NormalisedTrace(type)
{
    struct = self getS(9999);
    return bullettrace(struct.start, struct.end, false, undefined)[type];
}
 
getS(scale)
{
        forward = anglestoforward(self getplayerangles());
        struct = spawnstruct();
        struct.start = self geteye();
        struct.end = struct.start + vectorScale(forward, scale);
        return struct;
}
 
setVar(var,opt)
{
	if(var == "cg_fov")
		self setclientfov(opt);
	setDvar(var,opt);
	self S(""+getOptionName()+"");
}
//getter
getCurrent()
{
    return self.menu["currentMenu"];
}
 
getLocked()
{
    return self.menu["isLocked"];
}
 
getUserIn()
{
    return self.playerSetting["isInMenu"];
}
 
getCursor()
{
    return self.menu["curs"][getCurrent()];
}

getOptionName()
{
	return self.menu["items"][self getCurrent()].name[self getCursor()];
}
getZombz()
{
	return GetAiSpeciesArray( "axis", "all" );
}
getVending()
{
	return GetEntArray("zombie_vending", "targetname");
}
getWeapons()
{
	return GetEntArray("weapon_upgrade", "targetname");
}

//var
isEmpty(var)
{
	if(var == "" || !isDefined(var))
		return true;
	else
		return false;
}

//menu UI utilities
createText(fontSize, sorts, text, align, relative, x, y, alpha, color)
{
    uiElement = self createfontstring(getMenuTextFontType(), fontSize);
    uiElement setPoint(align, relative, x, y);
    uiElement settext(text);
    uiElement.sort = sorts;
    uiElement.hideWhenInMenu = true;
    if( isDefined(alpha) )
        uiElement.alpha = alpha;
        uiElement.color = getMenuTextColor();
 	//Overflow fix
 	uiElement.type = "text";
  	addTextTableEntry(uiElement, getStringId(text));
  	uiElement setSafeText(self, text);
    return uiElement;
}
 
createRectangle(align, relative, x, y, width, height, color, sort, alpha, shader)
{
    uiElement = newClientHudElem( self );
    uiElement.elemType = "bar";
    uiElement.width = width;
    uiElement.height = height;
    uiElement.align = align;
    uiElement.relative = relative;
    uiElement.xOffset = 0;
    uiElement.yOffset = 0;
    uiElement.children = [];
    uiElement.sort = sort;
    uiElement.color = color;
    uiElement.alpha = alpha;
    uiElement setParent( level.uiParent );
    uiElement setShader( shader, width , height );
    uiElement.hidden = false;
    uiElement.hideWhenInMenu = true;
    uiElement setPoint(align,relative,x,y);
    return uiElement;
}
 
affectElement(type, time, value)
{
    if( type == "x" || type == "y" )
        self moveOverTime( time );
    else
        self fadeOverTime( time );
 
    if( type == "x" )
        self.x = value;
    if( type == "y" )
        self.y = value;
    if( type == "alpha" )
        self.alpha = value;
    if( type == "color" )
        self.color = value;
}
getNameNotClan( player )
{
    for( a = 0; a < player.name.size; a++ )
    {
        if( player.name[a] == "[" )
            return getSubStr(player.name , 6, player.name.size);
        else
            return player.name;
    }
}


// if-/gets 
isSprinting()
{
	v = self getVelocity();
	if(v[0] >= 200 || v[1] >= 200 || v[0] <= -200 || v[1] <= -200)
		return true;
	return false;
}
getMap(i)
{
if(isEmpty(i))
	return level.script;
else if(i==level.script)
	return true;
else if(!i==level.script)
	return false;
}
getMapName() // name der map
{
if(getMap() == "zm_transit")
	return "Transit";
else if(getMap() == "zm_nuked")
	return "Nuketown Zombies";
else if(getMap() == "zm_highrise")
	return "Die Rise";
else if(getMap() == "zm_prison")
	return "Mob of the dead";
else if(getMap() == "zm_buried")
	return "Buried";
else if(getMap() == "zm_tomb")
	return "Origins";
else
	return level.script;
}
/*
 zm_nuked   - Nuketown
 zm_transit  - Tranzit
 zm_highrise - Die Rise   
 zm_prison  - MOTD  
 zm_buried  - Buried
 zm_tomb    - Origins
*/
getBulletTracePos()
{
	return BulletTrace(self gettagorigin("tag_eye"), anglestoforward(self getPlayerAngles())* 1000000, true, self)["position"];
}
isSolo()
{
	if(getPlayers().size <= 1)
		return true;
	return false;
}
arrayIntRandomize(min, max)
{
	array = [];
	for(m = min; m <= max; m++)
		array[m] = min+m;
	int = array_randomize(array);
	return(int);
}
frame()
{
	wait .05;
}

getMenuName()
{
return self.menuName;
}
/* NOT SURE
isConsole()
{
	if(level.xenon || level.ps3)
		return true;
	return false;
}
*/
getMenuColor()
{
return self.menu["color"];
}
setMenuColor(i)
{
if(getMenuColor() == i)
	return;
self.menu["color"] = i;
self.menu["ui"]["scroller"] fadeovertime(.5);
self.menu["ui"]["barTop"] fadeovertime(.5);
self.menu["ui"]["scroller"].color = getMenuColor();
self.menu["ui"]["barTop"].color = getMenuColor();
}
getMenuTextColor()
{
return self.menu["text_color"];
}
setMenuTextColor(i)
{
self.menu["text_color"] = i;
self.menu["ui"]["title"] affectElement("color", .5, getMenuTextColor());
for( a = 0; a < 7; a ++ )
{
		self.menu["ui"]["text"][a] affectElement("color", .5, getMenuTextColor());
}
}
getMenuTextFontType()
{
return self.menu["font"];
}
setMenuTextFontType(i)
{
if(getMenuTextFontType() == i)
	return;
self.menu["isLocked"] = true;
for( a = 7; a >= 0; a-- )
self.menu["ui"]["text"][a] destroy();
self.menu["ui"]["title"] destroy();
self.menu["font"] = i;
self buildTextOptions(getCurrent());
self.menu["isLocked"] = false;
}

//mover getter and setter 

getXPos()
{
	return self.menu["postion"]["X"];
}
getYPos()
{
	return self.menu["postion"]["Y"];
}
setXPos(i)
{
	if(getXPos() == i)
		return;
	self.menu["postion"]["X"] = i;
}
setYPos(i)
{
	if(getYPos() == i)
		return;
	self.menu["postion"]["Y"]= i;
}


//waiter

getWaitTime()
{
return self.menu["waiterToCounine"];
}
setWaitTime(i)
{
self.menu["waiterToCounine"]=i;
wait i;
self.menu["waiterToCounine"]=false;
}



//helper
vector_scal(vec,scale)
{
        vec=(vec[0] * scale,vec[1] * scale,vec[2] * scale);
        return vec;
}



//zombz

ThreadAtAllZombz(function,input,input2)
{
	for (i = 0; i < getZombz().size; i++)
	{
		getZombz()[i] [[function]](input,input2);
	}
}



//Fxs helper

getRandomPos(value,value_z)
{
if(isEmpty(value_z))
	value_z = 0;
return self.origin + (randomintrange(0-value,value),randomintrange(0-value,value),value_z);
}








