//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ id ]--------------------------------------------------//
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

YCMD:id(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        new giveplayerid; 
        if(sscanf(params, "k<fix>", giveplayerid))
        {
            sendTipMessage(playerid, "U�yj /id [ID/cz�� nicku]"); 
            return 1;
        }

        new string[333];
        if(IsNumeric(params))
        {
            if(!IsPlayerConnected(giveplayerid))
            {
                sendTipMessage(playerid, "Obecnie na serwerze nie ma gracza o tym ID.");
                return 1;
            }
            new nick[24];
            if(PlayerInfo[giveplayerid][pHidden] == 1 || GetPVarString(giveplayerid, "maska_nick", nick, 24))
            {
                SendClientMessage(playerid, COLOR_GREEN, "Znalezione osoby:");
                format(string, sizeof(string), "Gracz (ID: %d) %s", giveplayerid, GetNick(giveplayerid));
                SendClientMessage(playerid, COLOR_GRAD1, string);
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREEN, "Znalezione osoby:");
                format(string, sizeof(string), "Gracz (ID: %d) %s [%s]", giveplayerid, GetNick(giveplayerid), PlayerInfo[giveplayerid][pNickOOC]);
                SendClientMessage(playerid, COLOR_GRAD1, string);
            }

            return 1;
        } 
        else
        {
            if(strlen(params) < 3)
            {
                sendErrorMessage(playerid, "Za kr�tka fraza.");
                return 1;
            }

            SendClientMessage(playerid, COLOR_GREEN, "Znalezione osoby:");

            new c = 0;
            foreach(new i : Player)
            {
                if(c >= 10) { break; }

                if(strfind(GetNick(i), params, true) != -1)
                {
                    new nick[24];
                    if(PlayerInfo[i][pHidden] == 1 || GetPVarString(i, "maska_nick", nick, 24))
                    {
                        format(string, sizeof(string), "Gracz (ID: %d) %s", i, GetNick(i));
                        SendClientMessage(playerid, COLOR_GRAD1, string);
                    }
                    else
                    {
                        format(string, sizeof(string), "Gracz (ID: %d) %s [%s]", i, GetNick(i), PlayerInfo[i][pNickOOC]);
                        SendClientMessage(playerid, COLOR_GRAD1, string);
                    }
                    c++;
                }
            }

            if(c >= 10)
            {
                sendErrorMessage(playerid, "Zbyt du�o wynik�w, zmie� kryteria.");
                return 1;
            }

            if(c == 0)
            {
                sendErrorMessage(playerid, "Nie znaleziono takiego nicku.");
                return 1;
            }
        }
    }
    return 1;
}
