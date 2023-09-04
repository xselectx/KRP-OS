//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ lockint ]------------------------------------------------//
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

YCMD:lockint(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			new model = GetVehicleModel(vehicleid);
			if(IsAInteriorVehicle(model))
			{
				if(Car_GetOwnerType(vehicleid) == CAR_OWNER_GROUP) //grupy
				{
					if(!IsPlayerInGroup(playerid, Car_GetOwner(vehicleid)))
					{
						return sendTipMessageEx(playerid, COLOR_LIGHTGREEN, "Ten pojazd nie nale�y do Twojej grupy!");
					}
				}
                if(!(IsCarOwner(playerid, vehicleid) || (Car_GetOwnerType(vehicleid) == CAR_OWNER_FRACTION && IsPlayerInGroup(playerid, Car_GetOwner(vehicleid)))))
				{
					return sendTipMessageEx(playerid, COLOR_LIGHTGREEN, "Ten pojazd nie nale�y do Ciebie!");
				}
				
				if(VehicleUID[vehicleid][vIntLock] == 0)
				{
				    VehicleUID[vehicleid][vIntLock] = 1;
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Otworzy�e� interior");
				}
				else
				{
				    VehicleUID[vehicleid][vIntLock] = 0;
					sendTipMessageEx(playerid, COLOR_LIGHTBLUE, "Zamkn��e� interior");
				}
		    }
		    else
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Ten w�z nie ma interioru");
		    }
	   	}
	   	else
	   	{
	   	    sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� w wozie");
	   	}
	}
	return 1;
}
