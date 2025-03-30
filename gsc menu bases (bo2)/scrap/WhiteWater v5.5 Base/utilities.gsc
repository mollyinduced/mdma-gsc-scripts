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

test()
{
	self iprintln("^1This Isnt An Option Retard");
}

resetBooleans()
{
	self.InfiniteHealth = false;
}



