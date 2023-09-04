//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ plac ]-------------------------------------------------//
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

YCMD:plac(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
			new giveplayerid, moneys;
			if( sscanf(params, "k<fix>s[32]", giveplayerid, string))
			{
				sendTipMessage(playerid, "U�yj /plac [playerid/Cz��Nicku] [ilo��]");
				return 1;
			}
			moneys = FunkcjaK(string);


			if(moneys < 1 || moneys > 1001)
			{
			    sendTipMessage(playerid, "Kwota musi wynosi� mniej ni� 1000$ .");
			    return 1;
			}
			if(moneys > 50 && PlayerInfo[playerid][pLevel] < 2 && PlayerInfo[playerid][pLocal] != 108)
			{
				return sendTipMessage(playerid, "Nie mo�esz p�aci� wi�cej niz $50");
			}
			if(PlayerInfo[playerid][pConnectTime] == 0)
			{
				sendTipMessage(playerid, "Zanim b�dziesz m�g� p�aci�, musisz gra� wi�cej ni� 1 godzin� online!");
			    return 1;
			}
			if(AntySpam[playerid] == 1)
			{
			    sendTipMessage(playerid, "Odczekaj 15 sekund, po�wi�� ten czas na wykonanie akcji RP");
				return 1;
			}
			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID && playerid != giveplayerid)
			    {
			        if(PlayerInfo[giveplayerid][pLocal] == 106)
					{
						sendTipMessage(playerid, "Komenda nie dzia�a w tym miejscu.");
						return 1;
					}
			        if(Spectate[giveplayerid] != INVALID_PLAYER_ID)
					{
						sendErrorMessage(playerid, "Jeste� za daleko od gracza.");
						return 1;
					}
					if (ProxDetectorS(5.0, playerid, giveplayerid))
					{
						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						new playermoney = kaska[playerid];
						if (moneys > 0 && playermoney >= moneys)
						{
							ZabierzKaseDone(playerid, moneys);
							DajKaseDone(giveplayerid, moneys);
							format(string, sizeof(string), "   Da�e� %s(gracz: %d), $%d.", giveplayer,giveplayerid, moneys);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_GRAD1, string);
							format(string, sizeof(string), "   Otrzyma�e� $%d od %s(gracz: %d).", moneys, sendername, playerid);
							SendClientMessage(giveplayerid, COLOR_GRAD1, string);
							Log(payLog, WARNING,  "%s da� %s kwot� %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), moneys);
							PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "* %s wyci�ga pieni�dze i daje je %s.", sendername ,giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							if(IsPlayerInRangeOfPoint(playerid, 20.0, 2414.0461,-1604.5720,2420.4224) && IsPlayerInGroup(giveplayerid, 11))
							{
							}
							else
							{
								AntySpam[playerid] = 1;
								SetTimerEx("AntySpamTimer",15000,0,"d",playerid);
							}
						}
						else
						{
							sendErrorMessage(playerid, "Nieprawid�owa ilo�� pieni�dzy.");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Jeste� za daleko od gracza.");
					}
				}//invalid id
			}
			else
			{
				format(string, sizeof(string), "%d nie jest na serwerze.", giveplayerid);
				sendErrorMessage(playerid, string);
			}
		}
		else
		{
		    KickEx(playerid);
		}
	}
	return 1;
}
