//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------

stock GPS_Load(playerid)
{
	if(IsValidDynamicMapIcon(GPSIcon[playerid])) return 0;
	if(OnDuty[playerid] < 1) return 0; 
	new frac = GetPlayerGroupUID(playerid, OnDuty[playerid]-1);
	if(frac > 0 && frac < MAX_GROUPS-1)
	{
		if(GPSTurned[frac] == true)
		{
			new Float:x, Float:y, Float:z;
			foreach(new i : Player)
			{
				if(IsPlayerInGroup(i, frac) && TurnedGPS[i] == true)
				{
					GetPlayerPos(i, x, y, z);
					GPSIcon[i] = CreateDynamicMapIcon(x, y, z, GPS_MAPICON, GroupInfo[frac][g_Color], -1, -1, playerid, -1.0, MAPICON_GLOBAL);
					break;
				}
			}
		}
	}
	return 1;
}

//end