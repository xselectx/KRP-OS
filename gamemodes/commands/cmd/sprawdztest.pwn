//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ sprawdztest ]----------------------------------------------//
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

YCMD:sprawdztest(playerid, params[], help)
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsAUrzednik(playerid) && PlayerInfo[playerid][pLocal] == 108)
    {
        new giveplayerid;
    	if( sscanf(params, "k<fix>", giveplayerid))
    	{
    		sendTipMessage(playerid, "U�yj /sprawdztest [ID/Nick]");
    		return 1;
    	}

		if(!IsPlayerConnected(giveplayerid)) 
		{
			return sendErrorMessage(playerid, "Nie ma takiego gracza.");
		}

        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
		if(PlayerInfo[giveplayerid][pWtrakcietestprawa]==1)
		{
			format(string, sizeof(string), "* Gracz %s nadal rozwi�zuje test.", giveplayer);
			SendClientMessage(playerid, COLOR_GRAD2, string);
			return 1;
		}
        else
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* Urz�dnik %s sprawdza test %s", sendername, giveplayer);
			ProxDetector(40.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			if(PlayerInfo[giveplayerid][pMinalczasnazdpr] == 1)
			{
				format(string, sizeof(string), "* Gracz %s nie zd��y� odpowiedzie� w wyznaczonym czasie! Nie zda�.", giveplayer);
				SendClientMessage(playerid, COLOR_GREEN, string);
				return 1;
			}
			else if(PlayerInfo[giveplayerid][pCarLic] == 1)
			{
				format(string, sizeof(string), "%s posiada ju� prawo jazdy", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				return 1;
			}
			else if(PlayerInfo[giveplayerid][pSprawdzczyzdalprawko] == 1 || PlayerInfo[giveplayerid][pCarLic] == 2)
			{
				format(string, sizeof(string), "Gracz %s ZDA� egzamin teoretyczny i mo�e rozpocz�� egzamin praktyczny", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				return 1;
			}
			else if(PlayerInfo[giveplayerid][pCarLic] == 3)
			{
				format(string, sizeof(string), "Gracz %s ZDA� egzamin teoretyczny oraz praktyczny i mo�e odebra� prawo jazdy", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				return 1;
			}
            else if(PlayerInfo[giveplayerid][pCarLic] > 1000)
			{
				format(string, sizeof(string), "Gracz %s straci� prawo jazdy za przekroczon� ilos� punkt�w karnych", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				return 1;
			}
			else
			{
				format(string, sizeof(string), "Gracz %s NIE ZDA� testu! Dobrze: %d �le: %d (liczniki pokazuj�ce zero r�wnie� niezaliczaj� testu)", giveplayer, PlayerInfo[giveplayerid][pPrawojazdydobreodp], 3 - PlayerInfo[giveplayerid][pPrawojazdydobreodp]);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				return 1;
			}
        }
    }
    else return sendErrorMessage(playerid, "* Nie jeste� Urz�dnikiem!");
}
