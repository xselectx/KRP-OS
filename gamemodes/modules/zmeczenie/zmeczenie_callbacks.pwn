//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  zmeczenie                                                 //
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
// Autor: Dawidoskyy
// Data utworzenia: 25.11.2021
//Opis:
/*
	System zmeczenia
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnPlayerConnect(playerid)
{
	SetPlayerMaxStamina(playerid, STAMINA_DEFAULT_MAX);
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	SetPlayerMaxStamina(playerid, STAMINA_DEFAULT_MAX);
	return 1;
}

stock UpdatePlayerStamina(playerid)
{
	if(IsPlayerRunning(playerid)) GivePlayerStamina(playerid, -1);
	else if(GetPlayerStamina(playerid) < GetPlayerMaxStamina(playerid)) GivePlayerStamina(playerid, 5);
	return 1;
}

stock CreateStaminaForPlayers()
{
	for(new i, maxp = GetPlayerPoolSize(); i == maxp; i++)
	{
		SetPlayerMaxStamina(i, STAMINA_DEFAULT_MAX);
		SetPlayerStamina(i, STAMINA_DEFAULT_MAX);
	}
	return 1;
}
//end