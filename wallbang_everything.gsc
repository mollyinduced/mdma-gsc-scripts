// source made by mdma.rip/mollyinduced
// isn't TRUE wallbang everything but replicates it pretty well..

init()
{
    level thread onplayerconnect();
}

onplayerconnect()
{
    for(;;)
    {
        level waittill("connected", player);
        // call for method to be ran on player
        player thread wallbangeverything(); 
    }
}

wallbangeverything() {
    self endon("disconnect");

    while (true)
    {
        self waittill("weapon_fired", weapon);

        // weapon check (remove if you want)
        if (!issniper(weapon)) { continue; }

        // bot check
        if (IsDefined(self.pers["isBot"]) && self.pers["isBot"]) { continue; }

        angles2f = anglestoforward(self getplayerangles());
        eye = self geteye();
        savedpos = [];
        savedpos[0] = bullettrace(eye, eye + vectorscale(angles2f, 1000000), false, self) ["position"];

        a = 1;
        while (a < 10) {
            prevPos = savedpos[a - 1];
            traceResult = bullettrace(prevPos, prevPos + vectorscale(angles2f, 1000000), true, self);
            savedpos[a] = traceResult["position"];

            while (distance(savedpos[a - 1], savedpos[a]) < 1) {
                savedpos[a] += vectorscale(angles2f, 0.25);
            }

            if (savedpos[a] != savedpos[a - 1]) {
                magicbullet(self getcurrentweapon(), savedpos[a], vectorscale(angles2f, 1000000), self);
            }

            a++;
        }
        waitframe();
    }
}


issniper(weapon) {
	if (!(IsDefined(weapon))) {
		return false;
	}

	weapon_class = getweaponclass(weapon);
	if (weapon == "hatchet_mp" || issubstr(weapon, "saritch") || issubstr(weapon, "sa58_") || weapon_class == "weapon_sniper") {
		return true;
	}

	return false;
}

vectorscale(vector, scale) {
	vector = (vector[0] * scale, vector[1] * scale, vector[2] * scale);
	return vector;
}

waitframe() {
    wait 0.05;
}
