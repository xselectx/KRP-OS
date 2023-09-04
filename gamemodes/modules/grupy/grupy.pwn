//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------

IsValidGroup(groupid)
{
	if(groupid < 0 || groupid >= MAX_GROUPS) return 0;
	if(GroupInfo[groupid][g_UID] < 1) return 0;
	return 1;
}

GroupSetPerm(UID, Perm, bool:Set=true)
{
	if(Set == true)
	{
		for(new i = 0; i < 100; i++)
		{
			if(GroupInfo[UID][g_Flags][i] < 1)
			{
				GroupInfo[UID][g_Flags][i] = Perm;
				break;
			}
		}
	}
	else if(Set == false)
	{
		for(new i = 0; i < 100; i++)
		{
			if(GroupInfo[UID][g_Flags][i] == Perm)
			{
				GroupInfo[UID][g_Flags][i] = 0;
				break;
			}
		}
	}
	return 1;
}

GroupHavePerm(UID, Perm)
{
	if(!IsValidGroup(UID)) return false;
	for(new i = 0; i < 100; i++)
	{
		if(GroupInfo[UID][g_Flags][i] == Perm)
			return true;
	}
	return false;
}

GroupSendAnnouncement(playerid, groupid, msg[])
{
	new string[256];
	if(!IsValidGroup(groupid)) return 0;
	if(!GroupHavePerm(groupid, PERM_FINFO)) return 0;
	if(PlayerInfo[playerid][pBP])
	{
		format(string, sizeof(string), "   Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
		SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
		return 1;
	}
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ podczas @duty"); 
		return 1;
	}
	if(sprawdzReklame(msg, playerid)) return 0;
	new content[256];
	GetPVarString(playerid, "trescOgloszenia", content, sizeof(content));
	if(PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] >= 1)
	{
		PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 60-komunikatMinuty[playerid];
		format(string, sizeof(string), "Wys³a³eœ og³oszenie o tej samej treœci, odczekaj jeszcze %d minut", PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas]);
		sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string); 
		format(string, sizeof(string), "{A0522D}Ostatnie og³oszenie: {FFFFFF}%s", content);
		sendTipMessage(playerid, string);
		return 1;
	}
	if(strfind(msg, content, false) == -1)
	{
		if(strlen(msg) > 105)
		{
			sendErrorMessage(playerid, "Twoja wiadomoœæ by³a zbyt d³uga, skróæ j¹!"); 
			return 1;
		}
		SetPVarString(playerid, "trescOgloszenia", msg);
		sendFractionMessageToAll(playerid, groupid, msg); 
		komunikatTimeZerowanie[playerid] = SetTimerEx("KomunikatCzasZerowanie", 60000, true, "i", playerid);
		sendTipMessage(playerid, "Odczekaj 5 minut przed wys³aniem ponownego komunikatu o {AC3737}tej samej treœci"); 
		return 1;
	}

	SendClientMessage(playerid, -1, " "); 
	sendTipMessageEx(playerid, COLOR_WHITE, "Wys³a³eœ og³oszenie o tej samej treœci w czasie mniejszym jak {AC3737}5 minut!");
	sendTipMessageEx(playerid, COLOR_WHITE, "{C0C0C0}Zostajesz ukarany kar¹ Anty-Spam na {AC3737}60 minut");
	komunikatTime[playerid] = SetTimerEx("KomunikatCzas", 60000, true, "i", playerid);		
	PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 60;
	format(string, sizeof(string), "[ANTY_SPAM] %s otrzyma³ blokadê na 60 minut za wys³anie 2x tego samego komunikatu!", GetNickEx(playerid));
	SendAdminMessage(COLOR_BLUE, string);
	return 1;
}

