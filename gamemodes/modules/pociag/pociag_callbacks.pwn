//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  pizzaman                                                 //
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
// Autor: AnakinEU
// Data utworzenia: 01.11.2021
//Opis:
/*
	Praca dorywcza Magazynier
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnFilterScriptInit()
{
	printf("Ladowanie NPC");
	ConnectNPC("Carl_Johnson","pociag");
	CJVehicle = AddStaticVehicle(538, 769.002, -1325.48, -0.001477, 229.778, -1, -1);
	printf("Zakonczono ladowania NPC");
	return 1;
}

hook OnFilterScriptExit()
{
	return 1;
}
hook OnPlayerConnect(playerid)
{
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		new npcname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, npcname, sizeof(npcname));
		if(!strcmp(npcname, "Carl_Johnson", true))
		{
			SetPlayerSkin(playerid, 0);
			PutPlayerInVehicle(playerid, CJVehicle, 0);
			return 1;
		}
	}
	return 1;
}

//end