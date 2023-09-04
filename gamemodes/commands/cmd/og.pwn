//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ og ]--------------------------------------------------//
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

YCMD:og(playerid, params[], help)
{
    new string[256], admstring[256];
    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "Nie jeste� zalogowany!");
		else if(PlayerInfo[playerid][pConnectTime] == 0 && PlayerInfo[playerid][pLevel] == 1) return sendErrorMessage(playerid, "Aby pisa� og�oszenia musisz przegra� 1h na serwerze!");
		else if(GetPlayerAdminDutyStatus(playerid) == 1) return sendErrorMessage(playerid, "Nie mo�esz pisa� og�osze� podczas s�u�by administratora!");
		else if(PlayerInfo[playerid][pJailed] != 0) return sendErrorMessage(playerid, "Nie posiadasz telefonu w wi�zieniu!");
        else if(GetPhoneNumber(playerid) == 0) return SendClientMessage(playerid, COLOR_GREY, "Nie masz telefonu. Kup go w 24/7 !");
        else if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAD2, "U�YJ: (/og)loszenie [tekst og�oszenia]");
		else if(sprawdzReklame(params, playerid) == 1) return 1;
		else if(sprawdzWulgaryzmy(params, playerid) == 1) return 1;
		else if(PlayerInfo[playerid][pBP] >= 1)
		{
			format(string, sizeof(string), "Nie mo�esz napisa� na tym czacie, gdy� masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			return SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
		}
		else if(GetPhoneOnline(playerid) == 0)
		{
			sendTipMessage(playerid, "Tw�j telefon jest wy��czony! W��cz go za pomoc� /p Telefon");
			return 1;
		}
		else if ((!adds) && (!IsPlayerPremiumOld(playerid)) && PlayerInfo[playerid][pAdmin] < 10)
		{
			format(string, sizeof(string), "Spr�buj p�niej, %d sekund mi�dzy og�oszeniami !",  (addtimer/1000));
			return SendClientMessage(playerid, COLOR_GRAD2, string);
		}
		else
		{
			new Float:paramlen = float(strlen(params));
			new payout = floatround(paramlen * MULT_OGLOSZENIE, floatround_ceil);
			if(kaska[playerid] < payout)
			{
				format(string, sizeof(string), "* U�y�e� %d znak�w i masz zap�aci� $%d, nie posiadasz a� tyle.", strlen(params), payout);
				return SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			}
			ZabierzKaseDone(playerid, payout);
			format(string, sizeof(string), "Og�oszenie: %s, Kontakt: %d", params, GetPhoneNumber(playerid));
			format(admstring, sizeof(admstring), "Og�oszenie: %s, Kontakt: %d [%s]", params, GetPhoneNumber(playerid), GetNick(playerid));
			foreach(new i : Player)
			{
				if(IsPlayerConnected(i))
				{
					if(!gNews[i] && PlayerPersonalization[i][PERS_AD] == 0)
					{
						if(GetPlayerAdminDutyStatus(i) == 1)
						{
							SendClientMessage(i, TEAM_GROVE_COLOR, admstring);
						}
						else
						{
							SendClientMessage(i, TEAM_GROVE_COLOR, string);
						}
					}
				}
			}
			Log(chatLog, WARNING, "%s og�oszenie: %s", GetPlayerLogName(playerid), params);
			format(string, sizeof(string), "~r~Zaplaciles $%d~n~~w~Za: %d Znakow", payout, strlen(params));
			GameTextForPlayer(playerid, string, 5000, 5);
			if (PlayerInfo[playerid][pAdmin] < 1 && (!IsPlayerPremiumOld(playerid)))
			{
				SetTimer("AddsOn", addtimer, 0);adds = 0;
			}
		}   
    }
    return 1;
}
