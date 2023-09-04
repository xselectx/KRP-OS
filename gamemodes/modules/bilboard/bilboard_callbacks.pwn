//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                 bilboard                                                 //
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
// Data utworzenia: 17.07.2022

//

#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    LoadBilboards();
}

hook OnGameModeExit()
{
    SaveBilboards();
}

hook OnPlayerEditDynamicObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(PlayerInfo[playerid][pIsEditingBilboard] == true)
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			DestroyDynamicObject(PlayerInfo[playerid][pEditorBilboardObject]);
			PlayerInfo[playerid][pIsEditingBilboard] = false;
			CreateNewBilboard(x, y, z, rz);
            sendTipMessage(playerid, "Bilboard zosta³ pomyœlnie stworzony!");
			Streamer_Update(playerid);
		}
		if(response == EDIT_RESPONSE_CANCEL)
		{
			DestroyDynamicObject(PlayerInfo[playerid][pEditorBilboardObject]);
			PlayerInfo[playerid][pIsEditingBilboard] = false;
			sendTipMessage(playerid, "Anulowano edytor bilboardu.");
		}
		return 1;
	}
    return 0;
}