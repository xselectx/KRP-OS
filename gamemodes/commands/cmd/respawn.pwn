//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ respawn ]------------------------------------------------//
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

YCMD:respawn(playerid, params[], help)
{
	new string[128];
	
	
	if(Count >= 20)
	{
		if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || IsAScripter(playerid))
		{
			SendClientMessage(playerid,COLOR_YELLOW, "Odliczanie rozpocz�te");
			BroadCast(COLOR_PANICRED, "Uwaga! Za 20 sekund nast�pi respawn nieu�ywanych pojazd�w !");
			format(string, sizeof(string), "AdmCmd: %s [ID: %d] rozpocz�� odliczanie do Respawnu Aut !", GetNickEx(playerid), playerid);
			ABroadCast(COLOR_PANICRED,string,1);
			CountDownVehsRespawn();	
		}
		else
		{
			sendErrorMessage(playerid, "Poczekaj a� sko�czy si� to odliczanie!!!");
		}
	}
	return 1;
}
