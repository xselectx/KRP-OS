//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  Levele exp                                               //
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
	Levele exp

	PRZELICZNIK:
		LEVEL 1 ->  0 - 50exp
		LEVEL 2 ->  50 - 125exp
		LEVEL 3 ->  125 - 250exp
		LEVEL 4 ->  250 - 400exp
		LEVEL 5 ->  400exp

*/

stock ReturnToLevel(playerid)
{
	new PlayerLevel;

	if (PlayerInfo[playerid][pPlayerEXP] <= 50) { PlayerLevel = 1; }
	if (PlayerInfo[playerid][pPlayerEXP] >= 50 && PlayerInfo[playerid][pPlayerEXP] <= 125) { PlayerLevel = 2; }
	if (PlayerInfo[playerid][pPlayerEXP] >= 125 && PlayerInfo[playerid][pPlayerEXP] <= 250) { PlayerLevel = 3; }
	if (PlayerInfo[playerid][pPlayerEXP] >= 250 && PlayerInfo[playerid][pPlayerEXP] <= 400) { PlayerLevel = 4; }
	if (PlayerInfo[playerid][pPlayerEXP] >= 400) { PlayerLevel = 5; }

	return PlayerLevel;
}

stock AddEXP(playerid, ammount)
{
	new OldLevel = ReturnToLevel(playerid);
	PlayerInfo[playerid][pPlayerEXP] += ammount;
	if (PlayerInfo[playerid][pPlayerEXP] <= 0) { PlayerInfo[playerid][pPlayerEXP] = 0; } // Zabezpieczenie przed minusowym expem

	// Napis po wbiciu nowego poziomu
	new CongratMes[258];
	if (OldLevel != ReturnToLevel(playerid)) { format(CongratMes, sizeof(CongratMes), "~n~Nowy Poziom: ~y~%d", ReturnToLevel(playerid)); }
	else { format(CongratMes, sizeof(CongratMes), ""); }

	// Wyswietla textdraw z exp
	new Stringzy[258];
	if (ammount >= 0) { format(Stringzy, sizeof(Stringzy), "~g~+%d~w~ exp~w~%s", ammount, CongratMes); }
	if (ammount <= 0) { format(Stringzy, sizeof(Stringzy), "~r~%d~w~ exp~w~%s", ammount, CongratMes); }
	TextDrawEXPOn(playerid, Stringzy, 5000);
	return 1;
}

stock EXPtoNextLevel(playerid)
{
	new EXPNeed[258];

	if(ReturnToLevel(playerid) == 1) { format(EXPNeed, sizeof(EXPNeed), "%d|50", PlayerInfo[playerid][pPlayerEXP]);}
	if(ReturnToLevel(playerid) == 2) { format(EXPNeed, sizeof(EXPNeed), "%d|125", PlayerInfo[playerid][pPlayerEXP]);}
	if(ReturnToLevel(playerid) == 3) { format(EXPNeed, sizeof(EXPNeed), "%d|250", PlayerInfo[playerid][pPlayerEXP]);}
	if(ReturnToLevel(playerid) == 4) { format(EXPNeed, sizeof(EXPNeed), "%d|400", PlayerInfo[playerid][pPlayerEXP]);}
	if(ReturnToLevel(playerid) == 5) { format(EXPNeed, sizeof(EXPNeed), "MAX");}
	
	return EXPNeed;
}

///
/// TEXTDRAW
///

new EXPWyswietla[MAX_PLAYERS];

forward TextDrawEXPOn(playerid,string[],time);
public TextDrawEXPOn(playerid,string[],time)
{
	if(EXPWyswietla[playerid]==1){
		TextDrawHideForPlayer(playerid, TextDrawEXP[playerid]);
	}
	EXPWyswietla[playerid]=1;
	TextDrawSetString(TextDrawEXP[playerid], string);
	TextDrawShowForPlayer(playerid, TextDrawEXP[playerid]);
	SetTimerEx("TextDrawEXPoff",time, 0, "d", playerid);
	return 1;
}

forward TextDrawEXPoff(playerid,string[]);
public TextDrawEXPoff(playerid,string[])
{
	if(EXPWyswietla[playerid]==1) 
	{
		TextDrawHideForPlayer(playerid, TextDrawEXP[playerid]);
		EXPWyswietla[playerid]=0;
	}
}


///
/// STOCKI OD DODAWANIA EXPA
///

