//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ dl ]--------------------------------------------------//
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

YCMD:dl(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAnInstructor(playerid) || PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
        {
            if(PlayerInfo[playerid][pLocal] == 108 || PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
            {
	            new x_nr[16];
				new giveplayerid;
				if( sscanf(params, "s[16]k<fix>", x_nr, giveplayerid))
				{
				    sendTipMessageEx(playerid, COLOR_WHITE, "U�yj /dajlicencje [nazwa] [playerid/Cz��Nicku]");
				    sendTipMessageEx(playerid, COLOR_WHITE, "Dost�pne nazwy: Auto, Lot, Lodzie, Ryby, Bron.");//, Bron.");
					return 1;
				}
								
				if(!IsPlayerConnected(giveplayerid))
				{
					sendErrorMessage(playerid, "Nie ma takiego gracza !");
					return 1;
				}
				
			    if(strcmp(x_nr,"auto",true) == 0)
				{
				    if(GroupPlayerDutyRank(playerid) || PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		            {
						if(PlayerInfo[giveplayerid][pDowod] >= 1 || PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
						{
						    if(PlayerInfo[giveplayerid][pCarLic] == 3 || PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
						    {
								if(kaska[playerid] >= 0)
								{
									GetPlayerName(playerid, sendername, sizeof(sendername));
									GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
									format(string, sizeof(string), "* Da�e� licencj� na auto graczowi %s. Koszt licencji (0$) zosta� pobrany z twojego portfela.",giveplayer);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
									format(string, sizeof(string), "* Urz�dnik %s da� tobie prawo jazdy.",sendername);
									SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
									format(string, sizeof(string), "* Urz�dnik %s da� prawo jazdy %s. Urz�d zarobi� 0$.",sendername,giveplayer);
									SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
									ZabierzKaseDone(playerid, 0);
									Sejf_Add(FRAC_GOV, 0);
									PlayerInfo[giveplayerid][pCarLic] = 1;
									Log(payLog, WARNING, "Urz�dnik %s da� %s prawo jazdy (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
									return 1;
								}
								else
								{
									sendTipMessageEx(playerid, COLOR_GREY, "Koszt wydania tej licencji to 0$ a Ty tyle nie masz!");
								}
							}
							else
						    {
			       				sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie zaliczy� wszytkich egzamin�w i nie mo�e otrzyma� prawka!");
						    }
						}
		    			else
					    {
		       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyr�b graczowi dow�d ( komenda /wydaj ) !");
					    }
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 3 rangi aby m�c wyda� t� licencj�");
					}
				}
				else if(strcmp(x_nr,"lot",true) == 0)
				{
				    if(GroupPlayerDutyRank(playerid) >= 3)
		            {
						if(PlayerInfo[giveplayerid][pDowod] >= 1)
						{
							if(IsPlayerConnected(giveplayerid))
							{
							    if(giveplayerid != INVALID_PLAYER_ID)
							    {
							        if(kaska[playerid] >= 0)
							        {
								        GetPlayerName(playerid, sendername, sizeof(sendername));
								        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							            format(string, sizeof(string), "* Da�e� licencj� na latanie graczowi %s. Koszt licencji (0$) zosta� pobrany z twojego portfela.",giveplayer);
								        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								        format(string, sizeof(string), "* Urz�dnik %s da� tobie licencj� na latanie.",sendername);
								        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                                        format(string, sizeof(string), "* Urz�dnik %s da� licencje na latanie %s. Urz�d zarobi� 0$.",sendername,giveplayer);
									    SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
								        ZabierzKaseDone(playerid, 0);
                                        Sejf_Add(FRAC_GOV, 0);
								        PlayerInfo[giveplayerid][pFlyLic] = 1;
										Log(payLog, WARNING, "Urz�dnik %s da� %s licencje na latanie (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
								        return 1;
	                                }
								    else
								    {
								        sendTipMessageEx(playerid, COLOR_GREY, "Koszt wydania tej licencji to 0$ a ty tyle nie masz!");
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
		       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyr�b graczowi dow�d ( komenda /wydaj ) !");
					    }
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 3 rangi aby m�c wyda� t� licencj�");
					}
				}
				else if(strcmp(x_nr,"lodzie",true) == 0)
				{
					if(GroupPlayerDutyRank(playerid) >= 2)
		            {
						if(PlayerInfo[giveplayerid][pDowod] >= 1)
						{
							if(IsPlayerConnected(giveplayerid))
							{
							    if(giveplayerid != INVALID_PLAYER_ID)
							    {
							        if(kaska[playerid] >= 0)
							        {
								        GetPlayerName(playerid, sendername, sizeof(sendername));
								        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							            format(string, sizeof(string), "* Da�e� licencj� na p�ywanie �odziami graczowi %s. Koszt licencji (0$) zosta� pobrany z twojego portfela.",giveplayer);
								        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								        format(string, sizeof(string), "* Urz�dnik %s da� tobie licencj� na p�ywanie �odziami.",sendername);
								        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                                        format(string, sizeof(string), "* Urz�dnik %s da� licencj� na p�ywanie %s. Urz�d zarobi� 0$.",sendername,giveplayer);
									    SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
								        ZabierzKaseDone(playerid, 0);
                                        Sejf_Add(FRAC_GOV, 0);
								        PlayerInfo[giveplayerid][pBoatLic] = 1;
										Log(payLog, WARNING, "Urz�dnik %s da� %s licencje na p�ywanie (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
								        return 1;
							        }
								    else
								    {
								        sendTipMessageEx(playerid, COLOR_GREY, "Koszt wydania tej licencji to 0$ a ty tyle nie masz!");
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
		       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyr�b graczowi dow�d ( komenda /wydaj ) !");
					    }
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 2 rangi aby m�c wyda� t� licencj�");
					}
				}
				else if(strcmp(x_nr,"ryby",true) == 0)
				{
					if(PlayerInfo[giveplayerid][pDowod] >= 1)
					{
						if(IsPlayerConnected(giveplayerid))
						{
						    if(giveplayerid != INVALID_PLAYER_ID)
						    {
						        if(kaska[playerid] >= 0)
						        {
							        GetPlayerName(playerid, sendername, sizeof(sendername));
							        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						            format(string, sizeof(string), "* Da�e� kart� w�dkarsk� graczowi %s. Koszt licencji (0$) zosta� pobrany z twojego portfela.",giveplayer);
							        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							        format(string, sizeof(string), "* Urz�dnik %s da� tobie kart� w�dkarsk�.",sendername);
							        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Urz�dnik %s da� kart� w�dkarsk� %s. Urz�d zarobi� 0$.",sendername,giveplayer);
									SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
							        ZabierzKaseDone(playerid, 0);
                                    Sejf_Add(FRAC_GOV, 0);
							        PlayerInfo[giveplayerid][pFishLic] = 1;
									Log(payLog, WARNING, "Urz�dnik %s da� %s kart� w�dkarsk� (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
							        return 1;
						        }
							    else
							    {
							        sendTipMessageEx(playerid, COLOR_GREY, "Koszt wydania tej licencji to 0$ a ty tyle nie masz!");
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
	       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyr�b graczowi dow�d ( komenda /wydaj ) !");
				    }
				}
				else if(strcmp(x_nr,"bron",true) == 0)
				{
					if(GroupPlayerDutyRank(playerid) >= 1)
		            {
						if(PlayerInfo[giveplayerid][pDowod] >= 1)
						{
							if(IsPlayerConnected(giveplayerid))
							{
							    if(giveplayerid != INVALID_PLAYER_ID)
							    {
							        if(kaska[playerid] >= 0)
							        {
								        GetPlayerName(playerid, sendername, sizeof(sendername));
								        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							            format(string, sizeof(string), "* Da�e� licencj� na bro� graczowi %s. Koszt licencji (0$) zosta� pobrany z twojego portfela.",giveplayer);
								        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								        format(string, sizeof(string), "* Urz�dnik %s da� tobie licencj� na bro�.",sendername);
								        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                                        format(string, sizeof(string), "* Urz�dnik %s da� licencj� na bro� %s. Urz�d zarobi� 0$.",sendername,giveplayer);
									    SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
								        ZabierzKaseDone(playerid, 0);
                                        Sejf_Add(FRAC_GOV, 0);
								        PlayerInfo[giveplayerid][pGunLic] = 1;
										Log(payLog, WARNING, "Urz�dnik %s da� %s licencj� na bro� (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
								        return 1;
							        }
								    else
								    {
								        sendTipMessageEx(playerid, COLOR_GREY, "Koszt wydania tej licencji to 0$ a ty tyle nie masz!");
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
		       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyr�b graczowi dow�d ( komenda /wydaj ) !");
					    }
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 1 rangi aby m�c wyda� t� licencj�");
					}
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_WHITE, "Dost�pne nazwy: Auto, Lot, Lodzie, Ryby, Bron.");
					return 1;
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� w Urz�dzie Miasta!");
            	return 1;
			}
        }
        else
        {
            sendErrorMessage(playerid, "Nie jeste� instruktorem !");
            return 1;
        }
    }
    return 1;
}
