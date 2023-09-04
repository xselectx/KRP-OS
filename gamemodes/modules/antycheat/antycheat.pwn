//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 antycheat                                                 //
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
// Autor: Mrucznik
// Data utworzenia: 16.09.2019
//Opis:
/*
	Anty-cheat serwera + integracje z zewn�trznymi anty-cheatami.
*/

//

//-----------------<[ Funkcje: ]>-------------------
ProcessACCode(playerid, code)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	switch(nexac_additional_settings[code])
	{
		case OFF: 
		{
			//should never occur
		}
		case KICK:
		{
			SetPVarInt(playerid, "CheatDetected", 1);
			ACKickMessage(playerid, code);
			if(IsAProductionServer()) KickEx(playerid);
		}
		case INSTAKICK: //code == 50 || code == 28 || code == 27 || code == 5
		{
			ACKickMessage(playerid, code);
			if(IsAProductionServer()) Kick(playerid);
		}
		case LVL1KICK:
		{
			if(PlayerInfo[playerid][pLevel] <= 1)
			{
				SetPVarInt(playerid, "CheatDetected", 1);
				ACKickMessage(playerid, code);
				if(IsAProductionServer()) KickEx(playerid);
			}
			else
			{
				MarkPotentialCheater(playerid);
				ACWarningDelay(playerid, code);
			} 
		}
		case LVL1MARK:
		{
			if(PlayerInfo[playerid][pLevel] == 1)
			{
				MarkPotentialCheater(playerid);
				ACWarningDelay(playerid, code);
			}
		}
		case LVL1INSTAKICK:
		{
			if(PlayerInfo[playerid][pLevel] <= 1)
			{
				ACKickMessage(playerid, code);
				Kick(playerid);
				KickEx(playerid);
			}
			else
			{
				MarkPotentialCheater(playerid);
				ACWarningDelay(playerid, code);
			} 
		}
		case ADMIN_WARNING:
		{
			SendMessageToAdmin(sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] prawdopodobnie czituje. | %s [%d]", 
				GetNickEx(playerid), playerid, ip, NexACDecodeCode(code), code), 
				0xFF00FFFF);
			ACWarningDelay(playerid, code);
		}
		case MARK_AS_CHEATER:
		{
			MarkPotentialCheater(playerid);
			ACWarningDelay(playerid, code);
		}
		case MARK_AND_WARNING:
		{
			SendMessageToAdmin(sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] najprawdopodobniej czituje. | %s [%d]", 
				GetNickEx(playerid), playerid, ip, NexACDecodeCode(code), code), 
				0xFF00FFFF);
			MarkPotentialCheater(playerid);
			ACWarningDelay(playerid, code);
		}
	}
}

