//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ caluj ]-------------------------------------------------//
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

YCMD:caluj(playerid, params[], help)
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U�yj /caluj [ID gracza]");
			return 1;
		}
		if(PlayerInfo[playerid][pInjury])
		{
			sendErrorMessage(playerid, "Nie mo�esz ca�o�� si� w trakcie obecnego statusu (ranny)!"); 
			return 1;
		}
		if(playa == playerid)
		{
			sendErrorMessage(playerid, "Nie mo�esz poca�owa� samego siebie!"); 
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playa) == 1)
		{
			sendErrorMessage(playerid, "Nie mo�esz ca�owa� administratora!"); 
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo�esz ca�owa� si� b�d�c na s�u�bie @"); 
			return 1;
		}
		if(dialAccess[playerid] == 1)
		{
			sendErrorMessage(playerid, "Musisz odczeka� 15 sekund przed ponownym poca�unkiem!"); 
			return 1;
		}
		if (ProxDetectorS(5.0, playerid, playa) && Spectate[playa] == INVALID_PLAYER_ID)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					dialAccess[playa] = 0; 
					format(string, sizeof(string), "%s chce si� z tob� poca�owa� - je�li go kochasz kliknij ''Ca�uj''!", GetNick(playerid));
  					ShowPlayerDialogEx(playa, 1092, DIALOG_STYLE_MSGBOX, "Kotnik Role Play - poca�unek", string, "Ca�uj", "Odrzu�", false);
					ShowPlayerInfoDialog(playerid, "Kotnik Role-Play", "Zaoferowa�e� poca�unek - oczekuj na reakcje!", true);
					format(string, sizeof(string), "Zaoferowa�e� poca�unek %s - oczekuj na reakcje!", GetNick(playa));
					sendTipMessage(playerid, string);
					kissPlayerOffer[playa] = playerid;
				}
			}
		}
		else
		{
			sendErrorMessage(playerid, "Jeste� za daleko !");
		}
	}
	return 1;
}
