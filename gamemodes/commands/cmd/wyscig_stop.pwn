//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ wyscig_stop ]----------------------------------------------//
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

YCMD:wyscig_stop(playerid, params[], help)
{
    if(IsANoA(playerid) || IsAKt(playerid) || HasPerm(playerid, PERM_RACING))
    {
		if(GroupPlayerDutyRank(playerid) >= 3)
		{
			if(Scigamy != 666)
            {
				SendClientMessage(playerid, COLOR_LIGHTGREEN, "Wyscig zatrzymany. Wszyscy uczestnicy zostali poinformowani.");
				KoniecWyscigu(playerid);
			}
			else
			{
				sendErrorMessage(playerid, "¯aden wyœcig nie jest w tej chwili organizowany");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie posiadasz uprawnieñ (wymagana 3 ranga)");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ z NoA lub Korporacji Transportowej!");
	}
	return 1;
}
