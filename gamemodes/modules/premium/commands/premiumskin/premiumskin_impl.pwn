//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                premiumskin                                                //
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
command_premiumskin_Impl(playerid, skin)
{
	if(!PlayerHasSkin(playerid, skin))
		return sendErrorMessage(playerid, "Nie masz tego skina.");

	if((OnDuty[playerid] > 0) || SanDuty[playerid] == 1)
	{
		return sendErrorMessage(playerid, "B�d�c na s�u�bie nie mo�esz aktywowa� unikatowego skina.");
	}

	if(IsPlayerInAnyVehicle(playerid))
	{
		return sendErrorMessage(playerid, "Nie mo�esz przebra� si� b�d�c w poje�dzie.");
	}
	
	PlayerInfo[playerid][pSkin] = skin;

	SetPlayerSkinEx(playerid, skin);

	_MruAdmin(playerid, sprintf("Aktywowa�e� sw�j unikatowy skin [ID: %d]", skin));
	return 1;
}


//end