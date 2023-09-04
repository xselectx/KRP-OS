//timery.pwn

//25.06.2014 Aktualizacja timerów (wszystkich) - optymalizacja Kubi
forward SpecToggle(playerid);
public SpecToggle(playerid)
{
    Streamer_ToggleAllItems(playerid, STREAMER_TYPE_OBJECT, 1);
    sendTipMessage(playerid, "Wczytywanie obiektów!");
	TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
}
forward SpawnPosInfo(playerid);
public SpawnPosInfo(playerid)
{
	new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
    SetPVarFloat(playerid,"xposspawn",x);
    SetPVarFloat(playerid,"yposspawn",y);
    SetPVarFloat(playerid,"zposspawn",z);
}
public SprzedajMatsTimer(playerid,giveplayerid)
{
	if(GetPVarInt(giveplayerid, "OKupMats") == 1)
	{
		SetPVarInt(giveplayerid, "OKupMats", 0);
		SetPVarInt(giveplayerid, "Mats-id", 0);
  		SetPVarInt(giveplayerid, "Mats-kasa", 0);
    	SetPVarInt(giveplayerid, "Mats-mats", 0);
    	sendErrorMessage(giveplayerid, "Sprzeda¿ mats zosta³a anulowana!");
	}
	if(GetPVarInt(playerid, "OSprzedajMats") == 1)
	{
		SetPVarInt(playerid, "OSprzedajMats", 0);
		sendErrorMessage(playerid, "Sprzeda¿ mats zosta³a anulowana!");
	}
	return 1;
}

//PizzaJob
public PizzaJobTimer01(playerid)
{
	
}
//Naprawianie timer
public Naprawa(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new string[256];
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(RepairOffer[playerid], giveplayer, sizeof(giveplayer));
		RepairCar[playerid] = GetPlayerVehicleID(playerid);
		SetVehicleHealth(RepairCar[playerid], 1000.0);
		RepairVehicle(RepairCar[playerid]);

		CarData[VehicleUID[RepairCar[playerid]][vUID]][c_Tires] = 0;
		CarData[VehicleUID[RepairCar[playerid]][vUID]][c_HP] = 1000.0;

		PlayerPlaySound(RepairCar[playerid], 1140, 0.0, 0.0, 0.0);
		PlayerPlaySound(playerid, 1140, 0.0, 0.0, 0.0);
		format(string, sizeof(string), "* Twój samochód zosta³ naprawiony za $%d przez mechanika %s.",RepairPrice[playerid],giveplayer);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "* Naprawi³eœ pojazd %s, otrzymujesz $%d.",giveplayer,RepairPrice[playerid]);
		SendClientMessage(RepairOffer[playerid], COLOR_LIGHTBLUE, string);
		format(string, sizeof(string),"* Mechanik %s naprawia pojazd %s i chowa narzêdzia do skrzynki.",giveplayer,VehicleNames[GetVehicleModel(RepairCar[playerid])-400]);
		ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		format(string, sizeof(string), "* Silnik pojazdu znów dzia³a jak nale¿y (( %s ))", giveplayer);
		ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		PlayerInfo[RepairOffer[playerid]][pMechSkill] ++;
		if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 50)
		{ SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 2, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
		else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 100)
		{ SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 3, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
		else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 200)
		{ SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 4, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
		else if(PlayerInfo[RepairOffer[playerid]][pMechSkill] == 400)
		{ SendClientMessage(RepairOffer[playerid], COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 5, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
		ZabierzKaseDone(playerid, RepairPrice[playerid]);
		DajKaseDone(RepairOffer[playerid], RepairPrice[playerid]);
		RepairOffer[playerid] = 999;
		RepairPrice[playerid] = 0;
		Naprawiasie[playerid] = 0;
	}
	else
	{
		SendClientMessage(playerid, -1, "Naprawa przerwana - wyszed³eœ z pojazdu");
	}
    return 1;
}

//===============[VINYL CLUB]=======
forward textVinylT();
public textVinylT(){
	new Float:Pos[3];
	GetDynamicObjectPos(text_Vinyl, Pos[0], Pos[1], Pos[2]);
	if(Pos[2] == -21.528980){
		MoveDynamicObject(text_Vinyl, 817.176879, -1386.975463, -23.0, 1);
	}else{
		MoveDynamicObject(text_Vinyl, 817.176879, -1386.975463, -21.528980, 1);
	}
	return 1;
}
forward FreezePlayer(playerid);
public FreezePlayer(playerid){
	TogglePlayerControllable(playerid, 1);
	if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0) ApplyAnimation(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 1, 0, 1); 
	return 1;
}

forward SetTimeAndWeather (playerid);
public SetTimeAndWeather(playerid)
{
	new weatherID, timeVal; 
	weatherID = GetPVarInt(playerid, "WeatherToSet"); 
	timeVal = GetPVarInt(playerid, "TimeToSet");
	SetPlayerTime(playerid, timeVal, 0);
	SetPlayerWeather(playerid, weatherID);
	sendTipMessage(playerid, "Pomyœlnie ustalono pogodê i czas dla VW"); 
	KillTimer(SetTAWForPlayer[playerid]); 
	return 1;
}


//KONIEC
forward odczekaj15sec(playerid);
public odczekaj15sec(playerid)
{
	SetPVarInt(playerid, "CanDoIt", 0); 
	SetPVarInt(playerid, "WhatToDo", 0);
	KillTimer(odczekajTimer[playerid]);
	return 1; 
}
forward glosuj_admin_ankieta();
public glosuj_admin_ankieta()
{
	new string[128];
	glosowanie_admina_status = 0;
	SendAdminMessage(COLOR_RED, "=====[WYNIKI G£OSOWANIA]======"); 
	format(string, sizeof(string), "U¿ytkownicy, którzy g³osowali na TAK: %d", glosowanie_admina_tak);
	SendAdminMessage(COLOR_P@, string);
	format(string, sizeof(string), "U¿ytkownicy, którzy g³osowali na NIE: %d", glosowanie_admina_nie);
	SendAdminMessage(COLOR_P@, string);
	
	return 1;
}
//System Po¿arów v0.1
forward UsunPozar();
public UsunPozar()
{
    DeleteAllFire();
    return 1;
}
//Komendy Admina - Timer na oddanie HP
forward OddajZycieTimer(playerid);
public OddajZycieTimer(playerid)
{
	new stathptime = (GetPVarInt(playerid, "statusZycia")/1000);
	dajHPSekunda[playerid]++;
	if(dajHPSekunda[playerid] == stathptime)
	{
		new Float:ammoutHP;
		SetPlayerHealth(playerid, 1);
		ammoutHP = GetPVarFloat(playerid, "odnowaZyciaAdmin");
		SetPlayerHealth(playerid, ammoutHP);
		KillTimer(TimerOddaniaZycia[playerid]);
	}
	return 1;
}
forward JedzenieCooldown(playerid);
public JedzenieCooldown(playerid)
{
	new timeSec[MAX_PLAYERS];
	timeSec[playerid]++;
	if(timeSec[playerid] == 2)
	{
		TimerJedzenie[playerid] = 0;
		KillTimer(ZarcieCooldown[playerid]);
	}
	return 1;
}
//dialogi

