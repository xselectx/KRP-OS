// 2355.9321, -652.5734, 128.0547 // Drwal_Marker
// 2351.5801, -653.5382, 128.0547 // Drwal_Donies
// 2304.2861, -644.8680, 132.6271 // Drwal_Drzewo1
// "2320.4204", "-659.1718", "129.9130" // Drwal_Drzewo2
// "2316.7222", "-677.6136", "130.3099" // Drwal_Drzewo3

//  #define COLOR_GREEN 0x33AA33AA
//  #define COLOR_LIGHTBLUE 0x33CCFFAA
//  #define COLOR_BROWN 0x8F4747FF
#include <YSI_Coding\y_hooks>

#define DRWAL_MONEY 80
#define DRWAL_ATTACH_ID 9


new DrzewoObject[MAX_PLAYERS][3];
new DrzewoIcon[MAX_PLAYERS];
new DrzewoRandom[MAX_PLAYERS];
new DrzewoStage[MAX_PLAYERS];
new DrzewoStage2[MAX_PLAYERS];
new DrzewoNiesie[MAX_PLAYERS];
new DrzewoTimer[MAX_PLAYERS];
new DrzewoTimerActions[MAX_PLAYERS];
new DrzewoTimerQuit[MAX_PLAYERS];
new DrzewoWykonuje[MAX_PLAYERS];

new Float:Drwal_Drzewa[][3] = 
{
    {2304.2861,	-644.8680, 132.6271}, 
    {2320.4204, -659.1718, 129.9130},
    {2316.7222, -677.6136, 130.3099}
};

new Float:Drwal_Lokacje[][3] =
{
	{2355.9321, -652.5734, 128.0547}, // praca /drwal
	{2351.5801, -653.5382, 128.0547}  // œrodek tartaku - donoszenie drzew
};

forward Drwal_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
forward Drwal_Timer(playerid);
forward Drwal_Timer_Quit(playerid);
forward Drwal_Timer_Actions(playerid, etap, time);

public Drwal_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == D_DRWAL)
	{
		if(response)
		{
			Drwal_Start(playerid);
		 	return 1;
		}
		else return 1;
	}
	return 1;
}


public Drwal_Timer(playerid)  // timer przynoszenia drzewa do tartaku
{
	if(IsPlayerInRangeOfPoint(playerid, 3, Drwal_Lokacje[1][0], Drwal_Lokacje[1][1], Drwal_Lokacje[1][2]))
	{
		DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 100, false, "ddd", playerid, 4, 3);
  		
	}
	return 1;
}

public Drwal_Timer_Quit(playerid)  // timer anty-ucieczka
{
	if(!IsPlayerInRangeOfPoint(playerid, 250, Drwal_Lokacje[0][0], Drwal_Lokacje[0][1], Drwal_Lokacje[0][2]))
	{
		GameTextForPlayer(playerid, "~r~Anulowano!", 3000, 4);
		Drwal_End(playerid);
	}
	return 1;
}

