//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ globaldo ]-------------------------------------------------//
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

YCMD:globaldo(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 1000 && !IsAGameMaster(playerid)) return noAccessMessage(playerid);
    if(isnull(params))
        return sendTipMessage(playerid, "U¿yj: /globaldo [akcja]");
    new string[400];
    Log(chatLog, WARNING, "%s globaldo: %s", GetPlayerLogName(playerid), params);
    SendCommandLogMessage(sprintf("CMD_Info: /globaldo u¿yte przez %s [%d]", GetNick(playerid), playerid));

    if(strlen(params) < 78)
    {
        format(string, sizeof(string), "(globalne) * %s (( %s ))", params, GetNickEx(playerid));
        SendClientMessageToAll(COLOR_DO, string);
    } else
    {
        new pos = strfind(params, " ", true, strlen(params) / 2);
        if(pos != -1)
        {
            new text[64];

            strmid(text, params, pos + 1, strlen(params));
            strdel(params, pos, strlen(params));

            format(string, sizeof(string), "(globalne) * %s [.]", params);
            SendClientMessageToAll(COLOR_DO, string);

            format(string, sizeof(string), "[.] %s (( %s ))", text, GetNickEx(playerid));
            SendClientMessageToAll(COLOR_DO, string);
        }
    }
    return 1;
}