forward timerDialogs(playerid);
public timerDialogs(playerid)
{
	dialTime[playerid]++; 
	if(dialTime[playerid] == 3)
	{
		dialTime[playerid] = 0; 
		dialAccess[playerid] = 0; 
		KillTimer(dialTimer[playerid]);
	}
	return 1;
}
//Anty-Komunikat-Timer
forward KomunikatCzas(playerid);
public KomunikatCzas(playerid)
{
	komunikatMinuty[playerid]++;
	if(komunikatMinuty[playerid] == 60)
	{
		new string[128];
		format(string, sizeof(string), "null");
		sendTipMessage(playerid, "Zakoñczono odliczanie - Mo¿esz ponownie wys³aæ komunikat"); 
		SetPVarString(playerid, "trescOgloszenia", string);
		PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 0;
		komunikatMinuty[playerid] = 0;
		KillTimer(komunikatTime[playerid]);
	}
	return 1;
}
forward KomunikatCzasZerowanie(playerid);
public KomunikatCzasZerowanie(playerid)
{
	komunikatMinutyZerowanie[playerid]++;
	if(komunikatMinutyZerowanie[playerid] == 5)
	{
		new string[128];
		format(string, sizeof(string), "null"); 
		sendTipMessage(playerid, "Zakoñczono odliczanie - Mo¿esz ponowie wys³aæ komunikat"); 
		SetPVarString(playerid, "trescOgloszenia", string);
		KillTimer(komunikatTimeZerowanie[playerid]); 
		komunikatMinutyZerowanie[playerid] = 0;
	}

	return 1;
}
//End komunikatów
forward AktywujPozar();
public AktywujPozar()
{
    SetTimer("UsunPozar", 3600000, false);
    new losowy = random(15);
	new fraction_name[128];
	format(fraction_name, sizeof(fraction_name), "--------[%s]--------", GroupInfo[FRAC_ERS][g_Name]);
	if(losowy == 1)
	{
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: DOM JEDNORODZINNY - IDLEWOOD", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: WYBUCH KUCHENKI GAZOWEJ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRZECHODZIEÑ", true);
   		GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: DOM JEDNORODZINNY - IDLEWOOD",1);
    	AddFire(2016.998,-1696.110,15.036, 400);
		AddFire(2016.998,-1697.411,15.036, 400);
		AddFire(2016.998,-1698.870,15.036, 400);
		AddFire(2016.998,-1700.310,15.036, 400);
		AddFire(2016.998,-1701.901,15.036, 400);
		AddFire(2016.998,-1703.541,15.036, 400);
		AddFire(2016.998,-1705.311,15.036, 400);
		AddFire(2018.499,-1704.381,15.546, 400);
		AddFire(2018.499,-1702.281,15.546, 400);
		AddFire(2018.499,-1699.971,15.546, 400);
		AddFire(2018.499,-1697.660,15.546, 400);
		AddFire(2019.839,-1706.760,12.916, 400);
		AddFire(2019.839,-1707.570,12.916, 400);
		AddFire(2019.839,-1708.760,12.916, 400);
		AddFire(2019.839,-1709.791,12.916, 400);
		AddFire(2017.880,-1703.500,12.206, 400);
		AddFire(2016.910,-1701.301,13.456, 400);
		AddFire(2016.910,-1698.461,13.456, 400);
		AddFire(2017.568,-1695.621,15.726, 400);
		AddFire(2018.899,-1695.621,15.726, 400);
    }
	else if(losowy == 2)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: SKLEP 24/7 W OKOLICACH DMV", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: AWARIA INSTALACJI ELEKTRYCZNEJ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRACOWNIK SKLEPU", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: SKLEP 24/7 W OKOLICACH DMV",1);
    	AddFire(1362.514,-1759.767,12.359,400);
		AddFire(1361.113,-1759.767,12.359,400);
		AddFire(1360.043,-1759.767,12.359,400);
		AddFire(1358.473,-1759.767,12.359,400);
		AddFire(1357.153,-1759.767,12.359,400);
		AddFire(1355.792,-1759.767,12.359,400);
		AddFire(1354.202,-1759.767,12.359,400);
		AddFire(1352.442,-1759.767,12.689,400);
		AddFire(1352.442,-1759.767,11.189,400);
		AddFire(1350.571,-1759.767,12.849,400);
		AddFire(1348.951,-1759.767,12.339,400);
		AddFire(1347.871,-1759.767,12.339,400);
		AddFire(1347.871,-1759.767,12.339,400);
		AddFire(1345.991,-1759.767,12.339,400);
		AddFire(1344.361,-1759.767,12.339,400);
		AddFire(1342.791,-1759.767,12.339,400);
		AddFire(1342.791,-1758.750,16.589,400);
		AddFire(1344.001,-1758.750,16.589,400);
		AddFire(1345.682,-1758.750,16.589,400);
		AddFire(1347.502,-1758.750,16.589,400);
		AddFire(1356.223,-1758.750,16.589,400);
		AddFire(1358.063,-1758.750,16.589,400);
		AddFire(1359.403,-1758.750,16.589,400);
		AddFire(1361.223,-1758.750,16.589,400);
		AddFire(1362.794,-1758.750,16.589,400);
    }
	else if(losowy == 3)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: PIZZERIA IDLEWOOD", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: AWARIA KUCHENKI GAZOWEJ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRACOWNIK RESTAURACJI", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: PIZZERIA IDLEWOOD",1);
		AddFire(2105.741,-1796.412,12.551, 400);
		AddFire(2105.741,-1797.312,12.551, 400);
		AddFire(2105.741,-1798.193,12.551, 400);
		AddFire(2105.741,-1799.383,12.551, 400);
		AddFire(2105.741,-1799.913,12.551, 400);
		AddFire(2105.741,-1801.174,12.551, 400);
		AddFire(2105.741,-1801.834,12.551, 400);
		AddFire(2105.741,-1802.924,12.551, 400);
		AddFire(2105.741,-1804.234,12.551, 400);
		AddFire(2105.741,-1802.444,12.551, 400);
		AddFire(2105.741,-1806.724,12.551, 400);
		AddFire(2105.741,-1806.724,11.411, 400);
		AddFire(2105.741,-1809.305,12.681, 400);
		AddFire(2105.741,-1810.035,12.681, 400);
		AddFire(2105.741,-1811.015,12.681, 400);
		AddFire(2105.741,-1811.975,12.681, 400);
		AddFire(2105.741,-1812.695,12.681, 400);
		AddFire(2105.741,-1813.716,12.681, 400);
		AddFire(2105.741,-1814.646,12.681, 400);
		AddFire(2105.741,-1815.466,12.681, 400);
		AddFire(2105.741,-1816.326,12.681, 400);
		AddFire(2105.741,-1817.026,12.681, 400);
    }
	else if(losowy == 4)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: SKLEP BINCO - GANTON", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: PODPALENIE", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRZECHODZIEÑ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: SKLEP BINCO - GANTON",1);
		AddFire(2248.296,-1667.368,14.286, 400);
		AddFire(2247.255,-1667.017,14.286, 400);
		AddFire(2246.314,-1666.797,14.286, 400);
		AddFire(2245.373,-1666.537,14.286, 400);
		AddFire(2244.122,-1665.946,14.286, 400);
		AddFire(2244.122,-1665.946,13.066, 400);
		AddFire(2241.772,-1665.426,14.506, 400);
		AddFire(2240.772,-1665.426,14.506, 400);
		AddFire(2239.651,-1665.096,14.506, 400);
		AddFire(2240.231,-1665.096,14.506, 400);
		AddFire(2237.981,-1664.275,14.506, 400);
		AddFire(2237.690,-1664.275,13.356, 400);
    }
	else if(losowy == 5)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: STACJA PALIW - TEMPLE", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: WYBUCH DYSTRYBUTORA", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRACOWNIK STACJI", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: STACJA PALIW - TEMPLE",1);
    	AddFire(995.978,-938.445,40.229, 400);
		AddFire(997.778,-938.445,40.229, 400);
		AddFire(999.308,-938.445,40.229, 400);
		AddFire(1000.818,-938.445,40.229, 400);
		AddFire(1002.468,-938.445,40.229, 400);
		AddFire(1001.478,-938.445,40.229, 400);
		AddFire(1004.688,-938.445,40.229, 400);
		AddFire(1006.008,-938.445,40.229, 400);
		AddFire(1006.838,-938.445,40.229, 400);
		AddFire(1008.369,-938.445,40.229, 400);
		AddFire(1010.778,-938.445,40.229, 400);
		AddFire(1009.228,-938.445,40.229, 400);
    }
	else if(losowy == 6)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: KONTENERY - LOTNISKO LOS SANTOS", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: WYBUCH", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: OCHRONA LOTNISKA", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: KONTENERY - LOTNISKO LOS SANTOS",1);
    	AddFire(2067.007,-2206.814,13.666, 400);
		AddFire(2067.007,-2208.004,13.666, 400);
		AddFire(2067.007,-2209.165,13.666, 400);
		AddFire(2067.007,-2210.565,13.666, 400);
		AddFire(2067.007,-2211.836,13.666, 400);
		AddFire(2067.007,-2213.237,13.666, 400);
		AddFire(2067.007,-2213.947,13.666, 400);
		AddFire(2065.203,-2216.167,13.666, 400);
		AddFire(2065.203,-2215.047,13.666, 400);
		AddFire(2065.203,-2215.047,15.166, 400);
		AddFire(2065.203,-2215.867,15.166, 400);
		AddFire(2065.203,-2215.867,12.566, 400);
		AddFire(2065.203,-2217.038,12.566, 400);
		AddFire(2065.203,-2218.678,12.566, 400);
		AddFire(2065.203,-2218.678,11.466, 400);
		AddFire(2065.203,-2217.418,11.806, 400);
		AddFire(2065.203,-2215.966,11.496, 400);
		AddFire(2065.203,-2214.605,11.496, 400);
		AddFire(2065.203,-2214.605,12.966, 400);
		AddFire(2064.492,-2205.578,11.466, 400);
		AddFire(2064.492,-2204.597,11.466, 400);
		AddFire(2064.492,-2203.546,11.466, 400);
		AddFire(2064.492,-2202.516,11.466, 400);
		AddFire(2064.492,-2202.516,11.466, 400);
		AddFire(2064.492,-2202.516,13.776, 400);
    }
	else if(losowy == 7)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: P¥CZKARNIA NA MARKET", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: WYBUCH INSTALACJI ELEKTRYCZNEJ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRZECHODZIEÑ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: P¥CZKARNIA NA MARKET",1);
		AddFire(1037.776,-1341.086,12.726, 400);
		AddFire(1038.607,-1341.086,12.726, 400);
		AddFire(1038.897,-1341.086,11.326, 400);
		AddFire(1037.667,-1341.086,11.326, 400);
		AddFire(1040.315,-1339.865,14.896, 400);
		AddFire(1041.766,-1339.865,14.896, 400);
		AddFire(1038.706,-1339.865,14.896, 400);
		AddFire(1036.616,-1339.865,14.896, 400);
		AddFire(1035.096,-1339.865,14.896, 400);
		AddFire(1033.426,-1339.865,14.896, 400);
		AddFire(1031.756,-1339.865,14.896, 400);
		AddFire(1030.695,-1339.865,14.896, 400);
		AddFire(1029.575,-1341.645,14.896, 400);
		AddFire(1029.575,-1343.986,14.896, 400);
		AddFire(1042.866,-1340.755,14.896, 400);
		AddFire(1042.866,-1340.755,12.506, 400);
		AddFire(1042.866,-1344.856,12.506, 400);
		AddFire(1042.866,-1344.856,14.656, 400);
		AddFire(1042.915,-1347.697,14.656, 400);
		AddFire(1042.154,-1339.937,11.956, 400);
    }
	else if(losowy == 8)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: BAR W DILLIMORE", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: PODPALENIE", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRZECHODZIEÑ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: BAR W DILLIMORE",1);
    	AddFire(681.627,-473.598,15.457, 400);
		AddFire(681.627,-473.598,14.177, 400);
		AddFire(679.547,-473.598,15.637, 400);
		AddFire(678.266,-473.598,15.637, 400);
		AddFire(675.796,-472.148,14.657, 400);
		AddFire(674.576,-472.148,14.657, 400);
		AddFire(673.396,-470.028,14.657, 400);
		AddFire(673.396,-468.698,14.657, 400);
		AddFire(673.396,-465.828,14.657, 400);
		AddFire(672.246,-465.828,14.657, 400);
		AddFire(673.975,-463.198,15.717, 400);
		AddFire(673.975,-464.258,15.717, 400);
		AddFire(673.975,-459.138,15.717, 400);
		AddFire(673.975,-458.078,15.717, 400);
		AddFire(667.795,-455.208,14.887, 400);
		AddFire(669.115,-455.208,14.887, 400);
		AddFire(670.155,-455.208,14.887, 400);
		AddFire(670.155,-456.478,14.887, 400);
		AddFire(674.785,-448.958,15.987, 400);
		AddFire(673.225,-448.958,15.987, 400);
		AddFire(692.644,-452.308,15.987, 400);
		AddFire(692.644,-453.698,15.987, 400);
		AddFire(689.085,-457.988,15.457, 400);
		AddFire(689.085,-458.678,15.457, 400);
		AddFire(689.085,-462.858,15.457, 400);
		AddFire(689.085,-463.728,15.457, 400);
		AddFire(689.085,-467.868,15.457, 400);
		AddFire(689.085,-468.638,15.457, 400);
		AddFire(687.184,-472.008,14.697, 400);
		AddFire(684.235,-473.468,15.467, 400);
    }
	else if(losowy == 9)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: URZ¥D MIASTA PALOMINO CREEK", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: WYBUCH INSTALACJI ELEKTRYCZNEJ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRACOWNIK URZÊDU MIASTA", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: URZ¥D MIASTA PALOMINO CREEK",1);
    	AddFire(2269.603,-74.425,25.554, 400);
		AddFire(2269.603,-74.425,24.344, 400);
		AddFire(2265.882,-76.155,24.344, 400);
		AddFire(2266.783,-76.155,24.344, 400);
		AddFire(2266.783,-76.155,27.574, 400);
		AddFire(2265.833,-76.155,27.574, 400);
		AddFire(2263.582,-76.155,27.574, 400);
		AddFire(2261.831,-76.155,27.574, 400);
		AddFire(2260.870,-76.155,27.574, 400);
		AddFire(2259.750,-76.155,27.574, 400);
		AddFire(2257.250,-76.155,27.574, 400);
		AddFire(2255.900,-76.155,27.574, 400);
		AddFire(2254.439,-76.155,27.574, 400);
		AddFire(2253.129,-76.155,27.574, 400);
		AddFire(2255.081,-76.155,24.344, 400);
		AddFire(2256.581,-76.155,24.344, 400);
		AddFire(2259.382,-76.155,24.344, 400);
		AddFire(2260.893,-76.155,24.344, 400);
		AddFire(2262.263,-76.155,24.344, 400);
		AddFire(2263.484,-76.155,24.344, 400);
    }
	else if(losowy == 10)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: SKLEP 24/7 - IDLEWOOD", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: PODPALENIE", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRZECHODZIEÑ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: SKLEP 24/7 - IDLEWOOD",1);
		AddFire(1833.399,-1840.566,12.578, 400);
		AddFire(1833.399,-1838.866,12.578, 400);
		AddFire(1833.399,-1837.385,12.578, 400);
		AddFire(1833.399,-1836.025,12.578, 400);
		AddFire(1833.719,-1842.266,12.578, 400);
		AddFire(1833.719,-1842.266,11.268, 400);
		AddFire(1833.719,-1843.546,11.268, 400);
		AddFire(1833.719,-1843.546,12.728, 400);
		AddFire(1833.719,-1845.406,12.728, 400);
		AddFire(1833.719,-1846.675,12.728, 400);
		AddFire(1833.719,-1848.166,12.728, 400);
		AddFire(1833.719,-1849.596,12.728, 400);
		AddFire(1833.719,-1849.596,11.348, 400);
		AddFire(1833.719,-1848.346,11.348, 400);
		AddFire(1833.719,-1847.066,11.348, 400);
		AddFire(1833.719,-1845.565,11.348, 400);
		AddFire(1833.719,-1839.965,11.348, 400);
		AddFire(1833.719,-1838.075,11.348, 400);
		AddFire(1833.719,-1836.774,11.348, 400);
		AddFire(1833.719,-1835.814,11.348, 400);
	}
	else if(losowy == 11)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: MOTEL JEFFERSON", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: PODPALENIE", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRZECHODZIEÑ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: MOTEL JEFFERSON",1);
    	AddFire(2233.332,-1160.049,23.629, 400);
		AddFire(2233.332,-1160.049,25.089, 400);
		AddFire(2233.332,-1164.379,25.089, 400);
		AddFire(2233.332,-1167.989,25.089, 400);
		AddFire(2233.332,-1168.569,25.089, 400);
		AddFire(2233.332,-1173.290,25.089, 400);
		AddFire(2233.332,-1173.960,25.089, 400);
		AddFire(2233.332,-1178.490,25.089, 400);
		AddFire(2233.332,-1178.860,28.969, 400);
		AddFire(2233.332,-1178.190,28.969, 400);
		AddFire(2233.332,-1174.799,28.969, 400);
		AddFire(2233.332,-1173.638,28.969, 400);
		AddFire(2233.332,-1166.036,28.969, 400);
		AddFire(2233.332,-1168.997,28.969, 400);
		AddFire(2233.332,-1162.736,28.969, 400);
		AddFire(2233.332,-1156.636,28.969, 400);
		AddFire(2231.270,-1181.046,28.969, 400);
		AddFire(2230.629,-1181.046,28.969, 400);
		AddFire(2225.800,-1181.046,28.969, 400);
		AddFire(2221.389,-1181.046,28.969, 400);
		AddFire(2221.609,-1181.046,25.019, 400);
		AddFire(2222.350,-1181.046,25.019, 400);
		AddFire(2225.631,-1181.046,25.019, 400);
		AddFire(2226.402,-1181.046,25.019, 400);
		AddFire(2230.953,-1181.046,25.019, 400);
		AddFire(2216.340,-1181.046,25.019, 400);
		AddFire(2215.340,-1181.046,25.019, 400);
		AddFire(2212.369,-1181.046,25.019, 400);
		AddFire(2211.419,-1181.046,25.019, 400);
		AddFire(2208.118,-1181.046,25.019, 400);

	}
	else if(losowy == 12)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: SALON AUT", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: PODPALENIE", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRACOWNIK", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: SALON AUT",1);
    	AddFire(2133.200,-1151.196,23.681, 400);
    	AddFire(2133.200,-1151.196,22.271, 400);
    	AddFire(2131.720,-1151.196,22.271, 400);
    	AddFire(2131.720,-1151.196,23.901, 400);
    	AddFire(2133.280,-1151.196,23.901, 400);
    	AddFire(2130.200,-1151.196,22.091, 400);
    	AddFire(2130.200,-1151.196,23.991, 400);
    	AddFire(2129.100,-1152.456,23.991, 400);
    	AddFire(2129.100,-1152.456,22.391, 400);
    	AddFire(2129.100,-1152.456,21.771, 400);
    	AddFire(2128.350,-1154.136,21.771, 400);
    	AddFire(2128.350,-1154.136,23.331, 400);
    	AddFire(2127.289,-1155.017,23.331, 400);
    	AddFire(2127.289,-1155.017,21.561, 400);
    	AddFire(2126.108,-1155.017,23.441, 400);
    	AddFire(2126.108,-1155.017,21.871, 400);
    	AddFire(2125.038,-1155.017,21.871, 400);
    	AddFire(2125.038,-1155.017,23.741, 400);
    	AddFire(2135.179,-1153.978,23.741, 400);
    	AddFire(2135.179,-1153.978,22.291, 400);
    	AddFire(2136.650,-1153.978,22.291, 400);
    	AddFire(2137.891,-1155.278,22.291, 400);
    	AddFire(2137.891,-1155.278,23.691, 400);
    	AddFire(2136.401,-1154.978,23.691, 400);
    	AddFire(2135.991,-1154.978,22.661, 400);
	}
	else if(losowy == 13)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: GUNSHOP OBOK BAZY LSFD", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: PODPALENIE", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRACOWNIK", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: GUNSHOP OBOK BAZY LSFD",1);
    	AddFire(1781.413,-1161.296,22.015, 400);
    	AddFire(1781.413,-1161.296,23.765, 400);
    	AddFire(1782.823,-1161.837,23.765, 400);
    	AddFire(1782.823,-1161.837,22.205, 400);
    	AddFire(1784.974,-1162.087,22.205, 400);
    	AddFire(1784.974,-1162.087,24.025, 400);
    	AddFire(1786.814,-1162.687,23.765, 400);
    	AddFire(1786.814,-1162.687,22.215, 400);
    	AddFire(1790.015,-1162.687,22.215, 400);
    	AddFire(1790.015,-1162.687,23.755, 400);
    	AddFire(1791.174,-1163.257,23.755, 400);
    	AddFire(1791.174,-1163.257,22.385, 400);
    	AddFire(1792.675,-1163.487,22.385, 400);
    	AddFire(1792.675,-1163.487,23.665, 400);
    	AddFire(1793.835,-1164.227,23.665, 400);
    	AddFire(1793.835,-1164.227,22.335, 400);
    	AddFire(1796.146,-1165.588,22.335, 400);
    	AddFire(1797.456,-1165.588,22.335, 400);
    	AddFire(1797.456,-1165.588,23.245, 400);
    	AddFire(1796.136,-1165.588,23.245, 400);
    	AddFire(1799.976,-1166.208,23.245, 400);
    	AddFire(1801.527,-1166.558,23.245, 400);
    	AddFire(1801.527,-1166.558,22.225, 400);
    	AddFire(1800.627,-1166.558,22.225, 400);
    	AddFire(1799.576,-1166.558,22.225, 400);
	}
	else if(losowy == 14)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: BUDYNEK OBOK BIUROWCA FBI", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: WYBUCH INSTALACJI ELEKTRYCZNEJ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRZECHODZIEÑ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: BUDYNEK OBOK BIUROWCA FBI",1);
    	AddFire(651.468,-1458.514,14.407, 400);
    	AddFire(651.468,-1459.935,14.407, 400);
    	AddFire(651.468,-1460.804,14.407, 400);
    	AddFire(651.468,-1461.935,14.407, 400);
    	AddFire(651.468,-1464.714,14.407, 400);
    	AddFire(651.468,-1464.465,14.407, 400);
    	AddFire(651.468,-1467.434,14.407, 400);
    	AddFire(651.468,-1468.714,14.407, 400);
    	AddFire(651.468,-1471.725,14.407, 400);
    	AddFire(651.468,-1473.015,14.407, 400);
    	AddFire(651.468,-1475.204,14.407, 400);
    	AddFire(651.468,-1476.334,14.407, 400);
    	AddFire(650.267,-1458.384,18.107, 400);
    	AddFire(650.267,-1461.725,18.107, 400);
    	AddFire(650.267,-1462.935,18.107, 400);
    	AddFire(650.267,-1457.674,18.107, 400);
    	AddFire(650.267,-1466.296,18.107, 400);
    	AddFire(650.267,-1467.176,18.107, 400);
    	AddFire(650.267,-1471.336,18.107, 400);
    	AddFire(650.267,-1470.726,18.107, 400);
    	AddFire(650.267,-1474.856,18.107, 400);
    	AddFire(650.267,-1475.676,18.107, 400);
    	AddFire(650.267,-1478.786,18.107, 400);
    	AddFire(650.267,-1479.746,18.107, 400);
    	AddFire(650.267,-1483.306,18.107, 400);
	}
	else if(losowy == 15)
	{
		GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "           UWAGA: WYBUCH£ PO¯AR!", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "MIEJSCE PO¯ARU: BUDYNEK OBOK VINYL CLUB", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "PRZYCZYNA PO¯ARU: WYBUCH INSTALACJI ELEKTRYCZNEJ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "ZG£OSI£: PRZECHODZIEÑ", true);
    	GroupSendMessage(FRAC_ERS, 0xAA3333AA, "         !!!!UDAJ SIÊ NA MIEJSCE!!!!", true);
    	GroupSendMessage(FRAC_ERS, 0xFFFFFFAA, fraction_name, true);
    	ABroadCast(COLOR_YELLOW,"[SYSTEM PO¯ARÓW] Aktywowano po¿ar: BUDYNEK OBOK VINYL CLUB",1);
    	AddFire(830.011,-1385.443,15.928, 400);
    	AddFire(830.862,-1385.703,15.928, 400);
    	AddFire(831.782,-1385.703,15.928, 400);
    	AddFire(833.052,-1385.703,15.928, 400);
    	AddFire(834.223,-1385.703,15.928, 400);
    	AddFire(835.523,-1385.703,15.928, 400);
    	AddFire(836.323,-1385.703,15.928, 400);
    	AddFire(837.363,-1385.703,15.928, 400);
    	AddFire(838.973,-1385.703,15.928, 400);
    	AddFire(839.923,-1385.703,15.928, 400);
    	AddFire(841.233,-1385.703,15.928, 400);
    	AddFire(841.973,-1385.703,15.928, 400);
    	AddFire(843.453,-1385.703,15.928, 400);
    	AddFire(844.494,-1385.703,15.928, 400);
    	AddFire(845.274,-1385.703,15.928, 400);
    	AddFire(846.544,-1385.703,15.928, 400);
    	AddFire(846.544,-1385.703,17.368, 400);
    	AddFire(845.114,-1385.703,17.368, 400);
    	AddFire(843.343,-1385.703,17.368, 400);
    	AddFire(841.693,-1385.703,17.368, 400);
    	AddFire(840.073,-1385.703,17.368, 400);
    	AddFire(838.413,-1385.703,17.368, 400);
    	AddFire(837.153,-1385.703,17.368, 400);
    	AddFire(835.993,-1385.703,17.368, 400);
    	AddFire(834.203,-1385.703,17.368, 400);
    	AddFire(832.373,-1385.703,17.368, 400);
    	AddFire(830.103,-1385.703,17.368, 400);
    	AddFire(830.952,-1385.703,17.368, 400);
    	AddFire(833.223,-1385.703,17.368, 400);
    	AddFire(834.723,-1385.703,17.368, 400);
	}
    return 1;
}

