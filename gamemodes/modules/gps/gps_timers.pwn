//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                    gps                                                    //
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
	System GPS dla frakcji
*/

//

//-----------------<[ Timery: ]>-------------------

ptask UpdateGPS[1000](playerid)
{
	if(!TurnedGPS[playerid]) return 0;
	new frac = GetPlayerGroupUID(playerid, OnDuty[playerid]-1);
	if(frac < 1 || frac > MAX_GROUPS-1)
		return 0;
	if(!GPSTurned[frac])
		return 0;
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	foreach(new i : Player)
	{
		if(IsPlayerInGroup(i, frac))
		{
			if(!IsValidDynamicMapIcon(GPSIcon[i]))
				GPSIcon[i] = CreateDynamicMapIcon(x, y, z, GPS_MAPICON, GroupInfo[frac][g_Color], -1, -1, i, -1.0, MAPICON_GLOBAL);
			else
			{
				Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, GPSIcon[i], E_STREAMER_X, x);
				Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, GPSIcon[i], E_STREAMER_Y, y);
				Streamer_SetFloatData(STREAMER_TYPE_MAP_ICON, GPSIcon[i], E_STREAMER_Z, z);
			}
		}
	}
	return 1;
}

//end