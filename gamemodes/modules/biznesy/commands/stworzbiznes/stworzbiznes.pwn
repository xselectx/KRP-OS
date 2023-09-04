//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                stworzbiznes                                               //
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
#include "stworzbiznes_impl.pwn"

//-------<[ initialize ]>-------
command_stworzbiznes()
{
    new command = Command_GetID("stworzbiznes");

    //aliases
    Command_AddAlt(command, "stworzbiz");
    Command_AddAlt(command, "createbiz");
    Command_AddAlt(command, "createbusiness");
    

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:stworzbiznes(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda do tworzenia biznesu");
        return 1;
    }
    
    
    //command body
    return command_stworzbiznes_Impl(playerid);
}

YCMD:setbiznes(playerid, params[])
{
    if(!IsAHeadAdmin(playerid)) return noAccessMessage(playerid);
    new id, opt1[64], opt2[128];
    if(sscanf(params, "ds[64]S()[128]", id, opt1, opt2))
        return sendTipMessage(playerid, "U¿yj: /setbiznes ID [maxmoney | cena]");
    if(id < 1) return 0;
    switch(YHash(opt1))
    {
        case _H<maxmoney>:
        {
            Business[id][b_maxMoney] = strval(opt2);
        }
        case _H<cena>:
        {
            Business[id][b_cost] = strval(opt2);
        }
    }
    return 1;
}