NexACDecodeCode(code)
{
	new code_decoded[32];
	switch(code)
	{
		case 0:     format(code_decoded, sizeof(code_decoded), "AirBreak (pieszo)");
		case 1:     format(code_decoded, sizeof(code_decoded), "AirBreak (pojazd)");
		case 2:     format(code_decoded, sizeof(code_decoded), "TP (pieszo)");
		case 3:     format(code_decoded, sizeof(code_decoded), "TP (pojazd)");
		case 4:     format(code_decoded, sizeof(code_decoded), "TP (do/miedzy auta)");
		case 5:     format(code_decoded, sizeof(code_decoded), "TP (auto do gracza)");
		case 6:     format(code_decoded, sizeof(code_decoded), "TP (do pickupow)");
		case 7:     format(code_decoded, sizeof(code_decoded), "Fly (pieszo)");
		case 8:     format(code_decoded, sizeof(code_decoded), "Fly (pojazd)");
		case 9:     format(code_decoded, sizeof(code_decoded), "Speed (pieszo)");
		case 10:    format(code_decoded, sizeof(code_decoded), "Speed (pojazd)");
		case 11:    format(code_decoded, sizeof(code_decoded), "HP (pojazd)");
		case 12:    format(code_decoded, sizeof(code_decoded), "HP (pieszo)");
		case 13:    format(code_decoded, sizeof(code_decoded), "Kamizelka");
		case 14:    format(code_decoded, sizeof(code_decoded), "Pieniadze");
		case 15:    format(code_decoded, sizeof(code_decoded), "Bronie");
		case 16:    format(code_decoded, sizeof(code_decoded), "Dodawanie ammo");
		case 17:    format(code_decoded, sizeof(code_decoded), "Nieskonczonosc ammo");
		case 18:    format(code_decoded, sizeof(code_decoded), "AnimHack");
		case 19:    format(code_decoded, sizeof(code_decoded), "GodMode (pieszo)");
		case 20:    format(code_decoded, sizeof(code_decoded), "GodMode (pojazd)");
		case 21:    format(code_decoded, sizeof(code_decoded), "Niewidzialnosc");
		case 22:  	format(code_decoded, sizeof(code_decoded), "Lagcomp");
		case 23:    format(code_decoded, sizeof(code_decoded), "Tuning");
		case 24:    format(code_decoded, sizeof(code_decoded), "Parkour mod");
		case 25:    format(code_decoded, sizeof(code_decoded), "Szybkie animki");
		case 26:    format(code_decoded, sizeof(code_decoded), "Rapidfire");
		case 27:    format(code_decoded, sizeof(code_decoded), "FakeSpawn");
		case 28:    format(code_decoded, sizeof(code_decoded), "FakeKill");
		case 29:    format(code_decoded, sizeof(code_decoded), "Pro Aim");
		case 30:    format(code_decoded, sizeof(code_decoded), "Bieg CJa");
		case 31:    format(code_decoded, sizeof(code_decoded), "Strzelanie autami");
		case 32:    format(code_decoded, sizeof(code_decoded), "Kradniecie aut");
		case 33:    format(code_decoded, sizeof(code_decoded), "Unfreeze");
		case 34:  	format(code_decoded, sizeof(code_decoded), "AFK-Ghosting");
		case 35:    format(code_decoded, sizeof(code_decoded), "Full Aiming");
		case 36:  	format(code_decoded, sizeof(code_decoded), "Fake NPC");
		case 37:  	format(code_decoded, sizeof(code_decoded), "Reconnect");
		case 38:    format(code_decoded, sizeof(code_decoded), "Wysoki ping");
		case 39:    format(code_decoded, sizeof(code_decoded), "Czitowanie dialogow");
		case 40:  	format(code_decoded, sizeof(code_decoded), "Sandbox");
		case 41:    format(code_decoded, sizeof(code_decoded), "Zla wersja samp");
		case 42:    format(code_decoded, sizeof(code_decoded), "Rcon-Hack");
		case 43:    format(code_decoded, sizeof(code_decoded), "Tuning Crasher");
		case 44:    format(code_decoded, sizeof(code_decoded), "Inv. seat Crasher");
		case 45:    format(code_decoded, sizeof(code_decoded), "Dialog Crasher");
		case 46:    format(code_decoded, sizeof(code_decoded), "Dodatki Crasher");
		case 47:    format(code_decoded, sizeof(code_decoded), "Bronie Crasher");
		case 48:  	format(code_decoded, sizeof(code_decoded), "flood connect");
		case 49:  	format(code_decoded, sizeof(code_decoded), "flood callbacks");
		case 50:  	format(code_decoded, sizeof(code_decoded), "flood change seat");
		case 51:    format(code_decoded, sizeof(code_decoded), "DDOS");
		case 52:    format(code_decoded, sizeof(code_decoded), "Anti-NOPs");
		case 53:    format(code_decoded, sizeof(code_decoded), "Anti-FakeKill");
		case 54: 	format(code_decoded, sizeof(code_decoded), "KRP-AC: Speedfire");
		case 55:	format(code_decoded, sizeof(code_decoded), "KRP-AC: FakeAFK");
		case 56:	format(code_decoded, sizeof(code_decoded), "KRP-AC: FakeWL");
		case 57:	format(code_decoded, sizeof(code_decoded), "KRP-AC: FakeKill (2)");
		case 58:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Anti-Veh GodMode");
		case 59:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Anti-Weapon Hack");
		case 60:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Anti-Ammo Hack");
		case 61:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Anti-Slapper");
		case 62:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Upside-Down");
		case 63:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Speedhack (veh)");
		case 64:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Speedhack (onfoot)");
		case 65:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Invisible");
		case 66:	format(code_decoded, sizeof(code_decoded), "KRP-AC: Animhack");
		case 67:	format(code_decoded, sizeof(code_decoded), "KRP-AC: FlyHack");
		case 68:	format(code_decoded, sizeof(code_decoded), "KRP-AC: SilentAim");
		case 69:	format(code_decoded, sizeof(code_decoded), "KRP-AC: NoSpread");
		case 70: 	format(code_decoded, sizeof(code_decoded), "KRP-AC: Aimbot");
		case 71:	format(code_decoded, sizeof(code_decoded), "KRP-AC: ZoomHack");
		case 72:	format(code_decoded, sizeof(code_decoded), "KRP-AC: NoReload");
		case 73:	format(code_decoded, sizeof(code_decoded), "KRP-AC: SilentAim (2)");
		case 74:	format(code_decoded, sizeof(code_decoded), "KRP-AC: NoFuel");
		default:    format(code_decoded, sizeof(code_decoded), "Inne");
	}
	return code_decoded;
}

