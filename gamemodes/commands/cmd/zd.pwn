//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ zd ]--------------------------------------------------//
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

YCMD:zd(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    new Veh = GetPlayerVehicleID(playerid);
	if(CheckPlayerPerm(playerid, PERM_TAXI) || PlayerInfo[playerid][pJob] == 10)
	{
		if(IsPlayerConnected(playerid))
		{
			if(PlayerInfo[playerid][pJob] == 10)
			{
				if(IS_KomunikacjaMiejsca(Veh))
				{
				    if(PlayerInfo[playerid][pDrzwibusazamkniete]==0)
				    {
						GetPlayerName(playerid, sendername, sizeof(sendername));
						format(string, sizeof(string), "* %s naciska guzik i powoli zamyka drzwi", sendername);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						SetTimerEx("ZamykanieDrzwi",4000,0,"d",playerid);
						GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~Trwa zamykanie drzwi...", 4000, 3);
					}
					else
					{
						sendErrorMessage(playerid, "Drzwi autobusu s� ju� zamkni�te !");
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie jeste� w autobusie Korporacji !");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie posiadasz 2 rangi !");
			}
			return 1;
		}
	}
	else
	{
	sendErrorMessage(playerid, "Nie jeste� z Korporacji Transportowej !");
	}
	return 1;
}