//tazer
forward DostalTazerem(playerid);
public DostalTazerem(playerid)
{
    TogglePlayerControllable(playerid, 1);
    TazerAktywny[playerid] = 0;
    GameTextForPlayer(playerid, "JUZ MOZESZ SIE RUSZAC!", 3000, 5);
    ClearAnimations(playerid);
    SetPlayerDrunkLevel(playerid, 3000);
    return 1;
}
//tazer

//po /ob

forward WstalPoOB(playerid);
public WstalPoOB(playerid)
{
    GameTextForPlayer(playerid, "Odzyskales sprawnosc", 3000, 5);
    ClearAnimations(playerid);
	return 1;
}

//AFK timer
forward PlayerAFK(playerid, afktime, breaktime);
public PlayerAFK(playerid, afktime, breaktime)
{
	if(IsPlayerPaused(playerid) || IdleCount[playerid] >= MAX_IDLE_COUNT)
	{
		new caption[32];
		if(afktime < 60)
			format(caption, sizeof(caption), "[AFK] %d sekund (%d)", afktime, playerid);
		else
			format(caption, sizeof(caption), "[AFK] %d min. %d sek (%d)", afktime/60, afktime%60, playerid);
		if(afktime > 600 && (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid)))
		{
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				if(afktime > 900 && PlayerInfo[playerid][pAdmin] != 5000)
				{
					SendClientMessage(playerid, 0xAA3333AA, "Nie wolno afczyæ podczas @Duty! Otrzymujesz Kicka za AFK (15min)");
					SetTimerEx("KickEx", 500, false, "i", playerid);
				}
			}
		}

		AFKTime[playerid] = afktime;
		SetPlayerChatBubble(playerid, caption, 0x33AA33AA, 20.0, 1500);
		afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, afktime+1, 0);
	}
	else
	{
		if(breaktime > afktime || breaktime > 180)
		{
			printf("%s byl afk przez %d", GetNickEx(playerid), afktime);
			afk_timer[playerid] = -1;
			AFKTime[playerid] = 0;
		}
		else
		{
			afk_timer[playerid] = SetTimerEx("PlayerAFK", 1000, false, "iii", playerid, afktime, breaktime+1);
		}
	}
	return 1;
}

forward CheckChangeWeapon();
public CheckChangeWeapon()
{
	foreach (new i : Player)
	{
		new weaponID = GetPlayerWeapon(i);
		new playerState = GetPlayerState(i);
		if(MyWeapon[i]!=weaponID)
		{
			if(gPlayerLogged[i] == 1 || TutTime[i] >= 1)
			{
				if(playerState == 1)
				{
					if(GetPVarInt(i, "dutyadmin") == 0)
					{
						if(PlayerInfo[i][pInjury] > 0 || PlayerInfo[i][pBW] > 0)
						{
							return PlayerChangeWeaponOnInjury(i);
						}
						// else
						// {
						// 	if(PlayerPersonalization[i][PERS_GUNSCROLL] == 1) return SetPlayerArmedWeapon(i, MyWeapon[i]);
						// 	if(PokazDialogBronie(i) == 0)
						// 	{
						// 		MyWeapon[i] = 0;
						// 		SetPlayerArmedWeapon(i, 0);
						// 	}
						// }
					}
				}
			}
			else
			{
				ResetPlayerWeapons(i);
			}
		}
	}
	return 1;
}


forward MainTimer();
public MainTimer()
{
    JednaSekundaTimer();
	SlapperTimer();
    if(TICKS_Second)
    {
        Spectator();
        GangZone_Process();
		KradziezAut();
		AntiSpawn_Timer();
    }
    if(TICKS_3Sec == 2)
    {
        VehicleUpdate();
        CustomPickups();
        GangZone_ShowInfoToParticipants();
    }
    if(TICKS_MySQLRefresh == 14)
    {
        MySQL_Refresh();
    }
	if(TICKS_CheckGas == 19)
	{
		CheckGas();
	}
    if(TICKS_HalfMin == 29)
    {
        CarCheck();
    }
    if(TICKS_1Min == 59)
    {
		PlayersCheckerMinute();
        SyncUp();
		TimeUpdater();
		IdleKick();
    }
    if(TICKS_5Min == (60*5)-1)
    {
        Production();
    }
    if(TICKS_15Min == (60*15)-1)
    {
        ServerStuffSave();
		//IdleKick();
    }
    if(TICKS_30Min == (60*30)-1)
    {
        SaveAccounts();
    }

    PatrolGPS();
	for(new i = 0, j = GetPlayerPoolSize(); i <= j; i++)
	{
    	Ograniczenia(i);
	}
    //ADD TIME
    if(TICKS_Second)
        TICKS_Second = false;
    else
        TICKS_Second = true;

    if(TICKS_3Sec == 3)
        TICKS_3Sec = 0;
    else
        TICKS_3Sec++;

    if(TICKS_MySQLRefresh == 15)
        TICKS_MySQLRefresh = 0;
    else
        TICKS_MySQLRefresh++;

	if(TICKS_CheckGas == 20)
        TICKS_CheckGas = 0;
    else
        TICKS_CheckGas++;

    if(TICKS_HalfMin == 30)
        TICKS_HalfMin = 0;
    else
        TICKS_HalfMin++;

    if(TICKS_1Min == 60)
        TICKS_1Min = 0;
    else
        TICKS_1Min++;

    if(TICKS_5Min == 60*5)
        TICKS_5Min = 0;
    else
        TICKS_5Min++;

    if(TICKS_15Min == 60*15)
        TICKS_15Min = 0;
    else
        TICKS_15Min++;

    if(TICKS_30Min == 60*30)
        TICKS_30Min = 0;
    else
        TICKS_30Min++;
}

forward SaveMyAccountTimer(playerid);
public SaveMyAccountTimer(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid] == 1)
		{
			MruMySQL_SaveAccount(playerid);
		}
	}
	return 1;
}

public ServerStuffSave()
{
    new lTime = gettime();
    for(new i=0;i<MAX_OILS;i++)
    {
        if(Oil_IsValid(i))
        {
            if(OilData[i][oilTime]+3600 < lTime)
            {
                Oil_Destroy(i);
            }
        }
    }
}

