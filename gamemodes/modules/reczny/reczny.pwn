//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  reczny                                                //
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
// Autor: AnakinEU
// Data utworzenia: 01.11.2021
//Opis:
/*
	Hamulec reczny
*/

//

//-----------------<[ Funkcje: ]>-------------------
new Float:handbrake_pos[MAX_VEHICLES][4];
new bool:handbrake[MAX_VEHICLES] = {false, ...};



CMD:reczny(playerid, params[])
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		if(handbrake[vehicleid] == false)
		{
			GameTextForPlayer(playerid,"~r~RECZNY WL",3000,6);
			GetVehiclePos(vehicleid, handbrake_pos[vehicleid][0], handbrake_pos[vehicleid][1], handbrake_pos[vehicleid][2]);
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, 0, 0, alarm, doors, bonnet, boot, objective); //wylaczanie silnika
			GetVehicleZAngle(vehicleid, handbrake_pos[vehicleid][3]);
			SetVehicleVelocity(vehicleid, 0, 0, 0);
			handbrake[vehicleid] = true;
		}
		else if(handbrake[vehicleid] == true)
		{
			GameTextForPlayer(playerid,"~r~RECZNY WYL",3000,6);
			handbrake[vehicleid] = false;
			handbrake_pos[vehicleid][0] = 0.0;
			handbrake_pos[vehicleid][1] = 0.0;
			handbrake_pos[vehicleid][2] = 0.0;
			handbrake_pos[vehicleid][3] = 0.0;
		}
	}
    return 1;
}


stock OnUnoccupiedVehicleUpdateReczny(vehicleid)
{
	if(handbrake[vehicleid] == true)
	{
		SetVehiclePos(vehicleid, handbrake_pos[vehicleid][0], handbrake_pos[vehicleid][1], handbrake_pos[vehicleid][2]);
		SetVehicleZAngle(vehicleid, handbrake_pos[vehicleid][3]);
	}
	return 1;
}
//end