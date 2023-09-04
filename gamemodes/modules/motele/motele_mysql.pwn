//-----------------------------------------------<< MySQL >>-------------------------------------------------//
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

//------------------<[ MySQL: ]>--------------------
MruMySQL_LoadMotels() // £adowanie moteli z bazy danych
{
	new lStr[512], motelsNum = 1;
	mysql_query("SELECT * FROM `mru_motele`");
	mysql_store_result();
	while(mysql_fetch_row_format(lStr, "|"))
	{
		// Zapisywanie moteli z bazy do tablicy Motels
		sscanf(lStr, "p<|>ds[64]dddfffddfffdd", 
			Motels[motelsNum][motUID],
			Motels[motelsNum][motName],
			Motels[motelsNum][motRooms],
			Motels[motelsNum][motOccupied],
			Motels[motelsNum][motPrice],
			Motels[motelsNum][motPosX],
			Motels[motelsNum][motPosY],
			Motels[motelsNum][motPosZ],
			Motels[motelsNum][motVW],
			Motels[motelsNum][motInt],
			Motels[motelsNum][motInX],
			Motels[motelsNum][motInY],
			Motels[motelsNum][motInZ],
			Motels[motelsNum][motInVW],
			Motels[motelsNum][motInInt]
		);

		// Tworzenie pickupów, ikon i 3dtextów
		Motels[motelsNum][motPickup] = CreateDynamicPickup(19523, 1, Motels[motelsNum][motPosX], Motels[motelsNum][motPosY], Motels[motelsNum][motPosZ], Motels[motelsNum][motVW], Motels[motelsNum][motInt]);
		Motels[motelsNum][motIcon] =   CreateDynamicMapIcon(Motels[motelsNum][motPosX], Motels[motelsNum][motPosY], Motels[motelsNum][motPosZ], -1, Motels[motelsNum][motVW], Motels[motelsNum][motInt], -1, 200, MAPICON_GLOBAL);
		Motels[motelsNum][motText] =   CreateDynamic3DTextLabel(Motels[motelsNum][motName], 0x008080FF, Motels[motelsNum][motPosX], Motels[motelsNum][motPosY], Motels[motelsNum][motPosZ]+0.8, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, Motels[motelsNum][motVW], Motels[motelsNum][motInt]);
		Motels[motelsNum][motInText] = CreateDynamic3DTextLabel("Wyjœcie", 0x008080FF, Motels[motelsNum][motInX], Motels[motelsNum][motInY], Motels[motelsNum][motInZ]+0.3, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, Motels[motelsNum][motInVW], Motels[motelsNum][motInInt]);
		
		motelsNum++; // Iloœæ moteli
	}
	mysql_free_result();
	printf("Wczytano %d moteli", motelsNum-1);
}

MruMySQL_SaveMotels() // Zapis wszystkich moteli do bazy danych
{
	for(new i = 0; i<MAX_MOTELS; i++)
	{
		if(Motels[i][motUID] != 0)
		{
			MruMySQL_SaveMotel(i);
		}
	}
}

MruMySQL_SaveMotel(motelID) // Zapis pojedynczego motelu do bazy danych
{
	new query[512];
	format(query, sizeof(query), "UPDATE `mru_motele` SET \
								 `Name`='%s', `Rooms`='%d', `Occupied`='%d', `Price`='%d', \
								 `PosX`='%f', `PosY`='%f', `PosZ`='%f', `VW`='%d', `Interior`='%d', \
								 `InX`='%f', `InY`='%f', `InZ`='%f', `InVW`='%d', `InInterior`='%d' \
								  WHERE `UID` = '%d'",
								  Motels[motelID][motName], Motels[motelID][motRooms], Motels[motelID][motOccupied], Motels[motelID][motPrice],
								  Motels[motelID][motPosX], Motels[motelID][motPosY], Motels[motelID][motPosZ], Motels[motelID][motVW], Motels[motelID][motInt], 
								  Motels[motelID][motInX], Motels[motelID][motInY], Motels[motelID][motInZ], Motels[motelID][motInVW], Motels[motelID][motInInt],
								  Motels[motelID][motUID]);
	mysql_query(query);
	return 1;
}

MruMySQL_CreateMotel(motelID)
{
	new query[512];
	format(query, sizeof(query), "INSERT INTO `mru_motele` \
								 (`Name`, `Rooms`, `Occupied`, `Price`, \
								 `PosX`, `PosY`, `PosZ`, `VW`, `Interior`, \
								 `InX`, `InY`, `InZ`, `InVW`, `InInterior`) VALUES \
								 ('%s', '%d', '%d', '%d', \
								 '%f', '%f', '%f', '%d', '%d', \
								 '%f', '%f', '%f', '%d', '%d')",
								 Motels[motelID][motName], Motels[motelID][motRooms], Motels[motelID][motOccupied], Motels[motelID][motPrice],
								 Motels[motelID][motPosX], Motels[motelID][motPosY], Motels[motelID][motPosZ], Motels[motelID][motVW], Motels[motelID][motInt], 
								 Motels[motelID][motInX], Motels[motelID][motInY], Motels[motelID][motInZ], Motels[motelID][motInVW], Motels[motelID][motInInt]);
	mysql_query(query);
	return mysql_insert_id();
}