GroupShowInfo(playerid, groupid, admin = 0)
{
	if(!IsPlayerConnected(playerid) || !IsValidGroup(groupid)) return 0;
	new string[1024], nick[26];
	strmid(nick, MruMySQL_GetNameFromUID(GroupInfo[groupid][g_Leader]), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
	if(!strlen(nick)) format(nick, sizeof(nick), "{FF0000}BRAK");
	format(string, sizeof(string), "{FFFFFF}Nazwa grupy: {BA782D}%s\n", GroupInfo[groupid][g_Name]);
	format(string, sizeof(string), "%s{FFFFFF}Skrót grupy: {BA782D}%s\n", string, GroupInfo[groupid][g_ShortName]);
	if(GroupIsVLeader(playerid, groupid) || admin) format(string, sizeof(string), "%s{FFFFFF}Kasa w sejfie: {BA782D}%d{FFFFFF}$\n", string, GroupInfo[groupid][g_Money]);
	if(GroupIsVLeader(playerid, groupid) || admin) format(string, sizeof(string), "%sMatsy w sejfie: {BA782D}%d\n", string, GroupInfo[groupid][g_Mats]);
	format(string, sizeof(string), "%s{FFFFFF}G³ówny lider: %s", string, nick);
	strcat(string, "\n{FFFFFF}Uprawnienia: ");
	for(new i = 0; i < sizeof(gUprawnieniaInfo); i++)
	{
		if(!GroupHavePerm(groupid, i+1)) continue;
		format(string, sizeof(string), "%s{00FF00}%s{FFFFFF}, ", string, gUprawnieniaInfo[i]);
	}
	strreplace(string, ",", "", true, strlen(string)-2);
	ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_MSGBOX, MruTitle(sprintf("Informacje o grupie %s", GroupInfo[groupid][g_ShortName])), string, "OK", #);
	return 1;
}

GroupShowLeaderPanel(playerid, group, type, bool:asadmin = false, page = 1)
{
	if(group < 0 || group > MAX_GROUPS) return 0;
	if(!IsPlayerConnected(playerid)) return 0;
	if(!GroupIsLeader(playerid, group) && !GroupIsVLeader(playerid, group) && !PlayerInfo[playerid][pAdmin]) return 0;

	switch(type)
	{
		case 1:
		{
			new options[256];
			strcat(options, "»» Zarz¹dzanie rangami\n");
			strcat(options, "»» Zarz¹dzaj pojazdami\n");
			strcat(options, "»» Zarz¹dzaj pracownikami\n");
			strcat(options, "»» Zarz¹dzaj liderami\n");
			strcat(options, "»» Zmieñ kolor grupy\n");
			strcat(options, "»» Zmieñ nazwê grupy\n");
			strcat(options, "»» Zmieñ skrót\n");
			strcat(options, "»» SprawdŸ uprawnienia grupy\n");
			if(GroupHavePerm(group, PERM_RESTAURANT))
				strcat(options, "»» Zarz¹dzaj restauracj¹\n");
			strcat(options, "»» Informacje o grupie\n");
			SetPVarInt(playerid, "group-panel", group+1);
			ShowPlayerDialogEx(playerid, D_GROUPLEADERPANEL, DIALOG_STYLE_LIST, sprintf("Panel grupy %s", GroupInfo[group][g_ShortName]), options, "Dalej", "Zamknij");
		}
		case 2: //Ranks
		{
			new string[256];
			for(new i = 0; i < MAX_RANG; i++)
				format(string, sizeof(string), "%s\n%d.\t%s", string, i, GroupRanks[group][i]);
			SetPVarInt(playerid, "group-panel", group+1);
			ShowPlayerDialogEx(playerid, D_GROUPLEADERRANKS, DIALOG_STYLE_LIST, sprintf("Panel grupy %s - Rangi", GroupInfo[group][g_ShortName]), string, "Dalej", "Zamknij");
			DeletePVar(playerid, "group-editingrank");
		}
		case 3: //Employees
		{
			new query[256];
			format(query, sizeof(query), "SELECT COUNT(*) FROM `mru_konta` WHERE `Grupa1` = '%d' OR `Grupa2` = '%d' OR `Grupa3` = '%d'", GroupInfo[group][g_UID], GroupInfo[group][g_UID], GroupInfo[group][g_UID]);
			mysql_query(query);
			mysql_store_result();
			new row[24];
			mysql_fetch_row_format(row,"|");
			new ilosc = strval(row);
			mysql_free_result();

			if(ilosc == 0)
				return sendErrorMessage(playerid, "Ta grupa nie ma ¿adnych pracowników.");
			new header[128], Float:pp = ilosc / 20;
			format(header, sizeof(header), "Panel Lidera » Pracownicy [%d/%d]", page, floatround(pp, floatround_ceil)+1);

			DynamicGui_Init(playerid);

			new employees[1400];

			employees = "UID\tNazwa\tRanga";
			new offset = (page - 1) * 20;
			format(query, sizeof(query), "SELECT `UID`, `connected`, `Nick`, `Grupa1`, `Grupa2`, `Grupa3`, `Grupa1Rank`, `Grupa2Rank`, `Grupa3Rank` FROM `mru_konta` WHERE `Grupa1` = '%d' OR `Grupa2` = '%d' OR `Grupa3` = '%d' LIMIT %d,%d", GroupInfo[group][g_UID], GroupInfo[group][g_UID], GroupInfo[group][g_UID], offset, 20);
			mysql_query(query);
			mysql_store_result();
			while(mysql_fetch_row_format(query, "|"))
			{
				new uid, connected, nick[24], pgroup[3], pgrouprank[3], slot;
				sscanf(query, "p<|>dds[24]dddddd", uid, connected, nick, pgroup[0], pgroup[1], pgroup[2], pgrouprank[0], pgrouprank[1], pgrouprank[2]);
				//if(uid == PlayerInfo[playerid][pUID]) continue;
				for(new i = 0; i < 3; i++)
				{
					if(pgroup[i] == GroupInfo[group][g_UID])
					{
						slot = i;
					}
				}
				format(employees, sizeof(employees), "%s\n%d\t{%s}%s\t%s [%d]", employees, uid, (connected) ? ("00FF00") : ("FF0000"), nick, GroupRanks[group][pgrouprank[slot]], pgrouprank[slot]);
				DynamicGui_AddRow(playerid, uid, slot);
			}
			if( page > 1 )
			{
				format(employees, sizeof(employees), "%s\n\n{888888}<<< Poprzednia strona", employees);
				DynamicGui_AddRow(playerid, -2000);
			}
			if( ilosc > (page*20) )
			{
				format(employees, sizeof(employees), "%s\n\n{888888}Nastêpna strona >>>", employees);
				DynamicGui_AddRow(playerid, -3000);
			}
			mysql_free_result();
			SetPVarInt(playerid, "group-panel", group+1);
			DynamicGui_SetDialogValue(playerid, page);
			ShowPlayerDialogEx(playerid, D_GROUPLEADEREMPLOYEES, DIALOG_STYLE_TABLIST_HEADERS, header, employees, "Zarz¹dzaj", "Zamknij");
		}
		case 4: //Vehicle
		{
			new string[1024];
            string = "ID\tNazwa";
            for(new i = 0; i < MAX_VEHICLES; i++)
            {
                if(VehicleUID[i][vUID] == 0) continue;
                new lcarid = VehicleUID[i][vUID];
                if(CarData[lcarid][c_OwnerType] == CAR_OWNER_GROUP && CarData[lcarid][c_Owner] == group)
                {
                    format(string, sizeof(string), "%s\n%d\t%s", string, i, VehicleNames[GetVehicleModel(i)-400]);
                }
            }
            if(strlen(string) < 11)
                return sendErrorMessage(playerid, "Twoja grupa nie ma ¿adnych pojazdów.");
            ShowPlayerDialogEx(playerid, D_GROUPLEADERVEHICLE, DIALOG_STYLE_TABLIST_HEADERS, MruTitle("Zarz¹dzanie pojazdami"), string, "Zarz¹dzaj", "Cofnij");
		}
		case 5: //VLeader
		{
			if(!GroupIsLeader(playerid, group) && !asadmin)
			{
				sendErrorMessage(playerid, "Brak uprawnieñ, musisz byæ g³ównym liderem!");
				return GroupShowLeaderPanel(playerid, group, 1);
			}
			DynamicGui_Init(playerid);
			new string[456], count = 0;
			for(new i = 0; i<MAX_VLEADERS; i++)
			{
				if(GroupInfo[group][g_vLeaders][i] < 1) continue;
				new nick[26];
				strmid(nick, MruMySQL_GetNameFromUID(GroupInfo[group][g_vLeaders][i]), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
				if(strlen(nick))
				{
					format(string, sizeof(string), "%s\n%s", string, nick);
					DynamicGui_AddRow(playerid, GroupInfo[group][g_vLeaders][i]);
					count++;
				}
			}
			if(count < MAX_VLEADERS) 
			{
				strcat(string, "\n{00FF00}Dodaj lidera");
				DynamicGui_AddRow(playerid, 798978);
			}
			SetPVarInt(playerid, "group-panel", group+1);
			ShowPlayerDialogEx(playerid, D_GROUP_MANAGE_LEADERS, DIALOG_STYLE_LIST, sprintf("Zarz¹dzanie liderami w %s", GroupInfo[group][g_ShortName]), string, "Zarz¹dzaj", "Cofnij");
		}
	}
	return 1;
}

GroupPlayerDutyPerm(playerid, perm)
{
	if(IsPlayerNPC(playerid)) return 0;
	if(OnDuty[playerid] > 0 && GroupHavePerm(PlayerInfo[playerid][pGrupa][OnDuty[playerid]-1], perm)) return 1;
	return 0;
}

GroupRank(playerid, groupid)
{
	if(!IsValidGroup(groupid)) return 0;
	new slot = GetPlayerGroupSlot(playerid, groupid);
	if(slot == 0) return 0;
	return PlayerInfo[playerid][pGrupaRank][slot-1];
}

GroupPlayerDutyRank(playerid)
{
	if(IsPlayerNPC(playerid)) return 0;
	new group = OnDuty[playerid]-1;
	if(group < 0) return 0;
	return PlayerInfo[playerid][pGrupaRank][group];
}

GroupIsLeader(playerid, groupid)
{
	if(IsPlayerNPC(playerid)) return 0;
	if(GroupInfo[groupid][g_Leader] == PlayerInfo[playerid][pUID])
		return 1;
	return 0;
}

GroupIsVLeader(playerid, groupid, countleader = 1)
{
	if(IsPlayerNPC(playerid)) return 0;
	if(!IsValidGroup(groupid)) return false;
	if(GroupInfo[groupid][g_Leader] == PlayerInfo[playerid][pUID] && countleader)
		return true;
	for(new i = 0; i < MAX_VLEADERS; i++)
	{
		if(GroupInfo[groupid][g_vLeaders][i] == PlayerInfo[playerid][pUID])
			return  true;
	}
	return false;
}

GroupAddVLeader(groupid, uid, playerid = -1, info = 1)
{
	if(!IsValidGroup(groupid)) return 0;
	for(new i = 0; i < MAX_VLEADERS; i++)
	{
		if(GroupInfo[groupid][g_vLeaders][i] == uid) return 0;
		if(GroupInfo[groupid][g_vLeaders][i] < 1)
		{
			GroupInfo[groupid][g_vLeaders][i] = uid;
			break;
		}
	}
	GroupSave(groupid);
	if(info && playerid != -1)
	{
		foreach(new i : Player)
		{
			if(!IsPlayerConnected(i)) continue;
			if(PlayerInfo[i][pUID] == uid)
			{
				va_SendClientMessage(i, COLOR_LIGHTBLUE, "(Zosta³eœ mianowany v-liderem w grupie %s przez %s)", GroupInfo[groupid][g_Name], GetNick(playerid));
				return 1;
			}
		}
	}
	return 1;
}

GroupRemoveVLeader(groupid, uid)
{
	if(!IsValidGroup(groupid)) return 0;
	for(new i = 0; i < MAX_VLEADERS; i++)
	{
		if(GroupInfo[groupid][g_vLeaders][i] == uid)
		{
			GroupInfo[groupid][g_vLeaders][i] = 0;
			break;
		}
	}
	GroupSave(groupid);
	return 1;
}

GroupRemovePlayer(playerid, groupid, kicked, kickedby = INVALID_PLAYER_ID)
{
	if(!IsValidGroup(groupid)) return 0;
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsPlayerInGroup(playerid, groupid)) return 0;
	new slot = GetPlayerGroupSlot(playerid, groupid);
	if(slot == 0) return 0;
	slot--;

	PlayerInfo[playerid][pGrupa][slot] = 0;
	PlayerInfo[playerid][pGrupaRank][slot] = 0;
	PlayerInfo[playerid][pGrupaSkin][slot] = 0;
	if(OnDuty[playerid] == slot+1)
	{
		OnDuty[playerid] = 0;
		JobDuty[playerid] = 0;
		SanDuty[playerid] = 0;
		PlayerInfo[playerid][pUniform] = 0;
		UpdatePlayer3DName(playerid);
		SetPlayerSpawnSkin(playerid);
		SetPlayerToTeamColor(playerid);
	}
	if(GroupIsVLeader(playerid, groupid, 0)) //Usuñ v-lidera
	{
		GroupRemoveVLeader(groupid, PlayerInfo[playerid][pUID]);
	}
	if(kicked == 1)
	{
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "(Zosta³eœ wyrzucony z grupy %s przez %s)", GroupInfo[groupid][g_Name], (IsPlayerConnected(kickedby)) ? (GetNick(kickedby)) : ("SYSTEM"));
		if(IsPlayerConnected(kickedby))
		{
			va_SendClientMessage(kickedby, COLOR_LIGHTBLUE, "(Wyrzuci³eœ %s z grupy %s)", GetNick(playerid), GroupInfo[groupid][g_Name]);
		}
		Log(serverLog, WARNING, "%s zosta³ wyrzucony z grupy %s przez %s", GetPlayerLogName(playerid), GetGroupLogName(groupid), (IsPlayerConnected(kickedby)) ? (GetPlayerLogName(kickedby)) : ("SYSTEM"));
	}
	else
	{
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Opuœci³eœ grupê %s.", GroupInfo[groupid][g_Name]);
		SendLeaderRadioMessage(groupid, COLOR_LIGHTGREEN, sprintf("> %s opusci³ grupê %s", GetNickEx(playerid), GroupInfo[groupid][g_Name]));
		Log(serverLog, WARNING, "%s opuœci³ grupê %s", GetPlayerLogName(playerid), GetGroupLogName(groupid));
	}
	return 1;
}

