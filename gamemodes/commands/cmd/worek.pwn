//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ worek ]-------------------------------------------------//
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
	Creative 27 luty 2020
*/


// Notatki skryptera:
/*
	
*/

YCMD:worek(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(IsAPrzestepca(playerid))
		{
		    new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U�yj /worek [playerid/Cz��Nicku]");
				return 1;
			}

			if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz za�o�y�/�ci�gn�� sobie samemu worka!"); return 1; }

		    if(IsPlayerConnected(giveplayerid))
			{
				if(!ProxDetectorS(8.0, playerid, giveplayerid))
				{
					sendTipMessageEx(playerid, COLOR_GREY, "U�yj /worek [playerid/Cz��Nicku] b�d�c w pobli�u ofiary !");
					return 1;
				}

				if(Worek_MamWorek[giveplayerid])
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* %s �ci�gn�� Ci worek z g�owy, odzyska�e� orientacj� w terenie.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* �ci�gn��e� %s worek z g�owy.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* %s �ci�ga %s worek z g�owy.", sendername ,giveplayer);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					
					Worek_MamWorek[giveplayerid] = 0;
					Worek_KomuZalozylem[Worek_KtoZalozyl[giveplayerid]] = INVALID_PLAYER_ID;
					Worek_Uzyty[Worek_KtoZalozyl[giveplayerid]] = 0;
					Worek_KtoZalozyl[giveplayerid] = INVALID_PLAYER_ID;
					UnHave_Worek(giveplayerid);
				}
				else
				{	
					if(Worek_Uzyty[playerid])
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Masz tylko jeden worek, zdejmij go poprzedniej osobie !");
						return 1;
					}
					else
					{
						if(PlayerInfo[giveplayerid][pInjury] == 0 && PlayerTied[giveplayerid] == 0 && pobity[giveplayerid] == 0)
						{
							sendErrorMessage(playerid, "Mo�esz za�o�y� worek na g�ow� tylko graczowi, kt�ry jest pobity/zwi�zany lub ranny.");
							return 1;
						}

						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* %s za�o�y� Ci worek na g�ow�, straci�e� orientacj� w terenie.", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* Za�o�y�e� %s worek na g�ow�.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s zak�ada %s worek na g�ow�.", sendername ,giveplayer);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

						Worek_MamWorek[giveplayerid] = 1;
						Worek_KomuZalozylem[playerid] = giveplayerid;
						Worek_Uzyty[playerid] = 1;
						Worek_KtoZalozyl[giveplayerid] = playerid;

						Have_Worek(giveplayerid);

						//SetTimerEx("timer_MaWorek",2000,0,"d",giveplayerid);
						//todo timer:
						//osoba musi byc ranna/pobita, jezeli zakladajacy worek oddali sie na ~50 metrow lub wyjdzie z gry lub pojdzie afk dluzej niz 2 minuty worek zostanie zdjety
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
