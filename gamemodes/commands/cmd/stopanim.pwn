//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ stopanim ]-----------------------------------------------//
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

YCMD:stopanim(playerid, params[], help)
{
	if(PlayerHeist[playerid][p_Heist] != -1)  
	{
		sendErrorMessage(playerid, "Nie mo�esz tego zrobi� podczas napadu.");
		return TogglePlayerControllable(playerid, 0);
	}
    if(IsPlayerConnected(playerid))
    {
        new Float:Velocity[3];
		GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
        if( (!IsPlayerInAnyVehicle(playerid) && Velocity[2] == 0) && (!IsPlayerCarryingBox(playerid)))
        {
			if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0)
			{
				return ShowPlayerInfoDialog(playerid, "Kotnik Role Play", "{FF542E}Jeste� ranny!\n{FFFFFF}Nie mo�esz zatrzyma� animacji.");
			}
	        ClearAnimations(playerid);
	        SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
	    }
	    else
	    {
	        sendTipMessageEx(playerid, COLOR_WHITE, "Nie mo�esz zatrzyma� animacji");
	    }
    }
    return 1;
}