GroupAddPlayer(playerid, groupid, rank = 0, invitedby = INVALID_PLAYER_ID)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(!IsValidGroup(groupid)) return 0;
	if(IsPlayerInGroup(playerid, groupid)) return -1;
	if(!GroupCanPlayerJoin(playerid, groupid)) return -2;

	new slot = -1;
	for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
	{
		if(PlayerInfo[playerid][pGrupa][i] < 1)
		{
			slot = i;
			break;
		}
	}
	if(slot == -1) return -3;
	PlayerInfo[playerid][pGrupa][slot] = groupid;
	PlayerInfo[playerid][pGrupaRank][slot] = rank;
	PlayerInfo[playerid][pGrupaSkin][slot] = 0;
	MruMySQL_SaveAccount(playerid);
	if(IloscSkinow(groupid))
		RunCommand(playerid, "/g", sprintf("%d skin", slot+1));
	if(invitedby != INVALID_PLAYER_ID)
	{
		va_SendClientMessage(invitedby, COLOR_LIGHTBLUE, "(Przyj¹³eœ %s do swojej grupy %s, ranga: %s)", GetNick(playerid), GroupInfo[groupid][g_Name], GroupRanks[groupid][rank]);
        va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "(Lider %s przyj¹³ Ciê do grupy %s, ranga: %s)", GetNick(invitedby), GroupInfo[groupid][g_Name], GroupRanks[groupid][rank]);
		Log(serverLog, WARNING, "%s przyj¹³ %s do grupy %s", GetPlayerLogName(invitedby), GetPlayerLogName(playerid), GetGroupLogName(groupid));
	}
	else
	{
		va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "(Zosta³eœ przyjêty do grupy %s, ranga: %s)", GroupInfo[groupid][g_Name], GroupRanks[groupid][rank]);
	}
	return 1;
}

