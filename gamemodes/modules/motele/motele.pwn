//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   motele                                                  //
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
// Autor: xSeLeCTx
// Data utworzenia: 14.05.2021
//Opis:
/*
	System moteli
*/

//

//----- [ DEV INFO ] ------//

// 	GetCurrent(playerid);
// 	/amotel > both
// 	/motel > !outside 
// 	/wejdz > outside !both
// 	/wyjdz > !outside !both

// 	motUID, motRoom, motRoomInterior, motOwner,	  motDoors, 	 motLastOnline, motPayOffline
// 	1,	    543,	 3                1,	    	0,		     15.05.2021, 	5000,			
// 			-1 =	                  1 = owner	  	0 - close																			
//			unrent                    2 = sub-own  	1 - open
//  1,543,1,523.43,444.32,64.54,10,50

// UPDATE `mru_konta` SET `Money`=`Money`-200 WHERE `UID` in (1, 3) // przyk�adowe niwelowanie hajsu graczy offline o 8:00

// VW pokoi: mtrUID + 13000

//-----------------<[ Funkcje: ]>-------------------

/* Funkcje zarz�dzania, wchodzenia gracza */
Motel_Wejdz(playerid)
{
	new motelID = Motel_GetCurrent(playerid, true, false); // Sprawdza czy gracz jest przed motelem
	if(motelID != -1)
	{
		SetPlayerVirtualWorld(playerid, Motels[motelID][motInVW]);
		SetPlayerInterior(playerid, Motels[motelID][motInInt]);
		SetPlayerPos(playerid, Motels[motelID][motInX], Motels[motelID][motInY], Motels[motelID][motInZ]);
		Wchodzenie(playerid);

		GameTextForPlayer(playerid, sprintf("~w~Witamy w %s", Motels[motelID][motName]), 5000, 1);
	}
	return 1;
}

Motel_Wyjdz(playerid)
{
	new motelID = Motel_GetCurrent(playerid, false, false); // Sprawdza czy gracz jest w motelu przy drzwiach wyj�ciowych
	if(motelID != -1)
	{
		SetPlayerVirtualWorld(playerid, Motels[motelID][motVW]);
		SetPlayerInterior(playerid, Motels[motelID][motInt]);
		SetPlayerPos(playerid, Motels[motelID][motPosX], Motels[motelID][motPosY], Motels[motelID][motPosZ]);
		Wchodzenie(playerid);
	}
	return 1;
}

Motel_Room_Wejdz(playerid, roomID)
{
	new motelID = Motel_GetCurrent(playerid, false, false, true); // Sprawdza czy gracz jest w motelu
	if(motelID != -1)
	{
		if(Motels[motelID][motUID] != MotelRooms[roomID][mtrMotUID]) return 0;
		new access;
		for(new i = 0; i < MOTEL_MAX_ACCESS; i++) 
		{
			if(MotelRoomsAccess[roomID][i][mtraUID] == PlayerInfo[playerid][pUID])
			{
				access = 1;
				break;
			}
		}
		// Gdy gracz nie ma dost�pu, drzwi s� zamkni�te lub nie jest w�a�cicielem wy�wietla si� komunikat o zamkni�tych drzwiach
		if(!access && !MotelRooms[roomID][mtrDoors] && MotelRooms[roomID][mtrOwnerUID] != PlayerInfo[playerid][pUID]) return Motel_ShowError(playerid, motelID, "Drzwi do tego pokoju s� zamkni�te, a Ty nie masz dost�pu.");
		
		// Wchodzi do pokoju
		SetPlayerInterior(playerid, MotelInteriors[MotelRooms[roomID][mtrInterior]][mtiInt]);
		SetPlayerVirtualWorld(playerid, MotelRooms[roomID][mtrUID]+MOTEL_VW);
		SetPlayerPos(playerid, MotelInteriors[MotelRooms[roomID][mtrInterior]][mtiPosX], MotelInteriors[MotelRooms[roomID][mtrInterior]][mtiPosY], MotelInteriors[MotelRooms[roomID][mtrInterior]][mtiPosZ]);
		Wchodzenie(playerid);

		return 1;
	}
	return 0;
}

