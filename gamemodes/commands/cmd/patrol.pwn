//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ patrol ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:patrol(playerid, params[], help)
{
    new var[32], sign[32];
	if(!IsPlayerConnected(playerid)) return 1;
    if(GetPlayerGroupSlot(playerid, FRAC_LSPD) == 0) return 1;
    if(sscanf(params, "s[32]S()[32]", var, sign)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Dost�pne parametry: start, stop, mapa, akceptuj, lista, vsign");
    if(strcmp(var, "start", true) == 0)
    {
        if(GetPVarInt(playerid, "patrol") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Aktualnie jestes na patrolu.");
        if(!IsPlayerInAnyVehicle(playerid)) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, " Musisz by� w wozie.");

        new pat = GetPatrolID();
        if(pat == -1) return sendTipMessageEx(playerid, -1, "Brak wolnych slot�w na patrol.");
        SetPVarInt(playerid, "patrol-id", pat);

        ShowPlayerDialogEx(playerid, DIALOG_PATROL_NAME, DIALOG_STYLE_INPUT, "Konfiguracja patrolu � Nazwa", "Wprowad� nazw� patrolu (kryptonim)", "Dalej", "Anuluj");

        SetPVarInt(playerid, "patrol", 1);
    }
    else if(strcmp(var, "stop", true) == 0)
    {
        if(GetPVarInt(playerid, "patrol") == 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nie jestes w trakcie patrolu.");

        new pat = GetPVarInt(playerid, "patrol-id");

        if(PatrolInfo[pat][patroluje][1] == playerid)
        {
            new id = GetPVarInt(playerid, "patrol-parent");
            PatrolInfo[pat][patroluje][1] = INVALID_PLAYER_ID;
            SetPVarInt(playerid, "patrol", 0);
            SetPVarInt(playerid, "patrol-dec", 0);
            Patrol_HideZones(playerid);

            SetPVarInt(playerid, "patrol-duo", INVALID_PLAYER_ID);
            SetPVarInt(id, "patrol-duo", INVALID_PLAYER_ID);
            sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Opu�ci�es patrol.");
            sendTipMessageEx(id, COLOR_PAPAYAWHIP, "Wsp�lnik opusci� patrol.");
        }
        else if(PatrolInfo[pat][patroluje][0] != playerid) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nie jestes za�o�ycielem tego patrolu.");
        else
        {
            if(PatrolInfo[pat][patstrefa] != 0)
            {
                TextDrawDestroy(PatrolMarker[pat]);
                PatrolMarker[pat] = Text:INVALID_TEXT_DRAW;
                Patrolujacych[PatrolInfo[pat][patstrefa]-1]--;
            }
            new id = GetPVarInt(playerid, "patrol-parent");
            PatrolInfo[pat][patroluje][0] = INVALID_PLAYER_ID;
            PatrolInfo[pat][patroluje][1] = INVALID_PLAYER_ID;
            PatrolInfo[pat][patstrefa] = 0;
            PatrolInfo[pat][patstan] = 0;
            PatrolInfo[pat][pattyp] = 0;

            if(PatrolInfo[pat][pataktywny] != 0)
            {
                new str[64];
                format(str, 64, "{FFFFFF}��{6A5ACD} CENTRALA: {FFFFFF}%s:{6A5ACD} 10-33", PatrolInfo[pat][patname]);
                SendTeamMessage(1, COLOR_ALLDEPT, str);
                new pos = strfind(PatrolSq, PatrolInfo[pat][patname], true);
                strdel(PatrolSq, pos, pos + strlen(PatrolInfo[pat][patname]));
                strdel(PatrolInfo[pat][patname], 0, 16);


            }
            SetPVarInt(playerid, "patrol", 0);
            SetPVarInt(playerid, "patrol-dec", 0);

            PatrolInfo[pat][pataktywny] = 0;

            if(GetPVarInt(playerid, "patrol-duo")) SetPVarInt(id, "patrol", 0);
            if(GetPVarInt(playerid, "patrol-duo")) SetPVarInt(id, "patrol-dec", 0);

            Patrol_HideZones(playerid);
            if(GetPVarInt(playerid, "patrol-duo")) Patrol_HideZones(id);

            SetPVarInt(playerid, "patrol-duo", INVALID_PLAYER_ID);

            SetPVarInt(playerid, "patrol-parent", -1);
            SetPVarInt(id, "patrol-parent", -1);
            if(!GetPVarInt(playerid, "patrol-Wyszedl")) {
                sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Zako�czono patrol.");
            } else {
                sendTipMessageEx(id, COLOR_PAPAYAWHIP, "Wsp�lnik opu�ci� patrol. 10-33!");
            }
        }
    }
    else if(strcmp(var, "vsign", true) == 0)
    {
        if(strlen(sign) <= 0) return sendTipMessage(playerid, "U�yj: /patrol vsign [kryptonim / usun]");

        if(IsPlayerInAnyVehicle(playerid))
        {
            new carid = GetPlayerVehicleID(playerid);
            if(!IsACopCar(carid))
                return sendErrorMessage(playerid, "Musisz by� w poje�dzie policyjnym.");

            if(vSigny[carid] == 1) 
            {
                DestroyDynamic3DTextLabel(vSignyText[carid]);
                vSigny[carid] = 0;
                return 1;
            }
            ReColor(sign);
            vSignyText[carid] = CreateDynamic3DTextLabel(sign, 0xFFFFFFFF, 0, 0, 0, 10, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
            AttachDyn3DTextLabelToVehicle(vSignyText[carid], carid, -0.7, -2.3, -0.3);
            vSigny[carid] = 1;
            //
        } else return sendTipMessage(playerid, "Musisz by� w poje�dzie.");
    }
    else if(strcmp(var, "akceptuj", true) == 0)
    {
        if(GetPVarInt(playerid, "patrol-dec") == 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nikt nie oferowa� Ci patrolu.");
        if(GetPVarInt(playerid, "patrol") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Aktualnie jestes na patrolu.");
        new id = GetPVarInt(playerid, "patrol-parent");
        if(!IsPlayerConnected(id)) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nie ma takiego gracza.");
        new pat = GetPVarInt(id, "patrol-id");
        if(PatrolInfo[pat][pataktywny] == 0 || GetPVarInt(id, "patrol-parent") != playerid) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Taki patrol nie istnieje.");
        if(PatrolInfo[pat][pattime] != GetPVarInt(id, "patrol-time")) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Oferta patrolu wygas�a.");
        new str[128], nick[MAX_PLAYER_NAME+1];
        GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
        format(str, 128, "PATROL �� %s zaakceptowa� Twoj� propozycj�.", nick);
        sendTipMessageEx(id, COLOR_LIGHTBLUE, str);

        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "PATROL �� Zaakceptowano wsp�lny patrol.");

        PatrolInfo[pat][patroluje][1] = playerid;
        PatrolInfo[pat][pattyp] = 1;

        SetPVarInt(playerid, "patrol-id", pat);
        SetPVarInt(playerid, "patrol", 1);

        Patrol_ShowMap(id);
        SetPVarInt(id, "patrol-map", 1);
        SelectTextDraw(id, 0xD2691E55);

        SetPVarInt(id, "patrol-duo", 1);

        SetPVarInt(id, "patrol-dec", 0);
    }
    else if(strcmp(var, "mapa", true) == 0)
    {
        if(GetPVarInt(playerid, "patrolmap") == 0)
        {
            Patrol_ShowMap(playerid);
        }
        else if(GetPVarInt(playerid, "patrolmap") == 1)
        {
            Patrol_HideMap(playerid);
        }
    }
    else if(strcmp(var, "lista", true) == 0)
    {
        new alfa[32] = "Obszar ALFA: ";
        new beta[32] = "Obszar BETA: ";
        new gamma[32] = "Obszar GAMMA: ";
        new delta[32] = "Obszar DELTA: ";
        new a,b,g,d;
        for(new i = 0; i < sizeof(PatrolInfo); i++)
        {
            if(PatrolInfo[i][patstrefa] == 1)
            {
                strcat(alfa, PatrolInfo[i][patname]);
                strcat(alfa, ", ");
                a++;
            }
            else if(PatrolInfo[i][patstrefa] == 2)
            {
                strcat(beta, PatrolInfo[i][patname]);
                strcat(beta, ", ");
                b++;
            }
            else if(PatrolInfo[i][patstrefa] == 3)
            {
                strcat(gamma, PatrolInfo[i][patname]);
                strcat(gamma, ", ");
                g++;
            }
            else if(PatrolInfo[i][patstrefa] == 4)
            {
                strcat(delta, PatrolInfo[i][patname]);
                strcat(delta, ", ");
                d++;
            }
        }
        if(a > 0) SendClientMessage(playerid, COLOR_LIGHTBLUE, alfa);
        if(b > 0) SendClientMessage(playerid, COLOR_GREEN, beta);
        if(g > 0) SendClientMessage(playerid, COLOR_RED, gamma);
        if(d > 0) SendClientMessage(playerid, COLOR_YELLOW, delta);
    }
    return 1;
}
