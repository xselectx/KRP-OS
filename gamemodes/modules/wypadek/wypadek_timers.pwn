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
	System wypadków. Dawny filterscript scanhp.
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
					format(string, sizeof(string), "* %s uderzy³ g³ow¹ w kierownice mimo zapiêtych pasów", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Ale przywali³eœ, szczêœcie ¿e mia³eœ zapiête pasy!");
				}
				else if(oldhealth[playerid] > (newhealth[playerid] + SCAN_HP_VALUE+50))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					GetPlayerName(playerid, nick, sizeof(nick));
					format(string, sizeof(string), "* Pasy zadzia³a³y i %s nie dozna³ powa¿nych obra¿eñ (( %s ))", nick, nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kolejna st³uczka, mia³eœ zapiête pasy i nic ci siê nie sta³o!");
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
					format(string, sizeof(string), "* %s uderzy³ kaskiem w kierownicê.", nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Ale przywali³eœ, szczêœcie ¿e mia³eœ kask na g³owie!");
				}
				else if(oldhealth[playerid] > (newhealth[playerid] + SCAN_HP_VALUE+50))
				{
					new nick[MAX_PLAYER_NAME];
					new string[256];
					GetPlayerName(playerid, nick, sizeof(nick));
					format(string, sizeof(string), "* Kask uratowa³ %s i nie dozna³ powa¿nych obra¿eñ. (( %s ))", nick, nick);
					ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kolejna st³uczka, mia³eœ kask na g³owie i nic ci siê nie sta³o!");
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
						format(string, sizeof(string), "* %s uderzy³ g³ow¹ w kierownicê. (( %s ))", nick, nick);
						ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
						if(IsABike(GetPlayerVehicleID(playerid)))
						{
							SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kolejna st³uczka, aby unikn¹æ obra¿eñ wpisz /kask!");
						}
						else
						{
							SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kolejna st³uczka, aby unikn¹æ obra¿eñ wpisz /zp!");
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