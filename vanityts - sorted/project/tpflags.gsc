CreateFlag(origin, end)
{
	/*object = spawnstruct();
	object.type = "flag";
	object.triggertype = "triggertype";*/
	
	trigger = spawn("trigger_radius_use", origin + (0, 0, 70), 0, 72, 64);
	trigger sethintstring("Press ^3[{+activate}] ^7to teleport");
	trigger setcursorhint("HINT_NOICON");
	trigger usetriggerrequirelookat();
	trigger triggerignoreteam();
	trigger thread DestroyOnEndGame();

	//object.entnum = trigger getentitynumber();

	teleport = spawn("script_model", origin);
	teleport setmodel("mp_flag_allies_1");
	teleport thread TeleportPlayer(trigger, end);
	teleport thread DestroyOnEndGame();

	if(!isDefined(level.tp_flags)) level.tp_flags = 0;
	else level.tp_flags++;

	attach2DIcon(teleport, level.tp_flags, "waypoint_recon_artillery_strike");
}

attach2DIcon(object, objectiveid, icon) 
{
	/*
		object		: It rappresent the model and not the trigger
		objectiveid	: It is an index and must be numeric
		icon		: It is the shader name
	*/
	objective_add( objectiveid, "active", object.origin );
	objective_icon( objectiveid, icon);
	if(isDefined(object))
	{
		objective_onentity( objectiveid, object );
	}
}

