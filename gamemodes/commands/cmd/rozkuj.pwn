//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ rozkuj ]------------------------------------------------//
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

YCMD:rozkuj(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
    {
		new string[128];

		if(GroupPlayerDutyPerm(playerid, PERM_POLICE) || GroupPlayerDutyPerm(playerid, PERM_BOR))
		{
		    new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U�yj /rozkuj [playerid/Cz��Nicku]");
				return 1;
			}
			if(IsPlayerConnected(giveplayerid))
			{
				if(giveplayerid != INVALID_PLAYER_ID)
				{
				    if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz odku� samego siebie!"); return 1; }
						if(PlayerCuffed[giveplayerid] == 2 || Kajdanki_JestemSkuty[giveplayerid] >= 1)
						{
						    format(string, sizeof(string), "* Zosta�e� rozkuty przez %s.", GetNick(playerid));
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Rozku�e� %s.", GetNick(giveplayerid));
							SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							GameTextForPlayer(giveplayerid, "~g~Rozkuty", 2500, 3);
							TogglePlayerControllable(giveplayerid, 1);
							PlayerCuffed[giveplayerid] = 0;
							Kajdanki_JestemSkuty[giveplayerid] = 0;
							Kajdanki_SkutyGracz[giveplayerid] = 0;
                            Kajdanki_Uzyte[giveplayerid] = 0;
                            Kajdanki_Uzyte[playerid] = 0;
							Kajdanki_PDkuje[playerid] = 0;
							Kajdanki_PDkuje[giveplayerid]=0;
							PlayerInfo[giveplayerid][pMuted] = 0;
                            ClearAnimations(giveplayerid);
        					SetPlayerSpecialAction(giveplayerid,SPECIAL_ACTION_NONE);
							RemovePlayerAttachedObject(giveplayerid, 5);
						}
						else
						{
						    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest skuty !");
						}
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Twoja grupa nie ma takich uprawnie� lub nie jeste� na s�u�bie!");
		}
	}//not connected
	return 1;
}
