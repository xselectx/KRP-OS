//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     ac                                                    //
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
// Autor: Mrucznik
// Data utworzenia: 16.09.2019


//

//------------------<[ Implementacja: ]>-------------------
ac2_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused inputtext
    if(dialogid == DIALOG_AC_PANEL)
    {
        if(response)
        {
            if(strfind(inputtext, "»»", true) != -1) return ac_ShowDialog(playerid, GetPVarInt(playerid, "ac_page")+1);
    	    if(strfind(inputtext, "««", true) != -1) return ac_ShowDialog(playerid, GetPVarInt(playerid, "ac_page")-1);
            new kod = listitem + (GetPVarInt(playerid, "ac_page")-1)*50;

            new string[256];
            DynamicGui_SetDialogValue(playerid, kod);

            for(new eNexACAdditionalSettings:i; i<eNexACAdditionalSettings; i++)
            {
                strcat(string, GetNexACAdditionalSettingName(i));
                strcat(string, "\n");
            }
            ShowPlayerDialogEx(playerid, DIALOG_AC_PANEL_CHANGE, DIALOG_STYLE_LIST, "Panel Anty-Cheat'a", 
                string,
                "Ustaw", "WyjdŸ");
        }
        return 1;
    }
    else if(dialogid == DIALOG_AC_PANEL_CHANGE)
    {
        if(response)
        {
            new code = DynamicGui_GetDialogValue(playerid);
            new eNexACAdditionalSettings:type = eNexACAdditionalSettings:listitem;
            NexACSaveCode(code, type);
            Log(adminLog, WARNING, "Admin %s ustawi³ funkcjê anty-cheata %s[%d] na %s", 
                GetPlayerLogName(playerid), NexACDecodeCode(code), code, GetNexACAdditionalSettingName(type));
            ac_ShowDialog(playerid, GetPVarInt(playerid, "ac_page"));
        }
        return 1;
    }
    return 0;
}

ac_ShowDialog(playerid, page = 1)
{
    new string[70*60];
    new pages = floatround(sizeof(nexac_ac_names)/50, floatround_ceil)+1;
    new maxkody;
    if(sizeof(nexac_ac_names) <= page*50) maxkody = sizeof(nexac_ac_names);
    else maxkody = page*50;
    for(new i = page*50-50; i<maxkody; i++)
    {
        if(IsAntiCheatEnabled(i)) 
        {
            strcat(string, sprintf("{00FF00}%s[%d] - %s{FFFFFF}\n", nexac_ac_names[i], i, GetNexACAdditionalSettingName(nexac_additional_settings[i])));
        }
        else
        {
            strcat(string, sprintf("{FF0000}%s[%d] - OFF{FFFFFF}\n", nexac_ac_names[i], i));
        }
    }
    if(page > 1) strcat(string, "«« Poprzednia strona");
   	if(sizeof(nexac_ac_names) > (page*50)) strcat(string, "\n»» Nastêpna strona");
   	SetPVarInt(playerid, "ac_page", page);
    ShowPlayerDialogEx(playerid, DIALOG_AC_PANEL, DIALOG_STYLE_LIST, sprintf("Panel Anty-Cheat'a (%d/%d)", page, pages), string, "Zmieñ", "WyjdŸ");
    return 1;
}

command_ac_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 1000 || IsAScripter(playerid))
	{
        ac_ShowDialog(playerid);
	}
    return 1;
}

//end