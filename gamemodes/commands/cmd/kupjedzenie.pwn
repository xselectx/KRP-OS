//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ adajrange ]-----------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*

*/

YCMD:kupjedzenie(playerid, params[], help)
{
    new org = -1;
    if(IsPlayerInRangeOfPoint(playerid, 5.0, 2114.50, -1805.80, 13.61) && GetPlayerVirtualWorld(playerid) == 5) //pizzeria idlewood
        org = 28;
    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 369.67, -6.65, 1001.85) && GetPlayerInterior(playerid) == 9) //cluckinbell
        org = 53;
    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 392.8683,-1896.6530,7.9687) && GetPlayerVirtualWorld(playerid) == 18) //Cowboy Bar
        org = 57;
    else if(IsPlayerInRangeOfPoint(playerid, 5.0, 875.38, -1343.13, 13.50) && GetPlayerVirtualWorld(playerid) == 1) //Mexican Food
        org = 57;
    else
        return sendErrorMessage(playerid, "Nie znajdujesz siê w restauracji!");
    foreach(new i : Player)
    {
        if(IsPlayerPaused(i)) continue;
        else if(org == -1 || !OnDuty[i]) continue;
        //else if(GetPlayerGroupUID(i, OnDuty[i]-1) != org) continue;
        else if(!GroupPlayerDutyPerm(i, PERM_RESTAURANT)) continue;
        else
            return va_SendClientMessage(playerid, COLOR_RED, "Nie mo¿esz u¿yæ tej komendy, poniewa¿ ktoœ z restauracji jest na s³u¿bie! ID tej osoby: %s (%d)", GetNick(i), i);
    }
    new string[456];
    string = "Typ\tNazwa\tCena\tNajedzenie";
    DynamicGui_Init(playerid);
    for(new i = 0; i < sizeof botProducts; i++)
    {
        if(botProducts[i][_b_Org] != org) continue;
        strcat(string, sprintf("\n%s\t%s\t$%d\t%d%%", ItemTypes[botProducts[i][_b_ItemType]], botProducts[i][_b_Name], botProducts[i][_b_Price], botProducts[i][_b_Value2]));
        DynamicGui_AddRow(playerid, i);
    }
    ShowPlayerDialogEx(playerid, D_RESTAURANT_BOT_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Restauracja", string, "Kup", "Zamknij");
    return 1;
}