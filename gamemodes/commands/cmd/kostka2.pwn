//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kostka2 ]------------------------------------------------//
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

YCMD:kostka2(playerid, params[], help)
{
	new string[64];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new dice = true_random(6)+1;
		if (HasItemType(playerid, ITEM_TYPE_KOSTKA) != -1)
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s rzuca kostk� i wypada liczba %d", sendername,dice);
			ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 50.0, 1038.22924805,-1090.59741211,-67.52223969))
		{
			sendTipMessageEx(playerid, TEAM_AZTECAS_COLOR, "U�yj /kostka");
		}
		else
		{
			sendTipMessage(playerid, "Nie masz ko�ci");
			return 1;
		}
	}
	return 1;
}
