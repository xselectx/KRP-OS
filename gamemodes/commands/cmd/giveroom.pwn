//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ giveroom ]-----------------------------------------------//
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

YCMD:giveroom(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
	        if(PlayerInfo[playerid][pDom] != 0)
	        {
	            if(IsPlayerInRangeOfPoint(playerid, 10.0, Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y], Dom[PlayerInfo[playerid][pDom]][hWej_Z]))
	            {
                    new giveplayerid;
					if( sscanf(params, "k<fix>", giveplayerid))
					{
						sendTipMessage(playerid, "U�yj /dajpokoj [id]");
						return 1;
					}

					if(!IsPlayerConnected(giveplayerid)) 
					{
						sendErrorMessage(playerid, "Nie ma takiego gracza.");
						return 1;
					}

					if(PlayerInfo[giveplayerid][pDom] == 0)
					{
					    if(PlayerInfo[giveplayerid][pWynajem] == 0)
					    {
					        if(kaska[giveplayerid] >= Dom[PlayerInfo[playerid][pDom]][hCenaWynajmu])
					        {
					            if(IsPlayerInRangeOfPoint(giveplayerid, 10.0, Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y], Dom[PlayerInfo[playerid][pDom]][hWej_Z]))
	            				{
									new dom = PlayerInfo[playerid][pDom];
	            				    if(Dom[dom][hPDW] > 0)
									{
							            GetPlayerName(playerid, sendername, sizeof(sendername));
							            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
										format(string, sizeof(string), "Gracz %s proponuje ci wynajem pokoju za %d$, aby go wynaj�� wpisz /akceptuj wynajem.", sendername, Dom[PlayerInfo[playerid][pDom]][hCenaWynajmu]);
										SendClientMessage(giveplayerid, COLOR_WHITE, "Aby zobaczy� informacje o proponowanym domu wpisz /wynajeminfo przy domu.");
										SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
										format(string, sizeof(string), "Zaoferowa�e� graczowi %s wynajem pokoju w swoim domu za %d$", giveplayer, Dom[PlayerInfo[playerid][pDom]][hCenaWynajmu]);
										SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
										WynajemOffer[giveplayerid] = playerid;
									}
									else
									{
									    SendClientMessage(playerid, COLOR_GRAD3,"Pokoje w domu s� przepe�nione!");
									}
								}
								else
								{
								    SendClientMessage(playerid, COLOR_GRAD3,"Gracz kt�remu chcesz wynaj�� dom musi sta� przy twoim domu.");
								}
					        }
					        else
					        {
					            SendClientMessage(playerid, COLOR_GRAD3,"Tego gracza nie sta� na wynajem twojego domu.");
					        }
					    }
					    else
					    {
					        SendClientMessage(playerid, COLOR_GRAD3,"Ten gracz wynajmuje ju� dom. Aby da� mu pok�j do swojego domu popro� go aby wpisa� /unrent.");
					    }
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GRAD3,"Ten gracz posiada w�asny dom. Nie mo�esz mu da� pokoju w swoim domu.");
					}
				}
				else
				{
				    SendClientMessage(playerid, COLOR_GRAD3,"Musisz sta� przy swoim domu.");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GRAD3,"Nie posiadasz domu.");
			}
		}
	}
	return 1;
}
