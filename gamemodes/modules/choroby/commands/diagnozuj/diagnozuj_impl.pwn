//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 diagnozuj                                                 //
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
// Data utworzenia: 07.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_diagnozuj_Impl(playerid, giveplayerid)
{
	if (!IsAMedyk(playerid) && (PlayerInfo[playerid][pAdmin] == 0 || PlayerInfo[playerid][pNewAP] == 0))
	{
		sendErrorMessage(playerid, "Nie jeste� medykiem!");
        return 1;
	}
    
    if(!IsPlayerNear(playerid, giveplayerid))
    {
        sendErrorMessage(playerid, sprintf("Jeste� zbyt daleko od gracza %s", GetNick(giveplayerid)));
        return 1;
    }

    ProxDetector(20.0, playerid, sprintf("* Lekarz %s przeprowadzi� diagnoz� pacjenta %s.", GetNick(playerid), GetNick(giveplayerid)), 
        COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE
    );
    
    DiagnosePlayer(giveplayerid, playerid);
    return 1;
}

//end