//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ zwiaz ]-------------------------------------------------//
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

YCMD:zwiaz(playerid, params[], help)
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
		        sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 2 rangi aby zwi�zywa� ludzi !");
		        return 1;
		    }
		    new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U�yj /zwiaz [playerid/Cz��Nicku]");
				return 1;
			}

		    if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
				    if(PlayerTied[giveplayerid] > 0)
				    {
				        sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest ju� zwi�zany !");
				        return 1;
				    }
					if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    new car = GetPlayerVehicleID(playerid);
					    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz zwi�za� samego siebie!"); return 1; }
					    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == 2 && IsPlayerInVehicle(giveplayerid, car))
					    {
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
					        format(string, sizeof(string), "* Zosta�e� zwi�zany przez %s.", sendername);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Zwi�za�e� %s tak aby nie m�g� si� rozwi�za�.", giveplayer);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* %s wyci�ga lin� i zwi�zuje %s aby nigdzie nie uciek�.", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							GameTextForPlayer(giveplayerid, "~r~Zwiazany", 2500, 3);
							TogglePlayerControllable(giveplayerid, 0);
							PlayerTied[giveplayerid] = 1;
							PlayerCuffedTime[giveplayerid] = 5*60;
							pobity[giveplayerid] = 0;
					    }
					    else
					    {
					        sendTipMessageEx(playerid, COLOR_GREY, "Gracz nie jest w twoim wozie / nie jeste� kierowc� !");
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
	}
	return 1;
}
