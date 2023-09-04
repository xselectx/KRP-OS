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
                    sendErrorMessage(playerid, "Jesteœ podczas wsiadania - odczekaj chwile. Nie mo¿esz znajdowaæ siê w pojeŸdzie.");
                    return 1;
                }
                ShowPlayerDialogEx(playerid, DIALOG_HA_ZMIENSKIN(0), DIALOG_STYLE_LIST, "Zmiana ubrania", DialogListaFrakcji(), "Start", "Anuluj");
            } 
            else if(IsAHA(playerid))
            {
                sendTipMessage(playerid, "Dozwolone tylko dla rangi 1 lub wiêkszych");
            }
            else
            {
                sendTipMessage(playerid, "Dozwolone tylko dla rangi 2 lub wiêkszych");
            }
        } 
        else
        {
            sendTipMessage(playerid, "Tylko dla Hitman Agency i FBI/LSPD.");
        }
    }
    return 1;
}
