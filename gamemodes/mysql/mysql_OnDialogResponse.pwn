
MruMySQL_ZapiszUprawnienia(playerid)
{
    new str[128];
    format(str, sizeof(str), "SELECT `UID` FROM `mru_uprawnienia` WHERE `UID`=%d", PlayerInfo[playerid][pUID]);
    mysql_query(str);
    mysql_store_result();
    if(mysql_num_rows()) format(str, sizeof(str), "UPDATE `mru_uprawnienia` SET `FLAGS`= b'%b' WHERE `UID`=%d", ACCESS[playerid], PlayerInfo[playerid][pUID]);
    else format(str, sizeof(str), "INSERT INTO `mru_uprawnienia` (`FLAGS`, `UID`) VALUES (b'%b', %d)", ACCESS[playerid], PlayerInfo[playerid][pUID]);
    mysql_free_result();
    mysql_query(str);
}

MruMySQL_PobierzStatystyki(playerid, nickoruid[])
{
    new lStr[1024];
    new nick_escaped[MAX_PLAYER_NAME];
    mysql_real_escape_string(nickoruid, nick_escaped);
    new uid = strval(nickoruid);
    format(lStr, sizeof(lStr), "SELECT `Nick`, `Level`, `Admin`, `ZaufanyGracz`, `PAdmin`, `DonateRank`, `Money`, `Bank`, `Job`, `BlokadaPisania`, `Member`, `FMember`, `Dom`, `Block`, `ZmienilNick`, `UID` FROM `mru_konta` WHERE `Nick`='%s' OR `UID`='%d'", nick_escaped, uid);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(lStr, "|");
		
		new stringban[144], stringblock[144];
        new pnickname[MAX_PLAYER_NAME], plvl, padmin, pzg, ppadmin, ppremium, pmoney, pbank, pjob, pbp, pmember, porg, pdom, pblock, pzn, pwarn, puid;
		
		pwarn = MruMySQL_GetWarnsFromName(nick_escaped);
		
        sscanf(lStr, "p<|>s[24]ddddddddddddddd", pnickname, plvl, padmin, pzg, ppadmin, ppremium, pmoney, pbank, pjob, pbp, pmember, porg, pdom, pblock, pzn, puid);
        
		if (pblock == 1 || pblock == 3) {
			stringblock = "{FF0000}zablokowany";
		} else {
			stringblock = "{00FF00}brak";
		}
		
		if(pblock == 2 || pblock == 3) {
			stringban = "{FF0000}zbanowany";
		} else {
			stringban = "{00FF00}brak";
		}
        format(lStr, sizeof(lStr), "> %s {FFFFFF}(UID: %d)", pnickname, puid);
        SendClientMessage(playerid, COLOR_RED, lStr);
        format(lStr, sizeof(lStr), "Level: %d ¦ Kasa: %d ¦ Bank: %d ¦ ZN: %d ¦ Dom: %d", plvl, pmoney, pbank, pzn, pdom);
        SendClientMessage(playerid, -1, lStr);
        format(lStr, sizeof(lStr), "Admin: %d ¦ P@: %d ¦ ZG: %d ¦ BP: %d ¦ Block: %s", padmin, ppadmin, pzg, pbp, stringblock);
        SendClientMessage(playerid, -1, lStr);
        format(lStr, sizeof(lStr), "Warny: %d ¦ Ban: %s", pwarn, stringban);
        SendClientMessage(playerid, -1, lStr);
        format(lStr, sizeof(lStr), "Premium: %d ¦ Praca: %d ¦ Frakcja: %d ¦ Org.: %d", ppremium, pjob, pmember, porg);
        SendClientMessage(playerid, -1, lStr);
        SendClientMessage(playerid, COLOR_YELLOW, "--------------------------------------------------------------------------");
    }
    mysql_free_result();
}

