//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ unbwall ]-------------------------------------------------//
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

YCMD:unbwall(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 1000) return noAccessMessage(playerid);
	foreach(new i : Player)
    {
        ZdejmijBW(i, 0);
        SetPlayerChatBubble(i, " ", 0xFF0000FF, 100.0, 1000);
        SetPlayerHealth(i, 100);
    }
    if(GetPlayerAdminDutyStatus(playerid) == 1) iloscInne[playerid] = iloscInne[playerid]+1;
    SendClientMessageToAll(COLOR_LIGHTBLUE, sprintf("Admin %s zdj�� ka�demu BW.", GetNickEx(playerid)));
    return 1;
}