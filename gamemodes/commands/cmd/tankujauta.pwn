//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ tankujauta ]----------------------------------------------//
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

YCMD:tankujauta(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 35)
        {
            for(new c=0;c<CAR_AMOUNT;c++)
			{
				Gas[c] = GasMax;
			}
			
			new string[64];
			format(string, sizeof(string), "AdmCmd: %s zatankowa� wszystkie pojazdy.", GetNickEx(playerid));
			SendPunishMessage(string, playerid);
			Log(adminLog, WARNING, "Admin %s zatankowa� wszystkie pojazdy", GetPlayerLogName(playerid));
			SendClientMessage(playerid, COLOR_GREY, "Wszystkie pojazdy zatankowane ! ");
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid] = iloscInne[playerid]+1;
			}
        }
        else
        {
            noAccessMessage(playerid);
            return 1;
        }
    }
    return 1;
}
