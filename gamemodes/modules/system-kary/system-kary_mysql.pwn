//----------------------------------------------<< MySQL >>----------------------------------------------//
//                                                 system-kary                                                 //
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
// Autor: never
// Data utworzenia: 24.06.2021
//Opis:
/*
	System kary
*/

//GetNick(playername)


stock GetAccountIP(playerid)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}

stock CheckBlock(uid, type)
{
	new query[128],block;
	format(query,sizeof(query),"SELECT `Block` FROM `mru_konta` WHERE `UID`='%d'", uid);
	mysql_query(query);
	mysql_store_result();
	mysql_fetch_row_format(query);
	block=strval(query);
	if(block==type) return true;
	
	return false;
}

stock CheckBan(ip[], globalid)
{
	new query[128],gid,group;
	format(query,sizeof(query),"SELECT * FROM `mru_kary_bany` WHERE `ip`='%s' OR `player_global_id`='%d'", ip, globalid);
	mysql_query(query);
	
	mysql_store_result();
	
	if(mysql_num_rows())
	{
		gid=true;
		//format(query,sizeof(query),"INSERT INTO `mru_falied_logins` VALUES (NULL,'%d','%d','%s','%d','Ban w grze')", PlayerInfo[playerid][pUID],PlayerInfo[playerid][pGID], GetAccountIP(playerid), gettime());
		//mysql_query(query);
	}
	mysql_free_result();
	if(gid) return true;
	if(globalid)
	{
		format(query,sizeof(query),"SELECT `usergroup` FROM `mybb_users` WHERE `uid` ='%d'", globalid);
		mysql_query(query);
		mysql_store_result();
		mysql_fetch_row_format(query);
		group=strval(query);
		mysql_free_result();
		if(group==5)
		{
			return true;

		}
	}
	mysql_free_result();
	return gid;
}

public AddBan(gid, ip[])
{
	new query[128];
	format(query,sizeof(query),"INSERT INTO `mru_kary_bany` VALUES (NULL, '%s', '%d')", ip, gid);
	mysql_query(query);
	return 1;
}


public UnBan(uid, gid)
{
	new query[128], query2[128];
	format(query,sizeof(query),"DELETE FROM mru_kary_bany WHERE player_global_id = '%d'", gid);
	format(query2,sizeof(query2), "UPDATE `mru_konta` SET Block = Block - 2, `CK`=0 WHERE `UID`='%d'", uid);
	mysql_query(query);
	mysql_query(query2);
	return 1;
}