Motel_Room_CheckWyjdz(playerid)
{
	new VW = GetPlayerVirtualWorld(playerid);
	new roomUID = -1;
	if(VW > MOTEL_VW) roomUID = VW-MOTEL_VW; // Wz�r na zdobycie UID pokoju z VirtualWorlda gracza
	new roomID = Motel_GetRoomIDFromUID(roomUID); 
	if(roomUID != -1 && roomID != -1) // Znaleziono UID pokoju i ID w tablicy, mo�na przej�� dalej
	{
		new roomInt = MotelRooms[roomID][mtrInterior];
		if(IsPlayerInRangeOfPoint(playerid, 5, MotelInteriors[roomInt][mtiPosX], MotelInteriors[roomInt][mtiPosY], MotelInteriors[roomInt][mtiPosZ]))
		{
			Motel_Room_Wyjdz(playerid, roomID);
			return 1;
		}
	}
	return 0;
}

Motel_Room_Wyjdz(playerid, roomID)
{
	new motelID = Motel_GetMotelIDFromUID(MotelRooms[roomID][mtrMotUID]); // Sprawdza czy motel istnieje
	if(motelID != -1)
	{
		// Wychodzi z pokoju
		SetPlayerVirtualWorld(playerid, Motels[motelID][motInVW]);
		SetPlayerInterior(playerid, Motels[motelID][motInInt]);
		SetPlayerPos(playerid, Motels[motelID][motInX], Motels[motelID][motInY], Motels[motelID][motInZ]);
		Wchodzenie(playerid);
	}
	return 1;
}

Motel_Rent(playerid, UID, roomNum, roomInterior)
{
	new motelID = Motel_GetMotelIDFromUID(UID);
	if(motelID != -1)
	{
		new Year, Month, Day;
		getdate(Year, Month, Day);
		new roomID = Motel_GetFreeRoom();
		if(roomID == -1) return Motel_ShowError(playerid, motelID, "Brak wolnych pokoi.");
		// Ustawianie danych dot. motelu w tablicy gracza
		PlayerInfo[playerid][pMotRoom] = roomID;
		PlayerInfo[playerid][pMotEvict] = 0;
		// Ustawianie danych dot. motelu w tablicy pokoi
		MotelRooms[roomID][mtrMotUID] = Motels[motelID][motUID];
		MotelRooms[roomID][mtrRoomNum] = roomNum;
		MotelRooms[roomID][mtrInterior] = roomInterior;
		MotelRooms[roomID][mtrOwnerUID] = PlayerInfo[playerid][pUID];
		MotelRooms[roomID][mtrDoors] = 0;
		format(MotelRooms[roomID][mtrLastOnline], 32, "%d.%d.%d", Year, Month, Day);
		MotelRooms[roomID][mtrPayOffline] = 0;
		for(new i = 0; i < MOTEL_MAX_ACCESS; i++) {
			MotelRoomsAccess[roomID][i][mtraUID] = 0;
			format(MotelRoomsAccess[roomID][i][mtraNick], 32, " ");
		}
		MotelRooms[roomID][mtrAccessCount] = 0;

		if(MotelRooms[roomID][mtrUID] == 0) // Pok�j jeszcze nie jest stworzony w bazie, wi�c system go tworzy
		{
			MotelRooms[roomID][mtrUID] = MruMySQL_CreateMotelRoom(roomID);
		}
		else // Pok�j ju� istnieje w bazie i ma swoje UID, wi�c tylko zapisuje
		{
			MruMySQL_SaveMotelRoom(roomID);
		}

		Motels[motelID][motOccupied]++;

		new string[128];
		format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}%s{e8c205} ] -------------- |", Motels[motelID][motName]);
		SendClientMessage(playerid, -1, string);
		SendClientMessage(playerid, -1, "W�a�nie wynaj��e� pok�j w motelu. Op�ata b�dzie pobierana raz dziennie o godzinie 8:00.");
		SendClientMessage(playerid, -1, "Pami�taj by mie� �rodki na swoim koncie bankowym, inaczej zostaniesz wyeksmitowany!");
		Log(moteleLog, WARNING, "%s wynaj�� pok�j %d w motelu %d", GetPlayerLogName(playerid), MotelRooms[roomID][mtrUID], Motels[motelID][motUID]);

		// Wchodzi do pokoju
		SetPlayerInterior(playerid, MotelInteriors[roomInterior][mtiInt]);
		SetPlayerVirtualWorld(playerid, MotelRooms[roomID][mtrUID]+MOTEL_VW);
		SetPlayerPos(playerid, MotelInteriors[roomInterior][mtiPosX], MotelInteriors[roomInterior][mtiPosY], MotelInteriors[roomInterior][mtiPosZ]);
		Wchodzenie(playerid);

		// Zabiera kaske za 'wzi�cie klucza'
		ZabierzKaseDone(playerid, Motels[motelID][motPrice]);

		GameTextForPlayer(playerid, "~w~Witamy w twoim nowym pokoju", 5000, 1);
	} else return SendClientMessage(playerid, COLOR_RED, "WYST�PI� B��D Z WYNAJMEM POKOJU (NIEPRAWID�OWE ID MOTELU)"); // Prawdopodobnie nie wyst�puj�cy b��d
	return 1;
}

