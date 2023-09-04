//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ setzonecontrol ]--------------------------------------------//
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

YCMD:setzonecontrol(playerid, params[], help)
{
    if(IsAHeadAdmin(playerid) || IsAScripter(playerid)) {
        new id, frac;
        if(sscanf(params, "dd", id, frac)) return sendTipMessage(playerid, "U�yj /setzonecontrol [ZoneID] [Owner]");
        if(id < 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Numer od 0");
        if(!IsValidGroup(frac)) return 0;
        ZoneControl[id] = frac;
        MruMySQL_SetZoneControl(frac, id);

        foreach(new i : Player)
        {
            if(IsPlayerInGroup(i, FRAC_GROOVE))
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, ZONE_COLOR_GROOVE | 0x44);
            }
            else if(IsPlayerInGroup(i, FRAC_BALLAS))
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, ZONE_COLOR_BALLAZ | 0x44);
            }
            else if(IsPlayerInGroup(i, FRAC_VAGOS))
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, ZONE_COLOR_VAGOS | 0x44);
            }
            else if(IsPlayerInGroup(i, FRAC_WPS))
            {
                GangZoneHideForPlayer(i, id);
                GangZoneShowForPlayer(i, id, ZONE_COLOR_WPS | 0x44);
            }
        }

        SendClientMessage(playerid, COLOR_GRAD2, "SET.");
    }
    return 1;

}
