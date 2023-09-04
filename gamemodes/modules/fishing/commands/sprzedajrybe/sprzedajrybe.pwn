//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                sprzedajrybe                                               //
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
// Kod wygenerowany automatycznie narz�dziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN� NADPISANE PO WYWO�ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------
#include "sprzedajrybe_impl.pwn"

//-------<[ initialize ]>-------
command_sprzedajrybe()
{
    new command = Command_GetID("sprzedajrybe");

    //aliases
    Command_AddAlt(command, "sellfish");
    //Command_AddAlt(command, "sprzedajryby");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:sprzedajrybe(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Sprzedaje ryb� w skelpie 24/7.");
        return 1;
    }
    //fetching params
    new fishid;
    if(sscanf(params, "d", fishid))
    {
        sendTipMessage(playerid, "U�yj /sprzedajrybe [id ryby] ");
        return 1;
    }
    
    //command body
    return command_sprzedajrybe_Impl(playerid, fishid);
}

YCMD:sprzedajryby(playerid, params[])
{
    if (!PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))//centerpoint 24-7
    {
        SendClientMessage(playerid, COLOR_WHITE, "Ryby mo�esz sprzeda� tylko w 24/7!");
        return 1;
    } 
    if(FishGood[playerid] == 1)
    {
        SendPunishMessage(sprintf("AdmCmd: %s zostal zkickowany przez Admina: Marcepan_Marks, pow�d: teleport (ryby)", GetNickEx(playerid)), playerid);
        Log(punishmentLog, WARNING, "%s dosta� kicka od antycheata, pow�d: teleport (ryby)");
        KickEx(playerid);
        return 1;
    }
    SprzedajRyby(playerid);
    return 1;
}