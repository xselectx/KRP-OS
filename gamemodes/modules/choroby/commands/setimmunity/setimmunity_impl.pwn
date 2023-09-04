//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                setimmunity                                                //
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
// Autor: mrucznik
// Data utworzenia: 13.05.2020


//

//------------------<[ Implementacja: ]>-------------------
command_setimmunity_Impl(playerid, giveplayerid, immunity)
{
    if(PlayerInfo[playerid][pAdmin] < 1000)
    {
        noAccessMessage(playerid);
        return 1;
    }

    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Ustawi�e� odporno�� gracza %s na %d", GetNickEx(giveplayerid), immunity));
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Admin %s ustawi� twoj� odporno�� na %d", GetNickEx(playerid), immunity));
    Log(adminLog, WARNING, "Admin %s ustawi� odporno�� gracza %s na %d", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), immunity);
    SetPlayerImmunity(giveplayerid, immunity);
    return 1;
}

//end