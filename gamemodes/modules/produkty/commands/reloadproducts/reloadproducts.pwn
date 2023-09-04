//------------------------------------------<< Generated source >>-------------------------------------------//
//                                               reloadproducts                                              //
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "reloadproducts_impl.pwn"

//-------<[ initialize ]>-------
command_reloadproducts()
{
    new command = Command_GetID("reloadproducts");

    //aliases
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:reloadproducts(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Prze³adowuje produkty");
        return 1;
    }

    if(PlayerInfo[playerid][pAdmin] < 5000) return noAccessMessage(playerid);
    
    
    //command body
    return command_reloadproducts_Impl(playerid);
}