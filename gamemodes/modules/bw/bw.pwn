//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    bw                                                     //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
//Opis:
/*
	Zawiera system rannego i BW.
*/
// Autor: Creative
// Data utworzenia: 19.11.2019

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
public CheckBW(playerid)
{
	if(PlayerInfo[playerid][pBW] > 0 || PlayerInfo[playerid][pInjury] > 0)
		return 1;
	return 0;
}
stock IsPlayerAimingEx(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
    (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}

InfoMedicsInjury(injureplayer, bool:injury, bool:bw)
{
	new string[144], string2[144], pZone[MAX_ZONE_NAME], type[144], reason;
	GetPlayer2DZone(injureplayer, pZone, MAX_ZONE_NAME);
	reason = GetPVarInt(injureplayer,"bw-reason");
	if(reason <= 54 && reason > 0)
	{
		if(reason > 46 && ((reason-46) == 7 || (reason-46) == 8))
		{
			format(type, sizeof(type), "Œmiertelnie ranny");
		}
		else
		{
			format(type, sizeof(type), (bw ? "Nieprzytomny" : "Ranny"));
		}
	}
	else
	{
		format(type, sizeof(type), (bw ? "Nieprzytomny" : "Ranny"));
	}

	if(injury)
	{
		format(string2, sizeof(string2), "{FFFFFF}»»{6A5ACD} CENTRALA: {FF0000}%s {FFFFFF}w okolicach %s", type, pZone);
	}
	else if(bw)
	{
		format(string2, sizeof(string2), "{FFFFFF}»»{6A5ACD} CENTRALA: {FF0000}%s {FFFFFF}pacjent w salach pooperacyjnych", type);
	}

	if(reason <= 54 && reason > 0)
	{
		format(string, sizeof(string), "%s z urazami od %s", string2, (reason <= 46) ? GunNames[reason] : DeathNames[reason-46]);
	}
	else
	{
		string = string2;
	}
	//SendClientMessageToAll(COLOR_GRAD2, "#1 Wysy³am komunikat do ERS");
	SendTeamMessageOnDuty(0, COLOR_ALLDEPT, string, true, PERM_MEDIC);
	return 1;
}
NadajRanny(playerid, customtime = 0, bool:medicinformation = true)
{
	new reason = GetPVarInt(playerid,"bw-reason");
	if(reason <= 54 && reason > 0)
	{
		if(reason > 46 && ((reason-46) == 7 || (reason-46) == 8)) return NadajBW(playerid); //upadek lub zatoniecie
	}
	new Float:faceangle, interior, vw;
	interior = GetPlayerInterior(playerid);
	vw = GetPlayerVirtualWorld(playerid);
	
	GetPlayerFacingAngle(playerid, faceangle);
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
	SetPVarInt(playerid, "bw-vw", vw);
	SetPVarInt(playerid, "bw-int", interior);
	SetPVarFloat(playerid, "bw-faceangle", faceangle);
	SetPVarInt(playerid, "bw-veh", 0);
	if(IsPlayerInAnyVehicle(playerid))
	{
		SetPVarInt(playerid, "bw-veh", GetPlayerVehicleID(playerid));
		SetPVarInt(playerid, "bw-seat", GetPlayerVehicleSeat(playerid));
		if(GetPlayerVehicleSeat(playerid) == 0)
		{
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);
			if(engine == 1)
			{
				new string[156];
				SetVehicleParamsEx(GetPlayerVehicleID(playerid), 0, lights, alarm, doors, bonnet, boot, objective);
				//PlayerAC[playerid][acCarEngine_Tick] = gettime()+110;
				format(string, sizeof(string), "* Silnik w %s gaœnie ze wzglêdu na odniesione przez %s rany. (( %s ))", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400], GetNick(playerid), GetNick(playerid));
				ProxDetector(15.0, playerid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);
			}
		}
	}
	if(InfoSkate[playerid][sActive])
	{
		InfoSkate[playerid][sActive] = false;
		DestroyObject(InfoSkate[playerid][sSkate]);
		RemovePlayerAttachedObject(playerid,INDEX_SKATE);
	}
	//SendClientMessageToAll(COLOR_GRAD2, "#2: NadajRanny");
	if(GetPVarInt(playerid, "acceptdeath-allow"))
		return 0;
	if(!customtime) customtime = INJURY_TIME;
	PlayerInfo[playerid][pBW] = 0;
	PlayerInfo[playerid][pInjury] = customtime;
	if(!GetPVarInt(playerid, "timer_DamagedHP")) SetPVarInt(playerid, "timer_DamagedHP", SetTimerEx("DamagedHP", (customtime * 1000), false, "i", playerid));
	DeletePVar(playerid, "acceptdeath-allow");
	//tip
	sendTipMessage(playerid, sprintf("Po up³ywie %ds mo¿esz u¿yæ komendy /akceptuj smierc (zabiera ona broñ oraz przedmioty)", customtime-2));
	sendTipMessage(playerid, "Mo¿esz równie¿ poczekaæ, a¿ medyk lub osoba z apteczk¹ Ci pomo¿e.");
	//
	SetPlayerChatBubble(playerid, "** Ranny **", COLOR_PANICRED, 70.0, (customtime * 1000));
	if(medicinformation)
	{
		if((vw == 0 || vw == 90) && interior == 0) InfoMedicsInjury(playerid, true, false);
	}
	return 1;
}
NadajBW(playerid, customtime = 0, bool:medicinformation = true)
{
	new string[144];
	if(GetPVarInt(playerid, "bw-hitmankiller") == 1)
	{
		new killerid = GetPVarInt(playerid, "bw-hitmankillerid");
		if(IsPlayerConnected(killerid))
		{
			DajKaseDone(killerid, PlayerInfo[playerid][pHeadValue]);
			format(string,sizeof(string),"<< Hitman %s wype³ni³ kontrakt na: %s i zarobi³ $%d >>",GetNick(killerid),GetNick(playerid),PlayerInfo[playerid][pHeadValue]);
			GroupSendMessage(8, COLOR_YELLOW, string);
			format(string,sizeof(string),"NR Marcepan_Marks: Szok! Zamach na ¿ycie %s. Zosta³ on ciê¿ko ranny i przewieziony do szpitala.",GetNick(playerid));
			SendClientMessageToAll(COLOR_NEWS, string);
			Log(payLog, WARNING, "Hitman %s zabi³ %s i zarobi³ %d$", GetPlayerLogName(killerid), GetPlayerLogName(playerid), PlayerInfo[playerid][pHeadValue]);
			PlayerInfo[playerid][pHeadValue] = 0;
			GotHit[playerid] = 0;
			GetChased[playerid] = 999;
			GoChase[killerid] = 999;
			DeletePVar(playerid, "bw-hitmankiller");
			DeletePVar(playerid, "bw-hitmankillerid");
			customtime = BW_TIME_CRIMINAL;
		}
	}
	new Float:faceangle, interior, vw;
	interior = GetPlayerInterior(playerid);
	vw = GetPlayerVirtualWorld(playerid);
	GetPlayerFacingAngle(playerid, faceangle);
	GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
	SetPVarInt(playerid, "bw-vw", vw);
	SetPVarInt(playerid, "bw-int", interior);
	SetPVarFloat(playerid, "bw-faceangle", faceangle);
	//SendClientMessageToAll(COLOR_GRAD2, "#2-2: NadajBW");
	if(!customtime) customtime = BW_TIME;
	PlayerInfo[playerid][pInjury] = 0;
	PlayerInfo[playerid][pBW] = customtime;
	DeletePVar(playerid, "acceptdeath-allow");
	UsunBron(playerid);
	if(GetPVarInt(playerid, "timer_DamagedHP"))
	{
		KillTimer(GetPVarInt(playerid, "timer_DamagedHP"));
		DeletePVar(playerid, "timer_DamagedHP");
		DamagedHP(playerid);
	}
	SetPlayerChatBubble(playerid, "** Nieprzytomny **", COLOR_PANICRED, 70.0, (customtime * 1000));
	if(medicinformation)
	{
		if((vw == 0 || vw == 90) && interior == 0) InfoMedicsInjury(playerid, false, true);
	}
	return 1;
}
FreezePlayerOnInjury(playerid)
{
	//SendClientMessageToAll(COLOR_GRAD2, "#3: FreezePlayerOnInjury");
	TogglePlayerControllable(playerid, 0);
	ApplyAnimation(playerid, PlayerInfo[playerid][pDeathAnimLib], PlayerInfo[playerid][pDeathAnimName], 4.0, 0, 0, 0, 1, 0, 1); 
	SetTimerEx("FreezePlayer", 1500, false, "i", playerid);
	return 1;
}
PlayerEnterVehOnInjury(playerid)
{
	if(GetPVarInt(playerid, "bw-veh") > 0 && GetPlayerVehicleID(playerid) == GetPVarInt(playerid, "bw-veh"))
	{
		return 1;
	}
	//SendClientMessageToAll(COLOR_GRAD2, "#4: PlayerEnterVehOnInjury");
	Player_RemoveFromVeh(playerid);
	ShowPlayerInfoDialog(playerid, "Kotnik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Nie mo¿esz wsi¹œæ do pojazdu.");
	return 1;
}
PlayerExitVehOnInjury(playerid)
{
	if(GetPVarInt(playerid, "bw-veh") > 0)
	{
		PutPlayerInVehicle(playerid, GetPVarInt(playerid, "bw-veh"), GetPVarInt(playerid, "bw-seat"));
		ShowPlayerInfoDialog(playerid, "Kotnik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Nie mo¿esz wysi¹œæ z pojazdu.");
	}
	return 1;
}