Motel_RoomDestroy(roomID)
{
	Log(moteleLog, WARNING, "Pok�j %d zosta� zniszczony", MotelRooms[roomID][mtrUID]);
	Motels[Motel_GetMotelIDFromUID(MotelRooms[roomID][mtrMotUID])][motOccupied]--;
	MotelRooms[roomID][mtrMotUID] = 0;
	MotelRooms[roomID][mtrRoomNum] = 0;
	MotelRooms[roomID][mtrInterior] = 0;
	MotelRooms[roomID][mtrOwnerUID] = 0;
	MotelRooms[roomID][mtrDoors] = 0;
	format(MotelRooms[roomID][mtrLastOnline], 32, "0.0.0000");
	MotelRooms[roomID][mtrPayOffline] = 0;
	for(new i = 0; i < MOTEL_MAX_ACCESS; i++) {
		MotelRoomsAccess[roomID][i][mtraUID] = 0;
		format(MotelRoomsAccess[roomID][i][mtraNick], 32, " ");
	}
	MotelRooms[roomID][mtrAccessCount] = 0;
	
	MruMySQL_SaveMotelRoom(roomID);
	
}

Motel_Unrent(playerid, reason = 0, offline = 0)
{
	new roomID = PlayerInfo[playerid][pMotRoom];
	new motelID = Motel_GetMotelIDFromUID(MotelRooms[roomID][mtrMotUID]);

	Log(moteleLog, WARNING, "%s zrezygnowa� z wynajmu pokoju %d z powodu %d (offline: %d)", GetPlayerLogName(playerid), PlayerInfo[playerid][pMotRoom], reason, offline);
	if(!offline)
	{
		// Ustawianie danych dot. motelu w tablicy gracza
		PlayerInfo[playerid][pMotRoom] = 0;
		PlayerInfo[playerid][pMotEvict] = 0;

		// Ustawianie danych dot. motelu w tablicy pokoi
		MotelRooms[roomID][mtrMotUID] = 0;
		MotelRooms[roomID][mtrRoomNum] = 0;
		MotelRooms[roomID][mtrInterior] = 0;
		MotelRooms[roomID][mtrOwnerUID] = 0;
		MotelRooms[roomID][mtrDoors] = 0;
		format(MotelRooms[roomID][mtrLastOnline], 32, "0.0.0000");
		MotelRooms[roomID][mtrPayOffline] = 0;
		for(new i = 0; i < MOTEL_MAX_ACCESS; i++) {
			MotelRoomsAccess[roomID][i][mtraUID] = 0;
			format(MotelRoomsAccess[roomID][i][mtraNick], 32, " ");
		}
		MotelRooms[roomID][mtrAccessCount] = 0;

		MruMySQL_SaveMotelRoom(roomID);

		Motels[motelID][motOccupied]--;
	}

	new string[128];
	if(reason == 0)
	{
		if(motelID != -1 || motelID == 0) format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}%s{e8c205} ] -------------- |", Motels[motelID][motName]);
		else			  format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}Informacja od motelu{e8c205} ] -------------- |");
		SendClientMessage(playerid, -1, string);
		SendClientMessage(playerid, -1, "W�a�nie zrezygnowa�e� z wynajmu pokoju w tym motelu. Do zobaczenia nast�pnym razem!");
	}
	else if(reason == 1)
	{
		if(motelID != -1 || motelID == 0) format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}%s{e8c205} ] -------------- |", Motels[motelID][motName]);
		else			  format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}Informacja od motelu{e8c205} ] -------------- |");
		SendClientMessage(playerid, -1, string);
		SendClientMessage(playerid, -1, "Zosta�e� eksmitowany, poniewa� motel w kt�rym mia�e� pok�j zosta� usuni�ty.");
	}
	else if(reason >= 2)
	{
		if(motelID != -1 || motelID == 0) format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}%s{e8c205} ] -------------- |", Motels[motelID][motName]);
		else			  format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}Informacja od motelu{e8c205} ] -------------- |");
		SendClientMessage(playerid, -1, string);
		SendClientMessage(playerid, -1, "Zosta�e� eksmitowany, poniewa� nie masz pieni�dzy aby zap�aci� za pok�j.");
		if(reason > 2) // W reason zapisywana jest te� warto�� mtrPayOffline gdy pok�j zostaje zniszczony.
		{
			format(string, sizeof(string), "Dodatkowo z twojego konta zosta�o pobrane ��cznie {11d625}$%d{FFFFFF} gdy by�e� offline.", reason-2);
			SendClientMessage(playerid, -1, string);
		}
	}
	else if(reason == -1)
	{
		if(motelID != -1 || motelID == 0) format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}%s{e8c205} ] -------------- |", Motels[motelID][motName]);
		else			  format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}Informacja od motelu{e8c205} ] -------------- |");
		SendClientMessage(playerid, -1, string);
		SendClientMessage(playerid, -1, "Zosta�e� eksmitowany, poniewa� twoje konto by�o zablokowane.");
	}
	else if(reason == -2)
	{
		if(motelID != -1 || motelID == 0) format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}%s{e8c205} ] -------------- |", Motels[motelID][motName]);
		else			  format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}Informacja od motelu{e8c205} ] -------------- |");
		SendClientMessage(playerid, -1, string);
		SendClientMessage(playerid, -1, "Zosta�e� eksmitowany, poniewa� twoje konto nie by�o zalogowane od 7 dni.");
	}

	// Wyrzuca wszystkich z pokoju je�li s� w nim
	if(!offline)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && gPlayerLogged[i])
			{
				if(GetPlayerVirtualWorld(i) == MotelRooms[roomID][mtrUID]+MOTEL_VW)
				{
					SetPlayerVirtualWorld(i, Motels[motelID][motInVW]);
					SetPlayerInterior(i, Motels[motelID][motInInt]);
					SetPlayerPos(i, Motels[motelID][motInX], Motels[motelID][motInY], Motels[motelID][motInZ]);
					Wchodzenie(i);
				}
			}
		}
	}

	// Zabiera kaske z powodu rezygnacji
	if(reason == 0)
	{
		ZabierzKaseDone(playerid, Motels[motelID][motPrice]);
		GameTextForPlayer(playerid, "~w~Dziekujemy za pobyt!", 5000, 1);
	}
	return 1;
}

