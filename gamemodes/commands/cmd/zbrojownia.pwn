//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zbrojownia ]-----------------------------------------------//
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
// Autor: MorasznikPedofil
// Data utworzenia: 29.06.2021

// Opis:
/*
*/


// Notatki skryptera:
/*
	
*/

YCMD:zbrojownia(playerid, params[], help)
{
    new porzadkowy[MAX_PLAYER_NAME];
    GetPlayerName(playerid, porzadkowy, sizeof(porzadkowy));
    if(IsPlayerConnected(playerid))
    {
        if(!GroupPlayerDutyPerm(playerid, PERM_POLICE))
        {
            return sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie grupy, która ma uprawnienia do zbrojowni!");
        }
        new frakcja = GetPlayerGroupUID(playerid, OnDuty[playerid]-1);
        if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby siê uzbroiæ musisz byæ pieszo!");
        if ( IsPlayerInRangeOfPoint(playerid, 10.0, GroupInfo[frakcja][g_Spawn][0], GroupInfo[frakcja][g_Spawn][1], GroupInfo[frakcja][g_Spawn][2]))
        {
            if(GroupInfo[frakcja][g_Mats] >= 75)
            {
                new string[512];
                strcat(string, "Broñ\tMateria³y\nDesert Eagle\t25\nShotgun\t50\nMP5\t75");
                if(GroupPlayerDutyRank(playerid) >= 2) strcat(string, "\nM4\t150");
                if(GroupPlayerDutyRank(playerid) >= 4) strcat(string, "\nSPAS-12\t500");
                ShowPlayerDialogEx(playerid, D_ZBROJOWNIA, DIALOG_STYLE_TABLIST_HEADERS, sprintf("Lista broni (%d mats)", GroupInfo[frakcja][g_Mats]), string, "Kup", "Zamknij");
            }
            else
            {
                sendErrorMessage(playerid, "Brak matsów w sejfie grupy!");
            }
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ na spawnie");
        }
	}
	return 1;
}