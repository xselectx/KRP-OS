//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ podloz ]------------------------------------------------//
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
Komenda od podnoszenia paczki magazynier	
*/


// Notatki skryptera:
/*
	
*/


YCMD:sprzedaj(playerid, params[])
{
	if(Kradnie[playerid] == 0)
		return SendClientMessage(playerid, COLOR_BIALY,"[Szmugler] Nie masz paczki, nie mozesz niczego sprzedac.");
	if(!IsAPrzestepca(playerid, 0))
		return SendClientMessage(playerid, COLOR_BIALY, "[Szmugler] Musisz byæ z organizacji przestêpczej");
	if(!IsPlayerInRangeOfPoint(playerid, 3, 2329.02, -1000.98, 60.02))
	{
		SendClientMessage(playerid,COLOR_BIALY,"[Szmugler] Nie jestes u Ralpha Collinsa albo on Ciebie nie widzi.");
		return 1;
	}
	if(ACSzmugler[playerid] >= gettime())
	{
		new string[128];
		format(string, sizeof(string), "AdmWarn: %s[%d] <- Cheater, Teleportation during smuggler work %ds", GetNick(playerid), playerid, (gettime() + 45) - ACSzmugler[playerid]);
		SendAdminMessage(COLOR_YELLOW, string);	
		printf("[teleport][cheats] Cheater, Teleportation during smuggler work %ds", (gettime() + 45) - ACSzmugler[playerid]);
		ShowPlayerDialogEx(playerid, 10101, DIALOG_STYLE_MSGBOX, "Cheater", "Cheater, Teleportation during smuggler work", "OK", "");
        KickEx(playerid);
	}
	ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.1,0,1,1,0,1000,1);
	Kradnie[playerid] = 0;
	OkradanieTira[playerid] = 0;
	ACSzmugler[playerid] = 0;
	DajKaseDone(playerid, PRICE_SZMUGLER);
	SendClientMessage(playerid, COLOR_BIALY, "Ralph_Collins mówi: Yo' Dziêki ziomek za takie rzeczy! Trzymaj, to dla Ciebie.");
	SendClientMessage(playerid, COLOR_GREEN, "Dosta³eœ od Ralpha_Collinsa do rêki "#PRICE_SZMUGLER"$.");
	Item_Add("Zegarek", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_ZEGAREK, 0, 0, true, playerid, 1);
	Item_Add("Lancuszek", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_LANCUSZEK, 0, 0, true, playerid, 2);
	Item_Add("Materia³y", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MATS, 0, 0, true, playerid, 200, ITEM_NOT_COUNT);
	RemovePlayerAttachedObject(playerid, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}