IsPlayerOnLast()
{
	return (self.pers["pointstowin"] >= level.scorelimit - 1 || self.pers["pointstowin"] >= level.scorelimit - 2);
}
TeleportPlayer(trigger, end)
{
	level endon("game_ended");
	while (isDefined(self))
	{
		trigger waittill("trigger", player);
		if (player IsPlayerOnLast())
		{
			player setOrigin(end);
		}
	}
}
SpawnFlags()
{
	switch (getDvar("mapname"))
	{
	case "mp_la":
		CreateFlag((115, -1068, -267), (-724, -1196, 115));
		CreateFlag((-2570, 2395, -196), (-2996, 2544, 116));
		CreateFlag((89.3533, 5266.31, -262.875), (-638.706, 7642.99, 90.1037));
		CreateFlag((-1611.1, -1011.22, -259.875), (-1751.25, -1514.88, -76.5663));
		break;
	case "mp_slums":
		/*CreateFlag((592, 1455, 616), (1052, 1683, 1007));
		CreateFlag((-943, 1358, 584), (-1702, 1512, 1099));
		CreateFlag((-640, -1059, 552), (-1873, -1233, 1049));*/
		CreateFlag((-805.27, -2596.34, 456.125), (-2865.69, -3182.58, 1175.8));
		CreateFlag((-2839.7, -3450.88, 923.125), (-2821.34, -3201.16, 1177.62));
		CreateFlag((916.676, -3376.11, 462.125), (719.575, -3675.91, 1111.55));
		CreateFlag((-439.816, -4126, 942.611), (54.167, -6096.26, 1010.34));
		CreateFlag((-1774.92, -6552.17, 668.125), (-1519.55, -6870.55, 858.002));
		CreateFlag((-937, -714.645, 552.199), (-3371.59, -317.162, 1263.24));
		CreateFlag((-4293.54, -2276.81, 1185.13), (-4652.56, -1040.84, 1310.41));
		CreateFlag((-4293.54, -2276.81, 1185.13), (-4652.56, -1040.84, 1310.41));
		CreateFlag((-181.476, 2178.16, 584.125), (-168.239, 3266.75, 1431.4));
		CreateFlag((1238.67, -1525.03, 504.125), (3062.1, -1374.25, 1069.99));
		CreateFlag((1214.01, -105.558, 584.125), (2872.77, 580.469, 1054.13));
		CreateFlag((453.408, 2173.72, 584.125), (2970.53, 1203.75, 1141.52));
		break;
	case "mp_dockside":
		CreateFlag((-921, 3692, -67), (-2948, 2970, -55));
		CreateFlag((1043, 536, -67), (2239, 481, -67));
		CreateFlag((-133, 4192, -67), (-744, 5121, 228));
		CreateFlag((1348.72, 1160.29, -67.875), (6680.57, 837.092, 327.098));
		CreateFlag((-227.141, 4835.31, -67.875), (831.962, 6097.86, 320.084));
		break;
	case "mp_nuketown_2020":
		CreateFlag((-1912.92, 623.333, -63.875), (-1935.44, 867.489, 76.4663));
		CreateFlag((-1912.92, 623.333, -63.875), (-1935.44, 867.489, 76.4663));
		CreateFlag((-1640, 80, -63), (-1518, -1170, 66));
		CreateFlag((924.269, -869.839, -63.4909), (46.9927, -6059.45, 360.466));
		CreateFlag((1969.34, 444.293, -60.8312), (2528.86, -660.694, 397.717));
		CreateFlag((1547.97, 1112.66, -55.875), (2421.14, 1154.5, 147.693));
		CreateFlag((1526.37, -1088.99, -62.7715), (2210.21, -5568.56, 672.664));
		CreateFlag((-257.514, -760.008, -60.2973), (53.4138, -1627.69, 610.889));
		CreateFlag((1547.86, -88.1327, -63.7798), (1059.87, -494.301, 108.637));
		break;
	case "mp_paintball":
		CreateFlag((-1457, 63, 0), (-1643, -340, 241));
		CreateFlag((798, 1607, 48), (472, 1783, 272));
		CreateFlag((917, -1114, 136), (1107, -615, 264));
		CreateFlag((711, -2459, 0), (2256, -2893, -5));
		CreateFlag((2378, -3538, 0), (2444, -3357, 200));
		CreateFlag((991, 194, 136), (1180, 994, 300));
		CreateFlag((1547.52, -2309.93, 0.125), (1530.01, -2325.91, 537.031));
		CreateFlag((-1482.97, 2141.68, 3.9069), (-1431.58, 2136.67, 505.538));
		CreateFlag((-541.152, -1856.63, -0.510965), (-768.159, -1843.12, 267.625));
		CreateFlag((-946.332, -1848.46, -5.875), (-797.35, -1852.18, 267.625));
		CreateFlag((-701.73, -314.426, 46.125), (-1148.14, -323.916, 152.125));
		break;
	case "mp_pod":
		CreateFlag((1332, -1125, 260), (1210, -1592, 513));
		CreateFlag((1183, 115, 245), (3683, 3006, 1994));
		CreateFlag((-1902, 2154, 482), (-2134, 2755, 480));
		CreateFlag((269, 851, 334), (1484, 3486, 1778));
		CreateFlag((486.3, -80.5827, 241.037), (1470.01, 3489.26, 1778.13));
		break;
	case "mp_drone":
		CreateFlag((-2007, -1973, 80), (-2084, -2585, 80));
		CreateFlag((1025, 3557, 302), (974, 4152, 305));
		break;
	case "mp_carrier":
		CreateFlag((-6471, 704, -75), (-6359, 300, -175));
		CreateFlag((-3066, 804, 44), (-2964, 901, -67));
		CreateFlag((-2353, -312, 44), (-548, -988, -267));
		CreateFlag((-6003.11, -899.634, -83.875), (-6396.31, -649.565, -207.963));
		break;
	case "mp_concert": // Encore
		CreateFlag((2172, 1881, 24), (2501, 2061, 0));
		CreateFlag((842, 2868, 24), (1206, 2820, 448));
		CreateFlag((556, 2186, 24), (1677, 3378, 32));
		CreateFlag((1224, 326, 24), (599, 725, 148));
		CreateFlag((-2303, 428, -69), (-2827, -404, -119));
		CreateFlag((-2763.82, 1161.65, -8.0255), (-4407.76, 732.532, 314.339));
		break;
	case "mp_downhill":
		CreateFlag((689, -2693, 1088), (513, -7092, 1732));
		CreateFlag((1655, 2411, 1114), (1193, 4117, 1467));
		break;
	case "mp_socotra": // Yamen
		CreateFlag((-1372, -517, 206), (-2152, -278, 620));
		CreateFlag((-666, -855, 288), (-693, -978, 424));
		CreateFlag((985, 2233, 315), (877, 2798, 1165));
		CreateFlag((614, 2636, 293), (877, 2798, 1165));
		CreateFlag((2223.3, 912.379, 208.611), (4706.59, 2190.51, 1104.84));
		CreateFlag((-1188.92, 1557.22, -119.875), (-1637.41, 3275.45, 1239.12));
		CreateFlag((1917.84, 1234.03, 208.125), (2628.16, 1391.61, 782.252));
		CreateFlag((-1561.96, -1952.32, -34.4075), (-1594.57, -2176.06, 187.158));
		break;
	case "mp_express":
		CreateFlag((1068, 2804, -54), (605, 2759, 180));
		CreateFlag((1078, -2734, -54), (675, -2821, 180));
		CreateFlag((2321, 0, -120), (2477, 8, -279));
		break;
	case "mp_turbine":
		CreateFlag((-646, 1540, 425), (-941, 1412, 832));
		CreateFlag((-396, -2313, 159), (-514, -2557, 180));
		CreateFlag((1884, 465, 266), (2555.56, 14.1324, 700.698));
		CreateFlag((-1201.76, -4313.19, 639.125), (-1617.8, -4690.41, 3185.33));
		CreateFlag((-1129.54, 2777.95, 353.485), (-3640.64, 4472.18, 1939.26));
		CreateFlag((882.052, 3687.68, -171.727), (956.22, 3953.26, 208.134));
		break;
	case "mp_bridge": // Detour
		CreateFlag((-2982, -365, -72), (-3329, -693, 229));
		CreateFlag((2716.96, 415.982, 0.125), (2929.2, 245.052, 1.16263));
		break;
	case "mp_dig":
		CreateFlag((-171, 1485, 97), (362, 1559, 743));
		CreateFlag((1080, -142, 120), (1184, -18, 390));
		CreateFlag((-1749.97, -1698.21, 74.125), (-429.599, -4031.26, 523.627));
		CreateFlag((1550.04, 48.0021, 238.839), (5457.32, -370.833, 990.765));
		break;
	case "mp_raid":
		CreateFlag((-191, 3270, 112), (-162, 3442, 265));
		CreateFlag((4650, 3598, 32), (6629, 5441, -76));
		CreateFlag((1604.9, 2256.07, 141.572), (1524.82, 2645.68, 424.125));
		CreateFlag((2907.51, 1565.07, 110.125), (3204.42, 1584.12, 130.893));
		CreateFlag((-386.637, 2999.91, 113.228), (-2366.6, 4881.03, 555.123));
		CreateFlag((6253.02, 4851.81, -137.949), (7294.43, 3997.46, 687.034));
		CreateFlag((1550.04, 48.0021, 238.839), (5457.32, -370.833, 990.765));
		break;
	case "mp_studio":
		CreateFlag((189, -821, -127), (785, -1183, 225));
		CreateFlag((2642.86, 1689.37, -43.875), (2491.35, 1801.68, 138.238));
		CreateFlag((744.291, -1334.91, -45.2996), (544.275, -1545.91, 221.958));
		CreateFlag((3401.36, 2740.14, -35.875), (3438.9, 1795.5, 633.296));
		CreateFlag((-712.923, -670.171, -127.875), (-2954.22, -1705.46, 904.84));
		CreateFlag((-980.763, 1921.69, -55.875), (-2178.39, 3776.28, 907.31));
		CreateFlag((1359.82, -1681.07, -34.9436), (78.4931, -4233.04, 868.581));
		CreateFlag((982.117, 2629.51, -47.875), (1187.88, 3816.15, 496.424));
		break;
	case "mp_vertigo":
		CreateFlag((1008, 2076, -71), (4204, 3218, -325));
		CreateFlag((389, -1481, 0), (4199, -2314, -319));
		CreateFlag((1277.61, 370.892, 104.125), (4192.91, 386.275, 1856.13));
		CreateFlag((184.334, -4330.35, 8.125), (-48.9362, -4394.21, 461.22));
		break;
	case "mp_hydro":
		CreateFlag((762, -1624, 249), (1802, -2538, 1984));
		CreateFlag((-2404, -1463, 216), (-3093, -2409, 1984));
		CreateFlag((-2738, -481, 222), (-2562, -66, 216));
		CreateFlag((2641, -325, 220), (2357, -23, 216));
		CreateFlag((-3702.86, 5381.95, 216.125), (-3462.69, 5116.04, 459.641));
		CreateFlag((-5473.91, 9386.03, 128.125), (-1930.36, 24074.2, 3971.95));
		break;
	case "mp_uplink":
		CreateFlag((2943, 2025, 288), (2601, 3145, 185));
		CreateFlag((2096, -888, 320), (2135, -889, 456));
		CreateFlag((2851.49, -3474.89, 352.125), (3274.93, -4208.17, 1087.79));
		CreateFlag((4511.45, -4261.84, 289.905), (3974.54, -6806, 2605.94));
		CreateFlag((3575.7, -3361.01, 352.125), (3797.08, -3515.56, 352.125));
		CreateFlag((2387.3, -346.838, 314.984), (1963.4, -283.113, 663.781));
		CreateFlag((3666.94, -3134.7, 373.802), (3781.6, -2824.88, 588.893));
		break;
	case "mp_takeoff":
		CreateFlag((-23, 4348, 32), (-373, 5186, 115));
		CreateFlag((-1070, 2561, -55), (-1484, 2467, -47));
		CreateFlag((513, 3742, 32), (693, 3742, 32));
		CreateFlag((975, 3072, 32), (1107, 3072, 32));
		CreateFlag((184, -896, 0), (-139, -297, -135));
		CreateFlag((-1464.53, 2894.4, -47.875), (-4040.22, 3152.34, 2341.28));
		CreateFlag((38.2055, 5231.39, 115.426), (485.644, 5429.75, 309.199));
		CreateFlag((-553.142, 3615.77, 32.125), (-1414.11, 3905.94, 40.9409));
		break;
	case "mp_village":
		CreateFlag((-1189, 1092, 8), (-830, 3955, 400));
		CreateFlag((515.728, 261.256, 8.125), (79.1192, 166.205, 233.48));
		CreateFlag((1623.87, -329.869, 0.349442), (2194.62, 11.3069, 273.117));
		CreateFlag((149.292, -4356.86, 8.125), (-54.8377, -4420.12, 376.373));
		CreateFlag((-567.834, 3961.5, 13.4209), (-1124.24, 3929.2, 400.125));
		CreateFlag((-4568.72, 2592.47, -34.3099), (-4775.1, 2884.25, 378.288));
		CreateFlag((1166.14, -1016.36, 8.125), (1488.07, -912.874, 118.208));
		break;
	case "mp_meltdown":
		CreateFlag((1398.78, 4558.17, -135.875), (2538.92, 4998.62, -61.2619));
		CreateFlag((686.077, 5863.7, -135.875), (2732.48, 9089.79, 35.0579));
		CreateFlag((330.468, 4539.45, -135.625), (298.385, 4791.47, -135.625));
		CreateFlag((350.648, 5493.28, -135.671), (-95.8347, 5436.33, -63.875));
		CreateFlag((1406.93, -1224.25, -135.875), (2329.23, -1995.81, -117.809));
		CreateFlag((88.471, -968.044, -127.875), (-136.575, -4651.88, -38.0352));
		break;
	case "mp_overflow":
		CreateFlag((-1804.08, -1327.7, -131.38), (-1885.41, -1765.89, -31.875));
		CreateFlag((-464.452, -1650.7, -39.875), (-381.163, -1954.7, 112.125));
		CreateFlag((-1871.48, 599.954, 2.59018), (-2033.04, 926.264, -19.63));
		CreateFlag((-2101.31, -932.132, -131.557), (-2860.54, -1700.08, 82.814));
		break;
	case "mp_nightclub":
		CreateFlag((-14855.2, 3085.4, -191.875), (-14644.2, 3090.24, -192.875));
		CreateFlag((-19276.6, -48.4949, -191.875), (-19429.1, -3220, -179.318));
		break;
	case "mp_skate":
		CreateFlag((2377.88, -910.404, 181.036), (2223.44, -1157.19, 248.125));
		CreateFlag((2865.83, -206.396, 164.339), (3059.83, -221.093, 253.651));
		CreateFlag((2065.93, 378.573, 180.544), (5861.21, 2164.2, 1357.23));
		CreateFlag((-2078.48, -1911.04, 256.125), (-721.985, -2255.01, 583.62));
		CreateFlag((5825.74, 2163.61, 121.301), (5770.41, 2142.65, 1345.27));
		CreateFlag((-1659.25, -1641.98, 256.125), (-2147.63, -2497.74, 592.84));
		CreateFlag((2390.56, 1417.96, 128.125), (1970.06, 2144.96, 446.49));
		CreateFlag((3385.86, 1559.14, 128.125), (3125.95, 2145.54, 416.645));
		break;
	}
}