public Drwal_Timer_Actions(playerid, etap, time) // g³ówny timer wszystkich czynnoœci.
{
	new i = DrzewoRandom[playerid];

	if(etap == 1)
	{
		if(time != 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2]))
			{
				new string[64];
				// TogglePlayerControllable(playerid, false);
				ClearAnimations(playerid, 1);
				ApplyAnimation(playerid,"CHAINSAW","CSAW_G",4.0,0,1,1,1,1);
				format(string, sizeof(string), "~g~Scinanie drzewa~w~ %d~g~s", time);
				GameTextForPlayer(playerid, string, 1200, 4);
				DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 1000, false, "ddd", playerid, 1, time-1);
			} else {
				GameTextForPlayer(playerid, "~r~ Wroc do drzewa!", 2500, 4);
				DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 1000, false, "ddd", playerid, 1, time);
			}
		}
		else
		{
			GameTextForPlayer(playerid, "~g~Drzewo zostalo sciete", 1200, 4);
			// TogglePlayerControllable(playerid, true);
			ClearAnimations(playerid, 1);
			SendClientMessage(playerid, COLOR_GREEN, 	 "-------------- {FFFFFF}DRWAL {33AA33}--------------");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Gratulacje! Uda³o Ci siê œci¹æ drzewo");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Teraz musisz je por¹baæ na mniejsze kawa³ki, wpisz {FFFFFF}/porab");
			DestroyDynamicObject(DrzewoObject[playerid][0]);
			DrzewoObject[playerid][0] = CreateDynamicObject(836, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2], 0, 0, 0, 0, 0, -1);
			DrzewoStage2[playerid] = 2;
		    DrzewoWykonuje[playerid] = 0;
			return 1;
		}
	} 
	else if(etap == 2)
	{
		if(time != 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2]))
			{
				new string[64];
				// TogglePlayerControllable(playerid, false);
				ClearAnimations(playerid, 1);
				ApplyAnimation(playerid,"CHAINSAW","CSAW_G",4.0,0,1,1,1,1);
				format(string, sizeof(string), "~g~Scinanie drzewa~w~ %d~g~s", time);
				GameTextForPlayer(playerid, string, 1200, 4);
				DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 1000, false, "ddd", playerid, 2, time-1);
			} else {
				GameTextForPlayer(playerid, "~r~ Wroc do drzewa!", 2500, 4);
				DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 1000, false, "ddd", playerid, 2, time);
			}
		}
		else
		{
			GameTextForPlayer(playerid, "~g~Drzewo zostalo sciete", 1200, 4);
			//new i = DrzewoRandom[playerid];
			// TogglePlayerControllable(playerid, true);
			ClearAnimations(playerid, 1);

			SendClientMessage(playerid, COLOR_GREEN, 	 "-------------- {FFFFFF}DRWAL {33AA33}--------------");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Dobrze! Teraz musisz zanieœæ wszystkie kawa³ki do tartaku!");
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Aby to zrobiæ wpisz {FFFFFF}/podnies");

			DestroyDynamicObject(DrzewoObject[playerid][0]);
			DrzewoObject[playerid][0] = CreateDynamicObject(19793, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2]-0.5, 120, 0, 0, 0, 0, -1);
			DrzewoObject[playerid][1] = CreateDynamicObject(19793, Drwal_Drzewa[i][0]+3, Drwal_Drzewa[i][1], Drwal_Drzewa[i][2]-0.5, 120, 0, 0, 0, 0, -1);
			DrzewoObject[playerid][2] = CreateDynamicObject(19793, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1]+3, Drwal_Drzewa[i][2]-0.5, 120, 0, 0, 0, 0, -1);
			DrzewoStage2[playerid] = 3;
			DrzewoWykonuje[playerid] = 0;
			RemovePlayerAttachedObject(playerid, DRWAL_ATTACH_ID);
			return 1;
		}
	}
	else if(etap == 3)
	{
		if(time != 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 5, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2]))
			{
				new string[64];
				// TogglePlayerControllable(playerid, false);
				ClearAnimations(playerid, 1);
				ApplyAnimation(playerid,"COP_AMBIENT","Copbrowse_loop",4.0,0,1,1,1,1);
				format(string, sizeof(string), "~g~Podnoszenie drewna~w~ %d~g~s", time);
				GameTextForPlayer(playerid, string, 1200, 4);
				DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 1000, false, "ddd", playerid, 3, time-1);
			} else {
				GameTextForPlayer(playerid, "~r~ Wroc do drewna!", 2500, 4);
				DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 1000, false, "ddd", playerid, 3, time);
			}
		}
		else
		{
			GameTextForPlayer(playerid, "~g~Podniosles drewno!", 1200, 4);
			// TogglePlayerControllable(playerid, true);
			ClearAnimations(playerid, 1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerAttachedObject(playerid, DRWAL_ATTACH_ID, 19793, 6, 0,0,0,0,90,0);
			DrzewoTimer[playerid] = SetTimerEx("Drwal_Timer", 1000, true, "d", playerid);
	
			
			DestroyDynamicMapIcon(DrzewoIcon[playerid]);
			DrzewoIcon[playerid] = CreateDynamicMapIcon(Drwal_Lokacje[1][0], Drwal_Lokacje[1][1], Drwal_Lokacje[1][2], 0, COLOR_BROWN, 0, 0, playerid);
			DestroyDynamicObject(DrzewoObject[playerid][DrzewoStage[playerid]]);
			DrzewoStage[playerid]++;
	
			DrzewoNiesie[playerid] = 1;
			return 1;
		}
	}
	else if(etap == 4)
	{
		if(time != 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 3, Drwal_Lokacje[1][0], Drwal_Lokacje[1][1], Drwal_Lokacje[1][2]))
			{
				new string[64];
				// TogglePlayerControllable(playerid, false);
				ClearAnimations(playerid, 1);
				ApplyAnimation(playerid,"COP_AMBIENT","Copbrowse_loop",4.0,0,1,1,1,1);
				format(string, sizeof(string), "~g~Odkladanie drewna~w~ %d~g~s", time);
				GameTextForPlayer(playerid, string, 1200, 4);
				DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 1000, false, "ddd", playerid, 4, time-1);
				KillTimer(DrzewoTimer[playerid]);
			} else {
				GameTextForPlayer(playerid, "Wroc do tartaku!", 2500, 4);
				DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 1000, false, "ddd", playerid, 4, time);
				KillTimer(DrzewoTimer[playerid]);
			}
		}
		else
		{
			GameTextForPlayer(playerid, "~g~Polozyles drewno", 1200, 4);
			// TogglePlayerControllable(playerid, true);
			ClearAnimations(playerid, 1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			new string[128];
			SendClientMessage(playerid, COLOR_GREEN, 	 "-------------- {FFFFFF}DRWAL {33AA33}--------------");
			format(string, sizeof(string), "Zebra³eœ ju¿ {FFFFFF}%d/3 {00C2EC}drzew!", DrzewoStage[playerid]);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			RemovePlayerAttachedObject(playerid, DRWAL_ATTACH_ID);
			if(DrzewoStage[playerid] >= 3)
			{
				
				SendClientMessage(playerid, COLOR_GREEN, 	 "-------------- {FFFFFF}DRWAL {33AA33}--------------");
				format(string, sizeof(string), "Uda³o Ci siê wykonaæ zadanie! W nagrodê otrzymujesz {FFFFFF}$%d{00C2EC}!", DRWAL_MONEY);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				DajKase(playerid, DRWAL_MONEY);
	
				Drwal_End(playerid);
				return 1;
	
			} else {
				KillTimer(DrzewoTimer[playerid]);
				DrzewoNiesie[playerid] = 0;
				DestroyDynamicMapIcon(DrzewoIcon[playerid]);
				DrzewoIcon[playerid] = CreateDynamicMapIcon(Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2], 0, COLOR_BROWN, 0, 0, playerid);
				return 1;
			}
		}
	}
	return 1;
}


