//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ rentroom ]-----------------------------------------------//
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

YCMD:rentroom(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
	        if(PlayerInfo[playerid][pDom] == 0)
	        {
		        for(new i; i<MAX_DOM; i++)
			    {
					if(IsPlayerInRangeOfPoint(playerid, 5.0, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z]))
					{
						if(PlayerInfo[playerid][pWynajem] == 0)
						{
							if(PlayerInfo[playerid][pMotRoom] != 0) return sendTipMessage(playerid, "Nie mo¿esz wynajmowaæ domu gdy wynajmujesz pokój w motelu!");
						    if(kaska[playerid] >= Dom[i][hCenaWynajmu])
						    {
								if(Dom[i][hPDW] != 0)
								{
								    if(Dom[i][hWynajem] == 1)
									{
										sendername = GetNickEx(playerid);
										if(Dom[i][hPW] == 0)
										{
											Dom[i][hL1] = sendername;
										}
										else if(Dom[i][hPW] == 1)
										{
											Dom[i][hL2] = sendername;
										}
										else if(Dom[i][hPW] == 2)
										{
											Dom[i][hL3] = sendername;
										}
										else if(Dom[i][hPW] == 3)
										{
											Dom[i][hL4] = sendername;
										}
										else if(Dom[i][hPW] == 4)
										{
											Dom[i][hL5] = sendername;
										}
										else if(Dom[i][hPW] == 5)
										{
											Dom[i][hL6] = sendername;
										}
										else if(Dom[i][hPW] == 6)
										{
											Dom[i][hL7] = sendername;
										}
										else if(Dom[i][hPW] == 7)
										{
											Dom[i][hL8] = sendername;
										}
										else if(Dom[i][hPW] == 8)
										{
											Dom[i][hL9] = sendername;
										}
										else if(Dom[i][hPW] == 9)
										{
											Dom[i][hL10] = sendername;
										}
										Dom[i][hPDW] --;
										Dom[i][hPW] ++;
										PlayerInfo[playerid][pWynajem] = i;
										format(string, sizeof(string), "Wynaj¹³eœ pokój w tym domu za %d$. Aby uzyskaæ wiêcej opcji i mo¿liwoœci wpisz /dom");
										sendTipMessage(playerid, string, COLOR_NEWS);
									}
									else if(Dom[i][hWynajem] == 3)
									{
									    if(Dom[i][hWW] == 1)
									    {
                                            sendername = GetNickEx(playerid);
											if(Dom[i][hPW] == 0)
											{
												Dom[i][hL1] = sendername;
											}
											else if(Dom[i][hPW] == 1)
											{
												Dom[i][hL2] = sendername;
											}
											else if(Dom[i][hPW] == 2)
											{
												Dom[i][hL3] = sendername;
											}
											else if(Dom[i][hPW] == 3)
											{
												Dom[i][hL4] = sendername;
											}
											else if(Dom[i][hPW] == 4)
											{
												Dom[i][hL5] = sendername;
											}
											else if(Dom[i][hPW] == 5)
											{
												Dom[i][hL6] = sendername;
											}
											else if(Dom[i][hPW] == 6)
											{
												Dom[i][hL7] = sendername;
											}
											else if(Dom[i][hPW] == 7)
											{
												Dom[i][hL8] = sendername;
											}
											else if(Dom[i][hPW] == 8)
											{
												Dom[i][hL9] = sendername;
											}
											else if(Dom[i][hPW] == 9)
											{
												Dom[i][hL10] = sendername;
											}
											Dom[i][hPDW] --;
											Dom[i][hPW] ++;
											PlayerInfo[playerid][pWynajem] = i;
											format(string, sizeof(string), "Wynaj¹³eœ pokój w tym domu za %d$. Aby uzyskaæ wiêcej opcji i mo¿liwoœci wpisz /dom");
											sendTipMessage(playerid, string, COLOR_NEWS);
										}
										else if(Dom[i][hWW] == 2)
									    {
											GetPlayerName(playerid, sendername, sizeof(sendername));
											if(Dom[i][hPW] == 0)
											{
												Dom[i][hL1] = sendername;
											}
											else if(Dom[i][hPW] == 1)
											{
												Dom[i][hL2] = sendername;
											}
											else if(Dom[i][hPW] == 2)
											{
												Dom[i][hL3] = sendername;
											}
											else if(Dom[i][hPW] == 3)
											{
												Dom[i][hL4] = sendername;
											}
											else if(Dom[i][hPW] == 4)
											{
												Dom[i][hL5] = sendername;
											}
											else if(Dom[i][hPW] == 5)
											{
												Dom[i][hL6] = sendername;
											}
											else if(Dom[i][hPW] == 6)
											{
												Dom[i][hL7] = sendername;
											}
											else if(Dom[i][hPW] == 7)
											{
												Dom[i][hL8] = sendername;
											}
											else if(Dom[i][hPW] == 8)
											{
												Dom[i][hL9] = sendername;
											}
											else if(Dom[i][hPW] == 9)
											{
												Dom[i][hL10] = sendername;
											}
											Dom[i][hPDW] --;
											Dom[i][hPW] ++;
											PlayerInfo[playerid][pWynajem] = i;
											format(string, sizeof(string), "Wynaj¹³eœ pokój w tym domu za %d$. Aby uzyskaæ wiêcej opcji i mo¿liwoœci wpisz /dom");
											sendTipMessage(playerid, string, COLOR_NEWS);
									    }
									    else if(Dom[i][hWW] == 3)
									    {
									        if(Dom[i][hTWW] <= PlayerInfo[playerid][pLevel])
										    {
                                                GetPlayerName(playerid, sendername, sizeof(sendername));
												if(Dom[i][hPW] == 0)
												{
													Dom[i][hL1] = sendername;
												}
												else if(Dom[i][hPW] == 1)
												{
													Dom[i][hL2] = sendername;
												}
												else if(Dom[i][hPW] == 2)
												{
													Dom[i][hL3] = sendername;
												}
												else if(Dom[i][hPW] == 3)
												{
													Dom[i][hL4] = sendername;
												}
												else if(Dom[i][hPW] == 4)
												{
													Dom[i][hL5] = sendername;
												}
												else if(Dom[i][hPW] == 5)
												{
													Dom[i][hL6] = sendername;
												}
												else if(Dom[i][hPW] == 6)
												{
													Dom[i][hL7] = sendername;
												}
												else if(Dom[i][hPW] == 7)
												{
													Dom[i][hL8] = sendername;
												}
												else if(Dom[i][hPW] == 8)
												{
													Dom[i][hL9] = sendername;
												}
												else if(Dom[i][hPW] == 9)
												{
													Dom[i][hL10] = sendername;
												}
												Dom[i][hPDW] --;
												Dom[i][hPW] ++;
												PlayerInfo[playerid][pWynajem] = i;
												format(string, sizeof(string), "Wynaj¹³eœ pokój w tym domu za %d$. Aby uzyskaæ wiêcej opcji i mo¿liwoœci wpisz /dom");
												sendTipMessage(playerid, string, COLOR_NEWS);
										    }
										    else
										    {
										        format(string, sizeof(string), "Nie spe³niasz warunku wynajmu. Tylko ludzie z levelem wy¿szym lub równym %d moga wynaj¹æ ten dom.", Dom[i][hTWW]);
										        sendTipMessage(playerid, string);
							        			return 1;
										    }
										}
										else if(Dom[i][hWW] == 4)
									    {
									        if(IsPlayerPremiumOld(playerid))
										    {
										        GetPlayerName(playerid, sendername, sizeof(sendername));
												if(Dom[i][hPW] == 0)
												{
													Dom[i][hL1] = sendername;
												}
												else if(Dom[i][hPW] == 1)
												{
													Dom[i][hL2] = sendername;
												}
												else if(Dom[i][hPW] == 2)
												{
													Dom[i][hL3] = sendername;
												}
												else if(Dom[i][hPW] == 3)
												{
													Dom[i][hL4] = sendername;
												}
												else if(Dom[i][hPW] == 4)
												{
													Dom[i][hL5] = sendername;
												}
												else if(Dom[i][hPW] == 5)
												{
													Dom[i][hL6] = sendername;
												}
												else if(Dom[i][hPW] == 6)
												{
													Dom[i][hL7] = sendername;
												}
												else if(Dom[i][hPW] == 7)
												{
													Dom[i][hL8] = sendername;
												}
												else if(Dom[i][hPW] == 8)
												{
													Dom[i][hL9] = sendername;
												}
												else if(Dom[i][hPW] == 9)
												{
													Dom[i][hL10] = sendername;
												}
												Dom[i][hPDW] --;
												Dom[i][hPW] ++;
												PlayerInfo[playerid][pWynajem] = i;
												format(string, sizeof(string), "Wynaj¹³eœ pokój w tym domu za %d$. Aby uzyskaæ wiêcej opcji i mo¿liwoœci wpisz /dom");
												sendTipMessage(playerid, string, COLOR_NEWS);
										    }
											else
											{
											    format(string, sizeof(string), "Nie spe³niasz warunku wynajmu. Tylko ludzie z Kontem Premium wy¿szym lub równym %d moga wynaj¹æ ten dom.", Dom[i][hTWW]);
										        sendTipMessage(playerid, string);
							        			return 1;
											}
										}
									}
									else if(Dom[i][hWynajem] == 2)
									{
									    sendTipMessage(playerid,"Pokój w tym domu mo¿e daæ ci tylko w³aœciciel.");
						        		return 1;
									}
									else
									{
                                    	sendErrorMessage(playerid,"Ten dom nie jest do wynajmu.");
						        		return 1;
									}
								}
								else
								{
								    sendTipMessage(playerid,"Wszystkie pokoje s¹ zajête. Nie mo¿esz wynaj¹æ.");
						        	return 1;
								}
						    }
						    else
						    {
						        sendErrorMessage(playerid,"Nie staæ ciê na wynajmowanie tego domu.");
						        return 1;
						    }
						}
						else
		    			{
	        				sendTipMessage(playerid,"Wynajmujesz ju¿ dom, aby przestac go wynajmowaæ wpisz /unrent.");
					        return 1;
					    }
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid,"Nie mo¿esz wynajmowaæ domu kiedy posiadasz swój w³asny.");
			}
	    }
	}
	return 1;
}
