//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ setstrong ]-----------------------------------------------//
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

YCMD:setstrong(playerid, params[], help)
{
	new valueStrong, giveplayerid;
	new string[128];
	if( sscanf(params, "k<fix>d", giveplayerid, valueStrong))
	{
		sendTipMessage(playerid, "U�yj /setstrong [ID] [Warto��] ");
		return 1;
	}
	if(valueStrong >= MAX_STRONG_VALUE)
	{
		format(string, sizeof(string), "Nie mo�esz ustali� warto�ci wi�kszej jak %d", MAX_STRONG_VALUE);
		sendTipMessage(playerid, string); 
		return 1;
	}
	if(IsPlayerConnected(playerid) && IsPlayerConnected(giveplayerid))
	{
		if(PlayerInfo[giveplayerid][pStrong] != MAX_STRONG_VALUE)
		{
			if(PlayerInfo[playerid][pAdmin] >= 3500 || IsAScripter(playerid))
			{
				format(string, sizeof(string), "Administrator %s ustali� Ci warto�� si�y na %d [Poprzednia warto�� %d]", GetNickEx(playerid), valueStrong, PlayerInfo[giveplayerid][pStrong]);
				sendTipMessageEx(giveplayerid, COLOR_P@, string);
				format(string, sizeof(string), "Ustali�e� warto�� si�y %s na %d - jego poprzednia warto�� to %d", GetNick(giveplayerid), valueStrong, PlayerInfo[giveplayerid][pStrong]); 
				sendTipMessageEx(playerid, COLOR_P@, string); 
				PlayerInfo[giveplayerid][pStrong] = valueStrong;
			}
			else
			{
				sendTipMessage(playerid, "Brak wystarczaj�cych uprawnie�"); 
				return 1;
			}
		}
		else
		{
			sendTipMessage(playerid, "Ten gracz ma ju� maksymaln� warto�� si�y!"); 
			return 1;
		}
	
	}
	else
	{
		sendTipMessage(playerid, "Gracz nie jest pod��czony"); 
	}
	return 1;
}
