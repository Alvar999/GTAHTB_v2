#include <evoplay/a_connection>
#include <evoplay/a_includes>
new SQL = -1;
public OnGameModeInit()
{
	SQL = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	mysql_log(LOG_ERROR | LOG_WARNING, LOG_TYPE_HTML);

	SetNameTagDrawDistance(30);
	EnableStuntBonusForAll(0);
	ShowPlayerMarkers(2);
	LimitPlayerMarkerRadius(5.0);

    countdown = 0;

	//Vote
	voteoption = "NONE";
	voteoption2 = "NONE";
	voteoption3 = "NONE";
	

    textile = TextDrawCreate(102.000000, 193.000000, " ");
	TextDrawBackgroundColor(textile, 255);
	TextDrawFont(textile, 2);
	TextDrawLetterSize(textile, 0.500000, 2.399999);
	TextDrawColor(textile, -6749953);
	TextDrawSetOutline(textile, 0);
	TextDrawSetProportional(textile, 1);
	TextDrawSetShadow(textile, 1);
	TextDrawSetSelectable(textile, 0);
	
	for(new c=0;c<CAR_AMOUNT;c++)
	{
		Gas[c] = GasMax;
	}

	LoadTextdraws();
	LoadSystems();
	OnLoadAllCars();
	LoadAllDynamicObjects();
	LoadAllObjects();
	skinlist = LoadModelSelectionMenu("skins.txt");
	skinlist1 = LoadModelSelectionMenu("skins1.txt");
	skinlist2 = LoadModelSelectionMenu("skins2.txt");
	skinlist3 = LoadModelSelectionMenu("skins3.txt");
	skinlist4 = LoadModelSelectionMenu("skins4.txt");
	skinlist5 = LoadModelSelectionMenu("skins5.txt");
	skinlist6 = LoadModelSelectionMenu("skins6.txt");
	skinlist8 = LoadModelSelectionMenu("skins8.txt");
	skinlist9 = LoadModelSelectionMenu("skins9.txt");
	skinlist10 = LoadModelSelectionMenu("skins10.txt");
	skinlist11 = LoadModelSelectionMenu("skins11.txt");
	skinlist12 = LoadModelSelectionMenu("skins12.txt");
	skinlist13 = LoadModelSelectionMenu("skins13.txt");
	skinlist14 = LoadModelSelectionMenu("skins14.txt");
	skinlist15 = LoadModelSelectionMenu("skins15.txt");
	skinlist16 = LoadModelSelectionMenu("skins16.txt");
	skinlist17 = LoadModelSelectionMenu("skins17.txt");
	skinlist18 = LoadModelSelectionMenu("skins18.txt");
	SetGameModeText(SERVER_VERSION);
	SendRconCommand("mapname LS, LV, SF");
	format(objstore, sizeof(objstore), "MOLE: I got nothing, check back with me later.");
	format(cbjstore, sizeof(cbjstore), "HQ: There is nothing in your Vicinity, Out.");

	xhq[1] = 1568.6251;  	yhq[1] = -1690.5358; 	 	zhq[1] = 5.8906;
	xhq[2] = 328.8737;   	yhq[2] = -1513.1195; 	 	zhq[2] = 36.0391;
	xhq[3] = 627.6160;   	yhq[3] = -571.7920;  	 	zhq[3] = 17.6242;
	xhq[4] = 1456.7423;  	yhq[4] = 2773.3423;	 		zhq[4] = 10.8203;
	xhq[5] = 2495.3271;   	yhq[5] = -1690.6740;	 	zhq[5] = 14.7656;
	xhq[6] = 725.6769;  	yhq[6] = -1440.4506;	 	zhq[6] = 13.5391;
	xhq[7] = 689.9420;   	yhq[7] = -1275.9573;  	 	zhq[7] = 13.5595;
	xhq[8] = 2287.1047;   	yhq[8] = 2431.7996;  	 	zhq[8] = 10.8203;
	xhq[9] = -329.5258;  	yhq[9] = 1536.7759;  		zhq[9] = 76.6117;
	xhq[10] = 1455.2687; 	yhq[10] = 750.8684; 	 	zhq[10] = 11.0234;
	xhq[11] = 1081.1794;  	yhq[11] = -345.3979;  	 	zhq[11] = 73.9825;
	xhq[12] = 2435.3064; 	yhq[12] = 1671.0139; 	 	zhq[12] = 10.8203;
	xhq[13] = 2475.7747; 	yhq[13] = -1750.5632;   	zhq[13] = 13.5469;
	xhq[14] = 1173.2563; 	yhq[14] = -1323.3102;   	zhq[14] = 15.3943;
	xhq[15] = 2637.3118; 	yhq[15] = 2352.0276;   	    zhq[15] = 10.8203;

	//Create3DTextLabel
	Create3DTextLabel("Parachute Cost: 10,000$\nType /buyparachute to buy Parachute",0xFFFFFFFF,-2231.2058,-1736.1578,480.8620,20.0, 0, 1);
	Create3DTextLabel("Materials Los Santos\nType /buymaterials to buy materials",0xFFFFFFFF,1449.2723,-1848.4255,13.7721,10.0, 0, 1);
    Create3DTextLabel("Gate 1\nType /opengate 1 to open",0xFFFFFFFF,1767.5348,-1581.2784,1742.5024,5.0, 0, 1);
	Create3DTextLabel("{FFFF6B}Driving School!\n \nType /exam\nto start the test!",0xFFFFFFFF,1219.0502,-1812.7823,16.5938,20.0, 0, 1);
	CreateStreamed3DTextLabel("LS DealerShip!\n\nType /buycar to buy a car\nor /sellcar to sell an existing car!",COLOR_LIGHTGREEN2,328.3534,-1513.1687,36.0391,20.0,0);
    Create3DTextLabel("Get Drugs\nType /getdrugs to get drugs",0xFFFFFFFF,322.9745,1119.4409,1083.8828,20.0, 0, 1);
    Create3DTextLabel("Los Santos Police Departament's HQ",COLOR_BLUE,1554.7621,-1675.5870,16.1953,20.0, 0, 1);
    Create3DTextLabel("Las Venturas Police Departament's HQ",COLOR_BLUE,2287.1047,2431.7996,10.8203,20.0, 0, 1);
    Create3DTextLabel("Federal Bureau Of Investigation's HQ",COLOR_BLUE,627.6160,-571.7920,17.6242,20.0, 0, 1);
    Create3DTextLabel("{FFFF99}Los Santos Police Department\nGroup Safe",0x33CCFFFF,256.9322,64.7314,1003.6406,20.0, 0, 1);
    Create3DTextLabel("{FFFF99}Las Venturas Police Department\nGroup Safe",0x33CCFFFF,256.9322,64.7314,1003.6406,20.0, 3, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}09\n{FFFFFF}Job:{C00A13}Arms Deaeler\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,1365.8931,-1289.0779,13.5469,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}04\n{FFFFFF}Job:{C00A13}Drugs Dealer\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,2130.0400,-1700.1396,15.0784,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}06\n{FFFFFF}Job:{C00A13}Farmer\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,-367.1633,-1412.3904,25.7266,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}07\n{FFFFFF}Job:{C00A13}Bus Driver\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,1653.4697,-2239.6372,13.5239,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}10\n{FFFFFF}Job:{C00A13}Garbage Man\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,2503.0581,2778.7229,10.8203,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}01\n{FFFFFF}Job:{C00A13}Detective\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,607.8375,-1438.1827,14.0654,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}08\n{FFFFFF}Job:{C00A13}Mechanic\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,1621.6411,2210.4629,15.1959,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}05\n{FFFFFF}Job:{C00A13}Pizza Boy\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,2123.0237,-1788.8237,13.5547,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}13\n{FFFFFF}Job:{C00A13}FisherMan\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,391.8376,-2064.3474,7.8359,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}13\n{FFFFFF}Job:{C00A13}FisherMan\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,2000.7855,1564.9432,15.3672,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}14\n{FFFFFF}Job:{C00A13}Trucker\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,2434.8606,-2110.4429,13.5469,20.0, 0, 1);
	Create3DTextLabel("{FFFFFF}ID:{C00A13}02\n{FFFFFF}Job:{C00A13}Car Jacker\n{FFFFFF}Use {C00A13}/getjob {FFFFFF}to get job.",0x33CCFFFF,2850.9663,891.8728,10.7500,20.0, 0, 1);
 	Create3DTextLabel("{0E7BE9}Materials Pickup!\n\nType /getmats as an Arms Dealer\nto collect materials",COLOR_WHITE,597.5396,-1246.9562,18.2512,20.0, 0, 1);
	Create3DTextLabel("{26C4EC}Door ID: 11\nPD Garage | /garage",COLOR_WHITE,1594.7660,-1619.7109,13.4093,20.0, 0, 1);
	Create3DTextLabel("{26C4EC}Door ID: 37\nRestricted to faction(Los Santos Police Department)\nLSPD Staff HQ",COLOR_WHITE,242.4025,66.4760,1003.6406,20.0, 0, 1);
	Create3DTextLabel("{26C4EC}Door ID: 38\nRestricted to faction(Las Venturas Police Department)\nLVPD Staff HQ",COLOR_WHITE,242.4025,66.4760,1003.6406,20.0, 3, 1);
	Create3DTextLabel("{26C4EC}/garage",COLOR_WHITE,1292.7828,6.8377,1001.0078,20.0, 0, 1);
	Create3DTextLabel("{26C4EC}/exitgaragehitman",COLOR_WHITE,1292.7828,6.8377,1001.0078,20.0, 676, 1);
	Create3DTextLabel("Press enter to exit from LSPD Staff",COLOR_WHITE,238.5806,138.9213,1003.0234,20.0, 333, 1);
	Create3DTextLabel("Press enter to exit from LVPD Staff",COLOR_WHITE,238.5806,138.9213,1003.0234,20.0, 343, 1);
	Create3DTextLabel("{26C4EC}Door ID: 12\nRestricted to faction(Hitman Agency)\nHitman Garage | /garage",COLOR_WHITE,1059.6315,-344.6857,73.9922,20.0, 0, 1);
	Create3DTextLabel("Hitman Agency HQ",COLOR_WHITE,1081.1794,-345.3979,73.9825,20.0, 0, 1);
	Create3DTextLabel("National Guard HQ\n(locked)",COLOR_BLUE,200.8692,1869.5511,13.1470,20.0, 0, 1);
	Create3DTextLabel("Los Vagos HQ\n(locked)",COLOR_BLUE,725.7441,-1440.0914,13.5391,20.0, 0, 1);
	Create3DTextLabel("Grove Street HQ\n(locked)",COLOR_BLUE,2495.2434,-1690.6366,14.7656,20.0, 0, 1);
	Create3DTextLabel("Los Aztecas HQ\n(locked)",COLOR_BLUE,1457.0563,2773.3521,10.8203,20.0, 0, 1);
	Create3DTextLabel("The Rifa HQ\n(locked)",COLOR_BLUE,2637.3118,2352.0276,10.8203,20.0, 0, 1); // gata
	Create3DTextLabel("The Rifa HQ\n(locked)",COLOR_BLUE,2637.3118,2352.0276,10.8203,20.0, 0, 1);
	Create3DTextLabel("The Russian Mafia HQ\n(locked)",COLOR_BLUE,1123.0795,-2037.1305,69.8937,20.0, 0, 1);
	Create3DTextLabel("Taxi LV HQ\n(locked)",COLOR_BLUE,937.5077,1733.2762,8.8516,20.0, 0, 1);
	Create3DTextLabel("School Instructors LV HQ\n(locked)",COLOR_BLUE,2435.2900,1671.1409,10.8203,20.0, 0, 1);
	Create3DTextLabel("News Reporters HQ\n(locked)",COLOR_BLUE,-329.5621,1536.5757,76.6117,20.0, 0, 1);
	Create3DTextLabel("Las Venturas Paramedic Deparament HQ\n(locked)",COLOR_BLUE,1607.3318,1815.9183,10.8203,20.0, 0, 1);
	Create3DTextLabel("Taxi Los Santos HQ\n(locked)",COLOR_BLUE,1753.4095,-1903.1362,13.5633,20.0, 0, 1);
	areap = Create3DTextLabel("{2A98F2}Event Place\n{FFFFFF}Business {2A98F2}#100\n{FFFFFF}Owner: {2A98F2}AdmBot\n{FFFFFF}Please wait...",0xFFFFFFFF,1510.3986,-1059.5723,25.0625,5.0, 0, 1);
    Create3DTextLabel("{26C4EC}LSPD | /elevator",0xFFFFFFFF,1564.8662,-1666.4962,28.3956,20.0, 0, 1);
    Create3DTextLabel("{26C4EC}LVPD Roof | /elevator",0xFFFFFFFF,2339.3237,2461.2197,38.6837,20.0, 0, 1);
    Create3DTextLabel("{26C4EC}Door ID: 30\nRestricted to faction(Los Santos Police Department)\nLSPD Roof | /elevator",0xFFFFFFFF,1568.5891,-1690.3262,5.8906,20.0, 0, 1);
    Create3DTextLabel("{26C4EC}Door ID: 24\nRestricted to faction(Las Venturas Police Department)\nLVPD Roof | /elevator",0xFFFFFFFF,2340.2810,2456.5625,14.9688,20.0, 0, 1);
    Create3DTextLabel("{26C4EC}Los Santos Police Department\nProcessing Entrance\n \n(/arrest)",0xFFFFFFFF,1526.3739,-1678.0635,5.8906,20.0, 0, 1);
    Create3DTextLabel("{26C4EC}Las Venturas Police Department\nProcessing Entrance\n \n(/arrest)",0xFFFFFFFF,2282.1289,2425.7620,3.4692,20.0, 0, 1);
    Create3DTextLabel("Paintball !\n\n\nType /paint\nto enter the paintball arena!",0xFFFF00CC,1154.4122,-1440.0548,15.7969,10.0, 0, 1);
    Create3DTextLabel("{26C4EC}Door ID: 1\n{26C4EC}Restricted to STAFF(Admin/Helpers)\n{26C4EC}Press F for enter.",COLOR_WHITE,1016.5494,1050.5697,11.0000,10.0, 0, 1);
   	Create3DTextLabel("{26C4EC}Door ID: 2\nRestricted to STAFF(Helpers/Admins)\nHELPER / ADMIN HQ | /staffgarage",COLOR_WHITE,1087.9738,997.1158,11.0000,20.0, 0, 1);
   	Create3DTextLabel("{26C4EC}Exit from Garage #STAFF\nUse /exitgaragestaff for exit.",COLOR_WHITE,1292.8011,6.5901,1001.0078,20.0, 133, 1);
    // CreateDynamic3DTextLabel
	gettime(ghour, gminute, gsecond);
	FixHour(ghour);
	ghour = shifthour;
	if(!realtime)
	{
		SetWorldTime(wotime);
	}
    DisableInteriorEnterExits();
	AllowInteriorWeapons(1);
	UsePlayerPedAnims();
	paintm[1] = 1;
	paintm[2] = 1;
	paintm[3] = 1;
	paintm[4] = 1;
	paintg[1] = 1;
	paintg[2] = 1;
	PaintBallWinnerKills[1] = 0;
	PaintBallWinnerKills[2] = 0;
	PaintBallWinnerKills[3] = 0;
	PaintBallWinnerKills[4] = 0;
	PaintWinner[1] = 0;
	PaintWinner[2] = 0;
	PaintWinner[3] = 0;
	PaintWinner[4] = 0;
	paintrs[1] = 0;
	paintrs[2] = 0;
	paintrs[3] = 0;
	paintrs[4] = 0;
	paintt[1] = 0;
	paintt[2] = 0;
	paintt[3] = 0;
	paintt[4] = 0;
	mapvoted[1] = 0;
	mapvoted[2] = 0;
	mapvoted[3] = 0;
	mapvoted[4] = 0;
	gunvoted[1] = 0;
	gunvoted[2] = 0;

	for(new i = 0; i <= sizeof(Peds)-1; i++)
	{
		AddPlayerClass(Peds[i][0],1958.3783,1343.1572,1100.3746,269.1425,-1,-1,-1,-1,-1,-1);
	}

    ManualVehicleEngineAndLights();

	for(new i = 1; i < sizeof(CarInfo); i++)
	{
        if(CarInfo[i][cSell] == 2)
        {
        	CarInfo[i][cID] = -2;
        }
	}

	new nrinmatric[128];
	for(new i = 0; i < sizeof(Copcar); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{456FCF}BTR - 0%d", i);
	    SetVehicleNumberPlate(Copcar[i], nrinmatric);
	    SetVehicleToRespawn(Copcar[i]);
	}
	for(new i = 0; i < sizeof(Fbicar); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{456FCF}BTR - 0%d", i);
	    SetVehicleNumberPlate(Fbicar[i], nrinmatric);
	    SetVehicleToRespawn(Fbicar[i]);
	}
	for(new i = 0; i < sizeof(LVpdcar); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{456FCF}BTR - 0%d", i);
	    SetVehicleNumberPlate(LVpdcar[i], nrinmatric);
	    SetVehicleToRespawn(LVpdcar[i]);
	}
	for(new i = 0; i < sizeof(Ngcar); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{456FCF}BTR - 0%d", i);
	    SetVehicleNumberPlate(Ngcar[i], nrinmatric);
	    SetVehicleToRespawn(Ngcar[i]);
	}
	for(new i = 0; i < sizeof(Aztecasc); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{7e3937}BTR - 0%d", i);
	    SetVehicleNumberPlate(Aztecasc[i], nrinmatric);
	    SetVehicleToRespawn(Aztecasc[i]);
	}
	for(new i = 0; i < sizeof(Grovec); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{668573}BTR - 0%d", i);
	    SetVehicleNumberPlate(Grovec[i], nrinmatric);
	    SetVehicleToRespawn(Grovec[i]);
	}
	for(new i = 0; i < sizeof(Vagosc); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{2F2F2F}BTR - 0%d", i);
	    SetVehicleNumberPlate(Vagosc[i], nrinmatric);
	    SetVehicleToRespawn(Vagosc[i]);
	}
	for(new i = 0; i < sizeof(Ballasc); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{885724}BTR - 0%d", i);
	    SetVehicleNumberPlate(Ballasc[i], nrinmatric);
	    SetVehicleToRespawn(Ballasc[i]);
	}
	for(new i = 0; i < sizeof(news); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{FFABFC}BTR - 0%d", i);
	    SetVehicleNumberPlate(news[i], nrinmatric);
	    SetVehicleToRespawn(news[i]);
	}
	for(new i = 0; i < sizeof(towcar); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{FFFFA8}BTR - 0%d", i);
	    SetVehicleNumberPlate(towcar[i], nrinmatric);
	    SetVehicleToRespawn(towcar[i]);
	}
	for(new i = 0; i < sizeof(taxic); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{fcff00}BTR - 0%d", i);
	    SetVehicleNumberPlate(taxic[i], nrinmatric);
	    SetVehicleToRespawn(taxic[i]);
	}
	for(new i = 0; i < sizeof(si); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{10E056}BTR - 0%d", i);
	    SetVehicleNumberPlate(si[i], nrinmatric);
	    SetVehicleToRespawn(si[i]);
	}
	for(new i = 0; i < sizeof(ambcars); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{FF0033}BTR - 0%d", i);
	    SetVehicleNumberPlate(ambcars[i], nrinmatric);
	    SetVehicleToRespawn(ambcars[i]);
	}
	for(new i = 0; i < sizeof(bus); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{FF0033}BUS - 0%d", i);
	    SetVehicleNumberPlate(bus[i], nrinmatric);
	    SetVehicleToRespawn(bus[i]);
	}
	for(new i = 0; i < sizeof(bus); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{FF0033}BUS - 0%d", i);
	    SetVehicleNumberPlate(bus[i], nrinmatric);
	    SetVehicleToRespawn(bus[i]);
	}
	for(new i = 0; i < sizeof(rentls); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{FF0033}BTR - 0%d", i);
	    SetVehicleNumberPlate(rentls[i], nrinmatric);
	    SetVehicleToRespawn(rentls[i]);
	}
	for(new i = 0; i < sizeof(thea); i++)
	{
	    format(nrinmatric, sizeof(nrinmatric), "{CC0000}BTR - 0%d", i);
	    SetVehicleNumberPlate(thea[i], nrinmatric);
	    SetVehicleToRespawn(thea[i]);
	}

	// Pickups
	pickuph = CreatePickup(1316, 23, 1059.6315,-344.6857,73.9922); 		// Order pickup Hitman Garage
	AddStaticPickup(1242, 23, 1527.5,-12.1,1002.0); 					// binco armor
	AddStaticPickup(1239, 23, 1219.0502,-1812.7823,16.5938); 			// Driving License
	porp = CreatePickup(1254, 23, 2495.3271,-1690.6740,14.7656); 		// Grove Street Hq
	trdp = CreatePickup(1254, 23, 1456.7423,2773.3423,10.8203); 		// Los Aztecas Hq
	sicp = CreatePickup(1254, 23, 725.6769,-1440.4506,13.5391); 		// Los Vagos HQ
	rusp = CreatePickup(1254, 23, 1455.2687,750.8684,11.0234);
	russianp = CreatePickup(1254, 23, 1123.0795,-2037.1305,69.8937); 	 // Ballas HQ
	rifap = CreatePickup(1254, 23, 2637.3118,2352.0276,10.8203);        // Rifa HQ
	gslsenter1 = CreatePickup(1318, 23, 305.9341,-141.7895,1004.0547, -1);
	gslsenter2 = CreatePickup(1318, 23, 300.1486,-141.8312,1004.0625, -1);
	gslsenter3 = CreatePickup(1318, 23, 304.0917,-141.7523,1004.0625, -1);
	gslsenter4 = CreatePickup(1318, 23, 298.9318,-141.8459,1004.0547, -1);
	AddStaticPickup(1275, 23, 2434.8606,-2110.4429,13.5469);            // Trucker [/getjob]
    AddStaticPickup(1247, 23, 1554.7621,-1675.5870,16.1953);			// Lspd
    AddStaticPickup(1247, 23, 2287.1047,2431.7996,10.8203);				// Lvpd
    AddStaticPickup(1314, 23, 2282.1289,2425.7620,3.4692);				// Lvpd arrest
    AddStaticPickup(1314, 23, 1526.3739,-1678.0635,5.8906);				// Lspd arrest
    AddStaticPickup(1247, 23, 627.6160,-571.7920,17.6242);				// Fbi
	//govp = CreatePickup(1239, 23, 1481.2347,-1771.1429,18.7958);		// Guvern
	AddStaticPickup(1239, 23, 1756.4181,-1577.8954,1742.5309);			// exit jail
	AddStaticPickup(1239, 23, 1762.0028,-1584.4185,1742.5264);			// mdc jail
	AddStaticPickup(1275, 23, 1365.8931,-1289.0779,13.5469);			// GETJOB ARMS DEALER
    AddStaticPickup(1275, 23, 2130.0400,-1700.1396,15.0784);			// GETJOB DRUGS DEALER
	AddStaticPickup(1275, 23, 2503.0581,2778.7229,10.8203);			    // GETJOB GARBAGE MAN
	AddStaticPickup(1275, 23, 607.8375,-1438.1827,14.0654);				// GETJOB DETECTIVE
	AddStaticPickup(1275, 23, 1621.6411,2210.4629,15.1959); 			// GETJOB MECHANIC
	AddStaticPickup(1275, 23, 1343.6400,1164.2336,10.82);               // Haine
	AddStaticPickup(1275, 23, 2850.9663,891.8728,10.7500); 			    // GETJOB CAR JACKER
	AddStaticPickup(1239, 23, 2770.4629,-1628.3237,12.1775); 			// MATSCOLLECT
	AddStaticPickup(1239, 23, 2065.4844,-1584.0730,13.4821); 			// BUYIRON
	AddStaticPickup(1239, 23, 5.7771,-3989.8794,1003.5266); 			// STATION LS BUY
	sip = CreatePickup(1239, 23, 2435.3064,1671.0139,10.8203); 			// SI
	AddStaticPickup(1239, 23, 200.8692,1869.5511,13.1470); 				// NG ARMOURY
	taxip = CreatePickup(1239, 23, 1753.4095,-1903.1362,13.5633); 		// TAXI HQ
	taxilvp = CreatePickup(1239, 23, 937.5077,1733.2762,8.8516);        // TAXI LV HQ
	AddStaticPickup(1275, 23, 2123.0237,-1788.8237,13.5547); 			// PIZZA BOY
	AddStaticPickup(1275, 23, 391.8376,-2064.3474,7.8359); 				// FISH GETJOB
	AddStaticPickup(1275, 23, 2000.7855,1564.9432,15.3672);              // FISH LV GETJOB
	AddStaticPickup(1275, 23, -367.1633,-1412.3904,25.7266);            // FARM GETJOB
	AddStaticPickup(1275, 23, 2434.8606,-2110.4429,13.5469); 			// GETJOB TRUCKER
	AddStaticPickup(1275, 23, 1653.4697,-2239.6372,13.5239); 			// GETJOB BUS DRIVER
	hitmanep = CreatePickup(1239, 23, 1081.1794,-345.3979,73.9825); 	// HITMAN ENTER
	AddStaticPickup(1318, 23, 2139.1638,-1697.5662,15.0859); 			// DRUGS HOUSE
	AddStaticPickup(1316, 23, 1594.7660,-1619.7109,13.4093);            // GARAGE ENTER PD
	AddStaticPickup(1316, 23, 1292.7828,6.8377,1001.0078);       		// GARAGE EXIT PD
	AddStaticPickup(1318, 23, 1016.5494, 1050.5697, 11.0000);       	// HQ STAFF
	AddStaticPickup(1313, 23, 1154.4122,-1440.0548,15.7969);       	    // PAINTBALL LS
	AddStaticPickup(1316, 23, 1087.9738,997.1158,11.0000);              // GARAGE ENTER HQ HELPERI
	AddStaticPickup(1316, 23, 1292.8011,6.5901,1001.0078);              // GARAGE EXIT HQ HELPERI
	AddStaticPickup(1316, 23, 1581.3364,-1285.1337,17.5534);              // URCA
	AddStaticPickup(1316, 23, 1588.3729,-1272.0880,39.0895);              // COBOARA

	//CreateDynamicPickup(modelid, type, Float:x, Float:y, Float:z, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 100.0);
	CreateDynamicPickup(1247, 23, 242.4025,66.4760,1003.6406,-1,-1,-1,100.0); // LSPD STAFF HQ
    CreateDynamicPickup(1316, 23, 1292.7828,6.8377,1001.0078,676,18,-1,100.0); // GARAGE EXIT HITMAN
	CreateDynamicPickup(1279, 23, 322.9745,1119.4409,1083.8828,-1,-1,-1,100.0);
	CreateDynamicPickup(1239, 23, 918.6766,-1252.2185,16.2109,-1,-1,-1,100.0);
	CreateDynamicPickup(1277, 23, 328.3534,-1513.1687,36.0391,-1,-1,-1,100.0);  // DS PiCKUP
	CreateDynamicPickup(1239, 23, 1564.8662,-1666.4962,28.3956,-1,-1,-1,100.0); // LSPD Roff(sus)
	CreateDynamicPickup(1239, 23, 1568.5825,-1690.2802,5.8906,-1,-1,-1,100.0); // LSPD Roff(jos)
	CreateDynamicPickup(1239, 23, 2340.2810,2456.5625,14.9688,-1,-1,-1,100.0); // LVPD Roff(jos)
	CreateDynamicPickup(1239, 23, 2339.3237,2461.2197,38.6837,-1,-1,-1,100.0); // LVPD Roff(sus)
	CreateDynamicPickup(1239, 23, 229.4171,167.4609,1003.0234,-1,-1,-1,100.0); 	// clear fbi
	CreateDynamicPickup(1239, 23,187.8352,1931.4265,17.6874,-1,-1,-1,100.0); 	// clear ng
	CreateDynamicPickup(1239, 23,-329.5258,1536.7759,76.6117,-1,-1,-1,100.0); 	// nr
	CreateDynamicPickup(371, 23,-2231.2058,-1736.1578,480.8620,-1,-1,-1,100.0); // parachute
	//CreateDynamicPickup(1239, 23,1449.2723,-1848.4255,13.7721,-1,-1,-1,100.0); 	// buymaterials
	CreateDynamicPickup(1239, 23,1510.3986,-1059.5723,25.0625,-1,-1,-1,100.0); 	// event area enter
	CreateDynamicPickup(1239, 23,-1423.5153,935.8321,1036.4756,-1,-1,-1,100.0); // event area exit
	CreateDynamicPickup(1274, 23, 256.9322,64.7314,1003.6406, -1, -1,-1,100.0);

    // MAPICON
    CreateDynamicMapIcon(328.3534,-1513.1687,36.0391,55,0,-1,-1,-1,750.0);	// BuyCar Los Santos
	CreateDynamicMapIcon(1172.3258,-1323.4644,15.4033,22,0,-1,-1,-1,750.0);	// Hospital LS
    CreateDynamicMapIcon(1528.779,-1678.113,5.890625,30,0,-1,-1,-1,750.0); // Pd LS
    CreateDynamicMapIcon(2286.9417,2431.7651,10.8203,30,0,-1,-1,-1,750.0);	// Pd LV
	CreateDynamicMapIcon(627.6160,-571.7920,17.6242,30,0,-1,-1,-1,750.0);	// FBI
	CreateDynamicMapIcon(213.8154,1866.6807,13.1406,30,0,-1,-1,-1,750.0);	// NG
	CreateDynamicMapIcon(1510.3986,-1059.5723,25.0625,35,0,-1,-1,-1,750.0);	// Event Arena

	printf("%d - Objects.",CountDynamicObjects());
	printf("%d - Pickups.",CountDynamicPickups());

	//Timer
	if (realtime)
	{
		new tmphour,
			tmpminute,
			tmpsecond;
		gettime(tmphour, tmpminute, tmpsecond);
		FixHour(tmphour);
		tmphour = shifthour;
		new worldt = tmphour;
		SetWorldTime(worldt);
	}
	synctimer = SetTimer("SyncUp", 60000, 1);
	unjailtimer = SetTimer("SetPlayerUnjail", 1000, 1);
	othtimer = SetTimer("OtherTimer", 1000, 1);
	checkafktimer = SetTimer("CheckAFK", 1000, 1);
	checkpnstimer = SetTimer("CheckPNS", 1000, 1);
	cartimer = SetTimer("CarCheck", 30000, 1);
    idletimer = SetTimer("IdleKick", idletime, 1);
	spectatetimer = SetTimer("Spectator", 2000, 1);
	productiontimer = SetTimer("Production", 300000, 1); //5 mins (300000)
	checkgastimer = SetTimer("CheckGas", RunOutTime, 1);
    stoppedvehtimer = SetTimer("StoppedVehicle", RunOutTime, 1);
    checkvehinfotimer = SetTimer("Checkvehinfo",1000, 1);
    wantedicatimer = SetTimer("FiveSecondsTimer", 5000, 1);
    savedatatimer = SetTimer("SavePlayerData", 300000, 1);
   	pickuptimer = SetTimer("CustomPickups", 1000, 1);
    SetTimer("Hacks", 1000, true);
	SetTimer("SendMSG", 300000, 1);
	SetTimer("WeatherChange",1800000,1); // 30 min
    SetTimer("FallingChecker",500,1);
    SetTimer("CheckHelpers",  300000, 1);// 5 minute
    TimerLictiatii = SetTimer("SistemLictatii", 600000, 1);
    
	printf("OnGameModeInit Loaded");
	return 1;
}

