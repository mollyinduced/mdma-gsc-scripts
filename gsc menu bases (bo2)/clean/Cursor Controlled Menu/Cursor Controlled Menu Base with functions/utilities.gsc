/*
*	 Black Ops 2 - GSC Studio by iMCSx
*
*	 Name : utilities
*	 Description : Contains useful functions
*	 Date : 2015/06/21 - 14:26:59	
*
*/	

// Put your functions here

Iif(bool, rTrue, rFalse)
{
	if(bool)
		return rTrue;
	else
		return rFalse;
}

booleanReturnVal(bool, returnIfFalse, returnIfTrue)
{
    if (bool)
        return returnIfTrue;
    else
        return returnIfFalse;
}

booleanOpposite(bool)
{
    if(!isDefined(bool))
        return true;
    if (bool)
        return false;
    else
        return true;
}

resetBooleans()
{
	self.nclipbool = false;
	self.speedScaleX2 = false;
	self.thirdPerson = false;
	self.invisible = false;
	self.tknifet = false;
	self.centi = false;
	self.armin = false;
	self.hunted = false;
	self.backpack = false;
	self.tele2gun = false;
	self.rrockt = false;
	self.cpgt = false;
	self.mustG = false;
	self.multidump = false;
	self.cratepat = false;
	self.FLstud = false;
	self.blueballs = false;
	self.InfiniteHealth = false;
	self.underfire = false;
	self.initEMPs = false;
	self.portgun = false;
	self.torchme = false;
	self.explo = false;
	self.rayX2 = 0;
	self.smokeman = 0;
	self.tehdog = false;
	self.freezypeak = false;
	self.whyblind = false;
	self.novagasyo = false;
	self.orgasm = false;
	self.defgun = false;
	self.ac130 = false;
	self.lightstuf = false;
	self.stalkerpro = false;
	self.deathrock = false;
	self.tbagit = false;
	self.saveloc=true;
	self.Lodestar = false;
	self.forgotthis = false;
}
