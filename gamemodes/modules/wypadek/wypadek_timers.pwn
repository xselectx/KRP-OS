//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                  wypadek                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 11.06.2019
//Opis:
/*
	System wypadk�w. Dawny filterscript scanhp.
*/

//

//-----------------<[ Timery: ]>-------------------
public scanhp(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return 1;
    new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInConvoyCar(playerid)) return 1;
	GetVehicleHealth(vehicleid,newhealth[playerid]);
	if(oldhealth[playerid] > (newhealth[playerid] + SCAN_HP_VALUE))
	{
	    if(IsPlayerInRangeOfPoint(playerid, 7.0, 2064.0703,-1831.3167,13.3853) || IsPlayerInRangeOfPoint(playerid, 7.0, 1024.8514,-1022.2302,31.9395) || IsPlayerInRangeOfPoint(playerid, 7.0, 486.9398,-1742.4130,10.9594) || IsPlayerInRangeOfPoint(playerid, 7.0, -1904.2325,285.3743,40.8843)  || IsPlayerInRangeOfPoint(playerid, 7.0, 720.0876,-458.3574,16.3359))
	    {
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Pojazd naprawiony!");
	    }
	    else
		{
			if(WszedlDoPojazdu[playerid] == 0 && !IsABike(vehicleid) && pasy[playerid] == 1)
			{
				if(oldhealth[playerid] > (newhealth[playerid] + 150))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					new Float:zyciewypadku;
					GetPlayerName(playerid, nick, sizeof(nick));
					GetPlayerHealth(playerid, zyciewypadku);
					SetPlayerHealth(playerid, zyciewypadku-7);
					format(string, sizeof(string), "* %s uderzy� g�ow� w kierownice mimo zapi�tych pas�w", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Ale przywali�e�, szcz�cie �e mia�e� zapi�te pasy!");
				}
				else if(oldhealth[playerid] > (newhealth[playerid] + SCAN_HP_VALUE+50))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					GetPlayerName(playerid, nick, sizeof(nick));
					format(string, sizeof(string), "* Pasy zadzia�a�y i %s nie dozna� powa�nych obra�e� (( %s ))", nick, nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kolejna st�uczka, mia�e� zapi�te pasy i nic ci si� nie sta�o!");
				}
			}
			else if(WszedlDoPojazdu[playerid] == 0 && IsABike(vehicleid) && kask[playerid] == 1)
			{
				if(oldhealth[playerid] > (newhealth[playerid] + 150))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					new Float:zyciewypadku;
					GetPlayerName(playerid, nick, sizeof(nick));
					GetPlayerHealth(playerid, zyciewypadku);
					SetPlayerHealth(playerid, zyciewypadku-7);
					format(string, sizeof(string), "* %s uderzy� kaskiem w kierownic�.", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Ale przywali�e�, szcz�cie �e mia�e� kask na g�owie!");
				}
				else if(oldhealth[playerid] > (newhealth[playerid] + SCAN_HP_VALUE+50))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					GetPlayerName(playerid, nick, sizeof(nick));
					format(string, sizeof(string), "* Kask uratowa� %s i nie dozna� powa�nych obra�e�. (( %s ))", nick, nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kolejna st�uczka, mia�e� kask na g�owie i nic ci si� nie sta�o!");
				}
			}
			else
			{
				if(WszedlDoPojazdu[playerid] == 0)
				{
					if(oldhealth[playerid] > (newhealth[playerid] + SCAN_HP_VALUE+30))
					{
						new nick[MAX_PLAYER_NAME];
						new string[256];
						new Float:zyciewypadku;
						GetPlayerName(playerid, nick, sizeof(nick));
						GetPlayerHealth(playerid, zyciewypadku);
						SetPlayerHealth(playerid, zyciewypadku-7);
						format(string, sizeof(string), "* %s uderzy� g�ow� w kierownic�. (( %s ))", nick, nick);
						ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
						if(IsABike(GetPlayerVehicleID(playerid)))
						{
							SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kolejna st�uczka, aby unikn�� obra�e� wpisz /kask!");
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kolejna st�uczka, aby unikn�� obra�e� wpisz /zp!");
						}
					}
				}
			}
		}
	}
	GetVehicleHealth(vehicleid,oldhealth[playerid]);
	return 1;
}

public EnterCar(playerid)
{
	WszedlDoPojazdu[playerid] = 0;
}

//end