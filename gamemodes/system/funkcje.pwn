//funkcje.pwn
//FUNKCJE DLA CA�EGO SERWERA


/* SSCANF FIX */
SSCANF:fix(string[])
{
	new ret = INVALID_PLAYER_ID;
	
	if(IsNumeric(string))
	{
		new p = strval(string);
		if(IsPlayerConnected(p))
			ret = p;
	}
	else 
	{
		foreach(new p : Player)
		{
			if(strfind(GetNick(p), string, true) != -1)
			{
				ret = p;
				break;
			}
		}
	}
	
	return ret;
}

strToUpper(str[])
{
	for(new i = 0, n = strlen(str); i <n; i ++)
    {
        str[i] = toupper(str[i]);
    }
    return 1;
} 

GenString( string[ ] , size = sizeof string )
{
    static const Data[ ] = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";//add more characters if they want to include in string
    new i;
    for(i = 0 ; i < size; ++i)
        string[ i ] = Data[ random( sizeof Data ) ];
}

stock randomString(strDest[], strLen) // credits go to: RyDeR`
{
	strDest[--strLen] = '\0';
    while(strLen--)
        strDest[strLen] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
}

GetTickDiff(newtick, oldtick)
{
	if (oldtick < 0 && newtick >= 0) {
		return newtick - oldtick;
	} else if (oldtick >= 0 && newtick < 0 || oldtick > newtick) {
		return (cellmax - oldtick + 1) - (cellmin - newtick);
	}
	return newtick - oldtick;
}

PutPlayerInVehicleEx(playerid,vehicleid,seatid)
{
    PutPlayerInVehicle(playerid,vehicleid,seatid);
}

RemovePlayerFromVehicleEx(playerid)
{
    new veh = GetPlayerVehicleID(playerid);
    new model = GetVehicleModel(veh);
    if(model == 538 || model == 537 || model == 449)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(playerid, x, y, z+0.7);
    }
    RemovePlayerFromVehicle(playerid);
}

public Lowienie(playerid)
{
	FishGood[playerid] = 0;
	return 1;
}

saveLegale(playerid) {
	//LEGAL
	new lStr[256];
	format(lStr, sizeof lStr, "UPDATE mru_legal SET weapon1=%d, weapon2=%d, weapon3=%d, weapon4=%d, weapon5=%d, weapon6=%d, weapon7=%d, weapon8=%d, weapon9=%d, weapon10=%d, weapon11=%d,weapon12=%d,weapon13=%d WHERE pID = %d", playerWeapons[playerid][weaponLegal1],playerWeapons[playerid][weaponLegal2],playerWeapons[playerid][weaponLegal3],playerWeapons[playerid][weaponLegal4],playerWeapons[playerid][weaponLegal5],playerWeapons[playerid][weaponLegal6],playerWeapons[playerid][weaponLegal7],playerWeapons[playerid][weaponLegal8],playerWeapons[playerid][weaponLegal9],playerWeapons[playerid][weaponLegal10],playerWeapons[playerid][weaponLegal11],playerWeapons[playerid][weaponLegal12],playerWeapons[playerid][weaponLegal13], PlayerInfo[playerid][pUID]);
	db_free_result(db_query(db_handle, lStr));
}


loadKamiPos(playerid)
{
	new lStr[256];
	format(lStr, sizeof lStr, "SELECT * FROM `mru_kevlar` WHERE `pID`=%d", PlayerInfo[playerid][pUID]);
	new DBResult:db_result;
	db_result = db_query(db_handle, lStr);

	if(db_num_rows(db_result)) {
		SetPVarFloat(playerid, "k_offsetX", db_get_field_assoc_float(db_result, "offsetX"));
		SetPVarFloat(playerid, "k_offsetY", db_get_field_assoc_float(db_result, "offsetY"));
		SetPVarFloat(playerid, "k_offsetZ", db_get_field_assoc_float(db_result, "offsetZ"));
		SetPVarFloat(playerid, "k_rotX", db_get_field_assoc_float(db_result, "rotX"));
		SetPVarFloat(playerid, "k_rotY", db_get_field_assoc_float(db_result, "rotY"));
		SetPVarFloat(playerid, "k_rotZ", db_get_field_assoc_float(db_result, "rotZ"));
		SetPVarFloat(playerid, "k_scaleX", db_get_field_assoc_float(db_result, "scaleX"));
		SetPVarFloat(playerid, "k_scaleY", db_get_field_assoc_float(db_result, "scaleY"));
		SetPVarFloat(playerid, "k_scaleZ", db_get_field_assoc_float(db_result, "scaleZ"));

		db_free_result(db_result);
	}
	else
	{
		SetPVarFloat(playerid, "k_offsetX", 0.1);
		SetPVarFloat(playerid, "k_offsetY", 0.05);
		SetPVarFloat(playerid, "k_offsetZ", 0.0);
		SetPVarFloat(playerid, "k_rotX", 0.0);
		SetPVarFloat(playerid, "k_rotY", 0.0);
		SetPVarFloat(playerid, "k_rotZ", 0.0);
		SetPVarFloat(playerid, "k_scaleX", 1.0);
		SetPVarFloat(playerid, "k_scaleY", 1.2);
		SetPVarFloat(playerid, "k_scaleZ", 1.0);
	}
}


saveKevlarPos(playerid, recurention=1)
{
	new lStr[256];
	format(lStr, sizeof lStr, "SELECT * FROM `mru_kevlar` WHERE `pID`=%d", PlayerInfo[playerid][pUID]);
	new DBResult:db_result;
	db_result = db_query(db_handle, lStr);

	if(!db_num_rows(db_result)) 
	{
		format(lStr, sizeof lStr, "INSERT INTO `mru_kevlar` (`pID`,`offsetX`, `offsetY`, `offsetZ`, `rotX`, `rotY`, `rotZ`, `scaleX`, `scaleY`, `scaleZ`) VALUES (%d, 0.1,0.05,0.0,0.0,0.0,0.0,1.0,1.2,1.0)", PlayerInfo[playerid][pUID]);

		db_free_result(db_query(db_handle, lStr));

		if(recurention)
			saveKevlarPos(playerid, 0);
	}
	else
	{
		format(lStr, sizeof lStr, "UPDATE mru_kevlar SET offsetX=%f, offsetY=%f, offsetZ=%f, rotX=%f, rotY=%f, rotZ=%f, scaleX=%f, scaleY=%f, scaleZ=%f WHERE pID = %d", GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"), PlayerInfo[playerid][pUID]);

		db_free_result(db_query(db_handle, lStr));
	}
}


new scm_buf[144];
#define sendTipMessageFormat(%0,%1,%2) \
	(format(scm_buf, sizeof scm_buf, %1,%2), sendTipMessage(%0,scm_buf))
#define sendTipMessageFormatEx(%0,%1,%2,%3) \
	(format(scm_buf, sizeof scm_buf, %2,%3), sendTipMessageEx(%0,%1,scm_buf))	
pusteZgloszenia() {
	for(new i = 0, j=OSTATNIE_ZGLOSZENIA; i<j; i++) {
		new Hour, Minute;
		gettime(Hour, Minute);
		new string[36];
		format(string, sizeof(string), "%02d:%02d",  Hour, Minute);
		strmid(Zgloszenie[i][zgloszenie_kiedy], string, 0, sizeof(string), 36);
		strmid(Zgloszenie[i][zgloszenie_nadal], "Brak", 0, 4, MAX_PLAYER_NAME+1);
		strmid(Zgloszenie[i][zgloszenie_tresc], "Brak", 0, 4, 70);
	}
	for(new i = 0, j=OSTATNIE_ZGLOSZENIASASP; i<j; i++) {
		new Hour, Minute;
		gettime(Hour, Minute);
		new string[36];
		format(string, sizeof(string), "%02d:%02d",  Hour, Minute);
		strmid(ZgloszenieSasp[i][zgloszenie_kiedy], string, 0, sizeof(string), 36);
		strmid(ZgloszenieSasp[i][zgloszenie_nadal], "Brak", 0, 4, MAX_PLAYER_NAME+1);
		strmid(ZgloszenieSasp[i][zgloszenie_tresc], "Brak", 0, 4, 70);
	}
}
getWolneZgloszenie() {
	if(ilosczgloszen == OSTATNIE_ZGLOSZENIA) {
		ilosczgloszen = 0;
	}
	return ilosczgloszen++;
}
getWolneZgloszenieSasp() {
	if(ilosczgloszenSasp == OSTATNIE_ZGLOSZENIASASP) {
		ilosczgloszenSasp = 0;
	}
	return ilosczgloszenSasp++;
}
sendNotification(id, title[], text[], time) {
	CallRemoteFunction("notify", "dssd", id, title, text, time);
}
new _str[248];
_MruAdmin(id, string:msg[])
{
	format(_str, 248, "�� %s", msg);
	return SendClientMessage(id, 0xACD32FFF, _str);
}


_MruGracz(id, string:msg[], bool:noArrows=false)
{
	format(_str, 248, "%s%s", (!noArrows) ? ("�� ") : (""), msg);
	return SendClientMessage(id, COLOR_GOLD, _str);
}

noAccessMessage(id) {
    return SendClientMessage(id,COLOR_FADE2,"�� Nie posiadasz dost�pu do tej komendy");
}
sendTipMessage(id, string:msg[], color = COLOR_GRAD3) {
	format(_str,248,"�� %s", msg);
	return SendClientMessage(id, color, _str);
}

sendTipMessageEx(id, color = COLOR_GRAD3, string:msg[]) { //CM do sendclientmessage (:
	return sendTipMessage(id, msg, color);
}
sendErrorMessage(id, string:msg[]) {
	format(_str,248,"�� %s", msg);
	return SendClientMessage(id, COLOR_LIGHTRED, _str);
}

ToggleInwigilacja(playerid, adminid)
{
	if(PlayerInfo[playerid][pPodPW] == 0)
	{
		PlayerInfo[playerid][pPodPW] = 1;
		SendCommandLogMessage(sprintf("Admin %s [%d] w��czy� inwigilacje dla %s [%d]", GetNickEx(adminid), adminid, GetNick(playerid), playerid));
		Log(adminLog, WARNING, "Admin %s w��czy� inwigilacje /w dla gracza %s", GetPlayerLogName(adminid), GetPlayerLogName(playerid));
	}
	else if(PlayerInfo[playerid][pPodPW] == 1)
	{
		PlayerInfo[playerid][pPodPW] = 0;
		SendCommandLogMessage(sprintf("Admin %s [%d] wy��czy� inwigilacje dla %s [%d]", GetNickEx(adminid), adminid, GetNick(playerid), playerid));
		Log(adminLog, WARNING, "Admin %s wy��czy� inwigilacje /w dla gracza %s", GetPlayerLogName(adminid), GetPlayerLogName(playerid));
	}
	return 1;
}


//WRZUCANIE DO DEMORGAN
JailDeMorgan(playerid)
{
	new losuj= random(sizeof(SpawnStanowe));
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 1);
	SetPlayerPos(playerid, SpawnStanowe[losuj][0], SpawnStanowe[losuj][1], SpawnStanowe[losuj][2]);
	SetCameraBehindPlayer(playerid);
	Wchodzenie(playerid);
	PlayerInfo[playerid][pJailed] = 2;
	GameTextForPlayer(playerid, "~w~Witamy ~r~w sztumie!", 5000, 1);
	return 1;
}

// WYPUSZCZANIE z DEMORGAN
UnJailDeMorgan(playerid)
{
	SetPlayerVirtualWorld(playerid, 1);
	SetPlayerPos(playerid, 593.1899,-1494.0863,82.1648);
	Wchodzenie(playerid);
	GameTextForPlayer(playerid, "~w~Dostales szanse na bycie ~n~~r~lepszym obywatelem", 5000, 3);
	PoziomPoszukiwania[playerid] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
	if(PlayerInfo[playerid][pInjury] > 0) ZdejmijBW(playerid, 2000);
}

DialogListaFrakcji()
{
	new frakcje[512];
	for(new i=1; i<18; i++)
	{
		strcat(frakcje, GroupInfo[i][g_Name], sizeof(frakcje));
		if(i!=18) strcat(frakcje, "\n", sizeof(frakcje));
	}
	safe_return frakcje;
}

stock PreloadAnimLibs(playerid) {
  for(new i = 0; i < sizeof(AnimLibs); i++) {
      ApplyAnimation(playerid, AnimLibs[i], "null", 4.0, 0, 0, 0, 0, 0, 1);
  }
  return 1;
}

IloscSkinow(group)
{
	if(!IsValidGroup(group)) return 0;
	new count = 0;
	for(new i=0;i<20;i++)
	{
		if(GroupInfo[group][g_Skin][i] < 1) continue;
		count++;
	}
	return count;
}

DialogListaSkinow(frakcja)
{
	new skiny[1024];
	if(!IsValidGroup(frakcja)) safe_return skiny;
	for(new i=0;i<20;i++)
	{
		if(GroupInfo[frakcja][g_Skin][i] < 1) continue;
		format(skiny, sizeof(skiny), "%s%d\tID: %d\n", skiny, GroupInfo[frakcja][g_Skin][i], GroupInfo[frakcja][g_Skin][i], i);
	}
	strdel(skiny, strlen(skiny)-1, strlen(skiny));
	safe_return skiny;
}

PDTuneSultan(vehicleid)
{
	new o[5];
	o[0] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	o[1] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	o[2] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	o[3] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	o[4] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	AttachDynamicObjectToVehicle(o[0], vehicleid, 0.234999, 2.598513, -0.222499, 0.000000, -0.000001, 178.890090); //Object Model: 19797 |
	AttachDynamicObjectToVehicle(o[1], vehicleid, -0.234999, 2.598513, -0.217499, 0.000000, 179.895095, 182.910110); //Object Model: 19797 |
	AttachDynamicObjectToVehicle(o[2], vehicleid, 0.000000, -2.374014, 0.159999, 0.000000, 0.000000, 0.000000); //Object Model: 19797 |
	AttachDynamicObjectToVehicle(o[3], vehicleid, -0.674999, -2.362517, 0.110000, 0.000000, 0.000000, 0.000000); //Object Model: 19797 |
	AttachDynamicObjectToVehicle(o[4], vehicleid, 0.676498, -2.344018, 0.110000, 0.000000, 179.895095, -0.000001); //Object Model: 19797 |
}

PDTuneInfernus(vehicleid)
{
    new alspdo = CreateDynamicObject(2286,-0.0972000,-1.9730999,0.2444000,275.5001526,0.0000000,0.0000000);
    SetDynamicObjectMaterial(alspdo, 1, 0, "none", "none");
    new lspdo1 = CreateDynamicObject(19280, -0.5947266,2.6767578,-0.4871000,341.4990234,0.0000000,12.7496338);
    new lspdo3 = CreateDynamicObject(19280, -0.7447000,2.6440001,-0.4871000,341.4990234,0.0000000,12.7496338);
    new lspdo4 = CreateDynamicObject(19280, 0.6053000,2.6768000,-0.4871000,341.4990234,0.0000000,346.7496338);
    new lspdo5 = CreateDynamicObject(19280, 0.7545000,2.6418002,-0.4871000,341.4990234,0.0000000,346.7449951);
    SetDynamicObjectMaterial(lspdo1, 1, 18646, "matcolours", "red");
    SetDynamicObjectMaterial(lspdo3, 1, 18646, "matcolours", "red");
    SetDynamicObjectMaterial(lspdo4, 1, 18646, "matcolours", "blue");
    SetDynamicObjectMaterial(lspdo5, 1, 18646, "matcolours", "blue");
    SetDynamicObjectMaterialText(alspdo, 0, " POLICE", OBJECT_MATERIAL_SIZE_256x128, "Arial", 75, 1, 0xFFFFFFFF, 0, 1);
    AttachDynamicObjectToVehicle(alspdo, vehicleid, -0.0972000,-1.9730999,0.2444000,275.5001526,0.0000000,0.0000000);
    AttachDynamicObjectToVehicle(lspdo1, vehicleid, -0.5947266,2.6767578,-0.4871000,341.4990234,0.0000000,12.7496338);
    AttachDynamicObjectToVehicle(lspdo3, vehicleid, -0.7447000,2.6440001,-0.4871000,341.4990234,0.0000000,12.7496338);
    AttachDynamicObjectToVehicle(lspdo4, vehicleid, 0.6053000,2.6768000,-0.4871000,341.4990234,0.0000000,346.7496338);
    AttachDynamicObjectToVehicle(lspdo5, vehicleid, 0.7545000,2.6418002,-0.4871000,341.4990234,0.0000000,346.7449951);
    new hsiu_text = CreateDynamicObject(2659,-1.1012001,0.0907000,-0.1102000,0.0000000,0.0000000,271.5000000);
    new hsiu_text2 = CreateDynamicObject(2659,1.1012998,0.0907000,-0.1102000,0.0000000,0.0000000,88.7496338);
    SetDynamicObjectMaterialText(hsiu_text, 0, " LSPD", OBJECT_MATERIAL_SIZE_256x128, "Arial", 74, 1, 0xFFFFFFFF, 0, 1);
    SetDynamicObjectMaterialText(hsiu_text2, 0, " LSPD", OBJECT_MATERIAL_SIZE_256x128, "Arial", 74, 1, 0xFFFFFFFF, 0, 1);
    AttachDynamicObjectToVehicle(hsiu_text, vehicleid, -1.1012001,0.0907000,-0.150000,0.0000000,0.0000000,271.5000000);
    AttachDynamicObjectToVehicle(hsiu_text2, vehicleid, 1.1013298,0.0907000,-0.150000,0.0000000,0.0000000,88.7496338);
}

GetFreeVehicleSeatForArrestant(vehicleid)
{
	new bool:Seat[4];
	foreach(new i : Player)
	{
		if(IsPlayerInVehicle(i,vehicleid))
		{
			if(GetPlayerVehicleSeat(i) == 3) Seat[3] = true;
			else if(GetPlayerVehicleSeat(i) == 2) Seat[2] = true;
			else if(GetPlayerVehicleSeat(i) == 1) Seat[1] = true;
			else if(GetPlayerVehicleSeat(i) == 0) Seat[0] = true;
		}
	}
	if(Seat[3] == false) return 3;
	else if(Seat[2] == false) return 2;
	else if(Seat[1] == false) return 1;
	else if(Seat[0] == false) return 0;
	else return -1;
}

GetCarSpeed(vehicleid)
{
    new Float:pAC_Pos[3],Float:VS ;
    GetVehicleVelocity(vehicleid, pAC_Pos[0], pAC_Pos[1], pAC_Pos[2]);
    VS = VectorSize(pAC_Pos[0], pAC_Pos[1], pAC_Pos[2])*136.6666;
    return floatround(VS,floatround_round);
}

getEngineState(vehicleid)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	return engine;
}

Odpolszcz(text[])
{
    new string[256], i_pos;
    format(string, sizeof(string), text);
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'A';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'a';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'C';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'c';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'E';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'e';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'L';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'l';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'N';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'n';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'S';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 's';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'O';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'o';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'Z';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'z';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'Z';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'z';
	return string;
}

Uprawnienia(playerid, flags, bool:part=false)
{
    if(flags & ACCESS[playerid] != 0)
    {
        if(part) return 1;
        else
        {
            if(flags & ACCESS[playerid] == flags) return 1;
            else return 0;
        }
    }
    else return 0;
}

Taxi_FareEnd(playerid)
{
    new string[128];
    if(TransportDuty[playerid] == 1)
	{
		TaxiDrivers -= 1;
	}
	else if(TransportDuty[playerid] == 2)
	{
		BusDrivers -= 1;
	}
    for(new i=0;i<4;i++) if(TransportClient[playerid][i] != INVALID_PLAYER_ID) Taxi_Pay(TransportClient[playerid][i]); //Handle to 4 passenger

	TransportDuty[playerid] = 0;
	format(string, sizeof(string), "Zako�czy�e� s�u�b�, zarobi�e� $%d dla Korporacji Transportowej", TransportMoney[playerid]);

	_MruGracz(playerid, string);


	if(!IsPlayerInGroup(playerid, FRAC_KT))
	{
		DajKaseDone(playerid, TransportMoney[playerid]);
		Log(payLog, WARNING, "%s zarobi� $%d na s�u�bie taks�wkarza.", GetPlayerLogName(playerid), TransportMoney[playerid]);
	}
    else
    {
        Sejf_Add(FRAC_KT, floatround(TransportMoney[playerid]/2));
		DajKaseDone(playerid, floatround(TransportMoney[playerid]/2));
		Log(payLog, WARNING, "%s zarobil $%d dla KT na s�u�bie taks�wkarza.", GetPlayerLogName(playerid), TransportMoney[playerid]);
    }
	TransportValue[playerid] = 0; TransportMoney[playerid] = 0;
}

Taxi_Pay(playerid)
{
    new taxidriver = TransportDriver[playerid];
    if(IsPlayerConnected(taxidriver))
	{
        new slot = GetPVarInt(playerid, "taxi-slot");
        new string[64];
		new doZaplaty = 0;
        TransportCost[playerid] = floatround(TransportValue[taxidriver]*TransportDist[playerid]);
		
	    if(PlayerInfo[playerid][pLevel] < 3)
	    {
			if(kaska[playerid] < floatround(TransportCost[playerid]*0.25))
			{
				ZabierzKaseDone(playerid, floatround(kaska[playerid] + 25));//moneycheat
				doZaplaty = floatround(kaska[playerid] + 25);
				PoziomPoszukiwania[playerid] += 1;
				SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Kradzie� taks�wkarza(brak pieni�dzy na sp�ate)");
				format(string, sizeof(string), "Klient nie posiada� pe�nej kwoty.");
				SendClientMessage(taxidriver, COLOR_RED, string);
			}
			else
			{
				ZabierzKaseDone(playerid, floatround(TransportCost[playerid]*0.25));//moneycheat
				doZaplaty = floatround(TransportCost[playerid]*0.25);
			} 
	    }
	    else
	    {
	    	if(kaska[playerid] < floatround(TransportCost[playerid]))
			{
				ZabierzKaseDone(playerid, floatround(kaska[playerid] + 50));//moneycheat
				doZaplaty = floatround(kaska[playerid] + 50);
				PoziomPoszukiwania[playerid] += 1;
				SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Kradzie� taks�wkarza(brak pieni�dzy na sp�ate)");
				format(string, sizeof(string), "Klient nie posiada� pe�nej kwoty.");
				SendClientMessage(taxidriver, COLOR_RED, string);
			}
			else 
			{
				ZabierzKaseDone(playerid, floatround(TransportCost[playerid]));//moneycheat
				doZaplaty = floatround(TransportCost[playerid]);
			}
	    }
		
		TransportMoney[taxidriver] += doZaplaty;

	    format(string, sizeof(string), "~w~Klient opuscil taxi~n~~g~Zarobiles $%d",doZaplaty+TransportValue[taxidriver]);
	    GameTextForPlayer(taxidriver, string, 5000, 1);

		TransportCost[playerid] = 0;
        TransportDist[playerid] = 0.0;

        TransportClient[taxidriver][slot] = INVALID_PLAYER_ID;

        Taxi_HideHUD(playerid);
        new bool:hide=true;
        for(new i=0;i<4;i++)
        {
            if(TransportClient[taxidriver][slot] != INVALID_PLAYER_ID)
            {
                hide = false;
                break;
            }
        }
        if(hide) Taxi_HideHUD(taxidriver);

        TransportDriver[playerid] = 999;
	}
}

Taxi_HideHUD(playerid)
{
    TextDrawHideForPlayer(playerid, TAXI_BG[0]);
    TextDrawHideForPlayer(playerid, TAXI_BG[1]);
    PlayerTextDrawHide(playerid, TAXI_DIST[playerid]);
    PlayerTextDrawHide(playerid, TAXI_COST[playerid]);
}

Taxi_ShowHUD(playerid)
{
    TextDrawShowForPlayer(playerid, TAXI_BG[0]);
    TextDrawShowForPlayer(playerid, TAXI_BG[1]);
    PlayerTextDrawSetString(playerid, TAXI_DIST[playerid], "_");
    PlayerTextDrawSetString(playerid, TAXI_COST[playerid], "_");
    PlayerTextDrawShow(playerid, TAXI_DIST[playerid]);
    PlayerTextDrawShow(playerid, TAXI_COST[playerid]);
}

stock Have_Worek(playerid)
{
    TextDrawShowForPlayer(playerid, TXD_Worek);
    GangZoneShowForPlayer(playerid, blackmap, 255);
}

stock UnHave_Worek(playerid)
{
    TextDrawHideForPlayer(playerid, TXD_Worek);
    GangZoneHideForPlayer(playerid, blackmap);
}

GetPlayerFrac(playerid) // Duplikat funkcji �eby mi si� nie pierdoli�o z legacy funkcjami
{
	if(PlayerInfo[playerid][pMember] == 0) return PlayerInfo[playerid][pLider];
    else return PlayerInfo[playerid][pMember];
}

GetPlayerFraction(playerid)
{
    if(PlayerInfo[playerid][pMember] == 0) return PlayerInfo[playerid][pLider];
    else return PlayerInfo[playerid][pMember];
}

CarOpis_Usun(playerid, vehicleid, message=false)
{
    if(vehicleid >= MAX_VEHICLES) return 0;
    if(CarOpis[vehicleid] != Text3D:INVALID_3DTEXT_ID)
    {
        DestroyDynamic3DTextLabel(Text3D:CarOpis[vehicleid]);
        CarOpis[vehicleid] = Text3D:INVALID_3DTEXT_ID;
		
		if(CarData[VehicleUID[vehicleid][vUID]][c_UID] > 0)
		{
			MruMySQL_DeleteOpis(CarData[VehicleUID[vehicleid][vUID]][c_UID], 2);
		}
        if(message)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Opis: Usuni�to.");
        }
        return 1;
    }
    return 0;
}

public Dopalaj(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new Float:Velocity[4], veh;
		veh = GetPlayerVehicleID(playerid);
		GetVehicleVelocity(veh, Velocity[0], Velocity[1], Velocity[2]);
		Velocity[3] = VectorSize(Velocity[0], Velocity[1], 0.0);
		if(Velocity[3] > 0.9)
		{
			if(Velocity[3] > 1.5)
			{
				SetTimerEx("Dopalaj",1000,0,"d",playerid);
			}
			else
			{
				SetVehicleVelocity(veh, Velocity[0]*1.15, Velocity[1]*1.15, Velocity[2]-0.01);
				SetTimerEx("Dopalaj",1000,0,"d",playerid);
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "Dopalacz deaktywowany - zbyt ma�a pr�dko��");
			return 1;
		}
	}
	else
	{
		SendClientMessage(playerid, TEAM_CYAN_COLOR, "Dopalacz deaktywowany - wysiad�e� z wozu");
		return 1;
	}
	return 1;
}

ClearChat(playerid)
{
	for(new i; i<100; i++)
	{
		SendClientMessage(playerid, COLOR_GREY," ");
	}
	return 1;
}

AntyReklama(result[])
{
	if ( strfind(result , "kotnik-rp.pl" , true)>=0)
		return 0;
	if ( strfind(result , "lsrp" , true)>=0 ||  strfind(result , "ls-rp" , true)>=0 || strfind(result , "n4g" , true)>=0 || strfind(result , "net4game" , true)>=0)//nazwy serwer�while
		return 1;
	if ( strfind(result , "www." , true)>=0 || strfind(result , ".pl" , true)>=0 || strfind(result , ".net" , true)>=0 || strfind(result , ".com" , true)>=0)//strony internetowe
		return 2;

	new dwukrop = strfind(result , ":" , true);
	if ( dwukrop>=0)//adersy ip
	{
		if(result[dwukrop+1] != '\0')
		{
			if(result[dwukrop+1] >= '1' && result[dwukrop+1] <= '9')
				return 3;
		}
		else if(result[dwukrop+2] != '\0')
		{
			if(result[dwukrop+2] >= '1' && result[dwukrop+2] <= '9')
				return 3;
		}
	}
	return 0;
}

AntyCzitText(const result[])
{
	if(strfind(result , "cheat" , true)>=0 || strfind(result , "czit" , true)>=0 || strfind(result , "cleo" , true)>=0 || strfind(result , "sobeit" , true)>=0
	|| strfind(result , "hack" , true)>=0 || strfind(result , "hax" , true)>=0 || strfind(result , "s0b" , true)>=0 || strfind(result , "s0beit" , true)>=0)
		return 1;
	else
		return 0;
}

//--------------------------------------------------------
//---------------------[Mini Timery:]---------------------
//--------------------------------------------------------


public StartPaintball()
{
	PaintballRound = 1;
	StartingPaintballRound = 0;
	PaintballWinner = 999;
	PaintballWinnerKills = 0;
	foreach(new i : Player)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(PlayerPaintballing[i] != 0)
	        {
	            ResetPlayerWeapons(i);
	            GivePlayerWeapon(i, 29, 999);
            	PlayerInfo[i][pGun1] = 29;
            	PlayerInfo[i][pAmmo1] = 999;
	            TogglePlayerControllable(i, 1);
	            SendClientMessage(i, COLOR_YELLOW, "Mecz Pintballa rozpocz�ty, sko�czy si� za 4 minuty.");
	            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
	        }
	    }
	}
	SetTimer("PaintballEnded", 240000, 0);
	return 1;
}

public PreparePaintball()
{
    foreach(new i : Player)
	{
		if(PlayerPaintballing[i] != 0)
		{
			SendClientMessage(i, COLOR_YELLOW, "Mecz Pintballa rozpocznie si� za 20 sekund, prosz� czeka�.");
		}
	}
 	SetTimer("StartPaintball", 20000, 0);
	return 1;
}

PlayerPlayMusic(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		SetTimer("StopMusic", 5000, 0);
		PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
	}
}

public StopMusic()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			PlayerPlaySound(i, 1069, 0.0, 0.0, 0.0);
		}
	}
}

public PlayerFixRadio(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    SetTimer("PlayerFixRadio2", 500, 0);
		PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
		Fixr[playerid] = 1;
	}
}

MruDialog(playerid, title[], text[])
{
	return ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_MSGBOX, MruTitle(title), text, "Ok", "");
}
MruTitle(text[])
{
	new title_str[128];
	format(title_str, 128, "Kotnik-RP � {00b33c}%s", text);
	return title_str;
}

public PlayerFixRadio2()
{
	foreach(new i : Player)
	{
		if(Fixr[i])
		{
			PlayerPlaySound(i, 1069, 0.0, 0.0, 0.0);
			Fixr[i] = 0;
		}
	}
}

forward func_SetPVarInt(playerid, key[], value);
public func_SetPVarInt(playerid, key[], value)
{
	SetPVarInt(playerid, key, value);
	return 1;
}

public ZestawNaprawczy_CountDown(playerid, vehicleid)
{
	new Float:pos[3];
	new string[128];
	GetVehiclePos(vehicleid, pos[0],pos[1],pos[2]);
	if(GetVehicleSpeed(vehicleid) > 10)
	{
		ZestawNaprawczy_Warning[playerid] = 8;
	}
	if(ZestawNaprawczy_Warning[playerid] == 8)
	{
		SendClientMessage(playerid, COLOR_PANICRED, "* [ZESTAW NAPRAWCZY] Anulowano napraw� pojazdu.");
		ZestawNaprawczy_Timer[playerid] = 30;
		ZestawNaprawczy_Warning[playerid] = 0;
		DeletePVar(playerid, "Use_ZestawNaprawczy");
		return 1;
	}
	if (ZestawNaprawczy_Timer[playerid] > 0)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, pos[0], pos[1], pos[2]))
		{
			format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Pozostalo %ds", ZestawNaprawczy_Timer[playerid]);
			GameTextForPlayer(playerid, string, 2500, 3);
			SetPlayerChatBubble(playerid, "** naprawia pojazd **", COLOR_PURPLE, 30.0, 2500);
			ZestawNaprawczy_Timer[playerid]--;
			ZestawNaprawczy_Warning[playerid] = 0;
			SetTimerEx("ZestawNaprawczy_CountDown", 1000, false, "ii", playerid, vehicleid);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, pos[0], pos[1], pos[2]))
		{
			format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~r~Podejdz do auta! %ds", 8-ZestawNaprawczy_Warning[playerid]);
			GameTextForPlayer(playerid, string, 2500, 3);
			ZestawNaprawczy_Warning[playerid]++;
			SetTimerEx("ZestawNaprawczy_CountDown", 1000, false, "ii", playerid, vehicleid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_PANICRED, "* [ZESTAW NAPRAWCZY] Anulowano napraw� pojazdu. Nie by�e� w dostatecznie blisko pojazdu.");
			ZestawNaprawczy_Timer[playerid] = 30;
			ZestawNaprawczy_Warning[playerid] = 0;
			DeletePVar(playerid, "Use_ZestawNaprawczy");
		}
	}
	else
	{
		GameTextForPlayer(playerid, "~g~Naprawiono!", 2500, 6);
		ZestawNaprawczy_Timer[playerid] = 30;
		ZestawNaprawczy_Warning[playerid] = 0;
		PlayerInfo[playerid][pFixKit]--;
		RepairVehicle(vehicleid);
        SetVehicleHealth(vehicleid, 1000);
		CarData[VehicleUID[vehicleid][vUID]][c_HP] = 1000.0;
		DeletePVar(playerid, "Use_ZestawNaprawczy");
	}
	return 1;
}

public CountDownVehsRespawn()
{
	if (Count > 0)
	{
		new text[56];
		format(text, sizeof text, "respawn za ~g~%d", Count-1);
		GameTextForAll(text, 2500, 1);
		if(Count % 5 == 0) SoundForAll(1056);
		Count--;
		SetTimer("CountDownVehsRespawn", 1000, 0);
	}
	else
	{	
		SoundForAll(1057);
		GameTextForAll("~g~Respawn", 2500, 1);
		SendClientMessageToAll(COLOR_PANICRED, "|___Nast�pi� respawn nieu�ywanych pojazd�w___|");
		Count = 20;
		new bool:used[CAR_AMOUNT] = {false, ... };
		for(new p = 0; p<MAX_PLAYERS; p++)
		{
			if(IsPlayerConnected(p))
			{
				if(IsPlayerInAnyVehicle(p))
				{
					new veh = GetPlayerVehicleID(p);
					used[veh] = true;
				}
			}
		}
		for(new v; v < MAX_VEHICLES; v++)
		{
			if(!used[v])
			{
				if(NoRespawn[v]) 
				{
					NoRespawn[v] = 0;
					continue;
				}
				new lID = VehicleUID[v][vUID];
			    RespawnVehicleEx(v);
			    if(vSigny[v] == 1) 
			    {
			    	DestroyDynamic3DTextLabel(vSignyText[v]);
			    	vSigny[v] = 0;
			    }
			    if(Car_GetOwnerType(v) == CAR_OWNER_PLAYER)
			    {
                    Car_Unspawn(v);
	            } else {
	            	Gas[v] = 100;
	            	SetVehicleVirtualWorld(v, CarData[lID][c_VW]);
	            	LinkVehicleToInterior(v, CarData[lID][c_Int]);
	            }
				
			}
		}
	}
}

public Odmroz(playerid)
{
    TogglePlayerControllable(playerid, 1);
    return 1;
}

public Wchodzenie(playerid) //Zmiana na inteligentny system odmra�ania
{
    if(GetPVarInt(playerid, "enter-check") == 0)
    {
        TogglePlayerControllable(playerid, 0);
        SetPVarInt(playerid, "enter-check", 1);
        SetPVarInt(playerid, "enter-nowobj", 0);
        SetPVarInt(playerid, "enter-stuffobj", 0);
        SetPVarInt(playerid, "enter-stuff", 0);
        SetPVarInt(playerid, "enter-oldvw", GetPVarInt(playerid, "enter-vw"));
        SetPVarInt(playerid, "enter-vw", GetPlayerVirtualWorld(playerid));
        SetPVarInt(playerid, "enter-time", gettime());
    }
    else
    {
        new count = Streamer_CountVisibleItems(playerid, STREAMER_TYPE_OBJECT);
        if( ((count >= GetPVarInt(playerid, "enter-nowobj")) && GetPVarInt(playerid, "enter-nowobj") != 0) || (count > 0 && GetPVarInt(playerid, "enter-oldvw") == GetPVarInt(playerid, "enter-vw")) || (GetPVarInt(playerid, "enter-nowobj") >= count)) //obj wczytane
        {
            TogglePlayerControllable(playerid, 1);
            SetPVarInt(playerid, "enter-check", 0);
            if(GetPVarInt(playerid, "enter-stuff") != 0) DestroyDynamicObject(GetPVarInt(playerid, "enter-stuffobj"));
            return 1;
        }
        else if(GetPVarInt(playerid, "enter-nowobj") == 0) //check lag
        {
            if(GetPVarInt(playerid, "enter-stuff") == 0)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                SetPVarInt(playerid, "enter-stuffobj", CreateDynamicObject(19300, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid));
                SetPVarInt(playerid, "enter-stuff", 1);
                Streamer_Update(playerid);
            }
        }
        else
        {
            TogglePlayerControllable(playerid, 1);
            SetPVarInt(playerid, "enter-check", 0);
            new str[128];
            SendClientMessage(playerid, -1, "(OBJ LOADER Inteligencja) - B��d z wczytaniem obiekt�w, nie mo�na doda� nowych - zg�os to z debugiem:");
            format(str, 128, "CHK |%d| NowOBJ |%d| Stuff |%d:%d| VW.o |%d| VW.n |%d| T |%d| T.n |%d| T.s |%d| Count |%d|", GetPVarInt(playerid, "enter-check"),GetPVarInt(playerid, "enter-nowobj"),GetPVarInt(playerid, "enter-stuffobj"),GetPVarInt(playerid, "enter-stuff"),GetPVarInt(playerid, "enter-oldvw"),GetPVarInt(playerid, "enter-vw"),GetPVarInt(playerid, "enter-time"), gettime(), gettime()-GetPVarInt(playerid, "enter-time"),count);
            SendClientMessage(playerid, -1, str);
            printf("(OBJ LOADER Inteligencja) FAIL [%d]! CHK |%d| NowOBJ |%d| Stuff |%d:%d| VW.o |%d| VW.n |%d| T |%d| T.n |%d| T.s |%d| Count |%d|", playerid, GetPVarInt(playerid, "enter-check"),GetPVarInt(playerid, "enter-nowobj"),GetPVarInt(playerid, "enter-stuffobj"),GetPVarInt(playerid, "enter-stuff"),GetPVarInt(playerid, "enter-oldvw"),GetPVarInt(playerid, "enter-vw"),GetPVarInt(playerid, "enter-time"), gettime(), gettime()-GetPVarInt(playerid, "enter-time"),count);
            if(GetPVarInt(playerid, "enter-stuff") != 0) DestroyDynamicObject(GetPVarInt(playerid, "enter-stuffobj"));
        }
        SetPVarInt(playerid, "enter-nowobj", count);
    }
    SetTimerEx("Wchodzenie", 1800, 0, "i", playerid);
    return 1;
}
public freezuj(playerid){
TogglePlayerControllable(playerid, 0);
return 1;
}

public ZamykanieDrzwi(playerid){
TogglePlayerControllable(playerid, 1);
PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0);
PlayerInfo[playerid][pDrzwibusazamkniete]=1;
GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~g~Drzwi zamkniete!", 4000, 3);
return 1;
}

public AntySB(playerid)
{
	AntySpawnBroni[playerid] = 0;
	return 1;
}

public TiNzPJwGUI(playerid)
{
	new playername[MAX_PLAYER_NAME];
	new string [256];
	PlayerInfo[playerid][pPrawojazdydobreodp] = 0;
	PlayerInfo[playerid][pPrawojazdypytania] = 0;
	PlayerInfo[playerid][pWtrakcietestprawa] = 0;
	PlayerInfo[playerid][pMinalczasnazdpr] = 1;
	PlayerInfo[playerid][pSprawdzczyzdalprawko] = 0;
	GetPlayerName(playerid, playername, sizeof(playername));
	format(string, sizeof(string), "* S�ycha� d�wi�k ko�ca czasu na rozwi�znie testu ((%s))", playername);
	ProxDetector(40.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	ShowPlayerDialogEx(playerid, 13, DIALOG_STYLE_MSGBOX, "Czas min��!", "Przykro nam!\nUp�yn� czas na udzielenie poprawnej odpowiedzi.\nOblewasz egzamin i mo�esz go zda� ponownie za 2h.", "Wyjdz", "");
	return 1;
}
public Naprawianie(playerid){
naprawiony[playerid] = 0;
return 1;
}

public KickEx(playerid)
{
	SetTimerEx("KickExTimer",250,0,"d",playerid);
	return 1;
}

public Banicja(playerid)
{
	SetTimerEx("BanExTimer",250,0,"d",playerid);
	return 1;
}

public KickExTimer(playerid)
{
	print("#1 HERE (NPC TEST)");
	Kick(playerid);
	return 1;
}

public BanExTimer(playerid)
{
	print("#2 HERE (NPC TEST)");
	if(IsPlayerConnected(playerid)) Ban(playerid);
	return 1;
}

public Matsowanie(playerid){
MatsGood[playerid] = 0;
return 1;
}

public pobito(playerid){
pobilem[playerid] = 0;
PlayerInfo[playerid][pMuted] = 0;
return 1;
}

public togczastimer(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    new mtext[20], string[256];
		new year, month,day;
		getdate(year, month, day);
		if(month == 1) { mtext = "Styczen"; }
		else if(month == 2) { mtext = "Luty"; }
		else if(month == 3) { mtext = "Marzec"; }
		else if(month == 4) { mtext = "Kwiecien"; }
		else if(month == 5) { mtext = "Maj"; }
		else if(month == 6) { mtext = "Czerwiec"; }
		else if(month == 7) { mtext = "Lipiec"; }
		else if(month == 8) { mtext = "Sierpien"; }
		else if(month == 9) { mtext = "Wrzesien"; }
		else if(month == 10) { mtext = "Pazdziernik"; }
		else if(month == 11) { mtext = "Listopad"; }
		else if(month == 12) { mtext = "Grudzien"; }
	    new hour,minuite,second;
		gettime(hour,minuite,second);
		FixHour(hour);
		hour = shifthour;
		if (minuite < 10)
		{
			if (PlayerInfo[playerid][pJailTime] > 0)
			{
				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:0%d~g~|~n~~w~Czas Aresztu: %d sek", day, mtext, hour, minuite, PlayerInfo[playerid][pJailTime]-10);
			}
			else
			{
				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:0%d~g~|", day, mtext, hour, minuite);
			}
		}
		else
		{
			if (PlayerInfo[playerid][pJailTime] > 0)
			{
				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:%d~g~|~n~~w~Czas Aresztu: %d sec", day, mtext, hour, minuite, PlayerInfo[playerid][pJailTime]-10);
			}
			else
			{
				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:%d~g~|", day, mtext, hour, minuite);
			}
		}
		GameTextForPlayer(playerid, string, 5000, 1);
	}
	return 1;
}

public naczasbicie(playerid, playerid_atak){
	zdazylwpisac[playerid] = 0;
	TogglePlayerControllable(playerid_atak, 1);
	ClearAnimations(playerid_atak);
	SendClientMessage(playerid_atak, COLOR_NEWS, "Wygra�e� bitw� poniewa� broni�cy za d�ugo wpisywa� znaki!");
	KillTimer(GetPVarInt(playerid, "timerBicia"));
	return 1;
}

public UzyteKajdany(playerid){
Kajdanki_Uzyte[playerid] = 0;
return 1;
}

OdkujKajdanki(playerid)
{
	if(Kajdanki_PDkuje[playerid] != INVALID_PLAYER_ID)
	{
		new giveplayerid = Kajdanki_PDkuje[playerid]; //id policjanta
		Kajdanki_PDkuje[giveplayerid] = INVALID_PLAYER_ID;
		Kajdanki_Uzyte[giveplayerid] = 0;
		Kajdanki_SkutyGracz[giveplayerid] = INVALID_PLAYER_ID;
		Kajdanki_JestemSkuty[giveplayerid] = 0;
	}
	Kajdanki_PDkuje[playerid] = INVALID_PLAYER_ID;
	Kajdanki_Uzyte[playerid] = 0;
	Kajdanki_SkutyGracz[playerid] = INVALID_PLAYER_ID;
	Kajdanki_JestemSkuty[playerid] = 0;
	ClearAnimations(playerid);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
}

public spamujewl(playerid){
spamwl[playerid] = 0;
return 1;
}


public AntySpamMechanik(playerid){
SpamujeMechanik[playerid] = 0;
return 1;
}

public PoscigTimer(playerid){
poscig[playerid] = 0;
SendClientMessage(playerid,COLOR_PANICRED,"|_________________Tryb Po�cigu ZAKO�CZONY_________________|");
SendClientMessage(playerid,COLOR_WHITE,"Czas na z�apanie ci� dobieg� ko�ca.");
SendClientMessage(playerid,COLOR_WHITE,"Je�eli nie przeprowadzasz ju� �adnej akcji RP, mo�esz bezpiecznie wyj�� z gry");
SendClientMessage(playerid,COLOR_PANICRED,"|______________________________________________|");
return 1;
}

public AntySpamTimer(playerid){
AntySpam[playerid] = 0;
return 1;
}

public AntyBusCzit(playerid){
BusCzit[playerid] = 0;
return 1;
}

public spamujebronia(playerid){
zmatsowany[playerid] = 0;
return 1;
}

public odpalanie(playerid)
{
	new engine, lights, alarm, doors, bonnet, boot, objective, Float:health, sendername[MAX_PLAYER_NAME], string[256];
	new carid = GetPlayerVehicleID(playerid);
	GetPlayerName(playerid, sendername, sizeof(sendername));
	GetVehicleHealth(carid, health);
 	GetVehicleParamsEx(carid,engine, lights ,alarm, doors, bonnet, boot, objective);
 	OdpalanieSpam[playerid] = 0;
	if(Gas[carid] > 3)
	{
		new rand = random(1000);
		if(rand <= health)
		{
			format(string, sizeof(string), "* silnik odpali� (( %s ))", sendername);
			ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
      		SetVehicleParamsEx(carid , 1, lights, alarm, doors, bonnet, boot, objective);
			if(PlayerInfo[playerid][pTurnedOnCarWithoutCarLic] != carid && PlayerInfo[playerid][pCarLic] == 0)
			{
				PlayerInfo[playerid][pTurnedOnCarWithoutCarLic] = carid;
			}
		}
		else
		{
		    format(string, sizeof(string), "* silnik nie odpali� (( %s ))", sendername);
			ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	else
	{
	 	format(string, sizeof(string), "* na desce rozdzielczej pojawia si� informacja o braku paliwa (( %s ))", sendername);
		ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	return 1;
}
//SYSTEM KRADZIEZY AUT!

public KradziezAut() //nowy system
{
	foreach(new i : Player)
	{
		if(GetPlayerState(i) != PLAYER_STATE_DRIVER || Car_IsValid(GetPlayerVehicleID(i))) continue;
		if(KradniecieWozu[i] != INVALID_VEHICLE_ID || KradziezEtap[i] == 0 || KradziezTick[i] > gettime()) continue;
		new komunikat[128];
		switch(KradziezEtap[i])
		{
			case 1:
			{
				format(komunikat, sizeof(komunikat), "* %s ��czy kabelki i wyjmuje �rubokr�t i odkr�ca nast�pn� os�onk�.", GetNick(i));
				ProxDetector(20.0, i, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				KradziezTick[i] = gettime()+6;
				KradziezEtap[i] = 2;
			}
			case 2:
			{
				format(komunikat, sizeof(komunikat), "* %s wyjmuje 4 kolorowe kabelki.", GetNick(i));
    			ProxDetector(20.0, i, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				KradziezTick[i] = gettime()+6;
				KradziezEtap[i] = 3;
			}
			case 3:
			{
				new skillz;
				if(PlayerInfo[i][pJackSkill] < 50)
					skillz = 1;
				else if(PlayerInfo[i][pJackSkill] >= 50 && PlayerInfo[i][pJackSkill] <= 99)
					skillz = 2;
				else if(PlayerInfo[i][pJackSkill] >= 100 && PlayerInfo[i][pJackSkill] <= 199)
					skillz = 3;
				else if(PlayerInfo[i][pJackSkill] >= 200 && PlayerInfo[i][pJackSkill] <= 399)
					skillz = 4;
				else if(PlayerInfo[i][pJackSkill] >= 400)
					skillz = 5;
				new kradnij = random(100);
				new mnoznik = skillz*19;
				if(kradnij <= mnoznik)
				{
					format(komunikat, sizeof(komunikat), "* %s ��czy odpowiednie kabelki i wy��czy� alarm.", GetNick(i));
					ProxDetector(20.0, i, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					TogglePlayerControllable(i, 1);
					new carid = GetPlayerVehicleID(i); 
					if(Gas[carid] <= 10) Gas[carid] += 15;
					NieSpamujKradnij[i] = 0;
					SendClientMessage(i, COLOR_GRAD2, "Skill z�odzieja aut +1");
					PlayerInfo[i][pJackSkill] ++;
					KradniecieWozu[i] = GetPlayerVehicleID(i);
					Iter_Add(StolenVehicles[i], carid);
					if(PlayerInfo[i][pJackSkill] == 50)
					{ SendClientMessage(i, COLOR_YELLOW, "* Tw�j skill z�odzieja samochod�w wynosi teraz 2, masz teraz wi�ksze szanse �e uda ci si� ukra�� w�z."); }
					else if(PlayerInfo[i][pJackSkill] == 100)
					{ SendClientMessage(i, COLOR_YELLOW, "* Tw�j skill z�odzieja samochod�w wynosi teraz 3, masz teraz wi�ksze szanse �e uda ci si� ukra�� w�z."); }
					else if(PlayerInfo[i][pJackSkill] == 200)
					{ SendClientMessage(i, COLOR_YELLOW, "* Tw�j skill z�odzieja samochod�w wynosi teraz 4, masz teraz wi�ksze szanse �e uda ci si� ukra�� w�z."); }
					else if(PlayerInfo[i][pJackSkill] == 400)
					{ SendClientMessage(i, COLOR_YELLOW, "* Tw�j skill z�odzieja samochod�w wynosi teraz 5, masz teraz wi�ksze szanse �e uda ci si� ukra�� w�z."); }
				}
				else
				{
					new vehi = GetPlayerVehicleID(i);
					new engine, lights, alarm, doors, bonnet, boot, objective;
					format(komunikat, sizeof(komunikat), "* %s �le ��czy kabelki po czym w��cza si� alarm.", GetNick(i));
					ProxDetector(20.0, i, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					GetVehicleParamsEx(vehi, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehi, engine, lights, true, doors, bonnet, boot, objective);
					SetTimerEx("WylaczAlarm", 90000, false, "d", vehi);
					SendClientMessage(i, COLOR_PANICRED, "Zaraz tu b�d� gliny! Uciekaj!");
					TogglePlayerControllable(i, 1);
					RemovePlayerFromVehicleEx(i);
					KradniecieWozu[i] = 0;
					NieSpamujKradnij[i] = 0;
					new pZone[MAX_ZONE_NAME];
					GetPlayer2DZone(i, pZone, MAX_ZONE_NAME);
					format(komunikat, sizeof(komunikat), "HQ: Zg�oszono pr�b� kradzie�y %s na %s.", VehicleNames[GetVehicleModel(vehi)-400], pZone);
					SendRadioMessage(FRAC_LSPD, COLOR_LIGHTRED, komunikat, 0);
				}
				KradziezTick[i] = 0;
				KradziezEtap[i] = 0;
			}
		}
	}
	return 1;
}

public WylaczAlarm(vehi)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehi, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehi, engine, lights, false, doors, bonnet, boot, objective);
}

//KONIEC SYSTEMU KRADZIEZY WAUT

public UsuwanieBroniReset(playerid){
PrzywrocBron(playerid);
return 1;
}

public Odlicz(wyscig){
if(Wodliczanie == 3)
{
    foreach(new i : Player)
   	{
    	if(ScigaSie[i] == wyscig)
	    {
	        SetPlayerRaceCheckpoint(i,Wyscig[wyscig][wTypCH],wCheckpoint[wyscig][1][0], wCheckpoint[wyscig][1][1], wCheckpoint[wyscig][1][2],wCheckpoint[wyscig][2][0], wCheckpoint[wyscig][2][1], wCheckpoint[wyscig][2][2], 10);
			TogglePlayerControllable(i, 1);
			GameTextForPlayer(i, "~r~GO!", 2500, 4);
			Wodliczanie = 0;
			IloscCH[i] = 1;
			PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
		}
	}
}
else
{
    new string[12];
    foreach(new i : Player)
   	{
    	if(ScigaSie[i] == wyscig)
	    {
		    format(string, sizeof(string), "~g~%d", (3-Wodliczanie));
		    GameTextForPlayer(i, string, 1000, 4);
		    PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
        }
	}
	Wodliczanie++;
 	SetTimerEx("Odlicz",1000,0,"d",wyscig);
}
return 1;
}


KoniecWyscigu(playerid)
{
	new string[256];
	if(playerid == -1)
		format(string, sizeof(string), "Komunikat wy�cigowy: {FFFFFF}Wyscig %s zako�czony przez system.", Wyscig[Scigamy][wNazwa]);
	else if(playerid == -2)
		format(string, sizeof(string), "Komunikat wy�cigowy: {FFFFFF}Wyscig %s zako�czony - wszyscy dojechali do mety!", Wyscig[Scigamy][wNazwa]);
	else
		format(string, sizeof(string), "Komunikat wy�cigowy: {FFFFFF}Wyscig %s zako�czony przez %s.", Wyscig[Scigamy][wNazwa], GetNickEx(playerid));

	WyscigMessage(COLOR_YELLOW, string);

	foreach(new i : Player)
	{
		if(ScigaSie[i] != 666)
		{
		    DisablePlayerRaceCheckpoint(i);
		    SendClientMessage(i, COLOR_YELLOW, "Koniec wyscigu");
		    ScigaSie[i] = 666;
		    IloscCH[i] = 0;
		}
	}
	IloscZawodnikow = 0;
	Ukonczyl = 1;
	Scigamy = 666;
	return 1;
}

strreplace2(string[], find, replace)
{
    for(new i=0; string[i]; i++)
    {
        if(string[i] == find)
        {
            string[i] = replace;
        }
    }
}

public CleanPlayaPointsPJ(playerid)
{
PlayerInfo[playerid][pPrawojazdypytania] = 0;
PlayerInfo[playerid][pPrawojazdydobreodp] = 0;
return 1;
}

PrawoJazdyRandomGUITest(playerid, questions_available[], questions_count)
{
    new questions_ids[] = {3, 4, 5, 6, 7, 8, 9, 10, 21};
    new questions_content[][] =
    {
        "Jaki jest poprawny numer alarmowy?\n\nPodaj w cyfrach",
        "Czy nitro jest dozwolone?\n\nTak/Nie",
        "Ile wynosi dopuszczalna pr�dko��\nprzy holowaniu w terenie zabudowanym?\n\nPodaj w cyfrach",
        "Kt�r� stron� jezdni nale�y jecha�?\n\nPodaj jeden wyraz",
        "Co nale�y rozstawi� po wypadku?\n\nPodaj jeden wyraz",
        "Dozwolona pr�dko�� na autostradzie?\n\nPodaj w cyfrach",
        "Dozwolona pr�dko�� na mie�cie?\n\nPodaj w cyfrach",
        "Jaka jest maksymalna, dozwolona\npr�dko�� na drodze szybkiego ruchu?\n\nPodaj w cyfrach",
        "Co trzeba wyci�gn�� po wypadku\nby ostrzec o nim?\n\nPodaj jeden wyraz"
    };

    new random_question = random(questions_count);
    new random_question_id = questions_available[random_question];

    for(new i = random_question; i < questions_count - 1; i++)
    {
        questions_available[i] = questions_available[i+1];
    }

    ShowPlayerDialogEx(playerid, questions_ids[random_question_id], DIALOG_STYLE_INPUT, "Prawo Jazdy", questions_content[random_question_id], "Dalej", "");
    TiPJTGBKubi[playerid] = SetTimerEx("TiNzPJwGUI", 30000, 0, "i", playerid);
    return 1;
}

public Wywalonyzdmv(playerid){
wywalzdmv[playerid] = 0;
GameTextForPlayer(playerid, "~r~Mozesz juz wchodzic do dmv", 5000, 1);
return 1;
}

public ZlyKodUn(playerid){
AntyWlamSejf[playerid] = 0;
return 1;
}

public OgladanieDOM(playerid){
	new deem = PlayerInfo[playerid][pDomWKJ];
	if(PlayerInfo[playerid][pDomWKJ] != 0)
	{
		SetPlayerPos(playerid, Dom[deem][hWej_X], Dom[deem][hWej_Y], Dom[deem][hWej_Z]);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		PlayerInfo[playerid][pDomWKJ] = 0;
		SetServerWeatherAndTime(playerid);
	}
	if(isNaked[playerid])
	{
		UndressPlayer(playerid, false); 
	}
	GameTextForPlayer(playerid, "~r~Koniec czasu, zakup ten dom!", 5000, 1);
	DomOgladany[playerid] = 1;

	SetTimerEx("CzasOgladaniaDOM", 180000,0,"d",playerid);
	return 1;
}

public CzasOgladaniaDOM(playerid){
	DomOgladany[playerid] = 0;
	GameTextForPlayer(playerid, "~g~Znow mozesz obejrzec dom", 5000, 1);
	return 1;
}

public RSPAWN(playerid){
SetCameraBehindPlayer(playerid);
return 1;
}

public SzukanieAuta(playerid){
DisablePlayerCheckpoint(playerid);
return 1;
}

public TablicaWynikow(playerid)
{
	foreach(new i : Player)
	{
		if(IsPlayerInRangeOfPoint(i, 500, -1106.9854, -966.4719, 129.1807))
		{
			SendClientMessage(i, COLOR_LIGHTGREEN, "Tabela wynik�w:");
            foreach(new di : Player)
			{
			    if(zawodnik[di] == 1)
			    {
			        if(okregi[di] >= 1)
			        {
			            new iplayer[MAX_PLAYER_NAME];
			            new string[256];
				        GetPlayerName(di, iplayer, sizeof(iplayer));
				        format(string, sizeof(string), "%s - %d okr��e�", iplayer, okregi[di]);
						SendClientMessage(i, COLOR_WHITE, string);
					}
			    }
			}
		}
	}
	if(wyscigz == 1)
	{
		SetTimerEx("TablicaWynikow",30000,0,"d",playerid);
	}
}

//Osobno
public AutodbzesRH(playerid)
{
	PlayerInfo[playerid][pRockHotelPuAc]=0;
	return 0;
}

GetPlayer2DZone(playerid, zone[], len)
{
	if(PlayerInfo[playerid][pJailed] == 3) 
	{
		return format(zone, len, "Nieznane ((AJ))", 0);
	}
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}
stock UndressPlayer(playerid, bool:dressup, colorID=0)
{
	new string[124];
	if(dressup)
	{
		SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]); 
        isNaked[playerid] = 0;
        format(string, sizeof(string), "%s ubiera si�.", GetNick(playerid)); 
        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else
	{
		if(PlayerInfo[playerid][pSex] == 2)
        {
            if(colorID == 1)
            {
                SetPlayerSkinEx(playerid, 20001);
            }
            else
            {
                SetPlayerSkinEx(playerid, 20002); 
            }
        }
        else
        {
            if(colorID == 1)
            {
                SetPlayerSkinEx(playerid, 252);
            }
            else
            {
                SetPlayerSkinEx(playerid, 18); 
            }
        }
        format(string, sizeof(string), "%s rozbiera si�.", GetNick(playerid)); 
        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        sendTipMessage(playerid, "Aby ubra� si� spowrotem, ponownie u�yj komendy /rozbierz.");
        isNaked[playerid] = 1; 
	}
	return 1;
}
stock IsVehicleInRangeOfPoint(vehicleid,Float:range,Float:x,Float:y,Float:z)
{
    if(vehicleid == INVALID_VEHICLE_ID) return 0;
    
    new Float:DistantaCar = GetVehicleDistanceFromPoint(vehicleid, x, y, z);
    
    if(DistantaCar <= range) return 1;
    return 0;
} 

stock GetNickEx(playerid, withmask = false)
{
	new nick[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, nick, sizeof(nick));
	if(withmask)
	{
		return nick;
	}
	else
	{
		new nick2[24];
		if(GetPVarString(playerid, "maska_nick", nick2, 24))
		{
			return nick2;
		}
	}
	return nick;
}
stock GetNick(playerid)
{
	new nick[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, nick, sizeof(nick));
	return nick;
}
stock GetIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}

FindPlayerByNumber(number)
{
	foreach(new i : Player)
	{
		if(GetPhoneNumber(i) == number)
			return i;
	}
	return INVALID_PLAYER_ID;
}

Kostka_Wygrana(playerid, loser, kasa, bool:quit=false)
{
    //Kilka sprawdze�
    if(!quit && !IsPlayerConnected(loser)) return 0;
    if(strlen(GetNick(loser)) < 4) return 0;
    if(strlen(GetNick(playerid)) < 4) return 0;

    new podatek = floatround(kasa*0.05); //tutaj do sejfu 5% podatku
    DajKaseDone(playerid, kasa-podatek);
    if(quit)
    {
        SetPVarInt(playerid, "kostka",0);
        SetPVarInt(playerid, "kostka-throw", 0);
        SetPVarInt(playerid, "kostka-suma", 0);
        SetPVarInt(playerid, "kostka-cash", 0);
        SetPVarInt(playerid, "kostka-first", 0);
        SetPVarInt(playerid, "kostka-rzut", 0);
        SetPVarInt(playerid, "kostka-wait", 0);
        SetPVarInt(playerid, "kostka-player", 0);
    }
    Log(payLog, WARNING, "%s wygra� rzuty kostk� z %s na kwot� %d$ %s", GetPlayerLogName(playerid), GetPlayerLogName(loser), kasa, quit ? "(quit)" : "");
    Sejf_Add(11, podatek);


    return 1;
}
//system barierek by Kubi
GetNumberOfPages()
{
	if((gTotalItems >= SELECTION_ITEMS) && (gTotalItems % SELECTION_ITEMS) == 0)
	{
		return (gTotalItems / SELECTION_ITEMS);
	}
	else return (gTotalItems / SELECTION_ITEMS) + 1;
}

PlayerText:CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
   	PlayerTextDrawBoxColor(playerid, txtInit, 0x00000066);
   	PlayerTextDrawBackgroundColor(playerid, txtInit, 0x00000066);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 3.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------

PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 1.25, 3.0);
	PlayerTextDrawFont(playerid, txtInit, 0);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------

PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
	new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos,
	"                                 ~n~");
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawAlignment(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, 0x00215D77);
	PlayerTextDrawLetterSize(playerid, txtBackground, 0.0, Height/10);
	PlayerTextDrawFont(playerid, txtBackground, 1);
	PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground,-1);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, 0.0);
   	PlayerTextDrawBackgroundColor(playerid, txtBackground, 255);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}

//------------------------------------------------

PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, "");
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x00000066);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height);
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, -16.0, 0.0, -55.0);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

//------------------------------------------------

DestroyPlayerModelPreviews(playerid)
{
	new x=0;
	while(x != SELECTION_ITEMS) {
	    if(gSelectionItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gSelectionItems[playerid][x]);
			gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
		x++;
	}
}

//------------------------------------------------

ShowPlayerModelPreviews(playerid)
{
    new x=0;
	new Float:BaseX = DIALOG_BASE_X;
	new Float:BaseY = DIALOG_BASE_Y - (SPRITE_DIM_Y * 0.33);
	new linetracker = 0;

	new itemat = GetPVarInt(playerid, "gatechose_page") * SELECTION_ITEMS;

	DestroyPlayerModelPreviews(playerid);

	while(x != SELECTION_ITEMS && itemat < gTotalItems) {
	    if(linetracker == 0) {
	        BaseX = DIALOG_BASE_X + 25.0;
	        BaseY += SPRITE_DIM_Y + 1.0;
		}
  		gSelectionItems[playerid][x] = CreateModelPreviewTextDraw(playerid, gItemList[itemat], BaseX, BaseY, SPRITE_DIM_X, SPRITE_DIM_Y);
  		gSelectionItemsTag[playerid][x] = gItemList[itemat];
		BaseX += SPRITE_DIM_X + 1.0;
		linetracker++;
		if(linetracker == ITEMS_PER_LINE) linetracker = 0;
		itemat++;
		x++;
	}
}

//------------------------------------------------

UpdatePageTextDraw(playerid)
{
	new PageText[64+1];
	format(PageText, 64, "%d/%d", GetPVarInt(playerid,"gatechose_page") + 1, GetNumberOfPages());
	PlayerTextDrawSetString(playerid, gCurrentPageTextDrawId[playerid], PageText);
}

//------------------------------------------------

CreateSelectionMenu(playerid)
{
    gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y + 20.0, DIALOG_WIDTH, DIALOG_HEIGHT);
    gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, HEADER_TEXT);
    gCurrentPageTextDrawId[playerid] = CreateCurrentPageTextDraw(playerid, DIALOG_WIDTH - 95.0, DIALOG_BASE_Y+(DIALOG_HEIGHT/3)+108.0);
    gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH+1, DIALOG_BASE_Y+(DIALOG_HEIGHT/2), 25.0, 36.0, NEXT_TEXT);
    gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_BASE_X-1, DIALOG_BASE_Y+(DIALOG_HEIGHT/2), 25.0, 36.0, PREV_TEXT);

    ShowPlayerModelPreviews(playerid);
    UpdatePageTextDraw(playerid);
}

//------------------------------------------------

DestroySelectionMenu(playerid)
{
	DestroyPlayerModelPreviews(playerid);

	PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gCurrentPageTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);

	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

GetBarierID(frac)
{
    new id=-1;
    for(new i=0;i<10;i++)
    {
        if(!BarierState[frac][i])
        {
            id = i;
            break;
        }
    }
    return id;
}
HandlePlayerItemSelection(playerid, selecteditem)
{
    new frac = GetPVarInt(playerid, "gategroup");
    new id = GetBarierID(frac); //FRAKCJA!!

    if(id == -1) return SendClientMessage(playerid, -1, "Osi�gni�to limit barierek.");

    new Float:x, Float:y, Float:z, Float:a, vw;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    SetPlayerPos(playerid, x, y, z+0.2);
	vw = GetPlayerVirtualWorld(playerid);
    x+=2*floatsin(-a, degrees);
    y+=2*floatcos(-a, degrees);

    BARIERKA_Create(frac, id, gSelectionItemsTag[playerid][selecteditem], x, y, z-0.5, a, vw);

    SetPVarInt(playerid, "Barier-id", id+1);
    SetTimerEx("EditObj", 500, 0, "ii", playerid, Barier[frac][id]);
    return 1;
}

BARIERKA_Create(frac, id, model, Float:x, Float:y, Float:z, Float:a, vw = 0)
{
	DestroyDynamicObject(Barier[frac][id]);
	new oid = CreateDynamicObject(model, x, y, z, 0.0, 0.0, a, vw);
	if(Barier[frac][id] != oid) printf("Object ID moved from %d to %d", Barier[frac][id], oid), Barier[frac][id] = oid;
	BarierState[frac][id] = true;
    return 1;
}

BARIERKA_Remove(frakcja, id)
{
    SetDynamicObjectPos(Barier[frakcja][id], 0.0, 0.0, -100.0);
    DestroyDynamic3DTextLabel(BarText[frakcja][id]);
    BarierState[frakcja][id] = false;
    return 1;
}

BARIERKA_Init()
{
    for(new j=0;j<=4;j++) //rodziny, LSPD, FBI, NG LSMC
    {
        for(new i=0;i<10;i++)
        {
            Barier[j][i] = CreateDynamicObject(19300, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
            BarierState[j][i] = false;
        }
    }
    for(new i=0;i<10;i++) //LSFD
    {
        Barier[FRAC_ERS][i] = CreateDynamicObject(19300, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
        BarierState[FRAC_ERS][i] = false;
    }
    for(new i=0;i<10;i++) //USSS
    {
        Barier[FRAC_BOR][i] = CreateDynamicObject(19300, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
        BarierState[FRAC_BOR][i] = false;
    }
    return 1;
}

public EditObj(playerid, obj)
{
    EditDynamicObject(playerid, obj);
}

SetPlayerWeatherEx(playerid, id)
{
    if(!(1 < id < 21)) return 1;
	SetPlayerWeather(playerid, id);
    SetPVarInt(playerid, "Weather", id);
    return 1;
}

SetWeatherEx(id)
{
    if(!(1 < id < 21) || id == 11 || id == 19) return 1;
	SetWeather(id);
	ServerWeather = id;
	return 1;
}


//koniec Mini Timery

//--------------------------------------------------------
//-----------------------[Funkcje:]-----------------------
//--------------------------------------------------------

split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}


Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

IsPlayerNear(playerid, giveplayerid, distance=10)
{
	return (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(giveplayerid) && 
		GetDistanceBetweenPlayers(playerid, giveplayerid) < distance && 
		Spectate[giveplayerid] == INVALID_PLAYER_ID
	);
}

SearchingHit(playerid)
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new searchhit = 0;
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(searchhit == 0)
		    {
			    if(PlayerInfo[i][pHeadValue] > 0 && GotHit[i] == 0 && !IsPlayerInGroup(i, 8))
			    {
			        GetPlayerName(i, giveplayer, sizeof(giveplayer));
			        searchhit = 1;
			        hitfound = 1;
			        hitmanid = i;
			        foreach(new k : Player)
					{
						if(IsPlayerConnected(k))
						{
				        	if(IsPlayerInGroup(k, 8) || PlayerInfo[k][pLider] == 8)
				        	{
	               				SendClientMessage(k, COLOR_WHITE, "|__________________ Hitman Agency News __________________|");
				                SendClientMessage(k, COLOR_DBLUE, "*** Wiadomo��: Nowe zlecenia s� ju� dost�pne. ***");
				                format(string, sizeof(string), "Osoba: %s   ID: %d   Kasa: $%d", giveplayer, i, PlayerInfo[i][pHeadValue]);
								SendClientMessage(k, COLOR_DBLUE, string);
								SendClientMessage(k, COLOR_YELLOW, "Wpisz Givehit [hitmanid], aby podpisa� kontrakt z hitmanem.");
								SendClientMessage(k, COLOR_WHITE, "|________________________________________________________|");
	      					}
					    }
					}
					return 0;
			    }
			}
		}
	}
	if(searchhit == 0)
	{
	    SendClientMessage(playerid, COLOR_GREY, "   Nie ma dost�pnych zlece� !");
	}
	return 0;
}

public PaintballEnded()//nowe domy biznes wa�ne
{
	new string[256];
	new name[MAX_PLAYER_NAME];
    foreach(new i : Player)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(PlayerPaintballing[i] != 0)
	        {
	            if(IsPlayerConnected(PaintballWinner))
	            {
	                GetPlayerName(PaintballWinner, name, sizeof(name));
	                format(string,sizeof(string), "** %s wygra� mecz Pintballa z %d trafieniami **",name,PaintballWinnerKills);
	                SendClientMessage(i, COLOR_WHITE, string);
	            }
	            ResetPlayerWeapons(i);
	            PlayerPaintballing[i] = 0;
	            SetPlayerPos(i, 1310.126586,-1367.812255,13.540800);
	        }
		}
	}
	AnnouncedPaintballRound = 0;
    PaintballRound = 0;
	return 1;
}


StartZuzling()
{
    foreach(new i : Player)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(zawodnik[i] == 1)
	        {
	            SendClientMessage(i, COLOR_GREEN, "Zielone �wiat�o, go go go !");
	            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
	            SetPlayerCheckpoint(i,-1083.2609,-1006.3092,128.9274,5.0);
	            okrazenia[i] = 0;
	        }
	    }
	}
}

DollahScoreUpdate()
{
	new LevScore;
	foreach(new i : Player)
	{
		LevScore = PlayerInfo[i][pLevel];
		SetPlayerScore(i, LevScore);
	}
	return 1;
}

rightStr(source[], len)
{
	new retval[MAX_STRING2], srclen;
	srclen = strlen(source);
	strmid(retval, source, srclen - len, srclen, MAX_STRING2);
	return retval;
}

IsAProductionServer()
{
	return dini_Exists("production.info");
}

IsAnInstructor(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_GOV))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_GOV))
				return 1;
		}
	}
	return 0;
}

IsARestauracja(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_RESTAURANT))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_RESTAURANT))
				return 1;
		}
	}
	return 0;
}

IsAPolicja(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_POLICE))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_POLICE))
				return 1;
		}
	}
	return 0;
}

IsAFakeKonto(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new nick[MAX_PLAYER_NAME];
		GetPlayerName(playerid, nick, sizeof(nick));
		if(strcmp(nick,"Gniewomir_Wonsz", false) == 0 || strcmp(nick,"Filemon_Paprotka", false) == 0 || strcmp(nick,"Julia_Wisefield", false) == 0)
		{
		    return 1;
		}
	
		new ip[32];
		GetPlayerIp(playerid,ip,sizeof(ip));
		if(strcmp(ip,"185.6.30.124", false) == 0)
		{
			return 1;
		}
	}
	return 0;
}

IsAPrzestepca(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_CRIMINAL))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_CRIMINAL))
				return 1;
		}
	}
	return 0;
}
IsAGang(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_GANG))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_GANG))
				return 1;
		}
	}
	return 0;
}
IsAMafia(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_MAFIA))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_MAFIA))
				return 1;
		}
	}
	return 0;
}
IsADilerBroni(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_GUNDEALER))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_GUNDEALER))
				return 1;
		}
	}
	return 0;
}
IsASklepZBronia(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_LEGALGUNDEALER))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_LEGALGUNDEALER))
				return 1;
		}
	}
	return 0;
}

IsAHA(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
	    if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_HITMAN))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_HITMAN))
				return 1;
		}
	}
	return 0;
}

IsPlayerInFraction(playerid, frac, adminlvl=-1)
{
    new leader = PlayerInfo[playerid][pLider];
    new member = PlayerInfo[playerid][pMember];
    if(member==frac || leader == frac) return 1;
	if(IsPlayerInGroup(playerid, frac)) return 1;
    else if(adminlvl != -1 && PlayerInfo[playerid][pAdmin] >= adminlvl) return 1;
	return 0;
}

IsAMechazordWarsztatowy(playerid)
{
	return IsANoA(playerid) || HasPerm(playerid, PERM_WARSZTAT);
}

IsAMedyk(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
	    if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_MEDIC))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_MEDIC))
				return 1;
		}
	}
	return 0;
}

IsAKt(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_TAXI))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_TAXI))
				return 1;
		}
	}
	return 0;
}


IsANoA(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
		if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_WARSZTAT))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_WARSZTAT))
				return 1;
		}
	}
	return 0;
}

IsAWyscigOrganizowany()
{
	foreach(new i : Player)
	{
		if(owyscig[i] != 666)
		{
			return i;
		}
	}
	return -1;
}

IsAWyscigTworzony()
{
	foreach(new i : Player)
	{
		if(tworzenietrasy[i] != 666)
		{
			return i;
		}
	}
	return -1;
}

IsAUrzednik(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
	   	if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_GOV))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_GOV))
				return 1;
		}
	}
	return 0;
}

IsABOR(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
	    if(duty)
		{
			if(GroupPlayerDutyPerm(playerid, PERM_BOR))
				return 1;
		}
		else
		{
			if(CheckPlayerPerm(playerid, PERM_BOR))
				return 1;
		}
	}
	return 0;
}

IsAFBI(playerid, duty = 1)
{
	if(IsPlayerConnected(playerid))
	{
	    if(duty && OnDuty[playerid] > 0)
		{
			if(OnDuty[playerid] == GetPlayerGroupSlot(playerid, FRAC_FBI))
				return 1;
		}
		else
		{
			if(IsPlayerInGroup(playerid, FRAC_FBI))
				return 1;
		}
	}
	return 0;
}

UsunBron(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		PlayerInfo[playerid][pGun0] = 0;//Pi�� lub kastet
		PlayerInfo[playerid][pGun1] = 0;//Bro� bia�a
		PlayerInfo[playerid][pGun2] = 0;//Pistolety
		PlayerInfo[playerid][pGun3] = 0;//Shotguny
		PlayerInfo[playerid][pGun4] = 0;//Bro� maszynowa
		PlayerInfo[playerid][pGun5] = 0;//Karabiny
		PlayerInfo[playerid][pGun6] = 0;//Snajperki
		PlayerInfo[playerid][pGun7] = 0;//Ci�ka bro�
		PlayerInfo[playerid][pGun8] = 0;//Bro� wybuchowa
		PlayerInfo[playerid][pGun9] = 0;//Sprej/Gasnica/Aparat
		PlayerInfo[playerid][pGun10] = 0;//Nietypowa bro� bia�a
		PlayerInfo[playerid][pGun11] = 0;//Spadochron
		PlayerInfo[playerid][pGun12] = 0;//Detonator
		PlayerInfo[playerid][pAmmo0] = 0;
		PlayerInfo[playerid][pAmmo1] = 0;
		PlayerInfo[playerid][pAmmo2] = 0;
		PlayerInfo[playerid][pAmmo3] = 0;
		PlayerInfo[playerid][pAmmo4] = 0;
		PlayerInfo[playerid][pAmmo5] = 0;
		PlayerInfo[playerid][pAmmo6] = 0;
		PlayerInfo[playerid][pAmmo7] = 0;
		PlayerInfo[playerid][pAmmo8] = 0;
		PlayerInfo[playerid][pAmmo9] = 0;
		PlayerInfo[playerid][pAmmo10] = 0;
		PlayerInfo[playerid][pAmmo11] = 0;
		PlayerInfo[playerid][pAmmo12] = 0;
		return 1;
	}
	return 0;
}
stock RemoveWeaponFromSlot(playerid, iWeaponSlot) 
{
    new wps[13][2];
    for(new i = 0; i < 13; i++) GetPlayerWeaponData(playerid, i, wps[i][0], wps[i][1]);

    wps[iWeaponSlot][0] = 0;

    ResetPlayerWeapons(playerid);

    for(new i = 0; i < 13; i++) GivePlayerWeapon(playerid, wps[i][0], wps[i][1]);

}


stock RemovePlayerWeaponsTemporarity(playerid) 
{
	ResetPlayerWeapons(playerid);
	SetPlayerArmedWeapon(playerid, 0);
	MyWeapon[playerid] = 0;
}

DajBronieFrakcyjne(playerid, grupa)
{
	if(grupa == -1) return 0;
	if(GroupHavePerm(grupa, PERM_POLICE))
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 3; PlayerInfo[playerid][pAmmo1] = 1;
	        playerWeapons[playerid][weaponLegal2] = 1;
	    }
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 50 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 207;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
	}
	else if(!strcmp(GroupInfo[grupa][g_ShortName], "FBol", true)) //fbi
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 3; PlayerInfo[playerid][pAmmo1] = 1;
	        playerWeapons[playerid][weaponLegal2] = 1;
	    }
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 50 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 207;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
	    if(PlayerInfo[playerid][pGun3] == 0 || PlayerInfo[playerid][pGun3] == 25 && PlayerInfo[playerid][pAmmo3] < 50 || PlayerInfo[playerid][pAmmo3] <= 5)
	    {
	        PlayerInfo[playerid][pGun3] = 25; PlayerInfo[playerid][pAmmo3] = 150;
	        playerWeapons[playerid][weaponLegal4] = 1;
	    }
	    if(PlayerInfo[playerid][pGun4] == 0 || PlayerInfo[playerid][pGun4] == 29 && PlayerInfo[playerid][pAmmo4] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun4] = 29; PlayerInfo[playerid][pAmmo4] = 1030;
	        playerWeapons[playerid][weaponLegal5] = 1;
	    }
	    if(PlayerInfo[playerid][pGun5] == 0 || PlayerInfo[playerid][pGun5] == 31 && PlayerInfo[playerid][pAmmo5] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun5] = 31; PlayerInfo[playerid][pAmmo5] = 730;
	        playerWeapons[playerid][weaponLegal6] = 1;
	    }
	    if(PlayerInfo[playerid][pGun6] == 0 || PlayerInfo[playerid][pGun6] == 33 && PlayerInfo[playerid][pAmmo6] < 20  || PlayerInfo[playerid][pAmmo4] <= 5)
	    {
	        PlayerInfo[playerid][pGun6] = 34; PlayerInfo[playerid][pAmmo6] = 69;
	        playerWeapons[playerid][weaponLegal7] = 1;
	    }
	    if(PlayerInfo[playerid][pGun8] == 0 || PlayerInfo[playerid][pGun8] == 17 && PlayerInfo[playerid][pAmmo8] < 10 || PlayerInfo[playerid][pAmmo8] <= 2)
	    {
	        PlayerInfo[playerid][pGun8] = 17; PlayerInfo[playerid][pAmmo8] = 20;
	        playerWeapons[playerid][weaponLegal9] = 1;
	    }
	    if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 41 && PlayerInfo[playerid][pAmmo9] < 500 || PlayerInfo[playerid][pAmmo9] <= 30)
	    {
	        PlayerInfo[playerid][pGun9] = 41; PlayerInfo[playerid][pAmmo9] = 10000;
	        playerWeapons[playerid][weaponLegal9] = 10;
	    }
	}
	else if(!strcmp(GroupInfo[grupa][g_ShortName], "NG", true))
	{
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 50 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 207;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
	    if(PlayerInfo[playerid][pGun3] == 0 || PlayerInfo[playerid][pGun3] == 25 && PlayerInfo[playerid][pAmmo3] < 50 || PlayerInfo[playerid][pAmmo3] <= 5)
	    {
	        PlayerInfo[playerid][pGun3] = 25; PlayerInfo[playerid][pAmmo3] = 150;
	        playerWeapons[playerid][weaponLegal4] = 1;
	    }
	    if(PlayerInfo[playerid][pGun4] == 0 || PlayerInfo[playerid][pGun4] == 29 && PlayerInfo[playerid][pAmmo4] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun4] = 29; PlayerInfo[playerid][pAmmo4] = 1030;
	        playerWeapons[playerid][weaponLegal5] = 1;
	    }
	    if(PlayerInfo[playerid][pGun5] == 0 || PlayerInfo[playerid][pGun5] == 31 && PlayerInfo[playerid][pAmmo5] < 200 || PlayerInfo[playerid][pAmmo5] <= 30)
	    {
	        PlayerInfo[playerid][pGun5] = 31; PlayerInfo[playerid][pAmmo5] = 730;
	        playerWeapons[playerid][weaponLegal6] = 1;
	    }
	    if(PlayerInfo[playerid][pGun6] == 0 || PlayerInfo[playerid][pGun6] == 33 && PlayerInfo[playerid][pAmmo6] < 20 || PlayerInfo[playerid][pAmmo6] <= 5)
	    {
	        PlayerInfo[playerid][pGun6] = 33; PlayerInfo[playerid][pAmmo6] = 50;
	        playerWeapons[playerid][weaponLegal7] = 1;
	    }
	    if(PlayerInfo[playerid][pGun8] == 0)
	    {
	        PlayerInfo[playerid][pGun8] = 16; PlayerInfo[playerid][pAmmo8] = 2;
	        playerWeapons[playerid][weaponLegal9] = 1;
	    }
     	if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 41 && PlayerInfo[playerid][pAmmo9] < 500 || PlayerInfo[playerid][pAmmo9] <= 30)
	    {
	        PlayerInfo[playerid][pGun9] = 41; PlayerInfo[playerid][pAmmo9] = 10000;
	        playerWeapons[playerid][weaponLegal10] = 1;
	    }
	}
	else if(GroupHavePerm(grupa, PERM_MEDIC))
	{
	    if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 42 && PlayerInfo[playerid][pAmmo9] < 500 || PlayerInfo[playerid][pAmmo9] <= 30 )
	    {
	        PlayerInfo[playerid][pGun9] = 42; PlayerInfo[playerid][pAmmo9] = 10000;
	        playerWeapons[playerid][weaponLegal10] = 1;
	    }
	}
	else if(GroupHavePerm(grupa, PERM_BOR))
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 3; PlayerInfo[playerid][pAmmo1] = 1;
	    }
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 50 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 207;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
	}
	else if(GroupHavePerm(grupa, PERM_HITMAN))
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 4; PlayerInfo[playerid][pAmmo1] = 1;
	        playerWeapons[playerid][weaponLegal2] = 0;

	    }
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 25 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 107;
	        playerWeapons[playerid][weaponLegal3] = 0;
	    }//HA
	}
	else if(GroupHavePerm(grupa, PERM_NEWS))
	{
	    if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 43 && PlayerInfo[playerid][pAmmo9] < 10 || PlayerInfo[playerid][pAmmo9] <= 30)
	    {
	        PlayerInfo[playerid][pGun9] = 43; PlayerInfo[playerid][pAmmo9] = 100;
	        playerWeapons[playerid][weaponLegal10] = 1;
	    }
	}
	return 1;
}

DajBroniePracy(playerid)
{
	switch(PlayerInfo[playerid][pJob])
	{
		case JOB_MECHANIC:
		{
			if(PlayerInfo[playerid][pGun1] == 0)
			{
				PlayerInfo[playerid][pGun1] = 6; PlayerInfo[playerid][pAmmo1] = 1;
				playerWeapons[playerid][weaponLegal2] = 1;
			}
		}
		case JOB_DRAGDEALER:
		{
			if(PlayerInfo[playerid][pGun1] == 0)
			{
				PlayerInfo[playerid][pGun1] = 5; PlayerInfo[playerid][pAmmo1] = 1;
				playerWeapons[playerid][weaponLegal2] = 0;
			}
		}
		case JOB_GUNDEALER:
		{
			if(PlayerInfo[playerid][pGun1] == 0)
			{
				PlayerInfo[playerid][pGun1] = 5; PlayerInfo[playerid][pAmmo1] = 1;
				playerWeapons[playerid][weaponLegal2] = 0;
			}
		}
	}
}

PrzywrocBron(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    ResetPlayerWeapons(playerid);
		new startowabron = 0;
	    if(PlayerInfo[playerid][pGun0] == 1)
		{
			startowabron = 1;
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun0], PlayerInfo[playerid][pAmmo0]);
		}
		if(PlayerInfo[playerid][pGun1] >= 2)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun1], PlayerInfo[playerid][pAmmo1]);
		}
		if(PlayerInfo[playerid][pGun2] >= 2 && PlayerInfo[playerid][pAmmo2] >= 10)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun2], PlayerInfo[playerid][pAmmo2]);
		}
		if(PlayerInfo[playerid][pGun3] >= 2 && PlayerInfo[playerid][pAmmo3] >= 10)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun3], PlayerInfo[playerid][pAmmo3]);
		}
		if(PlayerInfo[playerid][pGun4] >= 2 && PlayerInfo[playerid][pAmmo4] >= 10)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun4], PlayerInfo[playerid][pAmmo4]);
		}
		if(PlayerInfo[playerid][pGun5] >= 2 && PlayerInfo[playerid][pAmmo5] >= 10)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun5], PlayerInfo[playerid][pAmmo5]);
		}
		if(PlayerInfo[playerid][pGun6] >= 2 && PlayerInfo[playerid][pAmmo6] >= 10)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun6], PlayerInfo[playerid][pAmmo6]);
		}
		if(PlayerInfo[playerid][pGun7] >= 2 && PlayerInfo[playerid][pAmmo7] >= 10)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun7], PlayerInfo[playerid][pAmmo7]);
		}
		if(PlayerInfo[playerid][pGun8] >= 2 && PlayerInfo[playerid][pAmmo8] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun8], PlayerInfo[playerid][pAmmo8]);
		}
		if(PlayerInfo[playerid][pGun9] >= 2  && PlayerInfo[playerid][pAmmo9] >= 10)
		{
            GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun9], PlayerInfo[playerid][pAmmo9]);
		}
		if(PlayerInfo[playerid][pGun10] >= 2)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun10], PlayerInfo[playerid][pAmmo10]);
		}
		if(PlayerInfo[playerid][pGun11] >= 2  && PlayerInfo[playerid][pAmmo11] >= 10)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun11], PlayerInfo[playerid][pAmmo11]);
		}
		if(PlayerInfo[playerid][pGun12] >= 2  && PlayerInfo[playerid][pAmmo12] >= 10)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun12], PlayerInfo[playerid][pAmmo12]);
		}
		PrzedmiotyZmienBron(playerid, startowabron);
		return 1;
	}
	return 0;
}

WyjmijBron(playerid)
{
    new dom = PlayerInfo[playerid][pDom];
    new bron[2000];
    new a2,a3,a4,a5,a6,a7,a8,a9;
    new b0[100],b1[100],b2[100],b3[100],b4[100],b5[100],b6[100],b7[100],b8[100],b9[100],b10[100],b11[100];
    format(b0, sizeof(b0), "%s", GunNames[Dom[dom][hS_G0]]);
    format(b1, sizeof(b1), "%s", GunNames[Dom[dom][hS_G1]]);
    format(b2, sizeof(b2), "%s", GunNames[Dom[dom][hS_G2]]);
    format(b3, sizeof(b3), "%s", GunNames[Dom[dom][hS_G3]]);
    format(b4, sizeof(b4), "%s", GunNames[Dom[dom][hS_G4]]);
    format(b5, sizeof(b5), "%s", GunNames[Dom[dom][hS_G5]]);
    format(b6, sizeof(b6), "%s", GunNames[Dom[dom][hS_G6]]);
    format(b7, sizeof(b7), "%s", GunNames[Dom[dom][hS_G7]]);
    format(b8, sizeof(b8), "%s", GunNames[Dom[dom][hS_G8]]);
    format(b9, sizeof(b9), "%s", GunNames[Dom[dom][hS_G9]]);
    format(b10, sizeof(b10), "%s", GunNames[Dom[dom][hS_G10]]);
    format(b11, sizeof(b11), "%s", GunNames[Dom[dom][hS_G11]]);
    a2 = Dom[dom][hS_A2];
    a3 = Dom[dom][hS_A3];
    a4 = Dom[dom][hS_A4];
    a5 = Dom[dom][hS_A5];
    a6 = Dom[dom][hS_A6];
    a7 = Dom[dom][hS_A7];
    a8 = Dom[dom][hS_A8];
    a9 = Dom[dom][hS_A9];
    format(bron, sizeof(bron), "%s\n%s\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\n%s",b0,b1,b2,a2,b3,a3,b4,a4,b5,a5,b6,a6,b7,a7,b8,a8,b9,a9,b10,b11);
    ShowPlayerDialogEx(playerid, 8241, DIALOG_STYLE_LIST, "Wybierz bro� kt�r� chcesz wyj��", bron, "Wybierz", "Cofnij");
}

SchowajBron(playerid)
{
    new BronieF[13][2];
	for(new i = 0; i < 13; i++) { GetPlayerWeaponData(playerid, i, BronieF[i][0], BronieF[i][1]); }
 	new b0[100],b1[100],b2[100],b3[100],b4[100],b5[100],b6[100],b7[100],b8[100],b9[100],b10[100],b11[100];
	new a2,a3,a4,a5,a6,a7,a8,a9;
	format(b0, sizeof(b0), "%s", GunNames[BronieF[0][0]]);
	format(b1, sizeof(b1), "%s", GunNames[BronieF[1][0]]);
	if(BronieF[2][1] >= 1) { format(b2, sizeof(b2), "%s", GunNames[BronieF[2][0]]); a2 = BronieF[2][1]; }
	if(BronieF[3][1] >= 1) { format(b3, sizeof(b3), "%s", GunNames[BronieF[3][0]]); a3 = BronieF[3][1]; }
	if(BronieF[4][1] >= 1) { format(b4, sizeof(b4), "%s", GunNames[BronieF[4][0]]); a4 = BronieF[4][1]; }
	if(BronieF[5][1] >= 1) { format(b5, sizeof(b5), "%s", GunNames[BronieF[5][0]]); a5 = BronieF[5][1]; }
	if(BronieF[6][1] >= 1) { format(b6, sizeof(b6), "%s", GunNames[BronieF[6][0]]); a6 = BronieF[6][1]; }
	if(BronieF[7][1] >= 1) { format(b7, sizeof(b7), "%s", GunNames[BronieF[7][0]]); a7 = BronieF[7][1]; }
	if(BronieF[8][1] >= 1) { format(b8, sizeof(b8), "%s", GunNames[BronieF[8][0]]); a8 = BronieF[8][1]; }
	if(BronieF[9][1] >= 1) { format(b9, sizeof(b9), "%s", GunNames[BronieF[9][0]]); a9 = BronieF[9][1]; }
	format(b10, sizeof(b10), "%s", GunNames[BronieF[10][0]]);
	format(b11, sizeof(b11), "%s", GunNames[BronieF[11][0]]);
	new bron28itrzyipol[2000];
 	format(bron28itrzyipol, sizeof(bron28itrzyipol), "%s\n%s\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\n%s",b0,b1,b2,a2,b3,a3,b4,a4,b5,a5,b6,a6,b7,a7,b8,a8,b9,a9,b10,b11);
 	ShowPlayerDialogEx(playerid, 8242, DIALOG_STYLE_LIST, "Wybierz bro� kt�r� chcesz schowa�", bron28itrzyipol, "Wybierz", "Cofnij");
}

ListaBroni(playerid)
{
	new dom = PlayerInfo[playerid][pDom];
    new bron[2000];
    new a2,a3,a4,a5,a6,a7,a8,a9;
    new b0[100],b1[100],b2[100],b3[100],b4[100],b5[100],b6[100],b7[100],b8[100],b9[100],b10[100],b11[100];
    format(b0, sizeof(b0), "%s", GunNames[Dom[dom][hS_G0]]);
    format(b1, sizeof(b1), "%s", GunNames[Dom[dom][hS_G1]]);
    format(b2, sizeof(b2), "%s", GunNames[Dom[dom][hS_G2]]);
    format(b3, sizeof(b3), "%s", GunNames[Dom[dom][hS_G3]]);
    format(b4, sizeof(b4), "%s", GunNames[Dom[dom][hS_G4]]);
    format(b5, sizeof(b5), "%s", GunNames[Dom[dom][hS_G5]]);
    format(b6, sizeof(b6), "%s", GunNames[Dom[dom][hS_G6]]);
    format(b7, sizeof(b7), "%s", GunNames[Dom[dom][hS_G7]]);
    format(b8, sizeof(b8), "%s", GunNames[Dom[dom][hS_G8]]);
    format(b9, sizeof(b9), "%s", GunNames[Dom[dom][hS_G9]]);
    format(b10, sizeof(b10), "%s", GunNames[Dom[dom][hS_G10]]);
    format(b11, sizeof(b11), "%s", GunNames[Dom[dom][hS_G11]]);
    a2 = Dom[dom][hS_A2];
    a3 = Dom[dom][hS_A3];
    a4 = Dom[dom][hS_A4];
    a5 = Dom[dom][hS_A5];
    a6 = Dom[dom][hS_A6];
    a7 = Dom[dom][hS_A7];
    a8 = Dom[dom][hS_A8];
    a9 = Dom[dom][hS_A9];
    format(bron, sizeof(bron), "%s\n%s\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\n%s",b0,b1,b2,a2,b3,a3,b4,a4,b5,a5,b6,a6,b7,a7,b8,a8,b9,a9,b10,b11);
    ShowPlayerDialogEx(playerid, 8243, DIALOG_STYLE_LIST, "Lista broni", bron, "Usu�", "Cofnij");
}

GetWeaponID(weaponname[]) {
	for(new i = 0; i < 55; i++) {
		if(strfind(WeaponNames[i], weaponname, true) != -1)
		return i;
	}
	return -1;
}

MaZapisanaBron(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pGun0] == 1)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun1] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun2] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun3] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun4] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun5] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun6] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun7] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun8] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun9] >= 2)
		{
            return 1;
		}
		else if(PlayerInfo[playerid][pGun10] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun11] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun12] >= 2)
		{
		    return 1;
		}
	}
	return 0;
}

IsAKogutCar(veh)
{
	new model = GetVehicleModel(veh);
	if(model == 415)//cheetah
    {
        return 1;
    }
    else if(model == 412)//voodoo
    {
        return 1;
    }
	else if(model == 579)//huntley
    {
        return 1;
    }
    else if(model == 421)//washington
    {
        return 1;
    }
    else if(model == 426)//premier
    {
        return 1;
    }
    else if(model == 428)//Securicar
    {
        return 1;
    }
    else if(model == 402)//Buffalo
    {
        return 1;
    }
    else if(model == 401)//bravura
    {
        return 1;
    }
    else if(model == 405)//Sentinel
    {
        return 1;
    }
    else if(model == 411)//infenus
    {
        return 1;
    }
    else if(model == 429)//banshee
    {
        return 1;
    }
    else if(model == 451)//turismo
    {
        return 1;
    }
    else if(model == 470)//hummer
    {
        return 1;
    }
    else if(model == 477)//zr-350
    {
        return 1;
    }
    else if(model == 506)//super gt
    {
        return 1;
    }
    else if(model == 507)//elegant
    {
        return 1;
    }
    else if(model == 541)//bullet
    {
        return 1;
    }
    else if(model == 560)//sultan
    {
        return 1;
    }
    else if(model == 562)//elegy
    {
        return 1;
    }
    else if(model == 558)//uranus
    {
        return 1;
    }
	else
	{
		return 0;
	}
}

PrzyczepKogut(playerid, veh)
{
	new model = GetVehicleModel(veh);

    new Float:x, Float:y, Float:z;
    if(model == 415)//cheetah
    {
        x = -0.5;
        y = -0.1;
        z = 0.65;
    }
    else if(model == 412)//voodoo
    {
        x = -0.5;
        y = -0.1;
        z = 0.75;
    }
    else if(model == 421)//washington
    {
        x = -0.5;
        y = 0.15;
        z = 0.75;
    }
    else if(model == 426)//premier
    {
        x = -0.55;
        y = 0.01;
        z = 0.9;
    }
    else if(model == 428)//Securicar
    {
        x = -0.9;
        y = 1.0;
        z = 1.4;
    }
    else if(model == 402)//Buffalo
    {
        x = -0.55;
        y = -0.5;
        z = 0.82;
    }
    else if(model == 401)//bravura
    {
        x = -0.5;
        y = -0.2;
        z = 0.82;
    }
    else if(model == 405)//Sentinel
    {
        x = -0.5;
        y = -0.1;
        z = 0.8;
    }
    else if(model == 411)//infenus
    {
        x = -0.5;
        y = -0.1;
        z = 0.75;
    }
	else if(model == 579)//huntley
    {
        x = -0.57;
        y = 0.1;
        z = 1.15;
    }
    else if(model == 429)//banshee
    {
        x = -0.75;
        y = -1.3;
        z = 0.5;
    }
    else if(model == 451)//turismo
    {
        x = -0.5;
        y = -0.5;
        z = 0.65;
    }
    else if(model == 470)//hummer
    {
        x = -0.57;
        y = 0.1;
        z = 1.15;
    }
    else if(model == 477)//zr-350
    {
        x = -0.57;
        y = -0.27;
        z = 0.75;
    }
    else if(model == 506)//super gt
    {
        x = -0.57;
        y = -0.98;
        z = 0.65;
    }
    else if(model == 507)//elegant
    {
        x = -0.57;
        y = -0.01;
        z = 0.82;
    }
    else if(model == 541)//bullet
    {
        x = -0.5;
        y = 0.01;
        z = 0.70;
    }
    else if(model == 560)//sultan
    {
        x = -0.5;
        y = 0.01;
        z = 0.89;
    }
    else if(model == 562)//elegy
    {
        x = -0.5;
        y = 0.01;
        z = 0.8;
    }
    else if(model == 558)//uranus
    {
        x = -0.55;
        y = 0.01;
        z = 0.88;
    }
    else
    {
        SendClientMessage(playerid, COLOR_WHITE, "Na tym wozie nie mo�na przyczepi� koguta");
    }
    VehicleUID[veh][vSiren] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    AttachDynamicObjectToVehicle(VehicleUID[veh][vSiren], veh, x,y,z, 0.0, 0.0, 0.0);
	return 1;
}

IsAtTheDMVWindows(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1455.7228,-1792.1116,77.9502))//okienko 1
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1455.7327,-1795.6041,77.9612))//okienko 2
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1455.7328,-1798.7909,77.9612))//okienko 3
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1455.7350,-1802.1936,77.9502))//okienko 4
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1445.2709,-1791.4561,77.9502))//okienko 5
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1445.3060,-1794.1992,77.9612))//okienko 6
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1445.3192,-1797.6259,77.9612))//okienko 7
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1445.3387,-1800.7615,77.9612))//okienko 8
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1450.0565,-1854.4873,81.4670))//biuro burmistrza
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1454.3301,-1782.8667,77.9502))//kamery bor
	{
	
		return 1;
	}

	return 0;
}
IsAtPlaceGetHP(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 0.5, 1483.4926,-1816.1971,77.9512))//DMV
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 0.5, 2130.9885,-1787.2729,13.6544))//Pizza idle
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 0.5, 783.4033,-1020.2896,26.3594))//Red house hotel
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 0.5, 737.7260,-1467.0419,22.5948))//Jetty
	{
	
		return 1;
	}
	return 0;
}

IsAtHealingPlace(playerid)
{
	if(GetPlayerVirtualWorld(playerid) == 90)
	{
		return 1;
	}
	else if(GetPlayerVirtualWorld(playerid) == 32 || GetPlayerInterior(playerid) == 1)
	{
		return 1;
	}
	return 0;
}

GraczBankomat(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 2127.66210938,-1153.92480469,23.48433304))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1040.38732910,-1131.23059082,23.46322632))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1493.25781250,-1022.13476562,23.46905136))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2842.70239258,-1562.88049316, 10.73664951))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2072.01953125,-1825.50097656, 13.18))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1928.63220215,-1768.14794922, 13.21))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1787.46899414,-1867.33886719,13.21315384))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 852.48236084,-2061.84008789,12.51009178))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 341.01486206,-1517.85717773,32.83914185))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2701.67407227,-2417.54223633,13.27571201))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1186.23657227,-1368.89025879,13.30330658))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1505.4449,-1754.8218,13.5469))
    {
        return 1;
    }
	//PA�DZIOCH
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2423.41968, -2066.13257, 13.16730))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1001.01910, -923.60107, 41.94500))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 388.61719, -1806.26758, 7.45220))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 647.26550, -1368.86865, 13.26730))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 661.38593, -575.82269, 15.95790))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2273.16821, -76.34060, 26.18810))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1822.5533,-1544.7983,13.3347))
	{
		return 1;
	}
	//Nowe 2.6
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2024.5298,997.9246,10.8203))//Four Dragons LV
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 222.7831,-63.5663,1.5781))//Blueberry
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1036.0112,-1025.2030,32.1016))//trans LS
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1380.6733,-1766.1440,13.5469))//za DMV
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1319.7610,339.2741,19.5547))//Montgomery
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 421.4708,2533.3391,16.5737))//Lotnisko Verdant
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, -1504.4927,2617.1204,55.8359))//miasteczko na pustyni LV
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, -2446.6143,2321.3167,4.9766))//BaySide 
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, -2278.0667,936.9093,66.6484))//San Fierro
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, -1690.4055,864.8093,24.8906))//San Fierro 2
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1709.06, -1495.75, 13.54))//Ammunation Commerce
	{
		return 1;
	}
	
	return 0;
}

IsAtClothShop(playerid)
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerToPoint(25.0,playerid,207.5627,-103.7291,1005.2578) || PlayerToPoint(25.0,playerid,203.9068,-41.0728,1001.8047))
		{//Binco & Suburban
		    return 1;
		}
		else if(PlayerToPoint(30.0,playerid,214.4470,-7.6471,1001.2109) || PlayerToPoint(50.0,playerid,161.3765,-83.8416,1001.8047))
		{//Zip & Victim
			return 1;

		}
		else if(PlayerToPoint(50.0,playerid,206.4627,-137.7076,1003.0938))
		{//pro laps
		    return 1;
		}
	}
	return 0;
}
IsAtTicketMachine(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(5.0, playerid, 1757.00513, -1943.20789, 13.26766) || PlayerToPoint(5.0, playerid,  1746.97949, -1943.71838, 13.45185) || PlayerToPoint(5.0, playerid, 825.69000, -1354.49915, 13.11831) || PlayerToPoint(5.0, playerid, 2293.0547,-1175.9962,26.0441))
		{
		
			return 1;
		}
	
	
	
	}
	return 0;

}
IsAtGasStation(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(10.0,playerid,1004.0070,-939.3102,42.1797) || PlayerToPoint(10.0,playerid,1944.3260,-1772.9254,13.3906))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(10.0,playerid,-90.5515,-1169.4578,2.4079) || PlayerToPoint(10.0,playerid,-1609.7958,-2718.2048,48.5391))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-2029.4968,156.4366,28.9498) || PlayerToPoint(8.0,playerid,-2408.7590,976.0934,45.4175))
		{//SF
		    return 1;
		}
		else if(PlayerToPoint(5.0,playerid,-2243.9629,-2560.6477,31.8841) || PlayerToPoint(8.0,playerid,-1676.6323,414.0262,6.9484))
		{//Between LS and SF
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,2202.2349,2474.3494,10.5258) || PlayerToPoint(10.0,playerid,614.9333,1689.7418,6.6968))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,-1328.8250,2677.2173,49.7665) || PlayerToPoint(6.0,playerid,70.3882,1218.6783,18.5165))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,2113.7390,920.1079,10.5255) || PlayerToPoint(6.0,playerid,-1327.7218,2678.8723,50.0625))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(12.0,playerid,-1471.86, 1864.23, 32.63))
		{//lv pustynia
			return 1;
		}
		else if(PlayerToPoint(8.0,playerid,-1130.1172,-1018.0840,129.2188))
		{//�u�el
		    return 1;
		}
		else if(PlayerToPoint(7.0,playerid,2482.4558,-2130.1379,13.5530))
		{//zajezdnia busowa
		    return 1;
		}
		else if(PlayerToPoint(5.0,playerid,654.9174,-559.6597,16.5015) || PlayerToPoint(5.0,playerid,656.3661,-570.4130,16.5015))
		{//Dillimore
		    return 1;
		}
		else if(PlayerToPoint(3.0,playerid,2584.5634765625,61.7255859375,25.61093711853) || PlayerToPoint(2.5,playerid,2584.5595703125,66.3486328125,25.61093711853))
		{//Palomino Creek
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,1381.5094,459.3204,20.3452))
		{//Montgomery
			return 1;
		}
		else if(PlayerToPoint(20.0,playerid,2054.13,-1912.34,14.06))
		{//Nowa stacja idle
			return 1;
		}
		else if(PlayerToPoint(15.0,playerid,1362.5422,-1819.4730,13.5639))
		{//Plac manewrowy
		    return 1;
		}
		else if(PlayerToPoint(10.0,playerid,2471.2898,-2105.1948,14.1259) || PlayerToPoint(6.0,playerid,1011.8489,-1356.9026,13.5839))
		{//Stacja pod p�czkiem LS
		    return 1;
		}
		else if(PlayerToPoint(10.0,playerid,2489.6565,-2101.3022,13.5620)) 
		{//stacja w bazie KT
			return 1;
		}
	}
	return 0;
}

IsAtBar(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 495.7801,-76.0305,998.7578) || IsPlayerInRangeOfPoint(playerid, 4.0, 499.9654,-20.2515,1000.6797))
		{//In grove street bar (with girlfriend), and in Havanna
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 1215.5813,-15.2610,1000.9219) || IsPlayerInRangeOfPoint(playerid, 10.0, -2658.9749,1407.4136,906.2734))
		{//PIG Pen  i Alhambra
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,4.0,-785.6683,498.2613,1371.7422) || IsPlayerInRangeOfPoint(playerid,7.0,598.6794,-2204.8613,1.8190))
		{//Basen "tsunami i W�oska restauracja
		    return 1;
 		}
		else if(IsPlayerInRangeOfPoint(playerid, 4.0, 1980.4153,-1290.2195,5620.3687) || IsPlayerInRangeOfPoint(playerid,4.0,-223.3081,1406.5033,27.7734))
		{//bar Kacpra i bar Vagos
		  	return 1;
		}
        else if(IsPlayerInRangeOfPoint(playerid, 4.0, 1983.4441,-1296.2300,-9.1928))
		{//bar       glenpark
		  	return 1;
		}
	}
	return 0;
}

IsAtWarsztat(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 1788.2085,-1694.2456,13.1814) || IsPlayerInRangeOfPoint(playerid, 5.0, 1779.0632,-1693.1831,13.1608) || IsPlayerInRangeOfPoint(playerid, 5.0, 1805.4418,-1713.5634,13.5176))
		{//Warsztat czerwony
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 40.0, 2333.7273,-1241.2806,22.0628))
		{//warsztat niebieski
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 20.0, 644.3516,-503.4102,15.8941))
		{//warsztat dillmore
		  	return 1;
		}
        else if(IsPlayerInRangeOfPoint(playerid, 30.0, 1017.75, -1353.33, 13.3825))
		{//warsztat przy p1czkarni
		  	return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 50.0, 1099.7108,-1240.7935,15.8203)) {
			// WARSZTAT NA MARKET XD
			return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 30, 1877.58, -1706.90, 14.27)) {
			//warstat idlewood
			return 1;
		}
	}
	return 0;
}

IsARower(carid)
{
	if(GetVehicleModel(carid) == 509 || GetVehicleModel(carid) == 481 || GetVehicleModel(carid) == 510)//rowery
	{
		return 1;
	}
	return 0;
}

IsABike(carid)
{
	if(GetVehicleModel(carid) == 509 || GetVehicleModel(carid) == 481 || GetVehicleModel(carid) == 510)//rowery
	{
		return 1;
	}
	if(GetVehicleModel(carid) == 462 || GetVehicleModel(carid) == 448 || GetVehicleModel(carid) == 581 || GetVehicleModel(carid) == 522 || GetVehicleModel(carid) == 461 || GetVehicleModel(carid) == 521 || GetVehicleModel(carid) == 523 || GetVehicleModel(carid) == 463 || GetVehicleModel(carid) == 586 || GetVehicleModel(carid) == 468)//motory
	{
		return 1;
	}
	if(GetVehicleModel(carid) == 471)//quad
	{
		return 1;
	}
	return 0;
}

IsACarBezSzyb(carid){
	if(GetVehicleModel(carid) == 568 || GetVehicleModel(carid) == 424 || GetVehicleModel(carid) == 504 || GetVehicleModel(carid) == 457 || GetVehicleModel(carid) == 571 || GetVehicleModel(carid) == 539 || GetVehicleModel(carid) == 429 || GetVehicleModel(carid) == 480 || GetVehicleModel(carid) == 531 || GetVehicleModel(carid) == 486 || GetVehicleModel(carid) == 530 || GetVehicleModel(carid) == 572 || GetVehicleModel(carid) == 567 || GetVehicleModel(carid) == 575 || GetVehicleModel(carid) == 485)
	{
		return 1;
	}
	return 0;
}

IsABoat(carid)
{
	if(GetVehicleModel(carid) == 472 || GetVehicleModel(carid) == 473 || GetVehicleModel(carid) == 493 || GetVehicleModel(carid) == 595 || GetVehicleModel(carid) == 484 || GetVehicleModel(carid) == 430 || GetVehicleModel(carid) == 453 || GetVehicleModel(carid) == 452 || GetVehicleModel(carid) == 446 || GetVehicleModel(carid) == 454)//�odzie
	{
		return 1;
	}
	return 0;
}

IsAPlane(carid)
{
	if(GetVehicleModel(carid) == 592 || GetVehicleModel(carid) == 577 || GetVehicleModel(carid) == 511 || GetVehicleModel(carid) == 512 || GetVehicleModel(carid) == 593 || GetVehicleModel(carid) == 520 || GetVehicleModel(carid) == 553 || GetVehicleModel(carid) == 476 || GetVehicleModel(carid) == 519 || GetVehicleModel(carid) == 460 || GetVehicleModel(carid) == 513)//samoloty
	{
		return 1;
	}
	if(GetVehicleModel(carid) == 548 || GetVehicleModel(carid) == 425 || GetVehicleModel(carid) == 417 || GetVehicleModel(carid) == 487 || GetVehicleModel(carid) == 488 || GetVehicleModel(carid) == 497 || GetVehicleModel(carid) == 563 || GetVehicleModel(carid) == 447 || GetVehicleModel(carid) == 469)//helikoptery
	{
		return 1;
	}
	return 0;
}

IsACopCar(carid)
{
    new lID = VehicleUID[carid][vUID];
    if(lID == 0) return 0;
	if(CarData[lID][c_OwnerType] == CAR_OWNER_GROUP)	
	{	
		if(GroupHavePerm(CarData[lID][c_Owner], PERM_POLICE)) return 1;	
	}
    if(CarData[lID][c_OwnerType] == CAR_OWNER_FRACTION)
    {
        if(CarData[lID][c_Owner] == FRAC_LSPD) return 1;
        else if(CarData[lID][c_Owner] == FRAC_FBI) return 1;
        else if(CarData[lID][c_Owner] == FRAC_NG) return 1;
    }
	return 0;
}

IsAnAmbulance(carid)
{
    new lID = VehicleUID[carid][vUID];
    if(lID == 0) return 0;
	if(CarData[lID][c_OwnerType] == CAR_OWNER_GROUP)	
	{	
		if(GroupHavePerm(CarData[lID][c_Owner], PERM_MEDIC)) return 1;	
	}
    if(CarData[lID][c_OwnerType] == CAR_OWNER_FRACTION)
    {
        if(CarData[lID][c_Owner] == FRAC_ERS) return 1;
    }
	return 0;
}

IsAInteriorVehicle(model)
{
	//484- Jacht(Marquis), 519 - Shamal, 553 - Nevada, 409 - Stretch, 416 - Ambulance, 508 - Journey, 582 - Newsvan
	return (model == 484 || model == 519 || model == 553 || model == 409 || model == 416 || model == 508 || model == 582 || model == 431 || model == 427 || model == 570);
}

IS_KomunikacjaMiejsca(carid)
{
    new lID = VehicleUID[carid][vUID];
    if(lID == 0) return 0;
    if((CarData[lID][c_Owner] == FRAC_KT && CarData[lID][c_OwnerType] == CAR_OWNER_FRACTION &&(CarData[lID][c_Model] == 431 || CarData[lID][c_Model] == 437 || CarData[lID][c_Model] == 418)) || (CarData[lID][c_Owner] == JOB_BUSDRIVER && CarData[lID][c_OwnerType] == CAR_OWNER_JOB)) return 1;
	return 0;
}

IsATaxiCar(carid)
{
    new lID = VehicleUID[carid][vUID];
    if(lID == 0) return 0;
	if(CarData[lID][c_OwnerType] == CAR_OWNER_GROUP)	
	{	
		if(GroupHavePerm(CarData[lID][c_Owner], PERM_TAXI)) return 1;	
	}
    if(CarData[lID][c_OwnerType] == CAR_OWNER_FRACTION)
    {
        if(CarData[lID][c_Owner] == FRAC_KT) return 1;
    }
	return 0;
}

IsATrain(carid)
{
    new lID = VehicleUID[carid][vUID];
    if(lID == 0) return 0;
    if(CarData[lID][c_OwnerType] == CAR_OWNER_FRACTION)
    {
        if(CarData[lID][c_Owner] == FRAC_KT && GetVehicleModel(carid) == 538) return 1;
    }
	return 0;
}

SetServerWeatherAndTime(playerid)
{
	SetPlayerWeatherEx(playerid, ServerWeather);
	SetPlayerTime(playerid, ServerTime, 0);
	return 1;
}
SetInteriorTimeAndWeather(playerid)
{
	SetPlayerWeatherEx(playerid, 2);
	SetPlayerTime(playerid, 14, 0);
	return 1;
}
Wejdz(playerid, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:tolerancja, komunikat[]="")
{
    if (IsPlayerInRangeOfPoint(playerid, tolerancja, x, y, z))
    {
    	SetPlayerPos(playerid, x2, y2, z2);
	 	SetPlayerVirtualWorld(playerid, 235);
        Wchodzenie(playerid);
		
		if(strlen(komunikat) > 0)
		{
			GameTextForPlayer(playerid, komunikat, 5000, 1);
		}
	}
	return 1;
}

Wyjdz(playerid, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:tolerancja, komunikat[]="")
{
    if (IsPlayerInRangeOfPoint(playerid, tolerancja, x, y, z))
    {
    	SetPlayerPos(playerid, x2, y2, z2);
	 	SetPlayerVirtualWorld(playerid, 0);
        Wchodzenie(playerid);
		
		if(strlen(komunikat) > 0)
		{
			GameTextForPlayer(playerid, komunikat, 5000, 1);
		}
	}
	return 1;
}

JoinChannel(playerid, number, line[])
{
    if(IsPlayerConnected(playerid))
	{
	    if(strcmp(IRCInfo[number][iPassword],line, true ) == 0 )
		{
	        JoinChannelNr(playerid, number);
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_GREY, "   Z�e has�o !");
	    }
	}
	return 1;
}

JoinChannelNr(playerid, number)
{
	if(IsPlayerConnected(playerid))
	{
	    new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(PlayersChannel[playerid] < 999)
	    {
			format(string, sizeof(string), "* %s opu�ci� ten kana�.", sendername);
			SendIRCMessage(PlayersChannel[playerid], COLOR_GREEN, string);
			IRCInfo[PlayersChannel[playerid]][iPlayers] -= 1;
	    }
		new channel; channel = number; channel += 1;
	    PlayersChannel[playerid] = number;
	    IRCInfo[PlayersChannel[playerid]][iPlayers] += 1;
    	new wstring[128];
		format(string, sizeof(string), "%s", sendername);
		strmid(wstring, string, 0, strlen(string), 255);
		if(strcmp(IRCInfo[number][iAdmin],wstring, true ) == 0 )
		{
		    format(string, sizeof(string), "* Do��czy�e� do kana�u numer %d jako Administartor.", channel);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		else
		{
		    format(string, sizeof(string), "* Do��czy�e� do kana�u numer %d, Administrator kana�u: %s.", channel, IRCInfo[number][iAdmin]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		format(string, sizeof(string), "MOTD: %s.", IRCInfo[number][iMOTD]);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof(string), "* %s do��czy� do tego kana�u.", sendername);
		SendIRCMessage(number, COLOR_GREEN, string);
	}
	return 1;
}

ClearMarriage(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "Nikt");
		strmid(PlayerInfo[playerid][pMarriedTo], string, 0, strlen(string), 255);
		PlayerInfo[playerid][pMarried] = 0;
	}
	return 1;
}

ClearCrime(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "********");
		strmid(PlayerCrime[playerid][pBplayer], string, 0, strlen(string), 255);
		strmid(PlayerCrime[playerid][pVictim], string, 0, strlen(string), 255);
		strmid(PlayerCrime[playerid][pAccusing], string, 0, strlen(string), 255);
		strmid(PlayerCrime[playerid][pAccusedof], string, 0, strlen(string), 255);
	}
	return 1;
}


Lotto(number)
{
	new winners=0, string[256], status=1; 
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pLottoNr] > 0)
			{
				if(PlayerInfo[i][pLottoNr] == number)
				{
					winners++; 
					status=2;
				}
				else 
				{
					format(string, sizeof(string), "Niestety nie uda�o Ci si� wygra� loterii z numerem %d.", PlayerInfo[i][pLottoNr]);
					SendClientMessage(i, COLOR_WHITE, string);
					PlayerInfo[i][pLottoNr] = 0; 
				}
			}
		}
	}
	new dzielnik = winners;
	foreach(new i2 : Player)
	{
		if(status == 1)
		{
			if(winners == 0)
			{
				new rand = random(MULT_LOTTO); 
				Jackpot = Jackpot+rand; 
				format(string, sizeof(string), "Nikt nie wygra�. Nagroda zosta�a podwy�szona do %d$", Jackpot);
				OOCOff(COLOR_WHITE, string);  
				break; 
			}
		}
		if(status == 2)
		{
			if(winners == 0)
			{
				new rand = random(MULT_LOTTO2);
				Jackpot = rand; 
				format(string, sizeof(string), "Lotto rozpoczyna kolejn� loteri�, kasa wyj�cia to %d$", Jackpot); 
				OOCOff(COLOR_WHITE, string); 
				status = 1;
				break;
			}
			if(PlayerInfo[i2][pLottoNr] > 0 && PlayerInfo[i2][pLottoNr] == number)
			{
				new kasaWin = Jackpot/dzielnik; 
				format(string, sizeof(string), "%s wygra� w totolotku %d$", GetNick(i2), kasaWin); 
				OOCOff(COLOR_WHITE, string);
				DajKaseDone(i2, kasaWin);
				PlayerInfo[i2][pLottoNr] =0;
				winners--;   
			}
		}
			
	}
}

SetPlayerCriminal(playerid,declare,reason[], bool:sendmessage=true)
{
	if(IsPlayerConnected(playerid))
	{
	    PlayerInfo[playerid][pCrimes] += 1;
	    new points = PoziomPoszukiwania[playerid];
		new turned[MAX_PLAYER_NAME];
		new turner[MAX_PLAYER_NAME];
		new turnmes[128];
		new wantedmes[128];
		strmid(PlayerCrime[playerid][pAccusedof], reason, 0, strlen(reason), 255);
		GetPlayerName(playerid, turned, sizeof(turned));
		if (declare == INVALID_PLAYER_ID)
		{
		    if(PoziomPoszukiwania[playerid] <= 5)
		    {
				format(turner, sizeof(turner), "Monitoring LSPD");
				strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
			}
			else if(PoziomPoszukiwania[playerid] >= 6)
			{
				format(turner, sizeof(turner), "Satelity FBI");
				strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
			}
		}
		else
		{
		    if(IsPlayerConnected(declare))
		    {
				GetPlayerName(declare, turner, sizeof(turner));
				strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
				strmid(PlayerCrime[declare][pBplayer], turned, 0, strlen(turned), 255);
				strmid(PlayerCrime[declare][pAccusing], reason, 0, strlen(reason), 255);
			}
		}
		format(turnmes, sizeof(turnmes), "Pope�ni�e� przest�pstwo ( %s ). Zg�osi�: %s.",reason,turner);
		SendClientMessage(playerid, COLOR_LIGHTRED, turnmes);
		PlayCrimeReportForPlayer(playerid, declare,5);
		if(points > 0)
		{
			if(points == 1)
			{
				if(PoziomPoszukiwania[playerid] != 1)
				{
					PoziomPoszukiwania[playerid] += 1;
				}
			}
			else if(points == 2)
			{
				if(PoziomPoszukiwania[playerid] != 2)
				{
					PoziomPoszukiwania[playerid] = 2;
				}
			}
			else if(points == 3)
			{
				if(PoziomPoszukiwania[playerid] != 3)
				{
					PoziomPoszukiwania[playerid] = 3;
				}
			}
			else if(points == 4)
			{
				if(PoziomPoszukiwania[playerid] != 4)
				{
					PoziomPoszukiwania[playerid] = 4;
				}
			}
            else if(points == 5)
			{
				if(PoziomPoszukiwania[playerid] != 5)
				{
					PoziomPoszukiwania[playerid] = 5;
				}
			}
			else if(points == 6)
			{
				if(PoziomPoszukiwania[playerid] != 6)
				{
					PoziomPoszukiwania[playerid] = 6;
				}
			}
			else if(points == 7)
			{
				if(PoziomPoszukiwania[playerid] != 7)
				{
					PoziomPoszukiwania[playerid] = 7;
				}
			}
			else if(points == 8)
			{
				if(PoziomPoszukiwania[playerid] != 8)
				{
					PoziomPoszukiwania[playerid] = 8;
				}
			}
			else if(points == 9)
			{
				if(PoziomPoszukiwania[playerid] != 9)
				{
					PoziomPoszukiwania[playerid] = 9;
				}
			}
			else if(points == 10)
			{
				if(PoziomPoszukiwania[playerid] != 10)
				{
					PoziomPoszukiwania[playerid] = 10;
				}
			}
			else if(PoziomPoszukiwania[playerid] > 10) 
			{
				if(PoziomPoszukiwania[playerid] != 10)
				{
					PoziomPoszukiwania[playerid] = 10;
				}
			}
			if(PoziomPoszukiwania[playerid] > 0)
			{
			    if((IsAPolicja(playerid) || IsABOR(playerid)) && OnDuty[playerid] > 0)
			    {
      				PoziomPoszukiwania[playerid] = 0;
				}
			}

			SetPlayerWantedLevel(playerid, (PoziomPoszukiwania[playerid] > 6 ? 6 : PoziomPoszukiwania[playerid]));
			
			if(sendmessage)
			{
				format(wantedmes, sizeof(wantedmes), "Posiadany Wanted Level: %d", PoziomPoszukiwania[playerid]);
				SendClientMessage(playerid, COLOR_YELLOW, wantedmes);
				new pZone[MAX_ZONE_NAME];
            	GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);//Dzielnica
				foreach(new i : Player)
				{
					if(IsPlayerConnected(i))
					{
					    if(IsAPolicja(i) && (OnDutyCD[i] || OnDuty[i]))
					    {
					        if(gCrime[i] == 0)
					        {
								format(cbjstore, sizeof(turnmes), "HQ: Przest�pstwo: %s | Nadawca: %s",reason, turner);
								SendClientMessage(i, COLOR_LFBI, cbjstore);
								format(cbjstore, sizeof(turnmes), "HQ: Podejrzany: %s, ostatnia lokalizacja: %s",turned, pZone);
								SendClientMessage(i, COLOR_LFBI, cbjstore);
							}
						}
					}
				}
			}
		}
	}//not connected
}

HideStats2(playerid)
{
	PlayerTextDrawHide(playerid, TXDSTATS_Background[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_UID[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_SkinShow[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_LogoMRP[playerid]);  
	PlayerTextDrawHide(playerid, TXDSTATS_LVL[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_NICK[playerid]);  
	PlayerTextDrawHide(playerid, TXDSTATS_PLEC[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Pochodzenie[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Zdrowie[playerid]);  
	PlayerTextDrawHide(playerid, TXDSTATS_Kasa[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Bank[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Telefon[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_KP[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Wiek[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Slub[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_OnLine[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Respekt[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Rodzina[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_RodzinaRanga[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_BOID[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_BMID[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Skin[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Dom[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Warny[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Praca[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Admin[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Drugs[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Mats[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Fraction[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_FractionRank[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Przestepstwa[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Zabic[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Smierci[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_ZmienNick[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_AresztTime[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_WozKlucz[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Pkt[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Sila[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_WL[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_WantedDeath[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Ryba[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Data[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Czas[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_LogoMRP[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Linia_01[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Linia_02[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Linia_03[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Linia_04[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_ZnakWodny[playerid]); 
}
ShowStats(playerid,targetid)
{
    if(IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
	{
		new cash = kaska[targetid];
		new atext[20];
		if(PlayerInfo[targetid][pSex] == 1) { atext = "M�czyzna"; }
		else if(PlayerInfo[targetid][pSex] == 2) { atext = "Kobieta"; }
  		new otext[20];
		if(PlayerInfo[targetid][pOrigin] == 1) { otext = "USA"; }
		else if(PlayerInfo[targetid][pOrigin] == 2) { otext = "Europa"; }
		else if(PlayerInfo[targetid][pOrigin] == 3) { otext = "Azja"; }

		new f1text[40], f2text[40], f3text[40];
		new r1text[40], r2text[40], r3text[40];
		if(PlayerInfo[targetid][pGrupa][0] != 0) 
		{
			new group = PlayerInfo[targetid][pGrupa][0];
			if(strlen(GroupInfo[PlayerInfo[targetid][pGrupa][0]][g_Name]) <= 12 && strlen(GroupInfo[PlayerInfo[targetid][pGrupa][0]][g_ShortName]) > 1)
				format(f1text, sizeof(f1text), "%s", GroupInfo[PlayerInfo[targetid][pGrupa][0]][g_Name]);
			else
				format(f1text, sizeof(f1text), "%s", GroupInfo[PlayerInfo[targetid][pGrupa][0]][g_ShortName]);	
			format(r1text, sizeof(r1text), "%s", GroupRanks[group][PlayerInfo[targetid][pGrupaRank][0]]);
		}
		else {f1text = "Brak"; r1text = "Brak";}
		if(PlayerInfo[targetid][pGrupa][1] != 0)
		{
			new group = PlayerInfo[targetid][pGrupa][1];
			if(strlen(GroupInfo[PlayerInfo[targetid][pGrupa][1]][g_Name]) <= 12 && strlen(GroupInfo[PlayerInfo[targetid][pGrupa][1]][g_ShortName]) > 1)
				format(f2text, sizeof(f2text), "%s", GroupInfo[PlayerInfo[targetid][pGrupa][1]][g_Name]);
			else
				format(f2text, sizeof(f2text), "%s", GroupInfo[PlayerInfo[targetid][pGrupa][1]][g_ShortName]);	
			format(r2text, sizeof(r2text), "%s", GroupRanks[group][PlayerInfo[targetid][pGrupaRank][1]]);
		}
		else {f2text = "Brak"; r2text = "Brak";}
		if(PlayerInfo[targetid][pGrupa][2] != 0)
		{
			new group = PlayerInfo[targetid][pGrupa][2];
			if(strlen(GroupInfo[PlayerInfo[targetid][pGrupa][2]][g_Name]) <= 12 && strlen(GroupInfo[PlayerInfo[targetid][pGrupa][2]][g_ShortName]) > 1)
				format(f3text, sizeof(f3text), "%s", GroupInfo[PlayerInfo[targetid][pGrupa][2]][g_Name]);
			else
				format(f3text, sizeof(f3text), "%s", GroupInfo[PlayerInfo[targetid][pGrupa][2]][g_ShortName]);
			format(r3text, sizeof(r3text), "%s", GroupRanks[group][PlayerInfo[targetid][pGrupaRank][2]]);	
		}
		else {f3text = "Brak"; r3text = "Brak";}

        new jtext[20];
        format(jtext, 20, "%s", JobNames[PlayerInfo[targetid][pJob]]);
		new drank[20];
		if(IsPlayerPremiumOld(targetid)) { drank = "Sponsor"; }
		else { drank = "Zwykly wieprz"; }
		new age = PlayerInfo[targetid][pAge];
		new ptime = PlayerInfo[targetid][pConnectTime];
		new znick = PlayerInfo[targetid][pZmienilNick];
		new lotto = PlayerInfo[targetid][pLottoNr];
		new deaths = PlayerInfo[targetid][pDeaths];
		new fishes = PlayerInfo[targetid][pFishes];
		new bigfish = PlayerInfo[targetid][pBiggestFish];
		new crimes = PlayerInfo[targetid][pCrimes];
		new arrests = PlayerInfo[targetid][pArrested];
		new warrests = PlayerInfo[targetid][pWantedDeaths];
		new drugs = PlayerInfo[targetid][pDrugs];
		new mats = CountMats(targetid);
		new wanted = PoziomPoszukiwania[targetid];
		new level = PlayerInfo[targetid][pLevel];
		new exp = PlayerInfo[targetid][pExp];
		new kills = PlayerInfo[targetid][pKills];
		new pnumber = GetPhoneNumber(targetid);
		new account = PlayerInfo[targetid][pAccount];
		new nxtlevel = PlayerInfo[targetid][pLevel]+1;
		new expamount = nxtlevel*levelexp;
		new costlevel = nxtlevel*levelcost;//10k for testing purposes
		new housekey = PlayerInfo[targetid][pDom];
		new skin = PlayerInfo[targetid][pSkin];
		new Float:shealth = PlayerInfo[targetid][pSHealth];
		new Float:health;
		new name[MAX_PLAYER_NAME];
		if(!GetPVarString(targetid, "maska_nick", name, MAX_PLAYER_NAME)) GetPlayerName(targetid, name, sizeof(name));
		GetPlayerHealth(targetid,health);
		new Float:px,Float:py,Float:pz;
		GetPlayerPos(targetid, px, py, pz);
		new coordsstring[256];
		SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
		format(coordsstring, sizeof(coordsstring),"*** %s ({8FCB04}%s{FFFFFF}) ({8FCB04}UID: %d{FFFFFF} {8FCB04}GID: %d{FFFFFF}) ***",name, PlayerInfo[targetid][pNickOOC], PlayerInfo[targetid][pUID], PlayerInfo[targetid][pGID]);
		SendClientMessage(playerid, COLOR_WHITE,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Level:[%d] P�e�:[%s] Wiek:[%d] Pochodzenie:[%s] Zdrowie:[%.1f] Kasa:[$%d] Bank:[$%d] Telefon:[%d]", level,atext,age,otext,shealth+50, cash, account, pnumber);
		SendClientMessage(playerid, COLOR_GRAD1,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Konto Premium:[%s] �lub z:[%s] On-Line:[%d] LottoNr:[%d] Praca:[%s] Punkty karne:[%d]", drank,PlayerInfo[targetid][pMarriedTo],ptime,lotto,jtext, PlayerInfo[targetid][pPK]);
		SendClientMessage(playerid, COLOR_GRAD2,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Ryb Z�owionych:[%d] Najwi�ksza Ryba:[%d] Przest�pstwa:[%d] Czas Aresztu:[%d] Smierci b�d�c Poszukiwanym:[%d]", fishes,bigfish,crimes,arrests,warrests );
		SendClientMessage(playerid, COLOR_GRAD3,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Zabi�:[%d] �mierci:[%d] Bonus Levelowy:[$%d] Respekt:[%d/%d] WL:[%d] Skin ID:[%d] KotnikCoins:[%d]",kills,deaths,costlevel,exp,expamount,wanted, skin, PremiumInfo[targetid][pMC]);
		SendClientMessage(playerid, COLOR_GRAD4,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Drugs:[%d] Mats:[%d] Warny:[%d] Dost�pnych zmian nick�w:[%d] Si�a:[%d] G��d:[%.1f%%]",drugs,mats,PlayerInfo[targetid][pWarns],znick, PlayerInfo[targetid][pStrong], PlayerInfo[targetid][pHunger]);
		SendClientMessage(playerid, COLOR_GRAD5,coordsstring);
		format(coordsstring, sizeof(coordsstring), "JobSkin:[%d] Apteczki:[%d] Zestawy:[%d] Pok�j:[%d] Dom:[%d] Klucz Wozu:[%d]", PlayerInfo[targetid][pJobSkin], PlayerInfo[targetid][pHealthPacks],PlayerInfo[targetid][pFixKit], MotelRooms[PlayerInfo[playerid][pMotRoom]][mtrRoomNum], housekey,PlayerInfo[targetid][pKluczeAuta]);
		SendClientMessage(playerid, COLOR_GRAD5, coordsstring); 
		format(coordsstring, sizeof(coordsstring), "Grupa 1:[%s] Grupa 2:[%s] Grupa 3:[%s] Ranga 1:[%s] Ranga 2:[%s] Ranga 3:[%s]", f1text, f2text, f3text, r1text, r2text, r3text);
		SendClientMessage(playerid, COLOR_GRAD6,coordsstring); 
		SendClientMessage(playerid, COLOR_GREEN,"_______________________________________");
	}
}

PokazStatyDialogBronie(playerid)
{
	new string[512];
	for(new i = 0; i < 6; i++)
	{
		new weaponid = st_getWeaponIDBySkill(i);
		if(weaponid == -1) continue;
		new skill = st_getPlayerWeaponSkill(playerid, weaponid);
		new weapon[32];
		GetWeaponName(weaponid, weapon);
		format(string, sizeof(string), "%s\n{d9d9d9}%s: \t- poziom %d [%d]", string, weapon, skill, PlayerInfo[playerid][pWeaponSkill][i]);
	}
	return ShowPlayerDialogEx(playerid, DIALOG_STATS_UMIEJETNOSCI, DIALOG_STYLE_LIST, "Umiej�tno�ci postaci", string, "Zamknij", "");
}

PokazStatyDialogSkille(playerid)
{
	new string3[1024];
	//PRAWNIK
	if(PlayerInfo[playerid][pLawSkill] >= 0 && PlayerInfo[playerid][pLawSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Prawnik: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pLawSkill]); }
	else if(PlayerInfo[playerid][pLawSkill] >= 51 && PlayerInfo[playerid][pLawSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Prawnik: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pLawSkill]); }
	else if(PlayerInfo[playerid][pLawSkill] >= 101 && PlayerInfo[playerid][pLawSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Prawnik: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pLawSkill]); } 
	else if(PlayerInfo[playerid][pLawSkill] >= 201 && PlayerInfo[playerid][pLawSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Prawnik: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pLawSkill]); } 
	else if(PlayerInfo[playerid][pLawSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Prawnik: \t- {FFD700}poziom 5", string3); }
	//PROSTYTUTKA
	if(PlayerInfo[playerid][pSexSkill] >= 0 && PlayerInfo[playerid][pSexSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Prostytutka: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pSexSkill]); }
	else if(PlayerInfo[playerid][pSexSkill] >= 51 && PlayerInfo[playerid][pSexSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Prostytutka: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pSexSkill]); }
	else if(PlayerInfo[playerid][pSexSkill]>= 101 && PlayerInfo[playerid][pSexSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Prostytutka: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pSexSkill]); } 
	else if(PlayerInfo[playerid][pSexSkill] >= 201 && PlayerInfo[playerid][pSexSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Prostytutka: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pSexSkill]); } 
	else if(PlayerInfo[playerid][pSexSkill] >= 401) { format(string3, sizeof(string3), "{d9d9d9}Prostytutka: \t- {FFD700}poziom 5"); }
	//DILER DRAG�W
	if(PlayerInfo[playerid][pDrugsSkill] >= 0 && PlayerInfo[playerid][pDrugsSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Drag�w: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pDrugsSkill]); }
	else if(PlayerInfo[playerid][pDrugsSkill] >= 51 && PlayerInfo[playerid][pDrugsSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Drag�w: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pDrugsSkill]); }
	else if(PlayerInfo[playerid][pDrugsSkill] >= 101 && PlayerInfo[playerid][pDrugsSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Drag�w: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pDrugsSkill]); } 
	else if(PlayerInfo[playerid][pDrugsSkill] >= 201 && PlayerInfo[playerid][pDrugsSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Drag�w: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pDrugsSkill]); } 
	else if(PlayerInfo[playerid][pDrugsSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Drag�w: \t- {FFD700}poziom 5", string3); }
	//Z�ODZIEJ AUT
	if(PlayerInfo[playerid][pJackSkill] >= 0 && PlayerInfo[playerid][pJackSkill] <= 50){ format(string3, sizeof(string3), "%s\nZ{d9d9d9}�odziej Aut: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pJackSkill]); }
	else if(PlayerInfo[playerid][pJackSkill] >= 51 && PlayerInfo[playerid][pJackSkill] <= 100) { format(string3, sizeof(string3), "%s\nZ{d9d9d9}�odziej Aut: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pJackSkill]); }
	else if(PlayerInfo[playerid][pJackSkill] >= 101 && PlayerInfo[playerid][pJackSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Z�odziej Aut: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pJackSkill]); } 
	else if(PlayerInfo[playerid][pJackSkill] >= 201 && PlayerInfo[playerid][pJackSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Z�odziej Aut: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pJackSkill]); } 
	else if(PlayerInfo[playerid][pJackSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Z�odziej Aut: \t- {FFD700}poziom 5", string3); }
	//RYBAK
	if(PlayerInfo[playerid][pFishSkill] >= 0 && PlayerInfo[playerid][pFishSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Rybak: \t\t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pFishSkill]); }
	else if(PlayerInfo[playerid][pFishSkill] >= 51 && PlayerInfo[playerid][pFishSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Rybak: \t\t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pFishSkill]); }
	else if(PlayerInfo[playerid][pFishSkill] >= 101 && PlayerInfo[playerid][pFishSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Rybak: \t\t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pFishSkill]); } 
	else if(PlayerInfo[playerid][pFishSkill] >= 201 && PlayerInfo[playerid][pFishSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Rybak: \t\t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pFishSkill]); } 
	else if(PlayerInfo[playerid][pFishSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Rybak: \t\t- {FFD700}poziom 5", string3); }
	//MECHANIK
	if(PlayerInfo[playerid][pMechSkill] >= 0 && PlayerInfo[playerid][pMechSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Mechanik: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pMechSkill]); }
	else if(PlayerInfo[playerid][pMechSkill] >= 51 && PlayerInfo[playerid][pMechSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Mechanik: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pMechSkill]); }
	else if(PlayerInfo[playerid][pMechSkill] >= 101 && PlayerInfo[playerid][pMechSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Mechanik: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pMechSkill]); } 
	else if(PlayerInfo[playerid][pMechSkill] >= 201 && PlayerInfo[playerid][pMechSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Mechanik: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pMechSkill]); } 
	else if(PlayerInfo[playerid][pMechSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Mechanik: \t- {FFD700}poziom 5", string3); }
	//BUSIARZ
	if(PlayerInfo[playerid][pCarSkill] >= 0 && PlayerInfo[playerid][pCarSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Busiarz: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pCarSkill]); }
	else if(PlayerInfo[playerid][pCarSkill] >= 51 && PlayerInfo[playerid][pCarSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Busiarz: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pCarSkill]); }
	else if(PlayerInfo[playerid][pCarSkill] >= 101 && PlayerInfo[playerid][pCarSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Busiarz: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pCarSkill]); } 
	else if(PlayerInfo[playerid][pCarSkill] >= 201 && PlayerInfo[playerid][pCarSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Busiarz: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pCarSkill]); } 
	else if(PlayerInfo[playerid][pCarSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Busiarz: \t- {FFD700}poziom 5", string3); }
	//BOKSER
	if(PlayerInfo[playerid][pBoxSkill] >= 0 && PlayerInfo[playerid][pBoxSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Bokser: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pBoxSkill]); }
	else if(PlayerInfo[playerid][pBoxSkill] >= 51 && PlayerInfo[playerid][pBoxSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Bokser: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pBoxSkill]); }
	else if(PlayerInfo[playerid][pBoxSkill] >= 101 && PlayerInfo[playerid][pBoxSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Bokser: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pBoxSkill]); } 
	else if(PlayerInfo[playerid][pBoxSkill] >= 201 && PlayerInfo[playerid][pBoxSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Bokser: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pBoxSkill]); } 
	else if(PlayerInfo[playerid][pBoxSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Bokser: \t- {FFD700}poziom 5", string3); }
	//DILER BRONI
	if(PlayerInfo[playerid][pGunSkill] >= 0 && PlayerInfo[playerid][pGunSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Broni: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pGunSkill]); }
	else if(PlayerInfo[playerid][pGunSkill] >= 51 && PlayerInfo[playerid][pGunSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Broni: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pGunSkill]); }
	else if(PlayerInfo[playerid][pGunSkill] >= 101 && PlayerInfo[playerid][pGunSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Broni: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pGunSkill]); } 
	else if(PlayerInfo[playerid][pGunSkill] >= 201 && PlayerInfo[playerid][pGunSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Broni: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pGunSkill]); } 
	else if(PlayerInfo[playerid][pGunSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Diler Broni: \t- {FFD700}poziom 5", string3); }
	//KURIER
	if(PlayerInfo[playerid][pTruckSkill] >= 0 && PlayerInfo[playerid][pTruckSkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Kurier: \t\t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pTruckSkill]); }
	else if(PlayerInfo[playerid][pTruckSkill] >= 51 && PlayerInfo[playerid][pTruckSkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Kurier: \t\t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pTruckSkill]); }
	else if(PlayerInfo[playerid][pTruckSkill] >= 101 && PlayerInfo[playerid][pTruckSkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Kurier: \t\t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pTruckSkill]); } 
	else if(PlayerInfo[playerid][pTruckSkill] >= 201 && PlayerInfo[playerid][pTruckSkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Kurier: \t\t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pTruckSkill]); } 
	else if(PlayerInfo[playerid][pTruckSkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Kurier: \t\t- {FFD700}poziom 5", string3); }
	//PIZZABOY
	if(PlayerInfo[playerid][pPizzaboySkill] >= 0 && PlayerInfo[playerid][pPizzaboySkill] <= 50){ format(string3, sizeof(string3), "%s\n{d9d9d9}Pizzaboy: \t- poziom 1 [%d/50]", string3, PlayerInfo[playerid][pPizzaboySkill]); }
	else if(PlayerInfo[playerid][pPizzaboySkill] >= 51 && PlayerInfo[playerid][pPizzaboySkill] <= 100) { format(string3, sizeof(string3), "%s\n{d9d9d9}Pizzaboy: \t- poziom 2 [%d/100]", string3, PlayerInfo[playerid][pPizzaboySkill]); }
	else if(PlayerInfo[playerid][pPizzaboySkill] >= 101 && PlayerInfo[playerid][pPizzaboySkill] <= 200) { format(string3, sizeof(string3), "%s\n{d9d9d9}Pizzaboy: \t- poziom 3 [%d/200]", string3, PlayerInfo[playerid][pPizzaboySkill]); } 
	else if(PlayerInfo[playerid][pPizzaboySkill] >= 201 && PlayerInfo[playerid][pPizzaboySkill] <= 400) { format(string3, sizeof(string3), "%s\n{d9d9d9}Pizzaboy: \t- poziom 4 [%d/400]", string3, PlayerInfo[playerid][pPizzaboySkill]); } 
	else if(PlayerInfo[playerid][pPizzaboySkill] >= 401) { format(string3, sizeof(string3), "%s\n{d9d9d9}Pizzaboy: \t- {FFD700}poziom 5", string3); }

	return ShowPlayerDialogEx(playerid, DIALOG_STATS_UMIEJETNOSCI, DIALOG_STYLE_LIST, "Umiej�tno�ci postaci", string3, "Zamknij", "");
}

PokazStatyDialog(playerid)
{
	new Float:armor;
	GetPlayerArmour(playerid, armor);
	new Float:zycie;
	GetPlayerHealth(playerid, zycie);
	new string[1024];
	new naglowek[1024];
	new name[MAX_PLAYER_NAME];
	if(!GetPVarString(playerid, "maska_nick", name, MAX_PLAYER_NAME)) GetPlayerName(playerid, name, sizeof(name));
	//zmienne
	new level = PlayerInfo[playerid][pLevel];
	new account = PlayerInfo[playerid][pAccount];
	new cash = kaska[playerid];
	new age = PlayerInfo[playerid][pAge];
	new pnumber = GetPhoneNumber(playerid);
	new jtext[20];
    format(jtext, 20, "%s", JobNames[PlayerInfo[playerid][pJob]]);
	new skin = PlayerInfo[playerid][pSkin];
	new nxtlevel = PlayerInfo[playerid][pLevel]+1;
	new expamount = nxtlevel*levelexp;
	new exp = PlayerInfo[playerid][pExp];
	new ptime = PlayerInfo[playerid][pConnectTime];
	new minuty = 0, godziny = 0, sekundy = PlayerInfo[playerid][pDutyTime];
	godziny = floatround( sekundy / 3600 );
	minuty = floatround( sekundy / 60 % 60 );
	//
	new atext[20];
	if(PlayerInfo[playerid][pSex] == 1) { atext = "M�czyzna"; }
	else if(PlayerInfo[playerid][pSex] == 2) { atext = "Kobieta"; }
  	new otext[20];
	if(PlayerInfo[playerid][pOrigin] == 1) { otext = "USA"; }
	else if(PlayerInfo[playerid][pOrigin] == 2) { otext = "Europa"; }
	else if(PlayerInfo[playerid][pOrigin] == 3) { otext = "Azja"; }
	new warny = PlayerInfo[playerid][pWarns];
	
	
	if(IsPlayerPremiumOld(playerid)) { format(naglowek, sizeof(naglowek),">>> {ffd700}%s{FFFFFF} (({8FCB04}%s{FFFFFF})) ({8FCB04}UID: %d{FFFFFF} {8FCB04}GID: %d{FFFFFF}) <<<",name, PlayerInfo[playerid][pNickOOC], PlayerInfo[playerid][pUID], PlayerInfo[playerid][pGID]);}
	else { format(naglowek, sizeof(naglowek),">>> %s (({8FCB04}%s{FFFFFF})) ({8FCB04}UID: %d{FFFFFF} {8FCB04}GID: %d{FFFFFF}) <<<",name, PlayerInfo[playerid][pNickOOC], PlayerInfo[playerid][pUID], PlayerInfo[playerid][pGID]); }

	if(zycie >= 75)
	{
		format(string, sizeof(string), "Zdrowie:\t\t{228B22}%0.1f HP", zycie);
	}
	else if (zycie < 75 && zycie >= 50)
	{
		format(string, sizeof(string), "Zdrowie:\t\t{98FB98}%0.1f HP", zycie);
	}
	else if (zycie < 50 && zycie >= 25)
	{
		format(string, sizeof(string), "Zdrowie:\t\t{DAA520}%0.1f HP", zycie);
	}
	else if (zycie < 25) 
	{
		format(string, sizeof(string), "Zdrowie:\t\t{B22222}%0.1f HP", zycie);
	}

	format(string, sizeof(string), "%s\nPancerz:\t\t%0.1f", string, armor);
	format(string, sizeof(string), "%s\nLevel:\t\t\t%d, Respekt:[%d/%d]", string, level,exp,expamount);
	if (cash > 0) { format(string, sizeof(string), "%s\nGot�wka:\t\t{9ACD32}%d$", string, cash); }
	else if (cash == 0) { format(string, sizeof(string), "%s\nGot�wka:\t\t{fffafa}%d$", string, cash); }
	else if (cash < 0) { format(string, sizeof(string), "%s\nGot�wka:\t\t{ff0000}%d$", string, cash); }
	if (account > 0) { format(string, sizeof(string), "%s\nBank:\t\t\t{9ACD32}%d$", string, account); }
	else if (account == 0) { format(string, sizeof(string), "%s\nBank:\t\t\t{fffafa}%d$", string, account); }
	else if (account < 0) { format(string, sizeof(string), "%s\nBank:\t\t\t{ff0000}%d$", string, account); }
	format(string, sizeof(string), "%s\nDane podstawowe:\t%s, %dlat, %s", string, atext,age,otext);
	format(string, sizeof(string), "%s\nSkin:\t\t\t%d", string, skin);
	format(string, sizeof(string), "%s\nNumer telefonu:\t%d", string, pnumber);
	format(string, sizeof(string), "%s\nPraca dorywcza:\t%s", string, jtext);
	format(string, sizeof(string), "%s\nCzas duty:\t\t%d godzin %d minut", string, godziny, minuty);
	format(string, sizeof(string), "%s\nGodziny online:\t\t%d", string, ptime);
	format(string, sizeof(string), "%s\nWarny:\t\t%d", string, warny);
	format(string, sizeof(string), "%s\n{d9d9d9}---", string);
	format(string, sizeof(string), "%s\n\t{d9d9d9}Wy�wietl posiadane dokumenty", string);
	format(string, sizeof(string), "%s\n\t{d9d9d9}Wy�wietl posiadane tatua�e", string);
	format(string, sizeof(string), "%s\n\t{d9d9d9}Wy�wietl statystyki postaci", string);
	format(string, sizeof(string), "%s\n\t{d9d9d9}Wy�wietl umiej�tno�ci postaci", string);
	format(string, sizeof(string), "%s\n\t{d9d9d9}Wy�wietl umiej�tno�ci strzelania", string);

	ShowPlayerDialogEx(playerid, DIALOG_STATS, DIALOG_STYLE_LIST, naglowek, string, "Zamknij", "");
}

SetPlayerToTeamColor(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(OnDuty[playerid] < 1) return SetPlayerColor(playerid,TEAM_HIT_COLOR);
		new group = GetPlayerGroupUID(playerid, OnDuty[playerid]-1);
	    if(group == FRAC_LSPD)
		{
		    SetPlayerColor(playerid, COLOR_LIGHTBLUE);
		}
		else if(group == FRAC_FBI)
		{
			SetPlayerColor(playerid, 0x5E1FABFF);
		}
		else if(group == FRAC_NG)
		{
		    SetPlayerColor(playerid, COLOR_GREEN);
		}
		else if(group == FRAC_ERS)
		{
		    SetPlayerColor(playerid, COLOR_LIGHTRED);
		}
		else if(group == FRAC_BOR)
		{
		    SetPlayerColor(playerid, COLOR_PURPLE);
		}
		else if(group == FRAC_SN)
		{
		    SetPlayerColor(playerid, COLOR_NEWS);
		}
		else if(group == FRAC_KT)
		{
		    SetPlayerColor(playerid, COLOR_YELLOW);
		}
		else if(group == FRAC_GOV)
		{
		    SetPlayerColor(playerid, COLOR_LIGHTGREEN);
		}
		else if(group == 17)
		{
			SetPlayerColor(playerid, COLOR_LSFD);
		}
        else SetPlayerColor(playerid,TEAM_HIT_COLOR);
	}
	return 1;
}

LoadBoxer()
{
	new arrCoords[3][64];
	new strFromFile2[256];
	new File: file = fopen("boxer.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, ',');
		Titel[TitelWins] = strval(arrCoords[0]);
		strmid(Titel[TitelName], arrCoords[1], 0, strlen(arrCoords[1]), 255);
		Titel[TitelLoses] = strval(arrCoords[2]);
		fclose(file);
	}
	return 1;
}

SaveBoxer()
{
	new coordsstring[256];
	format(coordsstring, sizeof(coordsstring), "%d,%s,%d", Titel[TitelWins],Titel[TitelName],Titel[TitelLoses]);
	new File: file2 = fopen("boxer.ini", io_write);
    if(file2)
    {
    	fwrite(file2, coordsstring);
    	fclose(file2);
    }
	return 1;
}

LoadStuff()
{
	new arrCoords[4][64];
	new strFromFile2[256];
	new File: file = fopen("stuff.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, ',');
		Jackpot = strval(arrCoords[0]);
		Tax = strval(arrCoords[1]);
		TaxValue = strval(arrCoords[2]);
		Security = strval(arrCoords[3]);
		fclose(file);
	}
	return 1;
}

SaveStuff()
{
	new coordsstring[256];
	format(coordsstring, sizeof(coordsstring), "%d,%d,%d,%d", Jackpot,Tax,TaxValue,Security);
	new File: file2 = fopen("stuff.ini", io_write);
    if(file2)
    {
        fwrite(file2, coordsstring);
    	fclose(file2);
    }
	return 1;
}

LoadIRC()
{
	new arrCoords[5][64];
	new strFromFile2[256];
	new File: file = fopen("channels.cfg", io_read);
	if (file)
	{
		new idx;
		while(idx < sizeof(IRCInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(IRCInfo[idx][iAdmin], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			strmid(IRCInfo[idx][iMOTD], arrCoords[1], 0, strlen(arrCoords[1]), 255);
			strmid(IRCInfo[idx][iPassword], arrCoords[2], 0, strlen(arrCoords[2]), 255);
			IRCInfo[idx][iNeedPass] = strval(arrCoords[3]);
			IRCInfo[idx][iLock] = strval(arrCoords[4]);
			idx++;
		}
		fclose(file);
	}
	return 1;
}

SaveIRC()
{
	new idx;
	new File: file2;
	while(idx < sizeof(IRCInfo))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%s|%s|%s|%d|%d\n",
		IRCInfo[idx][iAdmin],
		IRCInfo[idx][iMOTD],
		IRCInfo[idx][iPassword],
		IRCInfo[idx][iNeedPass],
		IRCInfo[idx][iLock]);
		if(idx == 0)
		{
			file2 = fopen("channels.cfg", io_write);
		}
		else
		{
			file2 = fopen("channels.cfg", io_append);
		}
		if(file2)
        {
            fwrite(file2, coordsstring);
    		fclose(file2);
        }
        idx++;
	}
	return 1;
}

//--------------------------------------------------- SYTEM ORGANIZACJI --------------------------------------------
//DO USUNI�CIA

HasPerm(playerid, perm) //old function
{
	return CheckPlayerPerm(playerid, perm);
}
GetPlayerOrg(playerid) return PlayerInfo[playerid][pOrg];

orgID(uid)
{
    for(new i=0;i<MAX_ORG;i++)
    {
        if(OrgInfo[i][o_UID] == uid)
        {
            return i;
        }
    }
    return 0xFFFF;
}

GetFractionMembersNumber(fractionid, bool:withOnDutyCheck)
{
	new membersNumber;
	foreach(new i : Player)
	{
		if(IsPlayerInGroup(i, fractionid))
		{
			new slot = GetPlayerGroupSlot(i, fractionid);
			if(slot == 0) continue;
			if(withOnDutyCheck)
			{
				if(fractionid == FRAC_SN && SanDuty[i] == 0)
					continue;
				if(OnDuty[i] != slot)
					continue;
			}
			membersNumber++;
		}
	}
	return membersNumber;
}


GetClosestPlayer(p1)
{
	new x,Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	for(x=0;x<MAX_PLAYERS;x++)
	{
		if(IsPlayerConnected(x))
		{
			if(x != p1)
			{
				dis2 = GetDistanceBetweenPlayers(x,p1);
				if(dis2 < dis && dis2 != -1.00)
				{
					dis = dis2;
					player = x;
				}
			}
		}
	}
	return player;
}

ZaladujTrasy()
{
	new trasaS[24];
	new numerCH[12];
	new s, e;
	s = GetTickCount();
    for(new i=0; i<sizeof(Wyscig); i++)
	{
	    format(trasaS, sizeof(trasaS), "Inne/trasa_%d.ini", i);
	    if(dini_Exists(trasaS))
	    {
		    Wyscig[i][wStworzony] = dini_Int(trasaS, "Stworzony");
			strcat(Wyscig[i][wNazwa], dini_Get(trasaS, "Nazwa"), 20);
			strcat(Wyscig[i][wOpis], dini_Get(trasaS, "Opis"), 50);
			Wyscig[i][wCheckpointy] = dini_Int(trasaS, "Checkpointy");
			Wyscig[i][wNagroda] = dini_Int(trasaS, "Nagroda");
			Wyscig[i][wTypCH] = dini_Int(trasaS, "TypCH");
			Wyscig[i][wRozmiarCH] = dini_Float(trasaS, "Rozmiar");
			for(new ii; ii<MAX_CHECKPOINTS; ii++)
			{
			    format(numerCH, sizeof(numerCH), "CH%d_x", ii);
				wCheckpoint[i][ii][0] = dini_Float(trasaS, numerCH);
				format(numerCH, sizeof(numerCH), "CH%d_y", ii);
		  		wCheckpoint[i][ii][1] = dini_Float(trasaS, numerCH);
		  		format(numerCH, sizeof(numerCH), "CH%d_z", ii);
		    	wCheckpoint[i][ii][2] = dini_Float(trasaS, numerCH);
		    }
		}
		else
		{
		    dini_Create(trasaS);
			dini_IntSet(trasaS, "Stworzony", 0);
			dini_Set(trasaS, "Nazwa", "Wolne");
			dini_Set(trasaS, "Opis", "Brak");
			dini_IntSet(trasaS, "Checkpointy", 0);
			dini_IntSet(trasaS, "Nagroda", 0);
			dini_IntSet(trasaS, "TypCH", 0);
			dini_IntSet(trasaS, "TypW", 0);
			dini_FloatSet(trasaS, "Rozmiar", 0);
			for(new ii; ii<MAX_CHECKPOINTS; ii++)
			{
			    format(numerCH, sizeof(numerCH), "CH%d_x", ii);
			    dini_FloatSet(trasaS, numerCH, 0);
				format(numerCH, sizeof(numerCH), "CH%d_y", ii);
			    dini_FloatSet(trasaS, numerCH, 0);
			    format(numerCH, sizeof(numerCH), "CH%d_z", ii);
			    dini_FloatSet(trasaS, numerCH, 0);
		    }
		    Wyscig[i][wStworzony] = dini_Int(trasaS, "Stworzony");
			strcat(Wyscig[i][wNazwa], dini_Get(trasaS, "Nazwa"), 20);
			strcat(Wyscig[i][wOpis], dini_Get(trasaS, "Opis"), 50);
			Wyscig[i][wCheckpointy] = dini_Int(trasaS, "Checkpointy");
			Wyscig[i][wNagroda] = dini_Int(trasaS, "Nagroda");
			Wyscig[i][wTypCH] = dini_Int(trasaS, "TypCH");
			Wyscig[i][wRozmiarCH] = dini_Float(trasaS, "Rozmiar");
			for(new ii; ii<MAX_CHECKPOINTS; ii++)
			{
			    format(numerCH, sizeof(numerCH), "CH%d_x", ii);
				wCheckpoint[i][ii][0] = dini_Float(trasaS, numerCH);
				format(numerCH, sizeof(numerCH), "CH%d_y", ii);
		  		wCheckpoint[i][ii][1] = dini_Float(trasaS, numerCH);
		  		format(numerCH, sizeof(numerCH), "CH%d_z", ii);
		    	wCheckpoint[i][ii][2] = dini_Float(trasaS, numerCH);
		    }
		}
	}
	e = GetTickCount();
	printf("DINI1: LADOWANIE TRAS czas wykonania: %d", e-s);
	return 1;
}

ZapiszTrase(trasa)
{
	new trasaS[24];
	new numerCH[12];
    format(trasaS, sizeof(trasaS), "Inne/trasa_%d.ini", trasa);
    dini_IntSet(trasaS, "Stworzony", Wyscig[trasa][wStworzony]);
	dini_Set(trasaS, "Nazwa", Wyscig[trasa][wNazwa]);
	dini_Set(trasaS, "Opis", Wyscig[trasa][wOpis]);
	dini_IntSet(trasaS, "Checkpointy", Wyscig[trasa][wCheckpointy]);
	dini_IntSet(trasaS, "Nagroda", Wyscig[trasa][wNagroda]);
	dini_IntSet(trasaS, "TypCH", Wyscig[trasa][wTypCH]);
	dini_FloatSet(trasaS, "Rozmiar", Wyscig[trasa][wRozmiarCH]);
	for(new ii; ii<MAX_CHECKPOINTS; ii++)
	{
	    format(numerCH, sizeof(numerCH), "CH%d_x", ii);
	    dini_FloatSet(trasaS, numerCH, wCheckpoint[trasa][ii][0]);
		format(numerCH, sizeof(numerCH), "CH%d_y", ii);
	    dini_FloatSet(trasaS, numerCH, wCheckpoint[trasa][ii][1]);
	    format(numerCH, sizeof(numerCH), "CH%d_z", ii);
	    dini_FloatSet(trasaS, numerCH, wCheckpoint[trasa][ii][2]);
    }
	return 1;
}


public MRP_ShopPurchaseCar(playerid, model, cena)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_GRAD2, "Wyjd� z pojazdu.");
        return 0;
    }
    new komunikat[256];

    if(CountPlayerCars(playerid) >= PlayerInfo[playerid][pCarSlots])
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Nie masz wolnych slot�w.");
        return 0;
    }
    new losuj = random(sizeof(LosowyParking));
	new losuj2 = random(sizeof(LosowyParkingLodz));
	new losuj3 = random(sizeof(LosowyParkingLot));
	new losuj4 = random(sizeof(LosowyParkingHeli));
	new carid;
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));

    //Create
    if(IsABoatModel(model))
	{
	    carid = Car_Create(model, LosowyParkingLodz[losuj2][0],LosowyParkingLodz[losuj2][1],LosowyParkingLodz[losuj2][2], LosowyParkingLodz[losuj2][3], 228, 228);
	}
	else if(IsAPlaneModel(model))
	{
	    carid = Car_Create(model, LosowyParkingLot[losuj3][0],LosowyParkingLot[losuj3][1],LosowyParkingLot[losuj3][2], LosowyParkingLot[losuj3][3], 228, 228);
	}
	else if(IsAHeliModel(model))
	{
	    carid = Car_Create(model, LosowyParkingLot[losuj4][0],LosowyParkingHeli[losuj4][1],LosowyParkingHeli[losuj4][2], LosowyParkingHeli[losuj4][3], 228, 228);
	}
    else carid = Car_Create(model, LosowyParking[losuj][0],LosowyParking[losuj][1],LosowyParking[losuj][2], LosowyParking[losuj][3], 228, 228);

    if(carid == -1)
    {
        SendClientMessage(playerid, COLOR_PANICRED, "Nie mo�na stworzy� pojazdu! Rekord nie zosta� dodany do bazy.");
        return 0;
    }
    //Assign
    Car_MakePlayerOwner(playerid, carid);
	
	ZabierzMC(playerid, cena);

    //Info
    format(komunikat, sizeof(komunikat), "Kupi�e� unikatowy %s za %d MC. Komendy auta znajdziesz w /auto. Gratulujemy zakupu!",VehicleNames[model-400], cena);

    _MruAdmin(playerid, komunikat);

	Log(premiumLog, WARNING, "%s kupi� unikatowy pojazd %s za %dMC", GetPlayerLogName(playerid), GetVehicleLogName(CarData[carid][c_ID]), cena);
    //TODO
    if(carid >= MAX_CARS)
    {
        sendErrorMessage(playerid, "Nie mo�na stworzy� pojazdu! Mo�liwe przepe�nienie, auto zosta�o kupione lecz nie mo�esz go u�y�.");
        return 1;
    }
	PutPlayerInVehicleEx(playerid, CarData[carid][c_ID], 0);
	return 1;
}

KupowaniePojazdu(playerid, model, kolor1, kolor2, cena)
{
    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GRAD2, "Wyjd� z pojazdu.");
    new komunikat[256];
	if(kaska[playerid] >= cena)
	{
	    if(model >= 400 && model <= 611)
	    {
            if(CountPlayerCars(playerid) >= PlayerInfo[playerid][pCarSlots]) return SendClientMessage(playerid, COLOR_YELLOW, "Nie masz wolnych slot�w.");
			new losuj = random(sizeof(LosowyParking));
			new losuj2 = random(sizeof(LosowyParkingLodz));
			new losuj3 = random(sizeof(LosowyParkingLot));
			new losuj4 = random(sizeof(LosowyParkingHeli));
			new carid;
			new nick[MAX_PLAYER_NAME];
			GetPlayerName(playerid, nick, sizeof(nick));

            //Create
            if(IsABoatModel(model))
			{
			    carid = Car_Create(model, LosowyParkingLodz[losuj2][0],LosowyParkingLodz[losuj2][1],LosowyParkingLodz[losuj2][2], LosowyParkingLodz[losuj2][3], kolor1, kolor2);
			}
			else if(IsAPlaneModel(model))
			{
			    carid = Car_Create(model, LosowyParkingLot[losuj3][0],LosowyParkingLot[losuj3][1],LosowyParkingLot[losuj3][2], LosowyParkingLot[losuj3][3], kolor1, kolor2);
			}
			else if(IsAHeliModel(model))
			{
			    carid = Car_Create(model, LosowyParkingLot[losuj4][0],LosowyParkingHeli[losuj4][1],LosowyParkingHeli[losuj4][2], LosowyParkingHeli[losuj4][3], kolor1, kolor2);
			}
            else carid = Car_Create(model, LosowyParking[losuj][0],LosowyParking[losuj][1],LosowyParking[losuj][2], LosowyParking[losuj][3], kolor1, kolor2);

            if(carid == -1) return SendClientMessage(playerid, COLOR_PANICRED, "Nie mo�na stworzy� pojazdu! Rekord nie zosta� dodany do bazy.");
            //Assign
            Car_MakePlayerOwner(playerid, carid);

            //Info
            format(komunikat, sizeof(komunikat), "Kupi�e� %s za %d$. Komendy auta znajdziesz w /auto. Gratulujemy zakupu!",VehicleNames[model-400], cena);
			SendClientMessage(playerid,COLOR_NEWS, komunikat);

            ZabierzKaseDone(playerid, cena);
			FirstCar(playerid);
			EXPPlayerBuyCar(playerid, cena);

			Log(payLog, WARNING, "%s kupi� pojazd %s za %d$", GetPlayerLogName(playerid), GetVehicleLogName(CarData[carid][c_ID]), cena);
            //TODO
            if(carid >= MAX_CARS) return SendClientMessage(playerid, COLOR_PANICRED, "Nie mo�na stworzy� pojazdu! Mo�liwe przepe�nienie, auto zosta�o kupione lecz nie mo�esz go u�y�.");

			PutPlayerInVehicleEx(playerid, CarData[carid][c_ID], 0);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_WHITE, "B��D - z�y model! Zg�o� okoliczno�ci na forum.");
		}
	}
	else
 	{
 	    format(komunikat, sizeof(komunikat), "Nie sta� Ci� na zakup tego pojazdu. Kosztuje on %d$ a Ty posiadasz tylko %d$.",cena, kaska[playerid]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, komunikat);
	}
	return 1;
}

ZaladujDomy()
{
	new string[256];
	if(dini_Exists("Domy/NRD.ini"))
	{
	    for(new i = 0; i <= dini_Int("Domy/NRD.ini", "NrDomow"); i++)
	    {
	        format(string, sizeof(string), "Domy/Dom%d.ini", i);
	        if(dini_Exists(string))
	        {
	            new GeT[MAX_PLAYER_NAME];
	            new message[128];
	            new SEJF[20];
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Wlasciciel"));
    			Dom[i][hID] = i;
    			Dom[i][hDomNr] = dini_Int(string, "DomNr");
    			Dom[i][hZamek] = dini_Int(string, "Zamek");
				Dom[i][hWlasciciel] = GeT;
				Dom[i][hKupiony] = dini_Int(string, "Kupiony");
				Dom[i][hBlokada] = dini_Int(string, "Blokada");
				Dom[i][hOplata] = dini_Int(string, "Dodatkowa_Oplata");
				format(message, sizeof(message), "%s", dini_Get(string, "Komunikat_Wynajmu"));
				Dom[i][hKomunikatWynajmu] = message;
				Dom[i][hCena] = dini_Int(string, "Cena");
				Dom[i][hUID_W] = dini_Int(string, "UID_Wlascicela");
				Dom[i][hData_DD] = dini_Int(string, "Data");
				Dom[i][hWej_X] = dini_Float(string, "Wej_X");
				Dom[i][hWej_Y] = dini_Float(string, "Wej_Y");
				Dom[i][hWej_Z] = dini_Float(string, "Wej_Z");
				Dom[i][hInt_X] = dini_Float(string, "Int_X");
				Dom[i][hInt_Y] = dini_Float(string, "Int_Y");
				Dom[i][hInt_Z] = dini_Float(string, "Int_Z");
				Dom[i][hInterior] = dini_Int(string, "Interior");
				Dom[i][hParcela] = dini_Int(string, "Parcela");
				Dom[i][hVW] = dini_Int(string, "VirtualWorld");
				Dom[i][hSwiatlo] = dini_Int(string, "Oswietlenie");
				Dom[i][hPokoje] = dini_Int(string, "Pokoje");
				Dom[i][hPDW] = dini_Int(string, "Pokoi_Dowynajecia");
				Dom[i][hPW] = dini_Int(string, "Pokoi_Wynajmowanych");
                if(Dom[i][hPW] < 0) Dom[i][hPW] = 0;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator1"));
				Dom[i][hL1] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator2"));
				Dom[i][hL2] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator3"));
				Dom[i][hL3] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator4"));
				Dom[i][hL4] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator5"));
				Dom[i][hL5] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator6"));
				Dom[i][hL6] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator7"));
				Dom[i][hL7] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator8"));
				Dom[i][hL8] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator9"));
				Dom[i][hL9] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator10"));
				Dom[i][hL10] = GeT;
				Dom[i][hWynajem] = dini_Int(string, "Wynajmowanie");
				Dom[i][hWW] = dini_Int(string, "Warunek_Wynajmu");
				Dom[i][hTWW] = dini_Int(string, "Tryb_WW");
				Dom[i][hCenaWynajmu] = dini_Int(string, "CenaWynajmu");
				Dom[i][hKomunikatDomowy] = dini_Int(string, "KomunikatDomowy");
				Dom[i][hUL_Z] = dini_Int(string, "Uprawnienia_Lokatorow_Zamek");
				Dom[i][hUL_D] = dini_Int(string, "Uprawnienia_Lokatorow_Dodatki");
				Dom[i][hApteczka] = dini_Int(string, "Apteczka");
				Dom[i][hKami] = dini_Int(string, "Kamizelka");
				Dom[i][hSejf] = dini_Int(string, "Sejf");
				format(SEJF, sizeof(SEJF), "%s", dini_Get(string, "Kod_Do_Sejfu"));
				Dom[i][hKodSejf] = SEJF;
				Dom[i][hZbrojownia] = dini_Int(string, "Zbrojownia");
				Dom[i][hGaraz] = dini_Int(string, "Garaz");
				Dom[i][hLadowisko] = dini_Int(string, "Ladowisko");
				Dom[i][hAlarm] = dini_Int(string, "Alarm");
				Dom[i][hZamekD] = dini_Int(string, "Zamek_Dodatkowy");
				Dom[i][hKomputer] = dini_Int(string, "Komputer");
				Dom[i][hRTV] = dini_Int(string, "Sprzet_RTV");
				Dom[i][hHazard] = dini_Int(string, "Zestaw_Hazardowy");
				Dom[i][hSzafa] = dini_Int(string, "Szafa");
				Dom[i][hTajemnicze] = dini_Int(string, "Tajemniczy_Dodatek");
				Dom[i][hS_kasa] = dini_Int(string, "S_kasa");
				Dom[i][hS_mats] = dini_Int(string, "S_mats");
				Dom[i][hS_ziolo] = dini_Int(string, "S_ziolo");
				Dom[i][hS_drugs] = dini_Int(string, "S_drugs");
				Dom[i][hS_PG1] = dini_Int(string, "S_PG1");
				Dom[i][hS_PG2] = dini_Int(string, "S_PG2");
				Dom[i][hS_PG3] = dini_Int(string, "S_PG3");
				Dom[i][hS_PG4] = dini_Int(string, "S_PG4");
				Dom[i][hS_PG5] = dini_Int(string, "S_PG5");
				Dom[i][hS_PG6] = dini_Int(string, "S_PG6");
				Dom[i][hS_PG7] = dini_Int(string, "S_PG7");
				Dom[i][hS_PG8] = dini_Int(string, "S_PG8");
				Dom[i][hS_PG9] = dini_Int(string, "S_PG9");
				Dom[i][hS_PG10] = dini_Int(string, "S_PG10");
				Dom[i][hS_PG11] = dini_Int(string, "S_PG11");
				Dom[i][hS_G0] = dini_Int(string, "S_G0");
				Dom[i][hS_G1] = dini_Int(string, "S_G1");
				Dom[i][hS_G2] = dini_Int(string, "S_G2");
				Dom[i][hS_G3] = dini_Int(string, "S_G3");
				Dom[i][hS_G4] = dini_Int(string, "S_G4");
				Dom[i][hS_G5] = dini_Int(string, "S_G5");
				Dom[i][hS_G6] = dini_Int(string, "S_G6");
				Dom[i][hS_G7] = dini_Int(string, "S_G7");
				Dom[i][hS_G8] = dini_Int(string, "S_G8");
				Dom[i][hS_G9] = dini_Int(string, "S_G9");
				Dom[i][hS_G10] = dini_Int(string, "S_G10");
				Dom[i][hS_G11] = dini_Int(string, "S_G11");
				Dom[i][hS_A1] = dini_Int(string, "S_A1");
				Dom[i][hS_A2] = dini_Int(string, "S_A2");
				Dom[i][hS_A3] = dini_Int(string, "S_A3");
				Dom[i][hS_A4] = dini_Int(string, "S_A4");
				Dom[i][hS_A5] = dini_Int(string, "S_A5");
				Dom[i][hS_A6] = dini_Int(string, "S_A6");
				Dom[i][hS_A7] = dini_Int(string, "S_A7");
				Dom[i][hS_A8] = dini_Int(string, "S_A8");
				Dom[i][hS_A9] = dini_Int(string, "S_A9");
				Dom[i][hS_A10] = dini_Int(string, "S_A10");
				Dom[i][hS_A11] = dini_Int(string, "S_A11");
				if(Dom[i][hKupiony] == 0)
				{
				    Dom[i][hPickup] = CreateDynamicPickup(1273, 1, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z], 0, 0, -1, 125.0);
				}
				else
				{
				    Dom[i][hPickup] = CreateDynamicPickup(1239, 1, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z], 0, 0, -1, 125.0);
					if(Dom[i][hWynajem] != 0)
					{
					}
				}
	        }
	    }
	}
	else
	{
	    dini_Create("Domy/NRD.ini");
	    dini_IntSet("Domy/NRD.ini", "NrDomow", 0);
	}
	return 1;
}

ZapiszDomy()
{
	new string[256];
    for(new i = 0; i <= dini_Int("Domy/NRD.ini", "NrDomow"); i++)
    {
    	format(string, sizeof(string), "Domy/Dom%d.ini", i);
     	if(dini_Exists(string))
      	{
   			dini_IntSet(string, "DomNr", Dom[i][hDomNr]);
			dini_Set(string, "Wlasciciel", Dom[i][hWlasciciel]);
			dini_IntSet(string, "Zamek", Dom[i][hZamek]);
			dini_IntSet(string, "Kupiony", Dom[i][hKupiony]);
			dini_IntSet(string, "Blokada", Dom[i][hBlokada]);
		 	dini_IntSet(string, "Dodatkowa_Oplata", Dom[i][hOplata]);
		 	dini_Set(string, "Komunikat_Wynajmu", Dom[i][hKomunikatWynajmu]);
		 	dini_IntSet(string, "Cena", Dom[i][hCena]);
			dini_IntSet(string, "UID_Wlascicela", Dom[i][hUID_W]);
			dini_IntSet(string, "Data", Dom[i][hData_DD]);
			dini_FloatSet(string, "Wej_X", Dom[i][hWej_X]);
			dini_FloatSet(string, "Wej_Y", Dom[i][hWej_Y]);
			dini_FloatSet(string, "Wej_Z", Dom[i][hWej_Z]);
			dini_FloatSet(string, "Int_X", Dom[i][hInt_X]);
			dini_FloatSet(string, "Int_Y", Dom[i][hInt_Y]);
			dini_FloatSet(string, "Int_Z", Dom[i][hInt_Z]);
			dini_IntSet(string, "Interior", Dom[i][hInterior]);
			dini_IntSet(string, "Parcela", Dom[i][hParcela]);
			dini_IntSet(string, "VirtualWorld", Dom[i][hVW]);
			dini_IntSet(string, "Oswietlenie", Dom[i][hSwiatlo]);
			dini_IntSet(string, "Pokoje", Dom[i][hPokoje]);
			dini_IntSet(string, "Pokoi_Dowynajecia", Dom[i][hPDW]);
			dini_IntSet(string, "Pokoi_Wynajmowanych", Dom[i][hPW]);
			dini_Set(string, "Lokator1", Dom[i][hL1]);
			dini_Set(string, "Lokator2", Dom[i][hL2]);
			dini_Set(string, "Lokator3", Dom[i][hL3]);
			dini_Set(string, "Lokator4", Dom[i][hL4]);
			dini_Set(string, "Lokator5", Dom[i][hL5]);
			dini_Set(string, "Lokator6", Dom[i][hL6]);
			dini_Set(string, "Lokator7", Dom[i][hL7]);
			dini_Set(string, "Lokator8", Dom[i][hL8]);
			dini_Set(string, "Lokator9", Dom[i][hL9]);
			dini_Set(string, "Lokator10", Dom[i][hL10]);
			dini_IntSet(string, "Wynajmowanie", Dom[i][hWynajem]);
			dini_IntSet(string, "CenaWynajmu", Dom[i][hCenaWynajmu]);
            dini_IntSet(string, "KomunikatDomowy", Dom[i][hKomunikatDomowy]);
			dini_IntSet(string, "Uprawnienia_Lokatorow_Zamek", Dom[i][hUL_Z]);
			dini_IntSet(string, "Uprawnienia_Lokatorow_Dodatki", Dom[i][hUL_D]);
            dini_IntSet(string, "Warunek_Wynajmu", Dom[i][hWW]);
            dini_IntSet(string, "Tryb_WW", Dom[i][hTWW]);
			dini_IntSet(string, "Apteczka", Dom[i][hApteczka]);
			dini_IntSet(string, "Kamizelka", Dom[i][hKami]);
			dini_IntSet(string, "Sejf", Dom[i][hSejf]);
			dini_Set(string, "Kod_Do_Sejfu", Dom[i][hKodSejf]);
			dini_IntSet(string, "Zbrojownia", Dom[i][hZbrojownia]);
			dini_IntSet(string, "Garaz", Dom[i][hGaraz]);
			dini_IntSet(string, "Ladowisko", Dom[i][hLadowisko]);
			dini_IntSet(string, "Alarm", Dom[i][hAlarm]);
		 	dini_IntSet(string, "Zamek_Dodatkowy", Dom[i][hZamekD]);
			dini_IntSet(string, "Komputer", Dom[i][hKomputer]);
			dini_IntSet(string, "Sprzet_RTV", Dom[i][hRTV]);
			dini_IntSet(string, "Zestaw_Hazardowy", Dom[i][hHazard]);
			dini_IntSet(string, "Szafa", Dom[i][hSzafa]);
			dini_IntSet(string, "Tajemniczy_Dodatek", Dom[i][hTajemnicze]);
			dini_IntSet(string, "S_kasa", Dom[i][hS_kasa]);
			dini_IntSet(string, "S_mats", Dom[i][hS_mats]);
			dini_IntSet(string, "S_ziolo", Dom[i][hS_ziolo]);
			dini_IntSet(string, "S_drugs", Dom[i][hS_drugs]);
			dini_IntSet(string, "S_PG1", Dom[i][hS_PG1]);
			dini_IntSet(string, "S_PG2", Dom[i][hS_PG2]);
			dini_IntSet(string, "S_PG3", Dom[i][hS_PG3]);
			dini_IntSet(string, "S_PG4", Dom[i][hS_PG4]);
			dini_IntSet(string, "S_PG5", Dom[i][hS_PG5]);
			dini_IntSet(string, "S_PG6", Dom[i][hS_PG6]);
			dini_IntSet(string, "S_PG7", Dom[i][hS_PG7]);
			dini_IntSet(string, "S_PG8", Dom[i][hS_PG8]);
			dini_IntSet(string, "S_PG9", Dom[i][hS_PG9]);
			dini_IntSet(string, "S_PG10", Dom[i][hS_PG10]);
			dini_IntSet(string, "S_PG11", Dom[i][hS_PG11]);
			dini_IntSet(string, "S_G0", Dom[i][hS_G0]);
			dini_IntSet(string, "S_G1", Dom[i][hS_G1]);
			dini_IntSet(string, "S_G2", Dom[i][hS_G2]);
			dini_IntSet(string, "S_G3", Dom[i][hS_G3]);
			dini_IntSet(string, "S_G4", Dom[i][hS_G4]);
			dini_IntSet(string, "S_G5", Dom[i][hS_G5]);
			dini_IntSet(string, "S_G6", Dom[i][hS_G6]);
			dini_IntSet(string, "S_G7", Dom[i][hS_G7]);
			dini_IntSet(string, "S_G8", Dom[i][hS_G8]);
			dini_IntSet(string, "S_G9", Dom[i][hS_G9]);
			dini_IntSet(string, "S_G10", Dom[i][hS_G10]);
			dini_IntSet(string, "S_G11", Dom[i][hS_G11]);
			dini_IntSet(string, "S_A1", Dom[i][hS_A1]);
			dini_IntSet(string, "S_A2", Dom[i][hS_A2]);
			dini_IntSet(string, "S_A3", Dom[i][hS_A3]);
			dini_IntSet(string, "S_A4", Dom[i][hS_A4]);
			dini_IntSet(string, "S_A5", Dom[i][hS_A5]);
			dini_IntSet(string, "S_A6", Dom[i][hS_A6]);
			dini_IntSet(string, "S_A7", Dom[i][hS_A7]);
			dini_IntSet(string, "S_A8", Dom[i][hS_A8]);
			dini_IntSet(string, "S_A9", Dom[i][hS_A9]);
			dini_IntSet(string, "S_A10", Dom[i][hS_A10]);
			dini_IntSet(string, "S_A11", Dom[i][hS_A11]);
        }
    }
    return 1;
}

ZapiszDom(domid)
{
    new string[256];
    format(string, sizeof(string), "Domy/Dom%d.ini", domid);
  	if(dini_Exists(string))
  	{
   		dini_IntSet(string, "DomNr", Dom[domid][hDomNr]);
  		dini_Set(string, "Wlasciciel", Dom[domid][hWlasciciel]);
  		dini_IntSet(string, "Zamek", Dom[domid][hZamek]);
  		dini_IntSet(string, "Kupiony", Dom[domid][hKupiony]);
  		dini_IntSet(string, "Blokada", Dom[domid][hBlokada]);
	 	dini_IntSet(string, "Dodatkowa_Oplata", Dom[domid][hOplata]);
	 	dini_Set(string, "Komunikat_Wynajmu", Dom[domid][hKomunikatWynajmu]);
	 	dini_IntSet(string, "Cena", Dom[domid][hCena]);
		dini_IntSet(string, "UID_Wlascicela", Dom[domid][hUID_W]);
		dini_IntSet(string, "Data", Dom[domid][hData_DD]);
		dini_FloatSet(string, "Wej_X", Dom[domid][hWej_X]);
		dini_FloatSet(string, "Wej_Y", Dom[domid][hWej_Y]);
		dini_FloatSet(string, "Wej_Z", Dom[domid][hWej_Z]);
		dini_FloatSet(string, "Int_X", Dom[domid][hInt_X]);
		dini_FloatSet(string, "Int_Y", Dom[domid][hInt_Y]);
		dini_FloatSet(string, "Int_Z", Dom[domid][hInt_Z]);
		dini_IntSet(string, "Interior", Dom[domid][hInterior]);
		dini_IntSet(string, "Parcela", Dom[domid][hParcela]);
		dini_IntSet(string, "VirtualWorld", Dom[domid][hVW]);
		dini_IntSet(string, "Oswietlenie", Dom[domid][hSwiatlo]);
		dini_IntSet(string, "Pokoje", Dom[domid][hPokoje]);
		dini_IntSet(string, "Pokoi_Dowynajecia", Dom[domid][hPDW]);
		dini_IntSet(string, "Pokoi_Wynajmowanych", Dom[domid][hPW]);
		dini_Set(string, "Lokator1", Dom[domid][hL1]);
		dini_Set(string, "Lokator2", Dom[domid][hL2]);
		dini_Set(string, "Lokator3", Dom[domid][hL3]);
		dini_Set(string, "Lokator4", Dom[domid][hL4]);
		dini_Set(string, "Lokator5", Dom[domid][hL5]);
		dini_Set(string, "Lokator6", Dom[domid][hL6]);
		dini_Set(string, "Lokator7", Dom[domid][hL7]);
		dini_Set(string, "Lokator8", Dom[domid][hL8]);
		dini_Set(string, "Lokator9", Dom[domid][hL9]);
		dini_Set(string, "Lokator10", Dom[domid][hL10]);
		dini_IntSet(string, "Wynajmowanie", Dom[domid][hWynajem]);
		dini_IntSet(string, "CenaWynajmu", Dom[domid][hCenaWynajmu]);
		dini_IntSet(string, "KomunikatDomowy", Dom[domid][hKomunikatDomowy]);
		dini_IntSet(string, "Uprawnienia_Lokatorow_Zamek", Dom[domid][hUL_Z]);
		dini_IntSet(string, "Uprawnienia_Lokatorow_Dodatki", Dom[domid][hUL_D]);
		dini_IntSet(string, "Warunek_Wynajmu", Dom[domid][hWW]);
  		dini_IntSet(string, "Tryb_WW", Dom[domid][hTWW]);
		dini_IntSet(string, "Apteczka", Dom[domid][hApteczka]);
		dini_IntSet(string, "Kamizelka", Dom[domid][hKami]);
		dini_IntSet(string, "Sejf", Dom[domid][hSejf]);
		dini_Set(string, "Kod_Do_Sejfu", Dom[domid][hKodSejf]);
		dini_IntSet(string, "Zbrojownia", Dom[domid][hZbrojownia]);
		dini_IntSet(string, "Garaz", Dom[domid][hGaraz]);
		dini_IntSet(string, "Ladowisko", Dom[domid][hLadowisko]);
		dini_IntSet(string, "Alarm", Dom[domid][hAlarm]);
	 	dini_IntSet(string, "Zamek_Dodatkowy", Dom[domid][hZamekD]);
		dini_IntSet(string, "Komputer", Dom[domid][hKomputer]);
		dini_IntSet(string, "Sprzet_RTV", Dom[domid][hRTV]);
		dini_IntSet(string, "Zestaw_Hazardowy", Dom[domid][hHazard]);
		dini_IntSet(string, "Szafa", Dom[domid][hSzafa]);
		dini_IntSet(string, "Tajemniczy_Dodatek", Dom[domid][hTajemnicze]);
		dini_IntSet(string, "S_kasa", Dom[domid][hS_kasa]);
		dini_IntSet(string, "S_mats", Dom[domid][hS_mats]);
		dini_IntSet(string, "S_ziolo", Dom[domid][hS_ziolo]);
		dini_IntSet(string, "S_drugs", Dom[domid][hS_drugs]);
		dini_IntSet(string, "S_PG1", Dom[domid][hS_PG1]);
		dini_IntSet(string, "S_PG2", Dom[domid][hS_PG2]);
		dini_IntSet(string, "S_PG3", Dom[domid][hS_PG3]);
		dini_IntSet(string, "S_PG4", Dom[domid][hS_PG4]);
		dini_IntSet(string, "S_PG5", Dom[domid][hS_PG5]);
		dini_IntSet(string, "S_PG6", Dom[domid][hS_PG6]);
		dini_IntSet(string, "S_PG7", Dom[domid][hS_PG7]);
		dini_IntSet(string, "S_PG8", Dom[domid][hS_PG8]);
		dini_IntSet(string, "S_PG9", Dom[domid][hS_PG9]);
		dini_IntSet(string, "S_PG10", Dom[domid][hS_PG10]);
		dini_IntSet(string, "S_PG11", Dom[domid][hS_PG11]);
		dini_IntSet(string, "S_G0", Dom[domid][hS_G0]);
		dini_IntSet(string, "S_G1", Dom[domid][hS_G1]);
		dini_IntSet(string, "S_G2", Dom[domid][hS_G2]);
		dini_IntSet(string, "S_G3", Dom[domid][hS_G3]);
		dini_IntSet(string, "S_G4", Dom[domid][hS_G4]);
		dini_IntSet(string, "S_G5", Dom[domid][hS_G5]);
		dini_IntSet(string, "S_G6", Dom[domid][hS_G6]);
		dini_IntSet(string, "S_G7", Dom[domid][hS_G7]);
		dini_IntSet(string, "S_G8", Dom[domid][hS_G8]);
		dini_IntSet(string, "S_G9", Dom[domid][hS_G9]);
		dini_IntSet(string, "S_G10", Dom[domid][hS_G10]);
		dini_IntSet(string, "S_G11", Dom[domid][hS_G11]);
		dini_IntSet(string, "S_A1", Dom[domid][hS_A1]);
		dini_IntSet(string, "S_A2", Dom[domid][hS_A2]);
		dini_IntSet(string, "S_A3", Dom[domid][hS_A3]);
		dini_IntSet(string, "S_A4", Dom[domid][hS_A4]);
		dini_IntSet(string, "S_A5", Dom[domid][hS_A5]);
		dini_IntSet(string, "S_A6", Dom[domid][hS_A6]);
		dini_IntSet(string, "S_A7", Dom[domid][hS_A7]);
		dini_IntSet(string, "S_A8", Dom[domid][hS_A8]);
		dini_IntSet(string, "S_A9", Dom[domid][hS_A9]);
		dini_IntSet(string, "S_A10", Dom[domid][hS_A10]);
		dini_IntSet(string, "S_A11", Dom[domid][hS_A11]);
    }
	return 1;
}

StworzDom(playerid, interior, oplata)
{
	if(interior == 8 || interior == 14)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior zosta� usuni�ty");
	    return 1;
	} // loled
	if(interior == 33)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior jest taki sam jak interior 36.");
	    return 1;
	}
	if(interior == 24)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior jest taki sam jak interior 23.");
	    return 1;
	}
    new string[256];
    new dld = dini_Int("Domy/NRD.ini", "NrDomow")+1;
    format(string, sizeof(string), "Domy/Dom%d.ini", dld);
	new pZone[MAX_ZONE_NAME];
    GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	if(dini_Exists(string))
	{
	    SendClientMessageToAll(COLOR_RED, "B��D PRZY TWORZENIU DOMU");
	    return 1;
	}
	else
	{
	    new GeT[MAX_PLAYER_NAME];
	    new message[128];
	    new Float:Wej_X, Float: Wej_Y, Float: Wej_Z;
     	GetPlayerPos(playerid, Wej_X, Wej_Y, Wej_Z);
	 	dini_Create(string);
		Dom[dld][hID] = dld;
		Dom[dld][hDomNr] = interior;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hWlasciciel] = GeT;
		Dom[dld][hZamek] = 0;
		Dom[dld][hKupiony] = 0;
		Dom[dld][hBlokada] = 0;
		Dom[dld][hOplata] = oplata;
		format(message, sizeof(message), "Wynajmujesz dom");
		Dom[dld][hKomunikatWynajmu] = message;
		Dom[dld][hUID_W] = 0;
		Dom[dld][hData_DD] = 0;
		Dom[dld][hWej_X] = Wej_X;
		Dom[dld][hWej_Y] = Wej_Y;
		Dom[dld][hWej_Z] = Wej_Z;
		Dom[dld][hInt_X] = IntInfo[interior][Int_X];
		Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];
		Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];
		Dom[dld][hInterior] = IntInfo[interior][Int];
		
		if(interior == 47)
			Dom[dld][hVW] = 2001;
		else if(interior == 55)
			Dom[dld][hVW] = 1901;
		else if(interior == 56)
			Dom[dld][hVW] = 1902;
		else
			Dom[dld][hVW] = dld;
		Dom[dld][hSwiatlo] = 0;
		Dom[dld][hPokoje] = IntInfo[interior][Pokoje];
		Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
		Dom[dld][hPW] = 0;//pokoi wynajmowanych
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL1] = GeT;
		Dom[dld][hL2] = GeT;
		Dom[dld][hL3] = GeT;
		Dom[dld][hL4] = GeT;
		Dom[dld][hL5] = GeT;
		Dom[dld][hL6] = GeT;
		Dom[dld][hL7] = GeT;
		Dom[dld][hL8] = GeT;
		Dom[dld][hL9] = GeT;
		Dom[dld][hL10] = GeT;
		Dom[dld][hWynajem] = 0;
		Dom[dld][hWW] = 1;
		Dom[dld][hTWW] = 1;
		Dom[dld][hCenaWynajmu] = 1000;
		Dom[dld][hKomunikatDomowy] = 0;
		Dom[dld][hUL_Z] = 0;
		Dom[dld][hUL_D] = 0;
		Dom[dld][hApteczka] = 0;
		Dom[dld][hKami] = 0;
		Dom[dld][hSejf] = 1;
		new GeT2[20];
		format(GeT2, sizeof(GeT2), "500500500500");
		Dom[dld][hKodSejf] = GeT2;
		Dom[dld][hZbrojownia] = 0;
		Dom[dld][hGaraz] = 0;
		Dom[dld][hLadowisko] = 0;
		Dom[dld][hAlarm] = 0;
		Dom[dld][hZamekD] = 0;
		Dom[dld][hKomputer] = 0;
		Dom[dld][hRTV] = 0;
		Dom[dld][hHazard] = 0;
		Dom[dld][hSzafa] = 0;
		Dom[dld][hTajemnicze] = 0;
		Dom[dld][hS_kasa] = 0;
		Dom[dld][hS_mats] = 0;
		Dom[dld][hS_ziolo] = 0;
		Dom[dld][hS_drugs] = 0;
		Dom[dld][hS_PG1] = 0;
		Dom[dld][hS_PG2] = 0;
		Dom[dld][hS_PG3] = 0;
		Dom[dld][hS_PG4] = 0;
		Dom[dld][hS_PG5] = 0;
		Dom[dld][hS_PG6] = 0;
		Dom[dld][hS_PG7] = 0;
		Dom[dld][hS_PG8] = 0;
		Dom[dld][hS_PG9] = 0;
		Dom[dld][hS_PG10] = 0;
		Dom[dld][hS_PG11] = 0;
		Dom[dld][hS_G0] = 0;
		Dom[dld][hS_G1] = 0;
		Dom[dld][hS_G2] = 0;
		Dom[dld][hS_G3] = 0;
		Dom[dld][hS_G4] = 0;
		Dom[dld][hS_G5] = 0;
		Dom[dld][hS_G6] = 0;
		Dom[dld][hS_G7] = 0;
		Dom[dld][hS_G8] = 0;
		Dom[dld][hS_G9] = 0;
		Dom[dld][hS_G10] = 0;
		Dom[dld][hS_G11] = 0;
		Dom[dld][hS_A1] = 0;
		Dom[dld][hS_A2] = 0;
		Dom[dld][hS_A3] = 0;
		Dom[dld][hS_A4] = 0;
		Dom[dld][hS_A5] = 0;
		Dom[dld][hS_A6] = 0;
		Dom[dld][hS_A7] = 0;
		Dom[dld][hS_A8] = 0;
		Dom[dld][hS_A9] = 0;
		Dom[dld][hS_A10] = 0;
		Dom[dld][hS_A11] = 0;
	    Dom[dld][hPickup] = CreateDynamicPickup(1273, 1, Dom[dld][hWej_X], Dom[dld][hWej_Y], Dom[dld][hWej_Z], 0, 0, -1, 125.0);
	    Dom[dld][hIkonka] = CreateDynamicMapIcon(Dom[dld][hWej_X], Dom[dld][hWej_Y], Dom[dld][hWej_Z], 31, 1, -1, -1, -1, 125.0);
		dini_IntSet("Domy/NRD.ini", "NrDomow", dld);
		new intcena = IntInfo[Dom[dld][hDomNr]][Cena];
  		new Float:cenadomu = intcena+oplata;
		Dom[dld][hCena] = floatround(cenadomu, floatround_ceil);
		new string2[256];
		format(string2, sizeof(string2), "Dom %d || NrDom %d || Parcela %s || Cene og�lna %d$.", dld, Dom[dld][hDomNr], pZone, floatround(cenadomu, floatround_ceil));
		SendClientMessage(playerid, COLOR_NEWS, string2);
		//
		ZapiszDom(dld);
	}
	return dld;
}

Dom_ChangeInt(playerid, dld, interior)
{
	if(interior == 8 || interior == 14)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior zosta� usuni�ty");
	    return 1;
	}
	if(interior == 33)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior jest taki sam jak interior 36.");
	    return 1;
	}
	if(interior == 24)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior jest taki sam jak interior 23.");
	    return 1;
	}
    new string[128];

	new oldInt = Dom[dld][hDomNr];
    new Float:Wej_X, Float: Wej_Y, Float: Wej_Z;
 	GetPlayerPos(playerid, Wej_X, Wej_Y, Wej_Z);
	if(interior >= 1)
	{
		Dom[dld][hPokoje] = IntInfo[interior][Pokoje];
		Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1;
	}
	else
	{
		Dom[dld][hPokoje] = 0;
		Dom[dld][hPDW] = 0;
	}
	Dom[dld][hWej_X] = Wej_X;
	Dom[dld][hWej_Y] = Wej_Y;
	Dom[dld][hWej_Z] = Wej_Z;
	if(interior >= 1)
	{
		Dom[dld][hInt_X] = IntInfo[interior][Int_X];
		Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];
		Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];
		Dom[dld][hInterior] = IntInfo[interior][Int];
	}
	else
	{
		Dom[dld][hInt_X] = Wej_X;
		Dom[dld][hInt_Y] = Wej_Y;
		Dom[dld][hInt_Z] = Wej_Z;
		Dom[dld][hInterior] = 0;
	}
    Dom[dld][hDomNr] = interior;

	new pZone[MAX_ZONE_NAME];
    GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	if(interior >= 1)
	{
		new intcena = IntInfo[interior][Cena];
		new Float:cenadomu = intcena;//cena domu
		Dom[dld][hCena] = floatround(cenadomu, floatround_ceil);
	}

    DestroyDynamicPickup(Dom[dld][hPickup]);
	if(Dom[dld][hIkonka] != 0) DestroyDynamicMapIcon(Dom[dld][hIkonka]);
    Dom[dld][hPickup] = CreateDynamicPickup(1239, 1, Dom[dld][hWej_X], Dom[dld][hWej_Y], Dom[dld][hWej_Z], 0, 0, -1, 125.0);
    Dom[dld][hIkonka] = 0;

	format(string, sizeof(string), "Zmiana Interioru - OK. || Dom %d || NrDom %d || Interior: %d || Cena %d", dld, Dom[dld][hDomNr], interior, Dom[dld][hCena]);
	SendClientMessage(playerid, COLOR_NEWS, string);
        
	Log(adminLog, WARNING, "Admin %s zmieni� interior domu %d z %d na %d", GetPlayerLogName(playerid), dld, oldInt, interior);
	//
	ZapiszDom(dld);
	return 1;
}

Dom_ChangeOwner(playerid, dom, forid)
{
    new string[128];

	Log(adminLog, WARNING, "Admin %s zmieni� w�a�ciciela domu %d z %s na %s", GetPlayerLogName(playerid), dom, Dom[dom][hWlasciciel], GetPlayerLogName(forid));
    PlayerInfo[forid][pDom] = dom;
	Dom[dom][hWlasciciel] = GetNickEx(forid);
	Dom[dom][hKupiony] = 1;
	Dom[dom][hUID_W] = PlayerInfo[forid][pUID];

	format(string, sizeof(string), "Zmiana wlasciciela - OK. || Dom %d || NrDom %d || Wlasciciel: %s", dom, Dom[dom][hDomNr], GetNickEx(forid));
	SendClientMessage(playerid, COLOR_NEWS, string);

	//
	ZapiszDom(dom);
	return 1;
}

L_StworzDom(playerid, kategoria, oplata)
{
    new string[256];
    new dld = dini_Int("Domy/NRD.ini", "NrDomow")+1;
	new pZone[MAX_ZONE_NAME];
    GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
    format(string, sizeof(string), "Domy/Dom%d.ini", dld );
	if(dini_Exists(string))
	{
	    SendClientMessageToAll(COLOR_RED, "B�AD PRZY TWORZENIU DOMU (DOM INSTNIEJE)");
	    return 1;
	}
	else
	{
	    new GeT[MAX_PLAYER_NAME];
	    new message[128];
	    new Float:Wej_X, Float: Wej_Y, Float: Wej_Z;
     	GetPlayerPos(playerid, Wej_X, Wej_Y, Wej_Z);
	 	dini_Create(string);
		Dom[dld][hID] = dld;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hWlasciciel] = GeT;
		Dom[dld][hZamek] = 0;
		Dom[dld][hKupiony] = 0;
		Dom[dld][hOplata] = oplata;
		format(message, sizeof(message), "Wynajmujesz dom");
		Dom[dld][hKomunikatWynajmu] = message;
		Dom[dld][hUID_W] = 0;
		Dom[dld][hData_DD] = 0;
		Dom[dld][hWej_X] = Wej_X;
		Dom[dld][hWej_Y] = Wej_Y;
		Dom[dld][hWej_Z] = Wej_Z;
		if(kategoria == 1)
		{
		    new interior = random(5);
		    if(interior == 0)
		    {
		        interior = 1;
		    }
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 2)
		{
		    new interior = random(13)+7;
		    if(interior == 8)
		    {
		        interior = 7;
		    }
		    if(interior == 14)
		    {
                interior = 15;
		    }
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 3)
		{
		    new interior = random(8)+21;
		    if(interior == 24)
		    {
		        interior = 23;
		    }
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 4)
		{
		    new interior = random(6)+30;
		    if(interior == 33)
		    {
		        interior = 36;
		    }
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 5)
		{
		    new interior = random(5)+37;
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 6)
		{
		    new interior = random(2)+43;
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 7)
		{
		    new interior = random(2)+45;
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else
		{
		    SendClientMessageToAll(COLOR_RED, "B�AD PRZY TWORZENIU DOMU (Z�A KATEGORIA)");
	    	return 1;
		}
		Dom[dld][hVW] = dld;
		Dom[dld][hPW] = 0;//pokoi wynajmowanych
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL1] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL2] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL3] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL4] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL5] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL6] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL7] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL8] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL9] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL10] = GeT;
		Dom[dld][hWynajem] = 0;
		Dom[dld][hWW] = 1;
		Dom[dld][hTWW] = 1;
		Dom[dld][hCenaWynajmu] = 1000;
		Dom[dld][hKomunikatDomowy] = 0;
		Dom[dld][hApteczka] = 0;
		Dom[dld][hKami] = 0;
		Dom[dld][hSejf] = 1;
		new GeT2[20];
		format(GeT2, sizeof(GeT2), "500500500500");
		Dom[dld][hKodSejf] = GeT2;
		Dom[dld][hGaraz] = 0;
		Dom[dld][hLadowisko] = 0;
		Dom[dld][hAlarm] = 0;
		Dom[dld][hZamekD] = 0;
		Dom[dld][hKomputer] = 0;
		Dom[dld][hRTV] = 0;
		Dom[dld][hHazard] = 0;
		Dom[dld][hSzafa] = 0;
		Dom[dld][hTajemnicze] = 0;
		Dom[dld][hS_kasa] = 0;
		Dom[dld][hS_mats] = 0;
		Dom[dld][hS_ziolo] = 0;
		Dom[dld][hS_drugs] = 0;
		Dom[dld][hS_PG1] = 0;
		Dom[dld][hS_PG2] = 0;
		Dom[dld][hS_PG3] = 0;
		Dom[dld][hS_PG4] = 0;
		Dom[dld][hS_PG5] = 0;
		Dom[dld][hS_PG6] = 0;
		Dom[dld][hS_PG7] = 0;
		Dom[dld][hS_PG8] = 0;
		Dom[dld][hS_PG9] = 0;
		Dom[dld][hS_PG10] = 0;
		Dom[dld][hS_PG11] = 0;
		Dom[dld][hS_G0] = 0;
		Dom[dld][hS_G1] = 0;
		Dom[dld][hS_G2] = 0;
		Dom[dld][hS_G3] = 0;
		Dom[dld][hS_G4] = 0;
		Dom[dld][hS_G5] = 0;
		Dom[dld][hS_G6] = 0;
		Dom[dld][hS_G7] = 0;
		Dom[dld][hS_G8] = 0;
		Dom[dld][hS_G9] = 0;
		Dom[dld][hS_G10] = 0;
		Dom[dld][hS_G11] = 0;
		Dom[dld][hS_A1] = 0;
		Dom[dld][hS_A2] = 0;
		Dom[dld][hS_A3] = 0;
		Dom[dld][hS_A4] = 0;
		Dom[dld][hS_A5] = 0;
		Dom[dld][hS_A6] = 0;
		Dom[dld][hS_A7] = 0;
		Dom[dld][hS_A8] = 0;
		Dom[dld][hS_A9] = 0;
		Dom[dld][hS_A10] = 0;
		Dom[dld][hS_A11] = 0;
		Dom[dld][hPickup] = CreateDynamicPickup(1273, 1, Dom[dld][hWej_X], Dom[dld][hWej_Y], Dom[dld][hWej_Z], 0, 0, -1, 125.0);
	    Dom[dld][hIkonka] = CreateDynamicMapIcon(Dom[dld][hWej_X], Dom[dld][hWej_Y], Dom[dld][hWej_Z], 31, 1, -1, -1, -1, 125.0);
		dini_IntSet("Domy/NRD.ini", "NrDomow", dld);
		new intcena = IntInfo[Dom[dld][hDomNr]][Cena];
  		new Float:cenadomu = intcena+oplata;//cena domu
		Dom[dld][hCena] = floatround(cenadomu, floatround_ceil);
		new string2[256];
		format(string2, sizeof(string2), "Dom %d || NrDom %d || Parcela %s || Cene og�lna %d$.", dld, Dom[dld][hDomNr], pZone, floatround(cenadomu, floatround_ceil));
		SendClientMessage(playerid, COLOR_NEWS, string2);
		//
		ZapiszDom(dld);
	}
	return 1;
}

KupowanieDomu(playerid, dom, platnosc, intType = 0)
{
    new string[256];
    format(string, sizeof(string), "Domy/Dom%d.ini", dom);
	if(!dini_Exists(string))
	{
        format(string, 256, "B�AD PRZY KUPOWANIU DOMU - Dom %d gracz %d", dom, playerid);
	    SendClientMessageToAll(COLOR_RED, string);
	    return 1;
	}
	else
	{
		if(Dom[dom][hKupiony] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, "Dom ju� jest kupiony!");
			return 1;
		}
		new str2[256];
		new cenadomu = Dom[dom][hCena];
	    if(platnosc == 1)
	    {
	        if(kaska[playerid] >= cenadomu && cenadomu != 0 && cenadomu > 0 && kaska[playerid] != 0 && kaska[playerid] > 0)
	        {
				ZabierzKaseDone(playerid, cenadomu);
				format(str2, sizeof(str2), "Gratulacje! Kupi�e� dom za %d$. Masz teraz %d$.", cenadomu, kaska[playerid]);
				SendClientMessage(playerid, COLOR_NEWS, str2);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_NEWS, "Nie sta� ci�!!!!");
			    return 1;
			}
	    }
	    if(platnosc == 2)
		{
		    if(PlayerInfo[playerid][pAccount] >= cenadomu && cenadomu != 0 && cenadomu > 0 && PlayerInfo[playerid][pAccount] != 0 && PlayerInfo[playerid][pAccount] > 0)
	        {
				PlayerInfo[playerid][pAccount] += -cenadomu;
				format(str2, sizeof(str2), "Gratulacje! Kupi�e� dom za %d$. Zosta�o one odliczone od twojego konta bankowego kt�re wynosi teraz %d", cenadomu, PlayerInfo[playerid][pAccount]);
				SendClientMessage(playerid, COLOR_PANICRED, str2);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_PANICRED, "Nie sta� ci�!!!!");
			    return 1;
			}
		}
		printf(str2);

		if(intType == 1)
		{
			Dom[dom][hInt_X] = Dom[dom][hWej_X];
			Dom[dom][hInt_Y] = Dom[dom][hWej_Y];
			Dom[dom][hInt_Z] = Dom[dom][hWej_Z];
			Dom[dom][hInterior] = 0;
			Dom[dom][hDomNr] = -1;
		}
		PlayerInfo[playerid][pDom] = dom;
	    new h, m;
		GetPlayerTime(playerid, h, m);
		Dom[dom][hWlasciciel] = GetNickEx(playerid);
		Dom[dom][hKupiony] = 1;
		Dom[dom][hUID_W] = PlayerInfo[playerid][pUID];
		DestroyDynamicPickup(Dom[dom][hPickup]);
		DestroyDynamicMapIcon(Dom[dom][hIkonka]);
	    Dom[dom][hPickup] = CreateDynamicPickup(1239, 1, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z], 0, 0, -1, 125.0);
	    Dom[dom][hIkonka] = 0;
	    SetPlayerPos(playerid, Dom[dom][hInt_X], Dom[dom][hInt_Y], Dom[dom][hInt_Z]);
	    SetPlayerInterior(playerid, Dom[dom][hInterior]);
	    SetPlayerVirtualWorld(playerid, Dom[dom][hVW]);
	    PlayerInfo[playerid][pDomWKJ] = dom;
	    PlayerInfo[playerid][pDomT] = h;
	    SendClientMessage(playerid, COLOR_NEWS, "Aby zobaczy� komendy domu wpisz /dompomoc");
		if(intType == 1)
		{
			SendClientMessage(playerid, COLOR_NEWS, "INFO: Wybra�e� w�asny interior. Mo�esz go teraz zbudowa� lub wynaj�� kogo� do pomocy.");
			SendClientMessage(playerid, COLOR_NEWS, "INFO: Pod komend� /dom mo�esz ustawi� pozycj� wej�cia do domu po zbudowaniu interioru.");
		}
		Log(payLog, WARNING, "%s kupi� dom %s za %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), cenadomu);
		FirstHouse(playerid);
		EXPPlayerBuyHouse(playerid);
		ZapiszDom(dom);
	}
	return 1;
}

ZlomowanieDomu(playerid, dom)
{
	new plik[256];
    format(plik, sizeof(plik), "Domy/Dom%d.ini", dom);
	//
	if(dini_Exists(plik))
	{
	    new GeT[MAX_PLAYER_NAME];
		Dom[dom][hZamek] = 0;
		Dom[dom][hKupiony] = 0;
		Dom[dom][hUID_W] = 0;
		Dom[dom][hData_DD] = 0;
		Dom[dom][hSwiatlo] = 0;
		Dom[dom][hPW] = 0;//pokoi wynajmowanych
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL1] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL2] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL3] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL4] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL5] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL6] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL7] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL8] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL9] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL10] = GeT;
		Dom[dom][hWynajem] = 0;
		Dom[dom][hWW] = 1;
		Dom[dom][hTWW] = 1;
		Dom[dom][hCenaWynajmu] = 1000;
		Dom[dom][hKomunikatDomowy] = 0;
		Dom[dom][hUL_Z] = 0;
		Dom[dom][hUL_D] = 0;
		Dom[dom][hApteczka] = 0;
		Dom[dom][hKami] = 0;
		Dom[dom][hSejf] = 1;
		new GeT3[20];
		format(GeT3, sizeof(GeT3), "500500500500");
		Dom[dom][hKodSejf] = GeT3;
		Dom[dom][hGaraz] = 0;
		Dom[dom][hLadowisko] = 0;
		Dom[dom][hAlarm] = 0;
		Dom[dom][hZamekD] = 0;
		Dom[dom][hKomputer] = 0;
		Dom[dom][hRTV] = 0;
		Dom[dom][hHazard] = 0;
		Dom[dom][hSzafa] = 0;
		Dom[dom][hTajemnicze] = 0;
		Dom[dom][hS_kasa] = 0;
		Dom[dom][hS_mats] = 0;
		Dom[dom][hS_ziolo] = 0;
		Dom[dom][hS_drugs] = 0;
		Dom[dom][hS_PG1] = 0;
		Dom[dom][hS_PG2] = 0;
		Dom[dom][hS_PG3] = 0;
		Dom[dom][hS_PG4] = 0;
		Dom[dom][hS_PG5] = 0;
		Dom[dom][hS_PG6] = 0;
		Dom[dom][hS_PG7] = 0;
		Dom[dom][hS_PG8] = 0;
		Dom[dom][hS_PG9] = 0;
		Dom[dom][hS_PG10] = 0;
		Dom[dom][hS_PG11] = 0;
		Dom[dom][hS_G0] = 0;
		Dom[dom][hS_G1] = 0;
		Dom[dom][hS_G2] = 0;
		Dom[dom][hS_G3] = 0;
		Dom[dom][hS_G4] = 0;
		Dom[dom][hS_G5] = 0;
		Dom[dom][hS_G6] = 0;
		Dom[dom][hS_G7] = 0;
		Dom[dom][hS_G8] = 0;
		Dom[dom][hS_G9] = 0;
		Dom[dom][hS_G10] = 0;
		Dom[dom][hS_G11] = 0;
		Dom[dom][hS_A1] = 0;
		Dom[dom][hS_A2] = 0;
		Dom[dom][hS_A3] = 0;
		Dom[dom][hS_A4] = 0;
		Dom[dom][hS_A5] = 0;
		Dom[dom][hS_A6] = 0;
		Dom[dom][hS_A7] = 0;
		Dom[dom][hS_A8] = 0;
		Dom[dom][hS_A9] = 0;
		Dom[dom][hS_A10] = 0;
		Dom[dom][hS_A11] = 0;
		Dom[dom][hZbrojownia] = 0;
		DestroyDynamicPickup(Dom[dom][hPickup]);
		DestroyDynamicMapIcon(Dom[dom][hIkonka]);
	    Dom[dom][hPickup] = CreateDynamicPickup(1273, 1, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z], 0, 0, -1, 125.0);
	    Dom[dom][hIkonka] = CreateDynamicMapIcon(Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z], 31, 1, -1, -1, -1, 125.0);
		ZapiszDom(dom);
		//
		if(playerid != 9999)
		{
		    new GeT4[MAX_PLAYER_NAME];
		    GetPlayerName(playerid, GeT4, sizeof(GeT4));
			PlayerInfo[playerid][pDom] = 0;
			DajKaseDone(playerid, (Dom[dom][hCena]/2));
			new GeT2[512];
			format(GeT2, sizeof(GeT2), "Sprzeda�e� sw�j dom za %d$. Osoby wynajmuj�ce zosta�y wyeksmitowane. Przedmioty w sejfie oraz dodatki do domu przepad�y.", (Dom[dom][hCena]/2));
			SendClientMessage(playerid, COLOR_NEWS, GeT2);
			Log(payLog, WARNING, "%s zez�omowa� dom %s i dosta� %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), (Dom[dom][hCena]/2));
			format(GeT, sizeof(GeT), "Brak");
			Dom[dom][hWlasciciel] = GeT;
		}
		else
		{
			if(strcmp(Dom[dom][hWlasciciel], "Gracz Nieaktywny") != 0)
			{
				Log(serverLog, WARNING, "Dom %s zosta� zez�omowany z powodu nieaktywno�ci w�a�ciciela %s.", GetHouseLogName(dom), Dom[dom][hWlasciciel]);
				format(GeT, sizeof(GeT), "Gracz Nieaktywny");
				Dom[dom][hWlasciciel] = GeT;
			}
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_NEWS, "B�AD - Tw�j dom nie istnieje, zg�o� to na forum !!");
	}
    return 1;
}

SprawdzSpojnoscWlascicielaDomu(playerid)
{
	new string[64];
	format(string, sizeof(string), "Domy/Dom%d.ini", PlayerInfo[playerid][pDom]);
	if(dini_Exists(string))
	{
		if(strcmp(Dom[PlayerInfo[playerid][pDom]][hWlasciciel], GetNickEx(playerid), true) != 0)
		{
			return 0;
		}
	}
	else
	{
		return -1;
	}
	return 1;
}

NaprawSpojnoscWlascicielaDomu(playerid)
{
	new domcheck = SprawdzSpojnoscWlascicielaDomu(playerid);
	new dom = PlayerInfo[playerid][pDom];
	if(domcheck == 1)
	{
		if(Dom[dom][hKupiony] == 0)
		{
			Dom[dom][hKupiony] = 1;
			ZapiszDom(dom);
			SendClientMessage(playerid, COLOR_PANICRED, "Wykryto bug z niekupionym domem, zosta� on automatycznie naprawiony. Je�eli komunikat b�dzie si� powtarza� lub wyst�pi� inne bugi, zg�o� to koniecznie na forum!");
			Log(serverLog, WARNING, "%s posiada� bug z niekupionym domem %s. Naprawiono.", GetPlayerLogName(playerid), GetHouseLogName(dom));
		}
	}
	else if(domcheck == 0)
	{
		if(Dom[dom][hKupiony] == 0)
		{
			DajKaseDone(playerid, (Dom[dom][hCena]/2));
			SendClientMessage(playerid, COLOR_PANICRED, "Tw�j dom zosta� zabrany z powodu nieaktywno�ci, otrzymujesz po�ow� wartosci domu!");
			Log(payLog, WARNING, "%s straci� dom %s z powodu nieaktywno�ci i otrzyma� %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hCena]/2);
			PlayerInfo[playerid][pDom] = 0;
		}
		else
		{
			DajKaseDone(playerid, (Dom[dom][hCena]/2));
			SendClientMessage(playerid, COLOR_PANICRED, "Wykro bug z dwoma w�a�cicielami! Jeste� drugim w�a�cicielem, wi�c tracisz dom, otrzymujesz po�ow� wartosci domu.");
			Log(payLog, WARNING, "%s straci� dom %s z powodu nieaktywno�ci (2 w�a�cicieli) i otrzyma� %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hCena]/2);
			PlayerInfo[playerid][pDom] = 0;
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_PANICRED, "Tw�j dom nie istnieje! Prawdopodobnie zosta� usuni�ty lub co� posz�o nie tak.");
		Log(serverLog, ERROR, "Brak domu %s gracza %s. Usuwam mu dom.", GetPlayerLogName(playerid), GetHouseLogName(dom));
		PlayerInfo[playerid][pDom] = 0;
	}
}

DialogZbrojowni(playerid)
{
    ShowPlayerDialogEx(playerid, 8282, DIALOG_STYLE_LIST, "Kup przystosowanie do przechowywania:", "Kastetu\t\t\t\t\t1 000$\nSpadochronu\t\t\t\t5 000$\nSpreju, ga�nicy i aparatu\t\t40 000$\nWibrator�w,kwiat�w i laski\t\t50 000$\nBroni bia�ej\t\t\t\t750 000$\nPistolet�w\t\t\t\t250 000$\nStrzelb\t\t\t\t\t450 000$\nPistolet�w maszynowych\t\t550 000$\nKarabin�w szturmowych\t\t850 000$\nSnajperek\t\t\t\t700 000$\nBroni ci�kiej\t\t\t\t2 000 000$\n�adunk�w wybuchowych\t\t4 000 000$", "Wybierz", "Cofnij");
}

Przystanek(playerid, color, tekst[])
{
    new car = GetPlayerVehicleID(playerid);
    if(KomunikacjaMiejsca[car] == -1) return 0;
	UpdateDynamic3DTextLabelText(Busnapisn[KomunikacjaMiejsca[car]], color, tekst);
    return 1;
}

KupowanieDodatkow(playerid, dom)
{
    new Sejf[100];
    new Zbrojownia[100];
    new Garaz[100];
    new Apteczka[100];
    new Pancerz[100];
    new Ladowisko[100];
    new Alarm[100];
    new Zamek[100];
    new Komputer[100];
    new RTV[100];
    new Hazard[100];
    new Szafa[100];
    new Tajne[100];
    new strALL[1300];
    format(Sejf, sizeof(Sejf), "Sejf\t\t\tLevel: %d\tCena: %d$\n", Dom[dom][hSejf]+1, 100000*(Dom[dom][hSejf]+1));
    if(Dom[dom][hZbrojownia] == 0)
	{
    	format(Zbrojownia, sizeof(Zbrojownia), "Zbrojownia\t\t\t\tCena: 1000000$\n");
	}
	else
	{
	    format(Zbrojownia, sizeof(Zbrojownia), "Przystosuj Zbrojownie do przechowywania broni.\n");
	}
	if(Dom[dom][hGaraz] == 0)
	{
		format(Garaz, sizeof(Garaz), "Gara�\t\t\tLevel: %d\tCena: %d$\n", 1, 1000000);
	}
	else
	{
	    format(Garaz, sizeof(Garaz), "Gara�\t\t\tLevel: %d\tCena: %d$\n", (Dom[dom][hGaraz]/20)+1, 500000*((Dom[dom][hGaraz]/20)+1));
	}
	if(Dom[dom][hApteczka] == 0)
	{
		format(Apteczka, sizeof(Apteczka), "Apteczka\t\t\t\tCena: %d$\n", 100000);//apteczka
	}
	else
	{
 		format(Apteczka, sizeof(Apteczka), "Apteczka\t\tLevel: MAX\n");//apteczka
	}
	if(Dom[dom][hKami] != 10)
	{
 		format(Pancerz, sizeof(Pancerz), "Pancerz\t\t\t\tCena: %d$\n", 300000);
	}
	else
	{
	    format(Pancerz, sizeof(Pancerz), "Pancerz\t\tLevel: MAX\n");
	}
	if(Dom[dom][hLadowisko] == 0)
	{
	    format(Ladowisko, sizeof(Ladowisko), "L�dowisko\t\tLevel: %d\tCena: %d$\n", 1, 10000000);
	}
	else
	{
	    format(Ladowisko, sizeof(Ladowisko), "L�dowisko\t\tLevel: %d\tCena: %d$\n", (Dom[dom][hLadowisko]/20)+1, 1000000*((Dom[dom][hLadowisko]/20)+1));
	}
  	format(Alarm, sizeof(Alarm), "Alarm\t\t\tLevel: %d\tCena: %d$\n", Dom[dom][hAlarm]+1, 0*(Dom[dom][hAlarm]+1));
   	format(Zamek, sizeof(Zamek), "Zamek\t\t\tLevel: %d\tCena: %d$\n", Dom[dom][hZamekD]+1, 0*(Dom[dom][hZamekD]+1));
    format(Komputer, sizeof(Komputer), "Komputer\t\tLevel: %d\tCena: %d$\n", Dom[dom][hKomputer]+1, 0*(Dom[dom][hKomputer]+1));
    format(RTV, sizeof(RTV), "Sprz�t RTV\t\tLevel: %d\tCena: %d$\n", Dom[dom][hRTV]+1, 0*(Dom[dom][hRTV]+1));
    format(Hazard, sizeof(Hazard), "Zestaw hazardzisty\tLevel: %d\tCena: %d$\n", Dom[dom][hHazard]+1, 0*(Dom[dom][hHazard]+1));
    format(Szafa, sizeof(Szafa), "Szafa\t\t\tLevel: %d\tCena: %d$\n", Dom[dom][hSzafa]+1, 0*(Dom[dom][hSzafa]+1));
    format(Tajne, sizeof(Tajne), "Tajemnicze dodatki\tLevel: %d\tCena: %d$\n", Dom[dom][hTajemnicze]+1, 0*(Dom[dom][hTajemnicze]+1));
    //ALL
	format(strALL, sizeof(strALL), "%s%s%s%s%s%s%s%s%s%s%s%s%s", Sejf, Zbrojownia, Garaz, Apteczka, Pancerz, Ladowisko, Alarm, Zamek, Komputer, RTV, Hazard, Szafa, Tajne);
    ShowPlayerDialogEx(playerid, 826, DIALOG_STYLE_LIST, "Kupowanie dodatk�w", strALL, "Wybierz", "Wyjd�");
    return 1;
}

Do_WnetrzaWozu(playerid, vehicleid, model)
{
	if(model == 484)//jacht
	{
		SetPlayerInterior(playerid, 9);
	    SetPlayerPos(playerid, 1935.6661376953, 1360.8430175781, 12313.875976563);
        Wchodzenie(playerid);
	    TogglePlayerControllable(playerid, 0);
	    GameTextForPlayer(playerid, "~w~Witamy na ~b~jachcie", 5000, 1);
	}
	else if(model == 519)//shamal
	{
		SetPlayerInterior(playerid, 9);
	    SetPlayerPos(playerid, 1074.3032226563, -1843.8029785156, 10657.265625);
        Wchodzenie(playerid);
	    TogglePlayerControllable(playerid, 0);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Witaj w ~r~odrzutowcu!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 553)//nevada
	{
        SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 1.808619,32.384357,1199.593750);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Witaj w ~r~nevadzie!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 409)//limuzyna
	{
		SetPlayerInterior(playerid, 9);
	    SetPlayerPos(playerid, 2985.498046875, 1866.7770996094, 371.35998535156);
        Wchodzenie(playerid);
	    TogglePlayerControllable(playerid, 0);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Witaj w ~r~limuzynie!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 416)//karetka
	{
		SetPlayerVirtualWorld(playerid, 32);
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 1079.5173, -1309.6299, 22.0575);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Skalpel ~r~w dlon!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 508)//journey
	{
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 2512.8455,-1729.0057,778.6371);
        Wchodzenie(playerid);
	    TogglePlayerControllable(playerid, 0);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Witaj w ~r~domu!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 431)//autobus
	{
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 1450.3420,-1779.3888,3.6388);
        Wchodzenie(playerid);
	    TogglePlayerControllable(playerid, 0);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Zapinaj Pasy - Jedziemy do piekla!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	
	}
	else if(model == 427)//Enforcer pd
	{
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 1479.1534,-1617.7773,-4.2809);
        Wchodzenie(playerid);
	    TogglePlayerControllable(playerid, 0);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Lap za bron!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	
	}
	else if(model == 570)//Wagony KT
	{
			SetPlayerInterior(playerid, 1);
			SetPlayerPos(playerid, 1708.72290, -1953.05688, -17.18891);
			Wchodzenie(playerid);
			TogglePlayerControllable(playerid, 0);
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Zajmuj miejsce, bo trzesie!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
			sendTipMessage(playerid, ">>Pomy�lnie wszed�e� do poci�gu! Bilet zosta� zu�yty!");
			sendTipMessage(playerid, ">>>Interior stworzony przez: Charlie112");
			PlayerInfo[playerid][pBiletpociag] = 0;
	}
	else if(model == 582)//sanvan
	{
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 739.3749,-1365.0778,7.4080);
        Wchodzenie(playerid);
	    TogglePlayerControllable(playerid, 0);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Mikrofon w dlon!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	SetPlayerVirtualWorld(playerid, vehicleid);
    WnetrzeWozu[playerid] = vehicleid;
	return 1;
}

Z_WnetrzaWozu(playerid, vehicleid)
{
    new Float:vehx, Float:vehy, Float:vehz, model;
	GetVehiclePos(vehicleid, vehx, vehy, vehz);
	model = GetVehicleModel(vehicleid);
    if(model == 484)//jacht
	{
	    SetPlayerPos(playerid, vehx, vehy, vehz+2);
	}
	else if(model == 519)//shamal
	{
	    SetPlayerPos(playerid, vehx-0.5, vehy-2, vehz);
	}
	else if(model == 553)//nevada
	{
	    SetPlayerPos(playerid, vehx-7, vehy, vehz);
	}
	else if(model == 409)//limuzyna
	{
	    SetPlayerPos(playerid, vehx-2, vehy-1, vehz);
	}
	else if(model == 416)//karetka
	{
		SetPlayerPos(playerid, vehx-1, vehy-1, vehz);
	}
	else if(model == 508)//journey
	{
		SetPlayerPos(playerid, vehx, vehy+0.23, vehz);
	}
	else if(model == 570)//kt 
	{
		SetPlayerPos(playerid, vehx, vehy+3, vehz);
	
	}
	else if(model == 427)
	{
		SetPlayerPos(playerid, vehx, vehy+0.23, vehz);
	}
	else if(model == 431)
	{
		SetPlayerPos(playerid, vehx, vehy+0.23, vehz);
	}
	else if(model == 582)//sanvan
	{
	    SetPlayerPos(playerid, vehx-1, vehy-1, vehz);
	}
	GameTextForPlayer(playerid, "~w~Opusciles pojazd", 5000, 1);
    SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
    WnetrzeWozu[playerid] = 0;
	Wchodzenie(playerid);
	TogglePlayerControllable(playerid, 0);
	return 1;
}

LadujInteriory()
{
	//kategoria 1
    IntInfo[1][Int_X] = 244.5000;//dom 1
    IntInfo[1][Int_Y] = 305.0000;
    IntInfo[1][Int_Z] = 999.1484;
    IntInfo[1][Int] = 1;
    IntInfo[1][Kategoria] = 1;
    IntInfo[1][Pokoje] = 1;
    IntInfo[1][Cena] = 50000;
    IntInfo[2][Int_X] = 301.3000;//dom 2
    IntInfo[2][Int_Y] = 306.3000;
    IntInfo[2][Int_Z] = 1003.5391;
    IntInfo[2][Int] = 4;
    IntInfo[2][Kategoria] = 1;
    IntInfo[2][Pokoje] = 2;
    IntInfo[2][Cena] = 53500;
    IntInfo[3][Int_X] = 344.83898925781;//dom 3
    IntInfo[3][Int_Y] = 305.42208862305;
    IntInfo[3][Int_Z] = 999.1484375;
    IntInfo[3][Int] = 6;
    IntInfo[3][Kategoria] = 1;
    IntInfo[3][Pokoje] = 1;
    IntInfo[3][Cena] = 55000;
    IntInfo[4][Int_X] = -68.816932678223;//dom 4
    IntInfo[4][Int_Y] = 1354.1055908203;
    IntInfo[4][Int_Z] = 1080.2109375;
    IntInfo[4][Int] = 6;
    IntInfo[4][Kategoria] = 1;
    IntInfo[4][Pokoje] = 3;
    IntInfo[4][Cena] = 60000;
    IntInfo[5][Int_X] = 2333.1157226563;//dom 5
    IntInfo[5][Int_Y] = -1074.7203369141;
    IntInfo[5][Int_Z] = 1049.0234375;
    IntInfo[5][Int] = 6;
    IntInfo[5][Kategoria] = 1;
    IntInfo[5][Pokoje] = 2;
    IntInfo[5][Cena] = 65000;
    IntInfo[6][Int_X] = 1207.6346435547;//dom 6 DOMEK Z MUZYCZK�
    IntInfo[6][Int_Y] = -42.482707977295;
    IntInfo[6][Int_Z] = 1000.953125;
    IntInfo[6][Int] = 3;
    IntInfo[6][Kategoria] = 1;
    IntInfo[6][Pokoje] = 1;
    IntInfo[6][Cena] = 25000;
    //kategoria 2
    IntInfo[7][Int_X] = 267.1000;//dom 7 MALY JASNY DOMEK
    IntInfo[7][Int_Y] = 305.0000;
    IntInfo[7][Int_Z] = 999.1484;
    IntInfo[7][Int] = 2;
    IntInfo[7][Kategoria] = 2;
    IntInfo[7][Pokoje] = 1;
    IntInfo[7][Cena] = 70000;
    //loled
    IntInfo[9][Int_X] = 2467.2964;//dom 9
    IntInfo[9][Int_Y] = -1698.1704;
    IntInfo[9][Int_Z] = 1013.5078;
    IntInfo[9][Int] = 2;
    IntInfo[9][Kategoria] = 2;
    IntInfo[9][Pokoje] = 3;
    IntInfo[9][Cena] = 75000;
    IntInfo[10][Int_X] = 221.6465;//dom 10
    IntInfo[10][Int_Y] = 1148.6022;
    IntInfo[10][Int_Z] = 1082.6094;
    IntInfo[10][Int] = 4;
    IntInfo[10][Kategoria] = 2;
    IntInfo[10][Pokoje] = 3;
    IntInfo[10][Cena] = 80000;
    IntInfo[11][Int_X] = 2254.3000;//dom 11 bug
    IntInfo[11][Int_Y] = -1140.0000;
    IntInfo[11][Int_Z] = 1050.6328;
    IntInfo[11][Int] = 9;
    IntInfo[11][Kategoria] = 2;
    IntInfo[11][Pokoje] = 3;
    IntInfo[11][Cena] = 85000;
    IntInfo[12][Int_X] = 2261.3000;//dom 12
    IntInfo[12][Int_Y] = -1135.9000;
    IntInfo[12][Int_Z] = 1050.63280;
    IntInfo[12][Int] = 10;
    IntInfo[12][Kategoria] = 2;
    IntInfo[12][Pokoje] = 3;
    IntInfo[12][Cena] = 90000;
    IntInfo[13][Int_X] = -42.796955108643;//dom 13 taki sam jak 8
    IntInfo[13][Int_Y] = 1407.6802978516;
    IntInfo[13][Int_Z] = 1084.4296875;
    IntInfo[13][Int] = 8;
    IntInfo[13][Kategoria] = 2;
    IntInfo[13][Pokoje] = 3;
    IntInfo[13][Cena] = 2000000;
	//loled
    IntInfo[15][Int_X] = 2308.8254394531;//dom 15
    IntInfo[15][Int_Y] = -1211.2672119141;
    IntInfo[15][Int_Z] = 1049.0234375;
    IntInfo[15][Int] = 6;
    IntInfo[15][Kategoria] = 2;
    IntInfo[15][Pokoje] = 2;
    IntInfo[15][Cena] = 95000;
    IntInfo[16][Int_X] = 2216.4047851563;//dom 16
    IntInfo[16][Int_Y] = -1076.3693847656;
    IntInfo[16][Int_Z] = 1050.484375;
    IntInfo[16][Int] = 1;
    IntInfo[16][Kategoria] = 2;
    IntInfo[16][Pokoje] = 2;
    IntInfo[16][Cena] = 100000;
    IntInfo[17][Int_X] = 2283.1279296875;//dom 17
    IntInfo[17][Int_Y] = -1138.7651367188;
    IntInfo[17][Int_Z] = 1050.89843751;
    IntInfo[17][Int] = 11;
    IntInfo[17][Kategoria] = 2;
    IntInfo[17][Pokoje] = 3;
    IntInfo[17][Cena] = 115000;
    IntInfo[18][Int_X] = 223.14936828613;//dom 18
    IntInfo[18][Int_Y] = 1287.5688476563;
    IntInfo[18][Int_Z] = 1082.140625;
    IntInfo[18][Int] = 1;
    IntInfo[18][Kategoria] = 2;
    IntInfo[18][Pokoje] = 4;
    IntInfo[18][Cena] = 120000;
    IntInfo[19][Int_X] = 2233.7893066406;//dom 19
    IntInfo[19][Int_Y] = -1115.1715087891;
    IntInfo[19][Int_Z] = 1050.8828125;
    IntInfo[19][Int] = 5;
    IntInfo[19][Kategoria] = 2;
    IntInfo[19][Pokoje] = 1;
    IntInfo[19][Cena] = 125000;
    IntInfo[20][Int_X] = 443.49890136719;//dom 20 bug
    IntInfo[20][Int_Y] = 509.49703979492;
    IntInfo[20][Int_Z] = 1001.41949462892;
    IntInfo[20][Int] = 12;
    IntInfo[20][Kategoria] = 2;
    IntInfo[20][Pokoje] = 2;
    IntInfo[20][Cena] = 140000;
    //kategoria 3
    IntInfo[21][Int_X] = 385.5547;//dom 21
    IntInfo[21][Int_Y] = 1471.6407;
    IntInfo[21][Int_Z] = 1080.1949;
    IntInfo[21][Int] = 15;
    IntInfo[21][Kategoria] = 3;
    IntInfo[21][Pokoje] = 3;
    IntInfo[21][Cena] = 145000;
    IntInfo[22][Int_X] = 261.8072;//dom 22
    IntInfo[22][Int_Y] = 1241.7100;
    IntInfo[22][Int_Z] = 1084.2578;
    IntInfo[22][Int] = 9;
    IntInfo[22][Kategoria] = 3;
    IntInfo[22][Pokoje] = 4;
    IntInfo[22][Cena] = 150000;
    IntInfo[23][Int_X] = 23.7709;//dom 23 taki sam jak nizej
    IntInfo[23][Int_Y] = 1341.2079;
    IntInfo[23][Int_Z] = 1084.3750;
    IntInfo[23][Int] = 10;
    IntInfo[23][Kategoria] = 3;
    IntInfo[23][Pokoje] = 4;
    IntInfo[23][Cena] = 155000;
    IntInfo[25][Int_X] = 329.1805;//dom 25
    IntInfo[25][Int_Y] = 1478.9669;
    IntInfo[25][Int_Z] = 1084.437515;
    IntInfo[25][Int] = 15;
    IntInfo[25][Kategoria] = 3;
    IntInfo[25][Pokoje] = 5;
    IntInfo[25][Cena] = 160000;
    IntInfo[26][Int_X] = 2807.6186523438;//dom 26
    IntInfo[26][Int_Y] = -1173.2073974609;
    IntInfo[26][Int_Z] = 1025.57031258;
    IntInfo[26][Int] = 8;
    IntInfo[26][Kategoria] = 3;
    IntInfo[26][Pokoje] = 3;
    IntInfo[26][Cena] = 165000;
    IntInfo[27][Int_X] = 2237.5952148438;//dom 27
    IntInfo[27][Int_Y] = -1079.6644287109;
    IntInfo[27][Int_Z] = 1049.02343752;
    IntInfo[27][Int] = 2;
    IntInfo[27][Kategoria] = 3;
    IntInfo[27][Pokoje] = 3;
    IntInfo[27][Cena] = 170000;
    IntInfo[28][Int_X] = 261.16397094727;//dom 28
    IntInfo[28][Int_Y] = 1286.0953369141;
    IntInfo[28][Int_Z] = 1080.25781254;
    IntInfo[28][Int] = 4;
    IntInfo[28][Kategoria] = 3;
    IntInfo[28][Pokoje] = 4;
    IntInfo[28][Cena] = 175000;
    IntInfo[29][Int_X] = -262.10150146484;//dom 29
    IntInfo[29][Int_Y] = 1456.7391357422;
    IntInfo[29][Int_Z] = 1084.36718754;
    IntInfo[29][Int] = 4;
    IntInfo[29][Kategoria] = 3;
    IntInfo[29][Pokoje] = 3;
    IntInfo[29][Cena] = 180000;
    //Kategoria 4 (apartamenty)
    IntInfo[30][Int_X] = 376.3023;//dom 30
    IntInfo[30][Int_Y] = 1417.1825;
    IntInfo[30][Int_Z] = 1081.3281;
    IntInfo[30][Int] = 15;
    IntInfo[30][Kategoria] = 4;
    IntInfo[30][Pokoje] = 4;
    IntInfo[30][Cena] = 181000;
    IntInfo[31][Int_X] = 446.5189;//dom 31
    IntInfo[31][Int_Y] = 1399.3490;
    IntInfo[31][Int_Z] = 1084.3047;
    IntInfo[31][Int] = 2;
    IntInfo[31][Kategoria] = 4;
    IntInfo[31][Pokoje] = 5;
    IntInfo[31][Cena] = 182000;
    IntInfo[32][Int_X] = 295.4799;//dom 32
    IntInfo[32][Int_Y] = 1473.8265;
    IntInfo[32][Int_Z] = 1080.2578;
    IntInfo[32][Int] = 15;
    IntInfo[32][Kategoria] = 4;
    IntInfo[32][Pokoje] = 5;
    IntInfo[32][Cena] = 183000;
    IntInfo[34][Int_X] = 2195.7058105469;//dom 34
    IntInfo[34][Int_Y] = -1204.3842773438;
    IntInfo[34][Int_Z] = 1049.0234375;
    IntInfo[34][Int] = 6;
    IntInfo[34][Kategoria] = 4;
    IntInfo[34][Pokoje] = 6;
    IntInfo[34][Cena] = 184000;
    IntInfo[35][Int_X] = 2269.0183105469;//dom 35
    IntInfo[35][Int_Y] = -1210.4658203125;
    IntInfo[35][Int_Z] = 1047.5625;
    IntInfo[35][Int] = 10;
    IntInfo[35][Kategoria] = 4;
    IntInfo[35][Pokoje] = 4;
    IntInfo[35][Cena] = 185000;
    IntInfo[36][Int_X] = 2365.2951660156;//dom 36 taki sam jak 33
    IntInfo[36][Int_Y] = -1134.3520507813;
    IntInfo[36][Int_Z] = 1050.8990478516;
    IntInfo[36][Int] = 8;
    IntInfo[36][Kategoria] = 4;
    IntInfo[36][Pokoje] = 4;
    IntInfo[36][Cena] = 186000;
    //Kategoria 5 (Ville)
    IntInfo[37][Int_X] = 235.5197;//dom 37
    IntInfo[37][Int_Y] = 1188.7935;
    IntInfo[37][Int_Z] = 1080.2578;
    IntInfo[37][Int] = 3;
    IntInfo[37][Kategoria] = 5;
    IntInfo[37][Pokoje] = 6;
    IntInfo[37][Cena] = 190000;
    IntInfo[38][Int_X] = 140.50755310059;//dom 38
    IntInfo[38][Int_Y] = 1368.2507324219;
    IntInfo[38][Int_Z] = 1083.8626708984;
    IntInfo[38][Int] = 5;
    IntInfo[38][Kategoria] = 5;
    IntInfo[38][Pokoje] = 5;
    IntInfo[38][Cena] = 195000;
    IntInfo[39][Int_X] = 83.150199890137;//dom 39
    IntInfo[39][Int_Y] = 1324.0864257813;
    IntInfo[39][Int_Z] = 1083.859375;
    IntInfo[39][Int] = 9;
    IntInfo[39][Kategoria] = 5;
    IntInfo[39][Pokoje] = 6;
    IntInfo[39][Cena] = 196000;
    IntInfo[40][Int_X] = 231.4000;//dom 42
    IntInfo[40][Int_Y] = 1114.1000;
    IntInfo[40][Int_Z] = 1080.9922;
    IntInfo[40][Int] = 5;
    IntInfo[40][Kategoria] = 5;
    IntInfo[40][Pokoje] = 8;
    IntInfo[40][Cena] = 197000;
    IntInfo[41][Int_X] = 225.6000;//dom 43
    IntInfo[41][Int_Y] = 1023.5000;
    IntInfo[41][Int_Z] = 1084.0117;
    IntInfo[41][Int] = 7;
    IntInfo[41][Kategoria] = 5;
    IntInfo[41][Pokoje] = 9;
    IntInfo[41][Cena] = 198000;
    IntInfo[42][Int_X] = 2324.3999;//dom 44
    IntInfo[42][Int_Y] = -1147.5000;
    IntInfo[42][Int_Z] = 1050.7101;
    IntInfo[42][Int] = 12;
    IntInfo[42][Kategoria] = 5;
    IntInfo[42][Pokoje] = 11;
    IntInfo[42][Cena] = 199000;
    //Kategoria 6 (pa�ace)
    IntInfo[43][Int_X] = 1263.1934814453;//dom 43 MADD DOG kategoria 8
    IntInfo[43][Int_Y] = -785.47039794922;
    IntInfo[43][Int_Z] = 1091.90625;
    IntInfo[43][Int] = 5;
    IntInfo[43][Kategoria] = 6;
    IntInfo[43][Pokoje] = 15;
    IntInfo[43][Cena] = 200000;
    IntInfo[44][Int_X] = 1298.8577880859;//dom 44 MADD DOGG kategoria 8
    IntInfo[44][Int_Y] = -794.06591796875;
    IntInfo[44][Int_Z] = 1084.0078125;
    IntInfo[44][Int] = 5;
    IntInfo[44][Kategoria] = 6;
    IntInfo[44][Pokoje] = 11;
    IntInfo[44][Cena] = 200000;
    //Kategoria 7 (Inne)
    IntInfo[45][Int_X] = 744.2455;//dom 45 PORNODOM
    IntInfo[45][Int_Y] = 1437.2065;
    IntInfo[45][Int_Z] = 1102.7031;
    IntInfo[45][Int] = 6;
    IntInfo[45][Kategoria] = 7;
    IntInfo[45][Pokoje] = 4;
    IntInfo[45][Cena] = 200000;
    IntInfo[46][Int_X] = 2526.3950;//dom 3 ZBUGOWANY PRZESWIT
    IntInfo[46][Int_Y] = -1679.4390;
    IntInfo[46][Int_Z] = 1015.498;
    IntInfo[46][Int] = 1;
    IntInfo[46][Kategoria] = 7;
    IntInfo[46][Pokoje] = 4;
    IntInfo[46][Cena] = 200000;

    IntInfo[47][Int_X] = 1284.1958;//WO�P
    IntInfo[47][Int_Y] = -810.7264;
    IntInfo[47][Int_Z] = 109.1989;
    IntInfo[47][Int] = 0;
    IntInfo[47][Kategoria] = 5;
    IntInfo[47][Pokoje] = 7;
    IntInfo[47][Cena] = 200000;

    IntInfo[48][Int_X] = 2149.0562;//Julia 1 - �adny
    IntInfo[48][Int_Y] = -1322.0059;
    IntInfo[48][Int_Z] = 25.8396;
    IntInfo[48][Int] = 0;
    IntInfo[48][Kategoria] = 4;
    IntInfo[48][Pokoje] = 2;
    IntInfo[48][Cena] = 200000;

    IntInfo[49][Int_X] = 2150.1968;//Julia 2 - �adny ma�y
    IntInfo[49][Int_Y] = -1283.3784;
    IntInfo[49][Int_Z] = 24.2428;
    IntInfo[49][Int] = 0;
    IntInfo[49][Kategoria] = 4;
    IntInfo[49][Pokoje] = 2;
    IntInfo[49][Cena] = 200000;

    IntInfo[50][Int_X] = 2126.7422;//Julia 3 - dwupi�trowy
    IntInfo[50][Int_Y] = -1320.4714;
    IntInfo[50][Int_Z] = 26.6311;
    IntInfo[50][Int] = 0;
    IntInfo[50][Kategoria] = 4;
    IntInfo[50][Pokoje] = 4;
    IntInfo[50][Cena] = 200000;

    IntInfo[51][Int_X] = 2131.7869;//Julia 4 - �adny
    IntInfo[51][Int_Y] = -1278.2720;
    IntInfo[51][Int_Z] = 26.0321;
    IntInfo[51][Int] = 0;
    IntInfo[51][Kategoria] = 4;
    IntInfo[51][Pokoje] = 3;
    IntInfo[51][Cena] = 200000;

    IntInfo[52][Int_X] = 2099.9829;//Julia 5 - czarny elegancki
    IntInfo[52][Int_Y] = -1324.0430;
    IntInfo[52][Int_Z] = 26.6471;
    IntInfo[52][Int] = 0;
    IntInfo[52][Kategoria] = 4;
    IntInfo[52][Pokoje] = 1;
    IntInfo[52][Cena] = 200000;

    IntInfo[53][Int_X] = 2091.5286;//Julia 6 - �adny
    IntInfo[53][Int_Y] = -1276.3370;
    IntInfo[53][Int_Z] = 26.1449;
    IntInfo[53][Int] = 0;
    IntInfo[53][Kategoria] = 4;
    IntInfo[53][Pokoje] = 2;
    IntInfo[53][Cena] = 200000;

	IntInfo[54][Int_X] = 2348.0505;
	IntInfo[54][Int_Y] = 1314.0719;
	IntInfo[54][Int_Z] = -77.2239;
	IntInfo[54][Int] = 0;
	IntInfo[54][Kategoria] = 4;
	IntInfo[54][Pokoje] = 2;
	IntInfo[54][Cena] = 200000;

	IntInfo[55][Int_X] = 692.07;
	IntInfo[55][Int_Y] = -1600.20;
	IntInfo[55][Int_Z] = 14.27;
	IntInfo[55][Int] = 0;
	IntInfo[55][Kategoria] = 4;
	IntInfo[55][Pokoje] = 1;
	IntInfo[55][Cena] = 200000;

	IntInfo[56][Int_X] = 1909.52;
	IntInfo[56][Int_Y] = -1117.04;
	IntInfo[56][Int_Z] = 25.75;
	IntInfo[56][Int] = 0;
	IntInfo[56][Kategoria] = 4;
	IntInfo[56][Pokoje] = 1;
	IntInfo[56][Cena] = 200000;
    return 1;
}

//-----------------------[chaty]------------------------------

BroadCast(color,const string[])
{
	SendClientMessageToAll(color, string);
	return 1;
}

ABroadCast(color,const string[],level, podglad = 0)
{
	foreach(new i : Player)
	{
		
		if(IsPlayerConnected(i))
		{
			if(podglad == 0)
			{
				if (PlayerInfo[i][pAdmin] >= level)
				{
					SendClientMessage(i, color, string);
				}
				else if (PlayerInfo[i][pNewAP] >= level)
				{
					SendClientMessage(i, color, string);
				}
				else if (PlayerInfo[i][pZG] >= level)
				{
					SendClientMessage(i, color, string);
				}
			}
			else
			{
				if (PlayerInfo[i][pAdmin] >= level && TogPodglad[i] == 0)
				{
					SendClientMessage(i, color, string);
				}
				else if (PlayerInfo[i][pNewAP] >= level && TogPodglad[i] == 0)
				{
					SendClientMessage(i, color, string);
				}	
			}
		}
	}
	printf("%s", string);
	return 1;
}

OOCOff(color,const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gOoc[i])
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

OOCNewbie(const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gNewbie[i] && GetPVarInt(i, "TOG_newbie") == 0 && PlayerPersonalization[i][PERS_NEWBIE] == 0)
		    {
				SendClientMessage(i, 0x8D8DFF00, string);
			}
		}
	}
}

OOCJoin(const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerPersonalization[i][PERS_JOINLEAVE] == 0)
		    {
				SendClientMessage(i, COLOR_GREY, string);
			}
		}
	}
}

OOCLeft(const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerPersonalization[i][PERS_JOINLEAVE] == 0)
		    {
				SendClientMessage(i, COLOR_GREY, string);
			}
		}
	}
}

OOCNews(color,const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gNews[i] && PlayerPersonalization[i][PERS_AD] == 0)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}
SendTeamMessage(team, color, string[], isDepo = 0, perm = 0)
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
			if(perm == 0)
			{
				if(IsPlayerInGroup(i, team))
				{
					if(isDepo == 1 && gMuteDepo[i] == 0) 
					{
						SendClientMessage(i, color, string);
					}
					if(isDepo == 0) {
						SendClientMessage(i, color, string);
					}
				}
			}
			else
			{
				new sent[MAX_PLAYERS];
				if(CheckPlayerPerm(i, perm))
				{
					if(sent[i] == 0)
					{
						if(isDepo == 1 && gMuteDepo[i] == 0) 
						{
							SendClientMessage(i, color, string);
							sent[i] = 1;
						}
						if(isDepo == 0) {
							SendClientMessage(i, color, string);
							sent[i] = 1;
						}
					}
				}
			}
		}
	}
}
SendTeamMessageOnDuty(team, color, string[], bool:isBW = false, perm = 0)
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
			if(perm == 0)
			{
				if(IsPlayerInGroup(i, team) && OnDuty[i] == GetPlayerGroupSlot(i, team))
				{
					if(isBW == true)
					{
						if(gBW[i] == 0) SendClientMessage(i, color, string);
					}
					else
					{
						SendClientMessage(i, color, string);
					}
				}
			}
			else
			{
				new sent[MAX_PLAYERS];
				if(CheckPlayerPerm(i, perm) && OnDuty[i] > 0)
				{
					if(sent[i] == 0)
					{
						if(isBW == true)
						{
							if(gBW[i] == 0) SendClientMessage(i, color, string);
						}
						else
						{
							SendClientMessage(i, color, string);
						}
					}
				}
			}
		}
	}
}

PlayCrimeReportForPlayersTeam(team, suspectid, level = 16)
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(IsPlayerInGroup(i, team))
		    {
		    	PlayCrimeReportForPlayer(i, suspectid, level);
			}
		}
	}
}

SendRadioMessage(member, color, string[], ooc = 0, crime = 0)
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(IsPlayerInGroup(i, member))
		    {
				if(gRO[i] == 1 && ooc == 1) continue;
				if(crime == 1 && gCrime[i] == 1) continue;
				new realstring[256];
				if(ooc == 0) format(realstring, sizeof(realstring), "**!%d%s", GetPlayerGroupSlot(i, member), string);
				else format(realstring, sizeof(realstring), "**@%d%s", GetPlayerGroupSlot(i, member), string);
				SendClientMessage(i, color, realstring);
			}
		}
	}
}

SendLeaderRadioMessage(member, color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(GroupIsVLeader(i, member))
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

SendJobMessage(job, color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pJob] == job)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}
GetPlayerIDFromUID(playerUID)
{
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pUID] == playerUID)
			return i;
	}
	return INVALID_PLAYER_ID;
}
GetPlayerIDFromName(playerName[])
{
	foreach(new i : Player)
	{
		if(strcmp(GetNick(i), playerName, false, strlen(playerName)) == 0)
		{
			return i; 
		}
	}
	return INVALID_PLAYER_ID; 
}
WyscigMessage(color, string[])
{
	foreach(new i : Player)
	{
		if(ScigaSie[i] != 666)
		{
			SendClientMessage(i, color, string);
		}
	}
}
SendIRCMessage(channel, color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayersChannel[i] == channel)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

SendSMSMessageToAll(senderNumber, message[])
{
	foreach(new i : Player)
	{
		if(GetPhoneNumber(i) != 0)
		{
			SendSMSMessage(senderNumber, i, message);
		}
	}
}

SendSMSMessage(senderNumber, reciverid, message[])
{
	new string[144], string2[144];
	
	new slotKontaktu = PobierzSlotKontaktuPoNumerze(reciverid, senderNumber);
	if(strlen(message) < 78)
	{
		if(slotKontaktu >= 0)
		{
			format(string, sizeof(string), "SMS: %s, Nadawca: %s (%d)", message, Kontakty[reciverid][slotKontaktu][eNazwa], senderNumber);
		}
		else
		{
			format(string, sizeof(string), "SMS: %s, Nadawca: %d", message, senderNumber);
		}
		SendClientMessage(reciverid, COLOR_YELLOW, string);
	}
	else
	{
		new pos = strfind(message, " ", true, strlen(message) / 2);
		if(pos != -1)
		{
			new text2[64], text[128];
			strmid(text2, text, pos, strlen(text));
			strdel(text, pos, strlen(text));

			if(slotKontaktu >= 0)
			{
				format(string2, sizeof(string2), "[.] %s, Nadawca: %s (%d)", text2, Kontakty[reciverid][slotKontaktu][eNazwa], senderNumber);
			}
			else
			{
				format(string2, sizeof(string2), "[.] %s, Nadawca: %d", text2, senderNumber);
			}

			format(string, sizeof(string), "SMS: %s [.]", text);
			SendClientMessage(reciverid, COLOR_YELLOW, string);
			SendClientMessage(reciverid, COLOR_YELLOW, string2);
		}
	}

	PlayerPlaySound(reciverid, 6401, 0.0, 0.0, 0.0);
	LastSMSNumber[reciverid] = senderNumber;
}

StartACall(playerid, reciverid)
{
	Mobile[playerid] = reciverid;
	Mobile[reciverid] = playerid;
	
	RingTone[reciverid] = 1;
	CellTime[playerid] = 1;
}

StopACall(playerid)
{
	new reciverid = Mobile[playerid];
	StopACallForPlayer(playerid);
	
	new payer = playerid;
	if(reciverid >= 0)
	{
		StopACallForPlayer(reciverid);
		if(CellTime[reciverid] != 0) 
		{
			payer = reciverid;
		}
		
		if(TalkingLive[playerid] == reciverid)
		{
			TalkingLive[playerid] = INVALID_PLAYER_ID;
			TalkingLive[reciverid] = INVALID_PLAYER_ID;
		}
	}
	
	if(CellTime[payer] != 0)
	{
		new string[64];
		new cost = floatround(float(CellTime[payer]) * callcost);
		ZabierzKaseDone(payer, cost);
		CellTime[payer] = 0;
		format(string, sizeof(string), "~w~Koszt rozmowy: ~n~~r~$%d", cost);
		GameTextForPlayer(payer, string, 5000, 1);
	}
	
}

StopACallForPlayer(playerid)
{
	Mobile[playerid] = INVALID_PLAYER_ID;
	RingTone[playerid] = 0;
	Callin[playerid] = CALL_NONE;
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
}

bool:CzyGraczMaKontakty(playerid)
{
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] != 0)
		{
			return true;
		}
	}
	return false;
}

PobierzSlotKontaktuPoNumerze(playerid, numer)
{
	if(numer <= 0)
	{
		return -1;
	}

	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] == numer)
		{
			return i;
		}
	}
	return -1;
}

ListaKontaktowGracza(playerid)
{
	new string[58*MAX_KONTAKTY];
	
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] == 0)
		{
			continue;
		}
		
		if(FindPlayerByNumber(Kontakty[playerid][i][eNumer]) != INVALID_PLAYER_ID)
		{
			//aktywny
			format(string, sizeof(string), "{FFFFFF}%s%s - %d {00FF00}(on-line)\n", string, Kontakty[playerid][i][eNazwa], Kontakty[playerid][i][eNumer]);
		}
		else
		{
			//nieaktywny
			format(string, sizeof(string), "{FFFFFF}%s%s - %d {FF0000}(off-line)\n", string, Kontakty[playerid][i][eNazwa], Kontakty[playerid][i][eNumer]);
		}
	}
	
	safe_return string;
}


PobierzWolnySlotNaKontakt(playerid)
{
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] == 0)
		{
			return i;
		}
	}
	return -1; //error
}

CzyMaWolnySlotNaKontakt(playerid)
{
	return PobierzWolnySlotNaKontakt(playerid) != -1;
}

CzyKontaktIstnieje(playerid, numer)
{
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] == numer)
		{
			return true;
		}
	}
	return false;
}

DodajKontakt(playerid, nazwa[], numer)
{
	new slot = PobierzWolnySlotNaKontakt(playerid);
	if(slot == -1) return 0; //error
	format(Kontakty[playerid][slot][eNazwa], MAX_KONTAKT_NAME, "%s", nazwa);
	Kontakty[playerid][slot][eNumer] = numer;
	Kontakty[playerid][slot][eUID] = MruMySQL_AddPhoneContact(playerid, nazwa, numer);
	return 1;
}

EdytujKontakt(playerid, slot, nazwa[])
{
	format(Kontakty[playerid][slot][eNazwa], MAX_KONTAKT_NAME, "%s", nazwa);
	MruMySQL_EditPhoneContact(Kontakty[playerid][slot][eUID], nazwa);
	return 1;
}

UsunKontakt(playerid, slot)
{
	MruMySQL_DeletePhoneContact(Kontakty[playerid][slot][eUID]);
	
	Kontakty[playerid][slot][eUID] = 0;
	format(Kontakty[playerid][slot][eNazwa], MAX_KONTAKT_NAME, "%s", "");
	Kontakty[playerid][slot][eNumer] = 0;
	return 1;
}

PobierzIdKontaktuZDialogu(playerid, listitem)
{
	new count = listitem+1;
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] != 0)
		{
			count--;
		}
		if(count == 0)
		{
			return i;
		}
	}
	return -1;
}

ZerujKontakty(playerid)
{
	for(new i; i<MAX_KONTAKTY; i++)
	{
		Kontakty[playerid][i][eUID] = 0;
		Kontakty[playerid][i][eNumer] = 0;
	}
}

SendAdminMessage(color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pNewAP] >= 1 || IsAScripter(i))
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

SendScripterMessage(color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pAdmin] >= 1000 || IsAScripter(i))
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}


SendZGWiadomosc(color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pZG] >= 1)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

SendCommandLogMessage(string[])
{
	foreach(new i : Player)
	{
	    if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pNewAP] >= 1 || IsAScripter(i))
	    {
			if(GetPVarInt(i, "togcmdlog") == 0) SendClientMessage(i, 0xD8C173FF, string);
		}
	}
}

SendPunishMessage(string[], playerid=INVALID_PLAYER_ID)
{
	foreach(new i : Player)
	{
		if(GetPVarInt(i, "togadmincmd") == 0) SendClientMessage(i, COLOR_LIGHTRED, string);
        else if(playerid == i) SendClientMessage(i, COLOR_LIGHTRED, string);
	}
}

SendZGMessage(color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pNewAP] >= 1 || PlayerInfo[i][pZG] >= 1 || IsAScripter(i))
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

//-----------------------[koniec chaty]------------------------------
AddCar(car)
{
	new randcol = random(126);
	new randcol2 = 1;
	if (rccounter == 14)
	{
		rccounter = 0;
	}
	new id = AddStaticVehicleEx(carselect[rccounter], CarSpawns[car][pos_x], CarSpawns[car][pos_y], CarSpawns[car][pos_z], CarSpawns[car][z_angle], randcol, randcol2, -1);
	rccounter++;
	return id;
}

ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(!BigEar[i])
				{
				    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
				    {
						GetPlayerPos(i, posx, posy, posz);
						tempposx = (oldposx -posx);
						tempposy = (oldposy -posy);
						tempposz = (oldposz -posz);
						//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
						if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						{
							SendClientMessage(i, col1, string);
						}
						else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						{
							SendClientMessage(i, col2, string);
						}
						else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						{
							SendClientMessage(i, col3, string);
						}
						else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						{
							SendClientMessage(i, col4, string);
						}
						else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						{
							SendClientMessage(i, col5, string);
						}
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}//not connected
	return 1;
}

PolicjantWStrefie(Float:radi, playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    foreach(new i : Player)
		{
		    new Float:rangex, Float:rangey, Float:rangez;
		    GetPlayerPos(playerid, rangex, rangey, rangez);
	    	if(IsPlayerInRangeOfPoint(i, radi, rangex, rangey, rangez))
	        {
	            if(IsAPolicja(i) && Spectate[i] == INVALID_PLAYER_ID && i != playerid)
	            {
	            	return 1;
	            }
	        }
	    }
	}
	return 0;
}

ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

ProxDetectorW(Float:radi, Float:Pozy_X, Float:Pozy_Y, Float:Pozy_Z, ColorW, Wiadomosc[])
{
	new Float:Pozycja_Xx, Float:Pozycja_Yy, Float:Pozycja_Zz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	foreach(new i : Player)
	{
        GetPlayerPos(i, Pozycja_Xx, Pozycja_Yy, Pozycja_Zz);
        tempposx = (Pozycja_Xx - Pozy_X);
        tempposy = (Pozycja_Yy - Pozy_Y);
        tempposz = (Pozycja_Zz - Pozy_Z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
		    SendClientMessage(i, ColorW, Wiadomosc);
		}
	}
}

PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, radi, x, y, z))
		{
			return 1;
		}
	}
	return 0;
}

VehicleToPoint(Float:radi, vehicleid, Float:x, Float:y, Float:z)
{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetVehiclePos(vehicleid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
		return 0;
}
FixHour(hour)
{
	hour = timeshift+hour+1;
	if (hour < 0)
	{
		hour = hour+24;
	}
	else if (hour > 23)
	{
		hour = hour-24;
	}
	shifthour = hour;
	return 1;
}

public MRP_ForceDialog(playerid, dialogid)
{
    if(dialogid != -1) GUIExit[playerid] = 1;
    else GUIExit[playerid] = 0;
    iddialog[playerid] = dialogid;
    return 1;
}
stock ShowPlayerInfoDialog(playerid, caption[], info[], bool:dialogTimer=false)
{
	if(dialAccess[playerid] == 0)
	{
		ShowPlayerDialogEx(playerid, DIALOG_EMPTY_SC, DIALOG_STYLE_MSGBOX, caption, info, "Okej", "");
		if(dialogTimer == true)
		{
			dialTimer[playerid] = SetTimerEx("timerDialogs", 5000, true, "i", playerid);
			dialAccess[playerid] = 1; 
		}
	}
	else
	{
		sendErrorMessage(playerid, "Odczekaj 15 sekund przed wywo�aniem kolejnego dialogu"); 
	}
	return 1;
}
stock ShowPlayerDialogEx(playerid, dialogid, style, caption[], info[], button1[], button2[], bool:dialogTimer=false)
{
	if(dialAccess[playerid] == 0)
	{
		ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
		iddialog[playerid] = dialogid;
		antyHider[playerid] = 1;
		if(dialogTimer == true)
		{
			dialTimer[playerid] = SetTimerEx("timerDialogs", 5000, true, "i", playerid);
			dialAccess[playerid] = 1; 
		}
	}
	else
	{
		sendErrorMessage(playerid, "Odczekaj 15 sekund przed wywo�aniem kolejnego dialogu"); 
	}
	return 1;
}

SoundForAll(sound)
{
	for(new i = 0, j = MAX_PLAYERS; i < j; i ++)
		if (IsPlayerConnected(i))
			PlayerPlaySound(i,sound,0.0,0.0,0.0);
}

ListaWyscigow()
{
	new trasy[3000];
	for(new i=0; i<sizeof(Wyscig); i++)
	{
		if(Wyscig[i][wStworzony] == 1)
		{
			format(trasy, sizeof(trasy), "%s\n{7CFC00}Nazwa:{FFFFFF} %s\t{7CFC00}Wygrana:{FFFFFF} %d$", trasy, Wyscig[i][wNazwa], Wyscig[i][wNagroda]);
		}
		else
		{
			strcat(trasy, "{7CFC00}Nazwa:{FFFFFF} brak trasy\n");
		}
	}
	return trasy;
}

FunkcjaK(string[])
{
	new Float:x;
	new ilosc_k=0;

	if(strval(string) != 0 && strlen(string) > 1)
	{
		for(new i=strlen(string); i>0; i--)
		{
			if(string[i] == 'k')
				ilosc_k++;
            else if(string[i] == 'K')
				ilosc_k++;
		}
		if(ilosc_k != 0)
		{
			strdel(string, strlen(string)-ilosc_k, strlen(string));
			x=floatstr(string);
			return floatround((ilosc_k==1) ? (x*1000) : ((ilosc_k==2) ? (x*1000000) : (x*1000000000)), floatround_tozero); //zbugowane pot�gi: x*(1000^ilosc_k)
		}
	}
	return strval(string);
}

forward MUSIC_Response(index, response_code, data[]);
public MUSIC_Response(index, response_code, data[])
{
    if(index == 40)
    {
        if(response_code == 404)
        {
            strcat(AUDIO_LoginFormat, "mp3");
        }
        else strcat(AUDIO_LoginFormat, "ogg");
    }
    return 1;
}

public OPCLogin(playerid)
{
    new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, MAX_PLAYER_NAME);

    TogglePlayerControllable(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    SetPlayerCameraPos(playerid, 1288.0, -793.0, 109.0);
    SetPlayerCameraLookAt(playerid, 1288.0, -794.0, 109.0);

    TourCamera(playerid, 0);
	if(GetPVarInt(playerid, "IsDownloadingContent") == 1) DeletePVar(playerid, "IsDownloadingContent");
    //Strefy load
    ZonePTXD_Load(playerid);
    ZonePlayerTimer[playerid]=0;
    for(new j=0;j<MAX_ZONES;j++)
    {
        if(ZoneControl[j] == FRAC_GROOVE) GangZoneShowForPlayer(playerid, j, ZONE_COLOR_GROOVE | 0x44);
        else if(ZoneControl[j] == FRAC_BALLAS) GangZoneShowForPlayer(playerid, j, ZONE_COLOR_BALLAZ | 0x44);
        else if(ZoneControl[j] == FRAC_VAGOS) GangZoneShowForPlayer(playerid, j, ZONE_COLOR_VAGOS | 0x44);
        else if(ZoneControl[j] == FRAC_WPS) GangZoneShowForPlayer(playerid, j, ZONE_COLOR_WPS | 0x44);
        else if(ZoneControl[j] > 100) GangZoneShowForPlayer(playerid, j, OrgInfo[clamp(orgID(ZoneControl[j]-100), 0, MAX_ORG-1)][o_Color] | 0x44);
        else GangZoneShowForPlayer(playerid, j, 0xC6E2F144);
    }

	GUIExit[playerid] = 1;
	SafeTime[playerid] = 60*3;//ogarniczenie 3 minuty na logowanie
	SetPlayerColor(playerid,COLOR_GRAD2);

	LoadingHide(playerid);
	BottomBar(playerid, 1);
    new result;
    result = MruMySQL_DoesAccountExist(nick);
	//Sprawdzanie czy konto istnieje:
	if(result == -1 || result == 1) //logowanie
	{
        //Logowanie
		new string[512];
		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na czwartej edycji Kotnik Role Play, zaloguj si� aby poczu� VIBE.");
		format(string, sizeof(string), "{adc7e7}Witaj na Kotnik-RP.pl, serwerze o wielkich mo�liwo�ciach\nZaloguj si� lub do��cz ju� dzisiaj do nas i baw si� razem z nami w �wiecie GTA.\n\nKonto o takim nicku jest ju� stworzone.\nJest Twoja? Wpisz has�o i zaloguj si�.\nJe�eli nie wyjd� i wejd� na nowym nicku!", nick);
		ShowPlayerDialogEx(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "Logowanie", string, "Zaloguj", "Wyjd�");
		gPlayerAccount[playerid] = 1; //logowanie
	}
    else if(result == -999)
    {
        new string[256];
		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na czwartej edycji Kotnik Role Play, zaloguj si� aby poczu� VIBE.");
		format(string, sizeof(string), "Nick podobny do %s jest zarejestrowany.\n{FF0000}Podobny nick jest ju� w bazie, sprawd� wielkos� znak�w.", nick);
        SendClientMessage(playerid, COLOR_RED, string);
        SendClientMessage(playerid, COLOR_RED, string);
        SendClientMessage(playerid, COLOR_RED, string);
        KickEx(playerid);
    }
	else //rejestracja
	{
        if(VAR_MySQLREGISTER)
        {
			SendClientMessage(playerid, COLOR_RED, "Rejestracja tylko przez forum!");
            KickEx(playerid);
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, "Rejestracja zosta�a wy��czona na czas atak�w, przepraszamy za uniedogodnienia.");
            KickEx(playerid);
        }
	}
    return 1;
}

public NG_OpenGateWithKey(playerid)
{
    new ngstr[6];
    GetPVarString(playerid, "ng-key", ngstr, 6);
    if(strval(ngstr) == STANOWE_GATE_KEY)
    {
    	CancelSelectTextDraw(playerid);
        TextDrawHideForPlayer(playerid,NG_GateTD[0]);
		TextDrawHideForPlayer(playerid,NG_GateTD[1]);
		TextDrawHideForPlayer(playerid,NG_GateTD[2]);
		TextDrawHideForPlayer(playerid,NG_GateTD[3]);
		TextDrawHideForPlayer(playerid,NG_GateTD[4]);
		TextDrawHideForPlayer(playerid,NG_GateTD[5]);
		TextDrawHideForPlayer(playerid,NG_GateTD[6]);
		TextDrawHideForPlayer(playerid,NG_GateTD[7]);
        VAR_NGKeypad = false;
    }
    else
    {
        SendClientMessage(playerid,-1,"Zle Haslo !!");
    }
    TextDrawSetString(NG_GateTD[7], "0000");
    DeletePVar(playerid, "ng-key");
	return 1;
}

OddajZycie(playerid, timevalue, const tekst[],  bool:tekstwyswietl = false)
{
	new Float:health;
	new timeobl;
	new string[128];
	timeobl = timevalue*1000;
	GetPlayerHealth(playerid, health);
	SetPVarFloat(playerid, "odnowaZyciaAdmin", health); 
	TimerOddaniaZycia[playerid] = SetTimerEx("OddajZycieTimer", timeobl, true, "i", playerid);
	SetPVarInt(playerid, "StatusZycia", timeobl);
	format(string, sizeof(string), "%s", tekst); 
	if(tekstwyswietl == true)
	{
		sendTipMessage(playerid, string); 
	}
	return 1;
}
//      Aktualizacja    09.06.2014  KUBI  fix 09 
ElevatorTravel(playerid, Float:x, Float:y, Float:z, vw, Float:face)
{
    if(LSMCElevatorQueue) return;
    LSMCElevatorQueue = true;
    ChangeLSMCElevatorState(); //close them?

    new Float:px, Float:py, Float:pz, pvw;
    GetPlayerPos(playerid, px, py, pz);
    pvw = GetPlayerVirtualWorld(playerid);

    if(!ElevatorVar) ElevatorVar=true;

    foreach(new i : Player)
    {
        if(pvw == GetPlayerVirtualWorld(i) && IsPlayerInRangeOfPoint(i, 2.0, px, py, pz))
        {
            SetPVarFloat(i, "ElX", x);
            SetPVarFloat(i, "ElY", y);
            SetPVarFloat(i, "ElZ", z);
            SetPVarFloat(i, "ElFace", face);
            SetPVarInt(i, "ElVW", vw);

            SetTimerEx("ElevatorTravelEND", 3500, 0, "i", i);
            GameTextForPlayer(i, "~r~Zamykanie windy", 3000, 5);
        }
    }
}

public ElevatorTravelEND(playerid)
{
    SetPlayerPos(playerid, GetPVarFloat(playerid, "ElX"),GetPVarFloat(playerid, "ElY"), GetPVarFloat(playerid, "ElZ"));
    SetPlayerFacingAngle(playerid,GetPVarFloat(playerid, "ElFace"));
    SetCameraBehindPlayer(playerid);
    SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "ElVW"));
    TogglePlayerControllable(playerid, false);
    GameTextForPlayer(playerid, "~g~Otwieranie windy", 1000, 5);
    Wchodzenie(playerid);
    PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
    //Release doors
    if(ElevatorVar)
    {
        ElevatorVar=false;
        ChangeLSMCElevatorState(); //open again
        SetTimer("LSMCElevatorFree", 3000, 0);
    }
    return 1;
}

public LSMCElevatorFree()
{
    LSMCElevatorQueue = false;
    return 1;
}

ChangeLSMCElevatorState()
{
    for(new i=0;i<8;i++)
    {
        if(ElevatorObject[i] == 0)  break;
        if(ElevatorDoorsState[i]) //close them
        {
            if(floatround(ElevatorDoors[i][3]) == 90)
            {
                MoveDynamicObject(ElevatorObject[i],ElevatorDoors[i][0],ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
                MoveDynamicObject(ElevatorObject[i]+1,ElevatorDoors[i][0],ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
            }
            else
            {
                MoveDynamicObject(ElevatorObject[i],ElevatorDoors[i][0],ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
                MoveDynamicObject(ElevatorObject[i]+1,ElevatorDoors[i][0],ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
            }
            ElevatorDoorsState[i] = false;
        }
        else //open them
        {
            if(floatround(ElevatorDoors[i][3]) == 90)
            {
                MoveDynamicObject(ElevatorObject[i],ElevatorDoors[i][0]+1.7,ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
                MoveDynamicObject(ElevatorObject[i]+1,ElevatorDoors[i][0]-1.7,ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
            }
            else
            {
                MoveDynamicObject(ElevatorObject[i],ElevatorDoors[i][0],ElevatorDoors[i][1]-1.7,ElevatorDoors[i][2], 1.0);
                MoveDynamicObject(ElevatorObject[i]+1,ElevatorDoors[i][0],ElevatorDoors[i][1]+1.7,ElevatorDoors[i][2], 1.0);
            }
            ElevatorDoorsState[i] = true;
        }
    }
}

LoadServerInfo()
{
    ServerInfo="\0";
    mysql_query("SELECT `info` FROM `mru_serverinfo` WHERE `aktywne`=1 LIMIT 1");
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(ServerInfo, "|");
        new lPos=0;
        while((lPos = strfind(ServerInfo, "\\n", false, lPos)) != -1)
        {
            strdel(ServerInfo, lPos, lPos+2);
            strins(ServerInfo, "\n", lPos);
            lPos++;
        }
        lPos=0;
        while((lPos = strfind(ServerInfo, "\\t", false, lPos)) != -1)
        {
            strdel(ServerInfo, lPos, lPos+2);
            strins(ServerInfo, "\t", lPos);
            lPos++;
        }
        foreach(new i : Player)
        {
            if(gPlayerLogged[i] == 1) TextDrawShowForPlayer(i, TXD_Info);
        }
    }
	mysql_free_result();
}

LoadConfig()
{
    new query[2048], data[256];
    mysql_query("SELECT * FROM `mru_config`");
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(query, "|");
        sscanf(query, "p<|>s[128]s[128]dds[256]dd", RadioSANUno, RadioSANDos, ZONE_DISABLED, ZONE_DEF_TIME, data, STANOWE_GATE_KEY, TJD_Materials);
        sscanf(data, "a<s[16]>[20]", AUDIO_LoginData);
    }
	mysql_free_result();
    for(new i=0;i<20;i++)
    {
        if(strlen(AUDIO_LoginData[i]) > 1) AUDIO_LoginTotal++;
        else break;
    }

	mysql_query("SELECT `changelog` FROM `mru_config`");
	mysql_store_result();
	if(mysql_num_rows())
	{
		mysql_fetch_row_format(query, "|");
		sscanf(query, "p<|>s[2048]", Changelog);
		strreplace(Changelog, "-n-", "\n", false);
	}
	mysql_free_result();
	printf("Changelog: %s", Changelog);
    format(data, 256, "Kotnik-loginsound.lqs.pl/game/audio/%s.ogg", AUDIO_LoginData[0]);

    format(VINYL_Stream, 128, "%s",RadioSANDos);

    print("Wczytano podstawow� konfiguracj�");
}

WordWrap(source[], bool:spaces, dest[], size = sizeof(dest), chars = 30)
{
    new length = strlen(source);

    strcat((dest[0] = '\0', dest), source, size);

    if (length <= 0)
        return 0;

    while (--length != 0) if ((length % chars) == 0)
    {
        if (!spaces) {
            strins(dest, "\r\n", length, size);
        }
        else for(new i = length; dest[i] != '\0'; i ++) if (dest[i] == ' ' && dest[i + 1] != '\r') {
            strins(dest, "\r\n", i + 1, size); break;
        }
    }
    return 1;
}

stock wordwrapEx(givenString[128])
{
	new temporalString[ 128 ];
	memcpy(temporalString, givenString, 0, 128 * 4);

	new comaPosition = strfind(temporalString, ",", true, 0),
		dotPosition  = strfind(temporalString, ".", true, 0);
	while(comaPosition != -1)
	{
		if(temporalString[comaPosition+1] != ' ') strins(temporalString, " ", comaPosition + 1);
		comaPosition = strfind(temporalString, ",", true, comaPosition + 1);
	}
	while(dotPosition != -1)
	{
		if(temporalString[dotPosition+1] != ' ') strins(temporalString, " ", dotPosition + 1);
		dotPosition = strfind(temporalString, ",", true, dotPosition + 1);
	}

	new spaceCounter = 0,
		spacePosition = strfind(temporalString, " ", true, 0);

	while(spacePosition != -1)
	{
		spaceCounter++;
		if(spaceCounter % 4 == 0 && spaceCounter != 0)
		{
			strins(temporalString, "\n", spacePosition + 1);
		}
		spacePosition = strfind(temporalString, " ", true, spacePosition + 1);
	}
	return temporalString;
}

Mats_Add(frakcja, mats)
{
	GroupInfo[frakcja][g_Mats]+=mats;
	GroupSave(frakcja, true);
	Log(sejfLog, WARNING, "SEJF [%d] + [%d] - poprzednio [%d]", frakcja, mats, GroupInfo[frakcja][g_Mats]);
}

Sejf_Add(frakcja, kasa)
{
    GroupInfo[frakcja][g_Money]+=kasa;
    GroupSave(frakcja, true);
	Log(sejfLog, WARNING, "SEJF GRUPA [%d] + [%d] - poprzednio [%d]", frakcja, kasa, GroupInfo[frakcja][g_Money]);
}

//koniec


IsNickCorrect(nick[])
{
	if(regex_match(nick, "^[A-Z]{1}[a-z]{1,}(_[A-Z]{1}[a-z]{1,}([A-HJ-Z]{1}[a-z]{1,})?){1,2}$") >= 0)
	{
		return 1;
	}
	return 0;
}

CheckAlfaNumeric(password[])
{
    new charsets[46] = "0123456789a�bc�de�fghijkl�mn�o�prs�tuvwyz��xq";

    new bool:validchars[64]={false,...};

    new bool:doeschange=false;
    for(new i=0;i<strlen(password);i++)
    {
        for(new a=0;a<46;a++)
        {
            if(tolower(password[i]) == charsets[a]) validchars[i] = true;
        }
        if(!validchars[i]) //!alpha
        {
            password[i] = charsets[random(sizeof(charsets))];
            if(!doeschange) doeschange=true;
        }
    }
    return doeschange;
}

GetVehicleMaxPassengers(iModel) //RydeR
{
    if(400 <= iModel <= 611)
    {
        static
            s_MaxPassengers[] =
            {
                271782163, 288428337, 288559891, -2146225407, 327282960, 271651075, 268443408, 286339857, 319894289, 823136512, 805311233,
                285414161, 286331697, 268513553, 18026752, 286331152, 286261297, 286458129, 856765201, 286331137, 856690995, 269484528,
                51589393, -15658689, 322109713, -15527663, 65343
            }
        ;
        return ((s_MaxPassengers[(iModel -= 400) >>> 3] >>> ((iModel & 7) << 2)) & 0xF);
    }
    return 0xF;
}

issafefortextdraw(str[]) { //JerneL

	new safetil = -5;

	for(new i = 0; i < strlen(str); i++) {

		if ((str[i] == 126) && (i > safetil)) {

			if (i >= strlen(str) - 1) // not enough room for the tag to end at all.
				return false;

			if (str[i + 1] == 126)
				return false; // a tilde following a tilde.

			if (str[i + 2] != 126)
				return false; // a tilde not followed by another tilde after 2 chars

			safetil = i + 2; // tilde tag was verified as safe, ignore anything up to this location from further checks (otherwise it'll report tag end tilde as improperly started tag..).
		}
	}

	return true;
}

//Kubi AIRLINES system TOWER manager 3D

Render_Smart3D(playerid, vehicleid, Float:x, Float:y, Float:z)
{
    z = (80.4125) - ((y+2297.7136 +250.0)/600);
    y=-2297.7136;
    x = (1627.3287)-((1627.3287-x +100.0)/600);

    new str[32];
    format(str, 32, ".\n%d-%s", vehicleid, VehicleNames[GetVehicleModel(vehicleid)-400]);
    TOWER_TrafficHologram[playerid][vehicleid] = CreatePlayer3DTextLabel(playerid, str, 0xFF0000FF, x, y, z, 8.0);
}

AirTower3DDelete(playerid)
{
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        if(_:TOWER_TrafficHologram[playerid][i] != 0)
        {
            DeletePlayer3DTextLabel(playerid, TOWER_TrafficHologram[playerid][i]);
            TOWER_TrafficHologram[playerid][i]=PlayerText3D:0;
        }
    }
}

public INT_AirTower_RadarLoop(playerid)
{
    if(TOWER_ActivePlayers <= 0) return;
    AirTower3DDelete(playerid);
    new Float:x, Float:y, Float:z;
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        if(!IsAPlane(i)) continue;
        GetVehiclePos(i, x, y, z);
        if(VectorSize(x-1671.0825,y+2538.0308,z-13.5469) < 1500.0)
        {
            if(GetCarSpeed(i) > 2) //moving somewhere
            {
                Render_Smart3D(playerid, i, x, y, z);
            }
        }
    }
}

INT_AirTower_RadarInit(playerid) //first step
{
    TOWER_PlayerHologram[playerid] = CreatePlayer3DTextLabel(playerid, "=========================================\n=                                                                                |\n=========================================\n\n\n\n\n                          TOWER", 0xFFFF00FF, 1627.3287, -2297.7136, 80.4125, 8.0);

    INT_AirTower_RadarLoop(playerid);
    TOWET_LoopTimer[playerid] = SetTimerEx("INT_AirTower_RadarLoop", 1000, 1, "i", playerid);
}

INT_AirTower_RadarExit(playerid)
{
    DeletePlayer3DTextLabel(playerid, TOWER_PlayerHologram[playerid]);
    AirTower3DDelete(playerid);
}

public TRAIN_DoHorn(veh)
{
    new Float:x, Float:y, Float:z;
    GetVehiclePos(veh, x, y,z);
    new Float:angle, Float:ix, Float:iy, Float:iz, Float:dist;
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(IsPlayerInRangeOfPoint(i, 100.0, x, y, z))
        {
            SetPVarInt(i, "train-horn", 1);
            GetPlayerPos(i, ix, iy, iz);
            dist = VectorSize(ix-x, iy-y, iz-z);
            if(dist > 18.0)
            {
                dist = dist - (floatsqroot(dist)*1.5);
                angle = 180.0-atan2(x-ix,y-iy);
                x+=dist*floatsin(-angle, degrees);
                y+=dist*floatcos(-angle, degrees);
                PlayerPlaySound(i, 9200, x, y, z);
            }
            else if(dist < 1.5)
            {
                PlayerPlaySound(i, 9200, 0.0, 0.0, 0.0);
            }
        }
        else if(GetPVarInt(i, "train-horn") == 1)
        {
            PlayerPlaySound(i, 8199, 0.0, 0.0, 0.0);
            SetPVarInt(i, "train-horn", 0);
        }
    }
}

//BLINK

SetCarBlinking(veh, side, bool:skip=false) //0 - left 1 - right 2 - emergy
{
    if(IsCarBlinking(veh) && !skip) return DisableCarBlinking(veh);
    new model=GetVehicleModel(veh),obj[4];
    new id = model-400, trailer;

    if(!skip) BlinkSide[veh] = side;

    GetVehicleZAngle(veh, BlinkR[veh]);

    if(id > -1)
    {
        if(BlinkOffset[id][bX] != 0.0)
        {
            if(side == 0)
            {
                obj[0] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //blink yellow  front
                Blink[veh][0] = obj[0];
            }
            else
            {
                obj[2] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                Blink[veh][2] = obj[2];
            }
        }
        if((trailer = GetVehicleTrailer(veh)) != 0)
        {
            if(B_IsTrailer(trailer))
            {
                if(side == 0)
                {
                    obj[1] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //blink yellow back truck only trailer
                    Blink[veh][1] = obj[1];
                }
                else
                {
                    obj[3] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                    Blink[veh][3] = obj[3];
                }
            }
        }
        else
        {
            if(BlinkOffset[id][brX] != 0.0)
            {
                if(side == 0)
                {
                    obj[1] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //blink yellow back truck only trailer
                    Blink[veh][1] = obj[1];
                }
                else
                {
                    obj[3] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                    Blink[veh][3] = obj[3];
                }
            }
        }

        if(side == 0) //left
        {
            if(obj[0] != 0) AttachDynamicObjectToVehicle(obj[0], veh, BlinkOffset[id][bX],BlinkOffset[id][bY],BlinkOffset[id][bZ], 0.0, 0.0, 0.0);
            if(trailer != 0)
            {
                id = GetVehicleModel(trailer)-400;
                AttachDynamicObjectToVehicle(obj[1], trailer, BlinkOffset[id][brX],BlinkOffset[id][brY],BlinkOffset[id][brZ], 0.0, 0.0, 0.0);
            }
            else
            {
                if(obj[1] != 0) AttachDynamicObjectToVehicle(obj[1], veh, BlinkOffset[id][brX],BlinkOffset[id][brY],BlinkOffset[id][brZ], 0.0, 0.0, 0.0);
            }
        }
        else if(side == 1) //right
        {
            if(obj[2] != 0) AttachDynamicObjectToVehicle(obj[2], veh, -BlinkOffset[id][bX],BlinkOffset[id][bY],BlinkOffset[id][bZ], 0.0, 0.0, 0.0);
            if(trailer != 0)
            {
                id = GetVehicleModel(trailer)-400;
                AttachDynamicObjectToVehicle(obj[3], trailer, -BlinkOffset[id][brX],BlinkOffset[id][brY],BlinkOffset[id][brZ], 0.0, 0.0, 0.0);
            }
            else
            {
                if(obj[3] != 0) AttachDynamicObjectToVehicle(obj[3], veh, -BlinkOffset[id][brX],BlinkOffset[id][brY],BlinkOffset[id][brZ], 0.0, 0.0, 0.0);
            }
        }
        else if(side == 2)  //emergency
        {
            SetCarBlinking(veh, 0, true);
            SetCarBlinking(veh, 1, true);
        }
    }
	return 1;
}

public B_DisableBlinks(vehicleid)
{
    for(new i=0;i<4;i++)
    {
    	if(Blink[vehicleid][i] != -1) DestroyDynamicObject(Blink[vehicleid][i]);
    	Blink[vehicleid][i] = -1;
    }
    return 1;
}

DisableCarBlinking(veh)
{
	if(!IsCarBlinking(veh)) return 1;
    B_DisableBlinks(veh);
	return 1;
}

IsCarBlinking(vehicleid)
{
    if((BlinkSide[vehicleid] == 0 && Blink[vehicleid][0] == -1 && Blink[vehicleid][1] == -1) || (BlinkSide[vehicleid] == 1 && Blink[vehicleid][2] == -1 && Blink[vehicleid][3] == -1)) return 0;
    else if(Blink[vehicleid][0] == -1 && Blink[vehicleid][1] == -1 && Blink[vehicleid][2] == -1 && Blink[vehicleid][3] == -1) return 0;
    return 1;
}

B_IsTrailer(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 435, 450, 584, 591, 606: return 1;
    }
    return 0;
}

public B_OnTrailerDetached(trailerid, fromvehicleid)
{
    if(IsCarBlinking(fromvehicleid))
    {
        DisableCarBlinking(fromvehicleid);
        SetCarBlinking(fromvehicleid, BlinkSide[fromvehicleid]);
    }
    TrailerVehicle[trailerid] = 0;
}

public B_OnTrailerAttached(trailerid, tovehicleid)
{
    if(IsCarBlinking(tovehicleid))
    {
        DisableCarBlinking(tovehicleid);
        SetCarBlinking(tovehicleid, BlinkSide[tovehicleid]);
    }
    TrailerVehicle[trailerid] = tovehicleid;
}

public B_TrailerCheck()
{
    new trailer;
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        if((trailer = GetVehicleTrailer(i)) != 0)
        {
            if(BlinkTrailer[i] == 0)
            {
                BlinkTrailer[i]=trailer;
                B_OnTrailerAttached(trailer, i);
            }
        }
        else if(BlinkTrailer[i] != 0)
        {
            B_OnTrailerDetached(BlinkTrailer[i], i);
            BlinkTrailer[i] = 0;
        }
    }
}

//25.07     SYSTEM STREF GANG�W
public Zone_HideInfo(playerid)
{
    ZoneTXD_Hide(playerid);
    ZonePlayerTimer[playerid]=0;
}

ZoneTXD_Unload()
{
    for(new i=0;i<4;i++) TextDrawDestroy(Text:i);
}


Zone_StartAttack(zoneid, attacker, defender)
{
    ZoneAttack[zoneid] = true; //make

    if(attacker > 100) //gangi
    {
        if(defender > 100) //gang-gang
        {
            foreach(new i : Player)
            {
				new frac;
				for(new x = 0; x < MAX_PLAYER_GROUPS; x++)
				{
					if(PlayerInfo[i][pGrupa][x] != 0)
					{
						if(GroupHavePerm(PlayerInfo[i][pGrupa][x], PERM_GANG))
						{
							frac = PlayerInfo[i][pGrupa][x];
							break;
						}
					}
				}
                if(frac == attacker-100)
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttacker[i] = true;
                    SetPlayerCriminal(i, INVALID_PLAYER_ID, "Wojna gang�w", false);
                }
                else if(frac == defender-100)
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_pod_atakiem!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(i, zoneid, 0xFF000066);  //yey flash
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneDefender[i] = true;
                }
            }
        }
    }

    new str[128];
    format(str, 128, "DELETE FROM `mru_strefylimit` WHERE `gang`='%d'", attacker);
    mysql_query(str);
    format(str, 128, "INSERT INTO `mru_strefylimit` (`gang`, `data`) VALUES ('%d', '%d')", attacker, gettime());
    mysql_query(str);
    format(str, 128, "UPDATE `mru_strefy` SET `expire`='%d' WHERE `id`='%d'", gettime()+86400, zoneid);
    mysql_query(str);

    ZoneProtect[zoneid] = 1;
    ZoneAttackData[zoneid][2] = attacker;
    ZoneAttackData[zoneid][3] = defender;
    ZoneGangLimit[attacker] = false;
    format(str, 128, "ZONEDEFTIME_%d", zoneid);
    SetSVarInt(str, ZONE_DEF_TIME);
    ZoneAttackTimer[zoneid] = SetTimerEx("Zone_AttackEnd", ZONE_DEF_TIME*1000, 0, "iii", zoneid, attacker, defender);
    printf("[GangZone] Atak na stref� %d przez %d. Atakuje %d os�b broni %d os�b.", zoneid, attacker, ZoneAttackData[zoneid][0], ZoneAttackData[zoneid][1]);
}

Zone_GangUpdate(bool:cash=false)
{
    new string[256];
    new gangid, timegang;
    mysql_query("SELECT * FROM `mru_strefylimit`");
    mysql_store_result();
    while(mysql_fetch_row_format(string, "|"))
    {
        sscanf(string, "p<|>dd", gangid, timegang);
        if(!(0 <= gangid <= MAX_FRAC)) continue;
        if(gettime()-timegang >= 86400) ZoneGangLimit[gangid] = true; //1 day
        else ZoneGangLimit[gangid] = false;
    }
    mysql_free_result();
    if(cash)
    {
        for(new i=0;i<MAX_ZONES;i++)
        {
            if(ZoneControl[i] > 0 && ZoneControl[i] < 100)
            {
            }
            else if(ZoneControl[i]>100)
            {
            }
        }
    }
}

public Zone_AttackEnd(zoneid, attacker, defender)
{
    ZoneAttack[zoneid] = false;
    new str[128];
    if(ZoneAttackData[zoneid][1] < ZoneAttackData[zoneid][0]) //win
    {
        format(str, 128, "UPDATE `mru_strefy` SET `gang`='%d' WHERE `id`='%d'", attacker, zoneid);
        mysql_query(str);

        ZoneControl[zoneid] = attacker;
        new thisorg = orgID(ZoneControl[zoneid]-100);
        foreach(new i : Player)
        {
            if(ZoneControl[zoneid] == FRAC_GROOVE)
            {
                GangZoneHideForPlayer(i, zoneid);
                GangZoneShowForPlayer(i, zoneid, ZONE_COLOR_GROOVE | 0x44);
            }
            else if(ZoneControl[zoneid] == FRAC_BALLAS)
            {
                GangZoneHideForPlayer(i, zoneid);
                GangZoneShowForPlayer(i, zoneid, ZONE_COLOR_BALLAZ | 0x44);
            }
            else if(ZoneControl[zoneid] == FRAC_VAGOS)
            {
                GangZoneHideForPlayer(i, zoneid);
                GangZoneShowForPlayer(i, zoneid, ZONE_COLOR_VAGOS | 0x44);
            }
            else if(ZoneControl[zoneid] == FRAC_WPS)
            {
                GangZoneHideForPlayer(i, zoneid);
                GangZoneShowForPlayer(i, zoneid, ZONE_COLOR_WPS | 0x44);
            }
            else
            {
                GangZoneHideForPlayer(i, zoneid);
                GangZoneShowForPlayer(i, zoneid, OrgInfo[thisorg][o_Color] | 0x44);
            }
        }
        
        if(attacker > 100) //gangi
        {
            if(defender > 100) //gang-gang
            {
                foreach(new i : Player)
                {
					new frac;
					for(new x = 0; x < MAX_PLAYER_GROUPS; x++)
					{
						if(PlayerInfo[i][pGrupa][x] != 0)
						{
							if(GroupHavePerm(PlayerInfo[i][pGrupa][x], PERM_GANG))
							{
								frac = PlayerInfo[i][pGrupa][x];
								break;
							}
						}
					}
                    if(frac == attacker-100)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_przejeta!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(frac == defender-100)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_utracona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
        }
        else  //frac
        {
            if(defender > 100) //frac - gang
            {
                foreach(new i : Player)
                {
                    if(GetPlayerFraction(i) == attacker)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_przejeta!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(GetPlayerOrg(i) == defender-100)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_utracona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
            else
            {
                foreach(new i : Player) //frac - frac
                {
                    if(GetPlayerFraction(i) == attacker)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_przejeta!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(defender != 0 && GetPlayerFraction(i) == defender)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Strefa_utracona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
        }
    }
    else
    {

        if(attacker > 100) //gangi
        {
            if(defender > 100) //gang-gang
            {
                foreach(new i : Player)
                {
                    if(GetPlayerOrg(i) == attacker-100)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Przejecie_nieudane!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(GetPlayerOrg(i) == defender-100)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_obroniona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
            else
            {
                foreach(new i : Player) //gang-frac
                {
                    if(GetPlayerOrg(i) == attacker-100)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Przejecie_nieudane!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(defender != 0 && GetPlayerFraction(i) == defender)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_obroniona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
        }
        else  //frac
        {
            if(defender > 100) //frac - gang
            {
                foreach(new i : Player)
                {
                    if(GetPlayerFraction(i) == attacker)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Przejecie_nieudane!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(GetPlayerOrg(i) == defender-100)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_obroniona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
            else
            {
                foreach(new i : Player) //frac - frac
                {
                    if(GetPlayerFraction(i) == attacker)
                    {
                        MSGBOX_Show(i, "~r~[Strefy]_~>~_Przejecie_nieudane!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                    else if(defender != 0 && GetPlayerFraction(i) == defender)
                    {
                        MSGBOX_Show(i, "~g~[Strefy]_~>~_Strefa_obroniona!", MSGBOX_ICON_TYPE_POLICE, 5);
                    }
                }
            }
        }
    }
    format(str, 128, "ZONEDEFTIME_%d", zoneid);
    DeleteSVar(str);
    printf("FINAL Attackers: %d Defenders: %d", ZoneAttackData[zoneid][0], ZoneAttackData[zoneid][1]);
    GangZoneStopFlashForAll(zoneid);
    ZoneAttackData[zoneid][0] = 0;
    ZoneAttackData[zoneid][1] = 0;
}

Zone_Sync(playerid)
{
    new frac = GetPlayerFraction(playerid);
    if(frac == 0) frac = GetPlayerOrg(playerid);
    for(new i=0;i<MAX_ZONES;i++)
    {
        if(ZoneAttack[i])
        {
            if(ZoneAttackData[i][2] > 100)
            {
                if(frac == ZoneAttackData[i][2]-100)
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atakujesz_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(playerid, i, 0xFF000066);  //yey flash
                }
                else if(frac == ZoneAttackData[i][3]-100)
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(playerid, i, 0xFF000066);  //yey flash
                }
            }
            else
            {
                if(frac == ZoneAttackData[i][2])
                {
                    MSGBOX_Show(i, "~g~[Strefy]_~>~_Atakujesz_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(playerid, i, 0xFF000066);  //yey flash
                }
                else if(frac == ZoneAttackData[i][3])
                {
                    MSGBOX_Show(i, "~r~[Strefy]_~>~_Atak_na_strefe!", MSGBOX_ICON_TYPE_POLICE, 5);
                    GangZoneFlashForPlayer(playerid, i, 0xFF000066);  //yey flash
                }
            }
        }
    }
}

Zone_Load()
{
    new query[128];
    mysql_query("SELECT * FROM `mru_strefy`");
    mysql_store_result();
    new id, kontrol, expire, time=gettime();
    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>ddd", id, kontrol, expire);
        ZoneControl[id] = kontrol;
        if(expire == -1) ZoneProtect[id] = 1;
        else if(time - expire < 86400) ZoneProtect[id] = 1;
        else ZoneProtect[id] = 0;
    }
    mysql_free_result();

    if(ZoneControl[id] > 100)
    {
        if(orgID(ZoneControl[id]-100) == 0xFFFF)
        {
            ZoneControl[id] = 0;
            ZoneProtect[id] = 0;
        }
    }

    Zone_GangUpdate();

    for(new i=0;i<MAX_ZONES;i++)
    {
        id = GangZoneCreate(Zone_Data[i][0],Zone_Data[i][1],Zone_Data[i][2],Zone_Data[i][3]);
        if(i == 0) Zone_Points[0] = id;

        Zone_Area[i] = ((Zone_Data[i][2]-Zone_Data[i][0])*(Zone_Data[i][3]-Zone_Data[i][1]));
    }
    Zone_Points[1] = id;
}

Zone_CheckPossToAttack(playerid, zoneid)
{
    if(ZoneProtect[zoneid] == 1)
    {
        MSGBOX_Show(playerid, "Strefa_chroniona", MSGBOX_ICON_TYPE_WARNING);
        return false;
    }
    new fam = GetPlayerOrg(playerid);
    if(fam != 0)
    {
        if(OrgInfo[gPlayerOrg[playerid]][o_Color] & 0xFF000069 == 0xFF000069)
        {
            MSGBOX_Show(playerid, "Zmien_kolor_swojej_rodziny_(/pr_kolor)", MSGBOX_ICON_TYPE_WARNING);
            return false;
        }
    }
    new vic, att;
    if(ZoneControl[zoneid] == 0) //neutralne
    {
        new org = GetPlayerFraction(playerid);
        foreach(new i : Player)
        {
            if(GetPVarInt(i, "zoneid") == zoneid)
            {
                if(org != 0)
                {
                    if(org == GetPlayerFraction(i))
                    {
                        att++;
                    }
                }
                else
                {
                    if(fam == GetPlayerOrg(i))
                    {
                        att++;
                    }
                }
            }
        }
        if(att < Zone_MinimumPeople(zoneid))
        {
            MSGBOX_Show(playerid, "Brak_wymaganej_liczby_atakujacych!", MSGBOX_ICON_TYPE_WARNING);
            return false;
        }
    }
    else
    {
        new
            zonec = ZoneControl[zoneid],
            org = GetPlayerFraction(playerid);
        if(zonec == org || zonec-100 == fam) return false;
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        foreach(new i : Player)
        {
            if(zonec > 100)
            {
                if(GetPlayerOrg(i) == zonec-100)
                {
                    vic++;
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttackData[zoneid][1]++;
                }
            }
            else
            {
                if(GetPlayerFraction(i) == zonec)
                {
                    vic++;
                    if(GetPVarInt(i, "zoneid") == zoneid) ZoneAttackData[zoneid][1]++;
                }
            }
            if(IsPlayerInRangeOfPoint(i, 20.0, x, y, z))
            {
                if(org != 0)
                {
                    if(org == GetPlayerFraction(i))
                    {
                        att++;
                    }
                }
                else
                {
                    if(fam == GetPlayerOrg(i))
                    {
                        att++;
                    }
                }
            }
        }
        if(att < Zone_MinimumPeople(zoneid))
        {
            MSGBOX_Show(playerid, "Brak_wymaganej_liczby_atakujacych!", MSGBOX_ICON_TYPE_WARNING);
            return false;
        }
        if(vic < att)
        {
            MSGBOX_Show(playerid, "Brak_aktywnych_obroncow!", MSGBOX_ICON_TYPE_WARNING);
            return false;
        }
    }
    ZoneAttackData[zoneid][0] = att;
    return true;
}

ZoneTXD_Show(playerid, zoneid)
{
    new bool:gang=false;
    new frac=GetPlayerFraction(playerid);
    if(ZoneControl[zoneid] != 0 && (ZoneControl[zoneid] == frac || ZoneControl[zoneid]-100==GetPlayerOrg(playerid))) gang = false;

    for(new i=0;i<3;i++)
    {
        TextDrawShowForPlayer(playerid, ZoneTXD[i]);
    }
    if(gang && ZoneProtect[zoneid] == 0) TextDrawShowForPlayer(playerid, ZoneTXD[3]);

    new str[128];
    if(ZoneControl[zoneid] != 0)
    {
    }
    else format(str, 128, "Kontrolowana~n~przez: %s", "Brak");
    PlayerTextDrawSetString(playerid, ZonePTXD_Name[playerid], str);
    PlayerTextDrawShow(playerid, ZonePTXD_Name[playerid]);

    format(str, 128, "Zysk:~n~____%d$", Zone_GetCash(zoneid));
    PlayerTextDrawSetString(playerid, ZonePTXD_Cash[playerid], str);
    PlayerTextDrawShow(playerid, ZonePTXD_Cash[playerid]);

    format(str, 128, "Powierzchnia:~n~____%.2f km", Zone_Area[zoneid]/10000);
    PlayerTextDrawSetString(playerid, ZonePTXD_Area[playerid], str);
    PlayerTextDrawShow(playerid, ZonePTXD_Area[playerid]);

    format(str, 128, "Wymagana liczba~n~atakujacych:____%d", Zone_MinimumPeople(zoneid));
    PlayerTextDrawSetString(playerid, ZonePTXD_Member[playerid], str);
    PlayerTextDrawShow(playerid, ZonePTXD_Member[playerid]);

    SetPVarInt(playerid, "zoneid", zoneid);
}

ZoneTXD_Hide(playerid)
{
    for(new i=0;i<4;i++)
    {
        TextDrawHideForPlayer(playerid, ZoneTXD[i]);
    }
    PlayerTextDrawHide(playerid, ZonePTXD_Name[playerid]);
    PlayerTextDrawHide(playerid, ZonePTXD_Cash[playerid]);
    PlayerTextDrawHide(playerid, ZonePTXD_Area[playerid]);
    PlayerTextDrawHide(playerid, ZonePTXD_Member[playerid]);
}

Zone_MinimumPeople(zoneid)
{
    new Float:area = Zone_Area[zoneid]/10000;
    new ppl;
    if(0 < area < 1.0) ppl = 3;
    else if(1.0 <= area < 2.0) ppl = 5;
    else if(2.0 <= area < 4.0) ppl = 7;
    else if(4.0 <= area < 8.0) ppl = 10;
    else if(8.0 <= area < 12.0) ppl = 15;
    else if(12.0 <= area < 15.0) ppl = 25;
    else if(15.0 <= area < 20.0) ppl = 35;
    else ppl = 40;
    #if defined ZONE_REMOVE_LIMIT
    ppl = 1;
    #endif
    return ppl;
}

Zone_GetCash(zoneid)
{
    new Float:area = Zone_Area[zoneid]/10000;
    // za 1km^2 - 1.000 co PayDay?
    if(zoneid == 0 || zoneid == 19 || zoneid == 47 || zoneid == 59) area = 2.5;
    return floatround(area*750);
}

Car_Lock(playerid, veh)
{
	if(IsABike(veh)) return sendErrorMessage(playerid, "Nie mo�esz u�y� /lock na motocyklu");
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "INT_HOUSE", "wash_up",4.1, 0, 0, 0, 0, 0, 1);
    if(doors == 0)
    {
        doors=1;
        GameTextForPlayer(playerid, "Zamek w drzwiach ~r~zamkniety!", 2000, 5);
    }
    else
    {
        doors=0;
        GameTextForPlayer(playerid, "Zamek w drzwiach ~g~otwarty!", 2000, 5);
    }
    SetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);

    return 1;
}


//13.08
//--------------------------------------------------

GetMoveDirectionFromKeys(ud, lr)
{
	new direction = 0;

    if(lr < 0)
	{
		if(ud < 0) 		direction = MOVE_FORWARD_LEFT; 	// Up & Left key pressed
		else if(ud > 0) direction = MOVE_BACK_LEFT; 	// Back & Left key pressed
		else            direction = MOVE_LEFT;          // Left key pressed
	}
	else if(lr > 0) 	// Right pressed
	{
		if(ud < 0)      direction = MOVE_FORWARD_RIGHT;  // Up & Right key pressed
		else if(ud > 0) direction = MOVE_BACK_RIGHT;     // Back & Right key pressed
		else			direction = MOVE_RIGHT;          // Right key pressed
	}
	else if(ud < 0) 	direction = MOVE_FORWARD; 	// Up key pressed
	else if(ud > 0) 	direction = MOVE_BACK;		// Down key pressed

	return direction;
}

//--------------------------------------------------

MoveCamera(playerid)
{
	new Float:FV[3], Float:ncCP[3];
	GetPlayerCameraPos(playerid, ncCP[0], ncCP[1], ncCP[2]);          // 	Cameras position in space
    GetPlayerCameraFrontVector(playerid, FV[0], FV[1], FV[2]);  //  Where the camera is looking at

	// Increases the acceleration multiplier the longer the key is held
	if(noclipdata[playerid][accelmul] <= 1) noclipdata[playerid][accelmul] += ACCEL_RATE;

	// Determine the speed to move the camera based on the acceleration multiplier
	new Float:speed = MOVE_SPEED * noclipdata[playerid][accelmul];

	// Calculate the cameras next position based on their current position and the direction their camera is facing
	new Float:X, Float:Y, Float:Z;
	GetNextCameraPosition(noclipdata[playerid][mode], ncCP, FV, X, Y, Z);
	MovePlayerObject(playerid, noclipdata[playerid][flyobject], X, Y, Z, speed);

    if(noclipdata[playerid][fireobject] != 0) MoveDynamicObject(noclipdata[playerid][fireobject], X, Y, Z, speed);

	// Store the last time the camera was moved as now
	noclipdata[playerid][lastmove] = GetTickCount();
	return 1;
}

//--------------------------------------------------

GetNextCameraPosition(move_mode, Float:ncCP[3], Float:FV[3], &Float:X, &Float:Y, &Float:Z)
{
    // Calculate the cameras next position based on their current position and the direction their camera is facing
    #define OFFSET_X (FV[0]*6000.0)
	#define OFFSET_Y (FV[1]*6000.0)
	#define OFFSET_Z (FV[2]*6000.0)
	switch(move_mode)
	{
		case MOVE_FORWARD:
		{
			X = ncCP[0]+OFFSET_X;
			Y = ncCP[1]+OFFSET_Y;
			Z = ncCP[2]+OFFSET_Z;
		}
		case MOVE_BACK:
		{
			X = ncCP[0]-OFFSET_X;
			Y = ncCP[1]-OFFSET_Y;
			Z = ncCP[2]-OFFSET_Z;
		}
		case MOVE_LEFT:
		{
			X = ncCP[0]-OFFSET_Y;
			Y = ncCP[1]+OFFSET_X;
			Z = ncCP[2];
		}
		case MOVE_RIGHT:
		{
			X = ncCP[0]+OFFSET_Y;
			Y = ncCP[1]-OFFSET_X;
			Z = ncCP[2];
		}
		case MOVE_BACK_LEFT:
		{
			X = ncCP[0]+(-OFFSET_X - OFFSET_Y);
 			Y = ncCP[1]+(-OFFSET_Y + OFFSET_X);
		 	Z = ncCP[2]-OFFSET_Z;
		}
		case MOVE_BACK_RIGHT:
		{
			X = ncCP[0]+(-OFFSET_X + OFFSET_Y);
 			Y = ncCP[1]+(-OFFSET_Y - OFFSET_X);
		 	Z = ncCP[2]-OFFSET_Z;
		}
		case MOVE_FORWARD_LEFT:
		{
			X = ncCP[0]+(OFFSET_X  - OFFSET_Y);
			Y = ncCP[1]+(OFFSET_Y  + OFFSET_X);
			Z = ncCP[2]+OFFSET_Z;
		}
		case MOVE_FORWARD_RIGHT:
		{
			X = ncCP[0]+(OFFSET_X  + OFFSET_Y);
			Y = ncCP[1]+(OFFSET_Y  - OFFSET_X);
			Z = ncCP[2]+OFFSET_Z;
		}
	}
}
//--------------------------------------------------

CancelFlyMode(playerid)
{
    GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
	DeletePVar(playerid, "FlyMode");
	CancelEdit(playerid);
	GameTextForPlayer(playerid, "L O A D I N G", 1000, 3);
    SetTimerEx("SpecEnd", 500, false, "d", playerid);
	DestroyPlayerObject(playerid, noclipdata[playerid][flyobject]);
	noclipdata[playerid][cameramode] = CAMERA_MODE_NONE;
    if(noclipdata[playerid][fireobject] != 0)
    {
        DestroyDynamicObject(noclipdata[playerid][fireobject]);
        noclipdata[playerid][fireobject] = 0;
    }
	return 1;
}

//--------------------------------------------------

FlyMode(playerid, typ)
{
	// Create an invisible object for the players camera to be attached to
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	noclipdata[playerid][flyobject] = CreatePlayerObject(playerid, 19300, X, Y, Z, 0.0, 0.0, 0.0);

    if(noclipdata[playerid][flyobject] == INVALID_OBJECT_ID) return SendClientMessage(playerid, -1, " B��d limitu obiekt�w.");

    GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
    Unspec[playerid][sPint] = GetPlayerInterior(playerid);
    Unspec[playerid][sPvw] = GetPlayerVirtualWorld(playerid);

	// Place the player in spectating mode so objects will be streamed based on camera location
	SetPVarInt(playerid, "FlyMode", 1);
	TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachCameraToPlayerObject(playerid, noclipdata[playerid][flyobject]);

    if(typ != 0)
    {
        noclipdata[playerid][fireobject] = CreateDynamicObject(typ, X-0.5, Y, Z, 90.0, 90.0, 0.0);
    }
	noclipdata[playerid][cameramode] = CAMERA_MODE_FLY;
	return 1;
}

Kolczatka_GetID()
{
    new id=-1;
    for(new i=0;i<MAX_KOLCZATEK;i++)
    {
        if(KolID[i] == -1)
        {
            id=i;
            break;
        }
    }
    return id;
}

Kolczatka_Delete(id)
{
    if(KolID[id] == -1) return 1;
    DestroyDynamicObject(KolID[id]);
    KolID[id] = -1;
    KolTime[id] = 0;
    KolDelay[KolVehicle[id]] = false;
    KolVehicle[id] = 0;
    DestroyDynamicArea(KolArea[id]);
    return 1;
}

public OnPlayerEnterSpikes(playerid)
{
    new panels, doors, lights, tires, veh = GetPlayerVehicleID(playerid);
    if(IsACopCar(veh)) return 1;
    GetVehicleDamageStatus(veh, panels, doors, lights, tires);
    UpdateVehicleDamageStatus(veh, panels, doors, lights, 0b1111);
    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~Ooops... poslizg!", 1500, 3);
    return 1;
}

GetVehicleRotation(vehicleid,&Float:heading, &Float:attitude, &Float:bank)
{
    new Float:quat_w,Float:quat_x,Float:quat_y,Float:quat_z;
    GetVehicleRotationQuat(vehicleid,quat_w,quat_x,quat_y,quat_z);
    ConvertNonNormaQuatToEuler(quat_w,quat_x,quat_z,quat_y, heading, attitude, bank);
    bank = -1*bank;
    return 1;
}

ConvertNonNormaQuatToEuler(Float: qw, Float: qx, Float:qy, Float:qz,
                                &Float:heading, &Float:attitude, &Float:bank)
{
    new Float: sqw = qw*qw;
    new Float: sqx = qx*qx;
    new Float: sqy = qy*qy;
    new Float: sqz = qz*qz;
    new Float: unit = sqx + sqy + sqz + sqw;

    new Float: test = qx*qy + qz*qw;
    if (test > 0.499*unit)
    {
        heading = 2*atan2(qx,qw);
        attitude = 3.141592653/2;
        bank = 0;
        return 1;
    }
    if (test < -0.499*unit)
    {
        heading = -2*atan2(qx,qw);
        attitude = -3.141592653/2;
        bank = 0;
        return 1;
    }
    heading = atan2(2*qy*qw - 2*qx*qz, sqx - sqy - sqz + sqw);
    attitude = asin(2*test/unit);
    bank = atan2(2*qx*qw - 2*qy*qz, -sqx + sqy - sqz + sqw);
    return 1;
}

Patrol_Init()
{
    //BLUE
    PatrolZones[0] = GangZoneCreate(78.125,-1777.34375,625.0,-816.40625);//1
    PatrolZones[1] = GangZoneCreate(625.0,-1392.25,1320.3125,-593.75);
    //GREEN
    PatrolZones[2] = GangZoneCreate(625.0,-1949.21875,1851.5625,-1392.25);//1
    PatrolZones[3] = GangZoneCreate(1320.3125,-1392.25,1851.5625,-859.375);
    //RED
    PatrolZones[4] = GangZoneCreate(1851.5625,-1949.21875,2718.75,-960.9375);//1
    PatrolZones[5] = GangZoneCreate(2718.75,-2046.875,2859.375,-1011.71875);
    //YELLOW
    PatrolZones[6] = GangZoneCreate(984.375,-2765.625,2226.5625,-1949.21875);//1
    PatrolZones[7] = GangZoneCreate(2226.5625,-2234.375,2824.21875,-1949.21875);

    PatrolMap = TextDrawCreate(130.000000, 65.000000, "samaps:gtasamapbit4"); //127.000000, 55.125000
    TextDrawLetterSize(PatrolMap, 0.000000, 0.000000);
    TextDrawTextSize(PatrolMap, 380.000000, 315.000000); //250x250
    TextDrawAlignment(PatrolMap, 1);
    TextDrawColor(PatrolMap, -1);
    TextDrawSetShadow(PatrolMap, 0);
    TextDrawSetOutline(PatrolMap, 0);
    TextDrawFont(PatrolMap, 4);

    PatrolAlfa[0] = TextDrawCreate(140.000000, 151.062500, "~n~");
    TextDrawLetterSize(PatrolAlfa[0], 17.974994, 10.713175);  //Box height multi = letter Y * 10.5478         X * 11.4603
    TextDrawTextSize(PatrolAlfa[0], 206.000000, 113.000000);  //Box width is normal - heigh is equal letter Y * 10.5478
    TextDrawAlignment(PatrolAlfa[0], 1);
    TextDrawUseBox(PatrolAlfa[0], true);
    TextDrawBoxColor(PatrolAlfa[0], 52309);
    TextDrawBackgroundColor(PatrolAlfa[0], 51);
    TextDrawFont(PatrolAlfa[0], 1);
    TextDrawSetProportional(PatrolAlfa[0], 1);
    TextDrawSetSelectable(PatrolAlfa[0], true);

    PatrolAlfa[1] = TextDrawCreate(210.000000, 127.125000, "~n~");
    TextDrawLetterSize(PatrolAlfa[1], 17.981990, 9.015682);
    TextDrawTextSize(PatrolAlfa[1], 297.000000,  95.110000);
    TextDrawAlignment(PatrolAlfa[1], 1);
    TextDrawUseBox(PatrolAlfa[1], true);
    TextDrawBoxColor(PatrolAlfa[1], 52309);
    TextDrawBackgroundColor(PatrolAlfa[1], 51);
    TextDrawFont(PatrolAlfa[1], 1);
    TextDrawSetProportional(PatrolAlfa[1], 1);
    TextDrawSetSelectable(PatrolAlfa[1], true);

    PatrolBeta[0] = TextDrawCreate(301.000000, 156.562500, "~n~");
    TextDrawLetterSize(PatrolBeta[0], 17.987489, 5.738808);
    TextDrawTextSize(PatrolBeta[0], 363.000000,  60.544000);
    TextDrawAlignment(PatrolBeta[0], 1);
    TextDrawUseBox(PatrolBeta[0], true);
    TextDrawBoxColor(PatrolBeta[0], 13369429);
    TextDrawBackgroundColor(PatrolBeta[0], 51);
    TextDrawFont(PatrolBeta[0], 1);
    TextDrawSetProportional(PatrolBeta[0], 1);
    TextDrawSetSelectable(PatrolBeta[0], true);

    PatrolBeta[1] = TextDrawCreate(209.500000, 211.812500, "~n~");
    TextDrawLetterSize(PatrolBeta[1], 17.972496, 6.307557);
    TextDrawTextSize(PatrolBeta[1], 362.500000,  66.544000);
    TextDrawAlignment(PatrolBeta[1], 1);
    TextDrawUseBox(PatrolBeta[1], true);
    TextDrawBoxColor(PatrolBeta[1], 13369429);
    TextDrawBackgroundColor(PatrolBeta[1], 51);
    TextDrawFont(PatrolBeta[1], 1);
    TextDrawSetProportional(PatrolBeta[1], 1);
    TextDrawSetSelectable(PatrolBeta[1], true);

    PatrolGamma[0] = TextDrawCreate(366.000000, 163.375000, "~n~");
    TextDrawLetterSize(PatrolGamma[0], 18.033477, 11.693190);
    TextDrawTextSize(PatrolGamma[0], 470.000000, 123.614810);
    TextDrawAlignment(PatrolGamma[0], 1);
    TextDrawUseBox(PatrolGamma[0], true);
    TextDrawBoxColor(PatrolGamma[0], -872415147);
    TextDrawBackgroundColor(PatrolGamma[0], 51);
    TextDrawFont(PatrolGamma[0], 1);
    TextDrawSetProportional(PatrolGamma[0], 1);
    TextDrawSetSelectable(PatrolGamma[0], true);

    PatrolGamma[1] = TextDrawCreate(474.000000, 170.500000, "~n~");
    TextDrawLetterSize(PatrolGamma[1], 18.018476, 11.706321);
    TextDrawTextSize(PatrolGamma[1], 493.000000, 123.614810);
    TextDrawAlignment(PatrolGamma[1], 1);
    TextDrawUseBox(PatrolGamma[1], true);
    TextDrawBoxColor(PatrolGamma[1], -872415147);
    TextDrawBackgroundColor(PatrolGamma[1], 51);
    TextDrawFont(PatrolGamma[1], 1);
    TextDrawSetProportional(PatrolGamma[1], 1);
    TextDrawSetSelectable(PatrolGamma[1], true);

    PatrolDelta[0] = TextDrawCreate(257.000000, 271.250000, "~n~");
    TextDrawLetterSize(PatrolDelta[0], 17.960977, 9.068202);
    TextDrawTextSize(PatrolDelta[0], 411.500000, 95.110000);
    TextDrawAlignment(PatrolDelta[0], 1);
    TextDrawUseBox(PatrolDelta[0], true);
    TextDrawBoxColor(PatrolDelta[0], -859045803);
    TextDrawBackgroundColor(PatrolDelta[0], 51);
    TextDrawFont(PatrolDelta[0], 1);
    TextDrawSetProportional(PatrolDelta[0], 1);
    TextDrawSetSelectable(PatrolDelta[0], true);

    PatrolDelta[1] = TextDrawCreate(414.500000, 271.250000, "~n~");
    TextDrawLetterSize(PatrolDelta[1], 17.914997, 3.000041);
    TextDrawTextSize(PatrolDelta[1], 487.000000, 31.650000);
    TextDrawAlignment(PatrolDelta[1], 1);
    TextDrawUseBox(PatrolDelta[1], true);
    TextDrawBoxColor(PatrolDelta[1], -859045803);
    TextDrawBackgroundColor(PatrolDelta[1], 51);
    TextDrawFont(PatrolDelta[1], 1);
    TextDrawSetProportional(PatrolDelta[1], 1);
    TextDrawSetSelectable(PatrolDelta[1], true);

    PatrolAlfaSq = TextDrawCreate(151.000000, 157.062500, "Alfa");
    TextDrawLetterSize(PatrolAlfaSq, 0.260000, 1.066876);
    TextDrawAlignment(PatrolAlfaSq, 1);
    TextDrawColor(PatrolAlfaSq, -1);
    TextDrawSetShadow(PatrolAlfaSq, 0);
    TextDrawSetOutline(PatrolAlfaSq, 1);
    TextDrawBackgroundColor(PatrolAlfaSq, 51);
    TextDrawFont(PatrolAlfaSq, 2);
    TextDrawSetProportional(PatrolAlfaSq, 1);

    PatrolBetaSq = TextDrawCreate(217.500000, 218.437500, "Beta");
    TextDrawLetterSize(PatrolBetaSq, 0.260000, 1.066876);
    TextDrawAlignment(PatrolBetaSq, 1);
    TextDrawColor(PatrolBetaSq, -1);
    TextDrawSetShadow(PatrolBetaSq, 0);
    TextDrawSetOutline(PatrolBetaSq, 1);
    TextDrawBackgroundColor(PatrolBetaSq, 51);
    TextDrawFont(PatrolBetaSq, 2);
    TextDrawSetProportional(PatrolBetaSq, 1);

    PatrolGammaSq = TextDrawCreate(371.500000, 167.812500, "Gamma");
    TextDrawLetterSize(PatrolGammaSq, 0.260000, 1.066876);
    TextDrawAlignment(PatrolGammaSq, 1);
    TextDrawColor(PatrolGammaSq, -1);
    TextDrawSetShadow(PatrolGammaSq, 0);
    TextDrawSetOutline(PatrolGammaSq, 1);
    TextDrawBackgroundColor(PatrolGammaSq, 51);
    TextDrawFont(PatrolGammaSq, 2);
    TextDrawSetProportional(PatrolGammaSq, 1);

    PatrolDeltaSq = TextDrawCreate(265.500000, 274.687500, "Delta");
    TextDrawLetterSize(PatrolDeltaSq, 0.260000, 1.066876);
    TextDrawAlignment(PatrolDeltaSq, 1);
    TextDrawColor(PatrolDeltaSq, -1);
    TextDrawSetShadow(PatrolDeltaSq, 0);
    TextDrawSetOutline(PatrolDeltaSq, 1);
    TextDrawBackgroundColor(PatrolDeltaSq, 51);
    TextDrawFont(PatrolDeltaSq, 2);
    TextDrawSetProportional(PatrolDeltaSq, 1);

    PatrolLabel = TextDrawCreate(320.500000, 57.312500, "Mapa patroli~n~~y~LSPD");
    TextDrawLetterSize(PatrolLabel, 0.449999, 1.600000);
    TextDrawAlignment(PatrolLabel, 2);
    TextDrawColor(PatrolLabel, -1);
    TextDrawSetShadow(PatrolLabel, 0);
    TextDrawSetOutline(PatrolLabel, 1);
    TextDrawBackgroundColor(PatrolLabel, 51);
    TextDrawFont(PatrolLabel, 1);
    TextDrawSetProportional(PatrolLabel, 1);

    for(new i=0;i<MAX_PATROLS;i++)
    {
        PatrolMarker[i] = TextDrawCreate(0.0, 0.0, "_");
        TextDrawLetterSize(PatrolMarker[i], 0.000000, 0.000000);
        TextDrawTextSize(PatrolMarker[i], 19.500000, 17.062500);
        TextDrawAlignment(PatrolMarker[i], 1);
        TextDrawColor(PatrolMarker[i], -1);
        TextDrawSetShadow(PatrolMarker[i], 0);
        TextDrawSetOutline(PatrolMarker[i], 0);
        TextDrawFont(PatrolMarker[i], 4);
    }
}

Patrol_Unload()
{
    TextDrawDestroy(PatrolMap);
    TextDrawDestroy(PatrolAlfa[0]);
    TextDrawDestroy(PatrolAlfa[1]);
    TextDrawDestroy(PatrolBeta[0]);
    TextDrawDestroy(PatrolBeta[1]);
    TextDrawDestroy(PatrolGamma[0]);
    TextDrawDestroy(PatrolGamma[1]);
    TextDrawDestroy(PatrolDelta[0]);
    TextDrawDestroy(PatrolDelta[1]);
    TextDrawDestroy(PatrolAlfaSq);
    TextDrawDestroy(PatrolBetaSq);
    TextDrawDestroy(PatrolGammaSq);
    TextDrawDestroy(PatrolDeltaSq);
    TextDrawDestroy(PatrolLabel);

    for(new i = 0; i < MAX_PATROLS ; i++)
    {
        if(PatrolMarker[i] != Text:INVALID_TEXT_DRAW)
        {
            TextDrawDestroy(PatrolMarker[i]);
        }
    }
    for(new i = 0; i < 8 ; i++)
    {
        GangZoneDestroy(PatrolZones[i]);
    }
}

GetPatrolID()
{
    new id=-1;
    for(new i = 0; i < MAX_PATROLS ;i++)
    {
        if(PatrolInfo[i][pataktywny] == 0)
        {
            id = i;
            break;
        }
    }
    return id;
}

Patrol_ShowMap(playerid)
{
    TextDrawShowForPlayer(playerid, PatrolMap);
    TextDrawShowForPlayer(playerid, PatrolAlfa[0]);
    TextDrawShowForPlayer(playerid, PatrolAlfa[1]);
    TextDrawShowForPlayer(playerid, PatrolBeta[0]);
    TextDrawShowForPlayer(playerid, PatrolBeta[1]);
    TextDrawShowForPlayer(playerid, PatrolGamma[0]);
    TextDrawShowForPlayer(playerid, PatrolGamma[1]);
    TextDrawShowForPlayer(playerid, PatrolDelta[0]);
    TextDrawShowForPlayer(playerid, PatrolDelta[1]);
    TextDrawShowForPlayer(playerid, PatrolAlfaSq);
    TextDrawShowForPlayer(playerid, PatrolBetaSq);
    TextDrawShowForPlayer(playerid, PatrolGammaSq);
    TextDrawShowForPlayer(playerid, PatrolDeltaSq);
    TextDrawShowForPlayer(playerid, PatrolLabel);
    SelectTextDraw(playerid, 0xD2691E55);
    SetPVarInt(playerid, "patrolmap", 1);
}

Patrol_HideMap(playerid)
{
    TextDrawHideForPlayer(playerid, PatrolMap);
    TextDrawHideForPlayer(playerid, PatrolAlfa[0]);
    TextDrawHideForPlayer(playerid, PatrolAlfa[1]);
    TextDrawHideForPlayer(playerid, PatrolBeta[0]);
    TextDrawHideForPlayer(playerid, PatrolBeta[1]);
    TextDrawHideForPlayer(playerid, PatrolGamma[0]);
    TextDrawHideForPlayer(playerid, PatrolGamma[1]);
    TextDrawHideForPlayer(playerid, PatrolDelta[0]);
    TextDrawHideForPlayer(playerid, PatrolDelta[1]);
    TextDrawHideForPlayer(playerid, PatrolAlfaSq);
    TextDrawHideForPlayer(playerid, PatrolBetaSq);
    TextDrawHideForPlayer(playerid, PatrolGammaSq);
    TextDrawHideForPlayer(playerid, PatrolDeltaSq);
    TextDrawHideForPlayer(playerid, PatrolLabel);

    for(new i = 0; i < MAX_PATROLS ; i ++)
    {
        TextDrawHideForPlayer(playerid, PatrolMarker[i]);
    }
    CancelSelectTextDraw(playerid);
    SetPVarInt(playerid, "patrolmap", 0);
}

Patrol_DisplayZones(playerid)
{
    GangZoneShowForPlayer(playerid, PatrolZones[0], 0x0000CC55);
    GangZoneShowForPlayer(playerid, PatrolZones[1], 0x0000CC55);

    GangZoneShowForPlayer(playerid, PatrolZones[2], 0x00CC0055);
    GangZoneShowForPlayer(playerid, PatrolZones[3], 0x00CC0055);

    GangZoneShowForPlayer(playerid, PatrolZones[4], 0xCC000055);
    GangZoneShowForPlayer(playerid, PatrolZones[5], 0xCC000055);

    GangZoneShowForPlayer(playerid, PatrolZones[6], 0xCCCC0055);
    GangZoneShowForPlayer(playerid, PatrolZones[7], 0xCCCC0055);
}

Patrol_HideZones(playerid)
{
    GangZoneHideForPlayer(playerid, PatrolZones[0]);
    GangZoneHideForPlayer(playerid, PatrolZones[1]);

    GangZoneHideForPlayer(playerid, PatrolZones[2]);
    GangZoneHideForPlayer(playerid, PatrolZones[3]);

    GangZoneHideForPlayer(playerid, PatrolZones[4]);
    GangZoneHideForPlayer(playerid, PatrolZones[5]);

    GangZoneHideForPlayer(playerid, PatrolZones[6]);
    GangZoneHideForPlayer(playerid, PatrolZones[7]);
}

GPSMode(playerid, bool:red = false)
{
	new string[144], sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));

	if(PDGPS == playerid)
	{
		foreach(new i : Player)
		{
			if(IsAPolicja(i) || IsAMedyk(i) || IsPlayerInGroup(i, FRAC_BOR) || IsPlayerInGroup(i, FRAC_ERS) || (IsPlayerInGroup(i, 9) && SanDuty[i] == 1) || (PlayerInfo[i][pLider] == 9 && SanDuty[i] == 1) || GetPVarInt(playerid, "RozpoczalBieg") == 0 || IsPlayerInGroup(i, 17))
			{
				if(zawodnik[i] == 0)
					DisablePlayerCheckpoint(i);
			}
		}
	}

	if(red)
	{
		format(string, sizeof(string), "=: %s %s GPS %s :=", sendername, (PDGPS == playerid) ? ("deaktywowa�") : ("aktywowa�"), (PDGPS == playerid) ? ("- odwo�uj� RED") : ("potrzebne wsparcie! - CODE RED"));
		PDGPS = (PDGPS == playerid) ? (-1) : (playerid);
	}
	else
	{
		format(string, sizeof(string), "=: %s %s GPS %s :=", sendername, (PDGPS == playerid) ? ("deaktywowa�") : ("aktywowa�"), (PDGPS == playerid) ? ("") : ("potrzebne wsparcie!"));
		PDGPS = (PDGPS == playerid) ? (-1) : (playerid);
	}

	SendRadioMessage(1, COLOR_YELLOW2, string);
	SendRadioMessage(2, COLOR_YELLOW2, string);
	SendRadioMessage(3, COLOR_YELLOW2, string);
	SendRadioMessage(4, COLOR_YELLOW2, string);
	SendRadioMessage(FRAC_BOR, COLOR_YELLOW2, string); 
	SendRadioMessage(17, COLOR_YELLOW2, string);
}

public PatrolGPS()
{
    new Float:x, Float:y, Float:z;
    for(new i = 0; i < MAX_PATROLS; i ++)
    {
        if(PatrolInfo[i][pataktywny] == 1)
        {
            GetPlayerPos(PatrolInfo[i][patroluje][0], x, y, z);

            Patrol_CreateMarker(i, x, y, PatrolInfo[i][patstan]);
        }
    }
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        if(GetPVarInt(i, "patrolmap") == 1)
        {
            for(new a = 0; a < MAX_PATROLS; a ++)
            {
                if(PatrolInfo[a][pataktywny] == 1)
                {
                    TextDrawShowForPlayer(i, PatrolMarker[a]);
                }
            }
        }
        //CHECKPOINT

    }
}

Patrol_CreateMarker(patrolid, Float:x, Float:y, type)
{
    if(PatrolMarker[patrolid] != Text:INVALID_TEXT_DRAW)
    {
        TextDrawDestroy(PatrolMarker[patrolid]);
        PatrolMarker[patrolid] = Text:INVALID_TEXT_DRAW;
    }
    new str[32];

    if(type == 1) str = "LD_CHAT:thumbup"; //OK
    else if(type == 2) str = "LD_CHAT:badchat"; //pomoc
    else if(type == 3) str = "hud:radar_impound"; //poscig
    else if(type == 4) str = "hud:radar_hostpital"; // ranny

    x = floatabs(320 - 0.126666 * (x + 3000)) + 70;
    y = floatabs(240 + 0.105 * (y - 3000)) - 27;

    if(x <= 130)
    {
        str = "LD_CHAT:thumbdn";
        x = 130;
    }
    else if(x >= 510)
    {
        str = "LD_CHAT:thumbdn";
        x=510;
    }
    if(y <= 65)
    {
        str = "LD_CHAT:thumbdn";
        y=65;
    }
    else if(y >= 380)
    {
        str = "LD_CHAT:thumbdn";
        y=380;
    }

    PatrolMarker[patrolid] = TextDrawCreate(x, y, str);
    TextDrawLetterSize(PatrolMarker[patrolid], 0.000000, 0.000000);
    TextDrawTextSize(PatrolMarker[patrolid], 19.500000, 17.062500);
    TextDrawAlignment(PatrolMarker[patrolid], 1);
    TextDrawColor(PatrolMarker[patrolid], -1);
    TextDrawSetShadow(PatrolMarker[patrolid], 0);
    TextDrawSetOutline(PatrolMarker[patrolid], 0);
    TextDrawFont(PatrolMarker[patrolid], 4);
    TextDrawSetSelectable(PatrolMarker[patrolid], true);
}
//Scena
Scena_CreateAt(Float:x, Float:y, Float:z)
{
    new start, end, objstart, objend;
    //Pod�oga
    start = CreateDynamicObject(19464, 0.00000, 0.00000, 0.00000,   0.00000, 90.00000, 0.00000);
    objstart = start;
    CreateDynamicObject(19464, 0.00000, 5.93500, 0.00000,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19464, 5.09520, 5.93500, 0.00000,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19464, 5.09520, 0.00000, 0.00000,   0.00000, 90.00000, 0.00000);
    CreateDynamicObject(19464, 0.00000, -5.93500, 0.00000,   0.00000, 90.00000, 0.00000);
    objend = CreateDynamicObject(19464, 5.09520, -5.93500, 0.00000,   0.00000, 90.00000, 0.00000);
    for(new i=objstart;i<=objend;i++) SetDynamicObjectMaterial(i, 0, 18018, "genintintbarb", "cj_metalplate2");
    //Podstawa
    objstart = CreateDynamicObject(19463, -2.49824, 4.11975, -1.65150,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, -2.49000, -4.09100, -1.65150,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, 2.38022, -8.82674, -1.65150,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19463, 2.38020, 8.82670, -1.65150,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19463, 7.56052, -4.08956, -1.65150,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, 7.56050, 4.10710, -1.65150,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19463, 2.79501, 8.83527, -1.65150,   0.00000, 0.00000, 90.00000);
    objend = CreateDynamicObject(19463, 2.79500, -8.83530, -1.65150,   0.00000, 0.00000, 90.00000);
    for(new i=objstart;i<=objend;i++) SetDynamicObjectMaterial(i, 0, 3862, "hashmarket_sfsx", "ws_tarp4");
    //Ty�
    objstart = CreateDynamicObject(18766, 7.14500, -6.39960, 3.81240,   0.00000, 90.00000, 90.00000);
    CreateDynamicObject(18766, 7.14500, -1.39960, 3.81240,   0.00000, 90.00000, 90.00000);
    CreateDynamicObject(18766, 7.14500, 3.60040, 3.81240,   0.00000, 90.00000, 90.00000);
    objend = CreateDynamicObject(18766, 7.13720, 6.41620, 3.81240,   0.00000, 90.00000, 90.00000);
    for(new i=objstart;i<=objend;i++) SetDynamicObjectMaterial(i, 0, -1, "none", "none", 0xFF000000);
    CreateDynamicObject(16089, 6.62030, 0.00000, 0.52010,   0.00000, 0.00000, 0.00000);
    //Blinkery
    CreateDynamicObject(19150, 5.89259, 5.30542, 7.19990,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(19150, 5.89260, -3.69460, 7.19990,   0.00000, 0.00000, 90.00000);

    CreateDynamicObject(7096, 0.88983, -12.53191, -1.73484,   0.00000, 0.00000, 90.00000);
    //Dym

    //Napis mid
    ScenaScreenObject = CreateDynamicObject(4988, 6.5, 0.00000, 4.18430,   0.00000, 0.00000, 100.0000);
    SetDynamicObjectMaterialText(ScenaScreenObject, 0, "SCENA", OBJECT_MATERIAL_SIZE_512x256, "Arial", 72, 1, 0xFFFFFFFF, 0, 1);
    //
    CreateDynamicObject(2232, -2.04205, 8.23906, 0.73210,   0.00000, 0.00000, -72.24001);
    CreateDynamicObject(2232, -2.04225, -8.23434, 0.73210,   0.00000, 0.00000, -110.27997);
    CreateDynamicObject(2232, 6.05792, -8.38562, 0.73210,   0.00000, 0.00000, -90.59996);
    CreateDynamicObject(2232, 6.02001, 8.23435, 0.73210,   0.00000, 0.00000, -84.11996);
    CreateDynamicObject(2229, -1.72212, 7.32641, 0.12049,   0.00000, 0.00000, -82.91998);
    CreateDynamicObject(2229, -1.91799, -7.96637, 0.12049,   0.00000, 0.00000, -107.27997);
    //Efekty
    ScenaEffectStart = CreateDynamicObject(1951, -2.03500, 0.00000, -0.01209,   0.00000, 180.00000, 0.00000);
    CreateDynamicObject(1951, -2.03500, 3.00000, -0.01210,   0.00000, 180.00000, 0.00000);
    CreateDynamicObject(1951, -2.03500, 6.00000, -0.01210,   0.00000, 180.00000, 0.00000);
    CreateDynamicObject(1951, -2.03500, -3.00000, -0.01210,   0.00000, 180.00000, 0.00000);
    end = CreateDynamicObject(1951, -2.03500, -6.00000, -0.01210,   0.00000, 180.00000, 0.00000);
    new Float:x1, Float:y1, Float:z1;
    for(new i=start;i<=end;i++)
    {
        GetDynamicObjectPos(i, x1, y1, z1);
        SetDynamicObjectPos(i, x1+x, y1+y,z1+z);
    }
    for(new i=0;i<5;i++)
    {
        ScenaEffectData[SCEffectObj][i] = 0;
    }
    ScenaPosition[0] = x;
    ScenaPosition[1] = y;
    ScenaPosition[2] = z;
    ScenaData[0] = start;
    ScenaData[1] = end;
    ScenaCreated = true;

    ScenaAudioStream = "http://radioparty.pl/play/glowny.m3u";
    Scena_Refresh();
}

public Scena_GenerateEffect()
{
    if(ScenaEffectData[SCEffectCount] > 1)
    {
        ScenaEffectData[SCEffectCount]--;
        if(ScenaEffectData[SCEffectDelay] != 0) ScenaEffectData[SCEffectTimer] = SetTimer("Scena_GenerateEffect", ScenaEffectData[SCEffectDelay], 0);
    }
    new Float:x, Float:y, Float:z;
    for(new i=0;i<5;i++)
    {
        if(ScenaEffectData[SCEffectObj][i] != 0)
        {
            DestroyDynamicObject(ScenaEffectData[SCEffectObj][i]);
            ScenaEffectData[SCEffectObj][i] = 0;
        }
        if(ScenaEffectWait)
        {
            GetDynamicObjectPos(ScenaEffectStart+i, x, y, z);
            ScenaEffectData[SCEffectObj][i] = CreateDynamicObject(ScenaEffectData[SCEffectModel], x, y, z-1.5, 0.0, 0.0, 0.0);
        }
    }
    if(ScenaEffectWait) ScenaEffectWait=false;
    else ScenaEffectWait=true;
    Scena_Refresh();
}

Scena_Refresh()
{
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(IsPlayerInRangeOfPoint(i, 100.0, ScenaPosition[0], ScenaPosition[1], ScenaPosition[2]))
        {
            Streamer_Update(i);
        }
    }
}

public Scena_ScreenEffect()
{
    if(!ScenaScreenEnable)
    {
        return;
    }
    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(ScenaScreenObject, x, y, z);
    if(ScenaScreenTyp == 1)
    {
        if(ScenaScreenMove == 0) MoveDynamicObject(ScenaScreenObject, x, y, ScenaPosition[2]+4.18430+2.5, ScenaScreenData, 0.0, 0.0, 100.0000), ScenaScreenMove= 1;
        else if(ScenaScreenMove == 1) MoveDynamicObject(ScenaScreenObject, x, y, ScenaPosition[2]+4.18430-2.5, ScenaScreenData, 0.0, 0.0, 100.0000), ScenaScreenMove=0;
    }
}

Scena_NeonEffect()
{
    switch(ScenaNeonData[SCNeonTyp])
    {
        case 0:
        {
            for(new i=0;i<2;i++)
            {
                if(ScenaNeonData[SCNeonObj][i] != 0)
                {
                    DestroyDynamicObject(ScenaNeonData[SCNeonObj][i]);
                    ScenaNeonData[SCNeonObj][i] = 0;
                }
            }
            ScenaNeonData[SCNeonSlider]=false;
            ScenaNeonData[SCNeonSliderRefresh]=false;
            ScenaNeonData[SCNeonZderzacz] = false;
        }
        case 1: //slider
        {
            if(ScenaNeonData[SCNeonObj][0] == 0)
            {
                ScenaNeonData[SCNeonObj][0] = CreateDynamicObject(ScenaNeonData[SCNeonModel], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]+SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);
                Scena_Refresh();
            }
            else if(ScenaNeonData[SCNeonSliderRefresh])
            {
                DestroyDynamicObject(ScenaNeonData[SCNeonObj][0]);
                ScenaNeonData[SCNeonObj][0] = CreateDynamicObject(ScenaNeonData[SCNeonModel], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]+SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);
                Scena_Refresh();
                ScenaNeonData[SCNeonSliderRefresh]=false;
            }
            if(ScenaNeonData[SCNeonSlider])
            {
                MoveDynamicObject(ScenaNeonData[SCNeonObj][0], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]-SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, ScenaNeonData[SCNeonDelay]);
                ScenaNeonData[SCNeonSlider]=false;
            }
            else
            {
                MoveDynamicObject(ScenaNeonData[SCNeonObj][0], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]+SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, ScenaNeonData[SCNeonDelay]);
                ScenaNeonData[SCNeonSlider]=true;
            }
        }
        case 2: //slider
        {
            if(ScenaNeonData[SCNeonObj][0] == 0)
            {
                ScenaNeonData[SCNeonObj][0] = CreateDynamicObject(ScenaNeonData[SCNeonModel], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]+SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);
                ScenaNeonData[SCNeonObj][1] = CreateDynamicObject(ScenaNeonData[SCNeonModel], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]-SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);

                Scena_Refresh();
            }
            else if(ScenaNeonData[SCNeonSliderRefresh])
            {
                DestroyDynamicObject(ScenaNeonData[SCNeonObj][0]);
                DestroyDynamicObject(ScenaNeonData[SCNeonObj][1]);
                ScenaNeonData[SCNeonObj][0] = CreateDynamicObject(ScenaNeonData[SCNeonModel], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]+SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);
                ScenaNeonData[SCNeonObj][1] = CreateDynamicObject(ScenaNeonData[SCNeonModel], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]-SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);

                Scena_Refresh();
                ScenaNeonData[SCNeonSliderRefresh]=false;
            }

            if(ScenaNeonData[SCNeonSlider])
            {
                MoveDynamicObject(ScenaNeonData[SCNeonObj][0], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]+SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, ScenaNeonData[SCNeonDelay]);
                MoveDynamicObject(ScenaNeonData[SCNeonObj][1], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1]-SCENA_NEON_OFFSET_Y,ScenaPosition[2]+SCENA_NEON_OFFSET_Z, ScenaNeonData[SCNeonDelay]);

                ScenaNeonData[SCNeonSlider]=false;
            }
            else
            {
                MoveDynamicObject(ScenaNeonData[SCNeonObj][0], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1],ScenaPosition[2]+SCENA_NEON_OFFSET_Z, ScenaNeonData[SCNeonDelay]);
                MoveDynamicObject(ScenaNeonData[SCNeonObj][1], ScenaPosition[0]+SCENA_NEON_OFFSET_X,ScenaPosition[1],ScenaPosition[2]+SCENA_NEON_OFFSET_Z, ScenaNeonData[SCNeonDelay]);

                ScenaNeonData[SCNeonSlider]=true;
            }
            ScenaNeonData[SCNeonZderzacz] = 0;
        }
    }
}

Scena_Destroy()
{
    for(new i=ScenaData[0];i<=ScenaData[1];i++)
    {
        DestroyDynamicObject(i);
    }
    for(new i=0;i<5;i++)
    {
        if(ScenaEffectData[SCEffectObj][i] != 0) DestroyDynamicObject(ScenaEffectData[SCEffectObj][i]);
    }
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(GetPVarInt(i, "scena-audio") == 1)
        {
            if(IsPlayerInRangeOfPoint(i, 100.0, ScenaPosition[0],ScenaPosition[1],ScenaPosition[2]))
            {
                StopAudioStreamForPlayer(i);
                SetPVarInt(i, "scena-audio", 0);
            }
        }
    }
    ScenaNeonData[SCNeonTyp] = 0;
    Scena_NeonEffect();
    ScenaCreated = false;
}

//------------------- OIL SYSTEM -------------------------------

public OnPlayerEnterOilSpot(playerid)
{
	new rand = random(10);
	if(rand == 1)
	{
		new lVeh = GetPlayerVehicleID(playerid);
		new Float:lSpeed = GetCarSpeed(lVeh), Float:lAngle;
		GetVehicleZAngle(lVeh, lAngle);
		if(lSpeed < 50.0) return 0;
		new Float:lVel = floatsqroot(lSpeed)/150;
		if(lAngle - 180.0 > 0) lVel = -lVel;
		SetVehicleAngularVelocity(lVeh, 0.0, 0.0, lVel);
		GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~Ooops... poslizg!", 1500, 3);
	}
    return 1;
}

Oil_LoadCleanProcedure(playerid)
{
    for(new i=0;i<5;i++)
    {
        PlayerOilKeys[playerid][i] = 0;
    }
    PlayerOilKeys[playerid][2] = 1+random(4);
    PlayerOilKeys[playerid][3] = 1+random(4);
    PlayerOilKeys[playerid][4] = 1+random(4);
    Oil_LoadPTXD(playerid);
    Oil_UpdateKeysSeq(playerid);
    TextDrawShowForPlayer(playerid, OilTXD_BG[0]);
    TextDrawShowForPlayer(playerid, OilTXD_BG[1]);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.1, 0, 0, 0, 0, -1);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.1, 0, 0, 0, 0, -1);
}

Oil_UpdateRandomKeys(playerid)
{
    for(new i=0;i<4;i++)
    {
        PlayerOilKeys[playerid][i] = PlayerOilKeys[playerid][i+1];
    }
    PlayerOilKeys[playerid][4] = 1+random(4);
}

Oil_OnPlayerPress(playerid, keys)
{
    if(GetTickDiff(GetTickCount(), GetPVarInt(playerid, "oil_press")) < 100) return 0;
    if((keys == KEY_UP) && PlayerOilKeys[playerid][2] == 3) Oil_PressedOK(playerid);
    else if((keys == KEY_DOWN) && PlayerOilKeys[playerid][2] == 4) Oil_PressedOK(playerid);
    else if((keys == KEY_LEFT*2) && PlayerOilKeys[playerid][2] == 1) Oil_PressedOK(playerid);
    else if((keys == KEY_RIGHT*2) && PlayerOilKeys[playerid][2] == 2) Oil_PressedOK(playerid);
    else
    {
        //Co si� dzieje gdy wcisni�to niepoprawny przycisk
        new lStr[16];
        PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
        if(OilData[GetPVarInt(playerid, "oil_id")][oilHP] < OIL_MAX_HEALTH)
        {
            OilData[GetPVarInt(playerid, "oil_id")][oilHP] ++;
        }
        format(lStr, 16, "~r~%d", OilData[GetPVarInt(playerid, "oil_id")][oilHP]);
        GameTextForPlayer(playerid, lStr, 1000, 5);
    }
    SetPVarInt(playerid, "oil_press", GetTickCount());
    Oil_UpdateRandomKeys(playerid);
    Oil_UpdateKeysSeq(playerid);
    return 1;
}

Oil_PressedOK(playerid)
{
    new lID = GetPVarInt(playerid, "oil_id");
    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
    OilData[lID][oilHP]-=2;
    new Float:lPos[3];
    GetDynamicObjectPos(OilData[lID][oilObject], lPos[0], lPos[1], lPos[2]);
    if(OilData[lID][oilHP] < 0) Oil_Destroy(lID);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 0, 0);
    new lStr[16];
    format(lStr, 16, "~g~%d", OilData[lID][oilHP]);
    GameTextForPlayer(playerid, lStr, 1000, 5);
}

Oil_UpdateKeysSeq(playerid)
{
    new lStr[8];
    for(new i=0;i<5;i++)
    {
        switch(PlayerOilKeys[playerid][i])
        {
            case 0: format(lStr, 8, "_");
            case 1: format(lStr, 8, "~<~");
            case 2: format(lStr, 8, "~>~");
            case 3: format(lStr, 8, "~u~");
            case 4: format(lStr, 8, "~d~");
        }
        PlayerTextDrawSetString(playerid, OilPTXD_Arrow[i][playerid], lStr);
        PlayerTextDrawShow(playerid, OilPTXD_Arrow[i][playerid]);
    }
}

Oil_GenerateFromVehicle(vehicleid)
{
	if(Oil_GlobalCooldown > gettime()) return 0;
    if(!bOilOccur[vehicleid])
    {
        if(IsAPlane(vehicleid)) return 0;
        if(IsABoat(vehicleid)) return 0;
        new Float:lX, Float:lY, Float:lZ;
        GetVehicleVelocity(vehicleid, lX, lY, lZ);
        if(!(-0.25 < lZ < 0.25)) return 0;

        if(GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 510) return 0;

        new lID = Oil_GenerateID();
        if(lID == -1) return 0;
        new Float:lPos[3];
        GetVehiclePos(vehicleid, lPos[0], lPos[1], lPos[2]);

        //Szansa na powstanie plamy olejowej w zaleznosci od tego, czy jest blisko LS
        new lChance=1;
        if(VectorSize(1600.0-lPos[0], -1100.0-lPos[1], 0.0) < 1000.0) lChance+=4;

        new lNear = Oil_GetIDAtPosition(lPos[0], lPos[1], lPos[2], 200.0);
        if(lNear == -1)
        {
            new Float:lUnused;
            GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, lUnused, lUnused, lX);
            GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_WHEELSFRONT, lUnused, lUnused, lY);
            GetVehicleZAngle(vehicleid, lZ);
            OilData[lID][oilPos][0] = lPos[0],
            OilData[lID][oilPos][1] = lPos[1],
            OilData[lID][oilPos][2] = lPos[2] - ((floatsqroot(lX)/4)-lY+0.05);

            OilData[lID][oilHP] = OIL_MAX_HEALTH;
            OilData[lID][oilObject] = CreateDynamicObject(2715, lPos[0], lPos[1], OilData[lID][oilPos][2], 90.0, 0.0, lZ);
            SetDynamicObjectMaterial(OilData[lID][oilObject], 0, 11384, "xenon_sfse", "ruffroadlas");

            OilData[lID][oilArea] = CreateDynamicCube(lPos[0]-3.0, lPos[1]-3.0, OilData[lID][oilPos][2]-5.0, lPos[0]+3.0, lPos[1]+3.0, OilData[lID][oilPos][2]+5.0);
            bOilOccur[vehicleid] = true;
            OilData[lID][oilTime] = gettime();
			Oil_GlobalCooldown = gettime()+900; //15 minut
            printf("[OilSpot] Created ID %d at %.1f %.1f %.1f by car %d", lID, lPos[0], lPos[1], OilData[lID][oilPos][2], vehicleid);
        }
    }
    return 1;
}

Oil_Destroy(lID)
{
    OilData[lID][oilPos][0] = 0.0,
    OilData[lID][oilPos][1] = 0.0,
    OilData[lID][oilPos][2] = 0.0;

    DestroyDynamicObject(OilData[lID][oilObject]);
    DestroyDynamicArea(OilData[lID][oilArea]);

    foreach(new i : Player)
    {
        if(GetPVarInt(i, "oil_clear") != 1) continue;
        if(GetPVarInt(i, "oil_id") != lID) continue;
        Oil_UnloadPTXD(i);
        SetPVarInt(i, "oil_clear", 0);
		ClearAnimations(i);
	    SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
        TogglePlayerControllable(i, 1);
        TextDrawHideForPlayer(i, OilTXD_BG[0]);
        TextDrawHideForPlayer(i, OilTXD_BG[1]);
        ApplyAnimation(i, "BOMBER", "BOM_Plant_Crouch_Out", 4.0, 0, 0, 0, 0, -1);
        SendClientMessage(i, COLOR_WHITE, "[ERS] Usun��e� plam� oleju! Otrzymujesz "#PRICE_PLAMA"$! [ERS]");
        DajKaseDone(i, PRICE_PLAMA);
        GroupSendMessage(4, COLOR_GREEN, "[ERS] Stra�ak usun�� plam� oleju! Na konto frakcji wp�ywa "#PRICE_PLAMA"$! [ERS]");
		SendMessageToAdmin(sprintf("PLAMY: Gracz %s [%d] usun�� plam� oleju i otrzyma� za to "#PRICE_PLAMA"$!", GetNickEx(i), i), COLOR_LIGHTRED);
		Log(payLog, WARNING, "%s usun�� plam� oleju i otrzyma� za to "#PRICE_PLAMA"$", GetPlayerLogName(i));
        Sejf_Add(FRAC_ERS, PRICE_PLAMA);
    }
}

Oil_GenerateID()
{
    for(new i=0;i<MAX_OILS;i++)
    {
        if(Oil_IsValid(i)) continue;
        return i;
    }
    return -1;
}

Oil_IsValid(id) return (OilData[id][oilPos][0] != 0.0);

Oil_GetIDAtPosition(Float:x, Float:y, Float:z, Float:radius)
{
    new id=-1, Float:lA, Float:lB=radius;
    for(new i=0;i<MAX_OILS;i++)
    {
        if(OilData[i][oilPos][0] == 0.0) continue;
        if((lA = VectorSize(OilData[i][oilPos][0]-x, OilData[i][oilPos][1]-y, OilData[i][oilPos][2]-z)) < radius)
        {
            if(lA < lB)
            {
                lB = lA;
                id = i;
            }
        }
    }
    return id;
}

ChangePlayerName(playerid, name[])
{
    if(strlen(name) >= 21)
	{
		SendClientMessage(playerid, COLOR_RED, "Nowy nick mo�e mie� maksymalnie 20 znak�w!");
		return 0;
	}

    if(toupper(name[0]) != name[0])
    {
        SendClientMessage(playerid, COLOR_RED, "Litery pocz�tkowe musz� zaczyna� si� od du�ej.");
        return 0;
    }
    if(name[strlen(name)-1] == '_')
    {
        SendClientMessage(playerid, COLOR_RED, "Nie moze byc pod�ogi na ko�cu.");
        return 0;
    }
    for(new i=0;i<strlen(name);i++)
    {
        if(name[i] == ' ')
        {
            SendClientMessage(playerid, COLOR_RED, "Nick zawiera spacj�, zmie� to.");
		    return 0;
        }
    }
    new stabcount=0;
    for(new i=0;i<strlen(name);i++)
    {
        if(name[i] == '_')
        {
            if(toupper(name[i+1]) != name[i+1])
            {
                SendClientMessage(playerid, COLOR_RED, "Litery pocz�tkowe musz� zaczyna� si� od du�ej.");
                return 0;
            }
            stabcount++;
        }
    }
    if(stabcount == 0 || stabcount > 2)
    {
        SendClientMessage(playerid, COLOR_RED, "Nick nie zawiera podkresle�, lub ma ich ponad 2.");
		return 0;
    }

    if(!IsNickCorrect(name))
    {
        SendClientMessage(playerid, COLOR_RED, "Nick zawiera niepoprawne znaki (znaki polskie, cyfry lub specjalne).");
        return 0;
    }
	
	if(ReturnUser(name) != INVALID_PLAYER_ID) 
	{
        SendClientMessage(playerid, COLOR_RED, "Gracz o takim nicku gra obecnie na serwerze!");
		return 0;
	}

	if(MruMySQL_DoesAccountExist(name) != 0)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Ten Nick jest ju� zaj�ty przez innego gracza.");
		return 0;
	}

    PlayerInfo[playerid][pZmienilNick]--;
	PlayerInfo[playerid][pMember] = 0;
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pZG] = 0;
	PoziomPoszukiwania[playerid] = 0;
	SetPlayerName(playerid, name);
	SetRPName(playerid);
	
    format(PlayerInfo[playerid][pNick], 32, "%s", name);
	
    MruMySQL_SaveAccount(playerid);
    return 1;
}
CheckVulgarityString(text[])
{
	new valueVulgarity;
	if(strfind(text, "kurwa", true) >=0 
	|| strfind(text, "chuj", true) >=0 
	|| strfind(text, "cipa", true) >=0 
	|| strfind(text, "fiut", true) >=0 
	|| strfind(text, "zjeb", true) >=0 
	|| strfind(text, "dick", true) >=0 
	|| strfind(text, "kurwy", true) >=0 
	|| strfind(text, "jeb", true)>=0 
	|| strfind(text , "huj" , true)>=0 
	|| strfind(text , "pizda" , true)>=0 
	|| strfind(text , "pizdy" , true)>=0 
	|| strfind(text , "frajer" , true)>=0
	|| strfind(text , "szmul" , true)>=0
	|| strfind(text , "dzban" , true)>=0  	
	|| strfind(text , "kurwa" , true)>=0
	|| strfind(text , "kutas" , true)>=0 
	|| strfind(text , "dupa" , true)>=0 
	|| strfind(text , "cipa" , true)>=0 
	|| strfind(text , "cipka" , true)>=0 
	|| strfind(text , "n00b" , true)>=0 
	|| strfind(text , "noob" , true)>=0 
	|| strfind(text , "n0b" , true)>=0
	|| strfind(text , "kurwy" , true)>=0)
	{	
		valueVulgarity = 1;
	}
	else 
	{
		valueVulgarity = 0;
	}
	return valueVulgarity;
}
SetRPName(playerid)
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	format(nickRP[playerid], MAX_PLAYER_NAME, "%s", nick);
	strreplace2(nickRP[playerid], '_', ' ');
}

public VendCheck(playerid)
{
    if(GetPlayerAnimationIndex(playerid)==1660)
    {
        if(kaska[playerid] > SPRUNK_COST)
        {
            new Float:hp;
            GetPlayerHealth(playerid, hp);
            SetPlayerHealth(playerid, float(clamp(floatround(hp)+25, 1, 100)));

            ZabierzKaseDone(playerid, SPRUNK_COST);
        }
        else PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
    }
}

//--------------------------------------------------
//--------------------------------------------------
//30.10
TJD_Exit()
{
    TextDrawDestroy(TXD_TJDBg);
    TextDrawDestroy(TXD_TJDImg);
    DestroyDynamic3DTextLabel(TJD_Label);

    new lStr[64];
    format(lStr, 64, "UPDATE mru_config SET `trucker_magazyn`='%d'", TJD_Materials);
    if(MYSQL_SAVING) mysql_query(lStr);
}

TJD_Load()
{
    for(new i=0;i<7;i++) TJD_RestoreBox(i);

    //PACKEGES
    CreateDynamicObject(2991, 1731.05530, -2055.54248, 13.18880,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1731.05530, -2055.54248, 14.46492,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1731.05530, -2059.54248, 13.18880,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1731.05530, -2059.54248, 14.46490,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1733.05530, -2055.54248, 13.18880,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1733.05530, -2055.54248, 14.46490,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1733.05530, -2059.54248, 13.18880,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1558, 1730.61047, -2062.05151, 13.09371,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2900, 1733.04260, -2058.15479, 13.78380,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2900, 1732.79529, -2059.35864, 13.78380,   0.00000, 0.00000, 69.54000);
    CreateDynamicObject(2900, 1732.62561, -2060.59448, 13.78380,   0.00000, 0.00000, 88.97998);

    //OTHER
    CreateDynamicObject(5644, 1881.82031, -1315.92188, 56.06217,   0.0, 0.00000, 0.0, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(5463, 1881.80103, -1315.53516, 72.94360,   0.00000, 0.00000, 0.00000, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(5644, 1881.82031, -1315.92188, 81.33503,   0.0, 0.00000, 0.0, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(1384, 1912.12134, -1318.99951, 98.18674,   0.00000, 0.00000, 505.01999, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(1395, 1912.11914, -1318.93286, 45.80652,   0.00000, 0.00000, 0.00000, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(3722, 1962.26563, -1319.45068, 26.43902,   0.00000, 354.00000, 0.00000);
    CreateDynamicObject(3577, 1904.26013, -1295.57019, 13.22326,   0.00000, 0.00000, 91.67999);
    CreateDynamicObject(1685, 1899.94019, -1295.36926, 13.27162,   0.00000, 0.00000, 28.74000);
    CreateDynamicObject(1685, 1901.01685, -1297.61292, 13.27162,   0.00000, 0.00000, -14.40000);
    CreateDynamicObject(1685, 1900.35999, -1296.59497, 14.77025,   0.00000, 0.00000, 24.78000);
    CreateDynamicObject(1685, 1894.32825, -1297.11597, 13.31168,   0.00000, 0.00000, -72.18000);
    CreateDynamicObject(1685, 1894.82996, -1299.18164, 13.31168,   0.00000, 0.00000, -126.42000);
    CreateDynamicObject(1685, 1892.21777, -1298.77466, 13.33171,   0.00000, 0.00000, -126.42000);
    CreateDynamicObject(1685, 1893.68005, -1298.55237, 14.82419,   0.00000, 0.00000, -87.77999);
    CreateDynamicObject(3722, 1903.02673, -1318.92017, 10.71766,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3722, 1906.18860, -1318.88501, 10.74245,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3722, 1899.99146, -1318.77747, 10.74245,   0.00000, 0.00000, 10.98000);
    CreateDynamicObject(3049, 1861.89880, -1330.82715, 14.81102,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3049, 1866.39880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3049, 1870.89880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3049, 1875.39880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3049, 1879.89880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3050, 1893.39880, -1330.82715, 14.81100,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3049, 1893.39880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3050, 1902.55896, -1330.84766, 14.81100,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3049, 1861.84314, -1326.12708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1321.62708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1317.12708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1312.62708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1308.12708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1303.62708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1684, 1873.39368, -1295.73730, 14.20618,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2984, 1882.75342, -1294.28650, 13.61465,   0.78000, 4.98000, 93.83998);
    CreateDynamicObject(3282, 1954.07092, -1330.16174, 20.98397,   0.00000, 350.00000, 0.00000);
    CreateDynamicObject(3282, 1943.15479, -1330.14172, 18.95337,   0.00000, 350.00000, 0.00000);
    CreateDynamicObject(4099, 1957.73157, -1314.00635, 22.71690,   -3.84000, 355.55994, 47.94000);
    CreateDynamicObject(1685, 656.87292, 805.57257, -43.26763,   0.00000, 0.00000, 13.08000);
    CreateDynamicObject(1685, 655.08154, 805.12305, -43.26763,   0.00000, 0.00000, 13.08000);
    CreateDynamicObject(1685, 653.25555, 804.66394, -43.26763,   0.00000, 0.00000, 13.08000);
    CreateDynamicObject(1685, 651.29852, 804.44727, -43.26763,   0.00000, 0.00000, 4.44000);
    CreateDynamicObject(1685, 649.52148, 804.27161, -43.26763,   0.00000, 0.00000, 4.44000);
    CreateDynamicObject(1685, 647.54663, 804.36176, -43.26763,   0.00000, 0.00000, -5.10000);
    CreateDynamicObject(1685, 658.74884, 806.05511, -43.26763,   0.00000, 0.00000, 15.90000);
    CreateDynamicObject(1685, 660.66547, 806.85052, -43.26763,   0.00000, 0.00000, 28.98002);
    CreateDynamicObject(1685, 662.36334, 807.90942, -43.26763,   0.00000, 0.00000, 38.58003);
    CreateDynamicObject(1685, 663.90851, 809.27466, -43.26763,   0.00000, 0.00000, 44.22004);
    CreateDynamicObject(1685, 665.25793, 810.72522, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 666.54218, 812.18915, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 667.92657, 813.74432, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 666.00769, 814.48474, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 664.59644, 812.92163, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 663.32581, 811.31384, -43.26763,   0.00000, 0.00000, 46.86004);
    CreateDynamicObject(1685, 661.85834, 809.96594, -43.26763,   0.00000, 0.00000, 40.80002);
    CreateDynamicObject(1685, 660.22931, 808.83923, -43.26763,   0.00000, 0.00000, 29.22001);
    CreateDynamicObject(1685, 658.44696, 807.97968, -43.26763,   0.00000, 0.00000, 18.42000);
    CreateDynamicObject(1685, 656.59784, 807.51935, -43.26763,   0.00000, 0.00000, 13.08000);
    CreateDynamicObject(1685, 654.76886, 806.93689, -43.26763,   0.00000, 0.00000, 14.64000);
    CreateDynamicObject(1685, 652.64288, 806.60767, -43.26763,   0.00000, 0.00000, -1.32000);
    CreateDynamicObject(1685, 650.59900, 806.32904, -43.26763,   0.00000, 0.00000, 18.06000);
    CreateDynamicObject(1685, 648.48517, 806.13599, -43.26763,   0.00000, 0.00000, -2.88000);
    CreateDynamicObject(1685, 666.19055, 813.26825, -41.79947,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 664.96112, 811.74066, -41.79947,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 663.70697, 810.08124, -41.79947,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 662.17474, 808.76434, -41.79947,   0.00000, 0.00000, 36.60006);
    CreateDynamicObject(1685, 660.62048, 807.66290, -41.79947,   0.00000, 0.00000, 30.42004);
    CreateDynamicObject(1685, 658.83423, 806.86768, -41.79947,   0.00000, 0.00000, 23.88003);
    CreateDynamicObject(1685, 656.84607, 806.26874, -41.79947,   0.00000, 0.00000, -1.61997);
    CreateDynamicObject(1685, 654.06512, 805.70148, -41.79947,   0.00000, 0.00000, 12.66003);
    CreateDynamicObject(1685, 652.13287, 805.36993, -41.79947,   0.00000, 0.00000, 12.66003);
    CreateDynamicObject(1685, 650.00317, 805.00964, -41.79947,   0.00000, 0.00000, 12.66003);
    CreateDynamicObject(1685, 647.91980, 805.08209, -41.79947,   0.00000, 0.00000, -6.65996);

    SetTimer("TJDTimer", 3000, 1);

    TXD_TJDBg = TextDrawCreate(553.000000, 107.000000, "~n~~n~~n~~n~~n~");
    TextDrawAlignment(TXD_TJDBg, 2);
    TextDrawBackgroundColor(TXD_TJDBg, 255);
    TextDrawFont(TXD_TJDBg, 1);
    TextDrawLetterSize(TXD_TJDBg, 0.500000, 1.000000);
    TextDrawColor(TXD_TJDBg, -1);
    TextDrawSetOutline(TXD_TJDBg, 0);
    TextDrawSetProportional(TXD_TJDBg, 1);
    TextDrawSetShadow(TXD_TJDBg, 1);
    TextDrawUseBox(TXD_TJDBg, 1);
    TextDrawBoxColor(TXD_TJDBg, -1724834202);
    TextDrawTextSize(TXD_TJDBg, 80.000000, 111.000000);
    TextDrawSetSelectable(TXD_TJDBg, 0);

    TXD_TJDImg = TextDrawCreate(489.000000, 103.000000, "New Textdraw");
    TextDrawAlignment(TXD_TJDImg, 2);
    TextDrawBackgroundColor(TXD_TJDImg, 0);
    TextDrawFont(TXD_TJDImg, 5);
    TextDrawLetterSize(TXD_TJDImg, 0.000000, 1.000000);
    TextDrawColor(TXD_TJDImg, -1);
    TextDrawSetOutline(TXD_TJDImg, 0);
    TextDrawSetProportional(TXD_TJDImg, 1);
    TextDrawSetShadow(TXD_TJDImg, 1);
    TextDrawUseBox(TXD_TJDImg, 1);
    TextDrawBoxColor(TXD_TJDImg, 255);
    TextDrawTextSize(TXD_TJDImg, 61.000000, 50.000000);
    TextDrawSetPreviewModel(TXD_TJDImg, 1558);
    TextDrawSetPreviewRot(TXD_TJDImg, 350.000000, 0.000000, 30.000000, 1.000000);
    TextDrawSetSelectable(TXD_TJDImg, 0);

    new lStr[64];
    format(lStr, 64, "Liczba materia��w\n{99311E}%d\n{646464}(/zlecenie)", TJD_Materials);
    TJD_Label = CreateDynamic3DTextLabel(lStr, -1, TransportJobData[0][eTJDStartX], TransportJobData[0][eTJDStartY], TransportJobData[0][eTJDStartZ]+1.0, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

TJD_UpdateLabel()
{
    new lStr[64];
    format(lStr, 64, "Liczba materia��w\n{99311E}%d\n{646464}(/zlecenie)", TJD_Materials);
    UpdateDynamic3DTextLabelText(TJD_Label, -1, lStr);
}
TJD_JobEnd(playerid, bool:quiter=false)
{
    SetPVarInt(playerid, "TJDend", 0);
    SetPVarInt(playerid, "TJDstartend", 0);
    new veh = GetPVarInt(playerid, "TJDveh");

    TJD_CheckForUsedBox(veh);

    if(!quiter)
    {
        RemovePlayerFromVehicleEx(playerid);
        TJD_DestroyTXD(playerid);
    }

    SetVehicleZAngle(veh, 0.0);
    SetVehiclePos(veh, GetPVarFloat(playerid, "transX"),GetPVarFloat(playerid, "transY"), GetPVarFloat(playerid, "transZ"));

    new str[64];
    new ile = GetPVarInt(playerid, "transboxes");
    SetPVarInt(playerid, "transboxes", 0);
    new money = ile*96;
    format(str, 64, "Praca zako�czona. Przewioz�es %d paczek.", ile);
    SendClientMessage(playerid, -1, str);
    if(quiter) money/=2, ile/=2;
    format(str, 64, "Zarabiasz $%d oraz otrzymujesz %d umiej�tnosci.", money, floatround(ile/5, floatround_floor));
    SendClientMessage(playerid, 0x99311EFF, str);
    DajKaseDone(playerid, floatround(money/2));
	Sejf_Add(FRAC_KT, floatround(money/2));

    SetVehicleHealth(veh, 1000.0);
    Gas[veh] = 100;

    PlayerInfo[playerid][pTruckSkill]+=PlayerInfo[playerid][pTruckSkill]+floatround(ile/5, floatround_floor);
}

TJD_CallCheckpoint(playerid, veh)
{
    if(!IsPlayerInGroup(playerid, FRAC_KT)) return 1;
    if(GetVehicleModel(veh) == 578)
    {
        new idx = GetPVarInt(playerid, "trans");
        if(idx != 0)
        {
			new idx2 = (GetPVarInt(playerid, "trans")-1)/2;
            if(idx%2 == 1)
            {
				if(TransportJobData[idx2][eTJDStartX] == 0) idx2 = 0;
				if(IsPlayerInRangeOfPoint(playerid, 20, TransportJobData[idx2][eTJDStartX], TransportJobData[idx2][eTJDStartY], TransportJobData[idx2][eTJDStartZ]))
				{
					idx = (idx-1)/2;

					TJD_CheckForUsedBox(veh);

					SetPVarInt(playerid, "TJD_Loading", 1);
					SetPVarInt(playerid, "loadTimer", SetTimerEx("TJD_LoadTime", TJD_LOADUNLOAD_TIME, 0, "iii", playerid, 0, TransportJobData[idx][eTJDMaxItems]));
					GameTextForPlayer(playerid, "~r~Ladowanie towaru...", TJD_LOADUNLOAD_TIME*TransportJobData[idx][eTJDMaxItems], 4);
					TogglePlayerControllable(playerid, 0);
					DisablePlayerCheckpoint(playerid);
				}
				else
				{
					SetPlayerCheckpoint(playerid, TransportJobData[idx2][eTJDStartX], TransportJobData[idx2][eTJDStartY], TransportJobData[idx2][eTJDStartZ], 5.0);
				}
            }
            else
            {
				if(IsPlayerInRangeOfPoint(playerid, 20, TransportJobData[idx2][eTJDEndX], TransportJobData[idx2][eTJDEndY], TransportJobData[idx2][eTJDEndZ]))
				{
					if(GetPVarInt(playerid, "trans-antytp") > gettime())
					{
						new string[128];
						format(string, sizeof(string), "AdmCmd: %s zostal zkickowany przez Admina: Marcepan_Marks, pow�d: teleport (kurier)", GetNick(playerid));
                        SendPunishMessage(string, playerid);
						Log(punishmentLog, WARNING, "%s dosta� kicka od antycheata, pow�d: teleport (kurier)", GetPlayerLogName(playerid));
			        	KickEx(playerid);
					}
					idx = (idx-1)/2;

					SetPVarInt(playerid, "TJD_Loading", 1);
					SetPVarInt(playerid, "unloadTimer", SetTimerEx("TJD_UnloadTime", TJD_LOADUNLOAD_TIME, 0, "iii", playerid, 0, TransportJobData[idx][eTJDMaxItems]));
					GameTextForPlayer(playerid, "~g~Wyladowanie towaru...", TJD_LOADUNLOAD_TIME*TransportJobData[idx][eTJDMaxItems], 4);
					TogglePlayerControllable(playerid, 0);
					DisablePlayerCheckpoint(playerid);
				}
				else
				{
					SetPlayerCheckpoint(playerid, TransportJobData[idx2][eTJDEndX], TransportJobData[idx2][eTJDEndY], TransportJobData[idx2][eTJDEndZ], 5.0);
				}
            }
            return 1;
        }
    }
    else if(TJDVehBox[veh] != 0)
    {
        new idx = TJDVehBox[veh]-1;
        TJDBoxUsed[idx] = false;
        DestroyDynamicObject(TJDBoxes[idx]);
        TJDBoxes[idx] = 0;
        TJD_RestoreBox(idx);
        TJDVehBox[veh] = 0;
        DisablePlayerCheckpoint(playerid);
        if(GetPVarInt(playerid, "transjob") == 1)
        {
            if(gettime() - GetPVarInt(playerid, "transtime") < 5)
            {
                SendClientMessage(playerid, COLOR_GRAD2, "Za szybko.");
                return 1;
            }
            if(GLOBAL_DISABLETRUCKER) return 1;
            SetPVarInt(playerid, "transboxes", GetPVarInt(playerid, "transboxes")+1);
            new str[8];
            format(str, 8, "%d", GetPVarInt(playerid, "transboxes"));
            PlayerTextDrawSetString(playerid, TXD_TJDCounter[playerid], str);
            PlayerTextDrawShow(playerid, TXD_TJDCounter[playerid]);

            TJD_Materials+=5;
            TJD_UpdateLabel();
        }
        return 1;
    }
    return 1;
}


TJD_CallRaceCheckpoint(playerid)
{
    if(!IsPlayerInGroup(playerid, FRAC_FBI)) return;
    if(GetPVarInt(playerid, "TJDend") == 1)
    {
        TJD_JobEnd(playerid);
        DisablePlayerRaceCheckpoint(playerid);
    }
}

TJD_CallEnterVeh(playerid, veh)
{
    if(!IsPlayerInGroup(playerid, FRAC_FBI)) return;
    if(GetVehicleModel(veh) == 530)
    {
        if(GLOBAL_DISABLETRUCKER) return;
        if(GetPVarInt(playerid, "transjob") == 0)
        {
            new Float:x, Float:y, Float:z;
            GetVehiclePos(veh, x, y, z);
            if(GetPVarInt(playerid, "TJDstartend") == 0)
            {
                SetPVarFloat(playerid, "transX", x);
                SetPVarFloat(playerid, "transY", y);
                SetPVarFloat(playerid, "transZ", z);
            }
            SetPVarInt(playerid, "transjob", 1);
            SetPVarInt(playerid, "TJDstartend", 1);
            SetPVarInt(playerid, "TJDveh", veh);
        }
        TJD_CreateTXD(playerid);
    }
}

TJD_CallExitVeh(playerid)
{
    if(!IsPlayerInGroup(playerid, FRAC_FBI)) return;
    if(GetPVarInt(playerid, "transjob") == 1)
    {
        if(GetPVarInt(playerid, "TJDend") == 1)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Pojazd zniknie za 30 sekund, a Ty dostaniesz mniej kasy.");
        }
        else
        {
            SetPVarInt(playerid, "transjob", 0);
        }
        TJD_DestroyTXD(playerid);
    }
}

TJD_CheckForUsedBox(vehicleid)
{
    if(TJDVehBox[vehicleid] != 0)
    {
        new idx = TJDVehBox[vehicleid]-1;
        TJDBoxUsed[idx] = false;
        DestroyDynamicObject(TJDBoxes[idx]);
        TJDBoxes[idx] = 0;
        TJD_RestoreBox(idx);
        TJDVehBox[vehicleid] = 0;
        new playerid = TJDBoxOwner[idx];
        if(GetPVarInt(playerid, "transjob") == 1)
        {
            DisablePlayerCheckpoint(playerid);
            DisablePlayerRaceCheckpoint(playerid);
            TJD_JobEnd(playerid, true);
            SetPVarInt(playerid, "transjob", 0);
        }
    }
    else if(TJDTransporter[vehicleid]-1 >= 0 && GetPlayerVehicleID(TJDTransporter[vehicleid]-1) != vehicleid)
    {
        new pid = TJDTransporter[vehicleid]-1;
        for(new i=0;i<12;i++)
        {
            if(TransObjects[pid][i] != 0)
            {
                if(IsValidDynamicObject(TransObjects[pid][i]))
                {
                    DestroyDynamicObject(TransObjects[pid][i]);
                    TransObjects[pid][i] = 0;
                }
            }
        }
    }
}

TJD_TryPickup(playerid, veh)
{
    if(TJDVehBox[veh] == 0)
    {
        new idx=-1, Float:thisdist;
        new Float:x, Float:y, Float:z, Float:a;
        GetVehiclePos(veh, x, y, z);
        if(VectorSize(TJD_BoxPos[3][0]-x,TJD_BoxPos[3][1]-y,TJD_BoxPos[3][2]-z) < 20.0)
        {
            GetVehicleZAngle(veh, a);

            x+=1.5*floatsin(-a, degrees);
            y+=1.5*floatcos(-a, degrees);

            for(new i=0;i<7;i++)
            {
                if(TJDBoxUsed[i]) continue;
                thisdist = VectorSize(TJD_BoxPos[i][0]-x,TJD_BoxPos[i][1]-y,TJD_BoxPos[i][2]-z);
                if(thisdist < 0.75)
                {
                    idx=i;
                    break;
                }
            }
            if(idx != -1)
            {
                TJDBoxUsed[idx] = true;
                TJDVehBox[veh] = idx+1;
                TJDBoxOwner[idx] = playerid;

                new rand = random(2);
                switch(rand)
                {
                    case 0: SetPlayerCheckpoint(playerid, 1766.8551, -2049.2805, 12.9831, 5.0);
                    case 1: SetPlayerCheckpoint(playerid, 1766.8551, -2032.2805, 12.9831, 5.0);
                }
                SetPVarInt(playerid, "transtime", gettime());
                if(GetPVarInt(playerid, "TJDstartend") == 1 && GetPVarInt(playerid, "TJDend") == 0)
                {
                    SetPVarInt(playerid, "TJDend", 1);
                    SetPlayerRaceCheckpoint(playerid, 1, GetPVarFloat(playerid, "transX"),GetPVarFloat(playerid, "transY"), GetPVarFloat(playerid, "transZ"), 0.0, 0.0, 0.0, 2.0);
                }
            }
        }
    }
}

TJD_RestoreBox(id)
{
    if(TJDBoxes[id] != 0) DestroyDynamicObject(TJDBoxes[id]);
    TJDBoxes[id] = CreateDynamicObject(1558, TJD_BoxPos[id][0],TJD_BoxPos[id][1],TJD_BoxPos[id][2],0.0,0.0,0.0);
}

public TJDTimer()
{
    for(new i=0;i<7;i++)
    {
        if(!TJDBoxUsed[i])
        {
            SetDynamicObjectPos(TJDBoxes[i], TJD_BoxPos[i][0], TJD_BoxPos[i][1], TJD_BoxPos[i][2]);
            SetDynamicObjectRot(TJDBoxes[i], 0.0, 0.0, 0.0);
        }
    }
}

public TJD_LoadTime(playerid, count, maxcount)
{
    new idx = (GetPVarInt(playerid, "trans")-1)/2;
    if(count == maxcount)
    {
		SetPVarInt(playerid, "TJD_Loading", 0);
        SetPVarInt(playerid, "trans", GetPVarInt(playerid, "trans")+1);
        SetPVarInt(playerid, "transtime", gettime());
		SetPVarInt(playerid, "trans-antytp", gettime()+60);
        SetPlayerCheckpoint(playerid, TransportJobData[idx][eTJDEndX], TransportJobData[idx][eTJDEndY], TransportJobData[idx][eTJDEndZ], 5.0);
        SendClientMessage(playerid, 0x00FF00FF, "Towar za�adowany, udaj si� na miejsce wypakunku.");
        TogglePlayerControllable(playerid, 1);
    }
    else
    {
        TJDTransporter[GetPlayerVehicleID(playerid)] = playerid+1;

        count++;
        SetTimerEx("TJD_LoadTime", TJD_LOADUNLOAD_TIME, 0, "iii", playerid, count, maxcount);
    }
}

public TJD_UnloadTime(playerid, count, maxcount)
{
    if(count == maxcount)
    {
		SetPVarInt(playerid, "TJD_Loading", 0);
        new idx = (GetPVarInt(playerid, "trans")-1)/2;
        SetPVarInt(playerid, "trans", 0);
        new str[64], /*Float:speed,*/ ile;
        DisablePlayerCheckpoint(playerid);
		if(idx == -1) return; //TODO: check

		ile = TransportJobData[idx][eTJDMoney];
        format(str, 64, "Towar wy�adowany, zarabiasz %d$", ile);
        SendClientMessage(playerid, 0x00FF00FF, str);

        DajKaseDone(playerid, ile);
		Sejf_Add(FRAC_KT, floatround(ile/2));
		Log(payLog, WARNING, "%s dostarczy� towar i dosta� $%d (do sejfu KT trafi�o $%d)", GetPlayerLogName(playerid), ile, ile/2);
        new lSkill = floatround((ile*8)/((TransportJobData[idx][eTJDMoney]*2)+(TransportJobData[idx][eTJDMoney]/4)));
        if(lSkill > 0)
        {
            format(str, 64, "+ %d skilla", lSkill);
            SendClientMessage(playerid, COLOR_GRAD2, str);
            PlayerInfo[playerid][pTruckSkill]++;
        }

        if(ile != TransportJobData[idx][eTJDMoney]) SendClientMessage(playerid, 0x00FF00FF, "Pami�taj, �e im szybciej jedziesz, tym wi�cej gubisz towaru!");
        TogglePlayerControllable(playerid, 1);
    }
    else
    {
        count++;
        SetTimerEx("TJD_UnloadTime", TJD_LOADUNLOAD_TIME, 0, "iii", playerid, count, maxcount);
    }
}

TJD_DestroyTXD(playerid)
{
    PlayerTextDrawDestroy(playerid, TXD_TJDCounter[playerid]);
    TextDrawHideForPlayer(playerid, TXD_TJDBg);
    TextDrawHideForPlayer(playerid, TXD_TJDImg);

    SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
}

TJD_CreateTXD(playerid)
{
    new str[8];
    format(str, 8, "%d", GetPVarInt(playerid, "transboxes"));
    TXD_TJDCounter[playerid] = CreatePlayerTextDraw(playerid, 574.000000, 114.000000, str);
    PlayerTextDrawAlignment(playerid, TXD_TJDCounter[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, TXD_TJDCounter[playerid], 255);
    PlayerTextDrawFont(playerid, TXD_TJDCounter[playerid], 3);
    PlayerTextDrawLetterSize(playerid, TXD_TJDCounter[playerid], 0.600000, 3.000000);
    PlayerTextDrawColor(playerid, TXD_TJDCounter[playerid], -1);
    PlayerTextDrawSetOutline(playerid, TXD_TJDCounter[playerid], 0);
    PlayerTextDrawSetProportional(playerid, TXD_TJDCounter[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TXD_TJDCounter[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, TXD_TJDCounter[playerid], 0);
    PlayerTextDrawShow(playerid, TXD_TJDCounter[playerid]);
    TextDrawShowForPlayer(playerid, TXD_TJDBg);
    TextDrawShowForPlayer(playerid, TXD_TJDImg);

    SetPlayerWorldBounds(playerid, 1812.0, 1685.0, -2007.0, -2077.0);
}

//--------------------------------------------------

public BBD_Timer()
{
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(!IsPlayerConnected(i)) continue;
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
}

BBD_Turn(id)
{
    if(BoomBoxData[id][BBD_Standby])
    {
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(IsPlayerInRangeOfPoint(i, MAX_BBD_DISTANCE, BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z]))
            {
                if(GetPVarInt(i, "bbdid") != BoomBoxData[id][BBD_ID] || BoomBoxData[id][BBD_Refresh])
                {
                    SetPVarInt(i, "bbdid", BoomBoxData[id][BBD_ID]);
                    PlayAudioStreamForPlayer(i, BoomBoxData[id][BBD_URL], BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z], MAX_BBD_DISTANCE, 1);
                }
            }
        }
    }
    else
    {
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(GetPVarInt(i, "bbdid") == BoomBoxData[id][BBD_ID])
            {
                SetPVarInt(i, "bbdid", 0);
                StopAudioStreamForPlayer(i);
            }
        }
    }
    if(BoomBoxData[id][BBD_Refresh]) BoomBoxData[id][BBD_Refresh] = false;
}

BBD_Pickup(playerid, id)
{
    if(BoomBoxData[id][BBD_Carried]-1 >= 0) return;
    if(BoomBoxData[id][BBD_Standby])
    {
        BoomBoxData[id][BBD_Standby] = false;
        BBD_Turn(id);
        BoomBoxData[id][BBD_Standby] = true;
    }
    BoomBoxData[id][BBD_x] = 0;
    BoomBoxData[id][BBD_y] = 0;
    BoomBoxData[id][BBD_z] = 0;
    BoomBoxData[id][BBD_Carried] = playerid+1;
    SetPVarInt(playerid, "boomboxid", id);

    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_Out", 4.1, 0, 1, 1, 0, 0);

    SetPlayerAttachedObject(playerid, 9, 2226, 5, 0.42, 0.0, 0.0, 90.0, 270.0, 90.0);

    if(BoomBoxData[id][BBD_Obj] != 0) DestroyDynamicObject(BoomBoxData[id][BBD_Obj]);
}

BBD_Putdown(playerid, id)
{
    if(BoomBoxData[id][BBD_Carried]-1 < 0) return;
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    x+=0.9*floatsin(-a, degrees);
    y+=0.9*floatcos(-a, degrees);

    BoomBoxData[id][BBD_x] = x;
    BoomBoxData[id][BBD_y] = y;
    BoomBoxData[id][BBD_z] = z;
    BoomBoxData[id][BBD_Carried] = 0;

    RemovePlayerAttachedObject(playerid, 9);

    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.1, 0, 1, 1, 0, 0);

    BoomBoxData[id][BBD_Obj] = CreateDynamicObject(2226, x, y, z-1.05, 0.0, 0.0, a+180.0);

    if(GetPVarInt(playerid, "zoneid") == -1) return;
    else if(ZoneControl[GetPVarInt(playerid, "zoneid")] != GetPlayerFraction(playerid) && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != GetPlayerOrg(playerid)) return;

    BBD_Turn(id);
}

BBD_GetID()
{
    for(new i=0;i<MAX_BOOMBOX;i++)
    {
        if(BoomBoxData[i][BBD_ID] == 0) return i;
    }
    return -1;
}

public UnhireRentCar(playerid, veh)
{
    //Rent car system
    new caruid;
    if((caruid = VehicleUID[veh][vUID]) == 0) return 1;
    if(CarData[caruid][c_Owner] == RENT_CAR && CarData[caruid][c_OwnerType] == CAR_OWNER_SPECIAL)
    {
        if(CarData[caruid][c_Rang] != 0)
        {
            if(IsPlayerConnected(playerid))
            {
                if(GetPlayerVehicleID(playerid) == veh)
                {
                    SetVehicleVelocity(veh, 0.0, 0.0, 0.0);
                    RemovePlayerFromVehicleEx(playerid);
                    SendClientMessage(playerid, COLOR_YELLOW, "Czas wypo�yczenia min��!");
                }
                SetPVarInt(playerid, "rentTimer", 0);
            }
            CarData[caruid][c_Rang] = 0;
        }
    }
    return 1;
}

forward TourCamera(playerid, step);
public TourCamera(playerid, step)
{
    if(GetPlayerState(playerid) != 0) return 0;
    if(gettime() - GetPVarInt(playerid, "tourcameratick") < 5) return 0;
    SetPVarInt(playerid, "tourcamerastep", step);
    SetPVarInt(playerid, "tourcameratick", gettime());
    if(GetPVarInt(playerid, "tourcameratimer") != 0)
    {
        SetPVarInt(playerid, "tourcameratimer", 0);
        KillTimer(GetPVarInt(playerid, "tourcameratimer"));
    }
    TogglePlayerControllable(playerid, 0);
    new lTime=0;
    switch(step)
    {
        case 0:
        {
            InterpolateCameraPos(playerid, 1854.0327, -1845.7213, 32.9084, 1802.8463, -1853.9320, 24.3721, 12000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 1802.8463, -1853.9320, 24.3721, 1802.0990, -1854.0040, 24.4220, 11000, CAMERA_MOVE);
            SetPlayerPos(playerid, 1802.8463, -1853.9320, 0.0);
            Streamer_UpdateEx(playerid, 1802.8463, -1853.9320, 0.0);
            lTime = 13000;
        }
        case 1:
        {
            InterpolateCameraPos(playerid, 1597.6156, -1731.9628, 22.5997, 1481.4576, -1727.4557, 15.2575, 12000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 1481.4576, -1727.4557, 15.2575, 1481.4741, -1728.4609, 15.6023, 11000, CAMERA_MOVE);
            SetPlayerPos(playerid,1597.6156, -1731.9628, 0.0);
            Streamer_UpdateEx(playerid, 1597.6156, -1731.9628, 0.0);
            lTime = 12000;
        }
        case 2:
        {
            InterpolateCameraPos(playerid, 1330.4507, -1423.9467, 69.1760, 1216.2252, -1343.8439, 18.0992, 15000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 1216.2252, -1343.8439, 18.0992, 1215.3202, -1343.4011, 18.0841, 14000, CAMERA_MOVE);
            SetPlayerPos(playerid, 1216.2252, -1343.8439, 0.0);
            Streamer_UpdateEx(playerid, 1216.2252, -1343.8439, 0.0);
            lTime = 16000;
        }
        case 3:
        {
            InterpolateCameraPos(playerid, 1890.8367, -2133.2148, 31.2670, 1801.7451, -2073.0071, 18.8819, 9000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 1801.7451, -2073.0071, 18.8819, 1800.7998, -2072.6538, 18.7769, 8000, CAMERA_MOVE);
            SetPlayerPos(playerid, 1801.7451, -2073.0071,0.0);
            Streamer_UpdateEx(playerid, 1801.7451, -2073.0071, 0.0);
            lTime = 10000;
        }
        case 4:
        {
            InterpolateCameraPos(playerid, 2212.6924, -1750.6774, 15.7084, 2410.6738, -1750.8768, 15.7241, 15000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 2410.6738, -1750.8768, 15.7241, 2409.6650, -1750.8837, 15.7341, 12000, CAMERA_MOVE);
            SetPlayerPos(playerid, 2410.6738, -1750.8768, 0.0);
            Streamer_UpdateEx(playerid, 2410.6738, -1750.8768, 0.0);
            lTime = 16000;
        }
        case 5:
        {
            SetPlayerCameraPos(playerid,421.1918, -1756.8279, 12.7905);
            SetPlayerCameraLookAt(playerid, 420.8176, -1757.7660, 12.7204);
            SetPlayerPos(playerid, 421.1918, -1756.8279, 0.0);
            Streamer_UpdateEx(playerid, 421.1918, -1756.8279, 0.0);
        }
    }
    if(lTime != 0)
        SetPVarInt(playerid, "tourcameratimer", SetTimerEx("TourCamera", lTime, 0, "dd", playerid, step+1));
    return 1;
}
//--------------------------------------------------


ZaladujSamochody()
{
    new id;
    new randa = random(sizeof(RandCars));
	randa = random(sizeof(RandCars));carselect[0] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[1] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[2] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[3] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[4] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[5] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[6] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[7] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[8] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[9] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[10] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[11] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[12] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[13] = RandCars[randa][0];

    for(new i = 0; i < 165; i++)
	{
        id = AddCar(i);
    }
    CAR_End = id;
    printf("Wczytano %d aut do kradzie�y", CAR_End);
	return 1;
}

Support_ClearTicket(id)
{
    TICKET[id][suppValid] = false;
    SetPVarInt(TICKET[id][suppCaller], "active_ticket", 0);

    foreach(new i : Player)
        if(GetPVarInt(i, "support_dialog") == 1)
            Support_ShowTickets(i);
    return 1;
}

Support_ShowTickets(playerid)
{
    new str[1024], shortname[24];
    for(new i=0;i<MAX_TICKETS;i++)
    {
        if(!TICKET[i][suppValid]) continue;
        if(!IsPlayerConnected(TICKET[i][suppCaller]))
        {
            Support_ClearTicket(i);
            continue;
        }
        strmid(shortname, TICKET[i][suppDesc], 0, 24);

        format(str, sizeof(str), "%s%d %s\t%s\t%s\n", str, i, name_add_tabs(GetNick(TICKET[i][suppCaller])), name_add_tabs(TICKET[i][suppSub]), shortname);
    }
    if(strlen(str) > 10)
    {
        ShowPlayerDialogEx(playerid, D_SUPPORT_LIST, DIALOG_STYLE_LIST, "Zg�oszenia", str, "Wybierz", "Wyjd�");
        SetPVarInt(playerid, "support_dialog", 1);
    }
    else
    {
        if(GetPVarInt(playerid, "support_dialog") == 1)
        {
            ShowPlayerDialogEx(playerid, -1, -1, "-1", "-1", "-1", "-1");
            SetPVarInt(playerid, "support_dialog", 0);
        }
    }
    return 1;
}

name_add_tabs(names[])
{
	new ret[40];
	if(strlen(names) <= 8)	format(ret, sizeof(ret), "%s\t\t", names);
	else			format(ret, sizeof(ret), "%s\t", names);
	return ret;
}

RGBAtoRGB(color)
{
    return (color & ~0xFF) >>> 8;
}

SetPlayerInteriorEx(playerid, int)
{
	SetPlayerInterior(playerid, int);
	PlayerInfo[playerid][pInt] = int;
	return 1;
}

WeaponAC(playerid)
{	
	new weapons[13][2];
 
	for (new i = 0; i <= 12; i++)
	{
		GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
		if(weapons[i][0] != 0 && CheckWeaponAC(playerid, i, weapons[i][0]))
		{
		    if(weapons[i][0] == 46) return false;
			else return i;
		}
	}
	return false;
}

//returns false if no cheat detected
CheckWeaponAC(playerid, slot, gun)
{
	if(slot == 1 && PlayerInfo[playerid][pGun1] != gun) return slot;
	else if(slot == 2 && PlayerInfo[playerid][pGun2] != gun) return slot;
	else if(slot == 3 && PlayerInfo[playerid][pGun3] != gun) return slot;
	else if(slot == 4 && PlayerInfo[playerid][pGun4] != gun) return slot;
	else if(slot == 5 && PlayerInfo[playerid][pGun5] != gun) return slot;
	else if(slot == 6 && PlayerInfo[playerid][pGun6] != gun) return slot;
	else if(slot == 7 && PlayerInfo[playerid][pGun7] != gun) return slot;
	else if(slot == 8 && PlayerInfo[playerid][pGun8] != gun) return slot;
	else if(slot == 9 && PlayerInfo[playerid][pGun9] != gun) return slot;
	else if(slot == 10 && PlayerInfo[playerid][pGun10] != gun) return slot;
	else if(slot == 11 && PlayerInfo[playerid][pGun11] != gun) return slot;
	return 0;
}

WeaponHackCheck(issuerid, weaponid)
{
	if(weaponid == 37 || weaponid == 51 || weaponid == 46)
	{
		
	}
    else if(weaponid > 2 && weaponid < 39)
    {
		return CheckWeaponAC(issuerid, GetWeaponSlot(weaponid), weaponid);
    }
	return false;
}
BuyDrinkOnClub(playerid, const dName[], dCost, dLVL, dAction)
{
	new string[128];
	if(GetPVarInt(playerid, "jestPrzyBarzeVIP") == 1)
	{
		if(kaska[playerid] >= (dCost/2))
		{
			format(string, sizeof(string), "%s kupi� w barze %s - zaczyna pi�", GetNick(playerid), dName);
			ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerDrunkLevel(playerid, dLVL);
			SetPlayerSpecialAction(playerid, dAction);
			ZabierzKaseDone(playerid, (dCost/2));
			Sejf_Add(FRAC_SN, (dCost/2));
		}
		else
		{
			sendErrorMessage(playerid, "Nie masz takiej ilo�ci got�wki!"); 
			return 1;
		}
	}
	else if(GetPVarInt(playerid, "jestPrzyBarzeVIP") == 0)
	{
		if(kaska[playerid] >= dCost)
		{
			format(string, sizeof(string), "%s kupi� w barze %s - zaczyna pi�", GetNick(playerid), dName);
			ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerDrunkLevel(playerid, dLVL);
			SetPlayerSpecialAction(playerid, dAction);
			ZabierzKaseDone(playerid, (dCost));
			Sejf_Add(FRAC_SN, dCost);
		}
		else
		{
			sendErrorMessage(playerid, "Nie masz takiej ilo�ci got�wki!");
			return 1;
		}
	}
	return 1;
}
SetPLocal(playerid, wartosc)
{
	PlayerInfo[playerid][pLocal] = wartosc;
	
	return 1;
}
GetPLocal(playerid)
{
	new wartoscLocalu; 
	wartoscLocalu = PlayerInfo[playerid][pLocal];
	return wartoscLocalu;
}
ShowPersonalization(playerid, value)
{
	new persona_A[64];
	new persona_B[64];
	new persona_C[64];
	new persona_D[64];
	new persona_E[64];
	new string[356]; 
	if(value == 1)
	{
		if(PlayerPersonalization[playerid][PERS_LICZNIK] == 1)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Licznik w pojazdach\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_LICZNIK] == 0)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Licznik w pojazdach\t{80FF00}ON\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_CB] == 1)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "CB-RADIO\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_CB] == 0)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "CB-RADIO\t{80FF00}ON\n", 0);
		}
		format(string, sizeof(string), "%s%s", persona_A, persona_B);
		ShowPlayerDialogEx(playerid, D_PERS_VEH, DIALOG_STYLE_TABLIST, "Kotnik Role Play", string, "Akceptuj", "Wyjdz");
	}
	if(value == 2)
	{
		if(PlayerPersonalization[playerid][PERS_AD] == 1)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Og�oszenia [AD]\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_AD] == 0)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Og�oszenia [AD]\t{80FF00}ON\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_NEWBIE] == 1)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "Newbie Chat\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_NEWBIE] == 0)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "Newbie Chat\t{80FF00}ON\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_FAMINFO] == 1)
		{
			strdel(persona_C, 0, 64);
			strins(persona_C, "Og�oszenia GRUP\t{FF6A6A}OFF\n", 0);	
		}
		else if(PlayerPersonalization[playerid][PERS_FAMINFO] == 0)
		{
			strdel(persona_C, 0, 64);
			strins(persona_C, "Og�oszenia GRUP\t{80FF00}ON\n", 0);	
		}
		if(PlayerPersonalization[playerid][PERS_TALKANIM] == 1)
		{
			strdel(persona_D, 0, 64);
			strins(persona_D, "Animacja m�wienia\t{80FF00}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_TALKANIM] == 0)
		{
			strdel(persona_D, 0, 64);
			strins(persona_D, "Animacja m�wienia\t{80FF00}ON\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_JOINLEAVE] == 1)
		{
			strdel(persona_E, 0, 64);
			strins(persona_E, "Informacja Join/Left\t{80FF00}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_JOINLEAVE] == 0){
			strdel(persona_E, 0, 64);
			strins(persona_E, "Informacja Join/Left\t{80FF00}ON\n", 0);
		}
		format(string, sizeof(string), "%s%s%s%s%s", persona_A, persona_B, persona_C, persona_D, persona_E);
		ShowPlayerDialogEx(playerid, D_PERS_CHAT, DIALOG_STYLE_TABLIST, "Kotnik RP", string, "Akceptuj", "Odrzu�"); 

	}
	if(value == 3)
	{
		if(PlayerPersonalization[playerid][PERS_REPORT] == 1)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Reporty\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_REPORT] == 0)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Reporty\t{80FF00}ON\n ", 0);
		}
		if(PlayerPersonalization[playerid][WARNDEATH] == 1)
		{
			strdel(persona_B, 0, 64); 
			strins(persona_B,"Death Warning\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][WARNDEATH] == 0)
		{
			strdel(persona_B, 0, 64); 
			strins(persona_B,"Death Warning\t{80FF00}ON\n", 0);
		}
		format(string, sizeof(string), "%s%s", persona_A, persona_B);
		ShowPlayerDialogEx(playerid, D_PERS_ADMIN, DIALOG_STYLE_TABLIST, "Kotnik Role Play", string, "Akceptuj", "Wyjdz");
	}
	if(value == 4)
	{
		if(PlayerPersonalization[playerid][PERS_KB] == 0)
		{
			strdel(persona_A, 0, 64); 
			strins(persona_A, "Przelew Kontem Bankowym\t{80FF00}ON\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_KB] == 1)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Przelew Kontem Bankowym\t{FF6A6A}OFF\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_NICKNAMES] == 0)
		{
			strdel(persona_B, 0, 64); 
			strins(persona_B, "Wy�wietlanie nick�w\t{80FF00}ON\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_NICKNAMES] == 1)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "Wy�wietlanie nick�w\t{FF6A6A}OFF\n",0);
		}
		if(PlayerPersonalization[playerid][PERS_KARYTXD] == 0)
		{
			strdel(persona_C, 0, 64);
			strins(persona_C, "Kary w TXD\t{80FF00}ON\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_KARYTXD] == 1)
		{
			strdel(persona_C, 0, 64); 
			strins(persona_C, "Kary w TXD\t{FF6A6A}OFF\n", 0); 
		}
		if(PlayerPersonalization[playerid][PERS_GUNSCROLL] == 0)
		{
			strdel(persona_D, 0, 64);
			strins(persona_D, "Auto-GUI po zmianie broni\t{80FF00}ON\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_GUNSCROLL] == 1)
		{
			strdel(persona_D, 0, 64); 
			strins(persona_D, "Auto-GUI po zmianie broni\t{FF6A6A}OFF\n", 0); 
		}
		format(string, sizeof(string), "%s%s%s%s", persona_A, persona_B, persona_C, persona_D);
		ShowPlayerDialogEx(playerid, D_PERS_INNE, DIALOG_STYLE_TABLIST, "Kotnik Role Play", string, "Akceptuj", "Wyjdz"); 
	}
		 
	return 1;
}

stock SetPlayerTW(playerid, valueTime, time, weather)
{
	SetTAWForPlayer[playerid] = SetTimerEx("SetTimeAndWeather", valueTime,0,"d",playerid);
	SetPVarInt(playerid, "TimeToSet", time); 
	SetPVarInt(playerid, "WeatherToSet", weather); 
	sendTipMessage(playerid, "Trwa inicjowanie pogody i czasu - chwil� to potrwa!"); 
	return 1;
}

forward OnPlayerTakeDamageWeaponHack(playerid, weaponid, fakekillid);
public OnPlayerTakeDamageWeaponHack(playerid, weaponid, fakekillid)
{
	if(WeaponHackCheck(playerid, weaponid) > 0 && PlayerInfo[playerid][pAdmin] < 1 && IsPlayerConnected(fakekillid) && PlayerInfo[fakekillid][pLevel] > 1)
	{
		new string[128];
		format(string, sizeof string, "ACv2 [#2002]: %s mo�e mie� weapon hack. | Je�li fakekill, to: %s .", GetNickEx(playerid), GetNickEx(fakekillid));
		SendCommandLogMessage(string);
		Log(warningLog, WARNING, string);
		return 1;
	}
	return 0;
}
RespawnVehicleEx(vehID)
{
	if((CarData[VehicleUID[vehID][vUID]][c_Owner] == FRAC_KT && CarData[VehicleUID[vehID][vUID]][c_OwnerType] == CAR_OWNER_FRACTION && (CarData[VehicleUID[vehID][vUID]][c_Model] == 530 || CarData[VehicleUID[vehID][vUID]][c_Model] == 578)) || 
	   (CarData[VehicleUID[vehID][vUID]][c_Owner] == JOB_PIZZA && CarData[VehicleUID[vehID][vUID]][c_OwnerType] == CAR_OWNER_JOB))
	{
		SetVehicleHealth(vehID, 1000.0);
		
	}
	if(CarData[VehicleUID[vehID][vUID]][c_OwnerType] == CAR_OWNER_FRACTION)
	{
		Gas[vehID] = 100;
	}
	
	SetVehicleToRespawn(vehID);
	SetVehicleVirtualWorld(vehID, CarData[VehicleUID[vehID][vUID]][c_VW]);
	return 1;
}
SetWeaponValue(playerid, slot, weaponid, ammo, legal) //do usuniecia po modyfikacji antycheata od weapon hacka
{
	switch(slot)
	{
		case 0: {PlayerInfo[playerid][pGun0] = weaponid; PlayerInfo[playerid][pAmmo0] = ammo; playerWeapons[playerid][weaponLegal1] = legal;}
		case 1: {PlayerInfo[playerid][pGun1] = weaponid; PlayerInfo[playerid][pAmmo1] = ammo; playerWeapons[playerid][weaponLegal2] = legal;}
		case 2: {PlayerInfo[playerid][pGun2] = weaponid; PlayerInfo[playerid][pAmmo2] = ammo; playerWeapons[playerid][weaponLegal3] = legal;}
		case 3: {PlayerInfo[playerid][pGun3] = weaponid; PlayerInfo[playerid][pAmmo3] = ammo; playerWeapons[playerid][weaponLegal4] = legal;}
		case 4: {PlayerInfo[playerid][pGun4] = weaponid; PlayerInfo[playerid][pAmmo4] = ammo; playerWeapons[playerid][weaponLegal5] = legal;}
		case 5: {PlayerInfo[playerid][pGun5] = weaponid; PlayerInfo[playerid][pAmmo5] = ammo; playerWeapons[playerid][weaponLegal6] = legal;}
		case 6: {PlayerInfo[playerid][pGun6] = weaponid; PlayerInfo[playerid][pAmmo6] = ammo; playerWeapons[playerid][weaponLegal7] = legal;}
		case 7: {PlayerInfo[playerid][pGun7] = weaponid; PlayerInfo[playerid][pAmmo7] = ammo; playerWeapons[playerid][weaponLegal8] = legal;}
		case 8: {PlayerInfo[playerid][pGun8] = weaponid; PlayerInfo[playerid][pAmmo8] = ammo; playerWeapons[playerid][weaponLegal9] = legal;}
		case 9: {PlayerInfo[playerid][pGun9] = weaponid; PlayerInfo[playerid][pAmmo9] = ammo; playerWeapons[playerid][weaponLegal10] = legal;}
		case 10: {PlayerInfo[playerid][pGun10] = weaponid; PlayerInfo[playerid][pAmmo10] = ammo; playerWeapons[playerid][weaponLegal11] = legal;}
		case 11: {PlayerInfo[playerid][pGun11] = weaponid; PlayerInfo[playerid][pAmmo11] = ammo; playerWeapons[playerid][weaponLegal12] = legal;}
		case 12: {PlayerInfo[playerid][pGun12] = weaponid; PlayerInfo[playerid][pAmmo12] = ammo; playerWeapons[playerid][weaponLegal13] = legal;}
	}
	return 1;
}
GetWeaponSlot(weapon)
{
    new slot;
    switch (weapon)
    {
        case 0: slot = 0;
        case 1: slot = 0;
        case 2: slot = 1;
        case 3: slot = 1;
        case 4: slot = 1;
        case 5: slot = 1;
        case 6: slot = 1;
        case 7: slot = 1;
        case 8: slot = 1;
        case 9: slot = 1;
        case 22: slot = 2;
        case 23: slot = 2;
        case 24: slot = 2;
        case 25: slot = 3;
        case 26: slot = 3;
        case 27: slot = 3;
        case 28: slot = 4;
        case 29: slot = 4;
        case 32: slot = 4;
        case 30: slot = 5;
        case 31: slot = 5;
        case 33: slot = 6;
        case 34: slot = 6;
        case 35: slot = 7;
        case 36: slot = 7;
        case 37: slot = 7;
        case 38: slot = 7;
        case 16: slot = 8;
        case 17: slot = 8;
        case 18: slot = 8;
        case 39: slot = 8;
        case 41: slot = 9;
        case 42: slot = 9;
        case 43: slot = 9;
        case 10: slot = 10;
        case 11: slot = 10;
        case 12: slot = 10;
        case 13: slot = 10;
        case 14: slot = 10;
        case 15: slot = 10;
        case 44: slot = 11;
        case 45: slot = 11;
        case 46: slot = 11;
        case 40: slot = 12;
		default: slot = 0;
    }
    return slot;
}

stock GetVehicleDriverID(vehicleid)
{
    foreach(new i : Player) 
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(i, vehicleid))
		{
			return i;
		}
	}
    return -1;
}  

stock IsVehicleRangeOfPoint(vehicleid,Float:range,Float:x,Float:y,Float:z)
{
    if(vehicleid == INVALID_VEHICLE_ID) return 0;
    return GetVehicleDistanceFromPoint(vehicleid, x, y, z) <= range;
}  

stock GetClosestCar(playerid, Float:Prevdist=5.0)
{
	new Prevcar = -1;
	for(new carid = 0; carid < MAX_VEHICLES; carid++)
	{
		new Float:Dist = GetDistanceToCar(playerid,carid);
		if((Dist < Prevdist))
		{
			Prevdist = Dist;
			Prevcar = carid;
		}
	}
	return Prevcar;
} 
stock GetDistanceToCar(playerid, carid)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,Float:Dis;
	if (!IsPlayerConnected(playerid))return -1;
	GetPlayerPos(playerid,x1,y1,z1);GetVehiclePos(carid,x2,y2,z2);
	Dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(Dis);
}

SavePlayerSentMessage(playerid, message[], MessageType:type)
{
	new idx = SentMessagesIndex[playerid];
	format(SentMessages[playerid][idx], 144, "%s", message);
	SentMessagesType[playerid][idx] = type;
	SentMessagesIndex[playerid] = (idx+1) % MAX_SENT_MESSAGES;
}

ShowPlayerSentMessages(playerid, forplayerid, max=MAX_SENT_MESSAGES)
{
	SendClientMessage(forplayerid, COLOR_WHITE, sprintf("--- Ostatnie wiadomo�ci gracza %s: ---", GetNick(playerid)));
	new index = SentMessagesIndex[playerid];
	new count;
	for(new i = index; i < MAX_SENT_MESSAGES; i++) {
		if(strlen(SentMessages[playerid][i])) {
			SendClientMessage(forplayerid, (SentMessagesType[playerid][i] == TOME ? COLOR_NEWS : COLOR_YELLOW), SentMessages[playerid][i]);
			if(++count > max)  return;
		}
	}

	for(new i; i < index; i++) {
		if(strlen(SentMessages[playerid][i])) {
			SendClientMessage(forplayerid, (SentMessagesType[playerid][i] == TOME ? COLOR_NEWS : COLOR_YELLOW), SentMessages[playerid][i]);
			if(++count > max)  return;
		}
	}
}

SavePlayerDamaged(playerid, attackerid, Float:damage, weapon)
{
	new hour, minute, second;
	new sec = gettime() + 7200;
	new day;
    day = floatround(sec / 86400);
    hour = floatround((sec - (day * 86400)) / 3600);
    minute = floatround((sec - (day * 86400) - (hour * 3600)) / 60);
    second = sec % 60;
	new idx = ObrazeniaIndex[playerid];
	format(Obrazenia[playerid][idx][ATTACKER], MAX_PLAYER_NAME, "%s", GetNick(attackerid));
	Obrazenia[playerid][idx][DAMAGE] = damage;
	Obrazenia[playerid][idx][WEAPONID] = weapon;
	Obrazenia[playerid][idx][HOURS] = hour;
	Obrazenia[playerid][idx][MINUTES] = minute;
	Obrazenia[playerid][idx][SECONDS] = second;
	ObrazeniaIndex[playerid] = (idx+1) % 20;
}

SavePlayerDamage(playerid, defenderid, Float:damage, weapon)
{
	new hour, minute, second;
	new sec = gettime() + 7200;
	new day;
    day = floatround(sec / 86400);
    hour = floatround((sec - (day * 86400)) / 3600);
    minute = floatround((sec - (day * 86400) - (hour * 3600)) / 60);
    second = sec % 60;
	new idx = ObrazeniaZadaneIndex[playerid];
	format(ObrazeniaZadane[playerid][idx][DEFENDER], MAX_PLAYER_NAME, "%s", GetNick(defenderid));
	ObrazeniaZadane[playerid][idx][DAMAGE] = damage;
	ObrazeniaZadane[playerid][idx][WEAPONID] = weapon;
	ObrazeniaZadane[playerid][idx][HOURS] = hour;
	ObrazeniaZadane[playerid][idx][MINUTES] = minute;
	ObrazeniaZadane[playerid][idx][SECONDS] = second;
	ObrazeniaZadaneIndex[playerid] = (idx+1) % 20;
}

ShowPlayerDamaged(playerid, forplayerid)
{
	SendClientMessage(forplayerid, COLOR_WHITE, sprintf("--- Damagelog gracza %s: ---", GetNick(playerid)));
	new index = ObrazeniaIndex[playerid];
	new string[72];
	new weapon_decoded[24];
	new godzina,minuta,sekunda,Float:hp;
	new atakujacy[MAX_PLAYER_NAME];
	if(index != 0) 
	{
		for(new i = index-1; i>=0; i--)
		{
			hp = Obrazenia[playerid][i][DAMAGE];
			if(hp <= 0.1) continue;
			switch(Obrazenia[playerid][i][WEAPONID])
			{
				case 0..42: format(weapon_decoded, sizeof(weapon_decoded), "%s", GunNames[Obrazenia[playerid][i][WEAPONID]]);
				default: format(weapon_decoded, sizeof(weapon_decoded), "[WeaponID %d]", Obrazenia[playerid][i][WEAPONID]);
			}
			godzina = Obrazenia[playerid][i][HOURS];
			minuta = Obrazenia[playerid][i][MINUTES];
			sekunda = Obrazenia[playerid][i][SECONDS];			
			format(atakujacy, sizeof(atakujacy), "%s", Obrazenia[playerid][i][ATTACKER]);
			format(string, sizeof(string), "%d:%d:%d | %s zada� mu %0.1fHP z %s[%d]", godzina, minuta, sekunda, atakujacy, hp, weapon_decoded, Obrazenia[playerid][i][WEAPONID]);
			SendClientMessage(forplayerid, COLOR_LIGHTGREEN, string);
		}
	}
	for(new i= 19; i >= index; i--) 
	{
		hp = Obrazenia[playerid][i][DAMAGE];
		if(hp <= 0.1) continue;
		switch(Obrazenia[playerid][i][WEAPONID])
		{
			case 0..42: format(weapon_decoded, sizeof(weapon_decoded), "%s", GunNames[Obrazenia[playerid][i][WEAPONID]]);
			default: format(weapon_decoded, sizeof(weapon_decoded), "[WeaponID %d]", Obrazenia[playerid][i][WEAPONID]);
		}
		godzina = Obrazenia[playerid][i][HOURS];
		minuta = Obrazenia[playerid][i][MINUTES];
		sekunda = Obrazenia[playerid][i][SECONDS];
		hp = hp/2;
		format(atakujacy, sizeof(atakujacy), "%s", Obrazenia[playerid][i][ATTACKER]);
		format(string, sizeof(string), "%d:%d:%d | %s zada� mu %0.1fHP z %s[%d]", godzina, minuta, sekunda, atakujacy, hp, weapon_decoded, Obrazenia[playerid][i][WEAPONID]);
		SendClientMessage(forplayerid, COLOR_LIGHTGREEN, string);
	}
	return 1;
}

ShowPlayerDamage(playerid, forplayerid)
{
	SendClientMessage(forplayerid, COLOR_WHITE, sprintf("--- Damagelog gracza %s: ---", GetNick(playerid)));
	new index = ObrazeniaZadaneIndex[playerid];
	new string[72];
	new weapon_decoded[24];
	new godzina,minuta,sekunda,Float:hp;
	new broniacy[MAX_PLAYER_NAME];
	if(index != 0) 
	{
		for(new i = index-1; i>=0; i--)
		{
			hp = ObrazeniaZadane[playerid][i][DAMAGE];
			if(hp <= 0.1) continue;
			switch(ObrazeniaZadane[playerid][i][WEAPONID])
			{
				case 0..42: format(weapon_decoded, sizeof(weapon_decoded), "%s", GunNames[ObrazeniaZadane[playerid][i][WEAPONID]]);
				default: format(weapon_decoded, sizeof(weapon_decoded), "[WeaponID %d]", ObrazeniaZadane[playerid][i][WEAPONID]);
			}
			godzina = ObrazeniaZadane[playerid][i][HOURS];
			minuta = ObrazeniaZadane[playerid][i][MINUTES];
			sekunda = ObrazeniaZadane[playerid][i][SECONDS];
			format(broniacy, sizeof(broniacy), "%s", ObrazeniaZadane[playerid][i][DEFENDER]);
			format(string, sizeof(string), "%d:%d:%d | zada� %0.1fHP graczowi %s z %s[%d]", godzina, minuta, sekunda, hp, broniacy, weapon_decoded, Obrazenia[playerid][i][WEAPONID]);
			SendClientMessage(forplayerid, COLOR_LIGHTGREEN, string);
		}
	}
	for(new i= 19; i >= index; i--) 
	{
		hp = ObrazeniaZadane[playerid][i][DAMAGE];
		if(hp <= 0.1) continue;
		switch(ObrazeniaZadane[playerid][i][WEAPONID])
		{
			case 0..42: format(weapon_decoded, sizeof(weapon_decoded), "%s", GunNames[ObrazeniaZadane[playerid][i][WEAPONID]]);
			default: format(weapon_decoded, sizeof(weapon_decoded), "[WeaponID %d]", ObrazeniaZadane[playerid][i][WEAPONID]);
		}
		godzina = ObrazeniaZadane[playerid][i][HOURS];
		minuta = ObrazeniaZadane[playerid][i][MINUTES];
		sekunda = ObrazeniaZadane[playerid][i][SECONDS];
		format(broniacy, sizeof(broniacy), "%s", ObrazeniaZadane[playerid][i][DEFENDER]);
		format(string, sizeof(string), "%d:%d:%d | zada� %0.1fHP graczowi %s z %s[%d]", godzina, minuta, sekunda, hp, broniacy, weapon_decoded, Obrazenia[playerid][i][WEAPONID]);
		SendClientMessage(forplayerid, COLOR_LIGHTGREEN, string);
	}
	return 1;
}


IsReasonAPursuitReason(result[])
{
	return (strfind(result, "ucieczka", true) != -1 || strfind(result, "poscig", true) != -1 || strfind(result, "po�cig", true) != -1 || strfind(result, "ucieka", true) != -1);
}

PursuitMode(playerid, giveplayerid)
{
	if(ProxDetectorS(80.0, playerid, giveplayerid))
	{
		if(poscig[giveplayerid] != 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"Rozpocz��e� po�cig! Trwa on 10 minut.");
			SendClientMessage(giveplayerid,COLOR_PANICRED,"|_________________Tryb Po�cigu_________________|");
			SendClientMessage(giveplayerid,COLOR_WHITE,"S�u�by porz�dkowe ruszy�y za tob� w po�cig! W takim wypadku najlepiej si� podda�!");
			SendClientMessage(giveplayerid,COLOR_WHITE,"W trybie po�cigu nie mozesz wyj�� z gry, zgin�� oraz by� AFK.");
			SendClientMessage(giveplayerid,COLOR_WHITE,"Z�amanie tych zasad skutkuje kar� nadawan� automatycznie.");
			SendClientMessage(giveplayerid,COLOR_PANICRED,"|______________________________________________|");
			poscig[giveplayerid] = 1;
			SetTimerEx("PoscigTimer",10*60000,0,"d",giveplayerid);
		}
	}
	else
	{
		sendErrorMessage(playerid, "Gracz jest za daleko by nada� mu tryb po�cigu.");
	}
}

public DeathAdminWarning(playerid, killerid, reason)
{
	new killername[MAX_PLAYER_NAME];
	new string[144];

	if((!IsPlayerConnected(playerid) || !gPlayerLogged[playerid]) || (IsPlayerConnected(killerid) && !gPlayerLogged[killerid])) return 1;
	if(killerid != INVALID_PLAYER_ID)
	{
		GetPlayerName(killerid, killername, sizeof(killername));
		new bwreason[24];
		if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
		{
			//-------<[  Logi  ]>---------
			Log(warningLog, WARNING, "%s %s %s z broni o id %d b�d�c w aucie (mo�liwe DB/CK2).", GetPlayerLogName(killerid), bwreason, GetPlayerLogName(playerid), reason);
			SendClientMessage(killerid, COLOR_YELLOW, "DriveBy jest zakazane, robi�c DriveBy mo�esz zosta� ukarany przez admina!");
			if(PlayerInfo[killerid][pLevel] > 1)
			{
				format(string, sizeof(string), "AdmWarning: %s[%d] %s %s[%d] b�d� w aucie (mo�liwe DB/CK2) [GunID %d]!", killername, killerid, bwreason, GetNick(playerid), playerid, reason);
				SendMessageToAdmin(string, COLOR_YELLOW);
			}
			else
			{
				format(string, sizeof(string), "AdmWarning: %s[%d] %s %s[%d] z DB, dosta� kicka !", killername, killerid, bwreason, GetNick(playerid), playerid);
				SendMessageToAdmin(string, COLOR_YELLOW);
				Log(punishmentLog, WARNING, "Gracz %s dosta� kicka od systemu za Drive-By", GetPlayerLogName(killerid));
				SendClientMessage(killerid, COLOR_PANICRED, "Dosta�e� kicka za Drive-By do ludzi.");
				KickEx(killerid);
				SetPVarInt(playerid, "skip_bw", 1);
				return 1;
			}
		}
		else
		{
			switch(reason)
			{
				case 38:
				{
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) != 425)
					{
						format(string, sizeof(string), "AdmWarning: %s[%d] %s %s[%d] z miniguna, podejrzane !", killername, killerid, bwreason, GetNick(playerid), playerid);
						SendMessageToAdmin(string, COLOR_YELLOW);
						Log(warningLog, WARNING, "%s zabi� gracza %s u�ywaj�c miniguna", GetPlayerLogName(killerid), GetPlayerLogName(playerid));
						SendMessageToAdminEx(string, COLOR_P@, 2);
					}
					else if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						format(string, sizeof(string), "{FF66CC}DeathWarning: {FFFFFF}%s[%d] %s %s[%d] z Huntera",  killername, killerid, bwreason, GetNick(playerid), playerid);
						SendMessageToAdminEx(string, COLOR_P@, 2);
					}
				}
				case 41:
				{
					//-------<[  Logi  ]>---------
					format(string, sizeof(string), "AdmWarning: %s[%d] %s %s[%d] ze spreya!", killername, killerid, bwreason, GetNick(playerid), playerid);
					SendMessageToAdmin(string, COLOR_YELLOW);
					Log(warningLog, WARNING, "%s %s gracza %s u�ywaj�c spray'a", GetPlayerLogName(killerid), bwreason, GetPlayerLogName(playerid));
					SendMessageToAdminEx(string, COLOR_P@, 2);
				}
				default:
				{
					if(reason <= 54 && reason > 0)
					{
						format(string, sizeof(string), "{FF66CC}DeathWarning: {FFFFFF}%s[%d] %s %s[%d] z %s", killername, killerid, bwreason, GetNick(playerid), playerid, (reason <= 46) ? GunNames[reason] : DeathNames[reason-46]);
						SendMessageToAdminEx(string, COLOR_P@, 2);
					}	
					if(GetPVarInt(playerid, "skip_bw")  == 0)
					{
						if(PlayerInfo[playerid][pInjury] > 0)
						{
							if(lowcaz[killerid] == playerid && lowcap[playerid] != killerid && poddaje[playerid] != 1)
							{
								format(string, sizeof(string), "AdmWarning: �owca Nagr�d %s[%d] %s %s[%d] bez oferty /poddajsie !", killername, killerid, bwreason, GetNick(playerid), playerid);
								SendMessageToAdmin(string, COLOR_YELLOW);
								Log(warningLog, WARNING, "�owca nagr�d %s %s gracza %s bez oferty /poddajsie", GetPlayerLogName(killerid), bwreason, GetPlayerLogName(playerid));
							}

						}
					}	
				}
			}
		}
	}
	else
	{
		if(reason <= 54 && reason > 0)
		{
			format(string, sizeof(string), "{FF66CC}DeathWarning: %s [%d] umar� (%s)", GetNick(playerid), playerid, (reason <= 46) ? GunNames[reason] : DeathNames[reason-46]);
			SendMessageToAdminEx(string, COLOR_P@, 2);
		}
	}
	return 1;
}

public CuffedAction(playerid, cuffedid)
{
	Kajdanki_JestemSkuty[cuffedid] = 1;
	Kajdanki_Uzyte[playerid] = 1;
	Kajdanki_PDkuje[cuffedid] = playerid;
	Kajdanki_SkutyGracz[playerid] = cuffedid;
	ClearAnimations(cuffedid);
	SetPlayerSpecialAction(cuffedid, SPECIAL_ACTION_CUFFED);
	SetPlayerAttachedObject(cuffedid, 5, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977,-81.700035, 0.891999, 1.000000, 1.168000);
	SetTimerEx("UzyteKajdany",30000,0,"d",cuffedid);
	SetTimerEx("Kajdanki_debug", 1000, 0, "d", cuffedid);
	return 1;
}

forward TimeUpdater();
public TimeUpdater()
{
    new Hour, Minute;
	gettime(Hour, Minute);
    format(realtime_string, 32, "%02d:%02d", Hour, Minute);
    TextDrawSetString(RealtimeTXD, realtime_string);
}

//--------------------------------------------------

public AddsOn()
{
	adds=1;
	return 1;
}

LoadGreenZonesForPlayer(playerid)
{
	for(new i = 0; i<sizeof(GreenZones); i++)
	{
		GangZoneShowForPlayer(playerid, GreenZones[i], COLOR_GREEN);
	}
}

PrintDutyTime(playerid, reset = 1)
{
	new minuty = 0, godziny = 0, sekundy = PlayerInfo[playerid][pDutyTime], string[356];
	godziny = floatround( sekundy / 3600 );
	minuty = floatround( sekundy / 60 % 60 );
	format(string, sizeof(string), "[DUTY] Sp�dzi�e� na s�u�bie %d minut %d godzin.", minuty, godziny);
	SendClientMessage(playerid, COLOR_GREEN, string);
	if(reset)
	{
		sendTipMessage(playerid, "Tw�j czas na s�u�bie zostanie wyzerowany za 15 minut.");
		SetPVarInt(playerid, "reset-dutytime", gettime()+900);
		if(OnDuty[playerid] > 0)
		{
			new orgid = GetPlayerGroupUID(playerid, OnDuty[playerid]-1);
			Log(serverLog, WARNING, "%s sp�dzi� na s�u�bie %d minut %d godzin [%s]", GetPlayerLogName(playerid), minuty, godziny, GetGroupLogName(orgid));
		}
	}
	return 1;
}

IsNearGroupVehicle(playerid, grupa)
{
	new Float:x, Float:y, Float:z;
	foreach(new i : Vehicle)
	{
		GetVehiclePos(i, x, y, z);
		if(!Car_IsValid(i)) continue;
		if(GetPlayerDistanceFromPoint(playerid, x, y, z) > 2.75) continue;
		if(Car_GetOwnerType(i) == CAR_OWNER_GROUP && Car_GetOwner(i) == grupa)
		{
			return 1;
		}
	}
	return 0;
}

stock ApplyInverseRotation(&Float:x, &Float:y, &Float:z, Float:rx, Float:ry, Float:rz)  
{
	new Float:DEG2RAD = (3.14159265 * 2) / 360;

	rx = rx * DEG2RAD;
	ry = ry * DEG2RAD;
	rz = rz * DEG2RAD;

	new Float: tempY = y;
	y = floatcos ( rx ) * tempY + floatsin ( rx ) * z;
	z = -floatsin ( rx ) * tempY + floatcos ( rx ) * z;

	new Float: tempX = x;
	x = floatcos ( ry ) * tempX - floatsin ( ry ) * z;
	z = floatsin ( ry ) * tempX + floatcos ( ry ) * z;

	tempX = x;
	x = floatcos ( rz ) * tempX + floatsin ( rz ) * y;
	y = -floatsin ( rz ) * tempX + floatcos ( rz ) * y;
}

stock GetVehicleRealRotation(vehicleid,&Float:rx,&Float:ry,&Float:rz){
	new Float:qw,Float:qx,Float:qy,Float:qz;
	GetVehicleRotationQuat(vehicleid,qw,qx,qy,qz);
	rx = asin(2*qy*qz-2*qx*qw);
	ry = -atan2(qx*qz+qy*qw,0.5-qx*qx-qy*qy);
	rz = -atan2(qx*qy+qz*qw,0.5-qx*qx-qz*qz);
}

stock AttachDyn3DTextLabelToVehicle(Text3D:labelid, vehicleid, Float:offsetx, Float:offsety, Float:offsetz)
{
    Streamer_SetIntData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACHED_VEHICLE, vehicleid);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_X, offsetx);
    Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_Y, offsety);
    return Streamer_SetFloatData(STREAMER_TYPE_3D_TEXT_LABEL, labelid, E_STREAMER_ATTACH_OFFSET_Z, offsetz);
}

ShowNewRadio(playerid)
{
	new string[1024];
	for(new i = 0; i < sizeof Radio; i++){
		new buffer[128];
		format(buffer, sizeof buffer, "%s\n", Radio[i][0]);
		strcat(string, buffer);
	}
	ShowPlayerDialogEx(playerid, D_NEWRADIO, DIALOG_STYLE_LIST, "Radio", string, "Wybierz", "Wyjd�");
}

stock Float:GetPointAngleToPoint(Float:x2, Float:y2, Float:X, Float:Y) {

	new Float:DX, Float:DY;
  	new Float:angle;

  	DX = floatabs(floatsub(x2,X));
  	DY = floatabs(floatsub(y2,Y));

  	if (DY == 0.0 || DX == 0.0) {
    	if(DY == 0 && DX > 0) angle = 0.0;
    	else if(DY == 0 && DX < 0) angle = 180.0;
    	else if(DY > 0 && DX == 0) angle = 90.0;
    	else if(DY < 0 && DX == 0) angle = 270.0;
    	else if(DY == 0 && DX == 0) angle = 0.0;
  	}
  	else {
    	angle = atan(DX/DY);

    	if(X > x2 && Y <= y2) angle += 90.0;
    	else if(X <= x2 && Y < y2) angle = floatsub(90.0, angle);
    	else if(X < x2 && Y >= y2) angle -= 90.0;
    	else if(X >= x2 && Y > y2) angle = floatsub(270.0, angle);
  	}

  	return floatadd(angle, 90.0);
}

stock GetXYInFrontOfPoint(&Float:x, &Float:y, Float:angle, Float:distance) {
	x += (distance * floatsin(-angle, degrees));
	y += (distance * floatcos(-angle, degrees));
}

stock IsPlayerAimingAt(playerid, Float:x, Float:y, Float:z, Float:radius) {
  	new Float:camera_x,Float:camera_y,Float:camera_z,Float:vector_x,Float:vector_y,Float:vector_z;
  	GetPlayerCameraPos(playerid, camera_x, camera_y, camera_z);
  	GetPlayerCameraFrontVector(playerid, vector_x, vector_y, vector_z);

	new Float:vertical, Float:horizontal;

	switch (GetPlayerWeapon(playerid)) {
	  	case 34,35,36: {
	  		if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, vector_x, vector_y, vector_z) < radius) return true;
	  		return false;
		}
		case 30,31: {vertical = 4.0; horizontal = -1.6;}
		case 33: {vertical = 2.7; horizontal = -1.0;}
	  	default: {vertical = 6.0; horizontal = -2.2;}
	}

  	new Float:angle = GetPointAngleToPoint(0, 0, floatsqroot(vector_x*vector_x+vector_y*vector_y), vector_z) - 270.0;
  	new Float:resize_x, Float:resize_y, Float:resize_z = floatsin(angle+vertical, degrees);
  	GetXYInFrontOfPoint(resize_x, resize_y, GetPointAngleToPoint(0, 0, vector_x, vector_y)+horizontal, floatcos(angle+vertical, degrees));
  


  	if (DistanceCameraTargetToLocation(camera_x, camera_y, camera_z, x, y, z, resize_x, resize_y, resize_z) < radius) return true;
  	return false;
} 

ConvertHexToRGBA(hex[])
{
	for(new i=0;i<6;i++)
	{
		hex[i]=toupper(hex[i]);
		if(hex[i]< '0' || (hex[i]>'9' && hex[i] < 'A') || hex[i] > 'F')
			return 0;
		if(hex[i]>60)
			hex[i]-=55;
		else
			hex[i]-=48;
	}
	new rgba = hex[0] * 268435456 + hex[1] * 16777216 + hex[2] * 1048576 + hex[3] *65536 + hex[4] * 4096 + hex[5] * 256 + 255;
	return rgba;
}

ShowDeskaRozdzielcza(playerid)
{
	new veh = GetPlayerVehicleID(playerid);
	new engine,lights,alarm,doors,bonnet,boot,objective;

	new taknieL[16];
	new taknieBON[16];
	new taknieBOT[16];
	new komunikat[256];
	GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
	if(lights == 1) format(taknieL, sizeof(taknieL), "Wy��cz");
	else format(taknieL, sizeof(taknieL), "W��cz");
	if(bonnet == 1) format(taknieBON, sizeof(taknieBON), "Zamknij");
	else format(taknieBON, sizeof(taknieBON), "Otw�rz");
	if(boot == 1) format(taknieBOT, sizeof(taknieBOT), "Zamknij");
	else format(taknieBOT, sizeof(taknieBOT), "Otw�rz");
	format(komunikat, sizeof(komunikat), "�wiat�a (%s)\nMaska (%s)\nBaga�nik (%s)", taknieL, taknieBON, taknieBOT); // max. 79char
	if(veh > CAR_End)
	{
		if(CarData[VehicleUID[veh][vUID]][c_Neon] != 0)
		{
			new taknieNeo[16];
			if(VehicleUID[veh][vNeon]) format(taknieNeo, sizeof(taknieNeo), "Wy��cz");
			else format(taknieNeo, sizeof(taknieNeo), "W��cz");
			format(komunikat, sizeof(komunikat), "%s\nNeony (%s)", komunikat, taknieNeo); //+ 15char
		}
	}

	format(komunikat, sizeof(komunikat), "%s\nRadio\nWlasny Stream\nWy��cz radio", komunikat); //+ 35char
	ShowPlayerDialogEx(playerid, 666, DIALOG_STYLE_LIST, "Deska rozdzielcza", komunikat, "Wybierz", "Anuluj");
	return 1;
}

SetTrunkState(playerid, vehicleid, op, action = 1)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, op, objective);
	if(op && action) RunCommand(playerid, "ja", "otwiera baga�nik");
	else if(action)	 RunCommand(playerid, "ja", "zamyka baga�nik");
	return 1;
}

BeginnerCarDialog(playerid)
{
	if(CountPlayerCars(playerid) > 0) return 0;
	ShowPlayerDialogEx(playerid, NOWY_GRACZ_POJAZD, DIALOG_STYLE_PREVIEW_MODEL, "Wybor startowego pojazdu", "481\tBMX\n509\tRower\n462\tFaggio", "Wybierz", #);
	return 1;
}

UpdateRybyTop()
{
	new lQuery[1024], RybyTopString[1024];
	new nick[24], biggest;
	mysql_query("SELECT `Nick`, `BiggestFish` FROM `mru_konta` ORDER BY `BiggestFish` DESC LIMIT 10");
    mysql_store_result();
	format(RybyTopString, sizeof(RybyTopString), "{279127}Najwi�ksze ryby:\n");
    while(mysql_fetch_row_format(lQuery, "|"))
    {
    	sscanf(lQuery, "p<|>s[24]d",
    	nick,
		biggest);
		printf("Nick: %s", nick);
		
		format(RybyTopString, sizeof(RybyTopString), "%s\n{0080FF}%s {FFFFFF}: %dg", RybyTopString, ret_strreplace(nick, "_", " "), biggest);
    }
    mysql_free_result();
    UpdateDynamic3DTextLabelText(RybyTop, COLOR_WHITE, RybyTopString);
}

forward UpdateCarInfo(playerid);
public UpdateCarInfo(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	new speed = GetVehicleSpeed(vehicleid);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && GetPlayerState(playerid) != PLAYER_STATE_PASSENGER)
	{
		SpeedoHide(playerid);
	}

	new speed_upd[20];
 	new Float:health;
    new veh = vehicleid;
    GetVehicleHealth(veh, health);
	format(speed_upd, 20, "%.0f",(health)/10);
	PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][2],speed_upd);//health

	format(speed_upd, 20, "%d",Gas[vehicleid]);
	PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][3],speed_upd);//fuel

	format(speed_upd, 20, "%d",speed);
	PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][5],speed_upd);//speed
    switch(floatround((health)/10))
	{
	    case 0..9:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],  "-");//1
	    case 10..19:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],"--");//2
	    case 20..29:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],"---");//3
	    case 30..39:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],"----");//4
	    case 40..49:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],"-----");//5
	    case 50..59:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],"------");///6
        case 60..69:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],"-------");//7
        case 70..79:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],"--------");//8
        default:    PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][1],"---------");//9
	}
	switch(Gas[vehicleid])
	{
	    case 0..12:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0],  "-");//1
	    case 13..24:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0], "--");//2
	    case 25..36:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0], "---");//3
	    case 37..48:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0], "----");//4
	    case 49..60:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0], "-----");//5
	    case 61..72:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0], "------");//6
        case 73..84:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0], "-------");//7
        case 85..96:PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0], "--------");//8
        default: PlayerTextDrawSetString(playerid,SpeedometerPDP[playerid][0], "---------");//9
	}
    for(new i = 0; i < 8; i++)
	{
		if(i == 6 || i == 4 || i == 7) continue;
		PlayerTextDrawShow(playerid, SpeedometerPDP[playerid][i]);
	}
	for(new i = 0; i < 13; i++)
	{
		if(i == 6 || i == 7) continue;
		TextDrawShowForPlayer(playerid, SpeedometerTD[i]);
	}
	return 1;
}

GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}

stock GetPlayerSpeed(playerid)
{
	new Float:ST[4];
	if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid), ST[0], ST[1], ST[2]);
	else GetPlayerVelocity(playerid, ST[0], ST[1], ST[2]);
	ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 179.28625;
	return floatround(ST[3]);
}

AntyFakeWL(playerid, killerid)
{
	#pragma unused playerid, killerid
	return 0;
}

public Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    return VectorSize(x1-x2, y1-y2, z1-z2);
}

//EOF

