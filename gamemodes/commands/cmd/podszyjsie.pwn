//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ podszyjsie ]----------------------------------------------//
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


// YCMD:podszyj(playerid, params[], help) return RunCommand(playerid, "/podszyjsie",  params, help);
YCMD:podszyjsie(playerid, params[], help)
{
	/*
    if(IsPlayerConnected(playerid))
    {
        if(GetPlayerFrac(playerid) != FRAC_FBI) return 1;
		if(GroupPlayerDutyRank(playerid) == 4 || GroupPlayerDutyRank(playerid) == 5 || GroupPlayerDutyRank(playerid) == 7 || GroupPlayerDutyRank(playerid) == 8 || GroupPlayerDutyRank(playerid) == 9)
		{
		    ShowPlayerDialogEx(playerid,DIALOGID_PODSZYJ,DIALOG_STYLE_LIST,"Podszyj si�.","FBI\n""Grove\n""Ballas\n""ICC\n""Yakuza\n""Latin Kings","Dalej",""); //zmie� dialogid
		}
		else
		{
            SendClientMessage(playerid, COLOR_GRAD2, "	Nie mo�esz si� podszywa�!");
		}
	}
	*/
	return 1;
}

