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
				    sendTipMessageEx(playerid, COLOR_WHITE, "U¿yj /dajlicencje [nazwa] [playerid/CzêœæNicku]");
				    sendTipMessageEx(playerid, COLOR_WHITE, "Dostêpne nazwy: Auto, Lot, Lodzie, Ryby, Bron.");//, Bron.");
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
									format(string, sizeof(string), "* Da³eœ licencjê na auto graczowi %s. Koszt licencji (0$) zosta³ pobrany z twojego portfela.",giveplayer);
									SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
									format(string, sizeof(string), "* Urzêdnik %s da³ tobie prawo jazdy.",sendername);
									SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
									format(string, sizeof(string), "* Urzêdnik %s da³ prawo jazdy %s. Urz¹d zarobi³ 0$.",sendername,giveplayer);
									SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
									ZabierzKaseDone(playerid, 0);
									Sejf_Add(FRAC_GOV, 0);
									PlayerInfo[giveplayerid][pCarLic] = 1;
									Log(payLog, WARNING, "Urzêdnik %s da³ %s prawo jazdy (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
									return 1;
								}
								else
								{
									sendTipMessageEx(playerid, COLOR_GREY, "Koszt wydania tej licencji to 0$ a Ty tyle nie masz!");
								}
							}
							else
						    {
			       				sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie zaliczy³ wszytkich egzaminów i nie mo¿e otrzymaæ prawka!");
						    }
						}
		    			else
					    {
		       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyrób graczowi dowód ( komenda /wydaj ) !");
					    }
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 3 rangi aby móc wydaæ t¹ licencjê");
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
							            format(string, sizeof(string), "* Da³eœ licencjê na latanie graczowi %s. Koszt licencji (0$) zosta³ pobrany z twojego portfela.",giveplayer);
								        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								        format(string, sizeof(string), "* Urzêdnik %s da³ tobie licencjê na latanie.",sendername);
								        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                                        format(string, sizeof(string), "* Urzêdnik %s da³ licencje na latanie %s. Urz¹d zarobi³ 0$.",sendername,giveplayer);
									    SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
								        ZabierzKaseDone(playerid, 0);
                                        Sejf_Add(FRAC_GOV, 0);
								        PlayerInfo[giveplayerid][pFlyLic] = 1;
										Log(payLog, WARNING, "Urzêdnik %s da³ %s licencje na latanie (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
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
		       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyrób graczowi dowód ( komenda /wydaj ) !");
					    }
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 3 rangi aby móc wydaæ t¹ licencjê");
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
							            format(string, sizeof(string), "* Da³eœ licencjê na p³ywanie ³odziami graczowi %s. Koszt licencji (0$) zosta³ pobrany z twojego portfela.",giveplayer);
								        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								        format(string, sizeof(string), "* Urzêdnik %s da³ tobie licencjê na p³ywanie ³odziami.",sendername);
								        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                                        format(string, sizeof(string), "* Urzêdnik %s da³ licencjê na p³ywanie %s. Urz¹d zarobi³ 0$.",sendername,giveplayer);
									    SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
								        ZabierzKaseDone(playerid, 0);
                                        Sejf_Add(FRAC_GOV, 0);
								        PlayerInfo[giveplayerid][pBoatLic] = 1;
										Log(payLog, WARNING, "Urzêdnik %s da³ %s licencje na p³ywanie (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
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
		       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyrób graczowi dowód ( komenda /wydaj ) !");
					    }
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 2 rangi aby móc wydaæ t¹ licencjê");
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
						            format(string, sizeof(string), "* Da³eœ kartê wêdkarsk¹ graczowi %s. Koszt licencji (0$) zosta³ pobrany z twojego portfela.",giveplayer);
							        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							        format(string, sizeof(string), "* Urzêdnik %s da³ tobie kartê wêdkarsk¹.",sendername);
							        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Urzêdnik %s da³ kartê wêdkarsk¹ %s. Urz¹d zarobi³ 0$.",sendername,giveplayer);
									SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
							        ZabierzKaseDone(playerid, 0);
                                    Sejf_Add(FRAC_GOV, 0);
							        PlayerInfo[giveplayerid][pFishLic] = 1;
									Log(payLog, WARNING, "Urzêdnik %s da³ %s kartê wêdkarsk¹ (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
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
	       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyrób graczowi dowód ( komenda /wydaj ) !");
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
							            format(string, sizeof(string), "* Da³eœ licencjê na broñ graczowi %s. Koszt licencji (0$) zosta³ pobrany z twojego portfela.",giveplayer);
								        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
								        format(string, sizeof(string), "* Urzêdnik %s da³ tobie licencjê na broñ.",sendername);
								        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
                                        format(string, sizeof(string), "* Urzêdnik %s da³ licencjê na broñ %s. Urz¹d zarobi³ 0$.",sendername,giveplayer);
									    SendLeaderRadioMessage(11, COLOR_LIGHTGREEN, string);
								        ZabierzKaseDone(playerid, 0);
                                        Sejf_Add(FRAC_GOV, 0);
								        PlayerInfo[giveplayerid][pGunLic] = 1;
										Log(payLog, WARNING, "Urzêdnik %s da³ %s licencjê na broñ (0$).", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
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
		       				sendTipMessageEx(playerid, COLOR_GREY, "Najpierw wyrób graczowi dowód ( komenda /wydaj ) !");
					    }
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 1 rangi aby móc wydaæ t¹ licencjê");
					}
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_WHITE, "Dostêpne nazwy: Auto, Lot, Lodzie, Ryby, Bron.");
					return 1;
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w Urzêdzie Miasta!");
            	return 1;
			}
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ instruktorem !");
            return 1;
        }
    }
    return 1;
}
