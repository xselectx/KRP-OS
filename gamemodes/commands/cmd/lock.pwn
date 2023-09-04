//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ lock ]-------------------------------------------------//
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

YCMD:lock(playerid, params[], help)
{
    new newcar=0, Float:dis=2.75, Float:x, Float:y, Float:z, Float:currdist;
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        GetVehiclePos(i, x, y, z);
        if((currdist = GetPlayerDistanceFromPoint(playerid, x, y, z)) < dis)
        {
            dis = currdist;
            newcar = i;
        }
    }
    if(newcar != 0)
    {
        if(Car_GetOwnerType(newcar) == CAR_OWNER_GROUP) //grupy
        {
            if(IsPlayerInGroup(playerid, Car_GetOwner(newcar)))
            {
                Car_Lock(playerid, newcar);
            }
        }
	    else if(Car_GetOwnerType(newcar) == CAR_OWNER_FRACTION)// wszystkie auta frakcji
	    {
            if(IsPlayerInGroup(playerid, Car_GetOwner(newcar)))
            {
                Car_Lock(playerid, newcar);
            }
        }
        else if(Car_GetOwnerType(newcar) == CAR_OWNER_PLAYER)
        {
            if(IsCarOwner(playerid, newcar, true))
            {
                Car_Lock(playerid, newcar);
            }
        }
    }
    return 1;
}
