//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  specshow                                                 //
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
// Autor: Simeone
// Data utworzenia: 13.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_specshow_Impl(playerid, valueSpec)
{
    if(PlayerInfo[playerid][pAdmin] >= 2000 || IsAScripter(playerid))
    {
        new string[124];
        if(playerSeeSpec[playerid] == INVALID_SPECTATE_ID)
        {
            if(valueSpec == -1)
            {
                playerSeeSpec[playerid] = -1; 
                sendTipMessageEx(playerid, COLOR_RED, "W��czy�e� podgl�d u�ycia komendy /spectate na wszystkich administrator�w"); 
                return 1;
            }
            if(IsPlayerConnected(valueSpec))
            {
                if(PlayerInfo[valueSpec][pAdmin] == 0 && PlayerInfo[valueSpec][pNewAP] == 0)
                {
                    sendErrorMessage(playerid, "Ta osoba nie jest administratorem!"); 
                    return 1;
                }
                if(playerSeeSpec[playerid] == INVALID_SPECTATE_ID)
                {
                    format(string, sizeof(string), "Oznaczy�e� %s jako sw�j cel pogl�du u�y� komendy /spectate!", GetNick(valueSpec)); 
                    playerTargetSpec[valueSpec] = playerid; 
                    playerSeeSpec[playerid] = valueSpec;
                    sendTipMessageEx(playerid, COLOR_RED, string); 
                    sendTipMessage(playerid, "Ka�de u�ycie komendy przez t� osob�, zostanie Ci wy�wietlone"); 
                }
                else
                {
                    sendErrorMessage(playerid, "Masz ju� w��czony show-spectate! Wyst�pi� b��d."); 
                    return 1;
                }
            }
            else
            {
                sendErrorMessage(playerid, "Nie ma na serwerze takiej osoby!"); 
                return 1;
            }
        }
        else
        {
            playerSeeSpec[playerid] = INVALID_SPECTATE_ID; 
            playerTargetSpec[valueSpec] = INVALID_SPECTATE_ID; 
            sendTipMessage(playerid, "Wy��czy�e� podgl�d spectate"); 
        }
    }
    else 
    {
        noAccessMessage(playerid); 
    }
    return 1;
}

//end