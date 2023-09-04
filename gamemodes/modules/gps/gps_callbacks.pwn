//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                    gps                                                   //
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
// Autor: renosk
// Data utworzenia: 28.06.2021
//Opis:
/*
	
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnPlayerDisconnect(playerid)
{
    if(!gPlayerLogged[playerid])
        return 0;
    if(TurnedGPS[playerid] == true)
    {
        new frac = GetPlayerGroupUID(playerid, OnDuty[playerid]-1);
        if(frac > 0 && frac < MAX_FRAKCJE-1)
        {
            GPSTurned[frac] = false;
            foreach(new i : Player)
            {
                if(IsPlayerInGroup(playerid, frac))
                    DestroyDynamicMapIcon(GPSIcon[i]);
            }
            SendRadioMessage(frac, COLOR_BLUE, sprintf("%s wyszed³ z gry. Frakcyjny GPS zosta³ wy³¹czony!", GetNick(playerid)));
        }
    }
    DestroyDynamicMapIcon(GPSIcon[playerid]);
    GPSIcon[playerid] = -1;
    TurnedGPS[playerid] = false;
    return 1;
}