PlayerChangeWeaponOnInjury(playerid)
{
	//SendClientMessageToAll(COLOR_GRAD2, "#5: PlayerChangeWeaponOnInjury");
	SetPlayerArmedWeapon(playerid, MyWeapon[playerid]);
	return 1;
}
ZespawnujGraczaBW(playerid)
{
	Wchodzenie(playerid);
	new string[256], type[144];
	MedicBill[playerid] = 0;
	MedicTime[playerid] = 0;
	NeedMedicTime[playerid] = 0;
	SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "bw-vw"));
	SetPlayerInterior(playerid, GetPVarInt(playerid, "bw-int"));
	SetPlayerFacingAngle(playerid, GetPVarFloat(playerid, "bw-faceangle"));
	SetCameraBehindPlayer(playerid);
	
	format(type, sizeof(type), (PlayerInfo[playerid][pBW] > 0 ? "nieprzytomny" : "ranny"));
	format(string, sizeof(string), "{FF542E}Jesteœ %s! {FFFFFF}Mo¿esz wezwaæ pomoc (/wezwij medyk, /dzwon 911).", type);
	SendClientMessage(playerid, COLOR_LIGHTRED, string);
	format(string, sizeof(string), "Gracze z apteczk¹ mog¹ udzieliæ Ci pomocy medycznej za pomoc¹ (/apteczka). Zalecamy odgrywaæ odniesione obra¿enia.");
	SendClientMessage(playerid, COLOR_WHITE, string);
	ApplyAnimation(playerid, PlayerInfo[playerid][pDeathAnimLib], PlayerInfo[playerid][pDeathAnimName], 4.0, 0, 0, 0, 1, 0, 1); 
	SetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
	SetPlayerHealth(playerid, INJURY_HP);
	if(GetPVarInt(playerid, "bw-veh") > 0)
	{
		PutPlayerInVehicle(playerid, GetPVarInt(playerid, "bw-veh"), GetPVarInt(playerid, "bw-seat"));
	}
	return 1;
}
//-----------------<[ Timery: ]>-------------------
RannyTimer(playerid)
{
	new string[256], i = playerid;
	if(GetPVarInt(i, "bw-sync") != 1 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(i, "bw-sync", 1);
	}
	if(PlayerInfo[i][pInjury] > 0)
	{
		if(GetPlayerSpeed(playerid) > 4 && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID)
			FreezePlayerOnInjury(playerid);
		//SendClientMessageToAll(COLOR_GRAD2, "------Timer: RannyTimer");
		//if(GetPlayerState(i) != PLAYER_STATE_PASSENGER) 
		//SetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
		if(GetPVarInt(playerid, "bw-veh") > 0 && !IsPlayerInAnyVehicle(playerid))
		{
			PutPlayerInVehicle(playerid, GetPVarInt(playerid, "bw-veh"), GetPVarInt(playerid, "bw-seat"));
		}
		ApplyAnimation(i, PlayerInfo[playerid][pDeathAnimLib], PlayerInfo[playerid][pDeathAnimName], 4.1, 1, 0, 0, 1, 0, 1); 
		if(GetPVarInt(playerid, "acceptdeath-allow")) return 1;
		PlayerInfo[i][pInjury]-=2;
		BlockDeska[i] = 1;
		//format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Ranny: %d", PlayerInfo[i][pInjury]);
		//GameTextForPlayer(i, string, 2500, 3);
		format(string, sizeof(string), "jestes ~y~ranny~n~~y~%d~w~ sekund do ~g~/akceptuj smierc", PlayerInfo[i][pInjury]);
		TextDrawSetString(TextDrawInfo[i], string);
		TextDrawShowForPlayer(i, TextDrawInfo[i]);
		SetPlayerChatBubble(playerid, "** Ranny **", COLOR_PANICRED, 30.0, (PlayerInfo[i][pInjury] * 1000));
		if(PlayerInfo[i][pInjury] <= 0)
		{
			//NOWE BW - akceptuj smierc
			SetPVarInt(playerid, "acceptdeath-allow", 1);
			PlayerInfo[playerid][pInjury] = 999;
			TextDrawSetString(TextDrawInfo[playerid], "mozesz uzyc komendy ~g~/akceptuj smierc");
			TextDrawShowForPlayer(playerid, TextDrawInfo[playerid]);
		}
	}
	return 1;
}

