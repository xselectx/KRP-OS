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

YCMD:ppodnies(playerid, params[])
{
	if(MaPaczke[playerid] == 1) { SendClientMessage(playerid, COLOR_BIALY, "[Magazynier] Masz juz paczke."); return 1; }
    if(PodnoszeniePaczki[playerid] == 1) { SendClientMessage(playerid, COLOR_BIALY, "[Magazynier] Podnosisz wlasnie paczke, poczekaj."); return 1; }
	if(InfoSkate[playerid][sActive]) { SendClientMessage(playerid, COLOR_BIALY, "[Magazynier] Nie mo¿esz wykonywaæ tej pracy z deskorolk¹!."); return 1; }
	if(IsPlayerInRangeOfPoint(playerid,2.0,2174.98, -2248.15, 13.30) || IsPlayerInRangeOfPoint(playerid,2.0,2171.96, -2250.89, 13.30) || IsPlayerInRangeOfPoint(playerid,3.0,2294.3201,-1922.8436,13.5469))
	{
	    TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.1,0,1,1,0,8000,1);
		SetTimerEx("Czaspodnoszenia", 11000, false, "i", playerid);
		GameTextForPlayer(playerid, "~r~Podnosisz paczke", 19000, 3);
		PodnoszeniePaczki[playerid] = 1;
		BlockDeska[playerid] = 1;
		return 1;
	}
	else
	{
 		SendClientMessage(playerid, COLOR_BIALY, "[Magazynier] Nie jestes na miejscu podnoszenia paczek");
	}
	return 1;
}