public Spectator()
{
	new string[128], specid, Float:specHP, specNAME[MAX_PLAYER_NAME+1], weaponID, playerState;

    if(PDGPS != -1)
	{
        new Float:x, Float:y, Float:z;
		GetPlayerPos(PDGPS, x, y, z);
		foreach(new i : Player)
		{
			if(IsAPolicja(i) || IsAMedyk(i) || IsPlayerInFraction(i, FRAC_BOR) || (IsPlayerInGroup(i, 9) && SanDuty[i] == 1) || (PlayerInfo[i][pLider] == 9 && SanDuty[i] == 1) || IsPlayerInGroup(i, 17))
			{
				if(zawodnik[i] == 0)
					SetPlayerCheckpoint(i, x, y, z, 4.0);
			}
		}
	}

	foreach(new i : Player)
	{
		if(IsPlayerNPC(i)) continue;
        if(!IsPlayerConnected(i)) continue;
		
        if(ScenaCreated)
        {
            if(GetPVarInt(i, "scena-audio") == 0)
            {
                if(IsPlayerInRangeOfPoint(i, 100.0, ScenaPosition[0],ScenaPosition[1],ScenaPosition[2]))
                {
                    PlayAudioStreamForPlayer(i, ScenaAudioStream, ScenaPosition[0],ScenaPosition[1],ScenaPosition[2], 100.0, 1);
                    SetPVarInt(i, "scena-audio", 1);
                }
            }
            else if(GetPVarInt(i, "scena-audio") == 1)
            {
                if(!IsPlayerInRangeOfPoint(i, 100.0, ScenaPosition[0],ScenaPosition[1],ScenaPosition[2]))
                {
                    StopAudioStreamForPlayer(i);
                    SetPVarInt(i, "scena-audio", 0);
                }
            }
        }
		
        //Vinyl audio check
        if(!GetPVarInt(i, "VINYL-stream"))
        {
            if(IsPlayerInRangeOfPoint(i, VinylAudioPos[3], VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2]) && (GetPlayerVirtualWorld(i) == 71 || GetPlayerVirtualWorld(i) == 72))
            {
                SetPVarInt(i, "VINYL-stream", 1);
                PlayAudioStreamForPlayer(i, VINYL_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
            }
        }
        else
        {
            if(!IsPlayerInRangeOfPoint(i, VinylAudioPos[3], VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2]))
            {
                SetPVarInt(i, "VINYL-stream", 0);
                StopAudioStreamForPlayer(i);
            }
        }
        //END vinyl
		//Ibiza audio check
        if(GetPVarInt(i, "IBIZA-stream") == 0)
        {
            if(IsPlayerInRangeOfPoint(i, IbizaAudioPos[3], IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2]) && (GetPlayerVirtualWorld(i) == 21 || GetPlayerVirtualWorld(i) == 22 || GetPlayerVirtualWorld(i) == 23 || GetPlayerVirtualWorld(i) == 24 || GetPlayerVirtualWorld(i) == 26 || GetPlayerVirtualWorld(i) == 27))
            {
                SetPVarInt(i, "IBIZA-stream", 1);
                PlayAudioStreamForPlayer(i, IBIZA_Stream,IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2], IbizaAudioPos[3], 1);
            }
        }
        else
        {
            if(!IsPlayerInRangeOfPoint(i, IbizaAudioPos[3], IbizaAudioPos[0],IbizaAudioPos[1],IbizaAudioPos[2]) && !(GetPlayerVirtualWorld(i) == 21 || GetPlayerVirtualWorld(i) == 22 || GetPlayerVirtualWorld(i) == 23 || GetPlayerVirtualWorld(i) == 24 || GetPlayerVirtualWorld(i) == 26 || GetPlayerVirtualWorld(i) == 27))
            {
                SetPVarInt(i, "IBIZA-stream", 0);
                StopAudioStreamForPlayer(i);
            }
        }
        //END ibiza
		if(GetPlayerPing(i) >= 2000 && PlayerInfo[i][pAdmin] == 0)
		{
			if(gPlayerLogged[i] == 1)
			{
				if(!IsPlayerPremiumOld(i))
				{
					SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka, POWÓD: Ping wiêkszy ni¿ 2 000");
					KickEx(i);
				}
			}
		}
        //BW
		if(PlayerInfo[i][pInjury] > 0)
        {
            RannyTimer(i);
        }
        if(PlayerInfo[i][pBW] > 0)
        {
			BWTimer(i);
        }
		if((specid = Spectate[i]) != INVALID_PLAYER_ID)
		{
			if(IsPlayerConnected(specid))
			{
				new specIP[32];
				GetPlayerName(specid, specNAME, sizeof(specNAME));
				GetPlayerHealth(specid, specHP);
				GetPlayerIp(specid, specIP, sizeof(specIP));
				if(PlayerInfo[i][pAdmin] > 0 || IsAScripter(i)) format(string, sizeof(string), "~y~%s~w~(ID:~y~%d~w~)~n~HP: ~y~%.1f~w~~n~IP: ~y~%s",specNAME,specid,specHP,specIP);
				else format(string, sizeof(string), "~y~%s~w~(ID:~y~%d~w~)~n~HP: ~y~%.1f",specNAME,specid,specHP);
				TextDrawSetString(TextDrawInfo[i], string);
				TextDrawShowForPlayer(i, TextDrawInfo[i]);
				SpectateTime[i]++;
				if(GetPlayerInterior(i) != GetPlayerInterior(specid))
				{
                    SetPlayerInterior(i,GetPlayerInterior(specid));
				}
				if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(specid))
				{
					SetPlayerVirtualWorld(i,GetPlayerInterior(specid));
				}
                if(IsPlayerInAnyVehicle(specid) && GetPVarInt(i, "spec-type") != 2) PlayerSpectateVehicle(i, GetPlayerVehicleID(specid), SPECTATE_MODE_NORMAL), SetPVarInt(i, "spec-type", 2);
                else if(!IsPlayerInAnyVehicle(specid) && GetPVarInt(i, "spec-type") != 1) PlayerSpectatePlayer(i, specid, SPECTATE_MODE_NORMAL), SetPVarInt(i, "spec-type", 1);
			}
		}
		if(GetPlayerSpecialAction(i) == SPECIAL_ACTION_USEJETPACK)
		{
			KickEx(i);
		}

        weaponID = GetPlayerWeapon(i);
        playerState = GetPlayerState(i);

		if(gPlayerLogged[i] == 1 || TutTime[i] >= 1)
		{
			if(playerState >= 1 && playerState <= 6)
			{
				new ac_val = WeaponAC(i);
				if(ac_val)
				{
					if(AntySpawnBroni[i] >= 1)
					{
						AntySpawnBroni[i] --;
					}
					else
					{
						if(GetPVarInt(i, "bypassac-forweapon") != weaponID)
						{
							format(string, sizeof(string), "Dosta³eœ kicka od systemu, powód: Spawn Broni [%d]", ac_val);
							SendClientMessage(i, COLOR_PANICRED, string);
							KickEx(i);
						}
					}
				}
				if(weaponID >= 2 && weaponID <= 45)
				{
                    switch(weaponID)
                    {
    					case 2://kij golfowy
    					{
    						if(PlayerInfo[i][pGun1] != 2)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 3://pa³ka policyjna
    					{
    						if(PlayerInfo[i][pGun1] != 3)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
                        case 4://nó¿
    					{
    						if(PlayerInfo[i][pGun1] != 4 && !IsPlayerInGroup(i, 8) && PlayerInfo[i][pLider] != 8)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 5://bejzbol
    					{
    						if(PlayerInfo[i][pGun1] != 5)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 6://³opata
    					{
    						if(PlayerInfo[i][pGun1] != 6)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 7://bliard
    					{
    						if(PlayerInfo[i][pGun1] != 7)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 8://katana
    					{
    						if(PlayerInfo[i][pGun1] != 8)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 9://pi³a
    					{
    						if(PlayerInfo[i][pGun1] != 9)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 10://Purple Dildo
    					{
    						if(PlayerInfo[i][pGun10] != 10)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 11://Small White Vibrator
    					{
    						if(PlayerInfo[i][pGun10] != 11)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 12://Large White Vibrator
    					{
    						if(PlayerInfo[i][pGun10] != 12)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 13://Silver Vibrator
    					{
    						if(PlayerInfo[i][pGun10] != 13)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 14://kwiaty
    					{
    						if(PlayerInfo[i][pGun10] != 14)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 15://laska
    					{
    						if(PlayerInfo[i][pGun10] != 15)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 16://granat
    					{
    						if(PlayerInfo[i][pGun8] != 16)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 17://granat dymny
    					{
    						if(PlayerInfo[i][pGun8] != 17)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 18://molotov
    					{
    						if(PlayerInfo[i][pGun8] != 18)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					//Broñ 19, 20 i 21 nie istniej¹
    					case 22://9mm
    					{
    						if(PlayerInfo[i][pGun2] != 22)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							if(GetPVarInt(i, "bypassac-forweapon") != weaponID)
									{
										SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
										KickEx(i);
									}
                                }
    						}
    					}
    					case 23://9mm t³umik
    					{
    						if(PlayerInfo[i][pGun2] != 23)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							if(GetPVarInt(i, "bypassac-forweapon") != weaponID)
									{
										SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
										KickEx(i);
									}
                                }
    						}
    					}
    					case 24://desert eagle
    					{
    						if(PlayerInfo[i][pGun2] != 24)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
									if(GetPVarInt(i, "bypassac-forweapon") != weaponID)
									{
										SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
										KickEx(i);
									}
                                }
    						}
    					}
    					case 25://Shotgun
    					{
    						if(PlayerInfo[i][pGun3] != 25)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							if(GetPVarInt(i, "bypassac-forweapon") != weaponID)
									{
										SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
										KickEx(i);
									}
                                }
    						}
    					}
    					case 26://obrzyny
    					{
    						if(PlayerInfo[i][pGun3] != 26)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 27://spas12
    					{
    						if(PlayerInfo[i][pGun3] != 27)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 28://uzi
    					{
    						if(PlayerInfo[i][pGun4] != 28)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 29://mp5
    					{
    						if(PlayerInfo[i][pGun4] != 29)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 30://ak-47
    					{
    						if(PlayerInfo[i][pGun5] != 30)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							if(GetPVarInt(i, "bypassac-forweapon") != weaponID)
									{
										SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
										KickEx(i);
									}
                                }
    						}
    					}
    					case 31://m4
    					{
    						if(PlayerInfo[i][pGun5] != 31)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							if(GetPVarInt(i, "bypassac-forweapon") != weaponID)
									{
										SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
										KickEx(i);
									}
                                }
    						}
    					}
    					case 32://tec9
    					{
    						if(PlayerInfo[i][pGun4] != 32)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 33://rifle
    					{
    						if(PlayerInfo[i][pGun6] != 33)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 34://snajperka
    					{
    						if(PlayerInfo[i][pGun6] != 34)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 35://rakietnica
    					{
    						if(PlayerInfo[i][pGun7] != 35)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 36://bazooka
    					{
    						if(PlayerInfo[i][pGun7] != 36)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 37://ogniomiotacz
    					{
    						if(PlayerInfo[i][pGun7] != 37)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 38://minigun
    					{
    						if(PlayerInfo[i][pGun7] != 38)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 39://c4
    					{
    						if(PlayerInfo[i][pGun8] != 39)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
                        }
    					case 41://sprej
    					{
    						if(PlayerInfo[i][pGun9] != 41)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 42://gaœnica
    					{
    						if(PlayerInfo[i][pGun9] != 42)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 43://aparat
    					{
    						if(PlayerInfo[i][pGun9] != 43)
    						{
    							ResetPlayerWeapons(i);
    							PrzywrocBron(i);
    						}
    					}
    					case 44://Nightvision Goggles
    					{
    						if(PlayerInfo[i][pGun11] != 44)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
    					case 45://Thermal Goggles
    					{
    						if(PlayerInfo[i][pGun11] != 45)
    						{
    							if(AntySpawnBroni[i] >= 1)
    							{
    								AntySpawnBroni[i] --;
    							}
                                else
                                {
        							SendClientMessage(i, COLOR_PANICRED, "Dosta³eœ kicka od systemu, powód: Spawn Broni");
        							KickEx(i);
                                }
    						}
    					}
                    }
					if( playerState == 2 || playerState == 3)
					{
						if(weaponID == 24 || weaponID == 27)
						{
							SetPlayerArmedWeapon(i, 0 );
						}
						else
						{
							SetPlayerArmedWeapon(i, weaponID );
						}
					}
				}
			}
		}
		else
		{
			ResetPlayerWeapons(i);
		}
		//CheckPlayersAimAtNPC(i);
	//}
	//tu bylo /me wyciaga bron

	}
    return 1;
}

public SyncUp()
{
	SyncTime();
	DollahScoreUpdate();
	return 1;
}

public SyncTime()
{
	new string[64];
	new tmphour,tmpminute,tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	if(tmphour != GLOB_LastHour)
	{
		format(string, sizeof(string), "Jest teraz godzina {0073FF}%d:00",tmphour);
		BroadCast(COLOR_WHITE,string);
		PayDay();
        GLOB_LastHour=tmphour;
		if (realtime)
		{
            new ltime=0;
            ltime = CallRemoteFunction("GetRealTime", "d", tmphour);
			SetWorldTime(ltime == 0 ? tmphour : ltime);
			ServerTime = tmphour;
		}
	}
	return 1;
}

public SaveAccounts()
{
    foreach(new i : Player)
	{
		if(IsPlayerNPC(i)) continue;
		if(PlayerInfo[i][pJob] > 0)
		{
			if(PlayerInfo[i][pContractTime] < 25)
			{
				PlayerInfo[i][pContractTime] ++;
			}
		}
	}
	return 1;
}

public Production()
{
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i)) continue;
		if(PlayerDrunk[i] > 0) { PlayerDrunkTime[i] = 0; GameTextForPlayer(i, "~p~Jestes mniej pijany~n~~r~Pijaku", 3500, 1); }
		if(GetPlayerDrunkLevel(i) < 1999 && PlayerDrunk[i] > 0) { PlayerDrunk[i] = 0; PlayerDrunkTime[i] = 0; GameTextForPlayer(i, "~p~Wytrzezwiales~n~~r~Pijaku", 3500, 1); }
		if(PlayerInfo[i][pPayDay] < 6 && !IsPlayerPaused(i)) { PlayerInfo[i][pPayDay] += 1; } //+ 5 min to PayDay anti-abuse
		new wl = PoziomPoszukiwania[i];
		PlayerInfo[i][pWL] = wl;
	}
	return 1;
}

public CustomPickups()
{
	new mystate;
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i)) continue;
        mystate = GetPlayerState(i);
		if (IsPlayerInRangeOfPoint(i, 2.0, 323.0342,1118.5804,1083.8828))
		{//Buyable Drugs for Drug Dealers
			GameTextForPlayer(i, "~w~Wpisz /get dragi aby wziasc ~r~Dragi~y~~n~Dostosowane do twojego skillu", 5000, 3);
		}
		else if (IsPlayerInRangeOfPoint(i, 3, 1310.0885, -1367.6865, 13.8504))
		{
			GameTextForPlayer(i, "~y~Witamy przed ~r~Ratuszem~n~~w~Wpisz /wejdz aby wejsc", 5000, 5);
		}
		else if (mystate == 1 &&IsPlayerInRangeOfPoint(i, 2.0, 1215.1304,-11.8431,1000.9219))
		{
			GameTextForPlayer(i, "~g~Witaj,~n~~y~mozesz tu zostac ~r~Prostytutka~n~~w~Wpisz /dolacz jesli chcesz nia zostac", 5000, 3);
		}
		else if (mystate == 1 &&IsPlayerInRangeOfPoint(i, 2.0, 2166.3772,-1675.3829,15.0859))
		{
			GameTextForPlayer(i, "~g~Witaj,~n~~y~mozesz tu zostac ~r~Dilerem Dragow~n~~w~Wpisz /dolacz jesli chcesz nim zostac", 5000, 3);
		}
		else if (mystate == 1 &&IsPlayerInRangeOfPoint(i, 2.0, 1109.3318,-1796.3042,16.5938))
		{
			GameTextForPlayer(i, "~g~Witaj,~n~~y~mozesz tu zostac ~r~Zlodziejem Aut~n~~w~Wpisz /dolacz jesli chcesz nim zostac", 5000, 3);
		}
		else if (mystate == 1 &&IsPlayerInRangeOfPoint(i, 0.5,1820.0637,-1315.9836,109.9520))
		{
			if(IsPlayerInGroup(i, 9) || PlayerInfo[i][pLider] == 9) { GameTextForPlayer(i, "~w~Wpisz ~r~/gazeta ~w~aby stworzyc nowa gazete",5000,3); }
			else if(PlayerInfo[i][pJob] == 15) { GameTextForPlayer(i, "~w~Wpisz ~r~/gazety ~w~aby zobaczyc wszystki gazety",5000, 3); }
		}
		else if (mystate == 1 &&IsPlayerInRangeOfPoint(i, 2.0, 1366.4325,-1275.2096,13.5469))
		{
			if(PlayerInfo[i][pJob] > 0 || PlayerInfo[i][pMember] > 0) {}
			else { GameTextForPlayer(i, "~g~Witaj,~n~~y~mozesz tu zostac ~r~Dilerem Broni~n~~w~Wpisz /dolacz jesli chcesz nim zostac", 5000, 3); }
		}
		else if (mystate == 1 &&IsPlayerInRangeOfPoint(i, 2.0, 766.0804,14.5133,1000.7004))
		{
			if(PlayerInfo[i][pJob] > 0 || PlayerInfo[i][pMember] > 0) {}
			else { GameTextForPlayer(i, "~g~Witaj,~n~~y~mozesz tu zostac ~r~Bokserem~n~~w~Wpisz /dolacz jesli chcesz nim zostac", 5000, 3); }
		}
		else if (mystate == 1 &&IsPlayerInRangeOfPoint(i, 2.0, 1381.0413,-1088.8511,27.3906))
		{
			GameTextForPlayer(i, "~g~Witamy,~n~~y~Wpisz /misje aby zobaczyc dostepne misje", 5000, 3);
		}
		else if (IsPlayerInRangeOfPoint(i, 2.0, 327.5762,-1546.8887,13.8364))
		{
			GameTextForPlayer(i, "~g~Wpisz ~w~/kamera-w ~g~aby ogladac kamere", 5000, 3);
		}
		else if (mystate == 1 && GraczBankomat(i))
		{
			GameTextForPlayer(i, "~g~Uzyj ~w~/wplac ~g~lub ~w~/wyplac~n~ ~g~aby skorzystac z bankomatu", 5000, 3);
		}

        if(IsPlayerInAnyVehicle(i)) continue;
        for(new j=0;j<MAX_BOOMBOX;j++)
        {
            if(BoomBoxData[j][BBD_x] == 0.0 || !BoomBoxData[j][BBD_Standby]) continue;
            if(IsPlayerInRangeOfPoint(i, MAX_BBD_DISTANCE, BoomBoxData[j][BBD_x], BoomBoxData[j][BBD_y], BoomBoxData[j][BBD_z]))
            {
                if(GetPVarInt(i, "bbdid") != BoomBoxData[j][BBD_ID])
                {
                    SetPVarInt(i, "bbdid", BoomBoxData[j][BBD_ID]);
                    PlayAudioStreamForPlayer(i, BoomBoxData[j][BBD_URL], BoomBoxData[j][BBD_x], BoomBoxData[j][BBD_y], BoomBoxData[j][BBD_z], MAX_BBD_DISTANCE, 1);
                }
                break;
            }
            else if(GetPVarInt(i, "bbdid") == BoomBoxData[j][BBD_ID])
            {
                SetPVarInt(i, "bbdid", 0);
                StopAudioStreamForPlayer(i);
            }
        }
	}
	return 1;
}

public IdleKick()
{
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i)) continue;
		if(PlayerInfo[i][pAdmin] < 1 || PlayerInfo[i][pNewAP] < 1)
		{
			GetPlayerPos(i, PlayerPos[i][0], PlayerPos[i][1], PlayerPos[i][2]);
			if(PlayerPos[i][0] == PlayerPos[i][3] && PlayerPos[i][1] == PlayerPos[i][4])
			{
				IdleCount[i]++;
				if(IdleCount[i] == MAX_IDLE_COUNT-1)
				{
					SendClientMessage(i, 0xAA3333AA, RandomAFKText[random(sizeof(RandomAFKText))]);
				}
				if(IdleCount[i] == MAX_IDLE_COUNT)
				{
					if(afk_timer[i] == -1)
					{
						afk_timer[i] = SetTimerEx("PlayerAFK", 1000, false, "iii", i, MAX_IDLE_COUNT*60, 0);
						SendClientMessage(i, 0xAA3333AA, sprintf("Zosta³eœ oznaczony jako AFK, poniewa¿ od %d minut siê nie poruszy³eœ.", MAX_IDLE_COUNT));
					}
				}
				//KickEx(i);
			}
			else
			{
				IdleCount[i] = 0;
			}
			PlayerPos[i][3] = PlayerPos[i][0];
			PlayerPos[i][4] = PlayerPos[i][1];
			PlayerPos[i][5] = PlayerPos[i][2];
		}
	}
	return 1;
}
forward RPGTimer();
public RPGTimer()
{
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i)) continue;
	    if(!IsPlayerConnected(i)) continue;
		new rpggun;
        new rpgammo;
        new string[128];
        GetPlayerWeaponData(i, 7, rpggun, rpgammo);
        if(rpggun == 35 && rpgammo == 0 && PlayerInfo[i][pAdmin] < 1)//rpg czit
        {
			MruDialog(i, "ACv2: Kod #2005", "Zosta³eœ wyrzucony za weapon hack RPG.");
			format(string, sizeof string, "ACv2 [#2005]: %s zosta³ wyrzucony za weapon hack RPG.", GetNick(i));
			SendCommandLogMessage(string);
			Kick(i);
		}
	}
	return 1;
}
public SlapperTimer()
{
	foreach(new i : Player)
	{
		if(IsPlayerNPC(i)) continue;
		if(GetPlayerState(i) == PLAYER_STATE_ONFOOT)
		{
			new Float:pAC_Pos[3],Float:VS ;
			GetPlayerVelocity(i, pAC_Pos[0], pAC_Pos[1], pAC_Pos[2]);
			VS = VectorSize(pAC_Pos[0], pAC_Pos[1], pAC_Pos[2])*136.6666;
			if(floatround(VS,floatround_round) >= 350)
			{
				if(PlayerSlapperWarning[i] >= 5)
				{
					if(AddPunishment(i, GetNick(i), -1, gettime(), PENALTY_BAN, 0, "Anti-Slapper", 0) == 1) {
						//MruMySQL_Banuj(i, "Anti-Slapper");
						Log(punishmentLog, WARNING, "%s zosta³ zbanowany za podejrzenie slappera (%d speeda on-foot, %d ostrze¿eñ)", GetPlayerLogName(i), floatround(VS,floatround_round), PlayerSlapperWarning[i]);
						KickEx(i);
					}
				}
				else
				{
					new ip[16];
					GetPlayerIp(i, ip, sizeof(ip));
					SendMessageToAdmin(sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] prawdopodobnie czituje. | Slapper [%d/5]", 
					GetNickEx(i), i, ip, PlayerSlapperWarning[i]), 
					0xFF00FFFF);
					PlayerSlapperWarning[i]++;
				}
			}
		}
	}
}
public JednaSekundaTimer()
{
    //25.06.2014
    new State, Float:pancerzyy,string[128],vehicleid,VehicleModel,
        Float:x, Float:y, Float:z, Float:health,
    	cop, ammo, weaponID, weaponState, taxidriver; // pZone[MAX_ZONE_NAME],

    new plname[MAX_PLAYER_NAME], Float:angle,Lost = 0, trigger = 0,winner[MAX_PLAYER_NAME], loser[MAX_PLAYER_NAME],titel[MAX_PLAYER_NAME];

	if(PaintballPlayers >= 2 && PaintballRound != 1 && StartingPaintballRound != 1)
	{
		StartingPaintballRound = 1;
	   	SetTimer("PreparePaintball", 15000, 0);
	}
	if(KartingPlayers >= 2 && KartingRound != 1 && StartingKartRound != 1)
	{
	    StartingKartRound = 1;
	    SetTimer("PrepareKarting", 15000, 0);
	}
	if(KartingRound != 0 && KartingPlayers < 2)
	{
	    StartingKartRound = 0;
	    KartingRound = 0;
	    EndingKartRound = 1;
	}

    foreach(new i : Player)
	{
		if(IsPlayerNPC(i)) continue;
        if(!IsPlayerConnected(i)) continue;
        State = GetPlayerState(i);
        GetPlayerPos(i, x, y, z);
		GetPlayerArmour(i, pancerzyy);
        vehicleid = GetPlayerVehicleID(i);

		if(IsPlayerInGroup(i, FRAC_KT) && GetVehicleModel(vehicleid) == 578)
		{
			new idx = GetPVarInt(i, "trans");
			if(idx != 0)
			{
				if(GetPVarInt(i, "TJD_Loading") == 0)
				{
					new idx2 = (GetPVarInt(i, "trans")-1)/2;
					if(idx%2 == 1)
					{
						if(TransportJobData[idx2][eTJDStartX] == 0) idx2 = 0;
						if(!IsPlayerInRangeOfPoint(i, 20, TransportJobData[idx2][eTJDStartX], TransportJobData[idx2][eTJDStartY], TransportJobData[idx2][eTJDStartZ]))
						{
							SetPlayerCheckpoint(i, TransportJobData[idx2][eTJDStartX], TransportJobData[idx2][eTJDStartY], TransportJobData[idx2][eTJDStartZ], 5.0);
						}
					}
					else
					{
						if(!IsPlayerInRangeOfPoint(i, 20, TransportJobData[idx2][eTJDEndX], TransportJobData[idx2][eTJDEndY], TransportJobData[idx2][eTJDEndZ]))
						{
							SetPlayerCheckpoint(i, TransportJobData[idx2][eTJDEndX], TransportJobData[idx2][eTJDEndY], TransportJobData[idx2][eTJDEndZ], 5.0);
						}
					}
				}
			}
		}
		//dzwonek telefonu
		if(RingTone[i] > 0 && Mobile[i] >= 0)
		{
			if(RingTone[i] >= 60)
			{
				StopACall(i);
			}
			else
			{
				if(RingTone[i]%3 == 0)
				{
					PlayerPlaySound(i, 23000, 0.0, 0.0, 0.0);
				}
				if(RingTone[i]%12 == 0 || RingTone[i] == 1)
				{
					new caller = Mobile[i];
					new slotKontaktu = PobierzSlotKontaktuPoNumerze(i, GetPhoneNumber(caller));
					if(slotKontaktu >= 0)
					{
						format(string, sizeof(string), "Twój telefon dzwoni, (aby odebraæ wpisz: /od) dzwoni¹cy: %s (%d)", Kontakty[i][slotKontaktu][eNazwa], GetPhoneNumber(caller));
					}
					else
					{
						format(string, sizeof(string), "Twój telefon dzwoni, (aby odebraæ wpisz: /od) dzwoni¹cy: %d", GetPhoneNumber(caller));
					}
					SendClientMessage(i, COLOR_YELLOW, string);
					format(string, sizeof(string), "* Telefon %s zaczyna dzwoniæ.", GetNick(i));
					ProxDetector(30.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					PlayerPlaySound(i, 23000, 0.0, 0.0, 0.0);
				}
				RingTone[i]++;
			}
		}
		if(CellTime[i] > 0)
		{
			CellTime[i]++;
		}
		
		if(State == PLAYER_STATE_DRIVER || State == PLAYER_STATE_PASSENGER)
		{
			if(!ToggleSpeedo[i])
			{
				VehicleModel = GetVehicleModel(vehicleid);
				if(VehicleModel != 0)
				{
					GetVehicleHealth(vehicleid, health);

					if(VehicleModel==509||VehicleModel==481||VehicleModel==510)
					{
						SetVehicleHealth(vehicleid, 1000.0);
						Gas[vehicleid] = 100;
					}
					if(VehicleModel==520||VehicleModel==476||VehicleModel==593||VehicleModel==553||VehicleModel==513||VehicleModel==512||VehicleModel==577||VehicleModel==592||VehicleModel==511||VehicleModel==539||VehicleModel==464||VehicleModel==519)
					{
						Gas[vehicleid] = 100;
					}

					//GetVehicleVelocity(vehicleid, vel[0], vel[1], vel[2]);
					//Dis = VectorSize(vel[0], vel[1], vel[2]) * 166.666666;
					new pZone[MAX_ZONE_NAME];
					//new lcarid = VehicleUID[vehicleid][vUID];
					GetPlayer2DZone(i, pZone, MAX_ZONE_NAME);//Dzielnica
					//GetPlayer2DZone(i, pZone, MAX_ZONE_NAME);
					//format(string, 128,"Speed: %dkm/h~n~Paliwo: %d~n~Stan: %d\%~n~GPS: %s~n~%s" ,floatround(Dis), floatround(Gas[vehicleid]),floatround(health/10), pZone, VehicleNames[GetVehicleModel(vehicleid)-400]);
					//PlayerTextDrawSetString(i, Licznik[i], string);

					/*if(CarData[lcarid][c_OwnerType] == CAR_OWNER_GROUP || CarData[lcarid][c_GPS] == 1)
						format(string, 128, "~y~Predkosc: ~w~%d ~w~km/h ~n~~y~Stan: ~w~%d~n~~y~Paliwo: ~w~%d~n~~y~GPS: ~w~%s",floatround(Dis),floatround(health/10), floatround(Gas[vehicleid]), pZone);
					else
						format(string, 128, "~y~Predkosc: ~w~%d ~w~km/h ~n~~y~Stan: ~w~%d~n~~y~Paliwo: ~w~%d",floatround(Dis),floatround(health/10), floatround(Gas[vehicleid]));*/
					
					// TODO: v4.1
					UpdateCarInfo(i);
				}

				OldCoordsX[i] = x; OldCoordsY[i] = y;
			}
		}
        //PAYDAY
        //level = PlayerInfo[i][pLevel];
		//if(level >= 0 && level <= 2) { PlayerInfo[i][pPayCheck] += 1; }
		//else if(level >= 3 && level <= 4) { PlayerInfo[i][pPayCheck] += 2; }
		//else if(level >= 5 && level <= 6) { PlayerInfo[i][pPayCheck] += 3; }
		//else if(level >= 7 && level <= 8) { PlayerInfo[i][pPayCheck] += 4; }
		//else if(level >= 9 && level <= 10) { PlayerInfo[i][pPayCheck] += 5; }
		//else if(level >= 11 && level <= 12) { PlayerInfo[i][pPayCheck] += 6; }
		//else if(level >= 13 && level <= 14) { PlayerInfo[i][pPayCheck] += 7; }
		//else if(level >= 15 && level <= 16) { PlayerInfo[i][pPayCheck] += 8; }
		//else if(level >= 17 && level <= 18) { PlayerInfo[i][pPayCheck] += 9; }
		//else if(level >= 19 && level <= 20) { PlayerInfo[i][pPayCheck] += 10; }
		//else if(level >= 21) { PlayerInfo[i][pPayCheck] += 11; }
        //JAIL
		if(PlayerInfo[i][pJailed] > 0)
		{
			if(PlayerInfo[i][pJailTime] > 0 && WantLawyer[i] == 0 && gPlayerSpawned[i] == 1)
			{
				PlayerInfo[i][pJailTime]--;
			}
			if(PlayerInfo[i][pJailed] == 2)
			{
				new losuj= random(sizeof(SpawnStanowe));
				if(!IsPlayerInRangeOfPoint(i, 90.0, SpawnStanowe[losuj][0], SpawnStanowe[losuj][1], SpawnStanowe[losuj][2]))
				{
					SetPlayerSpawn(i); 
				}
			}
			if(PlayerInfo[i][pJailed] == 3)
			{
				if(!IsPlayerInRangeOfPoint(i, AJ_MAXRANGE, AJ_POSX, AJ_POSY, AJ_POSZ))
				{
					sendErrorMessage(i, "Nie znajdujesz siê w AJ! Pozycja przywrócona do poprawnej!");
					SetPlayerSpawn(i); 
				}
			}
			if(PlayerInfo[i][pJailTime] <= 0 && WantLawyer[i] == 0)
			{
				PlayerInfo[i][pJailTime] = 0;
				if(PlayerInfo[i][pJailed] == 1)
				{
					SetPlayerInterior(i, 0);
					SetPlayerVirtualWorld(i, 29);
					SetPlayerPos(i,1550.1117,-1643.1370,28.4881);
					if(PlayerInfo[i][pInjury] > 0) ZdejmijBW(i, 2000);
				}
				else if(PlayerInfo[i][pJailed] == 2)
				{
					//SetPlayerWorldBounds(i,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
                    //SetPlayerPos(i, NG_JAIL_X,NG_JAIL_Y,NG_JAIL_Z);
					UnJailDeMorgan(i);
				}
				else if(PlayerInfo[i][pJailed] == 3)
				{
					//SetPlayerInterior(i, 0);
					PlayerInfo[i][pJailed] = 0;
					PlayerInfo[i][pJailTime] = 0;
					//SetPlayerVirtualWorld(i, 0);
					PlayerInfo[i][pMuted] = 0;
					//SetPlayerPos(i,1481.1666259766,-1790.2204589844,156.7875213623);
					SetPlayerSpawn(i);
					format(string, sizeof(string), "~w~Wolnosc~n~~r~GRAJ RP!!!");
					GameTextForPlayer(i, string, 5000, 1);
					SetPVarInt(i, "skip_bw", 1);
					SetPlayerHealth(i, 0.0);
					PlayerPlaySound(i, 39000, 0.0, 0.0, 0.0);
					StopAudioStreamForPlayer(i);
					if((GetPVarInt(i, "DostalDM2") == 1) || strfind((PlayerInfo[i][pAJreason]), "DM2", true) > 0
					&& strfind((PlayerInfo[i][pAJreason]), "Death Match 2", true) > 0)
					{
						format(string, sizeof(string), "[Marcepan Marks] Zabra³em graczowi %s broñ [Odsiedzia³ karê za DM2]", GetNick(i));
						SendAdminMessage(COLOR_PANICRED, string);
						format(string, sizeof(string), "%s zabra³em twoj¹ broñ. Z pozdrowieniami - Marcepan Marks", GetNick(i));
						sendTipMessage(i, string);
						SetTimerEx("AntySB", 5000, 0, "d", i);
						AntySpawnBroni[i] = 5;
						ResetPlayerWeapons(i);
						UsunBron(i);
					}
				}
				PlayerInfo[i][pJailed] = 0;
				SendClientMessage(i, COLOR_GRAD1,"   Wolnoœæ! Odsiedzia³eœ karê, mamy nadzieje ¿e to ciê czegoœ nauczy³o.");
				format(string, sizeof(string), "~g~Wolnosc!~n~~w~Staraj sie byc lepszym obywatelem");
				GameTextForPlayer(i, string, 5000, 1);
				if(gTeam[i] == 4) { gTeam[i] = 3; }
				ClearCrime(i);
				SetPlayerToTeamColor(i);
				StopAudioStreamForPlayer(i);
			}
		}
        //AUDIO
		if(GetPVarInt(i, "sanaudio") == 0 && SANradio != 0)
		{
			if(IsPlayerInRangeOfPoint(i,SANzasieg,SANx, SANy, SANz))
			{
				SetPVarInt(i, "sanaudio", 1);
				PlayAudioStreamForPlayer(i, SANrepertuar, SANx, SANy, SANz, SANzasieg, 1);
			}
		}
		else if(GetPVarInt(i, "kluboweaudio") == 0 && KLUBOWEradio != 0 && !GetPVarInt(i, "HaveAMp3Stream"))
		{
			if(IsPlayerInRangeOfPoint(i,KLUBOWEzasieg,KLUBOWEx, KLUBOWEy, KLUBOWEz))
			{
				SetPVarInt(i, "kluboweaudio", 1);
				PlayAudioStreamForPlayer(i, KLUBOWErepertuar, KLUBOWEx, KLUBOWEy, KLUBOWEz, KLUBOWEzasieg, 1);
			}
		}
		else if(GetPVarInt(i, "sanaudio") == 1 && SANradio != 0)
		{
			if(!IsPlayerInRangeOfPoint(i,SANzasieg,SANx, SANy, SANz))
			{
				SetPVarInt(i, "sanaudio", 0);
				StopAudioStreamForPlayer(i);
			}
		}
		if(State == PLAYER_STATE_DRIVER)
		{
			if(IsPlayerInRangeOfPoint(i, 7.0, 2064.0703,-1831.3167,13.3853) || IsPlayerInRangeOfPoint(i, 5.0, 1351.0012,-1818.5981,13.3031) || IsPlayerInRangeOfPoint(i, 7.0, 1024.8514,-1022.2302,31.9395) || IsPlayerInRangeOfPoint(i, 7.0, 486.9398,-1742.4130,10.9594) || IsPlayerInRangeOfPoint(i, 7.0, -1904.2325,285.3743,40.8843)  || IsPlayerInRangeOfPoint(i, 7.0, 720.0876,-458.3574,16.3359) || IsPlayerInRangeOfPoint(i, 7.0, -2425.9668,1023.2122,50.1248) || IsPlayerInRangeOfPoint(i, 7.0, 1972.6704,2163.9829,10.7942) || IsPlayerInRangeOfPoint(i, 7.0, -100.3769,1115.7079,19.4688) || IsPlayerInRangeOfPoint(i, 7.0, -1420.5669,2584.1997,55.5703))
			{
				if(naprawiony[i] == 0)
				{
					GetVehicleHealth(vehicleid, health);
					if(health <= 999)
					{
						if(IsACopCar(GetPlayerVehicleID(i)) && OnDuty[i] > 0)
						{
							sendTipMessage(i, "Zap³aci³eœ $0 za wizytê w warsztacie pojazdem s³u¿bowym");
						}
						else
						{
							sendTipMessageFormat(i, "Zap³aci³eœ $%d za wizytê w warsztacie", PRICE_PAYNSPRAY);
							ZabierzKaseDone(i, PRICE_PAYNSPRAY);
						}
						RepairVehicle(vehicleid);
						naprawiony[i] = 1;
						SetTimerEx("Naprawianie",10000,0,"d",i);
					}
				}
			}
		}
		if(Kajdanki_JestemSkuty[i] == 1)
		{
			cop = Kajdanki_PDkuje[i];
			if(IsPlayerConnected(cop))
			{
				if(IsAPolicja(cop) || IsABOR(cop))
				{
					if(GetPlayerState(cop) == 1)
					{
						if(!ProxDetectorS(3.5, cop, i))
						{
							SetPlayerVirtualWorld(i, GetPlayerVirtualWorld(cop));
							SetPlayerInterior(i, GetPlayerInterior(cop));
							GetPlayerPos(cop, x, y, z);
							SetPlayerPos(i, x-0.5, y-0.5, z);
							SetPlayerSpecialAction(i, SPECIAL_ACTION_CUFFED);
							TogglePlayerControllable(i, 0);
							if(PlayerInfo[i][pBW] == 0) SetTimerEx("FreezePlayer", 2000, false, "i", i);
						}
					}
					else
					{
						new veh = GetPlayerVehicleID(cop);
                        new veh_zakuty = GetPlayerVehicleID(i);
                        if(veh != veh_zakuty) 
                        {
                            new seat = GetFreeVehicleSeatForArrestant(veh);
                            if(seat != -1)
                            {
                                PutPlayerInVehicleEx(i, veh, seat);
                                TogglePlayerControllable(i, 0);
                            }
                        }
					}
				}
			}
		}


        if(SafeTime[i] > 0)//3minuty na zalogowanie
		{
			SafeTime[i]--;
			if(SafeTime[i] == 1)
			{
				if(gPlayerAccount[i] == 1 && gPlayerLogged[i] == 0)
				{
					if(!IsPlayerNPC(i))
					{
						KickEx(i);
					}
				}
			}
		}
		if((taxidriver = TransportDriver[i]) != 999) //Taxi
		{
            TransportDist[i]+=(VectorSize(SavePlayerPos[i][LastX] - x, SavePlayerPos[i][LastY] - y, SavePlayerPos[i][LastZ]-z)/1000)*3;
            format(string, 128, "%.1fKM", TransportDist[i]);
            PlayerTextDrawSetString(i, TAXI_DIST[i], string);
            PlayerTextDrawSetString(taxidriver, TAXI_DIST[taxidriver], string);

            PlayerTextDrawShow(i, TAXI_DIST[i]);
            PlayerTextDrawShow(taxidriver, TAXI_DIST[taxidriver]);

            format(string, 128, "$%d", floatround((TransportDist[i]*TransportValue[taxidriver])+TransportValue[taxidriver]));
            PlayerTextDrawSetString(i, TAXI_COST[i], string);
            PlayerTextDrawSetString(taxidriver, TAXI_COST[taxidriver], string);

            PlayerTextDrawShow(i, TAXI_COST[i]);
            PlayerTextDrawShow(taxidriver, TAXI_COST[taxidriver]);
		}
		if(PoziomPoszukiwania[i] >= 1)
		{
		    PlayerInfo[i][pWL] = PoziomPoszukiwania[i];
		}
		if(PlayerInfo[i][pJailed] == 1 || PlayerInfo[i][pJailed] == 2)
		{
		    if(PoziomPoszukiwania[i] >= 1)
		    {
		    	PoziomPoszukiwania[i] = 0;
		    	PlayerInfo[i][pWL] = 0;
		    }
		}
        SavePlayerPos[i][LastX] = x;
        SavePlayerPos[i][LastY] = y;
        SavePlayerPos[i][LastZ] = z;
		if(GetPlayerWeapon(i) != 0 && PlayerInfo[i][pWeaponBlock] > gettime())
		{
			new sec = PlayerInfo[i][pWeaponBlock]-gettime();
			SetPlayerArmedWeapon(i, 0);
			MruDialog(i, "Blokada broni", sprintf("Posiadasz aktywn¹ blokadê broni, nie mo¿esz korzystaæ z niej przez %d minut.", floatround(sec / 60 % 60)));
		}

		// serce zapisu broni
		if(State >= 1 && State <= 6)
		{
			if(GetPVarInt(i, "ammohackdetect") == 1) KickEx(i);
			if(MaZapisanaBron(i))//if(PlayerInfo[i][pGun2] >= 2) - dziwne, ¿e wczeœniej nikt tego b³êdu nie zauwa¿y³.
			{
                weaponID = GetPlayerWeapon(i);
                ammo = GetPlayerAmmo(i);
                weaponState = GetPlayerWeaponState(i);
				if(weaponID == PlayerInfo[i][pGun2] && PlayerInfo[i][pGun2] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo2] >= 0)
					{
						if(PlayerInfo[i][pAmmo2] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo2] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun3] && PlayerInfo[i][pGun3] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo3] >= 0)
					{

						if(PlayerInfo[i][pAmmo3] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo3] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun4] && PlayerInfo[i][pGun4] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo4] >= 0)
					{

						if(PlayerInfo[i][pAmmo4] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo4] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun5] && PlayerInfo[i][pGun5] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo5] >= 0)
					{

						if(PlayerInfo[i][pAmmo5] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo5] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun6] && PlayerInfo[i][pGun6] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo6] >= 0)
					{

						if(PlayerInfo[i][pAmmo6] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo6] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun7] && PlayerInfo[i][pGun7] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo7] >= 0)
					{

						if(PlayerInfo[i][pAmmo7] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo7] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun8] && PlayerInfo[i][pGun8] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo8] >= 0)
					{

						if(PlayerInfo[i][pAmmo8] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo8] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun9] && PlayerInfo[i][pGun9] >= 2)
				{
					if(weaponState >= 1 && PlayerInfo[i][pAmmo9] >= 0)
					{

						if(PlayerInfo[i][pAmmo9] != ammo && ammo >= 1)
						{
							PlayerInfo[i][pAmmo9] = ammo;
						}
					}
				}
				else if(weaponID == PlayerInfo[i][pGun11] && PlayerInfo[i][pGun11] == 46)
				{
					if(weaponState == 0 && PlayerInfo[i][pAmmo11] <= 0)
					{
						if(weaponState == 0 && weaponID == PlayerInfo[i][pGun11])
						{
							PlayerInfo[i][pGun11] = 0;
							PlayerInfo[i][pAmmo11] = 0;
						}
					}
				}
			}
		}


        if(UsedFind[i] >= 1)
		{
			UsedFind[i] += 1;
			if(UsedFind[i] >= 120)
			{
				UsedFind[i] = 0;
			}
		}
        if(GetPVarInt(i, "wysekszony") > 0) {
            SetPVarInt(i, "wysekszony", GetPVarInt(i, "wysekszony")-1);
        }
        if(GetPVarInt(i, "wytazerowany") > 0) {
            SetPVarInt(i, "wytazerowany", GetPVarInt(i, "wytazerowany")-1);
        }
        if(GetPVarInt(i, "wydragowany") > 0) {
            SetPVarInt(i, "wydragowany", GetPVarInt(i, "wydragowany")-1);
        }
        if(GetPVarInt(i, "wyreportowany") > 0) {
            SetPVarInt(i, "wyreportowany", GetPVarInt(i, "wyreportowany")-1);
        }
        if(GetPVarInt(i, "finding") == 1) {
            new findtime = GetPVarInt(i, "findtime");
            if(findtime == 0) {
                SetPVarInt(i, "finding", 0);
                SetPVarInt(i, "findtime", 0);
                SetPVarInt(i, "findingId", 999);
                SetPVarInt(i, "findingRange", 0);
                GangZoneDestroy(pFindZone[i]);
                GameTextForPlayer(i, "~r~Strefa Ulegla Destrukcji", 2500, 1);
            } else { 
                new kogo = GetPVarInt(i, "findingId");
                new range = GetPVarInt(i, "findingRange");
                new Float:X,Float:Y,Float:Z;
                GetPlayerPos(kogo, X,Y,Z);
                if(pFindZone[i]) GangZoneDestroy(pFindZone[i]);
                pFindZone[i] = GangZoneCreate(X-range, Y-range, X+range, Y+range);
                GangZoneShowForPlayer(i, pFindZone[i], 0xff00eeBB);
                SetPVarInt(i, "findtime", findtime-1);
            }
        }
		if(GetPVarInt(i, "reset-dutytime") < gettime() && PlayerInfo[i][pDutyTime] > 0 && OnDuty[i] < 1 && !JobDuty[i])
		{
			PlayerInfo[i][pDutyTime] = 0;
			DeletePVar(i, "reset-dutytime");
			DeletePVar(i, "duty-act");
		}
		if(MedicTime[i] > 0)
		{
			if(MedicTime[i] == 3)
			{
				SetPlayerInterior(i, 5);
				//GetPlayerPos(i, x,y,z);
				//SetPlayerCameraPos(i, x + 3, y, z);
				//SetPlayerCameraLookAt(i,x,y,z);
			}
			MedicTime[i] ++;
			if(MedicTime[i] >= NeedMedicTime[i])
			{
				format(string, sizeof(string), "DOKTOR: %d zosta³eœ uleczony.", i);
				SendClientMessage(i, TEAM_CYAN_COLOR, string);
				TogglePlayerControllable(i, 1);
				MedicBill[i] = 0;
				MedicTime[i] = 0;
				NeedMedicTime[i] = 0;
				PlayerInfo[i][pDeaths] += 1;
				PlayerFixRadio(i);
				SetPlayerSpawn(i);
			}
		}
		if(WantLawyer[i] >= 1)
		{
			CallLawyer[i] = 111;
			if(WantLawyer[i] == 1)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "Potrzebujesz prawnika? (Wpisz tak lub nie)");
			}
			WantLawyer[i] ++;
			if(WantLawyer[i] == 8)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "Potrzebujesz prawnika? (Wpisz tak lub nie)");
			}
			if(WantLawyer[i] == 15)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "Potrzebujesz prawnika? (Wpisz tak lub nie)");
			}
			if(WantLawyer[i] >= 20)
			{
				SendClientMessage(i, COLOR_LIGHTRED, "Nie mo¿esz ju¿ wezwaæ prawnika, Czas odsiadki rozpoczêty.");
				WantLawyer[i] = 0;
				CallLawyer[i] = 0;
			}
		}
		if(TutTime[i] >= 1 && !IsPlayerNPC(i))
		{
			GetPlayerVelocity(i, x, y, z);
			if( x > 0.1 || y > 0.1)
			{
				SendClientMessage(i, COLOR_LIGHTBLUE, "AC: Kick za ucieczkê z samouczka!");
				KickEx(i);
			}
			TutTime[i] += 1;
			if(TutTime[i] == 3)
			{
				SetPlayerPos(i, 849.62371826172, -989.92199707031, -5.0);
				SetPlayerCameraPos(i, 849.62371826172, -989.92199707031, 53.211112976074);// kamera
				SetPlayerCameraLookAt(i, 907.40313720703, -913.14117431641, 77.788856506348);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: Wstêp ____|");
				SendClientMessage(i, COLOR_WHITE, "Witaj na serwerze Kotnik-RP! Zosta³eœ tutaj odes³any w celu przedstawienia informacji na temat gry!");
				SendClientMessage(i, COLOR_WHITE, "Znajdujesz siê na serwerze typu Role Play, inaczej odzwierciedlanie realnego ¿ycia w grze.");
				SendClientMessage(i, COLOR_WHITE, "Zapozna³eœ siê ze znaczeniem s³owa Role Play musisz poznaæ zasady panuj¹ce na naszym serwerze.");
				SendClientMessage(i, COLOR_WHITE, "W tym celu przejdziesz drobny samouczek tekstowy, który w pe³ni przygotuje Ciê do rozgrywki!"); 
			}
			else if(TutTime[i] == 14)
			{
				SetPlayerPos(i, 326.09194946289, -1521.3157958984, 20.0);
				SetPlayerCameraPos(i, 398.16021728516, -1511.9237060547, 78.641815185547);// kamera
				SetPlayerCameraLookAt(i, 326.09194946289, -1521.3157958984, 42.154850006104);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady serwera - DeathMatch(DM) oraz Nick ____|");
			}
			else if(TutTime[i] == 16)
			{
				SendClientMessage(i, COLOR_WHITE, "Na tym serwerze obowi¹zuje absolutny zakaz jakiegokolwiek DeathMatch`u(DM).");
				SendClientMessage(i, COLOR_WHITE, "Jeœli zdecydujesz siê kogoœ zabiæ, musisz mieæ naprawdê wa¿ny do tego powód.");
				SendClientMessage(i, COLOR_WHITE, "Na serwerze nie chcemy trzymaæ osób, które bezmyœlnie zabijaj¹, jest to nie wporz¹dku.");
				SendClientMessage(i, COLOR_WHITE, "Na serwerze obowi¹zkowo trzeba mieæ nick typu Imie_Nazwisko (np. Jan_Kowalski), jeœli masz inny poproœ admina o zmianê go.");
			}
			else if(TutTime[i] == 30)
			{
				SetPlayerPos(i, 1016.9872436523, -1372.0234375, -5.0);
				SetPlayerCameraPos(i, 1053.3154296875, -1326.3295898438, 28.300031661987);// kamera
				SetPlayerCameraLookAt(i, 1016.9872436523, -1372.0234375, 15.836219787598);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady serwera - Bug Using oraz Cheatowanie ____|");
			}
			else if(TutTime[i] == 32)
			{
				SendClientMessage(i, COLOR_WHITE, "Je¿eli widzisz, ¿e ktoœ ³amie regulamin, powiadom o tym dostêpnych administratorów przez komendê /report.");
				SendClientMessage(i, COLOR_WHITE, "Na serwerze pod ¿adnym pozorem nie wolno u¿ywaæ Bugów, nale¿y natychmiast zg³aszaæ je do administracji. ");
				SendClientMessage(i, COLOR_WHITE, "Na serwerze zakazuje siê u¿ywania jakichkolwiek wspomagaczy(cheatów), które u³atwiaj¹ tobie rozgrywke.");
				SendClientMessage(i, COLOR_WHITE, "Osoba korzystaj¹ca z Cheatów i Bugów mo¿e zostaæ ostrze¿ona, b¹dŸ zbanowana.");
			}
			else if(TutTime[i] == 52)
			{
				SetPlayerPos(i, 1352.2797851563, -1757.189453125, -5.0);
				SetPlayerCameraPos(i, 1352.4576416016, -1725.1925048828, 23.291763305664);// kamera
				SetPlayerCameraLookAt(i, 1352.2797851563, -1757.189453125, 13.5078125);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady Serwera - OOC (Out Of Character) ____|");
			}
			else if(TutTime[i] == 54)
			{
				SendClientMessage(i, COLOR_WHITE, "Aby zacz¹æ rozgrywke na serwerze, musisz poznaæ zasadê OOC");
				SendClientMessage(i, COLOR_WHITE, "Wszystko co tutaj znajdziesz jest bardzo wa¿ne, wiêc czytaj uwa¿nie i to zapamiêtaj.");
				SendClientMessage(i, COLOR_WHITE, "OOC to wszystko co dotyczy realnego œwiata, zakazuje siê przenoszenia tych informacji do gry, podczas odgrywania postaci.");
				SendClientMessage(i, COLOR_WHITE, "Na serwerze Chat OOC znajduje siê pod komend¹ /b.");
				SendClientMessage(i, COLOR_WHITE, "Je¿eli czegoœ nie rozumiesz b¹dŸ nie wiesz odnoœnie rozgrywki, mo¿esz zapytaæ o to innych graczy na chacie OOC.");
				SendClientMessage(i, COLOR_WHITE, "Poprawnie napisany przyk³adowy tekst na chacie OOC wygl¹da tak: /b Mo¿esz mi pomóc z rozgrywk¹? Nie rozumiem jak to zrobiæ.");
			}
			else if(TutTime[i] == 74)
			{
				SetPlayerPos(i, 370.02825927734, -2083.5886230469, -10.0);
				SetPlayerCameraPos(i, 340.61755371094, -2091.701171875, 22.800081253052);// kamera
				SetPlayerCameraLookAt(i, 370.02825927734, -2083.5886230469, 8.1386299133301);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady serwera - IC (In Character) ____|");
			}
			else if(TutTime[i] == 76)
			{
				SendClientMessage(i, COLOR_WHITE, "Aby zacz¹æ rozgrywke na serwerze, musisz wiedzieæ co to jest IC, oraz poprawnie to interpretowaæ.");
				SendClientMessage(i, COLOR_WHITE, "IC to przeciwieñstwo OOC, inaczej rzeczy zwi¹zane z uniwersum gry.");
				SendClientMessage(i, COLOR_WHITE, "Na tym chacie wczuwamy siê w nasz¹ odgrywan¹ postaæ. - Piszemy jedynie rzeczy z ni¹ zwi¹zane."); 
				SendClientMessage(i, COLOR_WHITE, "Na serwerze, na chacie IC mo¿esz rozmawiaæ w ró¿ne sposoby: /l (Chat Lokalny), /s (Szept) /k (Krzyk).");
				SendClientMessage(i, COLOR_WHITE, "Poprawnie napisany przyk³adowy tekst na chacie IC wygl¹da tak: /l Witam serdecznie, jestem zainteresowany pana ofert¹ pracy.");
			}
			else if(TutTime[i] == 96)
			{
				SetPlayerPos(i, 1172.8602294922, -1331.978515625, -5.0);
				SetPlayerCameraPos(i, 1228.7977294922, -1345.1479492188, 21.532119750977);// kamera
				SetPlayerCameraLookAt(i, 1172.8602294922, -1331.978515625, 14.317019462585);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: zasady serwera - MG (Meta Gaming) oraz PG (Power Gaming) ____|");
			}
			else if(TutTime[i] == 98)
			{
				SendClientMessage(i, COLOR_WHITE, "MG to inaczej wykorzystywanie informacji OOC do gry IC");
				SendClientMessage(i, COLOR_WHITE, "Przyk³adowo widzisz nick z nad g³owy gracza OOC, nastepnie wykorzystujesz to do gry IC i odnosisz siê do niego po imieniu.");
				SendClientMessage(i, COLOR_WHITE, "Inna sytuacja, ktoœ mówi na chacie OOC, ¿e jest liderem LSPD, po czym pytasz go IC o pracê w LSPD, jest to MG inaczej Meta Gaming.");
				SendClientMessage(i, COLOR_WHITE, "PG to inaczej przymuszanie do odegrania czynnoœci bez mo¿liwoœci reakcji");
				SendClientMessage(i, COLOR_WHITE, "Podchodzisz do gracza, nastêpnie odgrywasz /me zabija Johna, to jest PG inaczej Power Gaming.");
			}
			else if(TutTime[i] == 112)
			{
				SetPlayerPos(i, 412.80743408203, -1312.4066162109, -5.0);
				SetPlayerCameraPos(i, 402.2776184082, -1351.4703369141, 43.704566955566);// kamera
				SetPlayerCameraLookAt(i, 412.80743408203, -1312.4066162109, 39.677307128906);// patrz
				SendClientMessage(i, COLOR_PURPLE, "|____ Tutorial: Zakoñczenie ____|");
			}
			else if(TutTime[i] == 114)
			{
				SendClientMessage(i, COLOR_WHITE, "Wszystkich powy¿szych wymienionych zasad powinieneœ siê trzymaæ.");
				SendClientMessage(i, COLOR_WHITE, "Zapewne masz jeszcze sporo pytañ dotycz¹cych gry. Spokojnie, znajdziesz na nie odpowiedŸ!");
				SendClientMessage(i, COLOR_WHITE, "Mo¿esz œmia³o pytaæ administratora (/admins), poprzez zapytania (/zapytaj), b¹dŸ te¿ poprzez chat dla nowych graczy /newbie. To ju¿ koniec tekstowego samouczka. ");
				SendClientMessage(i, COLOR_WHITE, "Zasad, poradników i pomocy jest znacznie wiêcej na naszym forum! OdwiedŸ je: https://kotnik-rp.pl");
			}
			else if(TutTime[i] == 124)
			{
				SetPVarInt(i, "AntyCheatOff", 1);

				TogglePlayerSpectating(i, false);
				SpawnPlayer(i);
				
				SetPlayerPos(i, 208.3876,-34.8742,1001.9297);
				SetPlayerFacingAngle(i, 138.8926);

				SetPlayerCameraPos(i, 206.288314, -38.114028, 1002.229675);
				SetPlayerCameraLookAt(i, 208.775955, -34.981678, 1001.929687);
			}
			else if(TutTime[i] == 125)
			{
				TutTime[i] = 0; PlayerInfo[i][pTut] = 1;
				gOoc[i] = 0; gNews[i] = 0; gFam[i] = 0;
				MedicBill[i] = 0;
				PlayerInfo[i][pMuted] = 0;
				
				SendClientMessage(i, COLOR_NEWS, "Witamy Ciê serdecznie, pierwszy raz na serwerze.");
				SetPlayerSkinEx(i, PlayerInfo[i][pSkin]);
				SetPlayerSpawn(i);
				SetPlayerSpawnPos(i);
				SetPlayerInterior(i, 0);
				SetPlayerVirtualWorld(i, 0);
				format(string, sizeof(string), "Czy chcesz skorzystaæ z pomocy administracji w celu lepszego zapoznania siê z serwerem?");
				ShowPlayerDialogEx(i, NOWY_GRACZ, DIALOG_STYLE_MSGBOX, "Witamy na Kotnik-RP", string, "Tak", "Nie");
			}
		}
		if(PlayerTazeTime[i] >= 1)
		{
			PlayerTazeTime[i] += 1;
			if(PlayerTazeTime[i] == 15)
			{
				PlayerTazeTime[i] = 0;
			}
			else
			{
				GetPlayerFacingAngle(i, angle);
				SetPlayerFacingAngle(i, angle + 90);
			}
		}
		if(PlayerDrunk[i] >= 5)
		{
			PlayerDrunkTime[i] += 1;
			if(PlayerDrunkTime[i] == 8)
			{
				PlayerDrunkTime[i] = 0;
				GetPlayerFacingAngle(i, angle);
				if(IsPlayerInAnyVehicle(i))
				{
					if(GetPlayerState(i) == 2)
					{
						GetPlayerName(i, plname, sizeof(plname));
						format(string, sizeof(string), "%s Krzyczy: AAAAAhHahahahhaaa!!", plname);
						ProxDetector(30.0, i, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
					}
				}
				else
				{
					SetPlayerSpecialAction(i, SPECIAL_ACTION_DRINK_BEER);
					ApplyAnimation(i,"PED", "WALK_DRUNK",4.0,0,1,0,0,0);
				}
			}
		}
		if(PlayerStoned[i] >= 2)
		{
			PlayerStoned[i] += 1;
			if(PlayerStoned[i] == 20)
			{
				if(PlayerStonedStop[i] >= 600)
				{
					PlayerStoned[i] = 1;
					PlayerStonedStop[i] = 0;
				}
				else
				{
					PlayerStoned[i] = 2;
					PlayerStonedStop[i] ++;
				}
				SetPlayerDrunkLevel(i, GetPlayerDrunkLevel(i)+2000);
				SetPlayerSpecialAction(i, SPECIAL_ACTION_SMOKE_CIGGY);
			}
		}
		if(PlayerInfo[i][pCarTime] > 0)
		{
			if(PlayerInfo[i][pCarTime] <= 0)
			{
				PlayerInfo[i][pCarTime] = 0;
			}
			else
			{
				PlayerInfo[i][pCarTime] -= 1;
			}
		}
		if(BoxWaitTime[i] > 0)
		{
			if(BoxWaitTime[i] >= BoxDelay)
			{
				BoxDelay = 0;
				BoxWaitTime[i] = 0;
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				GameTextForPlayer(i, "~g~Walka rozpoczeta", 5000, 1);
				TogglePlayerControllable(i, 1);
				RoundStarted = 1;
			}
			else
			{
				format(string, sizeof(string), "%d", BoxDelay - BoxWaitTime[i]);
				GameTextForPlayer(i, string, 1500, 6);
				BoxWaitTime[i] += 1;
			}
		}
		if(RoundStarted > 0)
		{
			if(PlayerBoxing[i] > 0)
			{
				GetPlayerHealth(i, health);
				if(health < 12)
				{
					if(i == Boxer1) { Lost = 1; trigger = 1; }
					else if(i == Boxer2) { Lost = 2; trigger = 1; }
				}
				if(health < 28) { GetPlayerFacingAngle(i, angle); SetPlayerFacingAngle(i, angle + 85); }
				if(trigger)
				{
					if(Lost == 1)
					{
						if(IsPlayerConnected(Boxer1) && IsPlayerConnected(Boxer2))
						{
							SetPlayerPos(Boxer1, 765.8433,3.2924,1000.7186); SetPlayerPos(Boxer2, 765.8433,3.2924,1000.7186);
							SetPlayerInterior(Boxer1, 5); SetPlayerInterior(Boxer2, 5);
							GetPlayerName(Boxer1, loser, sizeof(loser));
							GetPlayerName(Boxer2, winner, sizeof(winner));
							if(PlayerInfo[Boxer1][pJob] == 12) { PlayerInfo[Boxer1][pLoses] += 1; }
							if(PlayerInfo[Boxer2][pJob] == 12) { PlayerInfo[Boxer2][pWins] += 1; }
							if(TBoxer < 255)
							{
								if(IsPlayerConnected(TBoxer))
								{
									if(TBoxer != Boxer2)
									{
										if(PlayerInfo[Boxer2][pJob] == 12)
										{
											TBoxer = Boxer2;
											GetPlayerName(TBoxer, titel, sizeof(titel));
											format(plname, sizeof(plname), "%s", titel);
											strmid(Titel[TitelName], plname, 0, strlen(plname), 255);
											Titel[TitelWins] = PlayerInfo[TBoxer][pWins];
											Titel[TitelLoses] = PlayerInfo[TBoxer][pLoses];
											SaveBoxer();
											format(string, sizeof(string), "Boks News: %s wygra³ walkê z Mistrzem %s i teraz to ON jest Mistrzem Boksu.",  titel, loser);
											OOCOff(COLOR_WHITE,string);
										}
										else
										{
											SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* zosta³byœ mistrzem bokserskim gdybyœ mia³ pracê boxera !");
										}
									}
									else
									{
										GetPlayerName(TBoxer, titel, sizeof(titel));
										format(string, sizeof(string), "Boks News: Mistrz boksu %s wygra³ walkê z %s.",  titel, loser);
										OOCOff(COLOR_WHITE,string);
										Titel[TitelWins] = PlayerInfo[TBoxer][pWins];
										Titel[TitelLoses] = PlayerInfo[Boxer2][pLoses];
										SaveBoxer();
									}
								}
							}//TBoxer
							format(string, sizeof(string), "* Przegra³eœ walkê z %s.", winner);
							SendClientMessage(Boxer1, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(Boxer1, "~r~you lost", 3500, 1);
							format(string, sizeof(string), "* Wygra³eœ walkê z %s.", loser);
							SendClientMessage(Boxer2, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(Boxer2, "~r~Wygrales", 3500, 1);
							if(GetPlayerHealth(Boxer1, health) < 20)
							{
								SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* Czujesz siê wyczerpany, idŸ coœ zjeœæ.");
								SetPlayerHealth(Boxer1, 30.0);
							}
							else
							{
								SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* Czujesz siê wspaniale, pomimo odbytego pojedynku.");
								SetPlayerHealth(Boxer1, 50.0);
							}
							if(GetPlayerHealth(Boxer2, health) < 10)
							{
								SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* Czujesz siê wykoñczony, idŸ coœ zjeœæ.");
								SetPlayerHealth(Boxer2, 30.0);
							}
							else
							{
								SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* Czujesz siê wspaniale, pomimo odbytego pojedynku.");
								SetPlayerHealth(Boxer2, 50.0);
							}
							GameTextForPlayer(Boxer1, "~g~Walka skonczona", 5000, 1); GameTextForPlayer(Boxer2, "~g~Walka skonczona", 5000, 1);
							if(PlayerInfo[Boxer2][pJob] == 12) { PlayerInfo[Boxer2][pBoxSkill] += 1; }
							PlayerBoxing[Boxer1] = 0;
							PlayerBoxing[Boxer2] = 0;
						}
					}
					else if(Lost == 2)
					{
						if(IsPlayerConnected(Boxer1) && IsPlayerConnected(Boxer2))
						{
							SetPlayerPos(Boxer1, 765.8433,3.2924,1000.7186); SetPlayerPos(Boxer2, 765.8433,3.2924,1000.7186);
							SetPlayerInterior(Boxer1, 5); SetPlayerInterior(Boxer2, 5);
							GetPlayerName(Boxer1, winner, sizeof(winner));
							GetPlayerName(Boxer2, loser, sizeof(loser));
							if(PlayerInfo[Boxer2][pJob] == 12) { PlayerInfo[Boxer2][pLoses] += 1; }
							if(PlayerInfo[Boxer1][pJob] == 12) { PlayerInfo[Boxer1][pWins] += 1; }
							if(TBoxer < 255)
							{
								if(IsPlayerConnected(TBoxer))
								{
									if(TBoxer != Boxer1)
									{
										if(PlayerInfo[Boxer1][pJob] == 12)
										{
											TBoxer = Boxer1;
											GetPlayerName(TBoxer, titel, sizeof(titel));
											format(plname, sizeof(plname), "%s", titel);
											strmid(Titel[TitelName], plname, 0, strlen(plname), 255);
											Titel[TitelWins] = PlayerInfo[TBoxer][pWins];
											Titel[TitelLoses] = PlayerInfo[TBoxer][pLoses];
											SaveBoxer();
											format(string, sizeof(string), "Boks News: %s wygra³ walkê z Mistrzem %s i teraz to ON jest Mistrzem Boksu.",  titel, loser);
											OOCOff(COLOR_WHITE,string);
										}
										else
										{
											SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* zosta³byœ mistrzem bokserskim gdybyœ mia³ pracê boxera !");
										}
									}
									else
									{
										GetPlayerName(TBoxer, titel, sizeof(titel));
										format(string, sizeof(string), "Boks News: Mistrz boksu %s wygra³ walkê z %s.",  titel, loser);
										OOCOff(COLOR_WHITE,string);
										Titel[TitelWins] = PlayerInfo[TBoxer][pWins];
										Titel[TitelLoses] = PlayerInfo[Boxer1][pLoses];
										SaveBoxer();
									}
								}
							}//TBoxer
							format(string, sizeof(string), "* Przegra³eœ walkê z %s.", winner);
							SendClientMessage(Boxer2, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(Boxer2, "~r~Przegrana", 3500, 1);
							format(string, sizeof(string), "* Wygra³eœ walkê z %s.", loser);
							SendClientMessage(Boxer1, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(Boxer1, "~g~Wygrana", 3500, 1);
							if(GetPlayerHealth(Boxer1, health) < 20)
							{
								SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* Czujesz siê wyczerpany, idŸ coœ zjeœæ.");
								SetPlayerHealth(Boxer1, 30.0);
							}
							else
							{
								SendClientMessage(Boxer1, COLOR_LIGHTBLUE, "* Czujesz siê wspaniale, pomimo odbytego pojedynku.");
								SetPlayerHealth(Boxer1, 50.0);
							}
							if(GetPlayerHealth(Boxer2, health) < 20)
							{
								SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* Czujesz siê wyczerpany, idŸ coœ zjeœæ.");
								SetPlayerHealth(Boxer2, 30.0);
							}
							else
							{
								SendClientMessage(Boxer2, COLOR_LIGHTBLUE, "* Czujesz siê wspaniale, pomimo odbytego pojedynku.");
								SetPlayerHealth(Boxer2, 50.0);
							}
							GameTextForPlayer(Boxer1, "~g~Koniec walki", 5000, 1); GameTextForPlayer(Boxer2, "~g~Koniec walki", 5000, 1);
							if(PlayerInfo[Boxer1][pJob] == 12) { PlayerInfo[Boxer1][pBoxSkill] += 1; }
							PlayerBoxing[Boxer1] = 0;
							PlayerBoxing[Boxer2] = 0;
						}
					}
					InRing = 0;
					RoundStarted = 0;
					Boxer1 = 255;
					Boxer2 = 255;
					TBoxer = 255;
					trigger = 0;
				}
			}
		}
		if(CzasInformacyjnego[i] > 0)
        {
            CzasInformacyjnego[i]--;
            if(CzasInformacyjnego[i] == 0)
            {
                PlayerTextDrawHide(i, TextInformacyjny[i]);
            }
        }
		if(StartingPaintballRound == 1 && AnnouncedPaintballRound == 0)
		{
			AnnouncedPaintballRound = 1;
			if(PlayerPaintballing[i] != 0)
			{
				SendClientMessage(i, COLOR_YELLOW, "Mecz Pintball`u rozpocznie siê za 15 sekund (Aby do³¹czy³o wiêcej uczestników).");
			}
		}
		if(StartingKartRound == 1 && AnnouncedKartRound == 0)
		{
			AnnouncedKartRound = 1;
			if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
			{
				SendClientMessage(i, COLOR_YELLOW, "Wyœcig gokartów rozpocznie siê za 15 sekund (Aby do³¹czy³o wiêcej uczestników).");
			}
		}
		if(EndingKartRound == 1)
		{
			if(PlayerKarting[i] != 0 && PlayerInKart[i] != 0)
			{
				DisablePlayerCheckpoint(i);
				CP[i] = 0;
			}
		}
		if(FindTime[i] > 0)
		{
			if(FindTime[i] == FindTimePoints[i]) { FindTime[i] = 0; FindTimePoints[i] = 0; DisablePlayerCheckpoint(i); PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0); GameTextForPlayer(i, "~r~Czerwony Marker ulegl destrukcji", 2500, 1); }
			else
			{
				format(string, sizeof(string), "%d", FindTimePoints[i] - FindTime[i]);
				GameTextForPlayer(i, string, 1500, 6);
				FindTime[i] += 1;
				GetPlayerPos(TaxiAccepted[i], x, y, z);
				SetPlayerCheckpoint(i, x, y, z, 5);
			}
		}
		if(TaxiCallTime[i] > 0)
		{
			if(TaxiAccepted[i] < 999)
			{
				if(IsPlayerConnected(TaxiAccepted[i]))
				{
					GetPlayerPos(TaxiAccepted[i], x, y, z);
					SetPlayerCheckpoint(i, x, y, z, 5);
				}
			}
		}
		if(BusCallTime[i] > 0)
		{
			if(BusAccepted[i] < 999)
			{
				if(IsPlayerConnected(BusAccepted[i]))
				{
					GetPlayerPos(BusAccepted[i], x, y, z);
					SetPlayerCheckpoint(i, x, y, z, 5);
				}
			}
		}
		if(MedicCallTime[i] > 0)
		{
			if(MedicCallTime[i] == 60) { MedicCallTime[i] = 0; DisablePlayerCheckpoint(i); PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0); GameTextForPlayer(i, "~r~Czerwony Marker ulegl destrukcji", 2500, 1); }
			else
			{
				format(string, sizeof(string), "%d", 60 - MedicCallTime[i]);
				GameTextForPlayer(i, string, 1500, 6);
				MedicCallTime[i] += 1;
			}
		}
		if(MechanicCallTime[i] > 0)
		{
			if(MechanicCallTime[i] == 60) { MechanicCallTime[i] = 0; DisablePlayerCheckpoint(i); PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0); GameTextForPlayer(i, "~r~Czerwony Marker ulegl destrukcji", 2500, 1); }
			else
			{
				format(string, sizeof(string), "%d", 60 - MechanicCallTime[i]);
				GameTextForPlayer(i, string, 1500, 6);
				MechanicCallTime[i] += 1;
			}
		}
		if(Robbed[i] == 1)
		{
			if(RobbedTime[i] <= 0)
			{
				RobbedTime[i] = 0;
				Robbed[i] = 0;
			}
			else
			{
				RobbedTime[i] -= 1;
			}
		}
		if(PlayerCuffed[i] == 1)
		{
			if(PlayerCuffedTime[i] <= 0)
			{
				TogglePlayerControllable(i, 1);
				PlayerCuffed[i] = 0;
				PlayerCuffedTime[i] = 0;
				PlayerTazeTime[i] = 1;
				PlayerTied[i] = 0;
				pobity[i] = 0;
			}
			else
			{
				PlayerCuffedTime[i] -= 1;
			}
		}
		if(PlayerCuffed[i] == 2 || PlayerCuffed[i] == 3 || PlayerTied[i] == 1)
		{
			if(PlayerCuffedTime[i] <= 0)
			{
                GetPlayerName(i, winner, sizeof(winner));
				format(string, sizeof(string), "* %s po wielu próbach poluzowa³ sznur i jest wolny.", winner);
				ProxDetector(30.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				GameTextForPlayer(i, "~r~Jestes wolny!", 2500, 3);
				PlayerCuffed[i] = 0;
				PlayerCuffedTime[i] = 0;
				pobity[i] = 0;
				PlayerInfo[i][pMuted] = 0;
				PlayerTied[i] = 0;
                PlayerInfo[i][pBW]=0;
                TogglePlayerControllable(i, 1);
                SetPVarInt(i, "bw-sync", 0);
                PlayerInfo[i][pMuted] = 0;
			}
			else
			{
				PlayerCuffedTime[i] -= 1;
			}
		}
		//Czas na /duty
		if( (OnDuty[i] > 0 || JobDuty[i] || SanDuty[i]) && !IsPlayerPaused(i))
			PlayerInfo[i][pDutyTime]++;
	}
	return 1;
}

//11.06.2014
public CheckGas()
{
	new string[128], vehicle, engine,lights,alarm,doors,bonnet,boot,objective;
	foreach(new i : Player)
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
		{
			vehicle = GetPlayerVehicleID(i);
			GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
			if(Gas[vehicle] >= 0)
			{
				if(engine != 0)
				{
					if(Gas[vehicle] <= 10) { PlayerPlaySound(i, 1085, 0.0, 0.0, 0.0); }
					if(Gas[vehicle] > 100) { Gas[vehicle] = 100; }
					if(gGas[i] == 1)
					{
						format(string, sizeof(string), "~r~~n~~n~~n~~n~~n~~n~~n~~n~~n~Paliwo:~w~ %d%",Gas[vehicle]);
						GameTextForPlayer(i,string,15500,3);
					}
					if(IsAPlane(vehicle) || IsABoat(vehicle))
					{
						Gas[vehicle]++;
					}
					Gas[vehicle]--;
				}
			}
			else
			{
				GameTextForPlayer(i,"~w~~n~~n~~n~~n~~n~~n~~n~~n~Brak paliwa w wozie, silnik zgasl",1500,3);
				SetVehicleParamsEx(vehicle,0,lights,alarm,doors,bonnet,boot,objective);
				//PlayerAC[i][acCarEngine_Tick] = gettime()+110;
			}
		}
	}
	return 1;
}