stock EXPPlayerDeath(playerid, killerid, reason) // Gracz umiera
{
	if (killerid != INVALID_PLAYER_ID) // zabicie przez gracza
	{
		if(reason == 0) { AddEXP(playerid, -1); } // zabicie z reki
		else { AddEXP(playerid, -2); }

		AddEXP(killerid, 1); // killerid dostaje +1 exp
	}

	if(reason==54) // gracz zabil sie sam
	{
		AddEXP(playerid, -1);
	}
	return 1;
}

stock EXPPlayerBuyHouse(playerid) // gracz kupuje dom
{
	AddEXP(playerid, 10);
	return 1;
}

stock EXPPlayerBuyCar(playerid, ammount) // gracz kupuje auto
{
	if(ammount >= 1000000) { AddEXP(playerid, 7); }
	else { AddEXP(playerid, 4); }
	return 1;
}

stock EXPPlayerJail(playerid, time) // gracz dostaje aj
{
	if (time >= 20) { AddEXP(playerid, -5); }
	else { AddEXP(playerid, -2); }
	return 1;
}

///
/// STOCKI OD TEGO CO DAJE LEVEL
///

stock LVLPlayerSpawn(playerid)
{
	if(ReturnToLevel(playerid) == 4){ SetPlayerArmour(playerid, 25); }
	if(ReturnToLevel(playerid) == 5){ SetPlayerArmour(playerid, 50); }
	return 1;
}

stock LVLPayDay(playerid)
{
	if(ReturnToLevel(playerid) == 2){ PremiumInfo[playerid][pMC] += 1; mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+1 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID])); }
	if(ReturnToLevel(playerid) == 3){ PremiumInfo[playerid][pMC] += 2; mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+2 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID])); }
	if(ReturnToLevel(playerid) == 4){ PremiumInfo[playerid][pMC] += 3; mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+3 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID]));}
	if(ReturnToLevel(playerid) == 5){ PremiumInfo[playerid][pMC] += 4; mysql_query(sprintf("UPDATE `mybb_users` SET `samp_kc`=`samp_kc`+4 WHERE `uid` = '%d'", PlayerInfo[playerid][pGID]));}

	MruMySQL_SaveMc(playerid);
	return 1;
}

stock LVLAddMats(playerid)
{
	if(ReturnToLevel(playerid) == 2){ Item_Add("Materia造", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MATS, 0, 0, true, playerid, 5, ITEM_NOT_COUNT); }
	if(ReturnToLevel(playerid) == 3){ Item_Add("Materia造", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MATS, 0, 0, true, playerid, 10, ITEM_NOT_COUNT); }
	if(ReturnToLevel(playerid) == 4){ Item_Add("Materia造", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MATS, 0, 0, true, playerid, 15, ITEM_NOT_COUNT); }
	if(ReturnToLevel(playerid) == 5){ Item_Add("Materia造", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MATS, 0, 0, true, playerid, 20, ITEM_NOT_COUNT); }
	return 1;
}

///
/// KOMENDY
///
YCMD:exp(playerid, params[])
{
	new String5[258];
	format(String5, sizeof(String5), "Posiadasz EXP: %d Level: %d Do nast瘼nego poziomu brakuje ci %s", PlayerInfo[playerid][pPlayerEXP], ReturnToLevel(playerid), EXPtoNextLevel(playerid));
	SendClientMessage(playerid, -1, String5);
	return 1;
}

YCMD:dodajexp(playerid, params[])
{
	if(IsPlayerAdmin(playerid) || Uprawnienia(playerid, ACCESS_OWNER) || IsAScripter(playerid))
	{
		new player, amount;
		if(sscanf(params, "dd", player, amount))
		{
			return SendClientMessage(playerid, -1, "/dodajexp [id] [exp]");
		}
		AddEXP(player, amount);
	}
	return 1;
}

YCMD:sprawdzexp(playerid, params[])
{
	if(IsPlayerAdmin(playerid) || Uprawnienia(playerid, ACCESS_OWNER) || IsAScripter(playerid))
	{
		new player;
		if(sscanf(params, "d", player))
		{
			return SendClientMessage(playerid, -1, "/sprawdzexp [id]");
		}
		if (!IsPlayerConnected(player)) {return SendClientMessage(playerid, -1, "Nie ma takiego gracza!");}
		new String5[258];
		new name[MAX_PLAYER_NAME];
		GetPlayerName(player, name, sizeof(name));
		format(String5, sizeof(String5), "Gracz: %s[%d] posiada EXP: %d Level: %d Do nast瘼nego poziomu brakuje mu %s", name, player, PlayerInfo[player][pPlayerEXP], ReturnToLevel(player), EXPtoNextLevel(player));
		SendClientMessage(playerid, -1, String5);
	}
	return 1;
}