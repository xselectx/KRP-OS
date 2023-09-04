//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ ja ]--------------------------------------------------//
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

YCMD:ja(playerid, params[], help)
{
    if(isnull(params))
    {
        sendTipMessage(playerid, "U¿yj /me [akcja]");
        return 1;
    }
    if(GetPVarInt(playerid, "dutyadmin") == 1)
    {
        sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tego podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");
        return 1;
    }
    new string[256];
    params[0] = tolower(params[0]);
    Log(chatLog, WARNING, "%s me: %s", GetPlayerLogName(playerid), params);

    new text_me[258];
    format(text_me, sizeof text_me, "** %s **", params);
    SetPlayerChatBubble(playerid, params, 0xAD83CDFF, 5.0, 10*1000);

    FirstRP(playerid);

    if(strlen(params) < 78)
    {
        format(string, sizeof(string), "* %s %s", GetNick(playerid), params);
        ProxDetector(15.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
    } else
    {
        new pos = strfind(params, " ", true, strlen(params) / 2);
        if(pos != -1)
        {
            new text[64];

            strmid(text, params, pos + 1, strlen(params));
            strdel(params, pos, strlen(params));

            format(string, sizeof(string), "* %s %s [.]", GetNick(playerid), params);
            ProxDetector(15.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);

            format(string, sizeof(string), "[.] %s", text);
            ProxDetector(15.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
        }
    }
    return 1;
}