SetAntyCheatForPlayer(playerid, valueCode)
{
	SetPVarInt(playerid, "AntyCheatOff", valueCode);
	return 1;
}

PlayerCanSpawnWihoutTutorial(playerid)
{
	if(PlayerInfo[playerid][pLevel] == 1 && (PlayerInfo[playerid][pSex] == 0 || PlayerInfo[playerid][pOrigin] == 0 || PlayerInfo[playerid][pAge] == 0)) //anty sobeit spawn
	{
		new ip[16];
		GetPlayerIp(playerid, ip, sizeof(ip));
		SendMessageToAdmin(
			sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] najprawdopodobniej czituje. | Spawn pomijaj�c tutorial", GetNickEx(playerid), playerid, ip), 
			0xFF00FFFF
		);
		sendErrorMessage(playerid, "Zespawnowa�e� si� bez wyboru p�ci/pochodzenia/wieku postaci! Zosta�e� wyrzucony z serwera.");
		KickEx(playerid);
		return 0;
	}
	return 1;
}

forward CheckCode2003(killerid, playerid);
public CheckCode2003(killerid, playerid)
{
    new string[256];
    if(IsPlayerConnected(playerid))
	{
    	MruDialog(killerid, "ACv2: Kod #2003", "Zosta�e� wyrzucony za weapon hack.");
		format(string, sizeof string, "ACv2 [#2003]: %s zosta� wyrzucony za weapon hack.", GetNickEx(killerid));
    	SendCommandLogMessage(string);
    	KickEx(killerid);
		Log(warningLog, WARNING, string);
		Log(punishmentLog, WARNING, string);
	}
	else
	{
	    format(string, sizeof string, "ACv2 [#2003] WARNING: Prawdopodobnie pr�ba wymuszenia kodu na graczu %s.", GetNickEx(killerid));
		MarkPotentialCheater(playerid);
    	SendCommandLogMessage(string);
		Log(warningLog, WARNING, string);
	}
}
forward AntyCheatON(playerid);
public AntyCheatON(playerid)
{
	timeAC[playerid]++; 
	if(timeAC[playerid] >= 3)
	{
		SetAntyCheatForPlayer(playerid, 0);
		timeAC[playerid] = 0; 
		KillTimer(timerAC[playerid]); 
	}
}

