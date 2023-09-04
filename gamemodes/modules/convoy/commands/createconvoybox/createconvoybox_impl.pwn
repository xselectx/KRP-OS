//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              createconvoybox                                              //
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
// Data utworzenia: 20.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_createconvoybox_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] < 5000)
    {
        noAccessMessage(playerid);
        return 1;
    }

    new Float:x, Float:y, Float:z, Float:ang;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, Float:ang);

    new boxid;
    if(IsPlayerInAnyVehicle(playerid)) {
        boxid = DropBoxFromCar(GetPlayerVehicleID(playerid));
    } else {
        boxid = CreateBox(x, y, z-BOX_ONFOOT_Z_OFFSET, 0.0, 0.0, ang);
    }
    if(boxid == -1) return SendClientMessage(playerid, -1, "Brak miejsca");
    SendClientMessage(playerid, -1, sprintf("Stworzy�e� box o id %d", boxid));

    Log(adminLog, WARNING, "Admin %s stworzy� box konwojowy", 
        GetPlayerLogName(playerid)
    );
    return 1;
}

//end