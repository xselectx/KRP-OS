//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  wejscia                                                  //
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
// Autor: Mrucznik & Simeone
// Data utworzenia: 04.05.2019
//Opis:
/*
	System wej��/wyj�� oraz wjazd�w/wyjazd�w do interior�w/lokacji.
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
DodajWejscie(Float:fx1, Float:fy1, Float:fz1, Float:fx2, Float:fy2, Float:fz2, vw1=0, int1=0, vw2=0, int2=0, nazwain[]="", nazwaout[]="", wejdzUID=0, playerLocal=255, bool:specialCome=false)
{
	wejscia[iloscwejsc][w_x1] = fx1;
	wejscia[iloscwejsc][w_y1] = fy1;
	wejscia[iloscwejsc][w_z1] = fz1;
	wejscia[iloscwejsc][w_x2] = fx2;
	wejscia[iloscwejsc][w_y2] = fy2;
	wejscia[iloscwejsc][w_z2] = fz2;
	wejscia[iloscwejsc][w_vw1] = vw1;
	wejscia[iloscwejsc][w_int1] = int1;
	wejscia[iloscwejsc][w_vw2] = vw2;
	wejscia[iloscwejsc][w_int2] = int2;
	wejscia[iloscwejsc][w_pLocal] = playerLocal;
	wejscia[iloscwejsc][w_UID] = wejdzUID;
	if(specialCome)
	{
		wejscia[iloscwejsc][w_specCome] = 1.3;
	}
	if(isnull(nazwain)) 
	{
		CreateDynamicPickup(1239, 2, fx1, fy1, fz1, vw1, int1);
	}
	else  
	{
		new Float:range = (int1 == 0 && vw1 == 0) ? EXTERIOR_3DTEXT_RANGE : INTERIOR_3DTEXT_RANGE;
		CreateDynamic3DTextLabel(nazwain, COLOR_PURPLE, fx1, fy1, fz1, range, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw1, int1);
	}
	if(isnull(nazwaout)) 
	{
		CreateDynamicPickup(1239, 2, fx1, fy1, fz1, vw2, int2);
	}
	else 
	{
		new Float:range = ((int2 == 0 && vw2 == 0) ? (EXTERIOR_3DTEXT_RANGE) : (INTERIOR_3DTEXT_RANGE));
		CreateDynamic3DTextLabel(nazwaout, COLOR_PURPLE, fx2, fy2, fz2, range, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vw2, int2);
	}
	
	return iloscwejsc++;
}
Sprawdz_w_cord(playerid, id)
{
	new playerPos;//0 - nigdzie, 1 - na /wejdz, 2 - na /wyjdz
	if(wejscia[id][w_specCome] > 0.5)
	{
		if(GetPlayerVirtualWorld(playerid) == wejscia[id][w_vw1]
		&& GetPlayerInterior(playerid) == wejscia[id][w_int1]
		&& IsPlayerInRangeOfPoint(playerid, wejscia[id][w_specCome], wejscia[id][w_x1],wejscia[id][w_y1],wejscia[id][w_z1]))
		{
			playerPos = OUT_INTERIOR; 
		}
		else if(GetPlayerVirtualWorld(playerid) == wejscia[id][w_vw2]
		&& GetPlayerInterior(playerid) == wejscia[id][w_int2]
		&& IsPlayerInRangeOfPoint(playerid, wejscia[id][w_specCome], wejscia[id][w_x2],wejscia[id][w_y2],wejscia[id][w_z2]))
		{
			playerPos = IN_INTERIOR; 
		}
		else
		{
			playerPos = NOT_IN_ENTER_RANGE;
		}
	}
	else 
	{
		if(GetPlayerVirtualWorld(playerid) == wejscia[id][w_vw1]
		&& GetPlayerInterior(playerid) == wejscia[id][w_int1]
		&& IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[id][w_x1],wejscia[id][w_y1],wejscia[id][w_z1]))
		{
			playerPos = OUT_INTERIOR; 
		}
		else if(GetPlayerVirtualWorld(playerid) == wejscia[id][w_vw2]
		&& GetPlayerInterior(playerid) == wejscia[id][w_int2]
		&& IsPlayerInRangeOfPoint(playerid, 3.0, wejscia[id][w_x2],wejscia[id][w_y2],wejscia[id][w_z2]))
		{
			playerPos = IN_INTERIOR; 
		}
		else
		{
			playerPos = NOT_IN_ENTER_RANGE;
		}
	}
	return playerPos;
}
Sprawdz_UID_Wchodzenie(playerid, Check_ID)
{
	if(Check_ID == 1)
	{
		if(dmv == 1 || IsAnInstructor(playerid, 0) || IsABOR(playerid, 0))
		{
			if(wywalzdmv[playerid] == 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Urz�d Miasta w Los Santos Wita! <<<<");
				SendClientMessage(playerid, COLOR_WHITE, "-> Cennik znajduje si� zaraz za rogiem, po prawej stronie.");
				SendClientMessage(playerid, COLOR_WHITE, "-> Znajdujesz si� na najwy�szym poziomie, winda znajduje si� w holu g��wnym");
				SendClientMessage(playerid, COLOR_WHITE, "-> Okienka dla patent�w znajduj� si� po lewej i prawej stronie w holu pierwszym");
				SendClientMessage(playerid, COLOR_WHITE, "-> [Obecny interior urz�du powsta� w listopadzie 2018 roku, za inicjatyw� Satius & Arkam & Simeone]");
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> �yczymy przyjemnego czekania na licencje! <<<<");
				GameTextForPlayer(playerid, "~n~~g~By Satius", 5000, 1);
				
				
				if(!GroupPlayerDutyPerm(playerid, PERM_POLICE) // Nie jest PD
				&& !GroupPlayerDutyPerm(playerid, PERM_BOR))
				{
					SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
					SendClientMessage(playerid, COLOR_WHITE, "Przechodz�c przez wykrywacz metalu s�yszysz alarm.");
					SendClientMessage(playerid, COLOR_WHITE, "Dopiero teraz dostrzegasz czerwon� tabliczk� informuj�c� o zakazie");
					SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k�opot�w, wi�c oddajesz sw�j arsena� agentowi USSS.");
					SendClientMessage(playerid, COLOR_PANICRED, "((Bro� otrzymasz po �mierci//ponownym zalogowaniu))");
					SetPVarInt(playerid, "mozeUsunacBronie", 1);
					RemovePlayerWeaponsTemporarity(playerid);
				}
			}
			else
			{
				SendClientMessage(playerid, COLOR_RED, "Zosta�e� wyrzucony z Urz�du przez agent�w USSS, spr�buj p�niej.");
				SendClientMessage(playerid, COLOR_WHITE, "[Czas wyrzucenia: 10 minut]");
				noAccessCome[playerid] = 1; 
				return 1;
			}
		}
		else
		{

			SendClientMessage(playerid,COLOR_RED,"|_________________Godziny pracy Urz�du_________________|");
			SendClientMessage(playerid,COLOR_WHITE,"                   {ADFF2F}�Poniedzia�ek - Pi�tek:");
			SendClientMessage(playerid,COLOR_WHITE,"                          Od 18:00 do 19:00");
			SendClientMessage(playerid,COLOR_WHITE,"");
			SendClientMessage(playerid,COLOR_RED,"             **********************************************");
			SendClientMessage(playerid,COLOR_WHITE,"                  {DDA0DD}�Sobota- Niedziela");
			SendClientMessage(playerid,COLOR_WHITE,"                          Od 15:00 do 16:00");
			SendClientMessage(playerid,COLOR_WHITE,"");
			SendClientMessage(playerid,COLOR_RED,"|____________>>> Urz�d Miasta Los Santos <<<____________|");
			noAccessCome[playerid] =1; 
			return 1;
		}	
	}
	else if(Check_ID == 2)
	{
		SendClientMessage(playerid, -1, "Powodzenia podczas egzaminu praktycznego!"); 
		GameTextForPlayer(playerid, "~n~~r~Powodzenia", 5000, 1); 	
	}	
	else if(Check_ID == 3)
	{
		if(doorFBIStatus == 0 && !IsPlayerInGroup(playerid, FRAC_FBI))
		{
			SendClientMessage(playerid, COLOR_WHITE, "Drzwi s� zamkni�te"); 
			noAccessCome[playerid] =1; 
			return 1;
		}
		else
		{
			SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Biurowiec FBI w Los Santos Wita! <<<<");
			SendClientMessage(playerid, COLOR_WHITE, "-> Recepcja znajduje si� po twojej lewej stronie");
			SendClientMessage(playerid, COLOR_WHITE, "-> Wej�cie do wi�zienia stanowego na wprost"); 
			SendClientMessage(playerid, COLOR_WHITE, "-> Winda znajduje si� za recepcj�");
			SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Federal Bureau of Investigation <<<<");
			GameTextForPlayer(playerid, "~w~Witamy w~y~ Biurowcu ~b~FBI~n~~r~by UbunteQ & Iwan", 5000, 1);
		}
	}
	else if(Check_ID == 4)
	{
		sendTipMessageEx(playerid, COLOR_RED, "=====Verte Bank Los Santos=====");
		sendTipMessage(playerid, "* Aby zarz�dza� swoim kontem wpisz /kontobankowe (/kb)");
		sendTipMessage(playerid, "* Sejf znajduje si� 10m pod ziemi� --> Bezpieczna lokata!");
	}
	else if(Check_ID == 5) 
	{
		sendTipMessageEx(playerid, COLOR_RED, "=====Verte Bank Palomino Creek=====");
		sendTipMessage(playerid, "* Aby zarz�dza� swoim kontem wpisz /kontobankowe (/kb)");
		sendTipMessage(playerid, "* Sejf znajduje si�  6m pod ziemi� --> Bezpieczna lokata!");	
	}
	else if(Check_ID == 6) //bonehead club
	{
		//tutaj ewentualne link do muzyki - odkomentowa� ni�ej
		//new muzik[128];
		//PlayAudioStreamForPlayer(playerid,muzik,2447.8284,-1963.1549,13.5469,100,0);
	}
	else if(Check_ID == 7)//Wejscie do VINYL
	{
		if(vinylStatus == 0)
		{
			if(!IsPlayerInGroup(playerid, FRAC_SN))
			{
				sendErrorMessage(playerid, "Klub jest teraz zamkni�ty!"); 
				return 1;
			}
		}
		else
		{
			if(GetPVarInt(playerid, "Vinyl-bilet") == 0)
			{
				if(!IsPlayerInGroup(playerid, FRAC_SN))
				{
					sendErrorMessage(playerid, "Nie posiadasz biletu do Vinyl Club"); 
					noAccessCome[playerid] = 1; 
					return 1;
				}
			}
		}
		SetPlayerTW(playerid, 5000, 1, 6); 
		PlayAudioStreamForPlayer(playerid, VINYL_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	else if(Check_ID == 8)
	{
		if(GetPVarInt(playerid, "Vinyl-bilet") != 2 && !IsPlayerInGroup(playerid, FRAC_SN))
		{
			sendErrorMessage(playerid, "Brak dost�pu do strefy V.I.P"); 
			noAccessCome[playerid] = 1; 
			return 1;
		}
		SetPlayerTW(playerid, 5000, 1, 6); 
		PlayAudioStreamForPlayer(playerid, VINYL_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	else if(Check_ID == 9)
	{
		if(!IsPlayerInGroup(playerid, FRAC_SN))
		{
			sendTipMessage(playerid, "Ups! Wygl�da na to, �e drzwi s� zamkni�te"); 
			noAccessCome[playerid] = 1; 
			return 1;
		}
		else
		{
			GameTextForPlayer(playerid, "~w~Scena DJ", 5000, 1);
		}
	}
	else if(Check_ID == 10)
	{
		GameTextForPlayer(playerid, "~w~Witamy w Klubie by~n~  ~h~~g~MrN", 5000, 1);
		PlayAudioStreamForPlayer(playerid, VINYL_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);	
	}
	else if(Check_ID == 11)
	{
		GameTextForPlayer(playerid, "~w~By ~r~Sergio ~w~& ~r~ Deduir", 5000, 1); 
	}
	else if(Check_ID == 12)//Do to poprawy
	{
		if(!DoorInfo[FRAC_LCN][d_State] && !IsPlayerInGroup(playerid, FRAC_LCN))
		{
			sendErrorMessage(playerid, "Te drzwi s� zamkni�te"); 
			noAccessCome[playerid] = 1; 
			return 1;
		}
	}
	else if(Check_ID == 13)
	{

	}
	else if(Check_ID == 14)
	{
		sendTipMessageEx(playerid, COLOR_GREEN, "======[Los Santos MMA 2]======");
		sendTipMessageEx(playerid, COLOR_P@, "Sponsorzy:");
		sendTipMessage(playerid, "San News;");
		sendTipMessageEx(playerid, COLOR_P@, "W�odarze:");
		sendTipMessage(playerid, "Beyonce Bennett"); 
		sendTipMessageEx(playerid, COLOR_P@, "Walka wieczoru:"); 
		sendTipMessage(playerid, "BRAK USTALONEJ"); 
		sendTipMessageEx(playerid, COLOR_GREEN, "===========[Fight]===========");
		GameTextForPlayer(playerid, "~w~By~n~~r~Dreptacz", 5000, 1); 
	}
	else if(Check_ID == 15)
	{
		GameTextForPlayer(playerid, "~w~By~n~~g~Dreptacz", 5000, 1); 
		sendTipMessage(playerid, "Zapraszamy na rze�!");

	}
	else if(Check_ID == 16)//Wi�zienie stanowe - wej�cie i wyj�cie
	{
		if(!IsAPolicja(playerid, 0) && !IsABOR(playerid, 0) && PlayerInfo[playerid][pJob] != 2 && !CheckPlayerPerm(playerid, PERM_LAWYER))
		{
			SendClientMessage(playerid, COLOR_WHITE, "Simon_Mrucznikov m�wi: Zaraz zaraz kolego! A ty gdzie? Nie mo�esz tu wej��!"); 
			noAccessCome[playerid] = 1;
			return 1;
		}
		GameTextForPlayer(playerid, "~w~by~n~Simeone & Rozalka", 5000, 1);
	}
	else if(Check_ID == 17)//Sekta rozalki, vw=20 pod cmenatrzem przy kasynie
	{
		if(SektaKey[playerid] == 0 && !CheckPlayerPerm(playerid, PERM_SEKTA)) 
    	{
			noAccessCome[playerid] = 1; 
			return 1;
		}
	}
	else if(Check_ID == 18 || Check_ID == 19) //ibiza audio
	{
		PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	else if(Check_ID == 20)
	{
		if(GunshopLSLock == 1)
		{
			sendTipMessage(playerid, "Drzwi s� zamkni�te.");
			noAccessCome[playerid] = 1;
			return 1;
		}
	}
	else if(Check_ID == 21) //bar HA
	{
		GameTextForPlayer(playerid, "~w~Bar by ~p~~h~Just Miko & skBarman", 5000, 1);
		return 1;
	}
	else if(Check_ID == 38) //Camorra
	{
	}
	else if(Check_ID == 45) //AS Pizzeria
	{
		if(!DoorInfo[28][d_State] && !IsPlayerInGroup(playerid, 28))
		{
			sendErrorMessage(playerid, "Te drzwi s� zamkni�te");
			noAccessCome[playerid] = 1;
			return 1;
		}
		GameTextForPlayer(playerid, "~w~Smacznego!", 5000, 1);
		sendTipMessage(playerid, "Je�eli w restauracji nikogo nie ma, wpisz /kupjedzenie przy ladzie.");
	}
	return 0; 
}
Sprawdz_UID_Wychodzenie(playerid, Check_ID)
{
	if(Check_ID == 10)
	{
		StopAudioStreamForPlayer(playerid); 
	}
	else if(Check_ID == 6)
	{
		StopAudioStreamForPlayer(playerid);	
	}
	else if(Check_ID == 13)
	{
		GameTextForPlayer(playerid, "~w~Zapraszamy ponownie!", 5000, 1);
	}
	else if(Check_ID == 17)//Sekta rozalki, vw=20 pod cmenatrzem przy kasynie
	{
		if(SektaKey[playerid] == 0 && !CheckPlayerPerm(playerid, PERM_SEKTA)) 
    	{
			noAccessCome[playerid] = 1; 
			return 1;
		}
	}
	else if(Check_ID == 25)
	{
	}
	else if(Check_ID == 38) //Camorra
	{
	}
	else if(Check_ID == 45)
	{
		GameTextForPlayer(playerid, "~w~Zapraszamy ponownie!", 5000, 1);
	}
	else if(Check_ID == 2)
	{
		if(dmv == 1 || IsAnInstructor(playerid) || IsABOR(playerid))
		{
			if(wywalzdmv[playerid] == 0)
			{
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> Urz�d Miasta w Los Santos Wita! <<<<");
				SendClientMessage(playerid, COLOR_WHITE, "-> Cennik znajduje si� zaraz za rogiem, po prawej stronie.");
				SendClientMessage(playerid, COLOR_WHITE, "-> Znajdujesz si� na najwy�szym poziomie, winda znajduje si� w holu g��wnym");
				SendClientMessage(playerid, COLOR_WHITE, "-> Okienka dla patent�w znajduj� si� po lewej i prawej stronie w holu pierwszym");
				SendClientMessage(playerid, COLOR_WHITE, "-> [Obecny interior urz�du powsta� w listopadzie 2018 roku, za inicjatyw� Satius & Arkam & Simeone]");
				SendClientMessage(playerid, COLOR_LIGHTGREEN, ">>>> �yczymy przyjemnego czekania na licencje! <<<<");
				GameTextForPlayer(playerid, "~n~~g~By Satius", 5000, 1);
				
				
				if(!GroupPlayerDutyPerm(playerid, PERM_POLICE) // Nie jest PD
				&& !GroupPlayerDutyPerm(playerid, PERM_BOR))
				{
					SendClientMessage(playerid, COLOR_PANICRED, "****Piip! Piip! Piip!*****");
					SendClientMessage(playerid, COLOR_WHITE, "Przechodz�c przez wykrywacz metalu s�yszysz alarm.");
					SendClientMessage(playerid, COLOR_WHITE, "Dopiero teraz dostrzegasz czerwon� tabliczk� informuj�c� o zakazie");
					SendClientMessage(playerid, COLOR_WHITE, "Nie chcesz k�opot�w, wi�c oddajesz sw�j arsena� agentowi USSS.");
					SendClientMessage(playerid, COLOR_PANICRED, "((Bro� otrzymasz po �mierci//ponownym zalogowaniu))");
					SetPVarInt(playerid, "mozeUsunacBronie", 1);
					RemovePlayerWeaponsTemporarity(playerid);
				}
			}
			else
			{
				sendErrorMessage(playerid, "Zosta�e� wyrzucony z urz�du!, nie pr�buj wchodzi� tylnim wej�ciem");
				noAccessCome[playerid] =1;
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Brak dost�pu do tego wej�cia"); 
			return 1;
		}
	}
	else if(Check_ID == 16)//Wi�zienie stanowe - g��wne wej�cie
	{
		if(PlayerInfo[playerid][pJailed] > 0)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Pavlo_Rudovy m�wi: Koleszko? Nie pomyli�o Ci si� co�? Wracaj do celi!!"); 
			noAccessCome[playerid] =1;
			return 1;
		}
		GameTextForPlayer(playerid, "~w~by~n~Simeone & Rozalka", 5000, 1);
	}
	else if(Check_ID == 18) //ibiza audio
	{
		PlayAudioStreamForPlayer(playerid, IBIZA_Stream,VinylAudioPos[0],VinylAudioPos[1],VinylAudioPos[2], VinylAudioPos[3], 1);
	}
	else if(Check_ID == 19)
	{
		StopAudioStreamForPlayer(playerid); 
	}
	else if(Check_ID == 20)
	{
		if(GunshopLSLock == 1)
		{
			sendTipMessage(playerid, "Drzwi s� zamkni�te.");
			noAccessCome[playerid] = 1;
			return 1;
		}
	}
	return 0; 
}
SprawdzWejscia(playerid)
{
	for(new i; i<iloscwejsc; i++)
	{
		if(Sprawdz_w_cord(playerid, i) == OUT_INTERIOR)
		{
			Sprawdz_UID_Wchodzenie(playerid, wejscia[i][w_UID]);
			if(noAccessCome[playerid] == 1)
			{
				noAccessCome[playerid] = 0;
				return 1;
			}
			SetPlayerPos(playerid,  wejscia[i][w_x2],  wejscia[i][w_y2], wejscia[i][w_z2]);
			SetPlayerInterior(playerid, wejscia[i][w_int2]);
			SetPlayerVirtualWorld(playerid, wejscia[i][w_vw2]);
			PlayerInfo[playerid][pLocal] = wejscia[i][w_pLocal];
			PlayerInfo[playerid][pDoor] = i;
			SetInteriorTimeAndWeather(playerid);
			fixActorsTimer[playerid] = SetTimerEx("ActorsFix", 4000, 0, "i", playerid);
			Wchodzenie(playerid);
			return 1;
		}
		if(Sprawdz_w_cord(playerid, i) == IN_INTERIOR)
		{
			Sprawdz_UID_Wychodzenie(playerid, wejscia[i][w_UID]);
			if(noAccessCome[playerid] == 1)
			{
				noAccessCome[playerid] = 0;
				return 1;
			}
			SetPlayerPos(playerid,  wejscia[i][w_x1],  wejscia[i][w_y1], wejscia[i][w_z1]);
			SetPlayerInterior(playerid, wejscia[i][w_int1]);
			SetPlayerVirtualWorld(playerid, wejscia[i][w_vw1]);
			PlayerInfo[playerid][pLocal] = PLOCAL_DEFAULT;
			PlayerInfo[playerid][pDoor] = 0;
			SetServerWeatherAndTime(playerid);
			fixActorsTimer[playerid] = SetTimerEx("ActorsFix", 4000, 0, "i", playerid);
			Wchodzenie(playerid);
			return 1;
		}
	}
	if(!IsPlayerInAnyVehicle(playerid))
	{
		for(new iduo; iduo<valueWjedz; iduo++)
		{
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[iduo][RangeofPoint], wjazdy[iduo][wj_X], wjazdy[iduo][wj_Y], wjazdy[iduo][wj_Z]))//Wej�cie
			{
				if(wjazdy[iduo][pFracOwn] == 0 && wjazdy[iduo][pOrgOwn] == 0)
				{
					SetPlayerVirtualWorld(playerid, wjazdy[iduo][wj_VW]);
					SetPLocal(playerid, wjazdy[iduo][wj_PLOCAL]);
					SetPlayerPos(playerid, wjazdy[iduo][wy_X], wjazdy[iduo][wy_Y], wjazdy[iduo][wy_Z]);
					return 1;
				}
				if(wjazdy[iduo][pFracOwn] > 0 || wjazdy[iduo][pOrgOwn] > 0)
				{
					if(IsPlayerInGroup(playerid, wjazdy[iduo][pFracOwn]))
					{
						SetPlayerVirtualWorld(playerid, wjazdy[iduo][wj_VW]);
						SetPLocal(playerid, wjazdy[iduo][wj_PLOCAL]);
						SetPlayerPos(playerid, wjazdy[iduo][wy_X], wjazdy[iduo][wy_Y], wjazdy[iduo][wy_Z]);
					}
				}
				
			}
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[iduo][RangeofPoint], wjazdy[iduo][wy_X], wjazdy[iduo][wy_Y], wjazdy[iduo][wy_Z]))
			{
				SetPlayerVirtualWorld(playerid, 0);
				SetPLocal(playerid, PLOCAL_DEFAULT);
				SetPlayerPos(playerid, wjazdy[iduo][wj_X], wjazdy[iduo][wj_Y], wjazdy[iduo][wj_Z]);
			}
		
		}
	}
	return 0;
}

GetClosestDoor(playerid)
{
	for(new i = 0; i < iloscwejsc; i++)
	{
		if(Sprawdz_w_cord(playerid, i) == OUT_INTERIOR || Sprawdz_w_cord(playerid, i) == IN_INTERIOR)
			return i;
	}
	return 0;
}


//-------------------
//-----[ Wjedz ]-----
//-------------------
StworzWjedz(Float:wjedzX, Float:wjedzY, Float:wjedzZ, Float:wyjedzX, Float:wyjedzY, Float:wyjedzZ, Float:RangePoint, VW, MessageIN[]=" ", MessageOut[]=" ", FracOwner=0, OrgOwner=0, local)
{
	wjazdy[valueWjedz][wj_X] = wjedzX;
	wjazdy[valueWjedz][wj_Y] = wjedzY;
	wjazdy[valueWjedz][wj_Z] = wjedzZ;
	wjazdy[valueWjedz][wy_X] = wyjedzX;
	wjazdy[valueWjedz][wy_Y] = wyjedzY;
	wjazdy[valueWjedz][wy_Z] = wyjedzZ;
	wjazdy[valueWjedz][wj_VW] = VW;
	wjazdy[valueWjedz][wj_PLOCAL] = local;
	wjazdy[valueWjedz][pFracOwn] = FracOwner;
	wjazdy[valueWjedz][pOrgOwn] = OrgOwner;
	wjazdy[valueWjedz][RangeofPoint] = RangePoint;

/*
	CreateDynamicPickup(1239, 2, wjedzX, wjedzY, wjedzZ, 0, 0);
	CreateDynamicPickup(1239, 2, wyjedzX, wyjedzY, wyjedzZ, VW, 0);
	
*/
	if(isnull(MessageIN)) 
	{
		CreateDynamicPickup(1239, 2, wjedzX, wyjedzY, wjedzZ, 0, 0);
	}
	else  
	{
		CreateDynamic3DTextLabel(MessageIN, COLOR_RED, wjedzX, wjedzY, wjedzZ, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0);
	}
	if(isnull(MessageOut)) 
	{
		CreateDynamicPickup(1239, 2, wyjedzX, wyjedzY, wyjedzZ, VW, 0);
	}
	else 
	{
		CreateDynamic3DTextLabel(MessageOut, COLOR_RED, wyjedzX, wyjedzY, wyjedzZ, 9.5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, VW, 0);
	}
	
	return valueWjedz++;
}
//new 
SprawdzWjazdy(playerid)
{
	if(GetPlayerVehicleSeat(playerid) != 0)
	{
		sendErrorMessage(playerid, "Nie jeste� kierowc�"); 
		return 1;
	}
	new pVehAcID = GetPlayerVehicleID(playerid);
	for(new i; i<valueWjedz; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]))//Wej�cie
		{
			if(wjazdy[i][pFracOwn] > 0 && wjazdy[i][pOrgOwn] > 0)
			{
				if(IsPlayerInGroup(playerid, wjazdy[i][pFracOwn]))
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						TogglePlayerControllable(playerid, 0);
						WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
						PlayerTextDrawShow(playerid, textwjedz[playerid]);
						SetPVarInt(playerid, "JestPodczasWjezdzania", 1);//
						SetPVarInt(playerid, "CodeACDisable", 1);
						SetInteriorTimeAndWeather(playerid);
					}
					else
					{
						sendTipMessage(playerid, "U�yj /wejdz"); 
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Nie mo�esz tutaj wjecha�"); 
				}
			}
			else if(wjazdy[i][pFracOwn] > 0  && wjazdy[i][pOrgOwn] == 0)
			{
				if(IsPlayerInGroup(playerid, wjazdy[i][pFracOwn]))
				{
					if(IsPlayerInAnyVehicle(playerid))
					{
						TogglePlayerControllable(playerid, 0);
						WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
						PlayerTextDrawShow(playerid, textwjedz[playerid]);
						SetPVarInt(playerid, "JestPodczasWjezdzania", 1);
						SetPVarInt(playerid, "CodeACDisable", 1);//wylaczenie ac
						SetInteriorTimeAndWeather(playerid);
					}
					else
					{
						sendTipMessage(playerid, "U�yj /wejdz");
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Nie mo�esz tutaj wjecha�"); 
				}
			
			}
			else if(wjazdy[i][pFracOwn] == 0 && wjazdy[i][pOrgOwn] == 0)
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					TogglePlayerControllable(playerid, 0);
					WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
					PlayerTextDrawShow(playerid, textwjedz[playerid]);
					SetPVarInt(playerid, "JestPodczasWjezdzania", 1);
					SetPVarInt(playerid, "CodeACDisable", 1);//wylaczenie ac
					SetInteriorTimeAndWeather(playerid);
				}
				else
				{
					sendTipMessage(playerid, "U�yj /wejdz"); 
					return 1;
				}
			}
			foreach(new i2 : Player)
			{
				if(GetPlayerVehicleID(i2) == pVehAcID && GetPlayerVehicleSeat(i2) != 0)
				{
					WjedzTimer[i2] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", i2);
					SetPVarInt(i2, "JestPodczasWjezdzaniaPasazer", 1);
					SetPVarInt(i2, "CodeACDisable", 1);//wylaczenie ac
					SetPVarInt(i2, "pSeatIDE", GetPlayerVehicleSeat(i2));
					TogglePlayerControllable(i2, 0);
					SetInteriorTimeAndWeather(i2);
				}
			}
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]))//wyjcie
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				TogglePlayerControllable(playerid, 0);
				WjedzTimer[playerid] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", playerid);
				PlayerTextDrawShow(playerid, textwjedz[playerid]);
				SetAntyCheatForPlayer(playerid, 4);
				SetPVarInt(playerid, "JestPodczasWjezdzania", 1); 
				SetServerWeatherAndTime(playerid); 
				
				foreach(new i2 : Player)
				{
					if(GetPlayerVehicleID(i2) == pVehAcID && GetPlayerVehicleSeat(i2) != 0)
					{
						KillTimer(WjedzTimer[i2]);
						WjedzTimer[i2] = SetTimerEx("WjedzTimerDebug", 2500, true, "i", i2);
						SetPVarInt(i2, "JestPodczasWjezdzaniaPasazer", 1);
						SetPVarInt(i2, "pSeatIDE", GetPlayerVehicleSeat(i2));
						TogglePlayerControllable(i2, 0); 
						SetServerWeatherAndTime(i2); 
						SetAntyCheatForPlayer(i2, 4);
						sendTipMessage(playerid, "Zmienianie pogody - pomy�lnie wykonano!");
					}
				}
			}
			else
			{
				sendTipMessage(playerid, "U�yj /wejdz"); 
				return 1;
			}
			return 1;
		}
		
	}
	return 0;
}
forward WjedzTimerDebug(playerid);
public WjedzTimerDebug(playerid)
{
	new pVehAcID = GetPlayerVehicleID(playerid);
	timeSecWjedz[playerid]++; 
	if(timeSecWjedz[playerid] == 2)
	{
		for(new i; i<valueWjedz; i++)
		{
		
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]))//Wej�cie
			{
				if(GetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer") == 1)
				{
					TogglePlayerControllable(playerid, 1);
					SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
					TogglePlayerControllable(playerid, 0);
					sendTipMessage(playerid, "Ustalanie VW - Ustalono"); 
					return 1;
				}
				RemovePlayerFromVehicle(playerid);
				SetPlayerVirtualWorld(playerid, wjazdy[i][wj_VW]);
				SetVehicleVirtualWorld(pVehAcID, wjazdy[i][wj_VW]);	
			}
			else if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]))//Wyjscie
			{
				if(GetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer") == 1)
				{
					TogglePlayerControllable(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					TogglePlayerControllable(playerid, 1);
					sendTipMessage(playerid, "Ustalanie VW - Ustawiono"); 
					return 1;
				}
				RemovePlayerFromVehicle(playerid);
				SetPlayerVirtualWorld(playerid, 0);
				SetVehicleVirtualWorld(pVehAcID, 0);
			}
			
		}
		PutPlayerInVehicle(playerid, pVehAcID, 0);
	}
	if(timeSecWjedz[playerid] == 3)
	{
		for(new i; i<valueWjedz; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]))//Wej�cie
			{
				if(GetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer") == 1)
				{
					new pSeat = GetPVarInt(playerid, "pSeatIDE"); 
					TogglePlayerControllable(playerid, 1);
					PutPlayerInVehicle(playerid, pVehAcID, pSeat);
					KillTimer(WjedzTimer[playerid]);
					SetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer", 0);
					SetPVarInt(playerid, "CodeACDisable", 0);
					SetAntyCheatForPlayer(playerid, 0);
					sendTipMessage(playerid, "Wykonano wjed� dla pasa�era"); 
					timeSecWjedz[playerid]=0; 
					return 1;
				}
				SetVehiclePos(pVehAcID, wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]);
				new pVeh2 = GetPlayerVehicleID(playerid);
				CarData[VehicleUID[pVeh2][vUID]][c_VW] = wjazdy[i][wj_VW]; 
				SetAntyCheatForPlayer(playerid, 0);
			}
			else if(IsPlayerInRangeOfPoint(playerid, wjazdy[i][RangeofPoint], wjazdy[i][wy_X], wjazdy[i][wy_Y], wjazdy[i][wy_Z]))//Wej�cie
			{
				if(GetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer") == 1)
				{
					new pSeat = GetPVarInt(playerid, "pSeatIDE"); 
					TogglePlayerControllable(playerid, 1);
					PutPlayerInVehicle(playerid, pVehAcID, pSeat);
					KillTimer(WjedzTimer[playerid]);
					SetPVarInt(playerid, "JestPodczasWjezdzaniaPasazer", 0);
					SetPVarInt(playerid, "CodeACDisable", 0);
					SetAntyCheatForPlayer(playerid, 0);
					sendTipMessage(playerid, "Wykonano wyjed� dla pasa�era!"); 
					timeSecWjedz[playerid] = 0; 
					return 1;
				}
				SetVehiclePos(pVehAcID, wjazdy[i][wj_X], wjazdy[i][wj_Y], wjazdy[i][wj_Z]);
			}
		}
		PlayerTextDrawHide(playerid, textwjedz[playerid]);
		TogglePlayerControllable(playerid, 1);
		timeSecWjedz[playerid] = 0;
		SetPVarInt(playerid, "JestPodczasWjezdzania", 0);
		KillTimer(WjedzTimer[playerid]);
		SetPVarInt(playerid, "CodeACDisable", 0);
		SetAntyCheatForPlayer(playerid, 0);
	}
	return 1;
}

stock LoadDoorsState()
{
	for(new i = 0; i < MAX_DOORS; i++)
		DoorInfo[i][d_State] = true;
	return 1;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end