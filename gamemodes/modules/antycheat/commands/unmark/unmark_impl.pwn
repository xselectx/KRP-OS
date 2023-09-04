//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   unmark                                                  //
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
// Data utworzenia: 12.05.2020


//

//------------------<[ Implementacja: ]>-------------------
command_unmark_Impl(playerid, giveplayerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        UnmarkPotentialCheater(giveplayerid);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Usun��e� gracza %s z listy potencjalnych cziter�w", GetNickEx(giveplayerid)));
        Log(adminLog, WARNING, "Admin %s usun�� gracza %s z listy potencjalnych cziter�w.", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid));
    } 
    else noAccessMessage(playerid);
    return 1;
}

//end