//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ oczyscmdc ]-----------------------------------------------//
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
YCMD:oczyscmdc(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pJob] == 2 || CheckPlayerPerm(playerid, PERM_LAWYER))
	 	{
	    	new playa;
			if( sscanf(params, "k<fix>", playa))
			{
				sendTipMessage(playerid, "U?yj /oczyscmdc [Nick/ID] (koszt -10$)");
				SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: ta komenda czysci kartoteki policyjne gracza");
				return 1;
			}


			if(IsPlayerConnected(playa))
		    {
   				if(playa != INVALID_PLAYER_ID)
			    {
				    if(GetDistanceBetweenPlayers(playerid,playa) < 10)
					{
					    if(kaska[playerid] > 10)
						{
		        			GetPlayerName(playerid, sendername, sizeof(sendername));
		        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		        			format(string, sizeof(string), "* Oczyœci³eœ kartoteki gracza %s (-10$)",giveplayer);
						    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					        format(string, sizeof(string), "* Prawnik %s oczyœci³ kartoteki Policji na twój temat",sendername);
					        SendClientMessage(playa, COLOR_LIGHTBLUE, string);
					        format(string, sizeof(string),"* %s wykonuje parê telefonów i oczyszcza kartoteki %s.", sendername, giveplayer);
							ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                            ZabierzKaseDone(playerid, 10);
                            format(string, sizeof(string), "~r~-$%d", 10);
							GameTextForPlayer(playerid, string, 5000, 1);
                    		PlayerPlaySound(playerid, 1054, 0.0, 0.0, 0.0);
                    		ClearCrime(playa);
						}
						else
						{
						    sendErrorMessage(playerid, "Nie masz wystarczaj¹cej iloœci pieniêdzy ($10).");
						}
                    }
					else
					{
					    sendErrorMessage(playerid, "Gracz jest za daleko.");
					}
				}
				else
				{
				    sendErrorMessage(playerid, "Nie ma takiego gracza.");
				}
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ prawnikiem.");
		}
	}
	return 1;
}