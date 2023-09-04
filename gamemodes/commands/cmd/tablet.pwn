//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ tablet ]------------------------------------------------//
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

YCMD:tablet(playerid, params[], help)
{
	new string[512];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(!IsAPolicja(playerid))
        {
            sendErrorMessage(playerid, "Nie jeste� policjantem!");
            return 1;
        }
		new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U�yj /tablet [id gracza/cz�� nicku]");
			return 1;
		}
		if(GroupPlayerDutyPerm(playerid, PERM_POLICE))
		{
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
			        format(string, sizeof(string), "Imi� i nazwisko:\t%s\nWiek:\t%d\n{00ABFF}Przest�pstwo:\t{FF0000}%s\n{00ABFF}Zg�oszone przez:\t{FF0000}%s\n{FF3535}Poziom poszukiwania:\t{FF3535}%d", giveplayer, PlayerInfo[giveplayerid][pAge], PlayerCrime[giveplayerid][pAccusedof], PlayerCrime[giveplayerid][pVictim], PoziomPoszukiwania[giveplayerid]);
	                ShowPlayerDialogEx(playerid, 9111, DIALOG_STYLE_TABLIST, "TABLET POLICYJNY", string, "Zamknij", "");
	                format(string, sizeof(string), "* %s wyci�ga z kieszeni tablet, po czym wpisuje dane.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
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
		    sendTipMessage(playerid, "Nie jeste� na s�u�bie.");
			return 1;
		}
	}
	return 1;
}
