//---------------------------------------------<< Callbacks >>-----------------------------------------------//
//                                                  pojazdy                                                  //
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
// Data utworzenia: 04.05.2019
//Opis:
/*
	System pojazd�w.
*/

//
#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnGameModeInit()
{
	RefreshSalon();
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{
	if(playertextid == Salon_Button[playerid][0])
	{
		DestroySalonDialog(playerid);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
		ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
	}
	else if(playertextid == Salon_Button[playerid][1])
	{
		DestroySalonDialog(playerid);
		ShowPlayerCarDialog(playerid, GetPVarInt(playerid, "SalonCurrentType"));
		pojazdid[playerid] = 0;
		CenaPojazdu[playerid] = 0;
	}
	return 1;
}

pojazdy_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 443)
	{
		if(response)
		{
			new lUID = PlayerInfo[playerid][pKluczeAuta];
			if(lUID == 0) return 1;

			new idx = Car_GetIDXFromUID(lUID);
			if(idx == -1) return 1;
			if(CarData[idx][c_Keys] != PlayerInfo[playerid][pUID])
			{
				SendClientMessage(playerid, COLOR_NEWS, "Kluczyki od tego pojazdu zosta�y zabrane przez w�a�ciciela.");
				PlayerInfo[playerid][pKluczeAuta] = 0;
				return 1;
			}
			switch(listitem)
			{
				case 0://spawnuj kluczyki - tu jest bug?
				{
					if(CarData[idx][c_ID] != 0)
					{
						SendClientMessage(playerid, 0xFFC0CB, "Pojazd do kt�rego masz kluczyki jest ju� zespawnowany");
						return 1;
					}
					Car_Spawn(idx);
					Log(serverLog, WARNING, "Gracz %s zespawnowa� pojazd %s", GetPlayerLogName(playerid), GetCarDataLogName(idx));
					SendClientMessage(playerid, 0xFFC0CB, "Tw�j pojazd zosta� zrespawnowany");
					
				}
				case 1://Znajd�
				{
					new Float:autox, Float:autoy, Float:autoz;
					new pojazdszukany = CarData[idx][c_ID];
					if(pojazdszukany == 0) return 1;
					GetVehiclePos(pojazdszukany, autox, autoy, autoz);
					SetPlayerCheckpoint(playerid, autox, autoy, autoz, 6);
					SetTimerEx("SzukanieAuta",30000,0,"d",playerid);
					SendClientMessage(playerid, 0xFFC0CB, "Jed� do czerwonego markera");

				}
				case 2://Poka� parking
				{
					SetPlayerCheckpoint(playerid, CarData[idx][c_Pos][0],CarData[idx][c_Pos][1],CarData[idx][c_Pos][2], 6);
					SetTimerEx("SzukanieAuta",30000,0,"d",playerid);
					SendClientMessage(playerid, 0xFFC0CB, "Jed� do czerwonego markera");

				}
			}
		}
	}
	else if(dialogid == D_AUTO_RESPAWN)//Potwierdzenie Respawnuj
	{
		if(response)
		{
			if(kaska[playerid] >= PRICE_CAR_RESPAWN)
			{
				new vehicleid;

				if((vehicleid = CarData[IloscAut[playerid]][c_ID]) != 0)
				{
					Car_Unspawn(vehicleid);
					Car_Spawn(IloscAut[playerid]);
					Log(serverLog, WARNING, "Gracz %s zrespawnowa� pojazd %s", GetPlayerLogName(playerid), GetCarDataLogName(IloscAut[playerid]));

					ZabierzKaseDone(playerid, PRICE_CAR_RESPAWN);
					SendClientMessage(playerid, 0xFFC0CB, "Pojazd zosta� zrespawnowany. Koszt: {FF0000}"#PRICE_CAR_RESPAWN"$");
				}
				else
				{
					SendClientMessage(playerid, 0xFFC0CB, "Ten pojazd nie jest zespawnowany");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, 0xFFC0CB, "Nie sta� ci�!");
				ShowCarsForPlayer(playerid, playerid);
			}
		}
		if(!response)
		{
			ShowCarsForPlayer(playerid, playerid);
		}
	}
	else if(dialogid == D_AUTO_UNSPAWN)//Potwierdzenie Unspawnuj
	{
		if(response)
		{
			if(kaska[playerid] >= PRICE_CAR_RESPAWN)
			{
				new vehicleid;

				if((vehicleid = CarData[IloscAut[playerid]][c_ID]) != 0)
				{
					Car_Unspawn(vehicleid);
					Log(serverLog, WARNING, "Gracz %s unspawnowa� pojazd %s", GetPlayerLogName(playerid), GetCarDataLogName(IloscAut[playerid]));

					ZabierzKaseDone(playerid, PRICE_CAR_RESPAWN);
					SendClientMessage(playerid, 0xFFC0CB, "Pojazd zosta� unspawnowany. Koszt: {FF0000}"#PRICE_CAR_RESPAWN"$");
				}
				else
				{
					SendClientMessage(playerid, 0xFFC0CB, "Ten pojazd nie jest zespawnowany");
					return 1;
				}
			}
			else
			{
				SendClientMessage(playerid, 0xFFC0CB, "Nie sta� ci�!");
				ShowCarsForPlayer(playerid, playerid);
			}
		}
		if(!response)
		{
			ShowCarsForPlayer(playerid, playerid);
		}
	}
	else if(dialogid == D_AUTO)
	{
		if(!response) return 1;
		new lUID = strval(inputtext);
		
		if(lUID < 0)
		{
			ShowCarsForPlayer(playerid, playerid);
			SendClientMessage(playerid, COLOR_RED, "� Ten pojazd jest zablokowany, skontaktuj si� z administratorem.");
			return 1;
		}

		new i = lUID;
		if(CarData[i][c_Owner] != PlayerInfo[playerid][pUID])
		{
			for(new j = 0; j<10; j++)
			{
				if(PlayerInfo[playerid][pCars][j] == lUID)
				{
					PlayerInfo[playerid][pCars][j] = 0;
				}
			}
			ShowCarsForPlayer(playerid, playerid);
			SendClientMessage(playerid, COLOR_RED, "� Ten pojazd jest zbugowany i nie nale�y do Ciebie, skontaktuj si� z administratorem.");
			Log(errorLog, WARNING, "%s zosta� odebrany pojazd UID: %d z powodu b��du z duplikatem aut (niepoprawny w�a�ciciel)",
				GetPlayerLogName(playerid), 
				lUID
			);
			return 1;
		}

		new string[2048];
		format(string, sizeof(string), "{FFFFFF}Spawnuj\nRespawnuj\nUnspawnuj\nZnajd�\nPoka� parking\nZ�omuj\nUsuwanie tuningu\n{E2BA1B}Tablica rejestracyjna (KP){FFFFFF}");
		ShowPlayerDialogEx(playerid, D_AUTO_ACTION, DIALOG_STYLE_LIST, "Panel pojazdu", string, "Wybierz", "Wyjd�");
		IloscAut[playerid] = lUID;
		return 1;
	}
	if(dialogid == D_AUTO_ACTION)
	{
		if(!response)
		{
			DestroySalonDialog(playerid);
			ShowCarsForPlayer(playerid, playerid);
			return 1;
		}
		new lUID = IloscAut[playerid];
		switch(listitem)
		{
			case 0:
			{
				if(CarData[lUID][c_ID] == 0)
				{
					Car_Spawn(lUID);
					Log(serverLog, WARNING, "Gracz %s zrespawnowa� pojazd %s", GetPlayerLogName(playerid), GetCarDataLogName(lUID));
					SendClientMessage(playerid, COLOR_WHITE, "Tw�j pojazd zosta� {2DE9B1}zespawnowany{FFFFFF}!");
				}
				else
				{
					SendClientMessage(playerid, COLOR_WHITE, "Tw�j pojazd jest ju� {2DE9B1}zespawnowany{FFFFFF}, stoi tam gdzie go zostawi�e�!");
				}
			}
			case 1:
			{
				ShowPlayerDialogEx(playerid, D_AUTO_RESPAWN, DIALOG_STYLE_MSGBOX, "Respawnuj w�z", "Czy na pewno chcesz zrespawnowa� � ten w�?\nKoszt respawnu wozu to {FF0000}"#PRICE_CAR_RESPAWN"${FFFAFA}!!!", "Respawnuj", "Anuluj");
			}
			case 2: 
			{
				ShowPlayerDialogEx(playerid, D_AUTO_UNSPAWN, DIALOG_STYLE_MSGBOX, "Unspawnuj w�z", "Czy na pewno chcesz unspawnowa� ten w�?\nKoszt unspawnowania wozu to {FF0000}"#PRICE_CAR_RESPAWN"${FFFAFA}!!!", "Unspawnuj", "Anuluj");
			}
			case 3://Znajd�
			{
				if(CarData[lUID][c_ID] == 0) return SendClientMessage(playerid, 0xFFC0CB, "Auto nie jest zespawnowane.");
				new Float:autox, Float:autoy, Float:autoz;
				new pojazdszukany = CarData[lUID][c_ID];
				GetVehiclePos(pojazdszukany, autox, autoy, autoz);
				SetPlayerCheckpoint(playerid, autox, autoy, autoz, 6);
				SetTimerEx("SzukanieAuta",30000,0,"d",playerid);
				SendClientMessage(playerid, 0xFFC0CB, "Lokalizacja pojazdu zosta�a oznaczona na mapie.");
			}
			case 4://Poka� parking
			{
				SetPlayerCheckpoint(playerid, CarData[lUID][c_Pos][0],CarData[lUID][c_Pos][1],CarData[lUID][c_Pos][2], 6);
				SetTimerEx("SzukanieAuta",30000,0,"d",playerid);
				SendClientMessage(playerid, 0xFFC0CB, "Lokalizacja pojazdu zosta�a oznaczona na mapie.");
			}
			case 5://Z�omuj
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(CarData[lUID][c_ID] == 0) return SendClientMessage(playerid, 0xFFC0CB, "Auto nie jest zespawnowane!");
					if(CarData[lUID][c_ID] != GetPlayerVehicleID(playerid)) return SendClientMessage(playerid, 0xFFC0CB, "Nie siedzisz w aucie, ktore chcesz zezlomowac!");
					ShowPlayerDialogEx(playerid, D_AUTO_DESTROY, DIALOG_STYLE_MSGBOX, "Z�omowanie wozu", "Czy na pewno chcesz zez�omowa� ten w�z? Zarobisz na tym tylko 200$!", "Z�OMUJ", "WYJD�");
				}
			}
			case 6://Usu� tuning
			{
				new string[2048];
				format(string, sizeof(string), "Usu� tuning - NITRO\nUsu� tuning - HYDRAULIKA\nUsu� tuning - FELGI\nUsu� tuning - MALUNEK\nUsu� tuning - SPOJLER\nUsu� tuning - ZDERZAKI");
				ShowPlayerDialogEx(playerid, D_AUTO_ACTION_TUNING, DIALOG_STYLE_LIST, "Panel pojazdu", string, "Wybierz", "Wyjd�");
			}
			case 7://rejestracja (NumberPlate)
			{
				if(!IsPlayerPremiumOld(playerid)) return sendTipMessage(playerid, "Nie posiadasz konta premium! Wpisz /kp.");
				ShowPlayerDialogEx(playerid, D_AUTO_REJESTRACJA, DIALOG_STYLE_INPUT, "Rejestracja", "Wprowad� nowy numer/tekst na swojej tablicy rejestracyjnej\n(do 9 znak�w):", "Ustaw", "Wr��");
			}
		}
		return 1;
	}
	if(dialogid == D_AUTO_ACTION_TUNING)
	{
		if(!response)
		{
			new string[2048];
			format(string, sizeof(string), "{FFFFFF}Spawnuj\nRespawnuj\nUnspawnuj\nZnajd�\nPoka� parking\nZ�omuj\nUsuwanie tuningu\n{E2BA1B}Tablica rejestracyjna (KP){FFFFFF}");
			ShowPlayerDialogEx(playerid, D_AUTO_ACTION, DIALOG_STYLE_LIST, "Panel pojazdu", string, "Wybierz", "Wyjd�");
			return 1;
		}
		new lUID = IloscAut[playerid];
		switch(listitem)
		{
			case 0://Usu� tuning
			{
				CarData[lUID][c_Nitro] = 0;
				SendClientMessage(playerid, 0xFFC0CB, "Tuning (NITRO) zostanie usuni�ty przy najbli�szym respawnie.");
			}
			case 1://Usu� tuning
			{
				CarData[lUID][c_bHydraulika] = false;
				SendClientMessage(playerid, 0xFFC0CB, "Tuning (HYDRAULIKA) zostanie usuni�ty przy najbli�szym respawnie.");
			}
			case 2://Usu� tuning
			{
				CarData[lUID][c_Felgi] = 0;
				SendClientMessage(playerid, 0xFFC0CB, "Tuning (FELGI) zostanie usuni�ty przy najbli�szym respawnie.");
			}
			case 3://Usu� tuning
			{
				CarData[lUID][c_Malunek] = 3;
				SendClientMessage(playerid, 0xFFC0CB, "Tuning (MALUNEK) zostanie usuni�ty przy najbli�szym respawnie.");
			}
			case 4://Usu� tuning
			{
				CarData[lUID][c_Spoiler] = 0;
				SendClientMessage(playerid, 0xFFC0CB, "Tuning (SPOJLER) zostanie usuni�ty przy najbli�szym respawnie.");
			}
			case 5://Usu� tuning
			{
				CarData[lUID][c_Bumper][0] = 0;
				CarData[lUID][c_Bumper][1] = 0;
				SendClientMessage(playerid, 0xFFC0CB, "Tuning (ZDERZAKI) zostanie usuni�ty przy najbli�szym respawnie.");
			}
		}
		return 1;
	}
	else if(dialogid == D_AUTO_REJESTRACJA)
	{
		new lUID = IloscAut[playerid];
		if(!response) return RunCommand(playerid, "/car",  "");
		if(strlen(inputtext) < 1 || strlen(inputtext) > 9)
		{
			RunCommand(playerid, "/car",  "");
			SendClientMessage(playerid, COLOR_GRAD1, "Nieodpowiednia ilo�� znak�w.");
			return 1;
		}
		else for (new i = 0, len = strlen(inputtext); i != len; i ++) {
			if ((inputtext[i] >= 'A' && inputtext[i] <= 'Z') || (inputtext[i] >= 'a' && inputtext[i] <= 'z') || (inputtext[i] >= '0' && inputtext[i] <= '9') || (inputtext[i] == ' '))
				continue;
			else return SendClientMessage(playerid, COLOR_GRAD1, "U�y�e� nieodpowiednich znak�w rejestracji (tylko litery i cyfry).");
		}
		CarData[lUID][c_Rejestracja] = strval(inputtext);
		SendClientMessage(playerid, 0xFFC0CB, "Tablica zostanie zmieniona po respawnie.");
		return 1;
	}
	else if(dialogid == 440)
	{
		if(response)
		{
			return ShowPlayerCarDialog(playerid, listitem+1);
		}
	}
	else if(dialogid == 450)
	{
		if(response)
		{
			new id = GetCarSalonSlotFromModel(strval(inputtext));
			if(id == -1) return sendErrorMessage(playerid, "Wyst�pi� b��d! Brak wybranego pojazdu w bazie. Zg�o� to administracji!"); // should never happen
			CreateSalonDialog(playerid, id);
			pojazdid[playerid] = SalonAut[id][sModel];
			CenaPojazdu[playerid] = Salon_ConvertStringToInt(SalonAut[id][sCena]);
		}
		else
		{
			DestroySalonDialog(playerid);
			ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategori� kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka�d� kiesze�\nMotory\nInne pojazdy", "Wybierz", "Wyjd�");
		}
	}
	else if(dialogid == 4001)
	{
		if(response)
		{
			DestroySalonDialog(playerid);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego wozu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
		}
		if(!response)
		{
			DestroySalonDialog(playerid);
			ShowPlayerCarDialog(playerid, GetPVarInt(playerid, "SalonCurrentType"));
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid == 31)
	{
		if(response)
		{
			DestroySalonDialog(playerid);
			switch(listitem)
			{
				case 0:
				{
					KolorPierwszy[playerid] = 0;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 1:
				{
					KolorPierwszy[playerid] = 1;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 2:
				{
					KolorPierwszy[playerid] = 2;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 3:
				{
					KolorPierwszy[playerid] = 3;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 4:
				{
					KolorPierwszy[playerid] = 4;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 5:
				{
					KolorPierwszy[playerid] = 126;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 6:
				{
					KolorPierwszy[playerid] = 6;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 7:
				{
					KolorPierwszy[playerid] = 7;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 8:
				{
					KolorPierwszy[playerid] = 8;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 9:
				{
					KolorPierwszy[playerid] = 42;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 10:
				{
					KolorPierwszy[playerid] = 16;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 11:
				{
					KolorPierwszy[playerid] = 20;
					ShowPlayerDialogEx(playerid, 32, DIALOG_STYLE_LIST, "Wybierz Kolor 2", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)", "Wybierz", "Wyjd�");
				}
				case 12:
				{
					ShowPlayerDialogEx(playerid, 35, DIALOG_STYLE_INPUT, "Wybierz Kolor 1", "Wpisz numer koloru (od 0 do 126)", "Wybierz", "Wyjd�");
				}
			}
		}
		if(!response)
		{
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid == 32)
	{
		DestroySalonDialog(playerid);
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 0, CenaPojazdu[playerid]);
				}
				case 1:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 1, CenaPojazdu[playerid]);
				}
				case 2:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 2, CenaPojazdu[playerid]);
				}
				case 3:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 3, CenaPojazdu[playerid]);
				}
				case 4:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 4, CenaPojazdu[playerid]);
				}
				case 5:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 126, CenaPojazdu[playerid]);
				}
				case 6:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 6, CenaPojazdu[playerid]);
				}
				case 7:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 7, CenaPojazdu[playerid]);
				}
				case 8:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 8, CenaPojazdu[playerid]);
				}
				case 9:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 42, CenaPojazdu[playerid]);
				}
				case 10:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 16, CenaPojazdu[playerid]);
				}
				case 11:
				{
					KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], 20, CenaPojazdu[playerid]);
				}
				case 12:
				{
					ShowPlayerDialogEx(playerid, 36, DIALOG_STYLE_INPUT, "Wybierz Kolor 2", "Wpisz numer koloru (od 0 do 126)", "Wybierz", "Wyjd�");
				}
			}
		}
		if(!response)
		{
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
			KolorPierwszy[playerid] = 0;
		}
	}
	else if(dialogid == 36)
	{
		if(response)
		{
			if(strval(inputtext) > 0 &&  strval(inputtext) < 255)
			{
				KupowaniePojazdu(playerid, pojazdid[playerid], KolorPierwszy[playerid], strval(inputtext), CenaPojazdu[playerid]);
			}
			else
			{
				ShowPlayerDialogEx(playerid, 36, DIALOG_STYLE_INPUT, "Wybierz Kolor 2", "Wpisz numer koloru (od 0 do 255)", "Wybierz", "Wyjd�");
			}
		}
		if(!response)
		{
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
			KolorPierwszy[playerid] = 0;
		}
	}
	else if(dialogid == D_AUTO_DESTROY)
	{
		if(response)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				if(!IsCarOwner(playerid, GetPlayerVehicleID(playerid))) return SendClientMessage(playerid, COLOR_GRAD2, "Ten pojazd nie nale�y do Ciebie.");

				new vehicleid = GetPlayerVehicleID(playerid);
				new giveplayer[MAX_PLAYER_NAME];
				GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
				Log(payLog, WARNING, "%s zez�omowa� auto %s i dosta� 200$", GetPlayerLogName(playerid), GetVehicleLogName(vehicleid));
				RemovePlayerFromVehicleEx(playerid);
				ClearAnimations(playerid);
				SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);

				for(new i=0;i<MAX_CAR_SLOT;i++)
				{
					if(PlayerInfo[playerid][pCars][i] == VehicleUID[vehicleid][vUID])
						PlayerInfo[playerid][pCars][i] = 0;
				}
				Car_Destroy(VehicleUID[vehicleid][vUID]);

				DajKase(playerid, 200);
				SendClientMessage(playerid, COLOR_YELLOW, "Auto zez�omowane, dostajesz 200$");
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Wsi�d� do pojazdu");
			}
		}
	}
	//System �odzi
	else if(dialogid == 400)//System �odzi - panel
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Ponton
				{
					ShowPlayerDialogEx(playerid, 402, DIALOG_STYLE_MSGBOX, "Kupowanie Pontonu", "Ponton\n\nCena: 95000$\nPr�dko�� Maksymalna: 120km/h\nWielkosc: Ma�y\nOpis: Ma�y, zwrotny oraz szybki ponton. Idealny do emocjonalnego p�ywania po morzu. Jego cena jest przyjazna dla pocz�tkuj�cych �eglarzy. W 2 kolorach.", "Kup!", "Wr��");
					pojazdid[playerid] = 473;
					CenaPojazdu[playerid] = 95000;
				}
				case 1://Kuter
				{
					ShowPlayerDialogEx(playerid, 401, DIALOG_STYLE_MSGBOX, "Kupowanie Kutra", "Kuter\n\nCena: 100000$\nPr�dko�� Maksymalna: 70km/h\nWielkosc: Spory\nOpis: Jest to wolna oraz ma�o zwrotna ��d�. Idealnie nadaje si� do �owienia ryb. Pok�ad cz�ciowo zadaszony, reszta otwarta. Dost�pny w 1 kolorze.", "Kup!", "Wr��");
					pojazdid[playerid] = 453;
					CenaPojazdu[playerid] = 100000;
				}
				case 2://Coastguard
				{
					ShowPlayerDialogEx(playerid, 403, DIALOG_STYLE_MSGBOX, "Kupowanie Coastguarda", "Coastguard\n\nCena: 130.000$\nPr�dko�� Maksymalna: 160km/h\nWielkosc: �redni\nOpis: Dosy� szybkki oraz zwrotny statek. Nie jest zadaszony, pok�ad jest pod�u�ny. U�ywany przez ratownik�w. Malowany na 2 kolory.", "Kup!", "Wr��");
					pojazdid[playerid] = 472;
					CenaPojazdu[playerid] = 130000;
				}
				case 3://Launch
				{
					ShowPlayerDialogEx(playerid, 404, DIALOG_STYLE_MSGBOX, "Kupowanie Launcha", "Launch\n\nCena: 160.000$\nPr�dko�� Maksymalna: 150km/h\nWielkosc: �redni\nOpis: ��d� bojowa, u�ywana przez wojsko, ma pod�u�ny kad�ub. Dost�pna jest wersja cywilna z atrap� karabinu. Nie jest zbyt zwrotna i szybka, ale ma walory bojowe. Zadaszona przednia cz��. Malowana w 1 kolorze.", "Kup!", "Wr��");
					pojazdid[playerid] = 595;
					CenaPojazdu[playerid] = 160000;
				}
				case 4://Speeder
				{
					ShowPlayerDialogEx(playerid, 405, DIALOG_STYLE_MSGBOX, "Kupowanie Speedera", "Speeder\n\nCena: 175.000$\nPr�dko�� Maksymalna: 220km/h\nWielkosc: �redni\nOpis: Typowa motor�wka: smuk�a, du�e przyspieszenie i pr�dko��. Jej zwrotno�� nie jest zachwycaj�ca ale powinna zadowoli� wi�kszo�� u�ytkownik�w. Malowana w 1 kolorze.", "Kup!", "Wr��");
					pojazdid[playerid] = 452;
					CenaPojazdu[playerid] = 175000;
				}
				case 5://Jetmax
				{
					ShowPlayerDialogEx(playerid, 407, DIALOG_STYLE_MSGBOX, "Kupowanie Jetmaxa", "Jetmax\n\nCena: 200.000$\nPr�dko�� Maksymalna: 220km/h\nWielkosc: Spory\nOpis: Motor�wka wy�cigowa, stworzona do du�ych pr�dko�ci. Jej cecha charakterystyczna to ogromny silnik wystaj�cy z ty�u �odzi. Malowana w 2 kolorach.", "Kup!", "Wr��");
					pojazdid[playerid] = 493;
					CenaPojazdu[playerid] = 200000;
				}
				case 6://Tropic
				{
					ShowPlayerDialogEx(playerid, 406, DIALOG_STYLE_MSGBOX, "Kupowanie Tropica", "Speeder\n\nCena: 250.000$\nPr�dko�� Maksymalna: 160km/h\nWielkosc: Du�y\nOpis: Luksusowy jacht wycieczkowy. Posiada dwa pi�tra, miejsce mieszkalne i dach. Nie jest zwrotny ale szybki. Idealny dla bogaczy.", "Kup!", "Wr��");
					pojazdid[playerid] = 454;
					CenaPojazdu[playerid] = 250000;
				}
				case 7://Squallo
				{
					ShowPlayerDialogEx(playerid, 408, DIALOG_STYLE_MSGBOX, "Kupowanie Squallo", "Squallo\n\nCena: 275000$\nPr�dko�� Maksymalna: 260km/h\nWielkosc: Spory\nOpis: Motor�wka luksusowo wy�cigowa. Jej pr�dko�� jest nieprzyzwoicie du�a a wygl�d i luksus sprawi� �e b�dzie si� czu� jak prawdziwy bogacz. Malowana w 2 kolorach.", "Kup!", "Wr��");
					pojazdid[playerid] = 446;
					CenaPojazdu[playerid] = 275000;
				}
				case 8://Jacht
				{
					ShowPlayerDialogEx(playerid, 409, DIALOG_STYLE_MSGBOX, "Kupowanie Jachtu", "Jacht\n\nCena: 300000$\nPr�dko�� Maksymalna: 80km/h\nWielkosc: Wielki\nOpis: Jacht to statek dla ludzi kt�rzy wyprawiaj� si� w mi�dzykontynentaln� przepraw� oraz pragn� luksusu. Mo�na w nim spa� i normalnie gdy� posiada spore wn�trze. Malowany w 2 kolorach.\n((UWAGA! Pojazd posiada wn�trze do kt�rego mo�na wchodzi� komend� /wejdzw))", "Kup!", "Wr��");
					pojazdid[playerid] = 484;
					CenaPojazdu[playerid] = 300000;
				}
			}
		}
		if(!response)
		{
			return 1;
		}
	}
	else if(dialogid == 410)//System samolot�w - panel
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Dodo
				{
					ShowPlayerDialogEx(playerid, 411, DIALOG_STYLE_MSGBOX, "Kupowanie Dodo", "Dodo\n\nCena: 300.000$\nPr�dko�� lotu poziomego: 150km/h\nWielkosc: Ma�y\nOpis:", "Kup!", "Wr��");
					pojazdid[playerid] = 593;
					CenaPojazdu[playerid] = 300000;
				}
				case 1://Cropduster
				{
					ShowPlayerDialogEx(playerid, 412, DIALOG_STYLE_MSGBOX, "Kupowanie Cropdustera", "Cropduster\n\nCena: 350.000$\nPr�dko�� lotu poziomego: 140km/h\nWielkosc: �redni\nOpis:", "Kup!", "Wr��");
					pojazdid[playerid] = 512;
					CenaPojazdu[playerid] = 350000;
				}
				case 2://Beagle
				{
					ShowPlayerDialogEx(playerid, 413, DIALOG_STYLE_MSGBOX, "Kupowanie Beagle", "Beagle\n\nCena: 500.000$\nPr�dko�� lotu poziomego: 160km/h\nWielkosc: Spory\nOpis:", "Kup!", "Wr��");
					pojazdid[playerid] = 511;
					CenaPojazdu[playerid] = 500000;
				}
				case 3://Stuntplane
				{
					ShowPlayerDialogEx(playerid, 414, DIALOG_STYLE_MSGBOX, "Kupowanie Stuntplane", "Stuntplane\n\nCena: 585.000$\nPr�dko�� lotu poziomego: 190km/h\nWielkosc: Ma�y\nOpis:", "Kup!", "Wr��");
					pojazdid[playerid] = 513;
					CenaPojazdu[playerid] = 585000;
				}
				case 4://Nevada
				{
					ShowPlayerDialogEx(playerid, 415, DIALOG_STYLE_MSGBOX, "Kupowanie Nevady", "Nevada\n\nCena: 680.000$\nPr�dko�� lotu poziomego: 205km/h\nWielkosc: Du�y\nOpis: ((UWAGA! Pojazd posiada wn�trze do kt�rego mo�na wchodzi� komend� /wejdzw))", "Kup!", "Wr��");
					pojazdid[playerid] = 553;
					CenaPojazdu[playerid] = 680000;
				}
				case 5://Shamal
				{
					ShowPlayerDialogEx(playerid, 416, DIALOG_STYLE_MSGBOX, "Kupowanie Shamala", "Shamal\n\nCena: 1.000.000$\nPr�dko�� lotu poziomego: 300km/h\nWielkosc: Du�y\nOpis: Odrzutowiec ((UWAGA! Pojazd posiada wn�trze do kt�rego mo�na wchodzi� komend� /wejdzw))", "Kup!", "Wr��");
					pojazdid[playerid] = 519;
					CenaPojazdu[playerid] = 1000000;
				}
			}
		}
		if(!response)
		{
			return 1;
		}
	}
	else if(dialogid == 420)//System helikopter�w - panel
	{
		if(response)
		{
			switch(listitem)
			{
				case 0://Sparrow
				{
					ShowPlayerDialogEx(playerid, 421, DIALOG_STYLE_MSGBOX, "Kupowanie Sparrowa", "Sparrow\n\nCena: 125.000$\n�rednia pr�dko�� lotu: 160km/h\nWielkosc: Ma�y\nOpis:", "Kup!", "Wr��");
					pojazdid[playerid] = 469;
					CenaPojazdu[playerid] = 125000;
				}
				case 1://Maverick
				{
					ShowPlayerDialogEx(playerid, 422, DIALOG_STYLE_MSGBOX, "Kupowanie Mavericka", "Maverick\n\nCena: 200.000$\n�rednia pr�dko�� lotu: 180km/h\nWielkosc: �redni\nOpis:", "Kup!", "Wr��");
					pojazdid[playerid] = 487;
					CenaPojazdu[playerid] = 200000;
				}
				case 2://Leviathan
				{
					ShowPlayerDialogEx(playerid, 423, DIALOG_STYLE_MSGBOX, "Kupowanie Leviathana", "Leviathan\n\nCena: 265.000$\n�rednia pr�dko�� lotu: 130km/h\nWielkosc: Du�y\nOpis:", "Kup!", "Wr��");
					pojazdid[playerid] = 417;
					CenaPojazdu[playerid] = 265000;
				}
				case 3://Raindance
				{
					ShowPlayerDialogEx(playerid, 424, DIALOG_STYLE_MSGBOX, "Kupowanie Raindance", "Raindance\n\nCena: 325.000$\n�rednia pr�dko�� lotu: 100km/h\nWielkosc: Spory\nOpis:", "Kup!", "Wr��");
					pojazdid[playerid] = 563;
					CenaPojazdu[playerid] = 325000;
				}
			}
		}
		if(!response)
		{
			return 1;
		}
	}
	else if(dialogid >= 401 && dialogid <= 409)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranej �odzi");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)\nInny", "Wybierz", "Wyjd�");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 400, DIALOG_STYLE_LIST, "Kupowanie �odzi", "Ponton\t\t95 000$\nKuter\t\t100 000$\nCoastguard\t130 000$\nLaunch\t\t160 000$\nSpeeder\t175 000$\nJetmax\t\t200 000$\nTropic\t\t250 000$\nSquallo\t\t275 000$\nJacht\t\t300 000$", "Wybierz", "Wyjd�");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 411 && dialogid <= 417)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego samolotu");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)\nInny", "Wybierz", "Wyjd�");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 410, DIALOG_STYLE_LIST, "Kupowanie samolotu", "Dodo\t\t\t300 000$\nCropduster\t350 000$\nBeagle\t\t500 000$\nStuntplane\t585 000$\nNevada\t\t680 000$\nShamal\t\t1 000 000$", "Wybierz", "Wyjd�");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	else if(dialogid >= 421 && dialogid <= 424)
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wybierz kolor wybranego helikopteru");
			ShowPlayerDialogEx(playerid, 31, DIALOG_STYLE_LIST, "Wybierz Kolor 1", "Czarny\nBialy\nJasno-niebieski\nCzerwony\nZielony\nR�owy\n��ty\nNiebieski\nSzary\nJasno-czerwony\nJasno-zielony\nFioletowy\nInny (Numer)\nInny", "Wybierz", "Wyjd�");
		}
		if(!response)
		{
			ShowPlayerDialogEx(playerid, 420, DIALOG_STYLE_LIST, "Kupowanie Helikopteru", "Sparrow\t\t125 000$\nMaverick\t\t200 000$\nLeviathan\t\t265 000$\nRaindance\t\t325 000$", "Wybierz", "Wyjd�");
			pojazdid[playerid] = 0;
			CenaPojazdu[playerid] = 0;
		}
	}
	return 0;
}

//end