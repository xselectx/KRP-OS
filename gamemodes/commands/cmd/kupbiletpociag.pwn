//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ kupbiletpociag ]--------------------------------------------//
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

YCMD:kupbiletpociag(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(IsAtTicketMachine(playerid))
		{
			if(PlayerInfo[playerid][pBiletpociag] == 1)
			{
				//zmienne:
				new string[128];
				//Komunikaty:
				sendErrorMessage(playerid, "Posiadasz ju� bilet do poci�gu!");
				format(string, sizeof(string), "* %s mruczy (jak Mrucznik) na bilet, kt�ry ju� posiada.", GetNick(playerid));//ciekawostka - mrucznik
				ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				return 1;
			}
			else if(PlayerInfo[playerid][pBiletpociag] == 0)
			{
				//zmienne
				new string[256];
				new giveplayer[MAX_PLAYER_NAME];
				GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
				//czynno�ci:
				format(string, sizeof(string), "{FFFF00}Korporacja Transportowa\n{FFFFFF}Cena: {00FF00}%d$\n{FFFFFF}Imi�_Nazwisko: {00FF00}%s\n{FFFFFF}Ulga: {00FF00}0$", CenaBiletuPociag, giveplayer);//Skrypt na zni�ki i ulgi w trakcie pisania, celowo ie ma tutaj warto�ci
				ShowPlayerDialogEx(playerid, 1090, DIALOG_STYLE_MSGBOX, "Maszyna do bilet�w", string, "Zakup", "Odejd�");
				//komunikaty:
				format(string, sizeof(string), "* %s wstukuje w maszyn� UID dowodu osobistego, wybiera tras� i ulg�.", GetNick(playerid));
				ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jeste� przy maszynie do kupna bilet�w!"); 
			return 1;
		}
	}
	return 1;
}
