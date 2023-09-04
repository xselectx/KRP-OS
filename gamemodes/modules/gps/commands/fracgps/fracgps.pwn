//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                  fracgps                                                  //
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
#include "fracgps_impl.pwn"

//-------<[ initialize ]>-------
command_fracgps()
{
    new command = Command_GetID("fracgps");

    //aliases
    Command_AddAlt(command, "fgps");
    

    //permissions
    Group_SetCommand(Group_GetID("frakcja_LSPD"), command, true);
    Group_SetCommand(Group_GetID("frakcja_FBI"), command, true);
    Group_SetCommand(Group_GetID("frakcja_SASP"), command, true);
    Group_SetCommand(Group_GetID("frakcja_LSMC"), command, true);
    Group_SetCommand(Group_GetID("frakcja_USSS"), command, true);
    Group_SetCommand(Group_GetID("frakcja_HA"), command, true);
    Group_SetCommand(Group_GetID("frakcja_SAN"), command, true);
    Group_SetCommand(Group_GetID("frakcja_KT"), command, true);
    Group_SetCommand(Group_GetID("frakcja_GOV"), command, true);
    Group_SetCommand(Group_GetID("frakcja_LSFD"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:fracgps(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "W³¹cza GPS dla frakcji");
        return 1;
    }
    
    
    //command body
    return command_fracgps_Impl(playerid);
}