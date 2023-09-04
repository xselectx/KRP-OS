//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ adminduty ]-----------------------------------------------//
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

YCMD:adminduty(playerid, params[], help)
{
	if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || PlayerInfo[playerid][pZG] >= 1)
	{	
		if(GetPlayerAdminDutyStatus(playerid) == 0)
		{
			if(OnDuty[playerid] > 0 || OnDutyCD[playerid] == 1)
			{
				sendErrorMessage(playerid, "Jesteœ na s³u¿bie IC, graj IC!");  
				return 1;
			}

			new nick[24];
			if(GetPVarString(playerid, "maska_nick", nick, 24))
			{
				SendClientMessage(playerid, COLOR_GREY, " Musisz œci¹gn¹æ maskê z twarzy! (/maska).");
				return 1;
			}
			if(IsAScripter(playerid))
			{
				SetPlayerChatBubble(playerid, "((Skrypter))", COLOR_PANICRED, 70.0, 99999999);
			}
			AdminDutyPlayer(playerid, 1); 
				
			return 1;	
		}
		else if(GetPlayerAdminDutyStatus(playerid) == 1)//Wykonuje zejœcie z duty
		{	
			AdminDutyPlayer(playerid, 0); 
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ administratorem, wiêc nie mo¿esz tego u¿yæ!"); 
		MSGBOX_Show(playerid, "Nie masz uprawnien!", MSGBOX_ICON_TYPE_ERROR);
		return 1; 
	}

	return 1;
}

