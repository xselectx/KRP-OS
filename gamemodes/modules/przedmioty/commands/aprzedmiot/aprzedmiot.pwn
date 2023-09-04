//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 aprzedmiot                                                //
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
#include "aprzedmiot_impl.pwn"

//-------<[ initialize ]>-------
command_aprzedmiot()
{
    new command = Command_GetID("aprzedmiot");

    //aliases
    Command_AddAlt(command, "ap");
    

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:aprzedmiot(playerid, params[], help)
{
    if(!PlayerInfo[playerid][pAdmin]) return noAccessMessage(playerid);
    if (help)
    {
        sendTipMessage(playerid, "Panel przedmiotów dla administratora");
        return 1;
    }
    //fetching params
    new opt1[64], opt2[64];
    if(sscanf(params, "s[64]S()[64]", opt1, opt2))
    {
        sendTipMessage(playerid, "U¿yj /aprzedmiot [stworz, usun, usun_uid, typy, clear3dtext]");
        return 1;
    }
    
    //command body
    return command_aprzedmiot_Impl(playerid, opt1, opt2);
}