BWTimer(playerid)
{
	new string[128], i = playerid;
	if(GetPVarInt(i, "bw-sync") != 1 && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
	{
		SetPVarInt(i, "bw-sync", 1);
	}
	if(PlayerInfo[playerid][pBW] > 0)
	{ 
		if(GetPlayerState(i) != PLAYER_STATE_PASSENGER) ApplyAnimation(i, "CRACK", "crckidle1", 4.0, 1, 0, 0, 1, 0, 1);
		PlayerInfo[i][pBW]-=2;
		BlockDeska[i] = 1;
		SetPlayerChatBubble(playerid, "** Nieprzytomny **", COLOR_PANICRED, 30.0, (PlayerInfo[i][pBW] * 1000));
		format(string, sizeof(string), "stan ~y~nieprzytomnosci~n~~w~przez ~y~%d~w~ sekund", PlayerInfo[i][pBW]);
		TextDrawSetString(TextDrawInfo[i], string);
		TextDrawShowForPlayer(i, TextDrawInfo[i]);
		if(PlayerInfo[i][pBW] <= 0)
		{
			format(string, sizeof(string), "* Otrzyma³eœ rachunek w wysokoœci %d$ za hospitalizacjê.", HOSPITALIZATION_COST);
			SendClientMessage(i, COLOR_LIGHTBLUE, string);
			ZabierzKaseDone(i, HOSPITALIZATION_COST);
			ZdejmijBW(i);
			GameTextForPlayer(i, "~n~~n~~g~~h~Obudziles sie", 5000, 5);
			format(string, sizeof(string), "{AAF542}Obudzi³eœ siê! {FFFFFF}Twoja postaæ odnios³a obra¿enia, które zalecamy odgrywaæ.");
			SendClientMessage(i, COLOR_NEWS, string);
			PlayerInfo[playerid][pWeaponBlock] = gettime()+300; //5 minut
			SendClientMessage(i, COLOR_LIGHTRED, "> Zosta³a Ci nadana blokada broni na okres 5 minut.");
		}
	}
	return 1;
}

ZespawnujGraczaSzpitalBW(playerid)
{
	new randbed = random(sizeof(HospitalBeds));
	SetPVarInt(playerid, "bw-vw", 90);
	SetPVarInt(playerid, "bw-int", 0);
	SetPVarFloat(playerid, "bw-faceangle", HospitalBeds[randbed][3]);
	PlayerInfo[playerid][pLocal] = PLOCAL_FRAC_LSMC;
	PlayerInfo[playerid][pPos_x] = HospitalBeds[randbed][0];
	PlayerInfo[playerid][pPos_y] = HospitalBeds[randbed][1];
	PlayerInfo[playerid][pPos_z] = HospitalBeds[randbed][2];		
	PlayerInfo[playerid][pMuted] = 1;
	ZespawnujGraczaBW(playerid);
	SetPlayerCameraPos(playerid,HospitalBeds[randbed][0] + 3, HospitalBeds[randbed][1], HospitalBeds[randbed][2]);
	SetPlayerCameraLookAt(playerid,HospitalBeds[randbed][0], HospitalBeds[randbed][1], HospitalBeds[randbed][2]);
	Wchodzenie(playerid);
	if(GetPVarInt(playerid, "lastDamage"))
	{
		DeletePVar(playerid, "lastDamage");
	}
	return 1;
}

NadajWLBW(killerid, victim, bool:bw)
{
	if(GetPlayerVirtualWorld(killerid) == 5000) return 1;
	//SendClientMessageToAll(COLOR_GRAD2, "#10: NadajWLBW");
	new playerid = victim;
	if(AntyFakeWL(playerid, killerid) != 1)
    {
		new string[144];
		format(string, sizeof(string), (bw ? "Morderstwo" : "Okaleczenie"));
		if(IsAPolicja(playerid) && OnDutyCD[playerid] != 1 && OnDuty[playerid])
		{
			PoziomPoszukiwania[killerid] += 2;
			strcat(string, " Policjanta");
		}
		if(lowcaz[killerid] == playerid)
			strcat(string, " £owcy Nagród");
		if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER || GetPlayerState(killerid) == PLAYER_STATE_PASSENGER)
			strcat(string, " z okna pojazdu");
	
		PlayerPlaySound(killerid, 1083, 0.0, 0.0, 0.0);
		PoziomPoszukiwania[killerid] ++;
		SetPlayerCriminal(killerid, INVALID_PLAYER_ID, string);
		if(PoziomPoszukiwania[killerid] >= 10)
		{
			sendTipMessageEx(killerid, COLOR_LIGHTRED, "Masz ju¿ 10 listów goñczych!");
			sendTipMessage(killerid, "Zaczynasz stawaæ siê coraz bardziej smakowity dla ³owców! Pilnuj siê!"); 
		}
	}
	return 1;
}

ZdejmijBW(playerid, drunklvl = 7000)
{
	//SendClientMessageToAll(COLOR_GRAD2, "#11: ZdejmijBW");
	new i = playerid;
	PlayerInfo[i][pBW]=0;
	PlayerInfo[i][pInjury]=0;
	PlayerInfo[i][pMuted] = 0;
	BlockDeska[i] = 0;
	PlayerRequestMedic[playerid] = 0;
	TogglePlayerControllable(i, 1);
	if(GetPVarInt(playerid, "timer_DamagedHP"))
	{
		KillTimer(GetPVarInt(playerid, "timer_DamagedHP"));
		DamagedHP(playerid);
	}
	SetPVarInt(i, "bw-sync", 0);
	DeletePVar(playerid, "acceptdeath-allow");
	ClearAnimations(i);
	SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
	SetPlayerChatBubble(playerid, "** Og³uszony **", COLOR_PANICRED, 70.0, (120 * 1000));
	// SetPlayerChatBubble(playerid, " ", 0xFF0000FF, 100.0, 1000); - lub usuwamy napis nad g³ow¹
	SetPlayerDrunkLevel(playerid, drunklvl);
	TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
	return 1;
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end