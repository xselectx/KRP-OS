//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ bp ]--------------------------------------------------//
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

YCMD:bp(playerid, params[], help)//blokada pisania
{
	new giveplayerid, czas, text[32], string[256];
	if(sscanf(params, "k<fix>ds[32]", giveplayerid, czas, text))
	{
		sendTipMessage(playerid, "U�yj /bp [ID gracza] [czas (w godzinach)] [nazwa chatu]");
		return 1;
	}
	if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid) || PlayerInfo[playerid][pNewAP] >= 1)
	{
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				if(czas <= 8 && czas >= 0)
				{
					GiveBPForPlayer(giveplayerid, playerid, czas, text);
					if(kary_TXD_Status == 1)
					{
						BPPlayerTXD(giveplayerid, playerid, czas, text);
					}
					else if(kary_TXD_Status == 0)
					{
						format(string, sizeof(string), "AdmCmd: %s dosta� Blokad� Pisania od %s na %d godzin. Pow�d: %s", GetNick(giveplayerid), GetNickEx(playerid), czas, text);
						SendPunishMessage(string, playerid);
					}
					return 1;
				}
				else
				{
					sendTipMessage(playerid, "Czas od 0 do 8");
				}
			}
		}
		else
		{
			format(string, sizeof(string), "%d jest nieaktywny.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
