//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zabierzgps ]------------------------------------------------//
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

YCMD:zabierzgps(playerid, params[], help)
{
	if(IsAPrzestepca(playerid))
	{
        new para1;
        if(sscanf(params, "k<fix>d", para1))
        {
            sendTipMessage(playerid, "U�yj /zabierzgps [playerid/Cz��Nicku]");
            return 1;
        }

        new string[144];
        if(GetDistanceBetweenPlayers(playerid, para1) < 4 && (PlayerInfo[para1][pBW] > 0 || PlayerInfo[para1][pInjury] > 0))
        {
            if(PDGPS == para1)
            {
                PDGPS = -1;
                new pZone[MAX_ZONE_NAME];
			    GetPlayer2DZone(para1, pZone, MAX_ZONE_NAME);
                format(string, sizeof(string), "* %s zabiera nadajnik GPS %s, nast�pnie go niszczy.", GetNick(playerid), GetNick(para1));
                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                format(string, sizeof(string), "* Zabra�e� %s nadajnik GPS. Nadawanie lokalizacji zosta�o przerwane.", GetNick(para1));
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), "=: Sygna� z nadajnika GPS %s zosta� przerwany. Ostatnia lokalizacja: %s :=", GetNick(para1), pZone);
                SendTeamMessage(0, COLOR_YELLOW2, string, PERM_POLICE);
                return ShowPlayerInfoDialog(para1, "Kotnik Role Play", "Zabrano Ci nadajnik GPS."); 
            }
            else
            {
                format(string, sizeof(string), "* Gracz nie ma w��czonego nadajnika GPS.");
                SendClientMessage(playerid, COLOR_GREY, string);
            }
        }
        else
        {
            return ShowPlayerInfoDialog(playerid, "Kotnik Role Play", "Gracz musi by� nieprzytomny lub jeste� za daleko.");     
        }
	}
	return 1;
}