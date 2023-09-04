//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ alkomat ]------------------------------------------------//
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

YCMD:alkomat(playerid, params[], help)
{
	new giveplayerid;
	if(sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U�yj /alkomat [ID gracza]");
		return 1;
	}
	if (IsAPolicja(playerid) || IsAHA(playerid))
	{
		if(!GroupPlayerDutyPerm(playerid, PERM_POLICE))
		{
			sendErrorMessage(playerid, "Nie jeste� na s�u�bie");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(GetDistanceBetweenPlayers(giveplayerid,playerid) < 10)
			{
				new string[128], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
				GetPlayerName(giveplayerid,giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid,sendername, sizeof(sendername));
				if(PlayerStoned[giveplayerid] >= 1 && PlayerStoned[giveplayerid] <= 2)
				{
					format(string, sizeof(string), "Gracz %s jest pod wp�ywem narkotyk�w (ma�o).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				else if(PlayerStoned[giveplayerid] >= 3)
				{
					format(string, sizeof(string), "Gracz %s jest pod wp�ywem narkotyk�w (du�o).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				else
				{
					format(string, sizeof(string), "Gracz %s jest czysty(narkotyki).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				if(PlayerDrunk[giveplayerid] >= 1 && PlayerDrunk[giveplayerid] <= 2 || GetPlayerDrunkLevel(playerid) >= 2000 && GetPlayerDrunkLevel(playerid) < 10000)
				{
					format(string, sizeof(string), "Gracz %s jest pod wp�ywem alkoholu(ma�o).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				else if(PlayerDrunk[giveplayerid] >= 3 || GetPlayerDrunkLevel(playerid) > 10000)
				{
					format(string, sizeof(string), "Gracz %s jest pod wp�ywem alkoholu(du�o).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				else
				{
					format(string, sizeof(string), "Gracz %s jest trze�wy(alkohol).", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTRED, string);
				}
				format(string, sizeof(string), "* %s bada alkomatem %s", sendername, giveplayer);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
			{
				sendErrorMessage(playerid, "Gracz nie znajduje sie obok ciebie.");
			}
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jeste� policjantem, ani agentem FBI");
	}
	return 1;
}
