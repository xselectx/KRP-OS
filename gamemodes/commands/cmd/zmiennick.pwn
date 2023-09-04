//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zmiennick ]-----------------------------------------------//
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

YCMD:zmiennick(playerid, params[], help)
{
	new sendername[MAX_PLAYER_NAME];

	if (PlayerInfo[playerid][pLevel] >= 2)
	{
        //Nowy system
        if(PlayerInfo[playerid][pZmienilNick] < 1) return sendTipMessage(playerid, "Nie posidasz pakietu zmiany nicku.");

        if(PlayerInfo[playerid][pDom] == 0)
	    {
	        if(PlayerInfo[playerid][pPbiskey] == 255)
	        {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(isnull(params))
				{
					sendTipMessage(playerid, "U�yj /zmiennick [nowy nick]");
                    sendTipMessage(playerid, "UWAGA!! Przy zmianie nicku kasuje ci si� frakcja/rodzina.", COLOR_PANICRED);
					return 1;
				}
				else
				{
					new nick[24];
					if(GetPVarString(playerid, "maska_nick", nick, 24))
					{
						SendClientMessage(playerid, COLOR_GREY, " Musisz �ci�gn�� mask� z twarzy! (/maska).");
						return 1;
					}

                    if(ChangePlayerName(playerid, params))
                    {
                    	SendClientMessageToAll(COLOR_LIGHTRED, sprintf("%s[%d] zmieni� sobie nick - Nowy nick: %s", sendername,PlayerInfo[playerid][pUID],params));
                    	Log(nickLog, WARNING, "{Player: %s[%d]} zmieni� nick na: %s", sendername, PlayerInfo[playerid][pUID], params);
						PlayerPersonalization[playerid][PERS_GUNSCROLL] = 1;
						ShowPlayerDialogEx(playerid, 70, DIALOG_STYLE_MSGBOX, "Zmiana nicku", "W�a�nie zmieni�e� nick. Nast�puj�ce elementy zosta�y wyzerowane:\n\nPraca\nFrakcja\nWanted Level\nRodzina\nLider\nRanga\nSkin\nZaufany Gracz\n\n\nPami�taj, �e ka�da zmiana nicku jest na wag� z�ota wi�c nie trwo� ich pochopnie!\nJe�eli dosz�o do b��dnej zmiany zg�o� ten fakt pr�dko na forum w panelu strat!\nPami�taj: nowa posta� = nowe �ycie.", "Dalej", "");
                    }
                }
			}
			else
			{
			    sendTipMessage(playerid, "Masz biznes, nie mo�esz zmieni� nicku");
			}
		}
		else
		{
		    sendTipMessage(playerid, "Masz lub wynajmujesz dom, nie mo�esz zmieni� nicku");
		    sendTipMessage(playerid, "U�yj /sprzedajdom lub /unrent");
		}
	}
	else
 	{
 		sendTipMessage(playerid, "Musisz mie� 3 level aby zmieni� sobie nick.");
  	}
	return 1;
}