IsPlayerInGroup(playerid, grupa, requireduty = 0)
{
	if(IsPlayerNPC(playerid)) return 0;
	for(new i=0;i<MAX_PLAYER_GROUPS;i++)
	{
		if(requireduty && OnDuty[playerid] != GetPlayerGroupSlot(playerid, grupa)) continue;
		if(PlayerInfo[playerid][pGrupa][i] == grupa) return 1;
	}
	return 0;
}

GetPlayerGroupSlot(playerid, grupa)
{
	if(IsPlayerNPC(playerid)) return 0;
	for(new i=0;i<MAX_PLAYER_GROUPS;i++)
	{
		if(PlayerInfo[playerid][pGrupa][i] == grupa) return i+1;
	}
	return 0;
}

GetPlayerGroupUID(playerid, slot)
{
	if(IsPlayerNPC(playerid)) return 0;
	return PlayerInfo[playerid][pGrupa][slot];
}

CheckPlayerPerm(playerid, Perm)
{
	if(IsPlayerNPC(playerid)) return 0;
	for(new i=0;i<MAX_PLAYER_GROUPS;i++)
	{
		if(GroupHavePerm(PlayerInfo[playerid][pGrupa][i], Perm)) return 1;
	}
	return 0;
}

GroupSendMessageOOC(playerid, group, params[], bool:fromchat = false)
{
	if(IsPlayerConnected(playerid))
	{
		if(group < 0 || group > MAX_PLAYER_GROUPS)
		{
			return sendTipMessage(playerid, "U¿yj (/ro)oc[slot] [tekst]");
		}
		if(isnull(params))
		{
			new help[64];
			format(help, sizeof(help), "U¿yj %s%d [tekst]", (fromchat) ? ("@") : ("/ro"), group);
			sendTipMessage(playerid, help);
			return 1;
		}
		if(gRO[playerid] == 1) return sendTipMessage(playerid, "Nie mo¿esz pisaæ na (/ro), zablokowa³eœ ten czat (U¿yj /togro)");

		new member = PlayerInfo[playerid][pGrupa][group-1];
		if(member > 0)
		{
			new string[256];
			format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", GroupRanks[member][PlayerInfo[playerid][pGrupaRank][group-1]],PlayerInfo[playerid][pGrupaRank][group-1],GetNickEx(playerid), params);
			SendRadioMessage(member, GroupInfo[member][g_Color], string, 1);
			Log(chatLog, WARNING, "%s radio %d OOC: %s", GetPlayerLogName(playerid), member, params);
			SendDiscordGroupMessage(member, string);
		}
		else
		{
			sendTipMessage(playerid, "Pod tym slotem nie masz ¿adnej grupy!");
			return 1;
		}
	}
	return 1;
}

