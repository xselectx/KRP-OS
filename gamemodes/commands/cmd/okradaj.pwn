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

YCMD:okradaj(playerid, params[])
{
	if(Kradnie[playerid] == 1) 
		return SendClientMessage(playerid, COLOR_BIALY, "[Szmugler] Masz juz paczke.");
	if(!IsAPrzestepca(playerid))
		return SendClientMessage(playerid, COLOR_BIALY, "[Szmugler] Musisz byæ z organizacji przestêpczej");
    if(OkradanieTira[playerid] == 1) 
		return SendClientMessage(playerid, COLOR_BIALY, "Chris_Harris mówi: Pss, ziomek! Z zawartoœci¹ udaj siê do Las Colinas do opuszczonego domu, ziomek odkupi od ciebie wszystko.");
	
	if(IsPlayerInRangeOfPoint(playerid,2.0,-76.32, -1559.37, 2.69) || IsPlayerInRangeOfPoint(playerid,2.0,-68.66, -1559.35, 2.69) || IsPlayerInRangeOfPoint(playerid,3.0,-59.03, -1554.73, 2.69))
	{
		if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_BIALY, "[Szmugler] Nie mo¿esz przebywaæ w pojeŸdzie!");
	    TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.1,0,1,1,0,8000,1);
		SetTimerEx("Czasokradania", 15000, false, "i", playerid);
		GameTextForPlayer(playerid, "~r~Wylamujesz paczke, okradasz", 19000, 3);
		OkradanieTira[playerid] = 1;
		SendRadioMessage(FRAC_LSPD, COLOR_LIGHTRED, "HQ: Trwa rabunek kontenera na granicy Los Santos!!!", 0, 1);
		SendRadioMessage(FRAC_LSPD, COLOR_LIGHTRED, "HQ: Podejrzany kieruje siê z zawartoœci¹ paczki do Las Colinas do opuszczonego domu!!!", 0, 1); 
		return 1; 
	}
	else
	{
 		SendClientMessage(playerid, COLOR_BIALY, "[Szmugler] Nie jestes na miejscu okradania kontenera");
	}
	return 1;
}