//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ do ]--------------------------------------------------//
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

YCMD:do(playerid, params[], help)
{
    if(isnull(params))
    {
        sendTipMessage(playerid, "U�yj /do [opis sytuacji]");
        return 1;
    }
	if(GetPVarInt(playerid, "dutyadmin") == 1)
	{
		sendErrorMessage(playerid, "Nie mo�esz u�y� tego podczas @Duty! Zejd� ze s�u�by u�ywaj�c /adminduty");
		return 1;
	}
    new string[256];
    
    params[0] = toupper(params[0]);
    if(strlen(params) < 78)
    {
        //format(string, sizeof(string), "* %s %s", GetNick(playerid, true), params);
        format(string, sizeof(string), "* %s (( %s ))", params, GetNick(playerid));
        ProxDetector(15.0, playerid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);
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
            ProxDetector(15.0, playerid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);

            format(string, sizeof(string), "[.] %s (( %s ))", text, GetNick(playerid));
            ProxDetector(15.0, playerid, string, COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO,COLOR_DO);
	        Log(chatLog, WARNING, "%s /do: %s", GetPlayerLogName(playerid), params);
        }
    }
    return 1;
}
