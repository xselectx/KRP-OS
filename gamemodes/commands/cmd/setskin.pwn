//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setskin ]------------------------------------------------//
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

YCMD:setskin(playerid, params[], help)
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U�yj /setskin [playerid/Cz��Nicku] [id skinu]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid) || Uprawnienia(playerid, ACCESS_SETSKIN))
		{
		    if(IsPlayerConnected(para1))
		    {
				if(level < 0)
				{
					sendErrorMessage(playerid, "B��dne ID skina"); 
					return 1;
				}
				if(level > 311 && level < 20000)
				{
					sendErrorMessage(playerid, "Brak takiego skina w samp-resources"); 
					return 1;
				}
		        if(para1 != INVALID_PLAYER_ID)
		        {
                    if(GetPlayerState(para1) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby nada� skina gracz musi by� pieszo!");
					PlayerInfo[para1][pSkin] = level;
					Log(adminLog, WARNING, "Admin %s zmieni� %s skin na %d", GetPlayerLogName(playerid), GetPlayerLogName(para1), level);
					format(string, sizeof(string), "Tw�j skin zosta� zmieniony na %d przez %s", level, GetNickEx(playerid));
					SendClientMessage(para1, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "Zmieni�e� skin graczowi %s na %d.", GetNick(para1),level);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					SetPlayerSkinEx(para1, level);
					return 1;
				}
			}
		}
		else if(PlayerInfo[playerid][pAdmin] >= 5)
		{
			if(para1 == playerid)
			{
				SetPlayerSkinEx(playerid, level); 
			}
			else
			{
				sendErrorMessage(playerid, "Mo�esz ustawi� skin tylko sobie!"); 
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
