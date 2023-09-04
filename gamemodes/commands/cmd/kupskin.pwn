//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kupskin ]------------------------------------------------//
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

// Opis
/*
	
*/


// Notatki skryptera:
/*
	
*/

DialogKupSkin(playerid)
{
	static string[sizeof(ShopSkins) * 20];
	if(isnull(string)) {
        for(new i; i<sizeof(ShopSkins); i++)  {
			if(ShopSkins[i][SKIN_TYPE] == SKIN_TYPE_DEFAULT) {
            	strcat(string, sprintf("%d\t~g~$%d\n", ShopSkins[i][SKIN_ID], ShopSkins[i][SKIN_PRICE]));
			}
        }
		string[strlen(string)-1] = '\0';
	}

	ShowPlayerDialogEx(playerid, DIALOG_KUPSKIN, DIALOG_STYLE_PREVIEW_MODEL, "Skiny do kupienia", string, "Kup", "Wyjdz");
}

YCMD:kupskin(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsAtClothShop(playerid))
        {
			//DialogKupSkin(playerid);
			RunCommand(playerid, "kup", "");
			return 1;
		}
	}
	return 1;
}
