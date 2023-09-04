//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  atuning                                                  //
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
#include "atuning_impl.pwn"

//-------<[ initialize ]>-------
command_atuning()
{
    new command = Command_GetID("atuning");

    //aliases
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:atuning(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Panel tuningu dla administratora");
        return 1;
    }
    //fetching params
    //new vehicleid;
    //if(sscanf(params, "d", vehicleid))
    //{
    //    sendTipMessage(playerid, "U¿yj /atuning [ID pojazdu] ");
    //    return 1;
    //}
    
    //command body
    return command_atuning_Impl(playerid, params);
}