//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ uwb ]--------------------------------------------------//
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

YCMD:uwb(playerid, params[], help)//usu� wszystkie bronie
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendTipMessage(playerid, "Najpierw zejd� z @DUTY!"); 
			return 1;
		}
		ResetPlayerWeapons(playerid);
		UsunBron(playerid);
		sendTipMessage(playerid, "Wszystkie bronie usuni�te");
		//komunikat o wyrzuceniu
		new string[256];
		format(string, sizeof(string), "%s wyrzuca na ziemie swoj� zepsut� bro�.", GetNick(playerid)); 
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	return 1;
}
