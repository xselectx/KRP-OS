//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ KickEx_all ]----------------------------------------------//
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

YCMD:kickall(playerid, params[], help)
{
	if(IsAHeadAdmin(playerid))
	{
		new string[64];
		format(string, sizeof(string), "Admin %s (id:%d) zkickowal wszystkich graczy",GetNickEx(playerid), playerid);
		SendClientMessageToAll(COLOR_RED, string);
		Log(adminLog, WARNING, "Admin %s zkickowa� wszystkich graczy", GetPlayerLogName(playerid));   

		foreach(new i : Player)
		{
			SendClientMessage(playerid, COLOR_WHITE,"*$AdmCmd$*: zkickowales wszystkich graczy!");
			KickEx(i);
		}
	}
    return 1;
}
