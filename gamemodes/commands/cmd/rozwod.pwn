//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ rozwod ]------------------------------------------------//
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

YCMD:rozwod(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pMarried] < 1)
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� po �lubie !");
			return 1;
        }
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U�yj /rozwod [id/nick]");
			return 1;
		}

	    if(IsPlayerConnected(giveplayerid))
		{
		    if(giveplayerid != INVALID_PLAYER_ID)
		    {
		        if (ProxDetectorS(8.0, playerid, giveplayerid))
				{
				    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz proponowa� rozwodu samemu sobie !"); return 1; }
				    new dstring[MAX_PLAYER_NAME];
					new wstring[MAX_PLAYER_NAME];
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "%s", giveplayer);
					strmid(wstring, string, 0, strlen(string));
					format(string, sizeof(string), "%s", PlayerInfo[playerid][pMarriedTo]);
					strmid(dstring, string, 0, strlen(string));
					if(strcmp(dstring ,wstring, true ) == 0 )
					{
					    format(string, sizeof(string), "* Wys�a�e� papiery rozwodowe do %s.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s wys�a� Ci papiery rozwodowe (wpisz /akceptuj rozwod) aby akceptowa�.", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				        DivorceOffer[giveplayerid] = playerid;
				        return 1;
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest w zwi�zku ma��e�skim z Tob� !");
					    return 1;
					}
				}
				else
				{
					sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest w pobli�u Ciebie !");
					return 1;
				}
		    }
		}
		else
		{
		    sendErrorMessage(playerid, "   Nie ma takiego gracza !");
		    return 1;
		}
	}
	return 1;
}
