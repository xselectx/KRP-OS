//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ kb ]--------------------------------------------------//
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

YCMD:kb(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
			new giveplayer[MAX_PLAYER_NAME];
			new string[128];
			if(PlayerInfo[playerid][pLevel] >= 1)
			{
				if(PlayerInfo[playerid][pLocal] == 103)
				{
					GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "Konto Bankowe >> %s", giveplayer);
					ShowPlayerDialogEx(playerid, 1067, DIALOG_STYLE_LIST, string, "Stan konta\n\nWp�a�\nWyp�a�\nPrzelew\n>> Grupa", "Wybierz", "Wyjd�");
				}
				else
				{
					sendErrorMessage(playerid, "Nie jeste� w banku!");
				}
			}
			else
			{
				sendErrorMessage(playerid, "Aby m�c zarz�dza� swoim kontem bankowym i dokonywa� przelew�w musisz osi�gn�� 1 lvl");
			}
		}
	}
	return 1;
}
