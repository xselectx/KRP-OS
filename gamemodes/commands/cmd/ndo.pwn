//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ ndo ]--------------------------------------------------//
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

YCMD:ndo(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 1 && !IsAGameMaster(playerid)) return noAccessMessage(playerid);
    if(isnull(params))
    {
        sendTipMessage(playerid, "U¿yj /ndo [opis sytuacji]");
        return 1;
    }
    new string[256];
    
    params[0] = toupper(params[0]);
    if(strlen(params) < 78)
    {
        //format(string, sizeof(string), "* %s %s", GetNick(playerid, true), params);
        format(string, sizeof(string), "* %s (( Narrator ))", params);
        ProxDetector(25.0, playerid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);
    }
    else
    {
        new pos = strfind(params, " ", true, strlen(params) / 2);
        if(pos != -1)
        {
            new text[64];

            strmid(text, params, pos + 1, strlen(params));
            strdel(params, pos, strlen(params));

            format(string, sizeof(string), "* %s [.]", params);
            ProxDetector(25.0, playerid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);

            format(string, sizeof(string), "[.] %s (( Narrator ))", text);
            ProxDetector(25.0, playerid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);
	        Log(chatLog, WARNING, "%s /ndo: %s", GetPlayerLogName(playerid), params);
        }
    }
    return 1;
}