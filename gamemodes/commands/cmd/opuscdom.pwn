//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ opuscdom ]-----------------------------------------------//
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

YCMD:opuscdom(playerid, params[], help)
{
	new string[128];

    if(gPlayerLogged[playerid] == 1)
    {
	    if(PlayerInfo[playerid][pDom] != 0)
	    {
			if(Dom[PlayerInfo[playerid][pDom]][hKupiony] != 0)
			{
			    if(IsPlayerInRangeOfPoint(playerid, 5.0, Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y], Dom[PlayerInfo[playerid][pDom]][hWej_Z]))
			    {
			        if(Dom[PlayerInfo[playerid][pDom]][hBlokada] == 0)
			        {
			            if(GUIExit[playerid] == 0)
	    				{
							new cenadomu = Dom[PlayerInfo[playerid][pDom]][hCena];
							format(string, sizeof(string), "Czy na pewno chcesz opu�ci� ten dom?\nZarobisz na tym tylko %d$, wszystkie przedmioty i ulepszenia domu przepadn�", cenadomu/2);
						    ShowPlayerDialogEx(playerid, 87, DIALOG_STYLE_MSGBOX, "Opuszczanie domu", string, "Tak", "Nie");
						}
					}
					else
					{
					    sendErrorMessage(playerid, "Masz zablokowan� mo�liwo�� opuszczenia tego domu.");
					}
				}
				else
				{
				    sendTipMessage(playerid, "Aby opu�ci� dom musisz sta� przed nim.");
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Tw�j dom nie jest kupiony (???) Zg�o� ten b��d na forum.");
			}
	    }
	    else
	    {
	        sendErrorMessage(playerid, "Nie masz wlasnego domu.");
	    }
	}
	return 1;
}
