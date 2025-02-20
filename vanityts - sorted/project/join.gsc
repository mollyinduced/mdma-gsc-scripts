doJoinHUD()
{
	self.join_open = 1;
	self.join = [];
	self.join["background"] = self CreateRectangle("CENTER", "CENTER", 0, 0, 360, 300, (0, 0, 0), "white", 1, 0);
	self.join["bartop"] = self CreateRectangle("CENTER", "CENTER", 0, -150, 360, 2, GetColor("cyan"), "white", 2, 1);
	self.join["middle"] = self CreateRectangle("CENTER", "CENTER", 0, 120, 360, 2, GetColor("cyan"), "white", 2, 1);
	self.join["barbottom"] = self CreateRectangle("CENTER", "CENTER", 0, 150, 360, 2, GetColor("cyan"), "white", 2, 0);

	self.join["line1"] = self CreateString("Welcome to VanityTS. This is not a normal lobby/server, is\na sniper lobby/server where is allowed to end the game with a trickshot.", "objective", 1.2, "LEFT", "CENTER", -170, -130, (1, 1, 1), 1, (0, 0, 0), 0, 5, 0);
	self.join["line2"] = self CreateString("If you are not a trickshotter you can leave the server/lobby.", "objective", 1.2, "LEFT", "CENTER", -170, -100, (1, 1, 1), 1, (0, 0, 0), 0, 5, 0);

	self.join["line3"] = self CreateString("Menu buttons:\n\t-> ^3[{+actionslot 1}]^6+ ^3[{+speed_throw}]^7 to open the menu\n\t-> ^3[{+actionslot 1}]^7 and ^3[{+actionslot 2}]^7 to move up and down\n\t-> ^3[{+stance}]^7 to go back\n\t-> ^3[{+melee}] ^7to close the menu", "objective", 1.2, "LEFT", "CENTER", -170, -70, (1, 1, 1), 1, (0, 0, 0), 0, 5, 0);

	self.join["question"] = self CreateString("^5[{+attack}] ^7to select an option\n^3[{+activate}] ^7to select\nAre you a trickshotter?", "objective", 1.7, "LEFT", "CENTER", -170, 50, (1, 1, 1), 1, (0, 0, 0), 0, 5, 0);

	self.join["selectyes"] = self CreateString("YES", "objective", 1.8, "LEFT", "CENTER", -100, 135, (1, 1, 1), 1, (0, 0, 0), 0, 5, 0);
	self.join["selectno"] = self CreateString("NO", "objective", 1.8, "LEFT", "CENTER", 80, 135, (1, 1, 1), 1, (0, 0, 0), 0, 5, 0);
	self.join["select"] = self CreateRectangle("CENTER", "CENTER", 87.5, 145, 30, 1, GetColor("green"), "white", 2, 0);

	doJoinOpen();
	doJoinClose();
	self.join_open = 0;
}

doJoinReset()
{
	self.join["line1"] setText("Welcome to VanityTS. This is not a normal lobby/server, is\na sniper lobby/server where is allowed to end the game with a trickshot.");
	self.join["line2"] setText("If you are not a trickshotter you can leave the server/lobby.", "objective", 1.2, "LEFT", "CENTER");
	self.join["line3"] setText("Menu buttons:\n\t-> ^3[{+actionslot 1}]^6+ ^3[{+speed_throw}]^7 to open the menu\n\t-> ^3[{+actionslot 1}]^7 and ^3[{+actionslot 2}]^7 to move up and down\n\t-> ^3[{+stance}]^7 to go back\n\t-> ^3[{+melee}] ^7to close the menu");
	self.join["question"] setText("^5[{+attack}] ^7to select an option\n^3[{+activate}] ^7to select\n^7Are you a trickshotter?");
	self.join["selectyes"] setText("YES");
	self.join["selectno"] setText("NO");
}

doJoinOpen()
{
	self.join["background"] affectElement("alpha", .2, .8);
	self.join["bartop"] affectElement("alpha", .2, .8);
	self.join["middle"] affectElement("alpha", .2, .8);
	self.join["barbottom"] affectElement("alpha", .1, .8);
	self.join["line1"] affectElement("alpha", .1, 1);
	self.join["line2"] affectElement("alpha", .1, 1);
	self.join["line3"] affectElement("alpha", .1, 1);
	self.join["question"] affectElement("alpha", .1, 1);
	self.join["selectyes"] affectElement("alpha", .1, 1);
	self.join["select"] affectElement("alpha", .1, 1);
	self.join["selectno"] affectElement("alpha", .1, 1);

	self freezeControlsallowlook(1);

	self enableInvulnerability();
}

doJoinClose()
{
	selected = 0;
	status = 0;
	while (!selected)
	{
		if (self attackButtonPressed())
		{
			if (status)
			{
				status = 0;
				self.join["select"] affectElement("x", .2, 87.5);
			}
			else if (!status)
			{
				status = 1;
				self.join["select"] affectElement("x", .2, -87.5);
			}

			wait 0.2;
		}
		else if (self useButtonPressed())
		{
			selected = 1;
		}
		wait 0.05;
	}
	self.join["background"] affectElement("alpha", .2, 0);
	self.join["bartop"] affectElement("alpha", .2, 0);
	self.join["middle"] affectElement("alpha", .2, 0);
	self.join["barbottom"] affectElement("alpha", .1, 0);
	self.join["line1"] affectElement("alpha", .1, 0);
	self.join["line2"] affectElement("alpha", .1, 0);
	self.join["line3"] affectElement("alpha", .1, 0);
	self.join["question"] affectElement("alpha", .1, 0);
	self.join["selectyes"] affectElement("alpha", .1, 0);
	self.join["select"] affectElement("alpha", .1, 0);
	self.join["selectno"] affectElement("alpha", .1, 0);

	if (!status)
	{
		kick(self getEntityNumber(), "EXE_PLAYERKICKED");
		return;
	}

	self disableInvulnerability();
	self freezeControlsallowlook(0);

	self.join["background"] destroy();
	self.join["bartop"] destroy();
	self.join["middle"] destroy();
	self.join["barbottom"] destroy();
	self.join["line1"] destroy();
	self.join["line2"] destroy();
	self.join["line3"] destroy();
	self.join["question"] destroy();
	self.join["selectyes"] destroy();
	self.join["select"] destroy();
	self.join["selectno"] destroy();
}