//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  urzadls                                                  //
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
// Autor: Simeone
// Data utworzenia: 20.09.2019
//Opis:
/*
	Automatyzacja Urzêdu Miasta w Los Santos - boty, skrypt botów, prawa jazdy [..] .
*/

//

//-----------------<[ Funkcje: ]>-------------------
PlayerInDmvPoint(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0215,-1792.1661,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0216,-1795.3773,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0219,-1798.5234,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0416,-1801.7599,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9628,-1791.4224,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9757,-1794.6508,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9752,-1797.7997,77.9453)
	|| IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9729,-1800.9788,77.9453))
	{
		return true;
	}
	return false;
}
CreateActorsInDMV(playerid)
{
	DmvActorStatus=true; 
	new string[124];
	dmv = 1; 
	if(playerid == INVALID_PLAYER_ID)
	{
		format(string, sizeof(string), "|____________Urz¹d Miasta otwarty_____________|");
		SendClientMessageToAll(COLOR_LIGHTGREEN, string);	
		return 1;
	}
	format(string, sizeof(string), "|____________Urz¹d Miasta otwarty przez %s_____________|", GetNick(playerid));
	SendClientMessageToAll(COLOR_LIGHTGREEN, string);
	return 1;
}
DestroyActorsInDMV()
{
	DmvActorStatus=false;
	dmv = 0;
	return 1;
}
DefaultItems_LicenseCost()
{
	DmvLicenseCost[0] = 20;
	DmvLicenseCost[1] = 30;
	DmvLicenseCost[2] = 250;
	DmvLicenseCost[3] = 120;
	DmvLicenseCost[4] = 30;
	DmvLicenseCost[5] = 40;
	DmvLicenseCost[6] = 20;
	DmvLicenseCost[7] = 700;
	DmvLicenseCost[8] = 150;
	DmvLicenseCost[9] = 350;
	return 1; 
}
//end