forward OznaczCziteraNew(playerid);
public OznaczCziteraNew(playerid)
{
	new string[71+MAX_PLAYER_NAME];
	SetPVarInt(playerid, "AC_oznaczony_new", 1);
	if(gettime() > GetPVarInt(playerid, "lastSobMsg"))
	{
		SetPVarInt(playerid, "lastSobMsg", gettime() + 60);
		format(string, sizeof(string), "%s[%d] jest podejrzany o S0beita (new)", GetNick(playerid), playerid);
		SendScripterMessage(COLOR_PANICRED, string);
		MarkPotentialCheater(playerid);
	}
	return 1;
}

forward OznaczCzitera(playerid);
public OznaczCzitera(playerid)
{
	new string[71+MAX_PLAYER_NAME];
	SetPVarInt(playerid, "AC_oznaczony", 1);
	if(gettime() > GetPVarInt(playerid, "lastSobMsg"))
	{
		SetPVarInt(playerid, "lastSobMsg", gettime() + 60);
		format(string, sizeof(string), "%s[%d] jest podejrzany o S0beita", GetNick(playerid), playerid);
		SendAdminMessage(COLOR_PANICRED, string);
		MarkPotentialCheater(playerid);
	}
	return 1;
}

MarkPotentialCheater(playerid, value=1)
{
	PotentialCheaters[playerid] += value;
	UpdatePotentialCheatersTxd();
}

UnmarkPotentialCheater(playerid)
{
	if(PotentialCheaters[playerid] > 0)
	{
		PotentialCheaters[playerid] = 0;
		UpdatePotentialCheatersTxd();
	}
}

//----- TextDrawy -----
CreatePotentialCheatersTxd()
{
	PotentialCheatersTitleTxd = TextDrawCreate(519.000000, 102.000000, "Szkodnicy:");
	TextDrawFont(PotentialCheatersTitleTxd, 1);
	TextDrawLetterSize(PotentialCheatersTitleTxd, 0.191666, 0.900000);
	TextDrawTextSize(PotentialCheatersTitleTxd, 400.000000, 17.000000);
	TextDrawSetOutline(PotentialCheatersTitleTxd, 1);
	TextDrawSetShadow(PotentialCheatersTitleTxd, 0);
	TextDrawAlignment(PotentialCheatersTitleTxd, 2);
	TextDrawColor(PotentialCheatersTitleTxd, -1);
	TextDrawBackgroundColor(PotentialCheatersTitleTxd, 255);
	TextDrawBoxColor(PotentialCheatersTitleTxd, 50);
	TextDrawUseBox(PotentialCheatersTitleTxd, 0);
	TextDrawSetProportional(PotentialCheatersTitleTxd, 1);
	TextDrawSetSelectable(PotentialCheatersTitleTxd, 0);
	TextDrawHideForAll(PotentialCheatersTitleTxd);

	for(new i; i<sizeof(PotentialCheatersTxd); i++)
	{
		PotentialCheatersTxd[i] = TextDrawCreate(500.000000, 114.000000 + i*11, " ");
		TextDrawFont(PotentialCheatersTxd[i], 1);
		TextDrawLetterSize(PotentialCheatersTxd[i], 0.137500, 0.900000);
		TextDrawTextSize(PotentialCheatersTxd[i], 607.500000, 17.000000);
		TextDrawSetOutline(PotentialCheatersTxd[i], 1);
		TextDrawSetShadow(PotentialCheatersTxd[i], 0);
		TextDrawAlignment(PotentialCheatersTxd[i], 1);
		TextDrawColor(PotentialCheatersTxd[i], COLOR_RED);
		TextDrawBackgroundColor(PotentialCheatersTxd[i], 255);
		TextDrawBoxColor(PotentialCheatersTxd[i], 50);
		TextDrawUseBox(PotentialCheatersTxd[i], 1);
		TextDrawSetProportional(PotentialCheatersTxd[i], 1);
		TextDrawSetSelectable(PotentialCheatersTxd[i], 1);
		TextDrawHideForAll(PotentialCheatersTxd[i]);
	}
}

