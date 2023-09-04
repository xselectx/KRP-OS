//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ przelew ]------------------------------------------------//
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

YCMD:przelew(playerid, params[], help)
{
	new string[128];
	
	if(IsPlayerConnected(playerid))
	{
		if(GetPLocal(playerid) != PLOCAL_INNE_BANK)
		{
			sendErrorMessage(playerid, "Nie znajdujesz si� w banku lub nie posiadasz smartfona!"); 
			return 1;
		}
		if(PlayerInfo[playerid][pConnectTime] < 1) return sendTipMessage(playerid, "Zanim b�dziesz m�g� p�aci�, musisz gra� wi�cej ni� 1 godzin� online!");
		if(PlayerPersonalization[playerid][PERS_KB] == 0)
		{
			format(string, sizeof(string), "Konto Bankowe >> %s >> Przelew", GetNick(playerid));
			ShowPlayerDialogEx(playerid, 1072, DIALOG_STYLE_INPUT, string, "Wpisz poni�ej ID odbiorcy", "Wykonaj", "Odrzu�");
		}
		else
		{
			new giveplayerid, value;
			if( sscanf(params, "k<fix>d", giveplayerid, value))
			{
				sendTipMessage(playerid, "U�yj /przelew [ID_GRACZA] [KWOTA]");
				return 1;
			}
			if(IsPlayerConnected(giveplayerid))
			{
				if(GetPlayerVirtualWorld(giveplayerid) == 1488)
				{
					sendErrorMessage(playerid, "Ten gracz jest w trakcie logowania!"); 
					return 1;
				}
				if(giveplayerid != playerid)
				{
					if(PlayerInfo[playerid][pAccount] < value)
					{	
						sendErrorMessage(playerid, "Nie masz takiej kwoty na swoim koncie!"); 
						return 1;
					}
					if(value <= 0)
					{
						sendErrorMessage(playerid, "Nie mo�esz wykonywa� przelew�w na minus / zero.");
						return 1;
					}
					if(PlayerInfo[giveplayerid][pAccount]+value > MAX_MONEY_IN_BANK)
					{
						sendErrorMessage(playerid, "Gracz do kt�rego pr�bowa�e� przela� got�wk� - ma zbyt du�o pieni�dzy na koncie."); 
						return 1;
					}
					//Czynno�ci:
					PlayerInfo[playerid][pAccount] -= value;
					PlayerInfo[giveplayerid][pAccount] += value;
				
					//komunikaty:
					format(string, sizeof(string), "Otrzyma�e� przelew w wysoko�ci %d$ od %s . Pieni�dze znajduj� si� na twoim koncie.", value, GetNick(playerid));
					SendClientMessage(giveplayerid, COLOR_RED, string);
				
					format(string, sizeof(string), "Wys�a�e� przelew dla %s w wysoko�ci %d$. Pieni�dze zosta�y pobrane z twojego konta bankowego", GetNick(giveplayerid), value);
					SendClientMessage(playerid, COLOR_RED, string); 
				
					Log(payLog, WARNING, "%s przela� %s kwot� %d$", 
					GetPlayerLogName(playerid),
					GetPlayerLogName(giveplayerid),
					value);
				
					if(value >= 50000)//Wiadomosc dla adminow
					{
						format(string, sizeof(string), "Gracz %s wys�a� przelew do %s w wysoko�ci %d$", GetNick(playerid), GetNick(giveplayerid), value);
						SendAdminMessage(COLOR_YELLOW, string);
						return 1;
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie mo�esz przela� got�wki samemu sobie!");
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma na serwerze takiego gracza!"); 
				return 1;
			}
		}
	}
	return 1;
}
