//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  gazeciarz                                                //
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
// Autor: Dawidoskyy
// Data utworzenia: 20.07.2022
//Opis:
/*
	gazeciarz
*/

new IsGazeciarz[MAX_PLAYERS] = 0, BlockGazeta[MAX_PLAYERS] = 0;
new GazeciarzAC[MAX_PLAYERS] = 0;

new Float: gazeciarzpoint[0][5] =
{
  { 1897.3784,-1645.8386,13.5468, 1.5 },
  { 1907.5267,-1631.5620,13.5468, 1.5 },
  { 1977.6581,-1651.5457,13.5463, 1.5 },
  { 1971.7686,-1687.9669,13.5463, 1.5 },
  { 1978.9882,-1695.9998,13.5549, 1.5 }
}; 

stock Gazeciarz3dText()
{
	Create3DTextLabel("{adc7e7}Roznosiciel Gazet\nAby zebraæ gazetê kliknij klawisz {ffffff}Y", 0xFFFFFFFF, 1870.5071,-1686.9442,13.5430, 40, 0, 0);
	return 1;
}

stock GazeciarzOnPlayerDisconnect(playerid)
{
	IsGazeciarz[playerid] = 0;
	GazeciarzAC[playerid] = 0;
	BlockDeska[playerid] = 0;
	BlockGazeta[playerid] = 0;
	return 1;
}

stock GazeciarzOnPlayerKey(playerid, newkeys)
{
	if(newkeys == KEY_YES) // Klawisz Y
	{
		if(IsPlayerInRangeOfPoint(playerid,3,1870.5071,-1686.9442,13.5430))
		{
			if(GetPlayerVirtualWorld(playerid) != 0 || IsGazeciarz[playerid] == 1 || InfoSkate[playerid][sActive] || IsPlayerInAnyVehicle(playerid)) return 0;
			if(BlockGazeta[playerid] == 1) return TextDrawInfoOn(playerid, "Odczekaj chwile przed podniesieniem nastepnej gazety!", 5000);
			new rand = random(sizeof(gazeciarzpoint));
			SetPlayerCheckpoint(playerid,gazeciarzpoint[rand][0],gazeciarzpoint[rand][1],gazeciarzpoint[rand][2],gazeciarzpoint[rand][3]);
			TextDrawInfoOn(playerid, "Dostarcz ~y~gazete~w~ do ~r~czerwonego~w~ celu", 8000);
			IsGazeciarz[playerid] = 1;
			GazeciarzAC[playerid] = gettime() + 5;
			BlockDeska[playerid] = 1;
			ApplyAnimation(playerid,"GANGS","DEALER_DEAL",4.1,0,1,1,0,0,0);
		}
	}
	return 1;
}

stock GazeciarzOnEnterCheckpoint(playerid)
{
	if(IsGazeciarz[playerid] == 1)
	{
		if(GazeciarzAC[playerid] >= gettime())
		{
			new string[128];
			format(string, sizeof(string), "[KICK]AdmWarn: %s[%d] <- Cheater, Teleportation during newspaper work %ds", GetNick(playerid), playerid, (gettime() + 5) - GazeciarzAC[playerid]);
			SendAdminMessage(COLOR_YELLOW, string);	
			printf("[KICK][teleport][cheats] Cheater, Teleportation during newspaper work %ds", (gettime() + 5) - GazeciarzAC[playerid]);
			ShowPlayerDialogEx(playerid, 10101, DIALOG_STYLE_MSGBOX, "KICK", "Cheater, Teleportation during newspaper work", "OK", "");
			KickEx(playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid,1.5,1897.3784,-1645.8386,13.5468) || IsPlayerInRangeOfPoint(playerid,1.5,1907.5267,-1631.5620,13.5468) || IsPlayerInRangeOfPoint(playerid,1.5,1977.6581,-1651.5457,13.5463) || IsPlayerInRangeOfPoint(playerid,1.5,1971.7686,-1687.9669,13.5463) || IsPlayerInRangeOfPoint(playerid,1.5,1978.9882,-1695.9998,13.5549))
		{
			TextDrawInfoOn(playerid, "Dostarczasz gazete!~n~~y~zaczekaj...", 8000);
			TogglePlayerControllable(playerid, 0);
			SetTimerEx("GazeciarzGazeta", 3000, false, "i", playerid);
			ApplyAnimation(playerid,"GANGS","DEALER_DEAL",4.1,0,1,1,0,0,0);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			GazeciarzAC[playerid] = 0;
		}
		else
		{
			ShowPlayerDialogEx(playerid, 10101, DIALOG_STYLE_MSGBOX, "NIE BUGUJ!", "Nie buguj checkpointa, praca zosta³a zresetowana!", "OK", "");
			IsGazeciarz[playerid] = 0;
			GazeciarzAC[playerid] = 0;
			BlockDeska[playerid] = 0;
		}
	}
	return 1;
}

