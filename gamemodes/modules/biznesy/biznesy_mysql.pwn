//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  biznesy                                                  //
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
// Autor: 2.5
// Data utworzenia: 04.05.2019
//Opis:
/*
	System biznesÃ³w.
*/

//

//------------------<[ MySQL: ]>--------------------
LoadBusiness()//?adowanie biznesów z bazy danych
{
	new lStr[1024];
	lStr = "`ID`, `ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Money`, `Cost`, `Location`, `MoneyPocket`";

	format(lStr, 1024, "SELECT %s FROM `mru_business` LIMIT "#MAX_BIZNES"", lStr);
	mysql_query(lStr);
	mysql_store_result();
	while(mysql_fetch_row_format(lStr, "|"))
	{
		new CurrentBID;
		sscanf(lStr, "p<|>d", CurrentBID);
		if(CurrentBID < 1) continue;
		sscanf(lStr, "p<|>dds[32]s[64]ffffffddddds[64]d",
		Business[CurrentBID][b_ID], 
		Business[CurrentBID][b_ownerUID],
		Business[CurrentBID][b_Name_Owner],
		Business[CurrentBID][b_Name],
		Business[CurrentBID][b_enX],
		Business[CurrentBID][b_enY],
		Business[CurrentBID][b_enZ],
		Business[CurrentBID][b_exX],
		Business[CurrentBID][b_exY],
		Business[CurrentBID][b_exZ],
		Business[CurrentBID][b_vw],
		Business[CurrentBID][b_int],
		Business[CurrentBID][b_pLocal],
		Business[CurrentBID][b_maxMoney],
		Business[CurrentBID][b_cost],
		Business[CurrentBID][b_Location],
		Business[CurrentBID][b_moneyPocket]);
	}
	mysql_free_result();
	return 1;
}
ClearBusinessOwner(businessID)
{
	new query[256];
	format(query, sizeof(query), "UPDATE `mru_konta` SET \
	`bizz`='%d' \
	WHERE `bizz`='%d'", INVALID_BIZ_ID, businessID); 
	mysql_query(query); 
	format(query, sizeof(query), "UPDATE `mru_business` SET \
	`ownerUID`='%d', \
	`ownerName`='Brak' \
	WHERE `ID`='%d'", 0, businessID);
	mysql_query(query); 
	return 1;
}
Create_BusinessMySQL()
{
	new query[1024];

	format(query, sizeof(query), "INSERT INTO `mru_business` (`ownerUID`, `ownerName`, `Name`, `enX`, `enY`, `enZ`, `exX`, `exY`, `exZ`, `exVW`, `exINT`, `pLocal`, `Money`, `Cost`, `Location`, `MoneyPocket`) VALUES\
	('0', 'Brak - na sprzeda¿', 'Brak', '0.0', '0.0', '0.0', '0.0', '0.0', '0.0', '0', '0', '0', '0', '0', 'Los Santos', '0')");

	mysql_query(query);
	return mysql_insert_id();
}
SaveBusiness(busID)//Zapis biznesów do bazy danych
{
	new query[1024];
	format(query, sizeof(query), "UPDATE `mru_business` SET \
	`ownerUID`='%d', \
	`ownerName`='%s', \
	`Name`='%s', \
	`enX`='%f', \
	`enY`='%f', \
	`enZ`='%f', \
	`exX`='%f', \
	`exY`= '%f', \
	`exZ`= '%f', \
	`exVW`= '%d', \
	`exINT` = '%d', \
	`pLocal` = '%d', \
	`Money` = '%d', \
	`Cost` = '%d', \
	`Location` = '%s', \
	`MoneyPocket` = '%d' \
	WHERE `ID`='%d'", 
	Business[busID][b_ownerUID],
	Business[busID][b_Name_Owner],
	Business[busID][b_Name],
	Business[busID][b_enX], 
	Business[busID][b_enY],
	Business[busID][b_enZ],
	Business[busID][b_exX],
	Business[busID][b_exY],
	Business[busID][b_exZ],
	Business[busID][b_vw],
	Business[busID][b_int],
	Business[busID][b_pLocal],
	Business[busID][b_maxMoney],
	Business[busID][b_cost],
	Business[busID][b_Location],
	Business[busID][b_moneyPocket],
	busID); 
	mysql_query(query);
	return 1;
}

//end