Motel_AddUIDToAccess(roomID, UID, nick[])
{
	for(new i = 0; i < MOTEL_MAX_ACCESS; i++) // Dodawanie danego UID do pierwszego wolnego slotu
	{
		if(MotelRoomsAccess[roomID][i][mtraUID] == 0)
		{
			MotelRoomsAccess[roomID][i][mtraUID] = UID;
			format(MotelRoomsAccess[roomID][i][mtraNick], 32, "%s", nick);
			MotelRooms[roomID][mtrAccessCount]++;
			MruMySQL_SaveMotelRoom(roomID);
			return 1;
		}
	}
	return 0;
}

Motel_RemoveUIDFromAccess(roomID, UID)
{
	for(new i = 0; i < MOTEL_MAX_ACCESS; i++) // Usuwanie danego UID
	{
		if(MotelRoomsAccess[roomID][i][mtraUID] == UID)
		{
			MotelRoomsAccess[roomID][i][mtraUID] = 0;
			format(MotelRoomsAccess[roomID][i][mtraNick], 32, " ");
			MotelRooms[roomID][mtrAccessCount]--;
			break;
		}
	}
	new sort = false;
	for(new i = 0; i < MOTEL_MAX_ACCESS-1; i++) // Sortowanie
	{
		if(MotelRoomsAccess[roomID][i][mtraUID] == 0 || sort)
		{
			MotelRoomsAccess[roomID][i][mtraUID] = MotelRoomsAccess[roomID][i+1][mtraUID];
			format(MotelRoomsAccess[roomID][i][mtraNick], 32, "%s", MotelRoomsAccess[roomID][i+1][mtraNick]);
			sort = true;
		}
	}
	
	MruMySQL_SaveMotelRoom(roomID);
	return 1;
}