GroupSendMessage(group, color, message[], bool:onduty = false)
{
	if(!IsValidGroup(group)) return 0;
	foreach(new i : Player)
	{
		if(!IsPlayerConnected(i) || IsPlayerNPC(i)) continue;
		if(IsPlayerInGroup(i, group, onduty))
			SendClientMessage(i, color, message);
	}
	return 1;
}

GroupSendMessageRadio(playerid, group, params[], bool:fromchat = false)
{
	if(IsPlayerConnected(playerid))
    {
		if(group < 0 || group > MAX_PLAYER_GROUPS)
		{
			return sendTipMessage(playerid, "U¿yj (/r)adio[slot] [tekst]");
		}
		if(isnull(params))
		{
			new help[64];
			format(help, sizeof(help), "U¿yj %s%d [tekst]", (fromchat) ? ("!") : ("/r"), group);
			sendTipMessage(playerid, help);
			return 1;
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz pisaæ poniewa¿ jesteœ wyciszony");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			new help[128];
			format(help, sizeof(help), "Dobry admin nie powinien robiæ OOC w IC! Pisz poprzez /ro%d [treœæ]", group);
			sendErrorMessage(playerid, help);
			return 1;
		}
		new member = PlayerInfo[playerid][pGrupa][group-1];
        if(GroupHavePerm(member, PERM_RADIO))
	    {
			new string[256];
			if(GetPVarInt(playerid, "patrol") == 1)
				format(string, sizeof(string), " %s %s [%s]: %s **", GroupRanks[member][PlayerInfo[playerid][pGrupaRank][group-1]],GetNick(playerid), PatrolInfo[GetPVarInt(playerid, "patrol-id")][patname], params);
            else
				format(string, sizeof(string), " %s %s: %s **", GroupRanks[member][PlayerInfo[playerid][pGrupaRank][group-1]],GetNick(playerid), params);
			SendRadioMessage(member, GroupInfo[member][g_Color], string);
            format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid), params);
			ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
			format(string, sizeof(string), "Radio: %s", params);
			SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
			Log(chatLog, WARNING, "%s radio %d IC: %s", GetPlayerLogName(playerid), member, params);
        }
		else
		{
			sendTipMessage(playerid, "Pod tym slotem nie masz ¿adnej grupy!");
			return 1;
		}
	}
	return 1;
}

