//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                   money                                                   //
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
// Data utworzenia: 01.07.2019
//Opis:
/*
	Moduł odpowiadający za operacje na pieniądzach gracza.
*/

//

//-----------------<[ Timery: ]>-------------------
forward AntyCheatSystemByMrucznik(); //repeated every second
public AntyCheatSystemByMrucznik()
{
    for(new i = 0, p = GetMaxPlayers(); i < p; i++)
    {
		if(GetPlayerMoney(i) != kaska[i])
		{
			if(IsPlayerConnected(i))
			{
				ResetPlayerMoney(i);
				GivePlayerMoney(i,kaska[i]);
			}
		}
	}
	return 1;
}

//end