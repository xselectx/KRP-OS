//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setname ]------------------------------------------------//
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

YCMD:setname(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

	new newname[MAX_PLAYER_NAME];
	if (PlayerInfo[playerid][pAdmin] >= 5000 || Uprawnienia(playerid, ACCESS_SETNAME) || IsAScripter(playerid))//(Uprawnienia(playerid, ACCESS_OWNER))
	{
		new giveplayerid;
		if( sscanf(params, "k<fix>s[25]", giveplayerid, newname))
		{
			sendTipMessage(playerid, "U�yj /setname [playerid] [nowynick]");
			return 1;
		}
		if(strlen(newname) >= MAX_PLAYER_NAME)
		{
			format(string, sizeof(string), "Nowy nick nie mo�e by� d�u�szy jak %d znak�w", MAX_PLAYER_NAME); 
			sendErrorMessage(playerid, string); 
			return 1;
		}
		new nick[24];
		if(GetPVarString(giveplayerid, "maska_nick", nick, 24))
		{
			SendClientMessage(playerid, COLOR_GREY, " Gracz musi �ci�gn�� mask� z twarzy! (/maska).");
			return 1;
		}

		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    if(PlayerInfo[giveplayerid][pDom] == 0)
		    {
		        if(PlayerInfo[giveplayerid][pBusinessOwner] == INVALID_BIZ_ID)
		        {
                    GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
					new sender_log_name[50];
					new giveplayer_log_name[50];
					format(sender_log_name, sizeof(sender_log_name), "%s", GetPlayerLogName(playerid));
					format(giveplayer_log_name, sizeof(giveplayer_log_name), "%s", GetPlayerLogName(giveplayerid));
                    if(ChangePlayerName(giveplayerid, newname))
                    {
    					format(string, sizeof(string), "Administrator %s zmieni� nick %s[%d] - Nowy nick: %s", GetNickEx(playerid),giveplayer,PlayerInfo[giveplayerid][pUID],newname);
    					SendClientMessageToAll(COLOR_LIGHTRED, string);
						Log(adminLog, WARNING, "Admin %s zmieni� %s nick na %s", sender_log_name, giveplayer_log_name, newname);
						Log(nickLog, WARNING, "Admin %s zmieni� %s nick na %s", sender_log_name, giveplayer_log_name, newname);

                        ShowPlayerDialogEx(giveplayerid, 70, DIALOG_STYLE_MSGBOX, "Zmiana nicku", "W�a�nie zmieni�e� nick. Nast�puj�ce elementy zosta�y wyzerowane:\n\nPraca\nWanted Level\nSkin\nZaufany Gracz\n\n\nPami�taj, �e ka�da zmiana nicku jest na wag� z�ota wi�c nie trwo� ich pochopnie!\nJe�eli dosz�o do b��dnej zmiany zg�o� ten fakt pr�dko na forum w panelu strat!\nPami�taj: nowa posta� = nowe �ycie.", "Dalej", "");

    					SetPlayerName(giveplayerid, newname);
                    }
				}
				else
				{
				    sendErrorMessage(playerid, "Ten gracz ma biznes, nie mo�esz zmieni� mu nicku");
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Ten gracz ma dom, nie mo�esz zmieni� mu nicku");
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d nie jest aktywnym graczem.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
