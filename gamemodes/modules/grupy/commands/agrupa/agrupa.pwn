//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 agrupa                                                 //
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
// Kod wygenerowany automatycznie narz�dziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN� NADPISANE PO WYWO�ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------

//-------<[ initialize ]>-------
command_agrupa()
{
    new command = Command_GetID("agrupa");

    //aliases
    Command_AddAlt(command, "ag");
    Command_AddAlt(command, "agroup");
}

//-------<[ command ]>-------
YCMD:agrupa(playerid, params[])
{
    if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY) && !IsAScripter(playerid) && !Uprawnienia(playerid, ACCESS_MAKELEADER))
        return noAccessMessage(playerid);
    new opt1[16], opt2[128];
    if(sscanf(params, "s[16]S()[128]", opt1, opt2))
    {
        sendTipMessage(playerid, "U�yj: /agrupa [stworz | usun | flagi | rangi | skiny | edytuj | dolacz | lider | zapros | wyrzuc | lista | info | kasa | mats | maxduty]");
        sendTipMessage(playerid, "U�yj: /agrupa [vlider]");
        return 1;
    }
    switch(YHash(opt1))
    {
        case _H<vlider>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY)) return noAccessMessage(playerid);
            if(isnull(opt2))
                return sendTipMessage(playerid, "U�yj: /agrupa vlider [ID grupy]");
            new groupid = strval(opt2);
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje."); 
            GroupShowLeaderPanel(playerid, groupid, 5, true);
        }
        case _H<maxduty>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY)) return noAccessMessage(playerid);
            new groupid, maxduty;
            if(sscanf(opt2, "dd", groupid, maxduty))
                return sendTipMessage(playerid, "U�yj: /agrupa maxduty [ID grupy] [warto�� maxduty, 0 wy��cza limit]");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje.");
            if(maxduty < 0)
                return sendTipMessage(playerid, "Nieprawid�owa warto��!");
            GroupInfo[groupid][g_MaxDuty] = maxduty;
            GroupSave(groupid, true);
            va_SendClientMessage(playerid, COLOR_GREEN, "* Zmieni�e� maxduty na: %d w grupie %s", maxduty, GroupInfo[groupid][g_Name]);
        }
        case _H<rangi>:
        {
            if(isnull(opt2))
                return sendTipMessage(playerid, "U�yj: /agrupa rangi [ID grupy]");
            new groupid = strval(opt2);
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje.");
            GroupShowLeaderPanel(playerid, groupid, 2);
        }
        case _H<info>:
        {
            if(isnull(opt2))
                return sendTipMessage(playerid, "U�yj: /agrupa info [ID grupy]");
            new groupid = strval(opt2);
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje.");
            GroupShowInfo(playerid, groupid, true);
        }
        case _H<kasa>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY))
                return noAccessMessage(playerid);
            new groupid, money;
            if(sscanf(opt2, "dd", groupid, money))
                return sendTipMessage(playerid, "U�yj: /agrupa kasa [ID grupy] [kasa]");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje.");
            Sejf_Add(groupid, money);
            va_SendClientMessage(playerid, COLOR_GRAD3, "�� %s grupie %s %d$ (NOWY STAN: %d$)", (money >= 0) ? ("Doda�e�") : ("Zabra�e�"), GroupInfo[groupid][g_Name], money, GroupInfo[groupid][g_Money]);
            Log(serverLog, WARNING, "%s doda� %d$ do sejfu grupy %s", GetPlayerLogName(playerid), money, GetGroupLogName(groupid));
        }
        case _H<mats>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY))
                return noAccessMessage(playerid);
            new groupid, mats;
            if(sscanf(opt2, "dd", groupid, mats))
                return sendTipMessage(playerid, "U�yj: /agrupa mats [ID grupy] [mats]");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje.");
            Mats_Add(groupid, mats);
            va_SendClientMessage(playerid, COLOR_GRAD3, "�� %s grupie %s %d mats�w (NOWY STAN: %d)", (mats >= 0) ? ("Doda�e�") : ("Zabra�e�"), GroupInfo[groupid][g_Name], mats, GroupInfo[groupid][g_Mats]);
            Log(serverLog, WARNING, "%s doda� %d mats�w do sejfu grupy %s", GetPlayerLogName(playerid), mats, GetGroupLogName(groupid));
        }
        case _H<stworz>:
        {
            new group_name[64], short_name[32], color[6+1];
            if(sscanf(opt2, "s[32]s[7]s[64]", short_name, color, group_name))
                return sendTipMessage(playerid, "U�yj: /agrupa stworz [skr�t grupy] [kolor w formacie HEX (np. FFFFFF)] [nazwa grupy]");
            mysql_real_escape_string(group_name, group_name);
            mysql_real_escape_string(short_name, short_name);
            if(strlen(color) != 6)
                return sendErrorMessage(playerid, "Kolor musi mie� 6 znak�w.");
            if(strfind(group_name, "%", true) != -1 || strfind(short_name, "%", true) != -1 || strfind(color, "%", true) != -1)
                return 1;
            if(strlen(short_name) > 16)
                return sendErrorMessage(playerid, "Max 16 znak�w w skr�cie grupy");
            if(strlen(group_name) > 48)
                return sendErrorMessage(playerid, "Max 48 znak�w w nazwie grupy");
            new converted_color = ConvertHexToRGBA(color);
            if(converted_color == 0)
                return sendErrorMessage(playerid, "Nieprawid�owy kolor.");

            new Float:x, Float:y, Float:z, Float:a;
            new vw = GetPlayerVirtualWorld(playerid), int = GetPlayerInterior(playerid);
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, a);

            new id = GroupCreate(group_name, x, y, z, a, int, vw, converted_color, short_name);
            if(id == -1 || id == -2) return sendErrorMessage(playerid, "Grupa nie mog�a zosta� stworzona (b��d MySQL)");
            if(id == -3) return sendErrorMessage(playerid, "Grupa nie mog�a zosta� stworzona (z�y spawn, koordynaty 0.0, 0.0, 0.0)");
            else
            {
                va_SendClientMessage(playerid, COLOR_GREEN, "* Stworzy�e� grup� {%06x}%s [%s] o ID: %d", converted_color >>> 8, group_name, short_name, id);
                va_SendClientMessage(playerid, COLOR_GREEN, "* Spawn grupy zosta� ustawiony w miejscu, w kt�rym aktualnie si� znajdujesz - aby to zmieni� wpisz /ag spawn");
                Admin_PermPanel(playerid, id, 1);
                Log(serverLog, WARNING, "%s stworzy� grup� %s", GetPlayerLogName(playerid), GetGroupLogName(id));
            }
            return 1;
        }
        case _H<usun>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY))
                return noAccessMessage(playerid);
            if(isnull(opt2))
                return sendTipMessage(playerid, "U�yj: /agrupa usun [id grupy z /ag lista]");
            new groupid = strval(opt2);
            if(groupid >= 1 && groupid <= 50) //Systemowe (tj. przekonwertowane z systemu organizacji/frakcji na grupy)
                return sendErrorMessage(playerid, "Nie mo�esz usun�� grupy stworzonej przez system!");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Ta grupa nie istnieje.");
            if(GroupDelete(groupid))
            {
                Log(serverLog, WARNING, "%s usun�� grup� o UID: %d", GetPlayerLogName(playerid), groupid);
                return va_SendClientMessage(playerid, COLOR_GREEN, "* Usun��e� grup� o UID: %d", groupid);
            }
            else sendErrorMessage(playerid, "Nie mo�na by�o usun�� grupy.");
            return 1;
        }
        case _H<flagi>:
        {
            if(isnull(opt2))
                return sendTipMessage(playerid, "U�yj: /agrupa flagi [id grupy z /ag lista]");
            new groupid = strval(opt2);
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje!");
            Admin_PermPanel(playerid, groupid, 1);
            return 1;
        }
        case _H<skiny>:
        {
            new groupid, type[16], id;
            if(sscanf(opt2, "ds[16]D(-1)", groupid, type, id))
                return sendTipMessage(playerid, "U�yj: /agrupa skiny [id grupy] [usun/dodaj]");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje!");
            
            if(!strcmp(type, "usun", true)) {
                if(IloscSkinow(groupid) < 1)
                    return sendErrorMessage(playerid, "Ta grupa nie ma �adnych skin�w!");
                ShowPlayerDialogEx(playerid, D_AGROUP_MANAGE_SKINS, DIALOG_STYLE_PREVIEW_MODEL, "Usuwanie skinow", DialogListaSkinow(groupid), "Usun", "Wyjdz");
                DynamicGui_SetDialogValue(playerid, groupid);
            }
            else if(!strcmp(type, "dodaj", true))
            {
                if(id == -1)
                    return sendTipMessage(playerid, "U�yj: /agrupa skiny dodaj [id skina]");
                if(id < 1)
                    return sendTipMessage(playerid, "Nieprawid�owe ID skina.");
                new frees = IloscSkinow(groupid);
                if(frees >= 19)
                    return sendErrorMessage(playerid, "W tej grupie brakuje wolnych slot�w na skiny!");
                GroupInfo[groupid][g_Skin][frees] = id;
                GroupSave(groupid);
                va_SendClientMessage(playerid, COLOR_GREEN, "* Doda�e� skina o ID: %d w grupie %s", id, GroupInfo[groupid][g_Name]);
                Log(serverLog, WARNING, "%s doda� skina %d do grupy %s", GetPlayerLogName(playerid), id, GroupInfo[groupid][g_Name]);
            }
            else sendTipMessage(playerid, "Nieznana opcja.");
            return 1;
        }
        case _H<spawn>:
        {
            if(isnull(opt2))
                return sendTipMessage(playerid, "U�yj: /agrupa spawn [id grupy]");
            new groupid = strval(opt2);
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje!");
            
            new Float:x, Float:y, Float:z, Float:a;
            new int = GetPlayerInterior(playerid), vw = GetPlayerVirtualWorld(playerid);
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, a);
            if(x == 0 && y == 0 && z == 0)
                return sendErrorMessage(playerid, "Nie mo�esz ustawi� spawnu na tych koordynatach!");
            GroupInfo[groupid][g_Spawn][0] = x;
            GroupInfo[groupid][g_Spawn][1] = y;
            GroupInfo[groupid][g_Spawn][2] = z;
            GroupInfo[groupid][g_Spawn][3] = a;
            GroupInfo[groupid][g_Int] = int;
            GroupInfo[groupid][g_VW] = vw;
            GroupSave(groupid, true);
            va_SendClientMessage(playerid, COLOR_GREEN, "* Ustawi�e� nowy spawn grupy %s", GroupInfo[groupid][g_Name]);
            Log(serverLog, WARNING, "%s ustawi� nowy spawn grupy %s", GetPlayerLogName(playerid), GetGroupLogName(groupid));
            return 1;
        }
        case _H<wyrzuc>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY))
                return noAccessMessage(playerid);
            new groupid, targetid;
            if(sscanf(opt2, "dk<fix>", groupid, targetid))
                return sendTipMessage(playerid, "U�yj: /agrupa wyrzuc [id grupy] [id gracza]");
            if(!IsValidGroup(groupid) || groupid < 1 || groupid > MAX_GROUPS)
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje.");
            if(!IsPlayerConnected(targetid) || IsPlayerNPC(targetid))
                return sendErrorMessage(playerid, "Gracz o podanym ID nie istnieje.");
            if(!IsPlayerInGroup(targetid, groupid))
                return sendErrorMessage(playerid, "Ten gracz nie jest w grupie o podanym ID.");
            if(GroupIsLeader(targetid, groupid))
                return sendErrorMessage(playerid, "Aby wyrzuci� lidera, najpierw zabierz mu uprawnienia poprzez /ag lider");
            
            GroupRemovePlayer(targetid, groupid, 1, playerid);
            return 1;
        }
        case _H<edytuj>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY))
                return noAccessMessage(playerid);
            new groupid, type[32], parameters[64];
            if(sscanf(opt2, "ds[32]S()[64]", groupid, type, parameters))
                return sendTipMessage(playerid, "U�yj: /agrupa edytuj [id grupy] [kolor/nazwa/skrot]");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje.");
            if(!strcmp(type, "kolor", true))
            {
                if(isnull(parameters))
                    return sendTipMessage(playerid, "U�yj: /agrupa edytuj [id grupy] kolor [HEX]");
                if(strlen(parameters) != 6)
                    return sendTipMessage(playerid, "HEX musi mie� 6 znak�w.");
                new color = ConvertHexToRGBA(parameters);
                if(color == 0)
                    return sendTipMessage(playerid, "Kolor jest nieprawid�owy.");
                GroupInfo[groupid][g_Color] = color;
                GroupSave(groupid, true);
                va_SendClientMessage(playerid, COLOR_GREEN, "* Zmieni�e� kolor grupy {%06x}%s", color >>> 8, GroupInfo[groupid][g_Name]);
                Log(serverLog, WARNING, "%s zmieni� kolor grupy %s", GetPlayerLogName(playerid), GetGroupLogName(groupid));
                return 1;
            }
            if(!strcmp(type, "nazwa", true))
            {
                if(isnull(parameters))
                    return sendTipMessage(playerid, "U�yj: /agrupa edytuj [id grupy] nazwa [nazwa grupy]");
                if(strlen(parameters) > 48)
                    return sendTipMessage(playerid, "Nazwa nie mo�e mie� wi�cej ni� 48 znak�w.");
                if(strfind(parameters, "%", true) != -1)
                    return 1;
                mysql_real_escape_string(parameters, parameters);
                format(GroupInfo[groupid][g_Name], 64, parameters);
                GroupSave(groupid, true);
                va_SendClientMessage(playerid, COLOR_GREEN, "* Zmieni�e� nazw� grupy na %s", GroupInfo[groupid][g_Name]);
                Log(serverLog, WARNING, "%s zmieni� nazw� grupy %s", GetPlayerLogName(playerid), GetGroupLogName(groupid));
                return 1;
            }
            if(!strcmp(type, "skrot", true))
            {
                if(isnull(parameters))
                    return sendTipMessage(playerid, "U�yj: /agrupa edytuj [id grupy] skrot [skr�t grupy]");
                if(strlen(parameters) > 16)
                    return sendTipMessage(playerid, "Skr�t nie mo�e mie� wi�cej ni� 16 znak�w.");
                if(strfind(parameters, "%", true) != -1)
                    return 1;
                mysql_real_escape_string(parameters, parameters);
                format(GroupInfo[groupid][g_ShortName], 32, parameters);
                GroupSave(groupid, true);
                va_SendClientMessage(playerid, COLOR_GREEN, "* Zmieni�e� skr�t grupy na %s", GroupInfo[groupid][g_ShortName]);
                Log(serverLog, WARNING, "%s zmieni� skr�t grupy %s", GetPlayerLogName(playerid), GetGroupLogName(groupid));
                return 1;
            }
            else sendTipMessage(playerid, "Nieprawid�owa opcja.");
            return 1;
        }
        case _H<dolacz>:
        {
            new groupid, rank;
            if(sscanf(opt2, "dd", groupid, rank))
                return sendTipMessage(playerid, "U�yj: /agrupa dolacz [id grupy] [ranga]");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje");
            if(rank < 0 || rank > 10)
                return sendErrorMessage(playerid, "Z�e ID rangi (0-10)!");
            new result = GroupAddPlayer(playerid, groupid, rank);
            if(result == 0) return sendErrorMessage(playerid, "Wyst�pi� b��d.");
            if(result == -1) return sendErrorMessage(playerid, "Jeste� ju� w tej grupie!");
            if(result == -2) return sendErrorMessage(playerid, "Nie mo�esz do��czy� do tej grupy!");
            if(result == -3) return sendErrorMessage(playerid, "Nie posiadasz wolnego slota na grup�!");
            else
            {
                Log(serverLog, WARNING, "%s doda� siebie do grupy %s", GetPlayerLogName(playerid), GetGroupLogName(groupid));
                return 1;
            }
        }
        case _H<lider>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKELEADER)) return noAccessMessage(playerid);
            new groupid, targetid;
            if(sscanf(opt2, "dd", groupid, targetid))
                return sendTipMessage(playerid, "U�yj: /agrupa lider [id grupy] [id gracza, -1 usuwa lidera]");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje");
            if(targetid == -1 || targetid == INVALID_PLAYER_ID)
            {
                GroupInfo[groupid][g_Leader] = 0;
                GroupSave(groupid, true);
                va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Usun��e� g��wnego lidera z grupy %s", GroupInfo[groupid][g_Name]);
                Log(serverLog, WARNING, "%s usun�� lidera z %s", GetPlayerLogName(playerid), GetGroupLogName(groupid));
                return 1;
            }
            if(!IsPlayerConnected(targetid) || IsPlayerNPC(targetid))
                return sendErrorMessage(playerid, "Gracz o podanym ID nie istnieje");
            if(PlayerInfo[targetid][pUID] == 0)
                return sendErrorMessage(playerid, "Gracz o podanym ID nie istnieje");
            if(!IsPlayerInGroup(targetid, groupid))
                return sendErrorMessage(playerid, "Najpierw musisz zaprosi� tego gracza do grupy (/ag zapros)");
            if(GroupIsLeader(targetid, groupid))
                return sendErrorMessage(playerid, "Ten gracz jest ju� liderem tej grupy!");
            
            new oldleader = GetPlayerIDFromUID(GroupInfo[groupid][g_Leader]);
            if(oldleader != INVALID_PLAYER_ID)
                va_SendClientMessage(oldleader, COLOR_LIGHTBLUE, "Zosta�e� wyrzucony przez %s z rangi g��wnego lidera w grupie %s", GetNick(playerid), GroupInfo[groupid][g_ShortName]);
            GroupInfo[groupid][g_Leader] = PlayerInfo[targetid][pUID];
            GroupSave(groupid, true);
            va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Da�e� g��wnego lidera graczowi %s w grupie %s", GetNick(targetid), GroupInfo[groupid][g_Name]);
            va_SendClientMessage(targetid, COLOR_LIGHTBLUE, "%s da� Ci g��wnego lidera w grupie %s", GetNick(playerid), GroupInfo[groupid][g_Name]);
            Log(serverLog, WARNING, "%s da� g��wnego lidera dla %s w %s", GetPlayerLogName(playerid), GetPlayerLogName(targetid), GetGroupLogName(groupid));
            return 1;
        }
        case _H<zapros>:
        {
            if(!Uprawnienia(playerid, ACCESS_MAKEFAMILY))
                return noAccessMessage(playerid);
            new groupid, targetid, rank;
            if(sscanf(opt2, "dk<fix>d", groupid, targetid, rank))
                return sendTipMessage(playerid, "U�yj: /agrupa zapros [id grupy] [id gracza] [ranga]");
            if(!IsValidGroup(groupid))
                return sendErrorMessage(playerid, "Grupa o podanym ID nie istnieje");
            if(!IsPlayerConnected(targetid) || IsPlayerNPC(targetid))
                return sendErrorMessage(playerid, "Gracz o podanym ID nie istnieje");
            if(PlayerInfo[targetid][pUID] == 0)
                return sendErrorMessage(playerid, "Gracz o podanym ID nie istnieje");
            if(IsPlayerInGroup(targetid, groupid))
                return sendErrorMessage(playerid, "Ten gracz jest ju� w tej grupie.");
            if(rank < 0 || rank > 10)
                return sendErrorMessage(playerid, "Z�e ID rangi (0-10)!");
            if(!strcmp(GroupRanks[groupid][rank], "-", true))
                return sendErrorMessage(playerid, "Ranga o podanym ID nie jest stworzona.");
            new slot = -1;
            for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
            {
                if(PlayerInfo[targetid][pGrupa][i] < 1)
                {
                    slot = i;
                    break;
                }

            }
            if(slot == -1)
                return sendErrorMessage(playerid, "Gracz o podanym ID przekroczy� limit grup.");
            if(!GroupCanPlayerJoin(targetid, groupid))
                return sendErrorMessage(playerid, "Gracz o tym ID nie mo�e do��czy� do tej grupy.");
            SetPVarInt(targetid, "groupinvite-id", groupid);
            SetPVarInt(targetid, "groupinvite-inviter", playerid);
            SetPVarInt(targetid, "groupinvite-rank", rank);
            ShowPlayerDialogEx(targetid, D_GROUP_INVITE, DIALOG_STYLE_MSGBOX, MruTitle("Zaproszenie do grupy"), sprintf("%s zaprasza Ci� do do��czenia do grupy %s (ranga: %s)", GetNick(playerid), GroupInfo[groupid][g_Name], GroupRanks[groupid][rank]), "Akceptuj", "Odrzu�");
            va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wys�a�e� zaproszenie do grupy %s graczowi %s", GroupInfo[groupid][g_Name], GetNick(targetid));
            return 1;
        }
        case _H<lista>:
        {
            SendClientMessage(playerid, COLOR_GREEN, "|_____    Lista grup  _____|");
            for(new i = 1; i < MAX_GROUPS; i++)
            {
                if(!IsValidGroup(i)) continue;
                new nick[26];
                strmid(nick, MruMySQL_GetNameFromUID(GroupInfo[i][g_Leader]), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
                va_SendClientMessage(playerid, COLOR_GREEN, "(%d) {%06x}%s {33AA33}[%s] Lider: %s, Liczba pracownik�w: %d", i, GroupInfo[i][g_Color] >>> 8, GroupInfo[i][g_Name], GroupInfo[i][g_ShortName], (strlen(nick)) ? (nick) : ("BRAK"), GroupEmployeeCount(i));
            }
            SendClientMessage(playerid, COLOR_GREEN, "|_____  Koniec  _____|");
            return 1;
        }
        default: sendTipMessage(playerid, "Nieprawid�owa opcja.");
    }
    return 1;
}