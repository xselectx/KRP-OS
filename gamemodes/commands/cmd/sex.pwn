//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ sex ]--------------------------------------------------//
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

YCMD:sex(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
   	{
        if(PlayerInfo[playerid][pJob] == 3)
		{
		    if(!IsPlayerInAnyVehicle(playerid))
		    {
				sendTipMessageEx(playerid, COLOR_GREY, "Mo�esz oferowa� sex tylko w poje�dzie !");
				return 1;
		    }
		    new Car = GetPlayerVehicleID(playerid);
			new giveplayerid, money;
			if( sscanf(params, "k<fix>d", giveplayerid, money))
			{
				sendTipMessage(playerid, "U�yj /sex [playerid/Cz��Nicku] [cena]");
				return 1;
			}
            if(GetPVarInt(playerid, "wysekszony") > 0) return sendErrorMessage(playerid, "Stosunek mo�esz uprawia� raz na dwie minuty!");
			if(money < PRICE_SEX_MIN || money > PRICE_SEX_MAX) { sendTipMessageEx(playerid, COLOR_GREY, "Cena od "#PRICE_SEX_MIN"$ do "#PRICE_SEX_MAX"$!"); return 1; }
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz oferowa� sexu temu graczowi!"); return 1; }
					    if(IsPlayerInAnyVehicle(playerid) && IsPlayerInVehicle(giveplayerid, Car))
					    {
						    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							format(string, sizeof(string), "* Oferujesz %s uprawianie sexu z tob� za $%d.", giveplayer, money);
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Prostytutka %s oferuje uprawianie sexu z ni� za $%d (wpisz /akceptuj sex) aby si� zgodzi�.", sendername, money);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				            SexOffer[giveplayerid] = playerid;
				            SexPrice[giveplayerid] = money;
			            }
			            else
			            {
			                sendTipMessageEx(playerid, COLOR_GREY, "Musicie by� w poje�dzie aby to zrobi� !");
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
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� prostytutk� !");
		}
	}//not connected
	return 1;
}
