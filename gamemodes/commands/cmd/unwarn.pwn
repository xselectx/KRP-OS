//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ unwarn ]------------------------------------------------//
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

YCMD:unwarn(playerid, params[], help)
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U�yj /unwarn [playerid/Cz��Nicku] [powod]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || Uprawnienia(playerid, ACCESS_KARY_UNBAN))
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
		        if(giveplayerid != INVALID_PLAYER_ID)
		        {
                    if(PlayerInfo[giveplayerid][pWarns] <= 0) return sendTipMessageEx(playerid, COLOR_GRAD1, "Ten gracz nie ma warn�w!");
					new str[128];
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					//PlayerInfo[giveplayerid][pWarns] -= 1;
					
					if(AddPunishment(giveplayerid, GetNick(giveplayerid), playerid, gettime(), PENALTY_UNWARN, 0, result, 0) == 1) {
						format(str, sizeof(str), "Da�e� UN-warna %s, pow�d: %s", giveplayer, (result));
						SendClientMessage(playerid, COLOR_LIGHTRED, str);
						format(str, sizeof(str), "Dosta�e� UN-warna od %s, pow�d: %s", sendername, (result));
						SendClientMessage(giveplayerid, COLOR_LIGHTRED, str);
						format(string, sizeof(string), "AdmCmd: %s zosta� UN-warnowany przez Admina %s, pow�d: %s", giveplayer, sendername, (result));
						ABroadCast(COLOR_YELLOW,string,1);
						Log(punishmentLog, WARNING, "Admin %s unwarnowa� %s, pow�d: %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), result);
						if(GetPlayerAdminDutyStatus(playerid) == 1)
						{
							iloscWarn[playerid] = iloscWarn[playerid]+1;
						}
						return 1;
					}
				}
			} else {
			sendErrorMessage(playerid, "Takiego gracza nie ma na serwerze!");
			}
		}
	}
	return 1;
}