HideGroupTextDraws(playerid)
{
	DestroyGroupTextDraws(playerid);
    for(new i = 0; i<MAX_PLAYER_GROUPS; i++)
    {
        SetPVarInt(playerid, "cmdgmenu", 0);
        PlayerTextDrawHide(playerid, NazwaGrupy[playerid][i]);
        PlayerTextDrawHide(playerid, InfoGrupy[playerid][i]);
        PlayerTextDrawHide(playerid, PojazdyGrupy[playerid][i]);
        PlayerTextDrawHide(playerid, OnlineGrupy[playerid][i]);
        PlayerTextDrawHide(playerid, DutyGrupy[playerid][i]);
        PlayerTextDrawHide(playerid, SystemGrup[playerid]);
        CancelSelectTextDraw(playerid);
    }
	return 1;
}

CreateGroupTextDraws(playerid)
{
	SystemGrup[playerid] = CreatePlayerTextDraw(playerid, 298.000000, 141.000000, "System Grup");
	PlayerTextDrawBackgroundColor(playerid, SystemGrup[playerid], 100);
	PlayerTextDrawLetterSize(playerid, SystemGrup[playerid], 0.350000, 1.500000);
	PlayerTextDrawColor(playerid, SystemGrup[playerid], -1);
	PlayerTextDrawUseBox(playerid, SystemGrup[playerid], 1);
	PlayerTextDrawSetOutline(playerid, SystemGrup[playerid], 0);
	PlayerTextDrawSetShadow(playerid, SystemGrup[playerid],0);
	PlayerTextDrawAlignment(playerid, SystemGrup[playerid], 2);
	PlayerTextDrawBoxColor(playerid, SystemGrup[playerid], 100);
	PlayerTextDrawTextSize(playerid, SystemGrup[playerid], 0.000000, 261.000000);

	for(new i=0;i<MAX_PLAYER_GROUPS;i++) {
		NazwaGrupy[playerid][i] = CreatePlayerTextDraw(playerid, 145.000000, 164.000000+(i*20), "NazwaGrupy");
		PlayerTextDrawBackgroundColor(playerid, NazwaGrupy[playerid][i], 100);
		PlayerTextDrawLetterSize(playerid, NazwaGrupy[playerid][i], 0.239998, 1.199998);
		PlayerTextDrawColor(playerid, NazwaGrupy[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, NazwaGrupy[playerid][i], 1);
		PlayerTextDrawSetOutline(playerid, NazwaGrupy[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, NazwaGrupy[playerid][i],0);
		PlayerTextDrawBoxColor(playerid, NazwaGrupy[playerid][i], 100);
		PlayerTextDrawTextSize(playerid, NazwaGrupy[playerid][i], 450.000000, 26.000000);
	}

	for(new i=0;i<MAX_PLAYER_GROUPS;i++) {
		DutyGrupy[playerid][i] = CreatePlayerTextDraw(playerid, 308.000000, 164.500000+(i*20), "Duty");
		PlayerTextDrawBackgroundColor(playerid, DutyGrupy[playerid][i], 100);
		PlayerTextDrawLetterSize(playerid, DutyGrupy[playerid][i],0.259999, 1.199899);
		PlayerTextDrawColor(playerid, DutyGrupy[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, DutyGrupy[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, DutyGrupy[playerid][i], 100);
		PlayerTextDrawAlignment(playerid, DutyGrupy[playerid][i], 2);
		PlayerTextDrawSetOutline(playerid, DutyGrupy[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, DutyGrupy[playerid][i],0);
		PlayerTextDrawSetProportional(playerid, DutyGrupy[playerid][i] , true);
		PlayerTextDrawSetShadow(playerid, DutyGrupy[playerid][i], 1);
		PlayerTextDrawTextSize(playerid, DutyGrupy[playerid][i], 15, 23.000000);
		PlayerTextDrawSetSelectable(playerid, DutyGrupy[playerid][i], 1);
	}

	for(new i=0;i<MAX_PLAYER_GROUPS;i++) {
		InfoGrupy[playerid][i] = CreatePlayerTextDraw(playerid, 347.000000, 164.500000+(i*20), "Informacje");
		PlayerTextDrawBackgroundColor(playerid, InfoGrupy[playerid][i], 100);
		PlayerTextDrawLetterSize(playerid, InfoGrupy[playerid][i],0.259999, 1.199899);
		PlayerTextDrawColor(playerid, InfoGrupy[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, InfoGrupy[playerid][i], 1);
		PlayerTextDrawAlignment(playerid, InfoGrupy[playerid][i], 2);
		PlayerTextDrawBoxColor(playerid, InfoGrupy[playerid][i], 100);
		PlayerTextDrawSetOutline(playerid, InfoGrupy[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, InfoGrupy[playerid][i],0);
		PlayerTextDrawSetProportional(playerid, InfoGrupy[playerid][i] , true);
		PlayerTextDrawSetShadow(playerid, InfoGrupy[playerid][i], 1);
		PlayerTextDrawTextSize(playerid, InfoGrupy[playerid][i], 15.000000, 44.000000);
		PlayerTextDrawSetSelectable(playerid, InfoGrupy[playerid][i], 1);
	}

	for(new i=0;i<MAX_PLAYER_GROUPS;i++) {
		PojazdyGrupy[playerid][i] = CreatePlayerTextDraw(playerid, 391.000000, 164.000000+(i*20), "Pojazdy");
		PlayerTextDrawBackgroundColor(playerid, PojazdyGrupy[playerid][i], 100);
		PlayerTextDrawLetterSize(playerid, PojazdyGrupy[playerid][i], 0.259999, 1.199899);
		PlayerTextDrawColor(playerid, PojazdyGrupy[playerid][i], -1);
		PlayerTextDrawAlignment(playerid, PojazdyGrupy[playerid][i], 2);
		PlayerTextDrawUseBox(playerid, PojazdyGrupy[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, PojazdyGrupy[playerid][i], 100);
		PlayerTextDrawSetOutline(playerid, PojazdyGrupy[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, PojazdyGrupy[playerid][i],0);
		PlayerTextDrawSetProportional(playerid, PojazdyGrupy[playerid][i] , true);
		PlayerTextDrawSetShadow(playerid, PojazdyGrupy[playerid][i], 1);
		PlayerTextDrawTextSize(playerid, PojazdyGrupy[playerid][i],15.000000,34.000000);
		PlayerTextDrawSetSelectable(playerid, PojazdyGrupy[playerid][i], 1);
	}

	for(new i=0;i<MAX_PLAYER_GROUPS;i++) {
		OnlineGrupy[playerid][i] = CreatePlayerTextDraw(playerid, 426.000000, 164.000000+(i*20), "Online");
		PlayerTextDrawBackgroundColor(playerid, OnlineGrupy[playerid][i], 100);
		PlayerTextDrawLetterSize(playerid, OnlineGrupy[playerid][i], 0.259999, 1.199988);
		PlayerTextDrawColor(playerid, OnlineGrupy[playerid][i], -1);
		PlayerTextDrawUseBox(playerid, OnlineGrupy[playerid][i], 1);
		PlayerTextDrawBoxColor(playerid, OnlineGrupy[playerid][i], 100);
		PlayerTextDrawAlignment(playerid, OnlineGrupy[playerid][i], 2);
		PlayerTextDrawSetOutline(playerid, OnlineGrupy[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, OnlineGrupy[playerid][i],0);
		PlayerTextDrawSetProportional(playerid, OnlineGrupy[playerid][i] , true);
		PlayerTextDrawSetShadow(playerid, OnlineGrupy[playerid][i], 1);
		PlayerTextDrawTextSize(playerid, OnlineGrupy[playerid][i],15.000000,25.000000);
		PlayerTextDrawSetSelectable(playerid, OnlineGrupy[playerid][i], 1);
	}
}

DestroyGroupTextDraws(playerid)
{
	PlayerTextDrawDestroy(playerid, SystemGrup[playerid]);
	for(new i=0;i<MAX_PLAYER_GROUPS;i++) PlayerTextDrawDestroy(playerid, NazwaGrupy[playerid][i]);
	for(new i=0;i<MAX_PLAYER_GROUPS;i++) PlayerTextDrawDestroy(playerid, DutyGrupy[playerid][i]);
	for(new i=0;i<MAX_PLAYER_GROUPS;i++) PlayerTextDrawDestroy(playerid, InfoGrupy[playerid][i]);
	for(new i=0;i<MAX_PLAYER_GROUPS;i++) PlayerTextDrawDestroy(playerid, PojazdyGrupy[playerid][i]);
	for(new i=0;i<MAX_PLAYER_GROUPS;i++) PlayerTextDrawDestroy(playerid, OnlineGrupy[playerid][i]);
}

GroupCanPlayerJoin(playerid, groupid)
{
	if(CheckPlayerPerm(playerid, PERM_GANG) && GroupHavePerm(groupid, PERM_GANG)) //tj. gracz nie mo¿e byæ w dwóch grupach typu gang
		return 0;
	//etc
	return 1;
}

ValidateGroups(playerid)
{
	for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
	{
		if(!IsValidGroup(PlayerInfo[playerid][pGrupa][i]) && PlayerInfo[playerid][pGrupa][i] != 0)
		{
			PlayerInfo[playerid][pGrupa][i] = 0;
		}
	}
	return 1;
}

//Admin

stock Admin_PermPanel(playerid, groupid, info = 0)
{
	if(!IsValidGroup(groupid)) return 0;
	if(!IsPlayerConnected(playerid)) return 0;

	if(info) va_SendClientMessage(playerid, COLOR_LIGHTRED, "* Edytujesz uprawnienia grupy %s", GroupInfo[groupid][g_Name]);
	new string[1024];
	for(new i = 0; i < sizeof(gUprawnieniaInfo); i++)
		format(string, sizeof(string), "%s\n%s%s", string, (GroupHavePerm(groupid, i+1)) ? ("{00FF00}") : ("{FF0000}"), gUprawnieniaInfo[i]);
	ShowPlayerDialogEx(playerid, D_GROUP_ADMIN_PERM, DIALOG_STYLE_LIST, MruTitle("Zmiana uprawnieñ grupy"), string, "Zmieñ", "Zapisz");
	DynamicGui_SetDialogValue(playerid, groupid);
	return 1;
}

//end
