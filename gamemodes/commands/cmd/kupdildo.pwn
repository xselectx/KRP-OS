//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kupdildo ]-----------------------------------------------//
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

YCMD:kupdildo(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		if(PlayerToPoint(30.0, playerid, -105.0829,-10.6207,1000.7188))
		{
	        if(kaska[playerid] < 1)
			{
			    sendTipMessage(playerid, "Nie masz przy sobie wystarczaj¹co du¿o pieniêdzy!");
			    return 1;
			}
			if(GUIExit[playerid] == 0)
 	    	{
				ShowPlayerDialogEx(playerid, 81, DIALOG_STYLE_LIST, "Los Santos Sex Shop XXX- wibratory, filmy i zabawki", "Purpurowe dildo\t\t"#PRICE_DILDO_PURP"$\nMa³y wibrator\t\t\t"#PRICE_DILDO_ANALNY"$\nDu¿y bia³y wibrator\t\t"#PRICE_DILDO_BIALY"$\nSrebrny wibrator\t\t"#PRICE_DILDO_SREBRNY"$\nLaska sado-maso\t\t"#PRICE_DILDO_LASKA"$\nKwiaty\t\t\t\t"#PRICE_DILDO_KWIATY"$\nPrezerwatywy\t\t\t"#PRICE_KONDOM"$", "Kup", "WyjdŸ");
			}
		}
		else
		{
		    sendErrorMessage(playerid,"Nie jesteœ w sex shopie");
		    return 1;
		}
	}
	return 1;
}