MruMySQL_LoadRoomAccess(roomID, count, input[MOTEL_MAX_ACCESS][12])
{
	new i, query[512];
	format(query, sizeof(query), "SELECT `UID`, `Nick` FROM `mru_konta` WHERE `UID` in (");
	for(new x = 0; x < count; x++) {
		strins(query, sprintf("%s ,", input[x]), strlen(query));
	}
	strdel(query, strlen(query)-1, strlen(query));
	strins(query, ")", strlen(query));
	mysql_query(query);
	mysql_store_result();
	while(mysql_fetch_row_format(query, "|"))
	{
		sscanf(query, "p<|>ds[32]",
			MotelRoomsAccess[roomID][i][mtraUID],
			MotelRoomsAccess[roomID][i][mtraNick]
		);
		i++;
	}
	mysql_free_result();
	return 1;
}

MruMySQL_LoadRooms() // £adowanie pokoi z bazy do systemu
{
	new lStr[512], roomsNum = 1;
	mysql_query("SELECT * FROM `mru_motele_rooms`");
	mysql_store_result();
	while(mysql_fetch_row_format(lStr, "|"))
	{
		new input[256];
		// Zapisywanie pokoi z bazy do tablicy MotelRooms
		sscanf(lStr, "p<|>dddddds[32]ds[256]",
			MotelRooms[roomsNum][mtrUID],
			MotelRooms[roomsNum][mtrMotUID], 
			MotelRooms[roomsNum][mtrRoomNum], 
			MotelRooms[roomsNum][mtrInterior], 
			MotelRooms[roomsNum][mtrOwnerUID],
			MotelRooms[roomsNum][mtrDoors], 
			MotelRooms[roomsNum][mtrLastOnline], 
			MotelRooms[roomsNum][mtrPayOffline], 
			input
		);
		new output[MOTEL_MAX_ACCESS][12], count;
		count = strexplode(output, input, ","); // Zbiera do tablicy listê UID graczy, którzy maj¹ dostêp do pokoju
		for(new i = 0; i < count; i++) {
			MotelRooms[roomsNum][mtrAccessCount]++;
		}
		if(MotelRooms[roomsNum][mtrAccessCount] > 0) {
			MruMySQL_LoadRoomAccess(roomsNum, count, output); // £adowanie dostêpów
		}
		roomsNum++;
	}
	mysql_free_result();
	printf("Wczytano %d pokoi", roomsNum-1);
	return 1;
}

MruMySQL_SaveMotelRooms()
{
	for(new i = 0; i<MAX_MOTEL_ROOMS; i++)
	{
		if(MotelRooms[i][mtrUID] != 0)
		{
			MruMySQL_SaveMotelRoom(i);
		}
	}
}

MruMySQL_SaveMotelRoom(roomID) 
{
	new query[512], formatted[256];
	if(MotelRooms[roomID][mtrAccessCount] > 0) {
		for(new i = 0; i < MOTEL_MAX_ACCESS; i++) {
			if(MotelRoomsAccess[roomID][i][mtraUID] != 0) strins(formatted, sprintf("%d ,", MotelRoomsAccess[roomID][i][mtraUID]), strlen(formatted));
		}
		strdel(formatted, strlen(formatted)-1, strlen(formatted));
	}

	format(query, sizeof(query), "UPDATE `mru_motele_rooms` SET \
								`MotelUID` = '%d', `RoomNum` = '%d', `Interior` = '%d', `OwnerUID` = '%d', \
								`Doors` = '%d', `LastOnline` = '%s', `PayOffline` = '%d', `Access` = '%s' \
								WHERE `UID` = '%d'",
								MotelRooms[roomID][mtrMotUID], MotelRooms[roomID][mtrRoomNum], MotelRooms[roomID][mtrInterior], MotelRooms[roomID][mtrOwnerUID],
								MotelRooms[roomID][mtrDoors], MotelRooms[roomID][mtrLastOnline], MotelRooms[roomID][mtrPayOffline], formatted,
								MotelRooms[roomID][mtrUID]);
	mysql_query(query);
	return 1;
}

MruMySQL_CreateMotelRoom(roomID)
{
	new query[512], formatted[256];
	for(new i = 0; i < MOTEL_MAX_ACCESS; i++) {
		if(MotelRoomsAccess[roomID][i][mtraUID] != 0) strins(formatted, sprintf("%d ,", MotelRoomsAccess[roomID][i][mtraUID]), strlen(formatted));
	}
	strdel(formatted, strlen(formatted)-1, strlen(formatted));

	format(query, sizeof(query), "INSERT INTO `mru_motele_rooms` \
								 (`MotelUID`, `RoomNum`, `Interior`, `OwnerUID`, `Doors`, `LastOnline`, `PayOffline`, `Access`) VALUES \
								 ('%d',		  '%d',		 '%d',		 '%d',       '%d',	  '%s',			'%d',		  '%s')",
								 MotelRooms[roomID][mtrMotUID], MotelRooms[roomID][mtrRoomNum], MotelRooms[roomID][mtrInterior], MotelRooms[roomID][mtrOwnerUID],
								 MotelRooms[roomID][mtrDoors], MotelRooms[roomID][mtrLastOnline], MotelRooms[roomID][mtrPayOffline], formatted);
	mysql_query(query);
	return mysql_insert_id();
}

MruMySQL_DestroyMotel(motelUID)
{
	new query[128];
	format(query, sizeof(query), "DELETE FROM `mru_motele` WHERE `UID` = '%d'", motelUID);
	mysql_query(query);
	return 1;
}

MruMySQL_MotelSetEvictState(UID, status)
{
	new query[128];
	format(query, sizeof(query), "UPDATE `mru_konta` SET `motelEvict` = '%d' WHERE `UID` = '%d'", status, UID);
	mysql_query(query);
	return 1;
}
//end