MruMySQL_ZnajdzBanaPoIP(playerid, unescaped_ip[])
{
    new query[356], query2[256], ip[16], str[2800];
    mysql_real_escape_string(unescaped_ip, ip);
	
	format(query, sizeof(query), "SELECT mru_kary.admin_gid, mru_kary.reason, mru_kary.time, mru_kary.player_uid, mru_kary.type, mybb_users.username FROM mru_kary LEFT JOIN mybb_users on mybb_users.uid=mru_kary.admin_gid WHERE mru_kary.player_ip = '%s' AND mru_kary.type IN (1,3,4,21,22,23) ORDER BY mru_kary.time DESC", ip);
	
   // format(query, sizeof(query), "SELECT `nadal_uid`, `nadal`, `powod`, `czas`, `dostal`, `dostal_uid`, `typ` FROM `mru_bany` WHERE `IP` = '%s' AND `typ`>1 ORDER BY `czas` DESC LIMIT 4", ip);
    mysql_query(query);
    mysql_store_result();
    if(mysql_num_rows())
    {
        while(mysql_fetch_row_format(query, "|"))
        {
            new powod[64], admin[32], id, czas[32], pid, typ, nick[32];
			
			sscanf(query, "p<|>ds[64]s[32]dds[32]", id, powod, czas, pid, typ, admin);
			
			if(isequal(admin, "NULL")) admin = "SYSTEM";
			
			format(query2, sizeof(query2), "SELECT `Nick` FROM `mru_konta` WHERE `UID`='%d'", pid);
			mysql_query(query2);
			mysql_store_result();

			if (mysql_num_rows())
			{
				mysql_fetch_row_format(query2, "|");
				mysql_free_result();
				sscanf(query2, "p<|>s[32]", nick);

			}
	
            new resultfit[80];
            if(strlen(powod) > 0)
                format(resultfit, sizeof(resultfit), "{079FE1}%s\n", powod);
			
			new Timestamp:ts = Timestamp:strval(czas), output[256];
			TimeFormat(ts, HUMAN_DATE, output);
			
			format(str, sizeof(str), "%s{FFFFFF}Gracz: %s\t\tPID: %d\tIP: %s\nNada³: %s\t\tPID: %d\n%sData: %s\tTyp: %s\n{FF0000}================================={FFFFFF}\n",str, nick, pid, ip, admin, id, resultfit, output, GetPunishmentType(typ));
        }
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "K-RP » Panel zarz¹dzania karami", str, "Wróæ", "");
    }
    else
    {
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "K-RP » Panel zarz¹dzania karami", "Brak wyników", "Wróæ", "");
    }
    mysql_free_result();
}

MruMySQL_ZnajdzBanaPoNicku(playerid, unescaped_nick[])
{
    new query[356],nick[MAX_PLAYER_NAME], str[2800];
    mysql_real_escape_string(unescaped_nick, nick);
	new t_uid;
	t_uid = MruMySQL_GetUIDFromName(nick);
	
	format(query, sizeof(query), "SELECT mru_kary.admin_gid, mru_kary.reason, mru_kary.time, mru_kary.player_uid, mru_kary.type, mybb_users.username, mru_kary.player_ip FROM mru_kary LEFT JOIN mybb_users on mybb_users.uid=mru_kary.admin_gid WHERE mru_kary.player_uid = '%d' AND mru_kary.type IN (1,3,4,21,22,23) ORDER BY mru_kary.time DESC", t_uid);
    mysql_query(query);
    mysql_store_result();
    if(mysql_num_rows())
    {
        while(mysql_fetch_row_format(query, "|"))
        {
            new powod[64], admin[32], id, czas[32], ip[16], pid, typ;
			
			sscanf(query, "p<|>ds[64]s[32]dds[32]s[16]", id, powod, czas, pid, typ, admin, ip);
			
			if(isequal(admin, "NULL")) admin = "SYSTEM";
			
            new resultfit[80];
            if(strlen(powod) > 0)
                format(resultfit, sizeof(resultfit), "{079FE1}%s\n", powod);
			
			new Timestamp:ts = Timestamp:strval(czas), output[256];
			TimeFormat(ts, HUMAN_DATE, output);
			
			format(str, sizeof(str), "%s{FFFFFF}Gracz: %s\t\tPID: %d\tIP: %s\nNada³: %s\t\tPID: %d\n%sData: %s\tTyp: %s\n{FF0000}================================={FFFFFF}\n",str, nick,pid,ip,admin, id, resultfit, output, GetPunishmentType(typ));
        }
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "K-RP » Panel zarz¹dzania karami", str, "Wróæ", "");
    }
    else
    {
        ShowPlayerDialogEx(playerid, D_PANEL_KAR_ZNAJDZ_INFO, DIALOG_STYLE_LIST, "K-RP » Panel zarz¹dzania karami", "Brak wyników", "Wróæ", "");
    }
    mysql_free_result();
}
