//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ fixveh ]------------------------------------------------//
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

YCMD:fixveh(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 1 || IsAScripter(playerid) || PlayerInfo[playerid][pNewAP] >= 1)
		{
			if(IsPlayerInAnyVehicle(playerid))
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new vuid = VehicleUID[vehicleid][vUID];
				SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
				RepairVehicle(GetPlayerVehicleID(playerid));
				CarData[vuid][c_HP] = 1000.0;
				
				new string[128];
				format(string, sizeof(string), "AdmCmd: %s naprawi� auto %s (%d)[%d].", GetNickEx(playerid), VehicleNames[GetVehicleModel(vehicleid)-400], vehicleid, vuid);
				SendMessageToAdmin(string, COLOR_RED);
				Log(adminLog, WARNING, "Admin %s u�y� /fixveh dla pojazdzu %s", GetPlayerLogName(playerid), GetVehicleLogName(vehicleid));
				if(GetPlayerAdminDutyStatus(playerid) == 1)
				{
					iloscInne[playerid] = iloscInne[playerid]+1;
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
