//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ selldom ]------------------------------------------------//
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

YCMD:selldom(playerid, params[], help)
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
	            new dom = PlayerInfo[playerid][pDom];
	            if(Dom[dom][hBlokada] == 1)
	        	{
                    sendErrorMessage(playerid, "Ten dom ma blokad� sprzedawania");
                    return 1;
	        	}
	            if(IsPlayerInRangeOfPoint(playerid, 10.0, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z]))
	            {
	                new giveplayerid, money;
					if( sscanf(params, "k<fix>s[32]", giveplayerid, string))
					{
						sendTipMessage(playerid, "U�yj /sprzedajdom [id/nick] [cena]");
						return 1;
					}
					money = FunkcjaK(string);
					if(!IsPlayerConnected(giveplayerid))
					{
						sendErrorMessage(playerid, "Nie ma takiego gracza");
						return 1;
					}

					if(money < PRICE_SELLHOUSE_MIN)
					{
					    sendTipMessage(playerid, "Cena musi by� powy�ej "#PRICE_SELLHOUSE_MIN"$");
					    return 1;
					}
					if(money > PRICE_SELLHOUSE_MAX)
					{
					    sendTipMessage(playerid, "Cena musi by� poni�ej "#PRICE_SELLHOUSE_MAX"$");
					    return 1;
					}
					if(PlayerInfo[giveplayerid][pDom] == 0)
					{
					    if(PlayerInfo[giveplayerid][pWynajem] == 0)
					    {
					        if(kaska[giveplayerid] >= money)
					        {
					            if(IsPlayerInRangeOfPoint(giveplayerid, 10.0, Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y], Dom[PlayerInfo[playerid][pDom]][hWej_Z]))
	            				{
	            				    if(PlayerInfo[giveplayerid][pLevel] < 3)
	            				    {
	            				        SendClientMessage(playerid, COLOR_GRAD2, "Gracz kt�remu sprzedajesz dom musi mie� co najmniej 3 lvl!");
					    				return 1;
	            				    }
						            GetPlayerName(playerid, sendername, sizeof(sendername));
						            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
									format(string, sizeof(string), "Gracz %s proponuje ci sprzeda� swojego domu za %d$, aby go kupi� wpisz /akceptuj dom.", sendername, money);
									SendClientMessage(giveplayerid, COLOR_WHITE, "Aby zobaczy� informacje o proponowanym domu wpisz /dominfo przy domu.");
									SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
									format(string, sizeof(string), "Zaoferowa�e� graczowi %s sprzeda� swojego domu za %d$", giveplayer, money);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
									DomOffer[giveplayerid] = playerid;
									DomCena[giveplayerid] = money;
									SetPVarInt(playerid, "DomOfferID", PlayerInfo[playerid][pDom]);
								}
								else
								{
								    sendTipMessage(playerid,"Gracz kt�remu chcesz sprzeda� dom musi sta� przy twoim domu.");
								}
					        }
					        else
					        {
					            sendTipMessage(playerid,"Tego gracza nie sta� na kupno za t� cen�.");
					        }
					    }
					    else
					    {
					        sendTipMessage(playerid,"Ten gracz wynajmuje dom. Aby da� mu sw�j dom popro� go aby wpisa� /unrent.");
					    }
					}
					else
					{
					    sendTipMessage(playerid,"Ten gracz posiada w�asny dom. Nie mo�esz mu sprzeda� domu.");
					}
	            }
	            else
	            {
	                sendTipMessage(playerid,"Musisz sta� przy swoim domu.");
	            }
	        }
	        else
	        {
	            sendTipMessage(playerid,"Nie posiadasz domu.");
	        }
	    }
	}
	return 1;
}
