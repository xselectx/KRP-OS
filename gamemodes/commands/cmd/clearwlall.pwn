//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ clearwlall ]----------------------------------------------//
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

YCMD:clearwlall(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pAdmin] >= 1000)
		{
			foreach(new i : Player)
			{
				PoziomPoszukiwania[i] = 0;
				PlayerInfo[i][pWL] = 0;
				SetPlayerWantedLevel(i, 0);
			}
			format(string, sizeof(string), "Admin %s wyczy�ci� wszystkim wanted level", GetNickEx(playerid));
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
