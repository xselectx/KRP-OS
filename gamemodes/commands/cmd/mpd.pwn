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
            format(string, sizeof(string), "[%s:o< Sta� tu %s! Zjed� na pobocze, zga� silnik i oczekuj na podej�cie funkcjonariusza!]",GetNickEx(playerid, true), GroupInfo[OnDuty[playerid]-1][g_Name]);
            ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
            format(string, sizeof(string), "Megafon: Sta� tu %s! Zjed� na pobocze, zga� silnik i oczekuj na podej�cie funkcjonariusza!!!", GroupInfo[OnDuty[playerid]-1][g_Name]);
            SetPlayerChatBubble(playerid,string,COLOR_YELLOW,30.0,8000);
            return 1;
        } else return sendErrorMessage(playerid, "Musisz by� w poje�dzie!");
    }
    else return noAccessMessage(playerid);
}
