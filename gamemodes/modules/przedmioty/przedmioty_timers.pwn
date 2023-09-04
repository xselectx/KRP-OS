//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: przedmioty ]------------------------------------------//
//----------------------------------------[ Autor: renosk ]----------------------------------------//

#include <YSI_Coding\y_timers>

//-----------------<[ Timery: ]>-------------------

timer ListNearItems[3000](playerid)
{
    new string[3048], oinfo[248];
    string = "#\tNazwa";
    DynamicGui_Init(playerid);
    foreach(new i : Items)
	{
		if(Item[i][i_OwnerType] != ITEM_OWNER_TYPE_DROPPED || !Item[i][i_Dropped]) continue;
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
		if(IsPlayerInRangeOfPoint(playerid, 2.2, Item[i][i_Pos][0], Item[i][i_Pos][1], Item[i][i_Pos][2]) && GetPlayerVirtualWorld(playerid) == Item[i][i_VW] && GetPlayerInterior(playerid) == Item[i][i_INT]) {
		    strcat(string, sprintf("\n%d\t%s%s x%d", i, Item[i][i_Name], oinfo, Item[i][i_Quantity]));
		    DynamicGui_AddRow(playerid, 1, i);
        }
	}
	if(strlen(string) < 13) return sendTipMessage(playerid, "Nie znaleziono ¿adnych przedmiotów w pobli¿u.");
	ShowPlayerDialogEx(playerid, D_ITEM_PICKUP, DIALOG_STYLE_TABLIST_HEADERS, "Przedmioty w pobli¿u", string, "Podnieœ", "Zamknij");
    return 1;
}