public LoadAllObjects()
{
    //gratii pd
    new gratie1, gratie2, gratie3, gratie4, gratie5, gratie6;
	gratie1 = CreateObject(19302, 266.32431, 85.70610, 1001.28571,   0.00000, 0.00000, 90.30000);
	gratie2 = CreateObject(19302, 266.31870, 87.46790, 1001.28571,   0.02000, 0.00000, -89.82000);
	gratie3 = CreateObject(19302, 266.32031, 82.94890, 1001.28571,   0.02000, 0.00000, -89.82000);
	gratie4 = CreateObject(19302, 266.33569, 81.20160, 1001.28571,   0.02000, 0.00000, 90.36000);
	gratie5 = CreateObject(19302, 266.29480, 76.71580, 1001.28571,   0.02000, 0.00000, 90.36000);
	gratie6 = CreateObject(19302, 266.29480, 78.45580, 1001.28571,   0.02000, 0.00000, -90.60000);
	SetObjectMaterial(gratie1, 0, 19302, "gratie1", "gratie1", 0xFFFFFFFF);
	SetObjectMaterial(gratie2, 0, 19302, "gratie2", "gratie2", 0xFFFFFFFF);
	SetObjectMaterial(gratie3, 0, 19302, "gratie3", "gratie3", 0xFFFFFFFF);
	SetObjectMaterial(gratie4, 0, 19302, "gratie4", "gratie4", 0xFFFFFFFF);
	SetObjectMaterial(gratie5, 0, 19302, "gratie5", "gratie5", 0xFFFFFFFF);
	SetObjectMaterial(gratie6, 0, 19302, "gratie6", "gratie6", 0xFFFFFFFF);

	//gratii ajail
	new gratia1, gratia2, gratia3, gratia4, gratia5, gratia6, gratia7, gratia8;
	gratia1 = CreateObject(19302, 228.28619, 112.66590, 999.23529,   0.00000, 0.00000, 180.48010);
	gratia2 = CreateObject(19302, 226.50360, 112.64810, 999.23529,   0.00000, 0.00000, 0.90020);
	gratia3 = CreateObject(19302, 222.62360, 112.64810, 999.23529,   0.00000, 0.00000, 359.64001);
	gratia4 = CreateObject(19302, 224.36360, 112.64810, 999.23529,   0.00000, 0.00000, 538.79919);
	gratia5 = CreateObject(19302, 220.38361, 112.64810, 999.23529,   0.00000, 0.00000, 539.69940);
	gratia6 = CreateObject(19302, 218.66360, 112.64810, 999.23529,   0.00000, 0.00000, 359.33963);
	gratia7 = CreateObject(19302, 216.44360, 112.64810, 999.23529,   0.00000, 0.00000, 538.73865);
	gratia8 = CreateObject(19302, 214.72360, 112.64810, 999.23529,   0.00000, 0.00000, 359.45889);
	SetObjectMaterial(gratia1, 0, 19302, "gratia1", "gratia1", 0xFFFFFFFF);
	SetObjectMaterial(gratia2, 0, 19302, "gratia2", "gratia2", 0xFFFFFFFF);
	SetObjectMaterial(gratia3, 0, 19302, "gratia3", "gratia3", 0xFFFFFFFF);
	SetObjectMaterial(gratia4, 0, 19302, "gratia4", "gratia4", 0xFFFFFFFF);
	SetObjectMaterial(gratia5, 0, 19302, "gratia5", "gratia5", 0xFFFFFFFF);
	SetObjectMaterial(gratia6, 0, 19302, "gratia6", "gratia6", 0xFFFFFFFF);
	SetObjectMaterial(gratia7, 0, 19302, "gratia7", "gratia7", 0xFFFFFFFF);
	SetObjectMaterial(gratia8, 0, 19302, "gratia8", "gratia8", 0xFFFFFFFF);
	
	// GiftBox
	CreateObject(1237, 2832.7747, -1583.1410, 10.0303, 0.00000, 0.00000, 359.45889);
	CreateObject(1237, 2832.0769, -1585.4375, 10.0303, 0.00000, 0.00000, 359.45889);
	CreateObject(1237, 2831.4231, -1587.5200, 10.0303, 0.00000, 0.00000, 359.45889);
	CreateObject(1237, 2908.9612, -1591.0282, 10.0303, 0.00000, 0.00000, 359.45889);
	CreateObject(1237, 2908.3118, -1593.4402, 10.0303, 0.00000, 0.00000, 359.45889);
	CreateObject(1237, 2907.6162, -1595.5017, 10.0303, 0.00000, 0.00000, 359.45889);
	
	// Fish SF
	CreateObject(984, -1338.06958, 458.33890, 6.77950,   0.00000, 0.00000, 0.00000);
    CreateObject(984, -1334.48425, 438.66229, 6.77950,   0.08000, 0.08000, 50.84000);
    CreateObject(984, -1338.08508, 473.48770, 6.77950,   0.00000, 0.00000, 0.00000);
    CreateObject(984, -1338.06506, 475.06769, 6.77950,   -0.04000, 0.00000, 0.00000);
    CreateObject(984, -1331.62012, 481.38519, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1318.83948, 481.37119, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1306.00208, 481.34241, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1293.19214, 481.28519, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1293.19214, 481.28519, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1280.41833, 481.24979, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1267.63416, 481.20959, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1254.85620, 481.17920, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1233.46631, 434.27209, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1246.25586, 434.32581, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1259.10339, 434.36691, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1271.92163, 434.40329, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1284.72473, 434.45871, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1297.52832, 434.50000, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1310.31555, 434.54111, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1323.12988, 434.58539, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1242.06677, 481.13531, 6.77950,   0.08000, 0.08000, 89.84000);
    CreateObject(984, -1230.80627, 476.88229, 6.77950,   0.08000, 0.08000, 48.84000);
    CreateObject(984, -1226.03271, 472.60959, 6.77950,   0.08000, 0.08000, 48.84000);
    CreateObject(984, -1220.87842, 461.53830, 6.77950,   0.08000, 0.08000, 0.84000);
    CreateObject(984, -1220.71204, 448.74081, 6.77950,   0.08000, 0.06000, 0.84000);
    CreateObject(984, -1220.63953, 443.99600, 6.77950,   0.08000, 0.08000, 0.84000);

	//gard cnn
    CreateObject(970, 1113.81226, -1415.95642, 12.99760,   0.00000, 0.00000, 1.02000);
	CreateObject(970, 1118.95190, -1415.88806, 12.99760,   0.00000, 0.00000, 0.24000);
	CreateObject(970, 1123.87134, -1415.89172, 13.01760,   0.00000, 0.00000, 0.00000);
	CreateObject(970, 1128.84937, -1415.87390, 13.05760,   0.00000, 0.00000, 0.00000);
	CreateObject(970, 1133.62927, -1415.89539, 13.05760,   0.00000, 0.00000, 0.00000);
	CreateObject(970, 1138.54712, -1415.90955, 13.07760,   0.00000, 0.00000, 0.00000);
	CreateObject(970, 1143.48718, -1415.95984, 13.07760,   0.00000, 0.00000, -0.54000);
	CreateObject(970, 1186.10474, -1495.67102, 12.96110,   0.00000, 0.00000, -90.06000);
	CreateObject(970, 1186.14282, -1490.92114, 12.96110,   0.00000, 0.00000, -90.06000);
	CreateObject(970, 1186.13611, -1486.25720, 12.96110,   0.00000, 0.00000, -90.06000);
	CreateObject(970, 1186.10059, -1481.48560, 12.96110,   0.00000, 0.00000, -90.06000);
	CreateObject(970, 1124.00598, -1562.16187, 12.95910,   0.00000, 0.00000, -0.48000);
	CreateObject(970, 1133.22400, -1562.16504, 12.95910,   0.00000, 0.00000, 0.12000);
	CreateObject(970, 1128.58142, -1562.17664, 12.95910,   0.00000, 0.00000, -0.48000);
	CreateObject(970, 1061.49329, -1492.59277, 12.96960,   0.00000, 0.00000, -105.78001);
	CreateObject(970, 1059.12000, -1501.51147, 12.96960,   0.00000, 0.00000, -104.70000);
	CreateObject(970, 1060.26794, -1497.01086, 12.98960,   0.00000, 0.00000, -105.30000);


	//PD Exterior by SKiM
	CreateObject(11326, 1605.05212, -1623.62476, 14.96770,   0.00000, 0.00000, 89.46000);
	CreateObject(955, 1553.64233, -1683.42175, 12.92650,   0.00000, 0.00000, -90.00000);
	CreateObject(983, 1542.62939, -1641.17981, 27.70590,   0.00000, 0.00000, -180.48010);
	CreateObject(983, 1545.80750, -1650.77563, 27.68590,   0.00000, 0.00000, -270.12021);
	CreateObject(983, 1542.60828, -1647.55884, 27.70590,   -0.16000, -0.04000, -180.12010);
	CreateObject(983, 1550.38745, -1650.77563, 27.68590,   0.00000, 0.00000, -270.12021);
	CreateObject(983, 1542.62939, -1640.45984, 27.70590,   0.00000, 0.00000, -180.48010);
	CreateObject(983, 1545.85986, -1637.26941, 27.70590,   0.00000, 0.00000, -270.18002);
	CreateObject(983, 1552.21460, -1637.27222, 27.70590,   0.00000, 0.00000, -270.18002);
	CreateObject(983, 1558.61877, -1637.28772, 27.70590,   0.00000, 0.00000, -270.18002);
	CreateObject(983, 1565.02625, -1637.32434, 27.70590,   0.00000, 0.00000, -270.18002);
	CreateObject(983, 1571.40149, -1637.35168, 27.70590,   0.00000, 0.00000, -270.18002);
	CreateObject(983, 1574.66931, -1637.35522, 27.70590,   0.00000, 0.00000, -270.17999);
	CreateObject(983, 1577.83557, -1640.57202, 27.70590,   0.00000, 0.00000, -180.48010);
	CreateObject(983, 1577.77295, -1646.93713, 27.70590,   0.00000, 0.00000, -180.48010);
	CreateObject(983, 1577.78162, -1653.32056, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.78674, -1659.73962, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.77917, -1666.16150, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.75732, -1672.53748, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.72766, -1678.91931, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.73621, -1685.32568, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.72400, -1691.71228, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.71289, -1698.10791, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.72131, -1704.51245, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.69897, -1710.88159, 27.70590,   0.00000, 0.00000, -180.06012);
	CreateObject(983, 1577.69897, -1711.24158, 27.70590,   0.00000, 0.00000, -180.06010);
	CreateObject(983, 1574.44556, -1714.38306, 27.70590,   0.00000, 0.00000, -270.35995);
	CreateObject(983, 1568.07471, -1714.34656, 27.70590,   0.00000, 0.00000, -270.35995);
	CreateObject(983, 1561.66760, -1714.30737, 27.70590,   0.00000, 0.00000, -270.35995);
	CreateObject(983, 1555.31116, -1714.26440, 27.70590,   0.00000, 0.00000, -270.35995);
	CreateObject(983, 1548.95508, -1714.22168, 27.70590,   0.00000, 0.00000, -270.35995);
	CreateObject(983, 1545.76025, -1714.20190, 27.70590,   0.00000, 0.00000, -270.35995);
	CreateObject(983, 1542.57971, -1710.99304, 27.70590,   0.00000, 0.00000, -359.87982);
	CreateObject(983, 1542.54773, -1704.60864, 27.70590,   0.00000, 0.00000, -359.87982);
	CreateObject(983, 1542.54773, -1703.70862, 27.70590,   0.00000, 0.00000, -359.87979);
	CreateObject(983, 1545.74390, -1700.54211, 27.70590,   0.00000, 0.00000, -270.00009);
	CreateObject(983, 1550.38757, -1700.53650, 27.70590,   0.00000, 0.00000, -270.00009);
	CreateObject(983, 1553.58850, -1697.36475, 27.70590,   0.00000, 0.00000, -179.70013);
	CreateObject(983, 1553.56555, -1690.94910, 27.70590,   0.00000, 0.00000, -179.70013);
	CreateObject(983, 1553.56580, -1656.84106, 27.70590,   0.00000, 0.00000, -179.70010);
	CreateObject(983, 1553.55737, -1653.96729, 27.70590,   0.00000, 0.00000, -179.70010);
	CreateObject(3934, 1562.89099, -1700.73755, 27.38710,   0.00000, -0.02000, -0.84000);
	CreateObject(3934, 1560.78516, -1650.95300, 27.38710,   0.00000, -0.02000, 1.02000);

	//Statii autobuz
	CreateObject(1257, 1692.89929, -2200.77808, 13.64870,   0.00000, 0.00000, -90.12000);
	CreateObject(1257, 1941.19080, -2172.63159, 13.76920,   0.00000, 0.00000, -90.36000);
	CreateObject(1257, 1967.80859, -1900.26184, 13.77870,   0.00000, 0.00000, 0.00000);
	CreateObject(1257, 1921.87402, -1746.02295, 13.76840,   0.00000, 0.00000, 90.06000);
	CreateObject(1257, 1815.46008, -1815.05981, 13.80990,   0.00000, 0.00000, -179.63989);
	CreateObject(1257, 1695.64038, -1766.75049, 13.78830,   0.00000, 0.00000, 0.00000);
	CreateObject(1257, 1392.64221, -1726.04602, 13.65910,   0.00000, 0.00000, 89.46000);
	CreateObject(1257, 1318.69714, -1633.10010, 13.76780,   0.00000, 0.00000, 0.00000);
	CreateObject(1257, 1325.55969, -1389.08057, 13.76010,   0.00000, 0.00000, 90.24000);
	CreateObject(1257, 1212.34741, -1326.52954, 13.68430,   0.00000, 0.00000, 0.00000);
	CreateObject(1257, 1083.02100, -1274.54492, 13.60720,   0.00000, 0.00000, 90.24000);
	CreateObject(1257, 964.63733, -1214.54919, 17.02340,   0.00000, 0.00000, 89.58000);
	CreateObject(1257, 818.55078, -1134.44849, 23.90680,   0.00000, 0.00000, 88.50000);
	CreateObject(1257, 791.28119, -1301.22681, 13.56870,   0.00000, 0.00000, -179.51990);
	CreateObject(1257, 679.34332, -1388.95630, 13.72830,   0.00000, 0.00000, 90.12000);
	CreateObject(1257, 378.06552, -1489.50562, 32.17630,   0.00000, 0.00000, 128.28003);
	CreateObject(1257, 261.02219, -1539.33704, 32.41950,   0.00000, 0.00000, -34.38000);
	CreateObject(1257, 485.92880, -1361.02576, 18.19000,   -4.00000, 4.00000, -65.24000);
	CreateObject(1257, 589.19830, -1236.84290, 17.97730,   0.00000, 0.00000, -67.92000);
	CreateObject(1257, 775.53870, -1062.00525, 24.75130,   0.00000, 0.00000, -77.69999);
	CreateObject(1257, 1209.70325, -952.07233, 43.01140,   0.00000, 0.00000, -79.26000);
	CreateObject(1257, 1713.93640, -736.80762, 50.49150,   -2.94000, 0.00000, -2.00000);
	CreateObject(1257, 1775.73401, 579.77661, 23.77970,   0.00000, 0.00000, -11.76000);
	CreateObject(1257, 1839.89514, 825.05157, 10.16840,   0.06000, 0.00000, 270.66010);
	CreateObject(1257, 2184.53564, 801.95203, 7.33030,   0.00000, 0.00000, -125.22000);
	CreateObject(1257, 2293.69141, 841.77661, 14.11820,   0.00000, 0.00000, 0.00000);
	CreateObject(1257, 2353.69604, 1025.47546, 10.84100,   0.00000, 0.00000, 0.00000);
	CreateObject(1257, 2570.79736, 1066.87720, 10.84120,   0.00000, 0.00000, -90.24001);
	CreateObject(1257, 2613.71777, 1319.62097, 10.86020,   0.00000, 0.00000, 90.36000);
	CreateObject(1257, 2476.20508, 1479.59375, 10.86030,   0.00000, 0.00000, 89.94000);
	CreateObject(1257, 2401.10645, 1619.55835, 10.89970,   0.00000, 0.00000, 89.88000);
	CreateObject(1257, 2293.08325, 1779.52710, 10.80020,   0.00000, 0.00000, 89.70000);
	CreateObject(1257, 2158.93481, 1995.43042, 10.87960,   0.00000, 0.00000, 0.00000);
	CreateObject(1257, 2231.25317, 2383.93506, 10.86030,   0.00000, 0.00000, -12.60000);
	CreateObject(1257, 2085.77344, 2459.35864, 10.88090,   0.00000, 0.00000, 90.00000);
	CreateObject(1257, 1948.35791, 2399.46997, 10.92060,   0.00000, 0.00000, 89.64000);
	CreateObject(1257, 1920.80237, 2315.90601, 10.88100,   0.00000, 0.00000, -179.69991);
	CreateObject(1257, 1921.41638, 2117.40479, 10.94120,   0.00000, 0.00000, -179.70000);
	CreateObject(1257, 2093.48389, 2015.85571, 10.90140,   0.00000, 0.00000, -90.18000);
	CreateObject(1257, 2035.99133, 1521.35413, 10.90060,   0.00000, 0.00000, -180.05991);
	CreateObject(1257, 2036.35254, 1168.23950, 10.82070,   0.00000, 0.00000, -179.75990);
	CreateObject(1257, 2034.95715, 878.28998, 7.36150,   0.00000, 0.00000, -179.40010);
	CreateObject(1257, 1752.35156, 621.24127, 21.25890,   4.00000, 0.00000, 165.00000);
	CreateObject(1257, 1614.87988, 186.35570, 33.65740,   4.00000, 0.00000, -192.00000);
	CreateObject(1257, 1657.21387, -331.40521, 40.28030,   0.00000, 0.00000, -174.59990);
	CreateObject(1257, 1684.78406, -727.13708, 49.88370,   4.00000, 0.00000, -190.80000);
	CreateObject(1257, 1412.48633, -934.33838, 35.80170,   0.00000, 0.00000, 80.46000);
	CreateObject(1257, 1431.33862, -1040.25464, 23.92800,   0.00000, 0.00000, -89.94000);
	CreateObject(1257, 1571.46692, -1139.13977, 23.71380,   0.00000, 0.00000, -180.60001);
	CreateObject(1257, 1708.46350, -1263.24890, 13.60880,   0.00000, 0.00000, -179.16000);
	CreateObject(1257, 1590.66150, -1434.45093, 13.52840,   0.00000, 0.00000, 90.06000);
	CreateObject(1257, 1423.55896, -1568.12500, 13.62870,   0.00000, 0.00000, 173.27989);
	CreateObject(1257, 1446.39136, -1738.46875, 13.68900,   0.00000, 0.00000, -89.58000);
	CreateObject(1257, 1579.74524, -1878.48059, 13.62880,   0.00000, 0.00000, -90.06000);
	CreateObject(1257, 1815.37183, -1904.30969, 13.65310,   0.00000, 0.00000, -180.65990);
	CreateObject(1257, 1955.44678, -1998.47595, 13.60910,   0.00000, 0.00000, -179.52000);
	CreateObject(1257, 1935.31299, -2160.26001, 13.66810,   0.00000, 0.00000, 89.82000);

	//Pompe de benzina
	CreateObject(1676, 1009.18927, -936.09637, 42.78190,   0.00000, 0.00000, 6.66000);
	CreateObject(1676, 1005.57520, -936.67499, 42.78190,   0.00000, 0.00000, 6.66000);
	CreateObject(1676, 1002.23541, -937.06488, 42.78190,   0.00000, 0.00000, 6.66000);
	CreateObject(1676, 998.64508, -937.57654, 42.78190,   0.00000, 0.00000, 6.66000);

	//Masinute/Elicoptere/Tancuri PD, Aeroport si Dealership
	CreateVehicle(464, 1972.3630, -2177.0972, 16.6885, 51.6000, -1, -1, 100);
	CreateVehicle(465, 1950.9691, -2177.2039, 16.8155, -56.9400, -1, -1, 100);
	CreateVehicle(441, 326.6814, -1538.6517, 32.1894, -133.6799, -1, -1, 100);
	CreateVehicle(441, 330.8876, -1533.0819, 32.1894, -133.7999, -1, -1, 100);
	CreateVehicle(564, 1546.9607, -1672.4099, 14.0163, 89.9999, -1, -1, 100);
	CreateVehicle(564, 1547.0096, -1678.7792, 14.0163, 89.9999, -1, -1, 100);
	return 1;
}
public OnGameModeExit()
{
	new qqerry[128];
	mysql_format(SQL,qqerry, sizeof(qqerry), "UPDATE `users` SET `Status` = '0'");
    mysql_tquery(SQL,qqerry,"","");
	mysql_format(SQL,qqerry, sizeof(qqerry), "UPDATE `friends` SET `Status` = '0'");
    mysql_tquery(SQL,qqerry,"","");
    
    
    ploop(i)
    {
        if(snowOn{i})
        {
            for(new j = 0; j < MAX_SNOW_OBJECTS; j++) DestroyDynamicObject(snowObject[i][j]);
            KillTimer(updateTimer{i});
        }
    }
	mysql_close(SQL);
	return 1;
}