//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wywaz ]-------------------------------------------------//
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

YCMD:wywaz(playerid, params[], help)
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
        if(!IsAPolicja(playerid))
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� policjantem!");
		    return 1;
		}
        if(OnDuty[playerid] != 1 && IsAPolicja(playerid))
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� na s�u�bie!");
		    return 1;
		}
    	new giveplayerid, dom;
		if( sscanf(params, "k<fix>d", giveplayerid, dom))
		{
			sendTipMessage(playerid, "U�yj /wywaz [playerid/Cz��Nicku] [ID domu]");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
  			if(giveplayerid != INVALID_PLAYER_ID)
		    {
		        if (ProxDetectorS(8.0, playerid, giveplayerid))
				{
				    if (!IsPlayerInRangeOfPoint(playerid, 2.0, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z]))
				    {
				       	sendTipMessageEx(playerid, COLOR_GREY, "Ten dom jest za daleko !");
				        return 1;
				    }
				    if (!IsAPolicja(giveplayerid) && OnDuty[giveplayerid] < 1)
				    {
				       	sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest policjantem na s�u�bie!");
				        return 1;
				    }
				    if (giveplayerid == playerid)
				    {
				       	sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz sam wywa�y� drzwi!");
				        return 1;
				    }
				    if(Dom[dom][hKupiony] == 0)
				    {
				       	sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz wywa�y� tych drzwi!");
				        return 1;
				    }
                    if(Dom[dom][hZamek] == 0)
					{
                        Dom[dom][hZamek] = 1;
                        format(string, sizeof(string),"* Policjanci %s oraz %s bior� taran policyjny i uderzaj� nim w drzwi wywa�aj�c je.",GetNick(playerid), GetNick(giveplayerid));
						ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						format(string, sizeof(string), "* Drzwi zosta�y wywa�one (( %s ))", GetNick(playerid));
						ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						format(string, sizeof(string), "[ALARM DOMOWY] Twoje drzwi zosta�y wywa�one! Sprawd� to! (Podejrzany: %s)", GetNick(playerid));
						sendTipMessageEx(GetPlayerIDFromName(Dom[dom][hWlasciciel]), COLOR_RED, string); 
                        return 1;
					}
					else
					{
                        sendTipMessageEx(playerid, COLOR_GREY, "Te drzwi s� otwarte!");
                        return 1;
					}
				}
				else
				{
					sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
					return 1;
				}
			}
		}
		else
		{
		    sendErrorMessage(playerid, "Nie ma takiego gracza !");
		    return 1;
		}
	}
	return 1;
}
