//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ tod ]--------------------------------------------------//
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

YCMD:tod(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new hour;
		if( sscanf(params, "d", hour))
		{
			sendTipMessage(playerid, "U�yj /tod [czas] (0-23)");
			return 1;
		}


		if (PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid))
		{
            SetWorldTime(hour);
            ServerTime = hour;
			
			format(string, sizeof(string), "Czas zmieniony na %d Godzine.", hour);
			BroadCast(COLOR_GRAD1, string);

            format(string, sizeof(string), "CMD_Info: /tod u�yte przez %s [%d]", GetNickEx(playerid), playerid);
            SendCommandLogMessage(string);
        	Log(adminLog, WARNING, "Admin %s u�y� /tod z warto�ci� %d", GetPlayerLogName(playerid), hour);
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
			foreach(new i : Player)//Je�eli gracze s� w intkach 
			{
				if(GetPlayerVirtualWorld(i) != 0 || GetPlayerInterior(i) != 0)
				{
					SetInteriorTimeAndWeather(i);
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
