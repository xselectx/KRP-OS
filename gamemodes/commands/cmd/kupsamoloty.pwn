//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ kupsamoloty ]----------------------------------------------//
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

YCMD:kupsamoloty(playerid, params[], help)
{
    if(IsPlayerInRangeOfPoint(playerid, 5.0, -1262.5095,40.3263,14.1392))//kupowanie samolotu
    {
		if(IsPlayerInAnyVehicle(playerid))
		{
			sendErrorMessage(playerid, "Aby tego u¿yæ musisz wyjœæ z pojazdu"); 
			return 1;
		}
        if(PlayerInfo[playerid][pSamolot] == 0)
	    {
	        if(GUIExit[playerid] == 0)
	    	{
		        ShowPlayerDialogEx(playerid, 410, DIALOG_STYLE_LIST, "Kupowanie samolotu", "Dodo\t\t\t300 000$\nCropduster\t350 000$\nBeagle\t\t500 000$\nStuntplane\t585 000$\nNevada\t\t680 000$\nShamal\t\t1 000 000$", "Wybierz", "WyjdŸ");
            }
	    }
	    else
	    {
	        sendErrorMessage(playerid, "Posiadasz ju¿ samolot.");
	    }
    }
    else
    {
        sendErrorMessage(playerid, "Nie jesteœ w salonie helikopterów/samolotów.");
    }
	return 1;
}