//11.06.2014
public Fillup()
{
    new VID, FillUp, string[128];
	foreach(new i : Player)
   	{
		if(IsPlayerNPC(i)) continue;
		VID = GetPlayerVehicleID(i);
		if(Gas[VID] <= 100) FillUp = GasMax - Gas[VID];
		else FillUp = 0;
		if(Refueling[i] == 1)
		{
			if(kaska[i] >= FillUp+4)
			{
				Gas[VID] += FillUp;
				FillUp = FillUp * MULT_TANKOWANIE;
				if(CarData[VehicleUID[VID][vUID]][c_Owner] == FRAC_KT && CarData[VehicleUID[VID][vUID]][c_OwnerType] == CAR_OWNER_GROUP && GroupPlayerDutyPerm(i, PERM_TAXI))
				{
					FillUp = 0;
				}
				if(IsACopCar(GetPlayerVehicleID(i)) && OnDuty[i] > 0)
				{
					format(string,sizeof(string),"Pojazd s³u¿bowy zatankowany za: $0.");
					SendClientMessage(i, COLOR_LIGHTBLUE,string);
				}
				else
				{
					format(string,sizeof(string),"Pojazd zatankowany za: $%d.",FillUp);
					SendClientMessage(i, COLOR_LIGHTBLUE,string);
					ZabierzKaseDone(i, FillUp);
				}
				Refueling[i] = 0;
			}
			else
			{
				format(string,sizeof(string),"Nie posiadasz doœæ pieniêdzy ($%d) aby zatankowaæ ten pojazd.",FillUp);
				sendErrorMessage(i,string);
                Refueling[i] = 0;
			}
		}
	}
	return 1;
}

