//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ reklama ]------------------------------------------------//
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

YCMD:reklama(playerid, params[], help)
{
	if(!IsAHA(playerid))
	{
		sendErrorMessage(playerid, "Nie jeste� z agencji!");
		return 1;
	}
	if(AntySpam[playerid] == 0)
	{
        new string[128];
		if(PlayerInfo[playerid][pBP] >= 1)
		{
			format(string, sizeof(string), "   Nie mo�esz napisa� na tym czacie, gdy� masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string);
			return 1;
		}
		SendClientMessageToAll(COLOR_WHITE, "|___________ Firma Sprz�taj�ca ___________|");
		SendClientMessageToAll(COLOR_LIGHTBLUE, "Chcesz pozby� si� jakiego� �miecia? Skorzystaj z us�ug ciecia! ((/kontrakt))");
        format(string, sizeof(string), "CMD_Info: /ha u�yte przez %s [%d]", GetNick(playerid), playerid);
        SendCommandLogMessage(string);
		foreach(new i : Player)
		{
			if(PlayerInfo[i][pAdmin] == 0 && PlayerInfo[i][pNewAP] == 0 && (IsPlayerInGroup(i, 8) || PlayerInfo[i][pLider] == 8))
			{
				SendClientMessage(i, 0xD8C173FF, string);
			}
		}
        Log(warningLog, WARNING, "%s u�y� /ha", GetPlayerLogName(playerid));
		AntySpam[playerid] = 1;
		SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
	}
	else
	{
		sendTipMessage(playerid, "Odczekaj 10 sekund");
	}
	return 1;
}
