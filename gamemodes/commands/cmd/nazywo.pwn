//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ nazywo ]------------------------------------------------//
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

YCMD:nazywo(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(IsPlayerInGroup(playerid, 9) || PlayerInfo[playerid][pLider] == 9)
		{
		    if(TalkingLive[playerid] != INVALID_PLAYER_ID)
		    {
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wywiad zakonczony.");
		        SendClientMessage(TalkingLive[playerid], COLOR_LIGHTBLUE, "* Wywiad zako�czony.");
	            TalkingLive[TalkingLive[playerid]] = INVALID_PLAYER_ID;
                TalkingLive[playerid] = INVALID_PLAYER_ID;
		        return 1;
		    }
			
			new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U�yj /wywiad [playerid/Cz��Nicku]");
				return 1;
			}
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				sendErrorMessage(playerid, "Nie mo�esz dawa� wywiadu podczas @Duty!");
				return 1;
			}
			if(GetPlayerAdminDutyStatus(giveplayerid) == 1)
			{
				sendErrorMessage(playerid, "Ta osoba jest podczas s�u�by administratora!");
				return 1;
			}


			if (IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (ProxDetectorS(5.0, playerid, giveplayerid) || Mobile[playerid] == giveplayerid)
					{
					    if(giveplayerid == playerid) { SendClientMessage(playerid, COLOR_GREY, "Nie mo�esz robi� wywiadu z samym sob�!"); return 1; }
					    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* Oferujesz %s wywiad na �ywo.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						format(string, sizeof(string), "* %s chce z tob� przeprowadzi� wywiad, wpisz (/akceptuj wywiad) aby akceptowa�.", sendername);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						LiveOffer[giveplayerid] = playerid;
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Jeste� za daleko od tego gracza.");
					    sendTipMessageEx(playerid, COLOR_GREY, "Mo�esz przeprowadzi� wywiad telefoniczny dzwoni�c do gracza i oferuj�c mu wywiad komend� /wywiad.");
					    return 1;
					}
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza!");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� Reporterem !");
		}
	}
	return 1;
}
