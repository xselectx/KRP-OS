//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 agraffiti                                                 //
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------

//-------<[ initialize ]>-------
command_g()
{
    new command = Command_GetID("g");

    //aliases
    Command_AddAlt(command, "g");
    Command_AddAlt(command, "groups");
    Command_AddAlt(command, "grupy");
    Command_AddAlt(command, "grupa");
}

//-------<[ command ]>-------
YCMD:g(playerid, params[])
{
    //fetching params
    new opcja[16], grupa, parametry[256], leader;
    #pragma unused leader
    if(!sscanf(params, "is[16]S()[256]", grupa, opcja, parametry))
    {
        if(grupa <= 0 || grupa > MAX_PLAYER_GROUPS) return sendTipMessage(playerid, "Masz dostêp tylko do trzech slotów grupowych.");
        grupa--;
        if(strcmp(opcja, "online", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new string[2048];
            foreach(new i : Player)
            {
                if(IsPlayerInGroup(i, PlayerInfo[playerid][pGrupa][grupa]))
                {
                    new slot = 0;
                    for(new s = 0; s < 3; s++)
                        if(PlayerInfo[i][pGrupa][s] == PlayerInfo[playerid][pGrupa][grupa]) slot = s;
                    format(string, sizeof(string), "%s{%06x}%s{B4B5B7} [%d] %s ranga %s [%d]\n", string, (GetPlayerColor(i) >>> 8), GetNick(i), i, (GroupIsLeader(i, PlayerInfo[i][pGrupa][slot]) || GroupIsVLeader(i, PlayerInfo[i][pGrupa][slot])) ? ("[LIDER]") : (""), GroupRanks[PlayerInfo[i][pGrupa][slot]][PlayerInfo[i][pGrupaRank][slot]], PlayerInfo[i][pGrupaRank][slot]);
                }
            }
            return ShowPlayerDialogEx(playerid, DIALOG_EMPTY_SC, DIALOG_STYLE_LIST, sprintf(">> %s Online", GroupInfo[PlayerInfo[playerid][pGrupa][grupa]][g_ShortName]), string, "OK", "");
        }
        else if(strcmp(opcja, "ustawspawn") == 0 || strcmp(opcja, "spawn") == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(GroupInfo[grupaid][g_Spawn][0] == 0.0)
                return sendTipMessage(playerid, "Ta grupa nie ma jeszcze ustawionego spawnu.");
            PlayerInfo[playerid][pGrupaSpawn] = grupa;
            va_SendClientMessage(playerid, COLOR_GRAD3, "»» Od teraz bêdziesz siê spawnowaæ na spawnie grupy %s.", GroupInfo[grupaid][g_Name]);
            return 1;
        }
        else if(strcmp(opcja, "info", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            GroupShowInfo(playerid, PlayerInfo[playerid][pGrupa][grupa]);
            return 1;
        }
        else if(strcmp(opcja, "skin", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(!IsPlayerInRangeOfPoint(playerid, 10, GroupInfo[grupaid][g_Spawn][0], GroupInfo[grupaid][g_Spawn][1], GroupInfo[grupaid][g_Spawn][2]) &&
            !IsNearGroupVehicle(playerid, PlayerInfo[playerid][pGrupa][grupa]))
            {
                return sendErrorMessage(playerid, "Aby zmieniæ skin musisz byæ na spawnie grupy.");
            }
            if(IloscSkinow(grupaid) < 1)
            {
                return SendClientMessage(playerid, COLOR_GRAD2, "Twoja grupa nie ma w³asnych skinów.");
            }
            ShowPlayerDialogEx(playerid, DIALOGID_UNIFORM_FRAKCJA, DIALOG_STYLE_PREVIEW_MODEL, "Zmien skin grupowy", DialogListaSkinow(grupaid), "Zmien skin", "Anuluj");
            SetPVarInt(playerid, "skin-group", grupaid);
            return 1;
        }
        else if(strcmp(opcja, "v", true) == 0 || strcmp(opcja, "pojazdy", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            new string[1024];
            string = "ID\tNazwa";
            for(new i = 0; i < MAX_VEHICLES; i++)
            {
                if(VehicleUID[i][vUID] == 0) continue;
                new lcarid = VehicleUID[i][vUID];
                if(CarData[lcarid][c_OwnerType] == CAR_OWNER_GROUP && CarData[lcarid][c_Owner] == grupaid)
                {
                    format(string, sizeof(string), "%s\n%d\t%s", string, i, VehicleNames[GetVehicleModel(i)-400]);
                }
            }
            if(strlen(string) < 11)
                return sendErrorMessage(playerid, "Twoja grupa nie ma ¿adnych pojazdów.");
            ShowPlayerDialogEx(playerid, D_GROUP_VEHICLE, DIALOG_STYLE_TABLIST_HEADERS, MruTitle("Pojazdy grupy"), string, "Namierz", "Zamknij");
            return 1;
        }
        else if(strcmp(opcja, "duty", true) == 0 || strcmp(opcja, "sluzba", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");

            if(GroupHavePerm(PlayerInfo[playerid][pGrupa][grupa], PERM_POLICE) && PoziomPoszukiwania[playerid] > 0)
                return sendTipMessage(playerid, "Osoby poszukiwane przez policjê nie mog¹ rozpocz¹æ s³u¿by !");

            if(GetPlayerAdminDutyStatus(playerid) == 1)
			    sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ  podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");

            if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) 
                return sendTipMessage(playerid, "Aby wzi¹æ s³u¿be musisz byæ pieszo!");

            if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
                return sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile. Nie mo¿esz znajdowaæ siê w pojeŸdzie.");

            if(gettime() - GetPVarInt(playerid, "lastDamage") < 60)
				return sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ podczas walki!");
            new groupid = PlayerInfo[playerid][pGrupa][grupa];
            OnDutyCD[playerid] = 0;
            if(OnDuty[playerid] == 0)
            {
                if(GetFractionMembersNumber(groupid, true) >= GroupInfo[groupid][g_MaxDuty] && GroupInfo[groupid][g_MaxDuty] > 0)
                {
                    return va_SendClientMessage(playerid, COLOR_LIGHTRED, "> Nie mo¿esz wejœæ na duty z powodu ustawionego limitu pracowników na: %d", GroupInfo[groupid][g_MaxDuty]);
                }
                new string[128];
                format(string, sizeof(string), "~n~~n~~n~~n~~w~Wchodzisz na sluzbe~n~~b~%s",GroupInfo[PlayerInfo[playerid][pGrupa][grupa]][g_ShortName]);
                GameTextForPlayer(playerid, string, 4000, 3);
                new grupaid = PlayerInfo[playerid][pGrupa][grupa];
                if(IsPlayerInRangeOfPoint(playerid, 5, GroupInfo[grupaid][g_Spawn][0], GroupInfo[grupaid][g_Spawn][1], GroupInfo[grupaid][g_Spawn][2]) ||
                IsNearGroupVehicle(playerid, PlayerInfo[playerid][pGrupa][grupa]))
                {
                    DajBronieFrakcyjne(playerid, grupaid);
                    if(GroupHavePerm(PlayerInfo[playerid][pGrupa][grupa], PERM_POLICE))
                    {
                        SetPlayerArmour(playerid, 100);
                        SetPlayerHealth(playerid, 100);
                        format(string, sizeof(string), "* %s bierze odznakê i broñ.", GetNickEx(playerid, true));
                        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    }
                    if(PlayerInfo[playerid][pGrupaSkin][grupa] > 0)
                    {
                        new bool:skinexists = false;
                        for(new i = 0; i < 20; i++) //Sprawdzanie, czy skin jest przypisany do grupy
                        {
                            if(GroupInfo[grupaid][g_Skin][i] == PlayerInfo[playerid][pGrupaSkin][grupa]) 
                            {
                                skinexists = true;
                                break;
                            }
                        }
                        if(!skinexists)
                        {
                            RunCommand(playerid, "/g", sprintf("%d skin", grupa+1));
                        }
                        else
                            PlayerInfo[playerid][pUniform] = PlayerInfo[playerid][pGrupaSkin][grupa];
                    }
                }
                OnDuty[playerid] = grupa+1;
                SetPlayerToTeamColor(playerid);
                SetPlayerSpawnSkin(playerid);
                UpdatePlayer3DName(playerid);
                if(!IsAPrzestepca(playerid)) SetPlayerChatBubble(playerid, sprintf("[%s]", GroupInfo[grupaid][g_ShortName]), GroupInfo[grupaid][g_Color], 10.0, 9000);
                if(GroupHavePerm(PlayerInfo[playerid][pGrupa][grupa], PERM_NEWS)) SanDuty[playerid] = 1;
            }
            else if(OnDuty[playerid] == grupa+1)
            {
                new string[128];
                format(string, sizeof(string), "~n~~n~~n~~n~~w~Schodzisz ze sluzby~n~~b~%s",GroupInfo[PlayerInfo[playerid][pGrupa][grupa]][g_ShortName]);
                GameTextForPlayer(playerid, string, 4000, 3);
                new grupaid = PlayerInfo[playerid][pGrupa][grupa];
                if(IsPlayerInRangeOfPoint(playerid, 5, GroupInfo[grupaid][g_Spawn][0], GroupInfo[grupaid][g_Spawn][1], GroupInfo[grupaid][g_Spawn][2]) ||
                IsNearGroupVehicle(playerid, PlayerInfo[playerid][pGrupa][grupa]))
                {
                    if(GroupHavePerm(PlayerInfo[playerid][pGrupa][grupa], PERM_POLICE))
                    {
                        format(string, sizeof(string), "* %s odk³ada odznakê i broñ.", GetNickEx(playerid, true));
                        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                        SetPlayerArmour(playerid, 0.0);
                    }
                }
                PrintDutyTime(playerid);
                PrzywrocBron(playerid);
                OnDuty[playerid] = 0;
                SetPlayerToTeamColor(playerid);
                UpdatePlayer3DName(playerid);
                PlayerInfo[playerid][pUniform] = 0;
                SetPlayerSpawnSkin(playerid);
                SetPlayerChatBubble(playerid, " ", -1, 10.0, 9000);
                if(GroupHavePerm(PlayerInfo[playerid][pGrupa][grupa], PERM_NEWS)) SanDuty[playerid] = 0;
            }
            else if(OnDuty[playerid] != grupa+1)
            {
                return sendErrorMessage(playerid, sprintf("Jesteœ ju¿ na s³u¿bie innej grupy %s [%d]", GroupInfo[PlayerInfo[playerid][pGrupa][OnDuty[playerid]-1]][g_ShortName], OnDuty[playerid]));
            }
            return 1;
        }
        else if(strcmp(opcja, "opusc", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            if(OnDuty[playerid] == grupa+1)
                return sendErrorMessage(playerid, "Nie mo¿esz byæ na s³u¿bie tej grupy.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(GroupIsLeader(playerid, grupaid))
                return sendErrorMessage(playerid, "Nie mo¿esz opuœciæ tej grupy, jesteœ jej g³ównym liderem - w celu zrezygnowania skontaktuj siê z administracj¹.");
            ShowPlayerDialogEx(playerid, D_GROUP_LEAVE_CONFIRM, DIALOG_STYLE_MSGBOX, "Opuszczanie grupy", sprintf("Czy na pewno chcesz opuœciæ grupê %s?", GroupInfo[grupaid][g_Name]), "Tak", "Nie");
            DynamicGui_SetDialogValue(playerid, grupa);
            return 1;
        }
        else if(strcmp(opcja, "zapros", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(!GroupIsLeader(playerid, grupaid) && !GroupIsVLeader(playerid, grupaid))
                return noAccessMessage(playerid);

            new targetid, rank;
            if(sscanf(parametry, "k<fix>d", targetid, rank))
                return sendTipMessage(playerid, sprintf("U¿yj: /g %d zapros [id gracza] [ranga]", grupa+1, rank));
            if(!IsPlayerConnected(targetid) || IsPlayerNPC(targetid))
                return sendErrorMessage(playerid, "Gracz o podanym ID nie jest na serwerze!");
            if(IsPlayerInGroup(targetid, grupaid))
                return sendErrorMessage(playerid, "Gracz o podanym ID jest ju¿ w Twojej grupie!");
            if(rank < 0 || rank > 10)
                return sendErrorMessage(playerid, "Z³e ID rangi.");
            if(!strcmp(GroupRanks[grupaid][rank], "-", true))
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
                return sendErrorMessage(playerid, "Gracz o podanym ID przekroczy³ limit grup.");
            if(!GroupCanPlayerJoin(targetid, grupaid))
                return sendErrorMessage(playerid, "Gracz o tym ID nie mo¿e do³¹czyæ do tej grupy.");
            SetPVarInt(targetid, "groupinvite-id", grupaid);
            SetPVarInt(targetid, "groupinvite-inviter", playerid);
            SetPVarInt(targetid, "groupinvite-rank", rank);
            ShowPlayerDialogEx(targetid, D_GROUP_INVITE, DIALOG_STYLE_MSGBOX, MruTitle("Zaproszenie do grupy"), sprintf("%s zaprasza Ciê do do³¹czenia do grupy %s (ranga: %s)", GetNick(playerid), GroupInfo[grupaid][g_Name], GroupRanks[grupaid][rank]), "Akceptuj", "Odrzuæ");
            va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wys³a³eœ zaproszenie do grupy %s graczowi %s", GroupInfo[grupaid][g_Name], GetNick(targetid));
            return 1;
        }
        else if(strcmp(opcja, "wypros", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(!GroupIsLeader(playerid, grupaid) && !GroupIsVLeader(playerid, grupaid))
                return noAccessMessage(playerid);

            new targetid;
            if(sscanf(parametry, "k<fix>", targetid))
                return sendTipMessage(playerid, sprintf("U¿yj: /g %d wypros [id gracza]", grupa+1));
            if(!IsPlayerConnected(targetid) || IsPlayerNPC(targetid))
                return sendErrorMessage(playerid, "Gracz o podanym ID nie jest na serwerze!");
            if(playerid == targetid)
                return sendErrorMessage(playerid, "Nie mo¿esz wyrzuciæ siebie!");
            if(!IsPlayerInGroup(targetid, grupaid))
                return sendErrorMessage(playerid, "Gracz o podanym ID nie jest w Twojej grupie!");
            if(GroupIsLeader(targetid, grupaid))
                return sendErrorMessage(playerid, "Gracz o podanym ID jest liderem, nie mo¿esz go wyrzuciæ.");
            if(GroupIsVLeader(targetid, grupaid))
                return sendErrorMessage(playerid, "Nie mo¿esz wyrzuciæ v-leadera, zrób to poprzez /g [slot] panel.");
            new slot = -1;
            for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
            {
                if(PlayerInfo[targetid][pGrupa][i] == grupaid)
                {
                    slot = i;
                    break;
                }

            }
            if(slot == -1)
                return sendErrorMessage(playerid, "Gracz o podanym ID nie jest w Twojej grupie!");
            
            GroupRemovePlayer(targetid, grupaid, 1, playerid);
            return 1;
        }
        else if(strcmp(opcja, "ranga", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(!GroupIsLeader(playerid, grupaid) && !GroupIsVLeader(playerid, grupaid))
                return noAccessMessage(playerid);

            new targetid, rank;
            if(sscanf(parametry, "k<fix>d", targetid, rank))
                return sendTipMessage(playerid, sprintf("U¿yj: /g %d ranga [id gracza] [ranga]", grupa+1));
            if(rank < 0 || rank > 10)
                return sendErrorMessage(playerid, "Z³y numer rangi!");
            if(!strcmp(GroupRanks[grupaid][rank], "-") || !strlen(GroupRanks[grupaid][rank]))
                return sendErrorMessage(playerid, "Ranga o danym numerze nie jest stworzona! Stwórz j¹ poprzez /g [slot] panel");
            if(!IsPlayerConnected(targetid) || IsPlayerNPC(targetid))
                return sendErrorMessage(playerid, "Gracz o podanym ID nie jest na serwerze!");
            if(!IsPlayerInGroup(targetid, grupaid))
                return sendErrorMessage(playerid, "Gracz o podanym ID nie jest w Twojej grupie!");
            new slot = -1;
            for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
            {
                if(PlayerInfo[targetid][pGrupa][i] == grupaid)
                {
                    slot = i;
                    break;
                }

            }
            if(slot == -1)
                return sendErrorMessage(playerid, "Gracz o podanym ID nie jest w Twojej grupie!");
            PlayerInfo[targetid][pGrupaRank][slot] = rank;
            va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "(Nada³eœ %s rangê %s (%d))", GetNick(targetid), GroupRanks[grupaid][rank], rank);
            va_SendClientMessage(targetid, COLOR_LIGHTBLUE, "(Lider %s nada³ Ci rangê %s (%d))", GetNick(playerid), GroupRanks[grupaid][rank], rank);
            Log(serverLog, WARNING, "%s nada³ rangê %d dla %s grupa: %s", GetPlayerLogName(playerid), rank, GetPlayerLogName(targetid), GetGroupLogName(grupaid));
            return 1;
        }
        else if(strcmp(opcja, "panel", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(!GroupIsLeader(playerid, grupaid) && !GroupIsVLeader(playerid, grupaid))
                return noAccessMessage(playerid);

            GroupShowLeaderPanel(playerid, grupaid, 1);
            return 1;
        }
        else if(strcmp(opcja, "komunikat", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(!GroupHavePerm(grupaid, PERM_FINFO))
                return noAccessMessage(playerid);
            if(GroupRank(playerid, grupaid) < 4)
                return sendErrorMessage(playerid, "Komunikaty s¹ dostêpne od 4 rangi.");
            if(isnull(parametry))
                return sendTipMessage(playerid, sprintf("U¿yj: /g %d komunikat [treœæ]", grupa+1));

            GroupSendAnnouncement(playerid, PlayerInfo[playerid][pGrupa][grupa], parametry);
            return 1;
        }
        else if(strcmp(opcja, "setspawn", true) == 0)
        {
            if(PlayerInfo[playerid][pGrupa][grupa] == 0)
                return sendTipMessage(playerid, "Pod tym slotem nie znajduje siê ¿adna grupa.");
            new grupaid = PlayerInfo[playerid][pGrupa][grupa];
            if(!GroupIsLeader(playerid, grupaid))
                return noAccessMessage(playerid);
            if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
                return sendErrorMessage(playerid, "Musisz byæ pieszo.");
            
            new Float:x, Float:y, Float:z, Float:a, Float:vw, Float:int;
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, a);
            vw = GetPlayerVirtualWorld(playerid);
            int = GetPlayerInterior(playerid);
            GroupInfo[grupaid][g_Spawn][0] = x;
            GroupInfo[grupaid][g_Spawn][1] = y;
            GroupInfo[grupaid][g_Spawn][2] = z;
            GroupInfo[grupaid][g_Spawn][3] = a;
            GroupInfo[grupaid][g_Int] = int;
            GroupInfo[grupaid][g_VW] = vw;

            GroupSave(grupaid, true);
            va_SendClientMessage(playerid, COLOR_LIGHTGREEN, "(Ustawi³eœ nowy spawn grupy %s)", GroupInfo[grupaid][g_ShortName]);
            Log(serverLog, WARNING, "%s ustawi³ nowy spawn grupy %s", GetPlayerLogName(playerid), GetGroupLogName(grupaid));
            return 1;
        }
    }
    new nazwy[MAX_PLAYER_GROUPS][32] = {"Wolny slot", ...};
    if(GetPVarInt(playerid, "cmdgmenu") == 0)
    {
        CreateGroupTextDraws(playerid);
        for(new i = 0; i<MAX_PLAYER_GROUPS; i++)
        {
            if(PlayerInfo[playerid][pGrupa][i] != 0)
            {
                SetPVarInt(playerid, "cmdgmenu", 1);
                SelectTextDraw(playerid, 0xE5413CFF);
                format(nazwy[i], 32, GroupInfo[PlayerInfo[playerid][pGrupa][i]][g_ShortName], PlayerInfo[playerid][pGrupa][i]);
                PlayerTextDrawSetString(playerid, NazwaGrupy[playerid][i], nazwy[i]);
                PlayerTextDrawShow(playerid, NazwaGrupy[playerid][i]);
                PlayerTextDrawShow(playerid, InfoGrupy[playerid][i]);
                PlayerTextDrawShow(playerid, PojazdyGrupy[playerid][i]);
                PlayerTextDrawShow(playerid, OnlineGrupy[playerid][i]);
                PlayerTextDrawShow(playerid, DutyGrupy[playerid][i]);
                PlayerTextDrawShow(playerid, SystemGrup[playerid]);
            }
        }
        sendTipMessage(playerid, "U¿yj: /g [slot] [info | online | zapros | wypros | ranga | online | v | skin | duty | opusc | panel | komunikat | spawn | setspawn]");
    }
    else
    {
        HideGroupTextDraws(playerid);
    }
    return 1;
}