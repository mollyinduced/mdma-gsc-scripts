CreateCollision(origin, angles, model)
{
	/*collision = spawn("script_model", origin);
	collision setmodel(model);
	collision.angles = (angles[0], 90, angles[2]);
	collision setContents(1);
	collision thread DestroyOnEndGame();
	_collision = spawn("script_model", origin);
	_collision setmodel("collision_physics_512x512x512");
	_collision.angles = (angles[0], 90, angles[2]);
	_collision setContents(1);
	_collision thread DestroyOnEndGame();*/
	spawncollision(model, "collider", origin, angles);
}
CustomCollisions()
{
	switch (getDvar("mapname"))
	{
	case "mp_la":
		CreateCollision((-618.025, 7691.3, 57.154), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((46.0661, -25637.7, 9177.88), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-1767.73, -1522.99, -86.719), (0, -0.0788803, 0), "collision_clip_256x256x10");
		break;
	case "mp_slums":
		break;
	case "mp_dockside":
		CreateCollision((6759.29, 941.297, 310.294), (0, -90.95, 0), "collision_clip_512x512x10");
		CreateCollision((9027.83, -549.684, -88.4081), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((4518.35, -568.258, -52.3286), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((-5966.07, 2046.52, -91.6618), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-4483.09, 5048.7, 607.798), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-4469.04, 5318.17, 604.674), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((842.969, 6109.96, 321.965), (0, 0, 0), "collision_clip_256x256x10");
		break;
	case "mp_nuketown_2020":
		CreateCollision((2506.28, -657.372, 392.592), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((258.522, 4187.87, 1538.5), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-4695.27, -9382.28, 3353.7), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((54.4572, -6120.24, 355.341), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((2413.58, 1130.5, 141.616), (0, 89.8663, 0), "collision_clip_256x256x10");
		CreateCollision((2413.7, 1280.5, 142.568), (0, 89.9762, 0), "collision_clip_256x256x10");
		CreateCollision((2413.79, 1520.49, 144.191), (0, 89.9762, 0), "collision_clip_256x256x10");
		CreateCollision((2413.89, 1760.49, 145.816), (0, 89.9762, 0), "collision_clip_256x256x10");
		CreateCollision((2168.77, -5991.59, 578.863), (0, 88.5711, 0), "collision_clip_512x512x10");
		CreateCollision((2168.55, -5662.71, 552.063), (0, 89.8894, 0), "collision_clip_512x512x10");
		CreateCollision((2169.82, -5362.72, 550.913), (0, 89.6697, 0), "collision_clip_512x512x10");
		CreateCollision((2170.57, -5032.75, 554.178), (0, 89.5598, 0), "collision_clip_512x512x10");
		CreateCollision((2173.45, -4762.77, 556.017), (0, 89.3895, 0), "collision_clip_512x512x10");

		CreateCollision((138.431, -1635.25, 542.93), (0, -179.367, 0), "collision_clip_128x128x10");
		CreateCollision((-11.3046, -1636.9, 534.189), (0, -179.367, 0), "collision_clip_128x128x10");
		CreateCollision((-190.988, -1638.88, 523.698), (0, -179.367, 0), "collision_clip_128x128x10");

		CreateCollision((853.702, -499.518, 44.6336), (0, 3.39499, 0), "collision_clip_256x256x10");
		CreateCollision((1003.26, -492.716, 53.7718), (0, 2.18649, 0), "collision_clip_256x256x10");
		CreateCollision((1242.7, -483.574, 67.4744), (0, 2.18649, 0), "collision_clip_256x256x10");
		break;
	case "mp_paintball":
		CreateCollision((1547.52, -2309.93, 350.618), (0, 0, 0), "collision_clip_128x128x10");
		CreateCollision((-1462.43, 2124.52, 350.419), (0, 0, 0), "collision_clip_128x128x10");
		break;
	case "mp_pod":
		break;
	case "mp_drone":
		break;
	case "mp_carrier":
		CreateCollision((-6401.51, -634.062, -240.879), (0, -90.2981, 0), "collision_clip_256x256x10");
		spot = 26;
		while (spot > 0)
		{
			if (spot <= 20 && spot > 0)
			{
				CreateCollision((-8489.36 - (256 * spot), -13541, -450.449), (0, -1, 0), "collision_clip_256x256x10");
			}
			else
			{
				CreateCollision((-8489.36 - (256 * spot), -13541, -370.449), (0, -1, 0), "collision_clip_256x256x10");
			}

			spot--;
		}
		spot = 20;
		while (spot > 0)
		{
			CreateCollision((-8419.36 + (512 * spot), -18553.6, -237.449), (0, -1, 0), "collision_clip_512x512x10");
			CreateCollision((-10268.1 - (512 * spot), 16358.7, -200.735), (0, -179.206, 0), "collision_clip_512x512x10");
			CreateCollision((2707.83 + (512 * spot), 13541.4, -562.716), (0, -2.89877, 0), "collision_clip_512x512x10");
			spot--;
		}
		break;
	case "mp_concert": // Encore
		CreateCollision((-12831.6, -5188.17, 388.078), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-8276.39, 6986.13, 440.563), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((920.474, -8785.83, 650), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((1325.17, -8673.56, 650), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-1272.73, -9606.52, 645), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-1692.03, -9604.53, 645), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-4447.75, 880.187, 249), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-4454.15, 611.219, 249), (0, 0, 0), "collision_clip_256x256x10");
		break;
	case "mp_downhill":
		break;
	case "mp_socotra": // Yamen
		CreateCollision((9192.28, 2845.78, 735.991), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((4600.09, 2308.6, 1040.88), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((-1732.23, 3091.58, 1233), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-1625.66, 3272.27, 1233), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((2625.02, 1370.75, 799.834), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((1870.08, 3547.63, 1954.78), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((2170.03, 3551.21, 1954.78), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((2508.05, 4293.83, 2430.22), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((2687.35, 4282.94, 2430.22), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((1328.32, 4950.77, 2298.27), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((983.918, 4632.57, 2018.97), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((1015.21, 4627.58, 2017.88), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-1590.84, -2182.91, 147.48), (0, -86.7768, 0), "collision_clip_256x256x10");
		break;
	case "mp_express":
		break;
	case "mp_turbine":
		CreateCollision((-1619.85, -4703.71, 3038.63), (0, 121.789, 0), "collision_clip_256x256x10");
		CreateCollision((-3709.58, 4496.43, 1934.13), (0, 164.694, 0), "collision_clip_256x256x10");
		CreateCollision((-1669.57, -673.674, 2018.86), (0, -77.2141, 0), "collision_clip_256x256x10");
		CreateCollision((-6349.16, -1931.31, 811.81), (0, -157.804, 0), "collision_clip_256x256x10");
		CreateCollision((-7372.7, 1765.9, 454.932), (0, 9.6929, 0), "collision_clip_256x256x10");
		CreateCollision((-1664.26, -638.372, 2025.61), (0, -127.62, 0), "collision_clip_256x256x10");
		CreateCollision((962.79, 3960.21, 187.805), (0, 39.6219, 0), "collision_clip_256x256x10");

		break;
	case "mp_bridge": // Detour
		CreateCollision((-22298.2, -2337.09, 3476.34), (0, 146.595, 0), "collision_clip_256x256x10");

		CreateCollision((-8465.05, 19674.9, 2915.76), (0, 103.795, 0), "collision_clip_512x512x10");
		CreateCollision((-8569.05, 20081.6, 2928.03), (0, 104.894, 0), "collision_clip_512x512x10");
		CreateCollision((-8692.4, 20545.4, 2937.92), (0, 104.894, 0), "collision_clip_512x512x10");
		CreateCollision((-8815.74, 21009.2, 2947.8), (0, 104.894, 0), "collision_clip_512x512x10");
		CreateCollision((-8923.67, 21415, 2956.45), (0, 104.894, 0), "collision_clip_512x512x10");

		CreateCollision((17835.1, 29303.4, 2873.16), (0, -75.6181, 0), "collision_clip_512x512x10");
		CreateCollision((17939.4, 28896.8, 2884.95), (0, -75.6181, 0), "collision_clip_512x512x10");
		CreateCollision((18025.7, 28578.2, 2884.09), (0, -74.8491, 0), "collision_clip_512x512x10");
		CreateCollision((18143.3, 28143.9, 2882.92), (0, -74.8491, 0), "collision_clip_512x512x10");
		CreateCollision((18260.9, 27709.5, 2881.74), (0, -74.8491, 0), "collision_clip_512x512x10");
		break;
	case "mp_dig":
		CreateCollision((5468.43, -263.333, 985.64), (0, 0, 0), "collision_clip_512x512x10");
		spot = 6;
		while (spot > 0)
		{
			CreateCollision((7.019 - (100 * spot), -4447.94 + (100 * spot), 503.034), (0, -88.9545, 0), "collision_clip_256x256x10");
			spot--;
		}
		break;
	case "mp_raid":
		CreateCollision((-2497.82, 4713.01, 546.074), (0, 46.4464, 0), "collision_clip_256x256x10");
		CreateCollision((-2374.24, 4843, 530.833), (0, 46.4464, 0), "collision_clip_256x256x10");
		CreateCollision((-2230.06, 4994.65, 513.052), (0, 46.4464, 0), "collision_clip_256x256x10");
		CreateCollision((-2649.82, 4231.44, 178.696), (0, -84.0655, 0), "collision_clip_256x256x10");
		CreateCollision((-2631.21, 4052.4, 177.95), (0, -84.0655, 0), "collision_clip_256x256x10");
		CreateCollision((-2612.6, 3873.37, 177.204), (0, -84.0655, 0), "collision_clip_256x256x10");
		CreateCollision((7270, 3992.06, 660.867), (0, 73.0769, 0), "collision_clip_256x256x10");
		break;
	case "mp_studio":
		spot = 16;
		while (spot > 0)
		{
			CreateCollision((-4318.59 + 128 * spot, -1730.55, 870), (0, -1, 0), "collision_clip_128x128x10");
			CreateCollision((-1779.59 - 128 * spot, 3785.75, 842.804), (0, -179.445, 0), "collision_clip_128x128x10");
			CreateCollision((64.6322, -3574.79 - 128 * spot, 863.456), (0, -88.9545, 0), "collision_clip_128x128x10");
			spot--;
		}
		spot = 6;
		while (spot > 0)
		{
			CreateCollision((3439.24, 2000.03 - 128 * spot, 576.107), (0, -88.9545, 0), "collision_clip_128x128x10");
			spot--;
		}
		spot = 6;
		while (spot > 0)
		{
			CreateCollision((2072.34 - 256 * spot, 3838.58, 491.299), (0, 179.837, 0), "collision_clip_256x256x10");
			spot--;
		}
		break;
	case "mp_vertigo":
		break;
	case "mp_hydro":
		CreateCollision((-3513.23, 5306.62, 420.157), (0, -88.8978, 0), "collision_clip_256x256x10");
		CreateCollision((-3508.61, 5066.67, 418.961), (0, -89.0076, 0), "collision_clip_256x256x10");
		bridge = 40;
		while (bridge > 0)
		{
			CreateCollision((4924.59 - 512 * bridge, 23965.3, 3850.07), (0, 179.311, 0), "collision_clip_512x512x10");
			bridge--;
		}
		break;
	case "mp_uplink":
		CreateCollision((-7319.86, -3621.84, 3043.18), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((4022.04, -6885.26, 2600.81), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((3273.81, -4110.3, 1082.66), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-9027.12, 6211.98, 5793.55), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((1907.82, -326.103, 620.281), (0, 87.9456, 0), "collision_clip_256x256x10");
		CreateCollision((3775.29, -2839.05, 604.693), (0, 28.6981, 0), "collision_clip_256x256x10");
		break;
	case "mp_takeoff":
		CreateCollision((-4112.39, 3174.31, 2280.11), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((462.558, 5416.14, 324.593), (0, 0, 0), "collision_clip_256x256x10");
		spot = 8;
		while (spot > 0)
		{
			CreateCollision((-1471.85, 3498.8 + (256 * spot), 35.8159), (0, 89.4038, 0), "collision_clip_256x256x10");
			spot--;
		}
		spot = 4;
		while (spot > 0)
		{
			CreateCollision((-1739.8, 3437.75 + (512 * spot), 35.247), (0, 89.4038, 0), "collision_clip_512x512x10");
			spot--;
		}
		break;
	case "mp_village":
		train = 38;
		while (train > 0)
		{
			CreateCollision((2204.24, 3281.25 - (128 * train), 235.248), (0, -90.1347, 0), "collision_clip_128x128x10");
			train--;
		}
		spot = 8;
		while (spot > 0)
		{
			CreateCollision((-53.24, -4189 - (128 * spot), 371.248), (0, -90.1347, 0), "collision_clip_128x128x10");
			spot--;
		}
		spot = 6;
		while (spot > 0)
		{
			CreateCollision((-5291.12 + (128 * spot), 2878.54, 373.163), (0, 0.415077, 0), "collision_clip_128x128x10");
			spot--;
		}
		break;
	case "mp_meltdown":
		CreateCollision((2526.81, 5035.37, -112.311), (0, -113.031, 0), "collision_clip_256x256x10");
		CreateCollision((-358.426, -4602.73, -38.0352), (0, -14.1439, 0), "collision_clip_512x512x10");
		CreateCollision((2346.06, -2044.08, -139.72), (0, 33.9047, 0), "collision_clip_256x256x10");

		spot = 6;
		while (spot > 0)
		{
			CreateCollision((2701.34 + (11 * spot), 8794.39 + (128 * spot), -23.0524), (0, 83.1504, 0), "collision_clip_256x256x10");
			spot--;
		}
		break;
	case "mp_overflow":
		CreateCollision((-2879.63, -1710.67, 89.1654), (0, 0, 0), "collision_clip_512x512x10");
		break;
	case "mp_nightclub":
		spot = 2;
		while (spot > 0)
		{
			CreateCollision((-19640.7 - (256 * spot), -3114.211 + (100 * spot), -200.193), (0, 150.962, 0), "collision_clip_256x256x10");
			spot--;
		}

		spot = 6;
		while (spot > 0)
		{
			CreateCollision((-19682.6 + (256 * spot), -3096.211 - (140 * spot), -200.193), (0, 150.962, 0), "collision_clip_256x256x10");
			spot--;
		}
		break;
	case "mp_skate":
		CreateCollision((5862.81, 2199.41, 1340.14), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((-711.616, -2229.88, 567.228), (0, 0, 0), "collision_clip_256x256x10");
		CreateCollision((-2084.55, -2512.74, 490.885), (0, -179.254, 0), "collision_clip_256x256x10");
		CreateCollision((1974.3, 2181.3, 441.365), (0, -88.568, 0), "collision_clip_512x512x10");
		CreateCollision((3111.63, 2171.4, 377.346), (0, -1.71007, 0), "collision_clip_512x512x10");

		break;
	case "mp_castaway":
		CreateCollision((2342.93, -17371.8, 381.451), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((-6308.61, 3669.26, 476.904), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((1639.73, 18502.1, 177.842), (0, 0, 0), "collision_clip_512x512x10");
		CreateCollision((-4463.22, 22907.8, 165.298), (0, 0, 0), "collision_clip_512x512x10");
		break;
	}
}