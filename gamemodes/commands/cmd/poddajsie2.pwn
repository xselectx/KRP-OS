//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ poddajsie2 ]----------------------------------------------//
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


YCMD:poddajsie2(playerid, params[], help)
{
	/*
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pJob] == 1)
		{
			if(Kajdanki_Uzyte[playerid] != 1)
			{
				new giveplayerid;
				if(sscanf(params, "k<fix>", giveplayerid))
				{
					sendTipMessage(playerid, "U�yj /poddajsie [id gracza]");
					return 1;
				}
				if(IsPlayerConnected(giveplayerid))
				{
					if(giveplayerid != INVALID_PLAYER_ID)
					{
						if(GetDistanceBetweenPlayers(playerid,giveplayerid) < 5)
						{
							if(GetPlayerState(playerid) == 1 && GetPlayerState(giveplayerid) == 1)
							{
								if(Kajdanki_JestemSkuty[giveplayerid] == 0)
								{
									if(Kajdanki_Uzyte[giveplayerid] == 0)
									{
										if(GUIExit[playerid] == 0 && GUIExit[giveplayerid] == 0)
										{
											new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
											if(lowcaz[playerid] == giveplayerid)
											{
												sendErrorMessage(playerid, "Nie masz zlecenia na tego gracza! Nie mo�esz go sku�!");
												return 1;
											}
											if(PoziomPoszukiwania[giveplayerid] == 0)
											{
												sendTipMessage(playerid,"Ten gracz nie ma WL! Nie mo�esz wykona� na niego zlecenia!");
												return 1;
											}
											GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
											GetPlayerName(playerid, sendername, sizeof(sendername));
											format(string, sizeof(string), "*�owca nagr�d %s wyci�ga kajdanki i pr�buje je za�o�y� %s.", sendername ,giveplayer);
											ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
											ShowPlayerDialogEx(giveplayerid, 7080, DIALOG_STYLE_MSGBOX, "Pddaj si�!", "Poddaj si�!\n�owca nagr�d z�o�y� propozycj� poddania si�!\nMo�esz j� przyj�� i trafi� do wi�zienia na kr�tszy czas\nlub spr�bowa� pokona� �owc� w walce!", "Poddaj si�", "Wyrwij si�");
											Kajdanki_PDkuje[giveplayerid] = playerid;
											Kajdanki_Uzyte[giveplayerid] = 1;
											//SetTimerEx("UzyteKajdany",30000,0,"dd",giveplayerid,playerid);
											SetTimerEx("UzyteKajdany",30000,0,"d",giveplayerid);
											poddaje[giveplayerid] = 1;
											lowcap[giveplayerid] = playerid;
										}
									}
									else
									{
										sendErrorMessage(playerid, "Odczekaj 30 sekund zanim znowu za�o�ysz kajdanki temu graczowi!");
									}
								}
								else
								{
									sendErrorMessage(playerid, "Ten gracz ma ju� za�o�one kajdanki!");
								}
							}
							else
							{
								sendErrorMessage(playerid, "Nikt z was nie mo�e by� si� w wozie!");
							}
						}
						else
						{
							sendErrorMessage(playerid, "Jeste� za daleko od gracza !");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie ma takiego gracza !");
					}
				}
			}
			else
			{
				sendErrorMessage(playerid, "U�ywasz kajdanek!");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jeste� �owc� nagr�d!");
		}
	}*/
	return 1;
}