forward GazeciarzGazeta(playerid);
public GazeciarzGazeta(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid,1.5,1897.3784,-1645.8386,13.5468) || IsPlayerInRangeOfPoint(playerid,1.5,1907.5267,-1631.5620,13.5468) || IsPlayerInRangeOfPoint(playerid,1.5,1977.6581,-1651.5457,13.5463) || IsPlayerInRangeOfPoint(playerid,1.5,1971.7686,-1687.9669,13.5463) || IsPlayerInRangeOfPoint(playerid,1.5,1978.9882,-1695.9998,13.5549))
	{
		TogglePlayerControllable(playerid,1);
		DajKaseDone(playerid, PRICE_GAZECIARZ);
		TextDrawInfoOn(playerid, "Dostarczyles gazete!~n~~g~"#PRICE_GAZECIARZ"$", 3000);
		IsGazeciarz[playerid] = 0;
		BlockDeska[playerid] = 0;
		ClearAnimations(playerid);
		BlockGazeta[playerid] = 1;
		SetTimerEx("BlockGazetta", 15000, false, "i", playerid);
	}
	else
	{
		ShowPlayerDialogEx(playerid, 10101, DIALOG_STYLE_MSGBOX, "NIE BUGUJ!", "Nie buguj checkpointa, praca zosta³a zresetowana!", "OK", "");
		IsGazeciarz[playerid] = 0;
		GazeciarzAC[playerid] = 0;
		BlockDeska[playerid] = 0;
	}
	return 1;
}

forward BlockGazetta(playerid);
public BlockGazetta(playerid)
{
	BlockGazeta[playerid] = 0;
	return 1;
}

//Ustawienia:
#define WORLD_ID_ONEDE 8293 
new bool:AntyCBUG = true;
new MAX_WARNINGS_CBUG = 3;

//Dialogi:
#define D_ADMIN_ONEDE_MENU 9123

//Zmienne:
new bool:Onede_Status = false;
new bool:PlayerOnedeData[MAX_PLAYERS];
new Float:SpawnSlot[][] =
{
	//Pozycje spawnu:

	//   X        Y       Z        R
	{300.0804, 191.6854, 1007.1719, 0.0},
	{299.7782, 173.2495, 1007.1719, 0.0},
	{221.2334, 150.3305, 1003.0234, 0.0},
	{210.7774, 186.4514, 1003.0313, 0.0},
	{249.1874, 160.9782, 1003.0234, 0.0},
	{205.3420, 157.3225, 1003.0234, 0.0},
	{228.8251, 180.7334, 1003.031, 0.0},
	{188.9388, 179.3719, 1003.0234,269.3708},
	{210.7774, 186.4514, 1003.0313,138.1063},
	{228.8251, 180.7334, 1003.0313,136.8530}
};
new CBUGWarnings[MAX_PLAYERS];
new bool:InCBUBFrezze[MAX_PLAYERS];
new onede_players;
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))


CMD:dmevent(playerid, params[])
{
	if(PlayerOnedeData[playerid] == false) {
		if(Onede_Status == true) {
			ResetPlayerWeapons(playerid);
			SetPlayerInterior(playerid, 3);
			SetPlayerVirtualWorld(playerid, WORLD_ID_ONEDE);
			SetPlayerHealth(playerid, 100);
			if(PlayerInfo[playerid][pGun2] == WEAPON_DEAGLE)
				SetPVarInt(playerid, "hasDeagle", 1);
			else
				SetPVarInt(playerid, "hasDeagle", 0);
			PlayerInfo[playerid][pGun2] = WEAPON_DEAGLE;
            PlayerInfo[playerid][pAmmo2] = 500;
            GivePlayerWeapon(playerid, WEAPON_DEAGLE, 500);
			GameTextForPlayer(playerid, "~r~~n~~n~~n~~n~DOLACZONO NA DEATHMATCH!", 3000, 3);

			new rand = random(sizeof(SpawnSlot));
			SetPlayerPos(playerid, SpawnSlot[rand][0], SpawnSlot[rand][1], SpawnSlot[rand][2]);
			SetPlayerFacingAngle(playerid, SpawnSlot[rand][3]);
			PlayerOnedeData[playerid] = true;
			onede_players++;
		}
		else
			SendClientMessage(playerid, -1, "Arena DeathMatch jest wy³¹czona.");
	}
	else {
		SetPlayerSpawn(playerid);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, false);
		GameTextForPlayer(playerid, "~r~~n~~n~~n~~n~WYSZEDLES Z DM!", 3000, 3);
		PlayerOnedeData[playerid] = false;
		onede_players--;
		ResetPlayerWeapons(playerid);
		if(!GetPVarInt(playerid, "hasDeagle"))
			PlayerInfo[playerid][pGun2] = 0;
		PrzywrocBron(playerid);
		SetPlayerHealth(playerid, 100.0);
	}
	return 1;
}

