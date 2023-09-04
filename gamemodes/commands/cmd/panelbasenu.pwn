//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ panelbasenu ]----------------------------------------------//
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

YCMD:panelbasenu(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(CheckPlayerPerm(playerid, PERM_TSUNAMIPOOL))
		{
			if(GroupIsVLeader(playerid, 0)) //TU WPISAC SLOT GRUPY JEZELI TAKA ZOSTANIE STWORZONA
			{
				if(IsPlayerInRangeOfPoint(playerid, 3.0, 1203.39294, -1772.58777, 13.71199))
				{
					new string[128];
					if(poolStatus == 0)
					{
						format(string, sizeof(string), "Otwórz Basen\nZmieñ cenê kredytów\nUstal muzykê\nWyœlij og³oszenie"); 
						ShowPlayerDialogEx(playerid, 1093, DIALOG_STYLE_TABLIST, "Laptop Lidera", string, "Wybierz", "Odrzuæ");
					}
					else
					{
						format(string, sizeof(string), "Zamknij Basen\nZmieñ cenê kredytów\nUstal muzykê\nWyœlij og³oszenie"); 
						ShowPlayerDialogEx(playerid, 1093, DIALOG_STYLE_TABLIST, "Laptop Lidera", string, "Wybierz", "Odrzuæ");

					}
				}
				else
				{
					sendTipMessage(playerid, "Nie jesteœ przy laptopie lidera"); 
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie jesteœ liderem basenu tsunami!"); 
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ pracownikiem basenu!"); 
			return 1;
		}
	
	
	}


	return 1;
}
