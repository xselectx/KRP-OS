//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    logi                                                   //
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
// Data utworzenia: 04.05.2019
//Opis:
/*
	Narz�dzia do obs�ugi log�w.
*/

//

//-----------------<[ Funkcje: ]>-------------------
GetPlayerLogName(playerid)
{
    if(IsPlayerConnected(playerid) && gPlayerLogged[playerid]) {
        safe_return sprintf("{Player: %s[%d]}", GetNickEx(playerid), PlayerInfo[playerid][pUID]);
    } 
    safe_return sprintf("{Player: %s}", GetNickEx(playerid));
}

GetWeaponLogName(weapon, ammo=-1)
{
    new gunname[32];
    GetWeaponName(weapon, gunname, sizeof(gunname));
    if(ammo == -1)
    {
        safe_return sprintf("{Weapon: %s[id: %d]}", gunname, weapon);
    }
    else
    {
        safe_return sprintf("{Weapon: %s[id: %d, ammo: %d]}", gunname, weapon, ammo);
    }
}

GetVehicleLogName(vehicleid)
{
    safe_return sprintf("{Vehicle: %s[%d]}", VehicleNames[GetVehicleModel(vehicleid)-400], CarData[VehicleUID[vehicleid][vUID]][c_UID]);
}

GetCarDataLogName(cardata)
{
    safe_return sprintf("{Vehicle: %s[%d]}", VehicleNames[CarData[cardata][c_Model]-400], CarData[cardata][c_UID]);
}

GetHouseLogName(house)
{
    safe_return sprintf("{House: %d}", house);
}

GetBusinessLogName(business)
{
    safe_return sprintf("{Business: %s[%d]}", Business[business][b_Name], business);
}

GetGraffitiLogText(graffiti)
{
    safe_return sprintf("{Graffiti: [%d]:%s}", graffiti, GraffitiInfo[graffiti][grafText]);
}

GetGroupLogName(group)
{
    safe_return sprintf("{Group: %s[%d]}", GroupInfo[group][g_Name], group);
}

GetItemLogName(item)
{
    safe_return sprintf("{Item: %s[%d]}", Item[item][i_Name], Item[item][i_UID]);
}

//end