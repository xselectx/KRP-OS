//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ rozwiaz ]------------------------------------------------//
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

YCMD:rozwiaz(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(IsAPrzestepca(playerid))
		{
		    if(GroupPlayerDutyRank(playerid) < 2)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Musisz mie� 2 lub wy�sz� rang�, aby kogo� rozwi�za� !");
		        return 1;
		    }
		    new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U�yj /odwiaz [playerid/Cz��Nicku]");
				return 1;
			}

			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
				    if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz rozwi�za� sam siebie!"); return 1; }
						if(PlayerTied[giveplayerid])
						{
						    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
						    format(string, sizeof(string), "* Zosta�e� odwi�zany przez %s.", sendername);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Odwi�za�e� %s.", giveplayer);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(giveplayerid, "~g~Wolnosc", 2500, 3);
							TogglePlayerControllable(giveplayerid, 1);
							PlayerTied[giveplayerid] = 0;
							pobity[giveplayerid] = 0;
							PlayerCuffedTime[giveplayerid] = 0;
							PlayerCuffed[giveplayerid] = 0;
						}
						else
						{
						    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest zwi�zany !");
						    return 1;
						}
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
					    return 1;
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			    return 1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}//not connected
	return 1;
}
