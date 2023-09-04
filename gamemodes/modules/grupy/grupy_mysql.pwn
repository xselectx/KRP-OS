//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                   grupy                                                   //
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
// Data utworzenia: 11.12.2021
//Opis:
/*
	System grup
*/

//

//------------------<[ MySQL: ]>--------------------
stock GroupsLoad()
{
	new lQuery[2048], lID, count;
	//Default fix
	mysql_query("UPDATE `mru_groups` SET `vLeader` = '0' WHERE `vLeader` = ''");
	mysql_query("UPDATE `mru_groups` SET `Ranks` = '-' WHERE `Ranks` = ''");
	mysql_query("UPDATE `mru_groups` SET `Skins` = '0' WHERE `Skins` = ''");
	mysql_query("UPDATE `mru_groups` SET `Flags` = '0' WHERE `Flags` = ''");
	//
    mysql_query("SELECT * FROM `mru_groups` WHERE 1");
    mysql_store_result();
    while(mysql_fetch_row_format(lQuery, "|"))
    {
		new rangi[256], ranga[MAX_RANG][MAX_RANG_LEN], skiny[256], vliderzy[32], flagi[256];
		sscanf(lQuery, "p<|>d", lID);
    	sscanf(lQuery, "p<|>ds[64]s[32]dffffdds[256]s[256]ds[32]dds[256]d",
    	GroupInfo[lID][g_UID],
    	GroupInfo[lID][g_Name],
		GroupInfo[lID][g_ShortName],
		GroupInfo[lID][g_Color],
    	GroupInfo[lID][g_Spawn][0],
    	GroupInfo[lID][g_Spawn][1],
    	GroupInfo[lID][g_Spawn][2],
    	GroupInfo[lID][g_Spawn][3],
    	GroupInfo[lID][g_Int],
    	GroupInfo[lID][g_VW],
		flagi,
		rangi,
		GroupInfo[lID][g_Leader],
		vliderzy,
		GroupInfo[lID][g_Money],
		GroupInfo[lID][g_Mats],
		skiny,
		GroupInfo[lID][g_MaxDuty]);
		if(GroupInfo[lID][g_Color] == 0 || GroupInfo[lID][g_Color] == 1)
			GroupInfo[lID][g_Color] = -1;
        sscanf(rangi, "p<,>A<s[25]>()[11]", ranga);
		for(new i=0;i<MAX_RANG;i++)
        {
			if(strlen(ranga[i]) > 1) format(GroupRanks[lID][i], 25, "%s", ranga[i]);
			else format(GroupRanks[lID][i], 25, "-");
		}
		sscanf(skiny, "p<,>A<d>(0)[20]", GroupInfo[lID][g_Skin]);
		sscanf(vliderzy, "p<,>A<d>(0)["#MAX_VLEADERS"]", GroupInfo[lID][g_vLeaders]);
		sscanf(flagi, "p<,>A<d>(0)[100]", GroupInfo[lID][g_Flags]);
		count++;
    }
    mysql_free_result();
    printf("[GRUPY]: Wczytano: %d grup ", count);
}

stock GroupSave(lID, bool:savehalf = false)
{
	new lQuery[512];
	new name_escaped[64], shortname_escaped[32];
	mysql_real_escape_string(GroupInfo[lID][g_Name], name_escaped);
	mysql_real_escape_string(GroupInfo[lID][g_ShortName], shortname_escaped);
	format(lQuery, sizeof(lQuery), "UPDATE `mru_groups` SET `Name` = '%s', `ShortName` = '%s', `Color` = '%d', `x`='%f', `y`='%f', `z`='%f', `a`='%f', `Int`='%d', `VW`='%d', `Leader` = '%d', `Money` = '%d', `Mats` = '%d', `MaxDuty` = '%d' WHERE `UID`='%d'",
		name_escaped, shortname_escaped, GroupInfo[lID][g_Color], GroupInfo[lID][g_Spawn][0], GroupInfo[lID][g_Spawn][1], GroupInfo[lID][g_Spawn][2], GroupInfo[lID][g_Spawn][3], GroupInfo[lID][g_Int], GroupInfo[lID][g_VW], GroupInfo[lID][g_Leader], GroupInfo[lID][g_Money], GroupInfo[lID][g_Mats], GroupInfo[lID][g_MaxDuty], GroupInfo[lID][g_UID]);
	if(lQuery[0]) mysql_query(lQuery);
	if(savehalf == false)
	{
		//Rangi - Save
		new string[256], first = -1;
		for(new i = 0; i < MAX_RANG; i++)
		{
			if(!strlen(GroupRanks[lID][i])) format(GroupRanks[lID][i], MAX_RANG_LEN, "-");
			if(first == -1) first = i;
			format(string, sizeof(string), "%s%s%s", string, (first == i) ? ("") : (","), GroupRanks[lID][i]);
		}
		if(strlen(string) > 1) 
		{
			format(lQuery, sizeof(lQuery), "UPDATE `mru_groups` SET `Ranks` = '%s' WHERE `UID` = '%d'", string, GroupInfo[lID][g_UID]);
			mysql_query(lQuery);
		}
		//

		//Skiny - Save
		first = -1;
		format(string, sizeof(string), "");
		for(new i = 0; i < 20; i++)
		{
			if(GroupInfo[lID][g_Skin][i] < 1) continue;
			if(first == -1) first = i;
			format(string, sizeof(string), "%s%s%d", string, (first == i) ? ("") : (","), GroupInfo[lID][g_Skin][i]);
		}
		if(strlen(string) > 1) 
		{
			format(lQuery, sizeof(lQuery), "UPDATE `mru_groups` SET `Skins` = '%s' WHERE `UID` = '%d'", string, GroupInfo[lID][g_UID]);
			mysql_query(lQuery);
		}
		//

		//Vliderzy - Save
		first = -1;
		format(string, sizeof(string), "");
		for(new i = 0; i < MAX_VLEADERS; i++)
		{
			if(GroupInfo[lID][g_vLeaders][i] < 1) continue;
			if(first == -1) first = i;
			format(string, sizeof(string), "%s%s%d", string, (first == i) ? ("") : (","), GroupInfo[lID][g_vLeaders][i]);
		}
		if(strlen(string) > 1) 
		{
			format(lQuery, sizeof(lQuery), "UPDATE `mru_groups` SET `vLeader` = '%s' WHERE `UID` = '%d'", string, GroupInfo[lID][g_UID]);
			mysql_query(lQuery);
		}
		//
		//Flagi - Save
		first = -1;
		format(string, sizeof(string), "");
		for(new i = 0; i < 100; i++)
		{
			if(GroupInfo[lID][g_Flags][i] < 1) continue;
			if(first == -1) first = i;
			format(string, sizeof(string), "%s%s%d", string, (first == i) ? ("") : (","), GroupInfo[lID][g_Flags][i]);
		}
		if(strlen(string) > 1) 
		{
			format(lQuery, sizeof(lQuery), "UPDATE `mru_groups` SET `Flags` = '%s' WHERE `UID` = '%d'", string, GroupInfo[lID][g_UID]);
			mysql_query(lQuery);
		}
		//
	}
	printf("[GRUPY]: Zapisano grupê UID %d [%s] ", GroupInfo[lID][g_UID], name_escaped);
	return 1;
}

stock GroupDelete(groupid)
{
	if(!IsValidGroup(groupid)) return 0;

	//Usuñ graczy z grupy
	foreach(new i : Player)
	{
		if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
		if(IsPlayerInGroup(i, groupid))
		{
			GroupRemovePlayer(i, groupid, 1);
			sendErrorMessage(i, "Zosta³eœ wyrzucony z grupy, poniewa¿ zosta³a ona usuniêta!");
		}
	}
	for(new i = 0; i < 3; i++)
	{
		mysql_query_format("UPDATE `mru_konta` SET `Grupa%d` = '0', `Grupa%dRank` = '0', `Grupa%dSkin` = '0' WHERE `Grupa%d` = '%d'", i+1, i+1, i+1, i+1, groupid);
	}
	//
	mysql_query_format("DELETE FROM `mru_groups` WHERE `UID` = '%d'", groupid);
	format(GroupInfo[groupid][g_Name], 64, "");
	format(GroupInfo[groupid][g_ShortName], 32, "");
	for(new i = 0; i < MAX_VLEADERS; i++) GroupInfo[groupid][g_vLeaders][i] = 0;
	for(new i = 0; i < 100; i++) GroupInfo[groupid][g_Flags][i] = 0;
	for(new i = 0; i < 10; i++) format(GroupRanks[groupid][i], MAX_RANG_LEN, "");
	for(new i = 0; i < 20; i++) GroupInfo[groupid][g_Skin][i] = 0;
	GroupInfo[groupid][g_UID] = 0;
	GroupInfo[groupid][g_Color] = -1;
	GroupInfo[groupid][g_Spawn][0] = 0.0;
	GroupInfo[groupid][g_Spawn][1] = 0.0;
	GroupInfo[groupid][g_Spawn][2] = 0.0;
	GroupInfo[groupid][g_Spawn][3] = 0.0;
	GroupInfo[groupid][g_Int] = 0;
	GroupInfo[groupid][g_VW] = 0;
	GroupInfo[groupid][g_Money] = 0;
	GroupInfo[groupid][g_Mats] = 0;
	GroupInfo[groupid][g_Leader] = 0;
	return 1;
}

stock GroupCreate(name[], Float:x, Float:y, Float:z, Float:a, interior, VW, color = 1, shortname[] = "")
{
	new lQuery[512];
	new name_escaped[64], shortname_escaped[32], short[32];
	if(x == 0 && y == 0 && z == 0) return -3;

	format(short, sizeof(short), "%s", shortname);
	if(strcmp(shortname, "") == 0)
	{
		for(new i = 0; i<strlen(name); i++)
		{
			if((toupper(name[i]) == name[i] && name[i] != ' ') || (name[i-1] == ' '))
			{
				format(short, sizeof(short), "%s%c", short, name[i]);
			}
		}
	}
	mysql_real_escape_string(name, name_escaped);
	mysql_real_escape_string(short, shortname_escaped);

	format(lQuery, sizeof(lQuery), "INSERT INTO `mru_groups` (`Name`, `ShortName`, `Color`, `x`, `y`, `z`, `a`, `Int`, `VW`) VALUES ('%s', '%s', '%d', '%f', '%f', '%f', '%f', '%d', '%d')",
		name_escaped, shortname_escaped, color, x, y, z, a, interior, VW);
	if(mysql_query(lQuery)) 
	{
		new id = mysql_insert_id();
		if(id == -1) return -1;
		GroupInfo[id][g_UID] = id;
		format(GroupInfo[id][g_Name], 64, "%s", name_escaped);
		format(GroupInfo[id][g_ShortName], 32, "%s", shortname_escaped);
		for(new i = 0; i < MAX_VLEADERS; i++) GroupInfo[id][g_vLeaders][i] = 0;
		GroupInfo[id][g_Color] = color;
		GroupInfo[id][g_Spawn][0] = x;
		GroupInfo[id][g_Spawn][1] = y;
		GroupInfo[id][g_Spawn][2] = z;
		GroupInfo[id][g_Spawn][3] = a;
		GroupInfo[id][g_Int] = interior;
		GroupInfo[id][g_VW] = VW;
		GroupInfo[id][g_Money] = 0;
		GroupInfo[id][g_Mats] = 0;
		GroupInfo[id][g_Leader] = 0;
		printf("[GRUPY]: Stworzono grupê UID %d [%s] ", GroupInfo[id][g_UID], name_escaped);
		return id;
	}
	else return -2;
}

GroupEmployeeCount(groupid)
{
	if(!IsValidGroup(groupid)) return 0;
	new count = 0;
	mysql_query_format("SELECT `UID` FROM `mru_konta` WHERE `Grupa1` = '%d' OR `Grupa2` = '%d' OR `Grupa3` = '%d'", groupid, groupid, groupid);
	mysql_store_result();
	count = mysql_num_rows();
	mysql_free_result();
	return count;
}

//end