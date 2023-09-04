//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ reset_ulepszen ]--------------------------------------------//
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

YCMD:reset_ulepszen(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		if (gPlayerLogged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Nie jeste� zalogowany!");
			return 1;
		}
		if (kaska[playerid] < PRICE_RESET_ULEPSZEN)
		{
			sendTipMessage(playerid, "To kosztuje $"#PRICE_RESET_ULEPSZEN"");
			return 1;
		}
		if (PlayerInfo[playerid][pLevel] < 2)
		{
			sendTipMessage(playerid, "Musisz mie� wi�cej ni� 2 level");
			return 1;
		}
		PlayerInfo[playerid][gPupgrade] = (PlayerInfo[playerid][pLevel]-1)*2;
		PlayerInfo[playerid][pSHealth] = 0.0;
		PlayerInfo[playerid][pAlcoholPerk] = 0;
		PlayerInfo[playerid][pDrugPerk] = 0;
		PlayerInfo[playerid][pMiserPerk] = 0;
		PlayerInfo[playerid][pPainPerk] = 0;
		PlayerInfo[playerid][pTraderPerk] = 0;
		ZabierzKaseDone(playerid, PRICE_RESET_ULEPSZEN);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		format(string, sizeof(string), "   Masz teraz %d niewykorzystanych Punkt�w Ulepszenia !",PlayerInfo[playerid][gPupgrade]);
		SendClientMessage(playerid, COLOR_GRAD2, string);
	}
	return 1;
}