Drwal_Start(playerid) // zaczyna dzia³anie systemu po zaakceptowaniu dialogu.
{
	SendClientMessage(playerid, COLOR_GREEN, 	 "-------------- {FFFFFF}DRWAL {33AA33}--------------");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Na twoim radarze pojawi³ siê znacznik w którym znajduje siê drzewo do œciêcia.");
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "Udaj siê tam i wykonaj swoje zadanie! Aby œci¹æ drzewo wpisz {FFFFFF}/zetnij {00C2EC}przy drzewie.");
	
	DrzewoRandom[playerid] = random(sizeof(Drwal_Drzewa));
	new i = DrzewoRandom[playerid];

	DrzewoObject[playerid][0] = CreateDynamicObject(696, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2], 0, 0, 0, 0, 0, -1);
	DrzewoIcon[playerid] = CreateDynamicMapIcon(Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2], 0, COLOR_BROWN, 0, 0, playerid);
	DrzewoStage2[playerid] = 1;
	SetPlayerAttachedObject(playerid, DRWAL_ATTACH_ID, 341, 6);
	DrzewoTimerQuit[playerid] = SetTimerEx("Drwal_Timer_Quit", 20000, true, "d", playerid);
	return 1;
}
	
Drwal_End(playerid) // konczy dzialanie systemu i przywraca domyœlne wartoœci. Warto dodaæ do OnPlayerDisconnect.
{
	DestroyDynamicMapIcon(DrzewoIcon[playerid]);
	DestroyDynamicObject(DrzewoObject[playerid][0]);
	DestroyDynamicObject(DrzewoObject[playerid][1]);
	DestroyDynamicObject(DrzewoObject[playerid][2]);
	DrzewoObject[playerid][0] = 0;
	DrzewoObject[playerid][1] = 0;
	DrzewoObject[playerid][2] = 0;
	DrzewoIcon[playerid] = 999;
	DrzewoRandom[playerid] = 0;
	DrzewoStage[playerid] = 0;
	DrzewoStage2[playerid] = 0;
	DrzewoNiesie[playerid] = 0;
	DrzewoWykonuje[playerid] = 0;
	KillTimer(DrzewoTimer[playerid]);
	KillTimer(DrzewoTimerActions[playerid]);
	KillTimer(DrzewoTimerQuit[playerid]);
	DrzewoTimer[playerid] = 0;
	DrzewoTimerActions[playerid] = 0;
	// TogglePlayerControllable(playerid, true);
	ClearAnimations(playerid, 1);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid, DRWAL_ATTACH_ID);
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(DrzewoStage2[playerid] > 0)
    {
        Drwal_End(playerid);
    }
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(DrzewoStage2[playerid] > 0)
    {
        Drwal_End(playerid);
    }
}

