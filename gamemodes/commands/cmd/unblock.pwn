//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ unblock ]------------------------------------------------//
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

YCMD:unblock(playerid, params[], help)
{
	new string[128];
	new nick[MAX_PLAYER_NAME], result[128];
	
    if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		if( sscanf(params, "s[24] s[128]", nick, result))
		{
			sendTipMessage(playerid, "U¿yj /unblock [nick] [powod]");
			return 1;
		}
		if(AddPunishment(-1, nick, playerid, gettime(), PENALTY_UNBLOCK, 0, result, 0) == 1)
		{
    		format(string, sizeof(string), "Administrator %s nada³ unblocka na postaæ %s powod %s", GetNickEx(playerid), nick, result);
            //SendPunishMessage(string);
            ABroadCast(COLOR_YELLOW,string,1);
            Log(punishmentLog, WARNING, "Admin %s odblokowa³ %s powod %s", GetPlayerLogName(playerid), nick, result);
        }
	}
	return 1;
}
