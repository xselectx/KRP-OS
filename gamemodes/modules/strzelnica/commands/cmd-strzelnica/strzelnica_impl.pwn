//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                strzelnica                                                //
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
// Autor: renosk
// Data utworzenia: 02.05.2023

//------------------<[ Implementacja: ]>-------------------
command_strzelnica_Impl(playerid)
{
    #pragma unused playerid
    //mozna odkomentowac, aby umozliwic graczom kupowanie pozwolenia na strzelnice poprzez bota (ta sama zasada, co kupjedzenie)

    //przypisaæ koordy
    /*new org = -1;
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 305.0363,-128.1189,999.6016) && GetPlayerInterior(playerid) == ST_INT)
    {
        org = STRZELNICA_GROUP1;
        SetPVarInt(playerid, "strzelnica-org", org);
    }
    else
    {
        return sendErrorMessage(playerid, "Nie znajdujesz siê na strzelnicy!");
    }
    foreach(new i : Player)
    {
        if(OnDuty[i] < 1 || org == -1) continue;
        if(GetPlayerGroupUID(i, OnDuty[i]-1) != org) continue;
        if(IsPlayerPaused(i)) continue;

        return va_SendClientMessage(playerid, COLOR_RED, "Nie mo¿esz u¿yæ tej komendy, poniewa¿ ktoœ z biznesu strzelnicy jest na s³u¿bie! ID tej osoby: %s (%d)", GetNick(i), i);
    }
    if(st_getFreePlace() == -1)
        return sendErrorMessage(playerid, "Na strzelnicy aktualnie brak wolnych miejsc, wróæ póŸniej jak siê zwolni.");
    new default_price = ST_PRICEFORENTRY * 2;
    new weapons[256];

    format(weapons, sizeof(weapons),
    "Broñ\tCena za wstêp\n \
    {FFFFFF}Deagle\t{00FF00}%d{FFFFFF}$\n \
    9MM\t{00FF00}%d{FFFFFF}$\n \
    Pistolet z t³umikiem\t{00FF00}%d{FFFFFF}$\n \
    Shotgun\t{00FF00}%d{FFFFFF}$\n \
    M4\t{00FF00}%d{FFFFFF}$\n \
    AK-47\t{00FF00}%d{FFFFFF}$\n",
    floatround(default_price * 1.50),
    floatround(default_price * 1.30),
    floatround(default_price * 1.25),
    floatround(default_price * 1.60),
    floatround(default_price * 1.90),
    floatround(default_price * 1.95));
    DynamicGui_Init(playerid);
    DynamicGui_AddRow(playerid, WEAPON_DEAGLE, floatround(default_price * 1.50));
    DynamicGui_AddRow(playerid, WEAPON_COLT45, floatround(default_price * 1.30));
    DynamicGui_AddRow(playerid, WEAPON_SILENCED, floatround(default_price * 1.25));
    DynamicGui_AddRow(playerid, WEAPON_SHOTGUN, floatround(default_price * 1.60));
    DynamicGui_AddRow(playerid, WEAPON_M4, floatround(default_price * 1.90));
    DynamicGui_AddRow(playerid, WEAPON_AK47, floatround(default_price * 1.95));

    //Cena 2 razy wy¿sza gdy wstêp jest zakupowany poprzez komende
    ShowPlayerDialogEx(playerid, D_STWEAPON, DIALOG_STYLE_TABLIST_HEADERS, "Strzelnica - Wybór broni", weapons, "Dalej", "WyjdŸ");*/
    return 1;
}

//end