public PlayersCheckerMinute()
{
	foreach(new j : Player)
	{
		if(gPlayerLogged[j] > 0)
		{
			if(PlayerInfo[j][pFishes] >= 5) 
			{ 
				if(FishCount[j] >= 9) //10 minut
				{
					PlayerInfo[j][pFishes] = 0; 
					FishCount[j] = 0;
				} 
				else 
				{ 
					FishCount[j]++; 
				} 
			}
			if(GetPlayerSkin(j) == 0 && GetPlayerAdminDutyStatus(j) == 0 && GetPVarInt(j, "JestPodczasWjezdzania") == 0 && GetPVarInt(j, "IsAGetInTheCar") == 0)
			{
				if(PlayerInfo[j][pSkin] > 0)
				{
					SetPlayerSpawnSkin(j);
				}
				else 
				{
					//PlayerInfo[j][pSkin] = 299; na potem
					SetPlayerSkinEx(j, 299);
					sendTipMessage(j, "Posiada³eœ skin CJ-a ID [0] - przywróciliœmy Ci domyœlny skin. Uwa¿asz, ¿e to b³¹d? Zg³oœ utratê w dziale b³êdów.");
					sendTipMessage(j, "[.] opisz dok³adnie co siê sta³o, np. dosta³eœ unfrakcjê lub jesteœ w rodzinie, frakcji. Pomocna bêdzie ka¿da informacja.");
				}
			}
		}
	}
}
//11.06.2014
public CarCheck()
{
	new string[128], lTime = gettime();
	foreach(new j : Player)
	{
        if(kaska[j] < 0)
		{
			if(MoneyMessage[j]==0)
			{
				format(string, sizeof(string), "Masz d³ugi, musisz zarobiæ do nastêpnej wyp³aty $%d inaczej naœlemy na ciebie policje.",PlayerInfo[j][pCash]);
				SendClientMessage(j, COLOR_LIGHTRED, string);
				MoneyMessage[j] = 1;
			}
		}
		else
		{
			MoneyMessage[j] = 0;
		}
        if(PlayerInfo[j][pCarLic] > 1000)
        {
            if(lTime > PlayerInfo[j][pCarLic])
            {
                PlayerInfo[j][pCarLic] = 0;
                SendClientMessage(j, COLOR_LIGHTRED, "Blokada licencji na prowadzenie pojazdu minê³a!");
            }
        }
	}	
    //Kolczatki 23.08
    new time = gettime();
    for(new i=0;i<MAX_KOLCZATEK;i++)
    {
        if(KolID[i] != -1)
        {
            if(KolTime[i] <= time)
            {
                Kolczatka_Delete(i);
            }
        }
    }
    //For oil only
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        bOilOccur[i] = false;
    }
	return 1;
}

