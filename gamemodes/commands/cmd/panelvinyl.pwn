//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ panelvinyl ]----------------------------------------------//
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
	Skrypt pozwalaj¹cy zarz¹dzaæ vinyl-clubem
*/


// Notatki skryptera:
/*
	
*/

YCMD:panelvinyl(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
        if(IsPlayerInGroup(playerid, 19, 1) && GroupPlayerDutyRank(playerid) >= 4) // Pod ibize
        {
            sendTipMessage(playerid, "Witamy w panelu zarz¹dzania Vinyl-Club");
            ShowPlayerDialogEx(playerid, 6999, DIALOG_STYLE_TABLIST, "Laptop Lidera", "Open/Close\nUstal cene Norm.\nUstal cene VIP\nUstal cene napoi\nUstal nazwe napoi", "Wybierz", "Odrzuæ");
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ z Ibizy, nie mo¿esz zarz¹dzaæ vinylem!");
        }
    }
	return 1;
}
