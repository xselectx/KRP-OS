//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   dajkp                                                   //
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
// Data utworzenia: 09.06.2019


//

//------------------<[ Implementacja: ]>-------------------
command_dajkp_Impl(playerid, giveplayerid, time)
{
    if(IsAKox(playerid))
	{
		if(time == 0)
		{
			DajKP(giveplayerid, 0, true);
		}
		else
		{
			DajKP(giveplayerid, gettime()+time, true);
		}

		Log(premiumLog, WARNING, "Admin %s da� %s konto premium na %d sekund", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), time);
		_MruAdmin(playerid, sprintf("Da�e� KP graczowi %s [ID: %d] na czas %d.", GetNickEx(giveplayerid), giveplayerid, time));
		if(giveplayerid != playerid) _MruAdmin(giveplayerid, sprintf("Dosta�e� KP od Admina %s [ID: %d]", GetNickEx(playerid), playerid));
		return 1;
	}
	else return noAccessMessage(playerid);
}


//end