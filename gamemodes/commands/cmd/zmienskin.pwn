//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zmienskin ]-----------------------------------------------//
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

YCMD:zmienskin(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if (IsAHA(playerid) || IsAPolicja(playerid) && (!IsPlayerInGroup(playerid, 3)))
        {
            if((GroupRank(playerid, FRAC_HA) >= 1 && IsAHA(playerid)) || (GroupPlayerDutyRank(playerid) >= 2 && GroupPlayerDutyPerm(playerid, PERM_POLICE)))
            {
                if(GetPVarInt(playerid, "IsAGetInTheCar") == 1)
                {
                    sendErrorMessage(playerid, "Jeste� podczas wsiadania - odczekaj chwile. Nie mo�esz znajdowa� si� w poje�dzie.");
                    return 1;
                }
                ShowPlayerDialogEx(playerid, DIALOG_HA_ZMIENSKIN(0), DIALOG_STYLE_LIST, "Zmiana ubrania", DialogListaFrakcji(), "Start", "Anuluj");
            } 
            else if(IsAHA(playerid))
            {
                sendTipMessage(playerid, "Dozwolone tylko dla rangi 1 lub wi�kszych");
            }
            else
            {
                sendTipMessage(playerid, "Dozwolone tylko dla rangi 2 lub wi�kszych");
            }
        } 
        else
        {
            sendTipMessage(playerid, "Tylko dla Hitman Agency i FBI/LSPD.");
        }
    }
    return 1;
}
