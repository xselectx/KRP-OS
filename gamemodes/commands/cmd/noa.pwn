//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ noa ]--------------------------------------------------//
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

YCMD:noa(playerid, params[], help)
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new content[256];

	if(IsANoA(playerid) && GroupPlayerDutyRank(playerid) >= 6)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U�yj /FDU [tresc]");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Dobry admin nie powinien robi� OOC w IC! Napisz to poprzez /o tre��");
			return 1;
		}
		GetPVarString(playerid, "trescOgloszenia", content, sizeof(content));
		if(PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] >= 1)
		{
			PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 15-komunikatMinuty[playerid];
			format(string, sizeof(string), "Wys�a�e� og�oszenie o tej samej tre�ci, odczekaj jeszcze %d minut", PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas]);
			sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string); 
			format(string, sizeof(string), "{A0522D}Ostatnie og�oszenie: {FFFFFF}%s", content);
			sendTipMessage(playerid, string);
			return 1;
		}
		if(strfind(params, content, false) == -1)
		{
			SetPVarString(playerid, "trescOgloszenia", params);
			SendClientMessageToAll(0xA400A4C8,"|____________[WIADOMOSC FDU]____________|");
			format(string, sizeof(string), "%s: %s", sendername, params);
			SendClientMessageToAll(COLOR_GREY, string);
			komunikatTimeZerowanie[playerid] = SetTimerEx("KomunikatCzasZerowaie", 60000, true, "i", playerid);
			sendTipMessage(playerid, "Odczekaj 5 minut przed wys�aniem ponownego komunikatu o {AC3737}tej samej tre�ci"); 
			return 1;
		}
		SendClientMessage(playerid, -1, " "); 
		sendTipMessageEx(playerid, COLOR_WHITE, "Wys�a�e� og�oszenie o tej samej tre�ci w czasie mniejszym jak {AC3737}5 minut!");
		sendTipMessageEx(playerid, COLOR_WHITE, "{C0C0C0}Zostajesz ukarany kar� Anty-Spam na {AC3737}15 minut");
		komunikatTime[playerid] = SetTimerEx("KomunikatCzas", 60000, true, "i", playerid);		
		PlayerInfo[playerid][pBlokadaPisaniaFrakcjaCzas] = 15;
		format(string, sizeof(string), "[ANTY_SPAM] %s otrzyma� blokad� na 15 minut za wys�anie 2x tego samego komunikatu!", GetNickEx(playerid));
		SendAdminMessage(COLOR_BLUE, string);
	}
	else
	{
		sendErrorMessage(playerid,"Nie jeste� z FDU/nie masz 6 rangi");
	}
	return 1;
}
