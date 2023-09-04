//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   motel                                                   //
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
// Autor: xSeLeCTx
// Data utworzenia: 15.05.2021


//

//------------------<[ Implementacja: ]>-------------------
command_motel_Impl(playerid, action[64])
{
    new motelID = Motel_GetCurrent(playerid, false, false, true, true); // Sprawdza czy gracz jest w motelu
    if(motelID != -1)
    {
        if(PlayerInfo[playerid][pMotRoom] == 0 && GetPlayerVirtualWorld(playerid) < MOTEL_VW)
        {
            if(strfind(action, "wyn", true) != -1 || strfind(action, "ren", true) != -1) {
                return Motele_OnDialogResponse(playerid, DIALOG_MOTEL, true, 0, ""); // Skip dialogu do w³aœciwej opcji (Wynajem)
            }
            else if(strfind(action, "wej", true) != -1 || strfind(action, "ent", true) != -1) {
                return Motele_OnDialogResponse(playerid, DIALOG_MOTEL, true, 1, ""); // Skip dialogu do w³aœciwej opcji (WejdŸ, input z numerem pokoju)
            }
            ShowPlayerDialogEx(playerid, DIALOG_MOTEL, DIALOG_STYLE_LIST, sprintf("{e8c205} %s",Motels[motelID][motName]), "» Wynajmij pokój\n» WejdŸ", "Wybierz", "Anuluj");
        }
        else
        {
            if(strfind(action, "wej", true) != -1 || strfind(action, "ent", true) != -1 || strfind(action, "wyj", true) != -1 || strfind(action, "exi", true) != -1) {
                return Motele_OnDialogResponse(playerid, DIALOG_MOTEL_WHERE, true, 0, ""); // Skip dialogu do w³aœciwej opcji (WejdŸ do siebie)
            }
            else if(strfind(action, "zar", true) != -1 || strfind(action, "mana", true) != -1 ) {
                return Motele_OnDialogResponse(playerid, DIALOG_MOTEL_2, true, 1, ""); // Skip dialogu do w³aœciwej opcji (Zarz¹dzaj);
            }
            if(GetPlayerVirtualWorld(playerid) < MOTEL_VW) { // Gracz jest w motelu
                ShowPlayerDialogEx(playerid, DIALOG_MOTEL_2, DIALOG_STYLE_LIST, sprintf("{e8c205} %s",Motels[motelID][motName]), "» WejdŸ\n» Zarz¹dzaj\n» Ustaw spawn\n» Zrezygnuj z wynajmu", "Wybierz", "Anuluj");
            } else { // Gracz jest w pokoju
                ShowPlayerDialogEx(playerid, DIALOG_MOTEL_2, DIALOG_STYLE_LIST, sprintf("{e8c205} %s",Motels[motelID][motName]), "» WyjdŸ\n» Zarz¹dzaj\n» Ustaw spawn\n» Zrezygnuj z wynajmu", "Wybierz", "Anuluj");
            }
        }
    }
    else return sendTipMessage(playerid, "Musisz byæ w motelu");
    return 1;
}

//end