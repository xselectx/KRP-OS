//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ say ]--------------------------------------------------//
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

YCMD:say(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(gPlayerLogged[playerid] == 0)
		{
			return 1;
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Jeste� uciszony! Nie mo�esz m�wi�"); 
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robi� OOC w IC! U�yj /b [tre��]"); 
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U�yj /(l)ocal [tekst]");
			return 1;
		}
		
		PlayerTalkIC(playerid, params, "m�wi", 8.0,  true); 
		Log(chatLog, WARNING, "%s chat IC: %s", GetPlayerLogName(playerid), params);	
	}

	return 1;
}
