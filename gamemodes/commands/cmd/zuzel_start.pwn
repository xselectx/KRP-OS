//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ zuzel_start ]----------------------------------------------//
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

YCMD:zuzel_start(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		if (PlayerInfo[playerid][pAdmin] >= 5 || CheckPlayerPerm(playerid, PERM_TAXI) && GroupPlayerDutyRank(playerid) >= 2)
		{
		    if(wyscigz == 0)
		    {
		    	StartZuzling();
		    	wyscigz = 1;
				ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, "Wy�cig �u�lowy rozpocz�ty!");
				SetTimerEx("TablicaWynikow",30000,0,"d",playerid);
				SendClientMessage(playerid, COLOR_GRAD2, "Zuzel start");
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GRAD2, "Wy�cig ju� jest, wpisz /zuzel_stop aby go zatrzyma�");
			}
		}
	}
	return 1;
}
