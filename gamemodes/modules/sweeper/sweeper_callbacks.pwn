//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  sweeper                                                 //
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
// Autor: AnakinEU
// Data utworzenia: 01.11.2021
//Opis:
/*
	sweeper
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnGameModeExit()
{
	for(new i; i < GetMaxPlayers(); ++i)
	{
	    if(!IsPlayerConnected(i)) continue;
	    if(SweeperJob[i]) ResetSweeperInfo(i, true);
	}
	
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	ResetSweeperInfo(playerid);
	return 1;
}

ptask SweepUpdate[UPDATE_TIME](playerid)
{
	if(SweeperJob[playerid] && GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
	{
		SweeperDistance[playerid] += floatround(GetPlayerDistanceFromPoint(playerid, SweeperLastPos[playerid][0], SweeperLastPos[playerid][1], SweeperLastPos[playerid][2]));
		GetPlayerPos(playerid, SweeperLastPos[playerid][0], SweeperLastPos[playerid][1], SweeperLastPos[playerid][2]);
		
		new string[128];
		format(string, sizeof(string), "~b~~h~Praca czysciciela ulic~n~~n~~w~Wyczyszczono: ~y~%d m", SweeperDistance[playerid]);
		PlayerTextDrawSetString(playerid, SweeperText[playerid], string);
	}
	
	return 1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER && GetVehicleModel(GetPlayerVehicleID(playerid)) == 574 && !SweeperJob[playerid]) GameTextForPlayer(playerid, "~n~~n~~w~Nacisnij ~y~~k~~TOGGLE_SUBMISSIONS~ ~w~aby zaczac prace~n~~b~~h~~h~Czysciciela Ulic", 3000, 3);
	if(oldstate == PLAYER_STATE_DRIVER && SweeperJob[playerid])
	{
	    new money = floatround(SweeperDistance[playerid] * MONEY_PER_METER), string[128];
	    format(string, sizeof(string), "~n~~n~~w~Wyczyszczony dystans: ~b~~h~~h~%d metrow~n~~w~Zarobiono ~g~~h~$%d", SweeperDistance[playerid], money);
	    GameTextForPlayer(playerid, string, 3000, 3);
	    DajKaseDone(playerid, money);
	    ResetSweeperInfo(playerid, true);
	}
	
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_SUBMISSION) && GetVehicleModel(GetPlayerVehicleID(playerid)) == 574 && !SweeperJob[playerid])
	{
	    SweeperText[playerid] = CreatePlayerTextDraw(playerid, 40.000000, 305.000000, "~b~~h~Praca czysciciela ulic~n~~n~~w~Wyczyszczono: ~y~0 metrow");
		PlayerTextDrawBackgroundColor(playerid, SweeperText[playerid], 255);
		PlayerTextDrawFont(playerid, SweeperText[playerid], 1);
		PlayerTextDrawLetterSize(playerid, SweeperText[playerid], 0.240000, 1.100000);
		PlayerTextDrawColor(playerid, SweeperText[playerid], -1);
		PlayerTextDrawSetOutline(playerid, SweeperText[playerid], 1);
		PlayerTextDrawSetProportional(playerid, SweeperText[playerid], 1);
		PlayerTextDrawSetSelectable(playerid, SweeperText[playerid], 0);
		PlayerTextDrawShow(playerid, SweeperText[playerid]);
		
	    SweeperDistance[playerid] = 0;
	    GetPlayerPos(playerid, SweeperLastPos[playerid][0], SweeperLastPos[playerid][1], SweeperLastPos[playerid][2]);
	    SweeperJob[playerid] = true;
	    SendClientMessage(playerid, -1, "Musisz jeŸdziæ po ulicach i je czyœciæ!");
	    SendClientMessage(playerid, -1, "Dostaniesz pieni¹dze, jeœli skoñczysz swoj¹ prace.");

		ACTimerSweeper[playerid] = SetTimerEx("AntyCheatTimerSweeper", 1000, true, "i", playerid);
	}
	
	return 1;
}

forward AntyCheatTimerSweeper(playerid);
public AntyCheatTimerSweeper(playerid)
{
	if(SweeperDistance[playerid] >= ACSweeper[playerid] + 100)
	{
		new string[128];
		ACSweeper[playerid] = 0;
		KillTimer(ACTimerSweeper[playerid]);
		format(string, sizeof(string), "[KICK]AdmWarn: %s[%d] <- Cheater, Teleportation during sweeper work %dm", GetNick(playerid), playerid, (SweeperDistance[playerid] - ACSweeper[playerid]));
		SendAdminMessage(COLOR_YELLOW, string);	
		printf("[KICK][teleport][cheats] Cheater, Teleportation during sweeper work %ds", (SweeperDistance[playerid] - ACSweeper[playerid]));
		ShowPlayerDialogEx(playerid, 10101, DIALOG_STYLE_MSGBOX, "BAN", "Cheater, Teleportation during sweeper work", "OK", "");
       	KickEx(playerid);
	}
	else
	{
		ACSweeper[playerid] = SweeperDistance[playerid];
	}
	return 1;
}

stock ResetSweeperInfo(playerid, bool: removeTD = false)
{
    SweeperJob[playerid] = false;
    SweeperUpdate[playerid] = 0;
    SweeperDistance[playerid] = 0;
	ACSweeper[playerid] = 0;
	KillTimer(ACTimerSweeper[playerid]);
    if(removeTD) PlayerTextDrawDestroy(playerid, SweeperText[playerid]);
    return 1;
}
//end