/* Funkcje systemowe */
Motel_ShowError(playerid, motelID, string[]) // motelID -2 = kreator moteli
{
	if(motelID != -2) return ShowPlayerInfoDialog(playerid, sprintf("{e8c205} %s {ff0000}� B��d", Motels[motelID][motName]), string); // Wy�wietla b��d
	else return ShowPlayerInfoDialog(playerid, "{e8c205} Kreator moteli {ff0000}� B��d", string); // Wy�wietla b��d
}

Motel_GetCurrent(playerid, outside, both = false, inside_everywhere = false, inside_room = false) // Sprawdza przy/w jakim motelu gracz si� znajduje
{
	for(new i = 0; i < MAX_MOTELS; i++)
    {
        if(Motels[i][motUID] != 0)
		{
			if ((!outside || both) && inside_everywhere) // Dzia�a wsz�dzie we wn�trzu motelu
			{
				if(GetPlayerVirtualWorld(playerid) == Motels[i][motInVW] && GetPlayerInterior(playerid) == Motels[i][motInInt])
				{
					if(IsPlayerInRangeOfPoint(playerid, 50, Motels[i][motInX], Motels[i][motInY], Motels[i][motInZ])) // bug duplikacja VW
					{
						return i;
					}
				}
			}
			if(outside || both) // Dzia�a przy wej�ciu do motelu ( na zewn�trz )
			{
				if(IsPlayerInRangeOfPoint(playerid, 3, Motels[i][motPosX], Motels[i][motPosY], Motels[i][motPosZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == Motels[i][motVW] && GetPlayerInterior(playerid) == Motels[i][motInt])
					{
						return i;
					}
				}
			}
			else if (!outside && !both) // Dzia�a przy wyj�ciu do motelu ( w �rodku )
			{
				if(IsPlayerInRangeOfPoint(playerid, 3, Motels[i][motInX], Motels[i][motInY], Motels[i][motInZ]))
				{
					if(GetPlayerVirtualWorld(playerid) == Motels[i][motInVW] && GetPlayerInterior(playerid) == Motels[i][motInInt])
					{
						return i;
					}
				}
			}
		}
	}
	if(inside_everywhere && inside_room)
	{
		if(GetPlayerVirtualWorld(playerid) == MotelRooms[PlayerInfo[playerid][pMotRoom]][mtrUID]+MOTEL_VW)
		{
			return Motel_GetMotelIDFromUID(MotelRooms[PlayerInfo[playerid][pMotRoom]][mtrMotUID]);
		}
	}
	return -1;
}

Motel_GetRandomInterior()
{
	return random(sizeof(MotelInteriors));
}

Motel_GetMotelIDFromUID(UID)
{
	if(UID == 0) return -1;
	for(new i = 1; i < MAX_MOTELS; i++)
	{
		if(Motels[i][motUID] == UID) return i;
	}
	return -1;
}

Motel_GetRoomIDFromUID(UID)
{
	if(UID == 0) return -1;
	for(new i = 0; i < MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrUID] == UID) return i;
	}
	return -1;
}

