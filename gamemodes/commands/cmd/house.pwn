//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ house ]-------------------------------------------------//
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

YCMD:house(playerid, params[], help)
{
    new string[128];

    if(gPlayerLogged[playerid] == 1)
    {
        if(GetPlayerAdminDutyStatus(playerid) == 0)
        {
            if(IsPlayerConnected(playerid))
            {
                if(GUIExit[playerid] == 0)
                {
                    if(PlayerInfo[playerid][pDom] != 0)
                    {
                        NaprawSpojnoscWlascicielaDomu(playerid);
                        format(string, sizeof(string), "Domy/Dom%d.ini", PlayerInfo[playerid][pDom]);
                        if(dini_Exists(string))
                        {
                            Dom[PlayerInfo[playerid][pDom]][hData_DD] = 0;
                            if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
                            {
                                if(Dom[PlayerInfo[playerid][pDom]][hDomNr] == -1)
                                    ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc\nUstaw wej�cie", "Wybierz", "Anuluj");
                                else
                                    ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nOtw�rz\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
                            } else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
                            {
                                if(Dom[PlayerInfo[playerid][pDom]][hDomNr] == -1)
                                    ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc\nUstaw wej�cie", "Wybierz", "Anuluj");
                                else
                                    ShowPlayerDialogEx(playerid, 810, DIALOG_STYLE_LIST, "Panel Domu", "Informacje o domu\nZamknij\nWynajem\nPanel dodatk�w\nO�wietlenie\nSpawn\nKup dodatki\nPomoc", "Wybierz", "Anuluj");
                            }
                        } else
                        {
                            sendErrorMessage(playerid,"Tw�j dom nie istnieje");
                        }
                    } else if(PlayerInfo[playerid][pWynajem] != 0)
                    {
                        format(string, sizeof(string), "Domy/Dom%d.ini", PlayerInfo[playerid][pDom]);
                        if(!dini_Exists(string))
                        {
                            if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 0)
                            {
                                ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nOtw�rz\nSpawn\nPomoc", "Wybierz", "Anuluj");
                            } else if(Dom[PlayerInfo[playerid][pDom]][hZamek] == 1)
                            {
                                ShowPlayerDialogEx(playerid, 8810, DIALOG_STYLE_LIST, "Panel Lokatora", "Informacje o domu\nZamknij\nSpawn\nPomoc", "Wybierz", "Anuluj");
                            }
                        } else
                        {
                            sendErrorMessage(playerid,"Wynajmowany dom nie istnieje");
                        }
                    } else
                    {
                        sendErrorMessage(playerid,"Nie posiadasz w�asnego domu.");
                    }
                }
            }
        } else
        {
            sendErrorMessage(playerid, "Najpierw zejd� ze s�u�by administratora!");
        }
    }
    return 1;
}
