//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ szturmowy ]-----------------------------------------------//
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

YCMD:szturmowy(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(IsAPolicja(playerid))
		{
			if (PlayerToPoint(3, playerid,255.3,77.4,1003.6)
			|| PlayerToPoint(3,playerid,266.7904,118.9303,1004.6172)
			|| PlayerToPoint(3,playerid,225.9369,157.1783,1003.0300)
			|| PlayerToPoint(5, playerid, 185.3000488281,-1571.0999755859,-54.5)
			|| PlayerToPoint(5, playerid, 1189.5999755859,-1574.6999511719,-54.5 )
			|| PlayerToPoint(10.0,playerid, 2515.0200, -2459.5896, 13.8187)
			|| PlayerToPoint(3,playerid, -1674.8365, 866.0356, -52.4141)//nowe komi by dywan
			|| PlayerToPoint(3.5, playerid, 597.1039,-1474.2688,80.4357))//nowe FBI by ubunteq
			{
				if(OnDuty[playerid] > 0 && DodatkiPD[playerid] == 0)
				{
					format(string, sizeof(string), "* %s wyci�ga z szafki i ubiera zestaw szturmowy.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	    		    //SetPlayerAttachedObject(playerid,1,19142,1,0.1,0.05,0.0,0.0,0.0,0.0,1.0,1.2);//Armour
					SetPlayerAttachedObject(playerid,2,19141,2,0.11,0.0,0.0,0.0,0.0,0.0);//Cask
					SetPlayerAttachedObject(playerid,3,18637,13,0.35,0.0,0.0,0.0,0.0,180.0);//Shield
					DodatkiPD[playerid] = 1;
				}
				else if(OnDuty[playerid] > 0 && DodatkiPD[playerid] == 1)
				{
					//RemovePlayerAttachedObject(playerid,1);
        			RemovePlayerAttachedObject(playerid,2);
       				RemovePlayerAttachedObject(playerid,3);
                	format(string, sizeof(string), "* %s �ci�ga z siebie zestaw szturmowy i chowa do szafki.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					DodatkiPD[playerid] = 0;
				}
				else
				{
				    sendTipMessage(playerid, "Nie jeste� na s�u�bie !");
				}
			}
			else
			{
				sendTipMessage(playerid, "Nie jeste� w szatni !");
				return 1;
			}
		}
        else
		{
			sendErrorMessage(playerid, "Nie jeste� ze s�u�b porz�dkowych !");
			return 1;
		}
	}
	return 1;
}
