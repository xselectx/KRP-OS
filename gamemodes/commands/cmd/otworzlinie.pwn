//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ otworzlinie ]----------------------------------------------//
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
Otwiera linie 100-150 dla San News. 	
*/


// Notatki skryptera:
/*
	
*/

YCMD:otworzlinie(playerid, params[], help)
{
    if(IsPlayerInGroup(playerid, FRAC_SN) || PlayerInfo[playerid][pLider] == FRAC_SN)
    {
        new lLine;
        if(sscanf(params, "d", lLine)) return sendTipMessage(playerid, "Podaj numer lini, kt�r� chcesz otworzy� np. 100 lub 150");
        if(!(100 <= lLine <= 150)) return sendTipMessage(playerid, "Numer od 100 do 150, co 10.");
        new lStr[128];
        if(lLine > 100 && lLine < 109 ||lLine > 120 && lLine < 129 || lLine > 130 && lLine < 139 ||lLine > 140 && lLine < 149)
        {
            return sendErrorMessage(playerid, "Mo�esz otworzy� jedynie linie 100-110-120-130-140-150!");
        }
        gSNLockedLine[lLine-100] = false;
        format(lStr, 128, "San-SMS: Linia %d zosta�a otworzona przez %s", lLine, GetNick(playerid));
        GroupSendMessage(FRAC_SN, COLOR_YELLOW, lStr);
    }
    else sendErrorMessage(playerid, "Nie jeste� z SN.");
    return 1;
}
