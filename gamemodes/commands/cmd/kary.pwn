//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kary ]-----------------------------------------------//
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

YCMD:kary(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {   
        new string[256];
        if(PlayerInfo[playerid][pWeaponBlock] > 0 && PlayerInfo[playerid][pWeaponBlock] > gettime())
            strcat(string, sprintf("[#] Blokada broni (Pozosta這: %d min)\n", floatround( ((PlayerInfo[playerid][pWeaponBlock]-gettime())/60), floatround_ceil)), sizeof(string));
        if(PlayerInfo[playerid][pBP] > 0)
            strcat(string, sprintf("[#] Blokada pisania (Pozosta這: %d h)\n", PlayerInfo[playerid][pBP]), sizeof(string));
        if(PlayerInfo[playerid][pJailTime] > 0 && PlayerInfo[playerid][pJailed] == 3)
            strcat(string, sprintf("[#] Admin Jail (Pozosta這: %d min)\n", PlayerInfo[playerid][pJailTime]), sizeof(string));
        if(strlen(string) == 0)
            strcat(string, "[#] Brak aktywnych kar");
        
        ShowPlayerDialogEx(playerid, DIALOG_EMPTY_SC, DIALOG_STYLE_LIST, "{8FCB04}Kotnik-RP 認FFFFFF} Aktywne kary", string, "Zamknij", "");
        return 1;
    }
    return 1;
}