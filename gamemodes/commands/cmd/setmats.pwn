//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setmats ]------------------------------------------------//
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

YCMD:setmats(playerid, params[], help)
{
	if (IsAHeadAdmin(playerid))
	{
		new gracz, wartosc;
		if(sscanf(params, "k<fix>d", gracz, wartosc))
		{
			sendTipMessage(playerid, "U�yj /setmats [playerid/Cz��Nicku] [ilo�� mats�w]");
			return 1;
		}

		if(IsPlayerConnected(gracz))
		{
			//PlayerInfo[gracz][pMats] = wartosc;
			Item_Add("Materia�y", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[gracz][pUID], ITEM_TYPE_MATS, 0, 0, true, gracz, wartosc, ITEM_NOT_COUNT);
			Log(adminLog, WARNING, "Admin %s ustawi� %s materia�y na %d", GetPlayerLogName(playerid), GetPlayerLogName(gracz), wartosc);

            _MruAdmin(playerid, sprintf("Da�e� %d materia��w graczowi %s [ID: %d]", wartosc, GetNick(gracz), gracz));
            if(gracz != playerid) _MruAdmin(gracz, sprintf("Dosta�e� %d materia��w od admina %s [ID: %d]", wartosc, GetNickEx(playerid), playerid));


		}
		else
		{
			sendErrorMessage(playerid, "Ten gracz jest offline!");
		}

	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}
