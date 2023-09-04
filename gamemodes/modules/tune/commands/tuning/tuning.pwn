//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   tuning                                                  //
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
#include "tuning_impl.pwn"

//-------<[ initialize ]>-------
command_tuning()
{
    new command = Command_GetID("tuning");

    //aliases
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:tuning(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Panel tuningu dla warsztatow");
        return 1;
    }
    //fetching params
    new giveplayerid = INVALID_PLAYER_ID;
    if(strlen(params) > 0)
    {
        if(sscanf(params, "r", giveplayerid))
        {
            sendTipMessage(playerid, "U¿yj /tuning [playerid/CzêœæNicku] ");
            return 1;
        }
        if(!IsPlayerConnected(giveplayerid))
        {
            sendErrorMessage(playerid, "Nie znaleziono gracza o nicku/id podanym w parametrze.");
            return 1;
        }
    }
    //command body
    return command_tuning_Impl(playerid, giveplayerid);
}