//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ bwset ]-------------------------------------------------//
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

YCMD:bwset(playerid, params[], help)
{
    if(!IsAHeadAdmin(playerid) && !IsAScripter(playerid)) return noAccessMessage(playerid);
    new togbw;
    if(sscanf(params, "d", togbw)) return sendTipMessage(playerid, "U�yj: /bwset [0 - off, 1 - on]");
    if(togbw == BW) return sendErrorMessage(playerid, sprintf("BW jest ju� %s!", (BW) ? ("w��czone") : ("wy��czone")));
    BW = togbw;
    SendClientMessage(playerid, COLOR_NEWS, sprintf("%s BW.", (BW) ? ("W��czy�e�") : ("Wy��czy�e�")));
    SendClientMessageToAll(COLOR_LIGHTBLUE, sprintf("Admin %s %s automatyczne BW!", GetNickEx(playerid), (BW) ? ("w��czy�") : ("wy��czy�")));
    return 1;
}