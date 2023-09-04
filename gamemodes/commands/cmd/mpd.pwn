//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ mpd ]--------------------------------------------------//
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
	stac tu pd bind
*/

YCMD:mpd(playerid, params[], help)
{
    if(IsAPolicja(playerid) && OnDuty[playerid] > 0) 
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new string[144];
            format(string, sizeof(string), "[%s:o< Staæ tu %s! ZjedŸ na pobocze, zgaœ silnik i oczekuj na podejœcie funkcjonariusza!]",GetNickEx(playerid, true), GroupInfo[OnDuty[playerid]-1][g_Name]);
            ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
            format(string, sizeof(string), "Megafon: Staæ tu %s! ZjedŸ na pobocze, zgaœ silnik i oczekuj na podejœcie funkcjonariusza!!!", GroupInfo[OnDuty[playerid]-1][g_Name]);
            SetPlayerChatBubble(playerid,string,COLOR_YELLOW,30.0,8000);
            return 1;
        } else return sendErrorMessage(playerid, "Musisz byæ w pojeŸdzie!");
    }
    else return noAccessMessage(playerid);
}