hook OnGameModeInit() // dodaæ do OnGameModeInit
{
	Create3DTextLabel("Praca Drwala\nWpisz /drwal aby pracowaæ", COLOR_LIGHTBLUE, Drwal_Lokacje[0][0], Drwal_Lokacje[0][1], Drwal_Lokacje[0][2]+0.5000, 20, 0, 0);
}

YCMD:zetnij(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(DrzewoStage2[playerid] == 1)
		{
			if(DrzewoWykonuje[playerid] == 0)
			{
				new i = DrzewoRandom[playerid];
				if(IsPlayerInRangeOfPoint(playerid, 5, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2]))
				{
					DrzewoWykonuje[playerid] = 1;
					DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 100, false, "ddd", playerid, 1, 30);
				} else return sendErrorMessage(playerid, "Jesteœ za daleko!");
			} else return sendErrorMessage(playerid, "Ju¿ wykonujesz t¹ czynnoœæ!");
		}
	}
	return 1;
}

YCMD:porab(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(DrzewoStage2[playerid] == 2)
		{
			if(DrzewoWykonuje[playerid] == 0)
			{
				new i = DrzewoRandom[playerid];
				if(IsPlayerInRangeOfPoint(playerid, 5, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2]))
				{
					DrzewoWykonuje[playerid] = 1;
					DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 100, false, "ddd", playerid, 2, 15);
				} else return sendErrorMessage(playerid, "Jesteœ za daleko!");
			} else return sendErrorMessage(playerid, "Ju¿ wykonujesz t¹ czynnoœæ!");
		}
	}
	return 1;
}

YCMD:podnies(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(DrzewoStage2[playerid] == 3)
		{
			new i = DrzewoRandom[playerid];
			if(IsPlayerInRangeOfPoint(playerid, 5, Drwal_Drzewa[i][0], Drwal_Drzewa[i][1], Drwal_Drzewa[i][2]))
			{
				if(DrzewoNiesie[playerid] == 0)
				{	
					DrzewoNiesie[playerid] = 1;
					DrzewoTimerActions[playerid] = SetTimerEx("Drwal_Timer_Actions", 100, false, "ddd", playerid, 3, 5);
				} else return sendErrorMessage(playerid, "Juz niesiesz jedno drzewo!");
			} else return sendErrorMessage(playerid, "Jesteœ za daleko!");
		}
	}
	return 1;
}

YCMD:drwal(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 10, Drwal_Lokacje[0][0], Drwal_Lokacje[0][1], Drwal_Lokacje[0][2]))
		{	
			if(DrzewoStage2[playerid] == 0)
			{
				ShowPlayerDialogEx(playerid, D_DRWAL, DIALOG_STYLE_MSGBOX, "Praca drwala", "Twoim zadaniem jest œciêcie drzewa, a nastêpnie przeniesienie go do tartaku", "Akceptuj", "Anuluj");
			} else return sendErrorMessage(playerid, "Wykonujesz ju¿ pracê drwala!");
		}
	}
	return 1;
}

YCMD:gotodrwal(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] > 0)
	{
		SetPlayerPos(playerid, Drwal_Lokacje[0][0], Drwal_Lokacje[0][1], Drwal_Lokacje[0][2]);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
		return 1; 
	} else return sendErrorMessage(playerid, "Brak uprwanieñ!");
}