public AddPunishment(playerid, playername[], admin, time, type, value, reason[], warn_kick)
{	
	new validreason[64];
	new validadmin_gid = -1;
	new validadmin_uid = -1;
	new uid=-1,gid=-1;
	new str[256];
	new ip_gracza[16];
	
	mysql_real_escape_string(reason, validreason);
	
	if(admin != -1) {
		validadmin_gid = PlayerInfo[admin][pGID];
		validadmin_uid = PlayerInfo[admin][pUID];
	}
	
	if(playerid == -1) {
		//Zaczytywanie UID oraz GID gdy gracz jest offline
		mysql_query_format("SELECT UID, uid_forum FROM mru_konta WHERE Nick = '%s'", playername);

		mysql_store_result();
		if(mysql_num_rows() > 0)
		{
			new ask[148];
			mysql_fetch_row_format(ask, "|");
			sscanf(ask, "p<|>dd", 
			uid,
			gid);
		}
		mysql_free_result();
		ip_gracza = "nieznane";
		
		if(uid == -1) {// Nie znaleziono gracza z takim nickiem
			if(admin != -1) sendErrorMessage(admin, "Gracz o takim nicku nie istnieje!");
			return 0;	
		}
	} else {
		uid = PlayerInfo[playerid][pUID];
		gid = PlayerInfo[playerid][pGID];
		ip_gracza = GetAccountIP(playerid);
	}	
	
	
	if(type == PENALTY_WARN) {
		if(playerid == -1) {
			new query[256];
			N_GivePWarnForPlayer(playername, admin, validreason);
			format(query, sizeof(query), "UPDATE `mybb_users` SET `samp_warns` = `samp_warns`+1 WHERE `uid` = '%d'", gid);
			mysql_query(query);
		} else {
			N_GiveWarnForPlayer(playerid, admin, validreason, warn_kick);
		}
	}
	
	else if(type == PENALTY_AJ) {
		if(playerid == -1) {
				N_SetPlayerPAdminJail(playername, admin, value, validreason);
		} else {
				N_SetPlayerAdminJail(playerid, admin, value, validreason);
		}
	}
	
	else if(type == PENALTY_KICK) {
		N_GiveKickForPlayer(playerid, admin, validreason);
	}
	
	else if(type == PENALTY_BAN) {
	
		if(CheckBlock(uid, BLOCK_BAN) || CheckBlock(uid, BLOCK_CHAR_BAN)) {
			if(admin != -1) sendErrorMessage(admin, "Gracz o tym nicku jest juz zbanowany!");
			return 0;	
		}
		
		if(playerid == -1) {
				N_GivePBanForPlayer(playername, admin, validreason);
				AddBan(gid, "nieznane");
		} else {
				N_GiveBanForPlayer(playerid, admin, validreason);
				AddBan(PlayerInfo[playerid][pGID], GetAccountIP(playerid));
		}
	}
	
	else if(type == PENALTY_BLOCK) {
	
		if(CheckBlock(uid, BLOCK_CHAR) || CheckBlock(uid, BLOCK_CHAR_BAN)) {
			if(admin != -1) sendErrorMessage(admin, "Gracz o tym nicku jest juz zablokowany!");
			return 0;	
		}
		
		if(playerid == -1) {
				N_GivePBlockForPlayer(playername, admin, validreason);
		} else {
				N_GiveBlockForPlayer(playerid, admin, validreason);
		}
	}
	
	else if(type == PENALTY_UNWARN) {

		if(playerid == -1) {
			//offline
			new query[256];
			format(query, sizeof(query), "UPDATE `mybb_users` SET `samp_warns` = `samp_warns`-1 WHERE `uid` = '%d'", gid);
			mysql_query(query);
		} else {
			//online
			new query[256];
			PlayerInfo[playerid][pWarns] -= 1;
			format(query, sizeof(query), "UPDATE `mybb_users` SET `samp_warns` = `samp_warns`-1 WHERE `uid` = '%d'", gid);
			mysql_query(query);
		}
	}
	
	else if(type == PENALTY_UNBLOCK) {
	
		if(CheckBlock(uid, BLOCK_CHAR) || CheckBlock(uid, BLOCK_CHAR_BAN) ) {
			new query[128];
			format(query, sizeof(query), "UPDATE `mru_konta` SET Block= Block - 1, `CK`=0 WHERE `Nick`='%s'", playername);
			mysql_query(query);
		} else {
			if(admin != -1) sendErrorMessage(admin, "Gracz o tym nicku nie jest zablokowany!");
			return 0;
		}
	}
	
	else if(type == PENALTY_UNBAN) {
	
			if(CheckBlock(uid, BLOCK_BAN) || CheckBlock(uid, BLOCK_CHAR_BAN)) {
				UnBan(uid, gid);
			} else {
				if(admin != -1) sendErrorMessage(admin, "Gracz o tym nicku nie jest zbanowany!");
				return 0;
			}
	
	}
	
	if(playerid == -1) {
		format(str, sizeof(str), "INSERT INTO `mru_kary` VALUES (NULL, '%d', '%d', '%s', '%d', '%d', '%d', '%d', '%d', '%s');", uid, gid, ip_gracza, validadmin_uid, validadmin_gid, time, type, value, validreason);
	} else {
		format(str, sizeof(str), "INSERT INTO `mru_kary` VALUES (NULL, '%d', '%d', '%s', '%d', '%d', '%d', '%d', '%d', '%s');", PlayerInfo[playerid][pUID], PlayerInfo[playerid][pGID], ip_gracza, validadmin_uid, validadmin_gid, time, type, value, validreason);
	}
	mysql_query(str);
	
	return 1;
}


//end