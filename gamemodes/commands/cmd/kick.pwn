//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ kick ]-------------------------------------------------//
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

YCMD:kick(playerid, params[], help)
{
	new string[256];

    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[128];
		if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U�yj /kick [playerid/Cz��Nicku] [reason]");
			return 1;
		}
		if(giveplayerid == 65535)
		{
			if(sscanf(params, "ds[64]", giveplayerid, result)) 
			{
				sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma zbugowane ID. Wpisz jego ID zamiast nicku aby go zkickowa�.");
				return 1;
			}
		}
		if(!IsPlayerConnected(giveplayerid))
		{
			sendErrorMessage(playerid, "B��dne ID gracza!"); 
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 1 || IsAScripter(playerid))
		{
		    if(AntySpam[playerid] == 1)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
			if(IsPlayerConnected(giveplayerid) || true)//bug z id
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if(PlayerInfo[giveplayerid][pAdmin] > 0)
					{
						sendTipMessage(playerid, "Nie mo�esz dawa� /kick administratorowi!");
						return 1;
					}
                    if(PlayerInfo[giveplayerid][pAdmin] >= 1) return sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zkickowa� Admina !");
  					if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 2 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
  					{
      					//GiveKickForPlayer(giveplayerid, playerid, (result));
						
						if(AddPunishment(giveplayerid, GetNick(giveplayerid), playerid, gettime(), PENALTY_KICK, 0, result, 0) == 1) {
							if(kary_TXD_Status == 1)
							{
								KickPlayerTXD(giveplayerid, playerid, (result));
							}
							else if(kary_TXD_Status == 0)
							{
								format(string, sizeof(string), "Admin %s zkickowa� %s. Pow�d: %s", GetNickEx(playerid), GetNick(giveplayerid), (result));
								SendPunishMessage(string, giveplayerid); 
							}
						} else {
							sendErrorMessage(playerid, "Wyst�pi� b��d!"); 
						}
						return 1;
					}
				}
			}
		}
	}
	return 1;
}
