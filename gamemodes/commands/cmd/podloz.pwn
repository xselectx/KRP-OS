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


YCMD:podloz(playerid, params[])
{
	if(MaPaczke[playerid] == 0) { SendClientMessage(playerid, COLOR_BIALY,"[Magazynier] Nie masz paczki, nie mozesz jej odlozyc."); return 1; }
	if(!IsPlayerInRangeOfPoint(playerid, 3, 2147.58, -2257.88, 13.30))
	{
		SendClientMessage(playerid,COLOR_BIALY,"[Magazynier] Nie jestes na miejscu oddawania paczki.");
		return 1;
	}
	if(ACMagazynier[playerid] >= gettime())
	{
		new string[128];
		format(string, sizeof(string), "[KICK]AdmWarn: %s[%d] <- Cheater, Teleportation during warehouse work %ds", GetNick(playerid), playerid, (gettime() + 10) - ACMagazynier[playerid]);
		SendAdminMessage(COLOR_YELLOW, string);	
		printf("[KICK][teleport][cheats] Cheater, Teleportation during warehouse work %ds", (gettime() + 10) - ACMagazynier[playerid]);
		ShowPlayerDialogEx(playerid, 10101, DIALOG_STYLE_MSGBOX, "BAN", "Cheater, Teleportation during warehouse work", "OK", "");
        KickEx(playerid);
	}
	ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.1,0,1,1,0,1000,1);
	MaPaczke[playerid] = 0;
	ACMagazynier[playerid] = 0;
	PodnoszeniePaczki[playerid] = 0;
	BlockDeska[playerid] = 0;
	DajKaseDone(playerid, PRICE_MAGAZYNIER);
	SendClientMessage(playerid, COLOR_BIALY, "[Magazynier] Odniosles paczke na dobre miejsce i zarobiles "#PRICE_MAGAZYNIER"$");
	RemovePlayerAttachedObject(playerid, 0);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}