ShowPotentialCheatersTxd(playerid)
{
	TextDrawShowForPlayer(playerid, PotentialCheatersTitleTxd);
	for(new i; i<sizeof(PotentialCheatersTxd); i++)
		TextDrawShowForPlayer(playerid, PotentialCheatersTxd[i]);
	IsPotentialCheatersTxdVisible[playerid] = true;
}

HidePotentialCheatersTxd(playerid)
{
	TextDrawHideForPlayer(playerid, PotentialCheatersTitleTxd);
	for(new i; i<sizeof(PotentialCheatersTxd); i++)
		TextDrawHideForPlayer(playerid, PotentialCheatersTxd[i]);
	IsPotentialCheatersTxdVisible[playerid] = false;
}

UpdatePotentialCheatersTxd()
{
	new PlayerArray<top_cheaters>;
	new i;

	sortPlayersInline top_cheaters => (R = l > r) {
		R = PotentialCheaters[l] > PotentialCheaters[r];
	}
	
	forPlayerArray (top_cheaters => playerid) {
		if(PotentialCheaters[playerid] > 0)
		{
			PotentialCheatersID[i] = playerid;
			TextDrawSetString(PotentialCheatersTxd[i], sprintf("%s [%d] - %d", GetNickEx(playerid), playerid, PotentialCheaters[playerid]));
			if(GetPVarInt(playerid, "AC_oznaczony")) {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_PANICRED);
			} else if(GetPVarInt(playerid, "AC_oznaczony_new")) {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_BLUE);
			} else if(PlayerInfo[playerid][pLevel] == 1) {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_NEWS);
			} else if(PotentialCheaters[playerid] >= 10) {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_RED);
			} else {
				TextDrawColor(PotentialCheatersTxd[i], COLOR_GREY);
			}
			TextDrawBoxColor(PotentialCheatersTxd[i], 50);

			i++;
			if(i == MAX_POTENTIAL_CHEATERS)
				break;
		}
	}

	for(; i<MAX_POTENTIAL_CHEATERS; i++)
	{
		TextDrawSetString(PotentialCheatersTxd[i], " ");
		TextDrawBoxColor(PotentialCheatersTxd[i], 0x00000000);
	}
}

// ----- Nex-AC modifications ------
NexACSaveCode(code, eNexACAdditionalSettings:type)
{
	nexac_additional_settings[code] = type;
	NexACSaveAdditionalConfig();
	if(type == OFF)
	{
        EnableAntiCheat(code, false);
	}
	else 
	{
        EnableAntiCheat(code, true);
	}
}

NexACLoadAdditionalConfig()
{
	new i, string[2048], File:cfgFile;
	if(fexist(AC_ADDITIONAL_CONFIG_FILE))
	{
		if((cfgFile = fopen(AC_ADDITIONAL_CONFIG_FILE, io_read)))
		{
			new j;
			while(fread(cfgFile, string) > 0)
			{
				sscanf(string, "i'//'i", j, i);
				nexac_additional_settings[i] = eNexACAdditionalSettings:j;
			}
			fclose(cfgFile);
		}
		else return 0;
	}
	else
	{
		NexACSaveAdditionalConfig();
	}
	return 1;
}

NexACSaveAdditionalConfig()
{
	static strtmp[10];
	new string[2048], File:cfgFile;
	if((cfgFile = fopen(AC_ADDITIONAL_CONFIG_FILE, io_write)))
	{
		for(new i; i < sizeof(nexac_additional_settings); ++i)
		{
			format(strtmp, sizeof strtmp, "%d //%d\r\n", nexac_additional_settings[i], i);
			strcat(string, strtmp);
		}
		fwrite(cfgFile, string);
		fclose(cfgFile);
	}
}

