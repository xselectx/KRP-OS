//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ kupowaniedomu ]---------------------------------------------//
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

YCMD:kupowaniedomu(playerid, params[], help)
{
	new string[128];

    if(gPlayerLogged[playerid] == 1)
    {
		if(GetPlayerAdminDutyStatus(playerid) == 0)
		{
			if(PlayerInfo[playerid][pDom] == 0)
			{
				if(PlayerInfo[playerid][pWynajem] == 0)
				{
					if(PlayerInfo[playerid][pMotRoom] != 0) return sendTipMessage(playerid, "Nie mo�esz kupi� domu gdy wynajmujesz pok�j w motelu!");
					for(new i; i<=dini_Int("Domy/NRD.ini", "NrDomow"); i++)
					{
						if(IsPlayerInRangeOfPoint(playerid, 5.0, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z]))
						{
							if(Dom[i][hKupiony] == 0)
							{
								if(GUIExit[playerid] == 0)
								{
									if(Dom[i][hBlokada] == 1)
									{
										sendTipMessage(playerid, "Dom posiada zablokowan� mo�liwo�� kupna.");
										return 1;
									}
									if(PlayerInfo[playerid][pLevel] < 3)
									{
										sendTipMessage(playerid, "Aby kupi� dom musisz mie� powy�ej 3 lvl");
										return 1;
									}
									new cenadomu = Dom[i][hCena];
									if(cenadomu < kaska[playerid] || cenadomu < PlayerInfo[playerid][pAccount])
									{
										IDDomu[playerid] = i;
										format(string, sizeof(string), "Czy na pewno chcesz kupi� ten dom za %d$?\nAby kupi� wci�nij 'Tak', aby anulowa� naci�nij 'Nie'", cenadomu);
										ShowPlayerDialogEx(playerid, 85, DIALOG_STYLE_MSGBOX, "Kupowanie domu - pytanie", string, "Tak", "Nie");
									}
									else
									{
										format(string, sizeof(string), "Nie sta� ci� na zakup tego domu, potrzebujesz %d", cenadomu);
										sendErrorMessage(playerid, string);
									}
								}
							}
							else
							{
								sendErrorMessage(playerid, "Ten dom ju� jest kupiony");
							}
						}
					}
				}
				else
				{
					sendTipMessage(playerid, "Aby kupi� dom nie mo�esz wynajmowa� domu. Wpisz /unrent.");
				}
			}
			else
			{
				sendTipMessage(playerid, "Posiadasz ju� 1 dom, nie mo�esz kupi� drugiego.");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie mo�esz kupi� domu podczas s�u�by administratora!"); 
		}
  	}
	return 1;
}
