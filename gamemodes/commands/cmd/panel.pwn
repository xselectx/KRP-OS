//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ panel ]-------------------------------------------------//
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

YCMD:panel(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_PANEL) && !Uprawnienia(playerid, ACCESS_SKRYPTER)) return noAccessMessage(playerid);
    new str[256];
    if(isnull(params))
    {
        new kary;
        if(Uprawnienia(playerid, ACCESS_KARY) || Uprawnienia(playerid, ACCESS_SKRYPTER)) kary=0b10;
        SetPVarInt(playerid, "panel-upr", kary);
        DeletePVar(playerid, "panel-kary-continue");
        DeletePVar(playerid, "panel-powod");
        format(str, sizeof(str), "{FFFFFF}» PANEL KAR (%s{FFFFFF})\n{FFFFFF}» SprawdŸ konto gracza", (kary & 0b10) ? ("{00FF00}Uprawnienia") : ("{FF0000}Brak upr."));
        ShowPlayerDialogEx(playerid, D_PANEL_ADMINA, DIALOG_STYLE_LIST, "K-RP » Panel administracyjny", str, "Wybierz", "WyjdŸ");
    }
    else
    {
        new var[32], sub[32], powod[64];
        if(sscanf(params, "s[32]s[32]S()[64]", sub, var, powod)) return SendClientMessage(playerid, COLOR_GRAD2, "Parametry: unban [nick] [powod] | ban [nick] [powód] | unwarn [nick] [powod]");
        if(strcmp(sub, "unban", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_UNBAN) && !Uprawnienia(playerid, ACCESS_SKRYPTER))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc!");
                return 1;
            }
			
            if(strlen(powod) < 1)
            {
                sendErrorMessage(playerid, "Podaj powód.");
                return 1;
            }
			
			if(AddPunishment(-1, var, playerid, gettime(), PENALTY_UNBAN, 0, powod, 0) != 1)
			{
				SendClientMessage(playerid, COLOR_RED, "Nie mo¿na by³o wykonaæ zapytania do bazy!");
				return 1;
			}

            format(str, sizeof(str), "ADM: %s - odblokowano nick: %s", GetNickEx(playerid), var);
            SendClientMessage(playerid, COLOR_LIGHTRED, str);
            Log(punishmentLog, WARNING, "Admin %s odbanowa³ %s", GetPlayerLogName(playerid), var);
            return 1;
        }
        else if(strcmp(sub, "ban", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_BAN) && !Uprawnienia(playerid, ACCESS_SKRYPTER))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                sendErrorMessage(playerid, "Niepoprawna d³ugosc!");
                return 1;
            }
            if(strlen(powod) < 1)
            {
                sendErrorMessage(playerid, "Podaj powód.");
                return 1;
            }
			
			//MruMySQL_BanujOffline(var, powod, playerid);
			
			if(AddPunishment(-1, var, playerid, gettime(), PENALTY_BAN, 0, powod, 0) == 1) {
				format(str, sizeof(str), "ADM: %s - zablokowano nick: %s powód: %s", GetNickEx(playerid), var, powod);
				SendClientMessage(playerid, COLOR_LIGHTRED, str);
				Log(punishmentLog, WARNING, "Admin %s ukara³ offline %s kar¹ bana, powód: %s", 
					GetPlayerLogName(playerid),
					var,
					powod);
				}
            return 1;
        }
        else if(strcmp(sub, "unwarn", true) == 0)
        {
            if(!Uprawnienia(playerid, ACCESS_KARY_UNBAN) && !Uprawnienia(playerid, ACCESS_SKRYPTER))
            {
                sendErrorMessage(playerid, "Uprawnienia: Nie posiadasz wystarczaj¹cych uprawnieñ.");
                return 1;
            }
            if(strlen(var) < 1 || strlen(var) > MAX_PLAYER_NAME)
            {
                SendClientMessage(playerid, COLOR_RED, "Niepoprawna d³ugosc!");
                return 1;
            }
            if(strlen(powod) < 1)
            {
                sendErrorMessage(playerid, "Podaj powód.");
                return 1;
            }
			new id;
			if(!sscanf(var, "k<fix>", id) && id != INVALID_PLAYER_ID)
			{
                SendClientMessage(playerid, COLOR_RED, "Gracz jest online, u¿ywam komendy /unwarn");
				
				new txt[64];
				format(txt, sizeof(txt), "%d Panel /unwarn", id);
				RunCommand(playerid, "/unwarn",  txt);
				return 1;
			}
			
            //new warny = MruMySQL_GetAccInt("Warnings", var);
            new warny = MruMySQL_GetWarnsFromName(var);
            if(warny > 0)
            {
				if(AddPunishment(-1, var, playerid, gettime(), PENALTY_UNWARN, 0, powod, 0) == 1) {
					//MruMySQL_Unwarn(var);
					format(str, sizeof(str), "AdmCmd: Konto gracza %s zosta³o unwarnowane przez %s, powod: %s", var, GetNickEx(playerid), powod);
					ABroadCast(COLOR_YELLOW,str,1);
					Log(punishmentLog, WARNING, "Admin %s unwarnowa³ %s, powod: %s", GetPlayerLogName(playerid), var, powod);
				}
            }
            else sendTipMessage(playerid, "Gracz nie posiada warnów");
            return 1;
        }
    }
    return 1;
}
