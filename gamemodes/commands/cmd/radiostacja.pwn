//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ radiostacja ]----------------------------------------------//
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

YCMD:radiostacja(playerid, params[], help)
{
    if(GetPLocal(playerid) == PLOCAL_ORG_SN)
    {
        if(CheckPlayerPerm(playerid, PERM_NEWS))
	    {
            if(GroupPlayerDutyRank(playerid) < 3) return sendTipMessageEx(playerid, COLOR_GREY, "Od 3 rangi!");
            ShowPlayerDialogEx(playerid, 667, DIALOG_STYLE_LIST, "Wybierz nag�o�ni�", "R SAN 01\nR SAN 02", "Wybierz", "Anuluj");
        }
        else return sendErrorMessage(playerid, "Nie nale�ysz do SN!");
	}
	else
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� w budynku San News");
	}

	return 1;
}
