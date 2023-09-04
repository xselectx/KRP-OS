//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ czysc ]-------------------------------------------------//
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

YCMD:czysc(playerid, params[], help)
{
    if(!GroupPlayerDutyPerm(playerid, PERM_FIREDEPT)) return sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jesteœ na s³u¿bie grupy z takimi uprawnieniami.");
    if(JobDuty[playerid] == 0 && OnDuty[playerid] == 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Nie jesteœ na s³u¿bie.");
    new Float:lPos[3];
    GetPlayerPos(playerid, lPos[0], lPos[1], lPos[2]);
    new lID = Oil_GetIDAtPosition(lPos[0], lPos[1], lPos[2], 2.5);
    if(lID == -1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Brak plam w pobli¿u.");
    if(GetPVarInt(playerid, "oil_clear") == 0)
    {
        Oil_LoadCleanProcedure(playerid);
        SetPVarInt(playerid, "oil_clear", 1);
        SetPVarInt(playerid, "oil_id", lID);
        TogglePlayerControllable(playerid, 0);
    }
    else
    {
        Oil_UnloadPTXD(playerid);
        SetPVarInt(playerid, "oil_clear", 0);
        TogglePlayerControllable(playerid, 1);
        TextDrawShowForPlayer(playerid, OilTXD_BG[0]);
        TextDrawShowForPlayer(playerid, OilTXD_BG[1]);
    }
    return 1;
}