bool:CheckACWarningDelay(playerid, code)
{
	return GetPVarInt(playerid, "LastDetectedCode")-1 == code;
}

ACWarningDelay(playerid, code)
{
	SetPVarInt(playerid, "LastDetectedCode", code+1);
	defer ClearACWarningDelay(playerid);
}

timer ClearACWarningDelay[1000](playerid)
{
	SetPVarInt(playerid, "LastDetectedCode", 0);
}

GetNexACAdditionalSettingName(type)
{
	new name[22];
	switch(type)
	{
		case OFF: 
		{
			strcat(name, "OFF");
		}
		case KICK:
		{
			strcat(name, "KICK");
		}
		case INSTAKICK:
		{
			strcat(name, "INSTAKICK");
		}
		case LVL1KICK:
		{
			strcat(name, "KICK 1LVL/OZNACZ");
		}
		case LVL1MARK:
		{
			strcat(name, "OZNACZ 1LVL");
		}
		case LVL1INSTAKICK:
		{
			strcat(name, "INSTAKICK 1LVL/OZNACZ");
		}
		case ADMIN_WARNING:
		{
			strcat(name, "WARNING");
		}
		case MARK_AS_CHEATER:
		{
			strcat(name, "OZNACZ");
		}
		case MARK_AND_WARNING:
		{
			strcat(name, "OZNACZ + WARNING");
		}
	}
	return name;
}

ACKickMessage(playerid, code)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	SendMessageToAdmin(sprintf("Anti-Cheat: %s [ID: %d] [IP: %s] dosta� kicka. | %s [%d]", 
		GetNickEx(playerid), playerid, ip, NexACDecodeCode(code), code), 
		0x9ACD32AA);
	if(IsAProductionServer()) SendClientMessage(playerid, 0x9ACD32AA, sprintf("Anti-Cheat: Dosta�e� kicka. | %s [%d]", NexACDecodeCode(code), code));
	if(IsAProductionServer()) SendClientMessage(playerid, 0x9ACD32AA, "Je�eli uwa�asz, �e antycheat zadzia�a� nieprawid�owo, zg�o� to administracji, podaj�c kod z jakim otrzyma�e� kicka.");
	Log(punishmentLog, WARNING, "%s dosta� kicka od antycheata, pow�d: kod %d", GetPlayerLogName(playerid), code);
}

ACv2_DrivingWithoutPremissions(playerid, vehicleid)
{
	new string[256];
	//ACv2: Kicking players that are trying to drive the car without permission
	if(!Player_CanUseCar(playerid, vehicleid) && PlayerCuffed[playerid] < 1 && PlayerInfo[playerid][pAdmin] < 1
	|| !Player_CanUseCar(playerid, vehicleid) && PlayerCuffed[playerid] < 1 && !IsAScripter(playerid))
	{
		// Skurwysyn kieruje bez prawka lub autem frakcji xD (Xd)
		if(GetPVarInt(playerid, "AntyCheatOff") == 0)
		{
			if(!IsPlayerNPC(playerid))
			{
				//if(IsAPrzestepca(playerid) && (Car_GetOwnerType(GetPlayerVehicleID(playerid)) == CAR_OWNER_PLAYER)) return 0;
				MruDialog(playerid, "ACv2: Kod #2001", "Dosta�e� kicka za kierowanie samochodem bez wymaganych uprawnie�");
				format(string, sizeof string, "ACv2 [#2001]: %s dosta� kicka za jazd� bez uprawnie� [Veh: %d]", GetNickEx(playerid), GetPlayerVehicleID(playerid));
				SendCommandLogMessage(string);
				Log(warningLog, WARNING, string);
				Log(punishmentLog, WARNING, string);
				KickEx(playerid);
			}
			return 1;
		}
	}
	return 0;
}