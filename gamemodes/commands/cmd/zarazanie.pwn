//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zarazanie ]------------------------------------------------//
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

YCMD:zarazanie(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 1000) return noAccessMessage(playerid);
    new zr;
    if(sscanf(params, "d", zr)) return sendTipMessage(playerid, "U�yj: /zarazanie [0 - off, 1 - on]");
    if(zr == Zarazanie) return SendClientMessage(playerid, COLOR_LIGHTGREEN, sprintf("Zara�anie jest ju� %s!", (zr) ? ("w��czone") : ("wy��czone")));
    Zarazanie = zr;
    SendClientMessage(playerid, COLOR_LIGHTGREEN, sprintf("Zara�anie zosta�o %s!", (Zarazanie) ? ("w��czone") : ("wy��czone")));
    return 1;
}