//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ po ]--------------------------------------------------//
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

YCMD:po(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if( (IsABOR(playerid) || IsAPolicja(playerid)) && OnDuty[playerid] > 0)
        {
    		new giveplayerid, result[64];
    		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
    		{
    			sendTipMessage(playerid, "U�yj /(su)spect [playerid/Cz��Nicku] [popelnione przestepstwo]");
    			return 1;
    		}
    		if(IsPlayerConnected(giveplayerid))
    		{
    			if(giveplayerid != INVALID_PLAYER_ID)
    			{
    				if (!(IsAPolicja(giveplayerid) && OnDuty[giveplayerid] > 0))
    				{
    					if(spamwl[giveplayerid] == 0)
    					{
    						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
    						GetPlayerName(playerid, sendername, sizeof(sendername));
							if(PoziomPoszukiwania[giveplayerid] == 0)
							{
								PoziomPoszukiwania[giveplayerid]+=2;
							}
    						else
    						{
                                if(IsABOR(playerid) && PoziomPoszukiwania[giveplayerid] > 1) return sendTipMessage(playerid, "Cz�onek GSA mo�e nada� tylko 1 WL."); //14.06.2014
    							PoziomPoszukiwania[giveplayerid]+= 1;
    						}
							spamwl[giveplayerid] = 1;
    						SetTimerEx("spamujewl",60000,0,"d",giveplayerid);
							PlayCrimeReportForPlayer(playerid,giveplayerid,5);
    						SetPlayerCriminal(giveplayerid,playerid, result);
    						format(string, sizeof(string), "%s ma teraz %d WL. Jest poszukiwany za: %s", giveplayer, PoziomPoszukiwania[giveplayerid], result);
    						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							
							if(IsReasonAPursuitReason(result))
							{
								PursuitMode(playerid, giveplayerid);
							}
    						return 1;
    					}
    					else
    					{
    						sendErrorMessage(playerid, "Da�e� ju� poziom poszukiwania, poczekaj 1 minute (zapobiega spamowaniu WL)");
    					}
    				}
    				else
    				{
    					sendTipMessage(playerid, "   Nie mo�esz dawa� Wanted Level policjantom na s�u�bie!");
    				}
    			}
    		}
    		else
    		{
    			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
    			sendErrorMessage(playerid, string);
    			return 1;
    		}
        } else sendErrorMessage(playerid, " Nie jeste� funkcjonariuszem PD/FBI/NG/BOR na s�u�bie!");
	}
	return 1;
}
