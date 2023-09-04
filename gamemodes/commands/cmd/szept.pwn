//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ szept ]-------------------------------------------------//
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

//YCMD:szept(playerid, params[], help)
///{
	
	//if(IsPlayerConnected(playerid))
	//{
		//if(gPlayerLogged[playerid] == 0)
		//{
		//	return 1;
		//}
		//if(PlayerInfo[playerid][pMuted] == 1)
		//{
		//	sendTipMessage(playerid, "Jesteœ uciszony! Nie mo¿esz mówiæ"); 
	//		return 1;
	//	}
	//	if(GetPlayerAdminDutyStatus(playerid) == 1)
	//	{
	//		sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! U¿yj /b [treœæ]"); 
	//		return 1;
	//	}
	//	if(isnull(params))
	//	{
		//	sendTipMessage(playerid, "U¿yj /(l)ocal [tekst]");
			//return 1;
		//}
		
		//PlayerTalkIC(playerid, params, "szepcze", 5.0,  true); 	
	//	Log(chatLog, WARNING, "%s szept: %s", GetPlayerLogName(playerid), params);	
	//}
//	return 1;
//}

CMD:szept(playerid, params[])
{
	if(isnull(params)) return sendTipMessage(playerid, "U¿yj /szept [tekst]");
	new string[128];
	format(string, sizeof(string), "%s szepcze: %s ", GetNick(playerid), params);
	ProxDetector(2.5, playerid, string, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_FADE1, COLOR_FADE2);
	return 1;
}