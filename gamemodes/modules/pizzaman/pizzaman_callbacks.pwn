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
// Autor: xSeLeCTx
// Data utworzenia: 09.05.2021
//Opis:
/*
	Praca dorywcza Pizzaboya
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnGameModeInit()
{
	Create3DTextLabel("Praca Dostawcy Pizzy!\n{FFFFFF}(/{929292}pizzaboy{FFFFFF}) aby pracowaæ\n(/{929292}dolacz{FFFFFF}) aby siê zatrudniæ", 0xFFA500AA, Pizzaboy_Main_Locations[0][0], Pizzaboy_Main_Locations[0][1], Pizzaboy_Main_Locations[0][2]+0.5000, 30, 0, 0);
    return 1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if(Pizzaboy_State[playerid] == PIZZABOY_STATE_GETPIZZA || Pizzaboy_State[playerid] == PIZZABOY_STATE_GOBACK)
	{
		Pizzaboy_Time[playerid] = PIZZABOY_TIME_PACKING;
		Pizzaboy_State[playerid] = PIZZABOY_STATE_PACKING;
   	 	DisablePlayerCheckpoint(playerid);
   	 	GameTextForPlayer(playerid, "~g~Pakowanie!", 2500, 4);
	}
	else if(Pizzaboy_State[playerid] == PIZZABOY_STATE_DELIVER)
	{
		new r = Pizzaboy_Random[playerid];
		new Float:a = Pizzaboy_Order_Locations[r][3];
		if(IsPlayerInRangeOfPoint(playerid, 5, (Pizzaboy_Order_Locations[r][0]+(2 * floatsin(-a,degrees))), (Pizzaboy_Order_Locations[r][1]+(2 * floatcos(-a,degrees))), Pizzaboy_Order_Locations[r][2]))
		{
			Pizzaboy_Taveled_Time[playerid] = Pizzaboy_Time[playerid];
			Pizzaboy_Time[playerid] = PIZZABOY_TIME_PICKUP;
			Pizzaboy_State[playerid] = PIZZABOY_STATE_PICKUP;
   	 		DisablePlayerCheckpoint(playerid);
   	 		GameTextForPlayer(playerid, "~g~Klient odbiera pizze!", 5000, 4);
   	 	} else {
   	 		SetPlayerCheckpoint(playerid, (Pizzaboy_Order_Locations[r][0]+(2 * floatsin(-a,degrees))), (Pizzaboy_Order_Locations[r][1]+(2 * floatcos(-a,degrees))), Pizzaboy_Order_Locations[r][2], 1);
   	 	}
	}
	else {
		DisablePlayerCheckpoint(playerid);
	}
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(Pizzaboy_Active[playerid])
    {
        Pizzaboy_End(playerid);
    }
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(Pizzaboy_Active[playerid] && gPlayerLogged[playerid])
    {
        Pizzaboy_End(playerid);
    }
}
//end