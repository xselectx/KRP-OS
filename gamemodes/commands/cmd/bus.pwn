//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ bus ]--------------------------------------------------//
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


YCMD:bus(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(GUIExit[playerid] == 0)
    	{
        	ShowPlayerDialogEx(playerid, 5000, DIALOG_STYLE_LIST, "Wybierz interesuj�c� ci� zagadnienie", "Linia 55\nLinia 72\nLinia 82\nLinia 96\nLinia 85\nObecnie w trasie\nWycieczki\nInformacje\nPomoc", "Wybierz", "Wyjd�");
		}
	}
	return 1;
}
