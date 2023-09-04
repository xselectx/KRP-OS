//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ zamek ]-------------------------------------------------//
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

YCMD:zamek(playerid, params[], help)
{
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 725.7198,-1439.3527,13.5391) ||
	IsPlayerInRangeOfPoint(playerid, 5.0, 734.0619, -1451.6720, 22.5920) ||
	IsPlayerInRangeOfPoint(playerid, 5.0, 725.5906, -1450.9875, 17.7069) ||
	IsPlayerInRangeOfPoint(playerid, 5.0, 722.0778, -1450.7183, 26.0396) ||
	IsPlayerInRangeOfPoint(playerid, 5.0, 735.2055, -1472.9760, 22.5920) ||
	IsPlayerInRangeOfPoint(playerid, 5.0, 736.3939, -1472.8465, 22.5920)) //LCN
    {
        if(CheckPlayerPerm(playerid, PERM_LCN))
        {
            new nick[MAX_PLAYER_NAME], string[64];
            GetPlayerName(playerid, nick, sizeof(nick));
	        format(string, sizeof(string), "* %s %s drzwi.", nick, (DoorInfo[FRAC_LCN][d_State]) ? ("zamyka") : ("otwiera"));
            ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            DoorInfo[FRAC_LCN][d_State] = (DoorInfo[FRAC_LCN][d_State]) ? false : true;
        }
    }
    else if(
    (IsPlayerInRangeOfPoint(playerid, 5.0, 2105.4844,-1806.6124,13.6504) && GetPlayerVirtualWorld(playerid) == 0) ||
    (IsPlayerInRangeOfPoint(playerid, 5.0, 2106.28, -1806.48, 13.6504) && GetPlayerVirtualWorld(playerid) == 5)) //AS Pizzeria
    {
        if(IsPlayerInGroup(playerid, 28))
        {
            new nick[MAX_PLAYER_NAME], string[64];
            GetPlayerName(playerid, nick, sizeof(nick));
	        format(string, sizeof(string), "* %s %s drzwi.", nick, (DoorInfo[28][d_State]) ? ("zamyka") : ("otwiera"));
            ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            DoorInfo[28][d_State] = (DoorInfo[28][d_State]) ? false : true;
        }
    }
    return 1;
}
