//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                   convoy                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 20.10.2019
//Opis:
/*
	System konwoj�w.
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_CROUCH))
	{
		new boxid = GetNearestBox(playerid);
		if(boxid != -1)
		{
			sendTipMessage(playerid, "Podnios�e� dyni� z narkotykami. Aby j� upu�ci�, naci�nij enter.");
			if(IsInAConvoyTeam(playerid)) {
				sendTipMessage(playerid, "Upu�� paczk� przy poje�dzie konwojowym, aby wrzuci� j� spowrotem do �rodka.");
			} else {
				sendTipMessage(playerid, "Dostarcz dyni� do upiornych handlarzy, aby otrzyma� nagrod�.");
			}
			ChatMe(playerid, "podnosi dyni�.");
			PickupBox(playerid, boxid);
		}
	}
	else if(PRESSED(KEY_SECONDARY_ATTACK))
	{
		if(IsPlayerCarryingBox(playerid) && !IsPlayerInAnyVehicle(playerid))
		{
			DropBox(playerid);
   			ApplyAnimation(playerid,"CARRY","putdwn", 4.0, 0, 0, 0, 0, 0); 
			ChatMe(playerid, "upuszcza dyni�.");
		}
	}
	return 1;
}

hook OnPlayerDeath(playerid)
{
	if(IsPlayerCarryingBox(playerid)) 
	{
		ChatMe(playerid, "upuszcza dyni�.");
		DropBox(playerid);
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerCarryingBox(playerid)) 
	{
		ChatMe(playerid, "upuszcza dyni�.");
		DropBox(playerid);
	}
	return 1;
}

hook OnPlayerConnect(playerid)
{
	carryingBox[playerid] = -1;
	return 1;
}

//end