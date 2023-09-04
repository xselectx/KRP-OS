//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ ado ]-------------------------------------------------//
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

YCMD:ado(playerid, params[], help)
{
    if(GetPVarInt(playerid, "CommandSpam") > gettime()) return sendErrorMessage(playerid, "Odczekaj 15 sekund przed wys³aniem kolejnej wiadomoœci.");
    if(isnull(params))
        return sendTipMessage(playerid, "U¿yj: /ado [tekst]");
    new door = GetClosestDoor(playerid), business = GetNearestBusiness(playerid), string[400], string2[200];
    if(door == 0 && business == INVALID_BIZ_ID)
        return sendTipMessage(playerid, "Nie znajdujesz siê przy drzwiach!");
    if(strlen(params) < 78) 
        format(string, sizeof string, "(drzwi) * %s (( %s ))", params, GetNickEx(playerid));
    else
    {
        new pos = strfind(params, " ", true, strlen(params) / 2);
        if(pos != -1)
        {
            new text[64];

            strmid(text, params, pos + 1, strlen(params));
            strdel(params, pos, strlen(params));

            format(string, sizeof(string), "(drzwi) * %s [.]", params);

            format(string2, sizeof(string2), "[.] %s (( %s ))", text, GetNickEx(playerid));
        }
    }
    SendClientMessage(playerid, COLOR_DO, string);
    if(strlen(string2)) SendClientMessage(playerid, COLOR_DO, string2);
    SetPVarInt(playerid, "CommandSpam", gettime()+15);
    new count = 0;
    foreach(new i : Player)
    {
        if(business && PlayerInfo[i][pInBiz] != business) continue;
        if(door && PlayerInfo[i][pDoor] != door) continue;
        if(!IsPlayerInRangeOfPoint(i, 50.0, wejscia[door][w_x2], wejscia[door][w_y2], wejscia[door][w_z2])) continue;
        SendClientMessage(i, COLOR_DO, string);
        if(strlen(string2)) SendClientMessage(i, COLOR_DO, string2);
        count++;
    }
    if(!count) return sendErrorMessage(playerid, "W interiorze nikogo nie ma.");
    return 1;
}