public GangZone_Process()
{
    new Float:x, Float:y, Float:z;
    foreach(new i : Player)
    {
		if(IsPlayerNPC(i)) continue;
        GetPlayerPos(i, x, y, z);
        for(new g=0;g<MAX_ZONES;g++) //zone loop
        {
            if(x >= Zone_Data[g][0] && x <= Zone_Data[g][2] && y >= Zone_Data[g][1] && y <= Zone_Data[g][3])
            {
                if(!bInZone[i][g])
                {
                    printf("%s entered gangzone %d", GetNick(i), g);
                    bInZone[i][g] = true;
                    CallLocalFunction("OnPlayerEnterGangZone", "ii", i, g);
                    break;
                }
            }
            else if(bInZone[i][g])
            {
                printf("%s left gangzone %d", GetNick(i), g);
                bInZone[i][g] = false;
                CallLocalFunction("OnPlayerLeaveGangZone", "ii", i, g);
                break;
            }
        }
    }
}
forward CheckTankMode(playerid, giveid, carid, Float:vhealth);
public CheckTankMode(playerid, giveid, carid, Float:vhealth)
{
	new result, string[144], Float:newvhealth;
	GetVehicleHealth(carid, newvhealth);
	result = (vhealth == newvhealth ? true : false);
    format(string, sizeof(string), "Admin %s [%d] sprawdzi³ %s [%d]. Wynik: %s", GetNickEx(playerid), playerid, GetNick(giveid), giveid, (result ? "{fad052}prawdopodobny tankmode (zalecany /spec)" : "{fa5252}negatywny (brak tankmode)"));
    SendCommandLogMessage(string);
	if(vhealth != newvhealth) SetVehicleHealth(carid, newvhealth+15);
	return 1;
}
forward GangZone_ShowInfoToParticipants();
public GangZone_ShowInfoToParticipants() {
    new string[60];
    foreach(new i : Player) {
		if(IsPlayerNPC(i)) continue;
        new frac = GetPlayerFraction(i);
        if(frac == 0) frac = GetPlayerOrg(i);
        new pzone = GetPVarInt(i, "zoneid");
        if(pzone == -1) return 1;
        if(ZoneAttack[pzone])
        {
            new svar_data[30];
            format(svar_data, 128, "ZONEDEFTIME_%d", pzone);
            if(GetSVarInt(svar_data) < 0)
                format(string, 128, "~n~~n~~n~~n~~n~ATAK NA STREFE~n~~y~PRAWIE KONIEC");
            else {
                format(string, 128, "~n~~n~~n~~n~~n~ATAK NA STREFE~n~~y~%d", GetSVarInt(svar_data));
            }
            GameTextForPlayer(i, string, 2500, 3);
            if(ZoneAttackData[pzone][2] > 100)
            {
                //GameTextForAll(string, 3000, 3);
                GameTextForPlayer(i, string, 1000, 3);
            }
            else
            {
                GameTextForPlayer(i, string, 1000, 3);   
            }
            SetSVarInt(svar_data, GetSVarInt(svar_data)-2);
        }
    }
    return 1;
}
public VehicleUpdate()
{
    new Float:lHP = 0.0,
        engine, lights, alarm, doors, bonnect, boot, objective;
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        if(!GetVehicleHealth(i, lHP)) continue;

        if(lHP < 250.0)
        {
            if(Car_GetOwner(i) == FRAC_KT && Car_GetOwnerType(i) == CAR_OWNER_GROUP && GetVehicleModel(i) == 530)
            {
                SetVehicleHealth(i, 1000.0);
                Gas[i] = 100;
            }
            else
            {
                SetVehicleHealth(i, 250.0);
                if(VehicleUID[i][vUID] != 0)
                    CarData[VehicleUID[i][vUID]][c_HP] = 250.0;
                GetVehicleParamsEx(i, engine, lights, alarm, doors, bonnect, boot, objective);
                SetVehicleParamsEx(i, 0, lights, alarm, doors, bonnect, boot, objective);
				new driverid = GetVehicleDriverID(i);
				//if(IsPlayerConnected(driverid))
				//	PlayerAC[driverid][acCarEngine_Tick] = gettime()+30;
                new hour,minute,second;
				gettime(hour,minute,second);
				FixHour(hour);
				if(shifthour >= 4)
				{
					Oil_GenerateFromVehicle(i);
				}
            }
        }
    }
}


