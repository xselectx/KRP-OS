//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ przedmioty ]-----------------------------------------------//
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

#include <YSI_Coding\y_timers>

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:przedmioty(playerid, params[], help)
{
    if(!gPlayerLogged[playerid]) return 0;
	if(Kajdanki_JestemSkuty[playerid] == 1)
		return sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tej komendy bêd¹c skutym!");
	if(PlayerInfo[playerid][pJailed] != 0)
		return sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tej komendy bêd¹c w wiêzieniu!"); 
	if(PlayerInfo[playerid][pBW] > 0 || PlayerInfo[playerid][pInjury] > 0)
		return sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tej komendy podczas BW!");
    if(!isnull(params)) 
	{
		if(!strcmp(params, "podnies", true) || !strcmp(params, "podnieœ", true) || !strcmp(params, "szukaj", true))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Musisz byæ pieszo.");
            ProxDetector(10.0, playerid, sprintf("* %s rozgl¹da siê za przedmiotami", GetNick(playerid)), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			ApplyAnimation(playerid, "PED", "XPRESSscratch", 4.1, 0, 0, 0, 0, 3000, 1);
			defer ListNearItems(playerid);
			return 1;
		}
		new itemid = FindItemByName(playerid, params);
		if(itemid != -1)
			return Item_Use(playerid, itemid);
	}
    if(Iter_Count(PlayerItems[playerid]) < 1) return sendTipMessage(playerid, "Nie posiadasz ¿adnych przedmiotów.");
	new items[4048], count = 0, oinfo[248];
	items = "#\tNazwa\tInfo";
	foreach(new i : PlayerItems[playerid]) {
		format(oinfo, sizeof oinfo, "");
		switch(Item[i][i_ItemType]) //opisy przedmiotów
		{
			case ITEM_TYPE_WEAPON:
			{
				if(Item[i][i_ValueSecret] == 1)
					format(oinfo, sizeof oinfo, " (legalne)");
				else
					format(oinfo, sizeof oinfo, " (nielegalne)");			
			}
		}
		strcat(items, sprintf("\n%d\t{%s}%s%s x%d\t{000000}(%d, %d)", i, (Item[i][i_Used]) ? ("f5c242") : ("196e75"), Item[i][i_Name], oinfo, Item[i][i_Quantity], Item[i][i_Value1], Item[i][i_Value2]));
		if(Item[i][i_ValueSecret] == ITEM_NOT_COUNT)
			count += 1;
		else 
			count += Item[i][i_Quantity];
	}
	ShowPlayerDialogEx(playerid, D_ITEMS, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Przedmioty (%d/%d)", count, (IsPlayerPremiumOld(playerid)) ? (MAX_ITEM_LIMIT_PREMIUM) : (MAX_ITEM_LIMIT)), items, "Dalej", "Zamknij");
    return 1;
}