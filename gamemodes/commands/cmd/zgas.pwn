//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ zgas ]-------------------------------------------------//
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

YCMD:zgas(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new playerState = GetPlayerState(playerid);
        if(playerState == PLAYER_STATE_DRIVER)
        {
	        if(gPlayerLogged[playerid] == 0)
	        {
	            return 1;
	        }
			
			if(IsARower(GetPlayerVehicleID(playerid)))
			{
				sendErrorMessage(playerid, "Rower nie ma silnika!");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s wyciaga kluczyk ze stacyjki i gasi auto.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(GetPlayerVehicleID(playerid),engine, lights ,alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(GetPlayerVehicleID(playerid) , VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
			//PlayerAC[playerid][acCarEngine_Tick] = gettime()+70;
		}
		else
		{
		    sendErrorMessage(playerid, "Nie jeste� kierowc�!");
            return 1;
		}
	}
	return 1;
}