public closeGate(i, j, playerid)
{
    bramki_sasd_state[i] = false;
    SetPVarInt(playerid, "wybramkowany", 0);
    bramy[j][b_flaga] = true;
    MoveDynamicObject(bramy[j][b_obiekt], bramy[j][b_x2],  bramy[j][b_y2], bramy[j][b_z2], bramy[j][b_speed], bramy[j][b_rx2],  bramy[j][b_ry2], bramy[j][b_rz2]);
    return 1;
}


public SlideRope(playerid)
{
    if(GetPVarInt(playerid,"sliderope") == 1)
    {
		new Float:X;
	    new Float:Y;
	    new Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
  	 	ApplyAnimation(playerid,"ped","abseil",2.0,0,0,0,1,0);
	    SetPlayerPos(playerid, X, Y, Z - 2.00);
		SetPlayerVelocity(playerid,0,0,0);
	    SetTimerEx("SlideRope", 1000, 0, "i", playerid);
 	}
	return 1;
}

public SpecEnd(playerid)
{
	SetSpawnInfo(playerid, PlayerInfo[playerid][pTeam], 299, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2], 10.0, -1, -1, -1, -1, -1, -1);
	TogglePlayerSpectating(playerid, false);
	SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]);
	if(PlayerInfo[playerid][pDoor] != 0 && GetPlayerVirtualWorld(playerid) == 22) //ibiza stream
	{
		new checkid = wejscia[PlayerInfo[playerid][pDoor]][w_UID];
		if(checkid == 18 || checkid == 19)
			PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	return 1;
}

public DamagedHP(playerid)
{
	RemovePlayerAttachedObject(playerid, 2);
	return 1;
}

forward CBugFreezeOver(playerid);
public CBugFreezeOver(playerid)
{
	TogglePlayerControllable(playerid, true);

	SetPVarInt(playerid, "cbugging", 0);
	return 1;
}

//EOF
