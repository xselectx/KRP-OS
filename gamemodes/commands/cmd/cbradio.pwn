//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ cbradio ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:cbradio(playerid, params[], help)
{
	if(HasActiveItemType(playerid, ITEM_TYPE_CBRADIO) == -1)
	{
		sendErrorMessage(playerid, "Nie masz CB-Radia/jest ono wy��czone! (aby w��czy� wpisz /p CB-Radio)");
		return 1;
	}
	if(GetPlayerVehicleID(playerid))
	{
		if(isnull(params))
		{
			sendTipMessage(playerid, "U�yj /cb [text]");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robi� OOC w IC! Pisz poprzez /b [tre��]");
			return 1;
		}
		new string[128];
		if(PlayerInfo[playerid][pBP] >= 1)
		{
			format(string, sizeof(string), "Nie mo�esz napisa� na tym czacie, gdy� masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string);
			return 1;
		}
		foreach(new i : Player)
		{
			if(GetPlayerVehicleID(i) || adminpodgladcb[i] == 1)
			{
				if(HasActiveItemType(i, ITEM_TYPE_CBRADIO) != -1 && PlayerPersonalization[i][PERS_CB] == 0)
				{
					format(string, sizeof(string), "%s m�wi przez CB-Radio: %s", GetNickEx(playerid), params);
					SendClientMessage(i,0xff00ff, string);
					Log(chatLog, WARNING, "%s cb-radio: %s", GetPlayerLogName(playerid), params);
				}
			}
		}
	}
	else
	{
        sendErrorMessage(playerid, "Nie jeste� w aucie");
	}
	return 1;
}