Motel_GetRoomIDFromRoomNumber(UID, room)
{
	for(new i = 0; i < MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrMotUID] == UID && MotelRooms[i][mtrRoomNum] == room) return i;
	}
	return -1;
}

Motel_CheckIfRoomExists(UID, room) // Sprawdza czy pok�j istnieje / Zapobiega duplikacji numeru pokoj�w
{
	// Sprawdza czy pok�j w danym motelu istnieje (po UID motelu)
	for(new i = 0; i < MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrMotUID] == UID && MotelRooms[i][mtrRoomNum] == room) return 1;
	}
	return 0;
}

Motel_FindRoomIDFromPlayerID(playerid)
{
	for(new i = 0; i < MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrOwnerUID] == PlayerInfo[playerid][pUID]) return i;
	}
	return -1;
}

Motel_GetFreeRoom()
{
	for(new i = 1; i < MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrRoomNum] == 0) return i;
	}
	return -1;
}

Motel_Create(playerid, Float:InX, Float:InY, Float:InZ, InVW, InInterior, Price, Rooms, MotelName[64])
{
	new motelID = Motel_GetCurrent(playerid, true, true, true);
	if(motelID != -1) return sendErrorMessage(playerid, "W tym miejscu nie mo�na stworzy� motelu!");

	for(new i = 1; i < MAX_MOTELS; i++)
	{
		if(Motels[i][motUID] == 0)
		{
			motelID = i;
			break;
		}
	}
	if(motelID == -1) return sendErrorMessage(playerid, "Brak wolnych slot�w na motel!");

	new Float:PosX, Float:PosY, Float:PosZ, VW, Interior;
	GetPlayerPos(playerid, PosX, PosY, PosZ);
	Interior = GetPlayerInterior(playerid);
	VW = GetPlayerVirtualWorld(playerid);

	format(Motels[motelID][motName], 64, "%s", MotelName);
	Motels[motelID][motRooms] = Rooms;
	Motels[motelID][motOccupied] = 0;
	Motels[motelID][motPrice] = Price;
	Motels[motelID][motPosX] = PosX;
	Motels[motelID][motPosY] = PosY;
	Motels[motelID][motPosZ] = PosZ;
	Motels[motelID][motVW] = VW;
	Motels[motelID][motInt] = Interior;
	Motels[motelID][motInX] = InX;
	Motels[motelID][motInY] = InY;
	Motels[motelID][motInZ] = InZ;
	Motels[motelID][motInVW] = InVW;
	Motels[motelID][motInInt] = InInterior;

	Motels[motelID][motUID] = MruMySQL_CreateMotel(motelID);
	if(Motels[motelID][motUID] != 0)
	{
		Motels[motelID][motPickup] = CreateDynamicPickup(19523, 1, Motels[motelID][motPosX], Motels[motelID][motPosY], Motels[motelID][motPosZ], Motels[motelID][motVW], Motels[motelID][motInt]);
		Motels[motelID][motIcon] =   CreateDynamicMapIcon(Motels[motelID][motPosX], Motels[motelID][motPosY], Motels[motelID][motPosZ], -1, Motels[motelID][motVW], Motels[motelID][motInt], -1, 200, MAPICON_GLOBAL);
		Motels[motelID][motText] =   CreateDynamic3DTextLabel(Motels[motelID][motName], 0x008080FF, Motels[motelID][motPosX], Motels[motelID][motPosY], Motels[motelID][motPosZ]+0.8, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, Motels[motelID][motVW], Motels[motelID][motInt]);
		Motels[motelID][motInText] = CreateDynamic3DTextLabel("Wyj�cie", 0x008080FF, Motels[motelID][motInX], Motels[motelID][motInY], Motels[motelID][motInZ]+0.3, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, Motels[motelID][motInVW], Motels[motelID][motInInt]);
		sendTipMessage(playerid, "Pomy�lnie stworzono motel!");
		Log(adminLog, WARNING, "%s stworzy� nowy motel %s [%d]", GetPlayerLogName(playerid), Motels[motelID][motName], Motels[motelID][motUID]);
	} else sendErrorMessage(playerid, "Nie uda�o si� stworzy� motelu... (B��d MySQL)");
	return 1;
}