CMD:a_dm(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >=2)
	{
		ShowPlayerDialogEx(playerid, D_ADMIN_ONEDE_MENU, DIALOG_STYLE_LIST, "Arena DM", "Wlacz skrypt.\nWylacz skrypt.", "OK", "WyjdŸ");
	}
	return 1;
}

stock OnDialogResponseOnede(playerid, dialogid, response, listitem)
{
	if(dialogid == D_ADMIN_ONEDE_MENU) {
		if(response) {
			switch(listitem) {
				case 0: {
					Onede_Status = true;
					GameTextForPlayer(playerid, "Skrypt wlaczony!", 5000, 4);
					SendClientMessageToAll(KOLOR_CZERWONY, "Arena DeathMatch zosta³a w³¹czona aby do³¹czyæ wpisz /dmevent");
					return 1;
				}

				case 1: {
					Onede_Status = false;
					GameTextForPlayer(playerid, "Skrypt wylaczony!", 5000, 4);
					SendClientMessageToAll(KOLOR_CZERWONY, "Arena DeathMatch zosta³a wy³¹czona");
					return 1;
				}
			}
		}
	}
	return 0;
}

stock OnPlayerDeathOnede(playerid, killerid)
{
	if(PlayerOnedeData[playerid] == true) {
		//TogglePlayerSpectating(playerid, true);
		//PlayerSpectatePlayer(playerid, killerid, SPECTATE_MODE_NORMAL);
		//SetTimerEx("TIMER_PLAYER_SPECTATE", 5 * 1000, false, "iii", playerid, killerid, GetPlayerSkin(playerid));
		GameTextForPlayer(playerid, "~r~NIE ZYJESZ!", 3000, 4);
		ResetPlayerWeapons(playerid);
		SetPlayerSpawn(playerid);
		SetPVarInt(playerid, "skip_bw", 1);
		PlayerOnedeData[playerid] = false;
		onede_players--;
		if(!GetPVarInt(playerid, "hasDeagle"))
			PlayerInfo[playerid][pGun2] = 0;
		PrzywrocBron(playerid);
		if(IsPlayerConnected(killerid))
		{
			DajKase(killerid, 5);

			new string[128];
			format(string, sizeof string, "~r~~n~~n~~n~~n~~n~ZABITO: ~w~%s. ~r~KASA: ~w~%i.", GetNick(playerid), 5);
			GameTextForPlayer(killerid, string, 3000, 3);
		}
	}
	return 1;
}

stock OnPlayerKeyStateChangeONEDE(playerid, newkeys, oldkeys)
{
	if(AntyCBUG == true && PlayerOnedeData[playerid] == true && InCBUBFrezze[playerid] == false) {
		if(GetPlayerWeapon(playerid) == WEAPON_DEAGLE || GetPlayerWeapon(playerid) == WEAPON_COLT45 || GetPlayerWeapon(playerid) == WEAPON_SILENCED) {
			if(HOLDING(KEY_FIRE)) {
				if(PRESSED(KEY_CROUCH)) {
					if(MAX_WARNINGS_CBUG != 0) {
						if(CBUGWarnings[playerid] == MAX_WARNINGS_CBUG) {
							CBUGWarnings[playerid] = 0;
							PlayerOnedeData[playerid] = false;
							SendClientMessage(playerid, -1, "{adc7e7}Zostales(as) wyrzucony(a) z powodu uzywania CBUG!");
							SetPlayerPos(playerid, 1319.3690,1255.4752,14.2731);
							SetPlayerVirtualWorld(playerid, 0);
							SetPlayerInterior(playerid, false);
							onede_players--;
							ResetPlayerWeapons(playerid);

							new string[258];
							format(string, sizeof string, "{adc7e7}[ONEDE]: {FFFFFF}Gracz {adc7e7}%s {FFFFFF}zostal wyrzucony(a) z ONEDE za bugowanie strzalow z broni. {adc7e7}( %i graczy ).", Playername(playerid), onede_players);
							SendClientMessageToAll(-1, string);
							SetPlayerHealth(playerid, 100.0);
						}
						else {
							TogglePlayerControllable(playerid, false);
							GameTextForPlayer(playerid, "~r~ZAKAZ UZYWANIA CBUG NA ARENIE!", 3000, 4);
							SetTimerEx("TIMER_FREZZE_CBUG", 3000, false, "i", playerid);
							InCBUBFrezze[playerid] = true;
							CBUGWarnings[playerid]++;
						}
					}
				}	
			}
		}
	}
	return 1;
}
forward TIMER_FREZZE_CBUG(playerid);
public TIMER_FREZZE_CBUG(playerid)
{
	TogglePlayerControllable(playerid, true);
	InCBUBFrezze[playerid] = false;
	return 1;
}