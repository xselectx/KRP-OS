//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ boks ]-------------------------------------------------//
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

YCMD:walka(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pJob] != 12)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� bokserem !");
            return 1;
        }
        if(InRing > 0)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Walczysz ju� z kim�, poczekaj a� walka dobiegnie ko�ca !");
            return 1;
        }
        if(PlayerBoxing[playerid] > 0)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Walczysz ju� z kim� !");
            return 1;
        }
        if(!PlayerToPoint(20.0,playerid,765.9343,0.2761,1000.7173))
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� w Si�owni !");
            return 1;
        }
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U�yj /walka [playerid/Cz��Nicku]");
			return 1;
		}

	    if(IsPlayerConnected(giveplayerid))
		{
		    if(giveplayerid != INVALID_PLAYER_ID)
		    {
		        if (ProxDetectorS(8.0, playerid, giveplayerid))
				{
				    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz wlaczy� ze sob�!"); return 1; }
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Oferujesz walk� boksersk� %s.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Boxer %s chce z tob� walczy� (wpisz /akceptuj box) aby akceptowa�.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
			        BoxOffer[giveplayerid] = playerid;
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
    return 1;
}
