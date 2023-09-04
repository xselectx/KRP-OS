//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ atakuj ]------------------------------------------------//
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

YCMD:atakuj(playerid, params[], help)
{
    if(ZONE_DISABLED == 1)
    {
        MSGBOX_Show(playerid, "Opcja_wylaczona", MSGBOX_ICON_TYPE_ERROR);
        return 1;
    }
    new frac;
    for(new i = 0; i < MAX_PLAYER_GROUPS; i++)
    {
        if(PlayerInfo[playerid][pGrupa][i] != 0)
        {
            if(GroupHavePerm(PlayerInfo[playerid][pGrupa][i], PERM_GANG))
            {
                frac = PlayerInfo[playerid][pGrupa][i];
                break;
            }
        }
    }
    if(frac != 0 && GroupRank(playerid, frac) > 3)
    {
        if(GetPVarInt(playerid, "zoneid") == -1) return sendTipMessageEx(playerid, -1, "Nie jestes na strefie.");
        if(ZoneAttack[GetPVarInt(playerid, "zoneid")])
        {
            MSGBOX_Show(playerid, "Wojna_aktualnie_trwa!", MSGBOX_ICON_TYPE_WARNING);
            return 1;
        }
        if(frac != 0)
        {
            if(!ZoneGangLimit[frac]) return MSGBOX_Show(playerid, "Limit_czasowy_trwa", MSGBOX_ICON_TYPE_ERROR);
            if(Zone_CheckPossToAttack(playerid, GetPVarInt(playerid, "zoneid")))
            {
                PoziomPoszukiwania[playerid] += 1;
                if(ZoneControl[GetPVarInt(playerid, "zoneid")] == 0)
                {
                    Zone_StartAttack(GetPVarInt(playerid, "zoneid"), frac, 0);
                }
                else
                {
                    Zone_StartAttack(GetPVarInt(playerid, "zoneid"), frac, ZoneControl[GetPVarInt(playerid, "zoneid")]);
                }
              //  SetPlayerCriminal(playerid, INVALID_PLAYER_ID, "Wojna gangów");
            }
        }
    }
    return 1;
}