Motel_Destroy(playerid, motelID)
{
	new tempMotelName[64], tempMotelUID;

	tempMotelUID = Motels[motelID][motUID];
	format(tempMotelName, 64, "%s", Motels[motelID][motName]);

	for(new i = 0; i < MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrMotUID] == tempMotelUID)
		{
			new found = 0;
			for(new j = 0; j < MAX_PLAYERS; j++)
			{
				if(IsPlayerConnected(j))
				{
					if(PlayerInfo[j][pUID] == MotelRooms[i][mtrOwnerUID])
					{
						found = 1;
						Motel_Unrent(j, 1);
					}
				}
			}
			if(!found)
			{
				MruMySQL_MotelSetEvictState(MotelRooms[i][mtrOwnerUID], 1);
				Motel_RoomDestroy(i);
			}
		}
	}

	Motels[motelID][motUID] = 0;
	format(Motels[motelID][motName], 64, "Motel");
	Motels[motelID][motRooms] = 0;
	Motels[motelID][motOccupied] = 0;
	Motels[motelID][motPrice] = 0;
	Motels[motelID][motPosX] = 0;
	Motels[motelID][motPosY] = 0;
	Motels[motelID][motPosZ] = 0;
	Motels[motelID][motVW] = 0;
	Motels[motelID][motInt] = 0;
	Motels[motelID][motInX] = 0;
	Motels[motelID][motInY] = 0;
	Motels[motelID][motInZ] = 0;
	Motels[motelID][motInVW] = 0;
	Motels[motelID][motInInt] = 0;

	DestroyDynamicPickup(Motels[motelID][motPickup]);
	DestroyDynamicMapIcon(Motels[motelID][motIcon]);
	DestroyDynamic3DTextLabel(Motels[motelID][motText]);
	DestroyDynamic3DTextLabel(Motels[motelID][motInText]);

	
	MruMySQL_DestroyMotel(tempMotelUID);
	Log(adminLog, WARNING, "%s usun�� motel %s [%d] wraz ze wszystkimi pokojami", GetPlayerLogName(playerid), tempMotelName, tempMotelUID);
	return 1;
}

