//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ dr ]--------------------------------------------------//
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

YCMD:dr(playerid, params[], help)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
			if(IsARower(GetPlayerVehicleID(playerid)))
			{
				sendErrorMessage(playerid, "Rower nie ma deski rozdzielczej!");
				return 1;
			}
			ShowDeskaRozdzielcza(playerid);
		}
		else
		{
		    sendTipMessage(playerid, "Musisz by� kierowc� !");
        	return 1;
		}
	}
	else
	{
        sendTipMessage(playerid, "Musisz by� w wozie.");
        return 1;
	}
	return 1;
}