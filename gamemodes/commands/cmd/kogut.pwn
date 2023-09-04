//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ kogut ]-------------------------------------------------//
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

YCMD:kogut(playerid, params[], help)
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));

	if(IsPlayerInAnyVehicle(playerid))
	{
	    new playerState = GetPlayerState(playerid);
        if(playerState == PLAYER_STATE_DRIVER || playerState == PLAYER_STATE_PASSENGER)
        {
            new veh = GetPlayerVehicleID(playerid);
		    if(IsAPolicja(playerid) || IsABOR(playerid))
		    {
		        if(GroupPlayerDutyRank(playerid) >= 1)
		        {
					if(IsAKogutCar(veh))
			        {
						if(OnDuty[playerid] > 0)
						{
					        if(VehicleUID[veh][vSiren] != 0)
					        {
							    DestroyDynamicObject(VehicleUID[veh][vSiren]);
							    VehicleUID[veh][vSiren] = 0;
           						format(string, sizeof(string), "* %s zdejmuje kogut z dachu i chowa.", sendername);
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					        }
					        else
					        {
							    PrzyczepKogut(playerid, veh);
								format(string, sizeof(string), "* %s przyczepia kogut na dach samochodu.", sendername);
								ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							}
							//sendErrorMessage(playerid, "OSTRZE�ENIE: Nadu�ywanie kogut�w skutkuje natychmiastowym wyrzuceniem z frakcji.");
						}
						else
						{
						    sendErrorMessage(playerid, "Nie jeste� na s�u�bie.");
						}
					}
					else
					{
					    sendErrorMessage(playerid, "Na tym poje�dzie nie mo�na przyczepi� koguta.");
			            return 1;
					}
                }
				else
				{
				    sendErrorMessage(playerid, "Potrzebujesz 1 lub wi�kszej rangi!");
     				return 1;
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie jeste� z PD!");
            	return 1;
			}
        }
		else
		{
		    sendErrorMessage(playerid, "Musisz by� kierowc�!");
        	return 1;
		}
	}
	else
	{
        sendErrorMessage(playerid, "Musisz by� w wozie");
        return 1;
	}
	return 1;
}