Motel_GetAllRent()
{
	new string[128];
	new query[256];
	//MruMySQL_SprawdzBanyUID(UID);
	for(new i = 1; i < MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrUID] != 0 && MotelRooms[i][mtrMotUID] != 0)
		{
			if(MotelRooms[i][mtrOwnerUID] != 0)
			{
				new motelID = Motel_GetMotelIDFromUID(MotelRooms[i][mtrMotUID]);
				if(motelID == -1)
				{
					Log(moteleLog, WARNING, "Motel %d nie istnieje, UID %d zosta� eksmitowany!", MotelRooms[i][mtrOwnerUID]);
					MruMySQL_MotelSetEvictState(MotelRooms[i][mtrOwnerUID], 1);
				}
				else
				{
					new found = 0;
					for(new j = 0; j < MAX_PLAYERS; j++)
					{
						if(IsPlayerConnected(j) && gPlayerLogged[j])
						{
							if(PlayerInfo[j][pUID] == MotelRooms[i][mtrOwnerUID])
							{
								found = 1;
								if(PlayerInfo[j][pAccount] >= Motels[motelID][motPrice])
								{
									PlayerInfo[j][pAccount]-=Motels[motelID][motPrice];
									format(string, sizeof(string), "{e8c205}| -------------- [ {FFFFFF}%s{e8c205} ] -------------- |", Motels[motelID][motName]);
									SendClientMessage(j, -1, string);
									format(string, sizeof(string), "Z twojego konta zosta�o pobrane {11d625}$%d{FFFFFF}.", Motels[motelID][motPrice]);
									SendClientMessage(j, -1, string);
									Log(payLog, WARNING, "%s zap�aci� $%d za pok�j %d w motelu %d", GetPlayerLogName(j), Motels[motelID][motPrice], MotelRooms[PlayerInfo[j][pMotRoom]][mtrUID], Motels[motelID][motUID]);
									break;
								}
								else
								{
									Log(moteleLog, WARNING, "UID %d nie mia� pieni�dzy by zap�aci� za pok�j %d w motelu %d", MotelRooms[i][mtrOwnerUID], MotelRooms[i][mtrUID], Motels[motelID][motUID]);
									Motel_Unrent(j, 2);
									break;
								}
							}
						}
					}
					if(!found)
					{
						new evicted = false;
						if(strcmp("0.0.0000", MotelRooms[i][mtrLastOnline], true) != 0)
						{
							new year, month, day, str[11];
							getdate(year, month, day);
							format(str, sizeof(str), "%d.%d.%d", year, month, day);
							new timestamp1 = DateToTimestamp(str);
							format(str, sizeof(str), "%s", MotelRooms[i][mtrLastOnline]);
							new timestamp2 = DateToTimestamp(str);
							if(timestamp1-timestamp2 >= 604800)
							{
								evicted = true;
								MruMySQL_MotelSetEvictState(MotelRooms[i][mtrOwnerUID], -2);
								Motel_RoomDestroy(i);
							}
						}
						if(!evicted)
						{
							if(CheckBlock(MotelRooms[i][mtrOwnerUID], BLOCK_BAN) || CheckBlock(MotelRooms[i][mtrOwnerUID], BLOCK_CHAR_BAN))
							{
								Log(moteleLog, WARNING, "UID %d jest zbanowany i zosta� eksmitowany z pokoju %d w motelu %d", MotelRooms[i][mtrOwnerUID], MotelRooms[i][mtrUID], Motels[motelID][motUID]);
								MruMySQL_MotelSetEvictState(MotelRooms[i][mtrOwnerUID], -1);
								Motel_RoomDestroy(i);
							}
							else
							{
								if(MruMySQL_GetAccInt("Bank", MruMySQL_GetNameFromUID(MotelRooms[i][mtrOwnerUID])) < Motels[motelID][motPrice]) {
									Log(moteleLog, WARNING, "UID %d jest offline i nie ma pieni�dzy by zap�ai�, zosta� eksmitowany z pokoju %d w motelu %d", MotelRooms[i][mtrOwnerUID], MotelRooms[i][mtrUID], Motels[motelID][motUID]);
									MruMySQL_MotelSetEvictState(MotelRooms[i][mtrOwnerUID], MotelRooms[i][mtrPayOffline]+2);
									Motel_RoomDestroy(i);
								} else {
									Log(moteleLog, WARNING, "UID %d jest offline, zap�aci� $%d za pok�j %d w motelu %d", MotelRooms[i][mtrOwnerUID], Motels[motelID][motPrice], MotelRooms[i][mtrUID], Motels[motelID][motUID]);
									format(query, sizeof(query), "UPDATE `mru_konta` SET `Bank`=`Bank`-'%d' WHERE `UID` = '%d'", Motels[motelID][motPrice], MotelRooms[i][mtrOwnerUID]);
									mysql_query(query);
									MotelRooms[i][mtrPayOffline]+=Motels[motelID][motPrice];
								}
							}
						}
					}
				}
			} 
			else
			{
				Log(moteleLog, WARNING, "Motel %d nie ma w�a�ciciela, usuwam",  MotelRooms[i][mtrUID]);
				Motel_RoomDestroy(i);
			}
		}
	}
	MruMySQL_SaveMotelRooms();
	MruMySQL_SaveMotels();
	return 1;
}
//end