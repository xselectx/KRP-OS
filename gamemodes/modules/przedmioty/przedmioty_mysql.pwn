//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                 przedmioty                                                //
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
// Autor: renosk
// Data utworzenia: 06.05.2021
//Opis:
/*
	System przedmiotów
*/

//

//------------------<[ MySQL: ]>--------------------

SaveItem(itemid)
{
	if(Item[itemid][i_UID] == 0) return 0;
	mysql_query_format("UPDATE `mru_items` SET `name` = '%s', \
	`X` = '%f', `Y` = '%f', `Z` = '%f', \
	`vw` = '%d', `int` = '%d', \
	`dropped` = '%d', \
	`owner_type` = '%d', `owner` = '%d', \
	`item_type` = '%d', \
	`value1` = '%d', `value2` = '%d', \
	`used` = '%d', \
	`quantity` = '%d', \
	`secretValue` = '%d' \
	WHERE UID = '%d'", 
	Item[itemid][i_Name],
	Item[itemid][i_Pos][0], Item[itemid][i_Pos][1], Item[itemid][i_Pos][2], 
	Item[itemid][i_VW], Item[itemid][i_INT],
	Item[itemid][i_Dropped],
	Item[itemid][i_OwnerType], Item[itemid][i_Owner],
	Item[itemid][i_ItemType],
	Item[itemid][i_Value1], Item[itemid][i_Value2], 
	Item[itemid][i_Used],
	Item[itemid][i_Quantity],
	Item[itemid][i_ValueSecret],
	Item[itemid][i_UID]);
	return 1;
}

LoadItems(bool:stats = true)
{
	new query[456], dropped = 0;
	query = "`UID`, `name`, `X`, `Y`, `Z`, `vw`, `int`, `dropped`, `owner_type`, `owner`, `item_type`, `value1`, `value2`, `used`, `quantity`, `secretValue`";
	format(query, sizeof query, "SELECT %s FROM `mru_items` LIMIT %d", query, MAX_ITEMS);
	mysql_query(query);
	mysql_store_result();
	while(mysql_fetch_row_format(query, "|"))
	{
		new id = Iter_Free(Items);
		if(id == -1) return 0;
		sscanf(query, "p<|>ds[40]fffddddddddddd",
		Item[id][i_UID],
		Item[id][i_Name],
		Item[id][i_Pos][0],
		Item[id][i_Pos][1],
		Item[id][i_Pos][2],
		Item[id][i_VW],
		Item[id][i_INT],
		Item[id][i_Dropped],
		Item[id][i_OwnerType],
		Item[id][i_Owner],
		Item[id][i_ItemType],
		Item[id][i_Value1],
		Item[id][i_Value2],
		Item[id][i_Used],
		Item[id][i_Quantity],
		Item[id][i_ValueSecret]);
		Iter_Add(Items, id);
		mysql_query_format("UPDATE `mru_items` SET `server_id` = '%d' WHERE `UID` = '%d'", id, Item[id][i_UID]);
		if(stats) {
			if(Item[id][i_Dropped]) dropped++;
		}
	}
	mysql_free_result();
	if(stats) printf("[LOAD] Za³adowano ³¹cznie %d przedmiotów | Wyrzucone: %d |", Iter_Count(Items), dropped);
	return 1;
}

LoadPlayerItems(playerid)
{
	if(PlayerInfo[playerid][pUID] < 1) return 0;
	new query[428];
	mysql_query_format("SELECT `server_id` FROM `mru_items` WHERE `owner_type` = '%d' AND `owner` = '%d'", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID]);
	mysql_store_result();
	while(mysql_fetch_row_format(query, "|"))
	{
		new id;
		sscanf(query, "p<|>d", id);
		if(!Iter_Contains(Items, id)) continue;
		Iter_Add(PlayerItems[playerid], id);
	}
	mysql_free_result();

	/*foreach(new i : Items)
	{
		if(Item[i][i_OwnerType] != ITEM_OWNER_TYPE_PLAYER || Item[i][i_Owner] != PlayerInfo[playerid][pUID]) continue;
		if(Iter_Contains(PlayerItems[playerid], i)) continue;
		Iter_Add(PlayerItems[playerid], i);
	}*/
	return 1;
}

SaveItems()
{
	foreach(new i : Items)
		SaveItem(i);
	return 1;
}

//end