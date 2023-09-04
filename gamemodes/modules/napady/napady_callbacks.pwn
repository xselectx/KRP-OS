//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: napady.pwn ]------------------------------------------//
//----------------------------------------[ Autor: renosk ]----------------------------------------//

#include <YSI_Coding\y_hooks>


hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case D_LISTANAPADOW:
        {
            if(!response) return 1;
            new id = Iter_Index(Heists, listitem);
            if(!Heist[id][h_UID]) return sendTipMessage(playerid, "Wyst¹pi³ nieoczekiwany b³¹d.");
            SetPlayerPos(playerid, Heist[id][h_Pos][0], Heist[id][h_Pos][1], Heist[id][h_Pos][2]);
            SetPlayerInteriorEx(playerid, Heist[id][h_INT]);
            SetPlayerVirtualWorld(playerid, Heist[id][h_VW]);
            _MruGracz(playerid, sprintf(" Przeteleportowano do napadu o ID: %d", id));
        }
        case D_NAPAD_C_CONFIRM:
        {
            if(!response) return 1;
            new cash = GetPVarInt(playerid, "Heist-Cash"), int = GetPlayerInterior(playerid), vw = GetPlayerVirtualWorld(playerid), Float:Pos[3], name[64];
            GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
            GetPVarString(playerid, "Heist-Name", name, 64);
            new heist = CreateHeist(name, cash, Pos[0], Pos[1], Pos[2], int, vw);
            if(heist == -1) return sendTipMessage(playerid, "Wyst¹pi³ nieoczekiwany b³¹d przy tworzeniu napadu.");
            else _MruGracz(playerid, sprintf(" Pomyœlnie stworzono napad o UID: %d", Heist[heist][h_UID]));
        }
    }
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    Heist_Fail(playerid, killerid);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    RobberyText[playerid] = CreatePlayerTextDraw(playerid, 40.000000, 295.000000, "_");
	PlayerTextDrawBackgroundColor(playerid, RobberyText[playerid], 255);
	PlayerTextDrawFont(playerid, RobberyText[playerid], 1);
	PlayerTextDrawLetterSize(playerid, RobberyText[playerid], 0.240000, 1.100000);
	PlayerTextDrawColor(playerid, RobberyText[playerid], -1);
	PlayerTextDrawSetOutline(playerid, RobberyText[playerid], 1);
	PlayerTextDrawSetProportional(playerid, RobberyText[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, RobberyText[playerid], 0);

    PlayerHeist[playerid][p_Heist] = -1;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(PlayerHeist[playerid][p_Heist] > -1) Heist_Reset(PlayerHeist[playerid][p_Heist]);
    for(new z = 0; _playerheistdata:z != _playerheistdata; z++) PlayerHeist[playerid][_playerheistdata:z] = 0;
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_NO)
    {

        if(GetPVarInt(playerid, "ROBBING_DOORS") == 1)
        {
            RTH[openeedd] = false;
            TextDrawInfooff(playerid,"");
            SetPVarInt(playerid, "ROBBING_DOORS", 0);
            KillTimer(RTH[TimerKickdooorss]);
            RTH[TimerKickdooorss] = 0;
            RTH[TimeToKick] = DOORKICKTIME;
            ClearAnimations(playerid);
            TogglePlayerControllable(playerid, 1);
            RTH[WaitTime] = 0;
            Unlockdooorss();
            ClearAnimations(playerid);
            SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
        }
        else if(GetPVarInt(playerid, "ROBBING_SAFE") == 1)
        {
            if(RTH[TimeToRob1] > 0)
            {
                SetPVarInt(playerid, "ROBBING_SAFE", 0);
                KillTimer(RTH[TimerRobbing1]);
                RTH[safeopeneedd1] = false;
                RTH[TimerRobbing1] = 0;
                RTH[TimeToRob1] = SAFEROBTIME;
                ClearAnimations(playerid);
                TogglePlayerControllable(playerid, 1);
                TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
                TextDrawInfooff(playerid,"");
                UpdateDynamic3DTextLabelText(RTH[textsafee1], COLOR_LIGHTGREENNAPAD, "{1FA7FF}Sejf\nWpisz {FFFFFF}/wlamanie {1FA7FF}aby w³amaæ siê do sejfu");
            }
        }
        else if(GetPVarInt(playerid, "ROBBING_SAFE") == 2)
        {
            if(RTH[TimeToRob1] > 0)
            {
                SetPVarInt(playerid, "ROBBING_SAFE", 0);
                KillTimer(RTH[TimerRobbing2]);
                RTH[safeopeneedd2] = false;
                RTH[TimerRobbing2] = 0;
                RTH[TimeToRob2] = SAFEROBTIME;
                ClearAnimations(playerid);
                TogglePlayerControllable(playerid, 1);
                TextDrawHideForPlayer(playerid, TextDrawInfo[playerid]);
                TextDrawInfooff(playerid,"");
                UpdateDynamic3DTextLabelText(RTH[textsafee2], COLOR_LIGHTGREENNAPAD, "{1FA7FF}Sejf\nWpisz {FFFFFF}/wlamanie {1FA7FF}aby w³amaæ siê do sejfu");
            }
        }
    }
		
    return 1;
}