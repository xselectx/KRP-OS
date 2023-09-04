//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                strzelnicawstep                                                //
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

//-------<[ command ]>-------

YCMD:strzelnicawstep(playerid, params[])
{
    new targetid, money;
    if(sscanf(params, "k<fix>d", targetid, money))
    {
        return sendTipMessage(playerid, "U¿yj: /strzelnicawstep [id gracza] [prowizja od 0$ do 70$]");
    }
    if(!GroupPlayerDutyPerm(playerid, PERM_STRZELNICA))
    {
        return noAccessMessage(playerid);
    }
    if(money < 0 || money > 70)
    {
        return sendTipMessage(playerid, "Prowizja od 0$ do 70$!");
    }
    if(!IsPlayerConnected(targetid))
    {
        return sendErrorMessage(playerid, "Gracz o podanym ID nie jest po³¹czony z serwerem.");
    }
    if(!OnDuty[playerid])
    {
        return sendErrorMessage(playerid, "Musisz byæ na duty!");
    }
    if(!IsPlayerNear(playerid, targetid))
    {
        return sendTipMessage(playerid, "Ten gracz nie jest obok Ciebie!");
    }
    if(stPlayer[targetid][stp_place] != -1)
    {
        return sendErrorMessage(playerid, "Ten gracz jest ju¿ na strzelnicy!");
    }
    if(st_getFreePlace() == -1)
        return sendErrorMessage(playerid, "Na strzelnicy aktualnie brak wolnych miejsc, musisz poczekaæ, a¿ siê zwolni.");

    new default_price = ST_PRICEFORENTRY;
    new weapons[256];

    format(weapons, sizeof(weapons),
    "Broñ\tCena za wstêp\n \
    {FFFFFF}Deagle\t{00FF00}%d{FFFFFF}$\n \
    9MM\t{00FF00}%d{FFFFFF}$\n \
    Pistolet z t³umikiem\t{00FF00}%d{FFFFFF}$\n \
    Shotgun\t{00FF00}%d{FFFFFF}$\n \
    M4\t{00FF00}%d{FFFFFF}$\n \
    AK-47\t{00FF00}%d{FFFFFF}$\n",
    floatround(default_price * 1.50 + money),
    floatround(default_price * 1.30 + money),
    floatround(default_price * 1.25 + money),
    floatround(default_price * 1.60 + money),
    floatround(default_price * 1.90 + money),
    floatround(default_price * 1.95 + money));
    DynamicGui_Init(targetid);
    DynamicGui_AddRow(targetid, WEAPON_DEAGLE, floatround(default_price * 1.50) + money);
    DynamicGui_AddRow(targetid, WEAPON_COLT45, floatround(default_price * 1.30) + money);
    DynamicGui_AddRow(targetid, WEAPON_SILENCED, floatround(default_price * 1.25) + money);
    DynamicGui_AddRow(targetid, WEAPON_SHOTGUN, floatround(default_price * 1.60) + money);
    DynamicGui_AddRow(targetid, WEAPON_M4, floatround(default_price * 1.90) + money);
    DynamicGui_AddRow(targetid, WEAPON_AK47, floatround(default_price * 1.95) + money);

    va_SendClientMessage(targetid, COLOR_PANICRED, "UWAGA: Sprzedaj¹cy pobiera %d$ prowizji.", money);
    SetPVarInt(targetid, "st-seller", playerid);
    SetPVarInt(targetid, "st-money", money);
    SetPVarInt(targetid, "strzelnica-org", GetPlayerGroupUID(playerid, OnDuty[playerid]-1));
    ShowPlayerDialogEx(targetid, D_STWEAPON, DIALOG_STYLE_TABLIST_HEADERS, "Strzelnica - Wybór broni", weapons, "Dalej", "WyjdŸ");
    return 1;
}