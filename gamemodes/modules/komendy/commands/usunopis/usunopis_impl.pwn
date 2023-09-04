//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  usunopis                                                 //
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
// Autor: niceczlowiek
// Data utworzenia: 13.05.2019


//

//------------------<[ Implementacja: ]>-------------------
command_usunopis_Impl(playerid, giveplayerid)
{
    if(PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pNewAP] == 0) return 1;
    if(!IsPlayerConnected(giveplayerid)) return sendErrorMessage(playerid, "Nie ma takiego gracza");

    if(isnull(PlayerInfo[giveplayerid][pDesc]))
	{
		return sendErrorMessage(playerid, "Ten gracz nie ma ustawionego opisu");
	}
	else
	{
		Update3DTextLabelText(PlayerInfo[giveplayerid][pDescLabel], 0xBBACCFFF, "");
		PlayerInfo[giveplayerid][pDesc][0] = EOS;
		new msg[128];
		format(msg, 128, "Administrator %s usun�� tw�j opis", GetNickEx(playerid));
		sendErrorMessage(giveplayerid, msg);
		format(msg, 128, "Usun��e� opis %s", GetNick(giveplayerid));
		sendErrorMessage(playerid, msg);
	}
	return 1;
}


//end