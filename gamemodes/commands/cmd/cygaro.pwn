//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ cygaro ]------------------------------------------------//
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

YCMD:cygaro(playerid, params[], help)
{
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 833.8511,-1391.2689,-17.6433))
	{
		if(kaska[playerid] < PRICE_CYGARO)
		{
			sendErrorMessage(playerid, "Nie masz wystarczaj¹co gotówki!"); 
			return 1;
		}
		sendTipMessage(playerid, "Jesteœ VIP - otrzymujesz cygaro za "#PRICE_CYGARO" dolców!"); 
		ZabierzKaseDone(playerid, PRICE_CYGARO); 
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
		Sejf_Add(FRAC_SN, PRICE_CYGARO);
		return 1;
	}
	if(HasItemType(playerid, ITEM_TYPE_CIGARETTE) == -1) return SendClientMessage(playerid, COLOR_LIGHTBLUE, "Musisz kupiæ cygaro aby móc je paliæ, idŸ do dilera lub 24/7");
    RunCommand(playerid, "przedmioty", "Cygaro");
	return 1;
}
