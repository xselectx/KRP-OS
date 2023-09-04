
MruMySQL_ClearZone(zoneid)
{
    new str[64];
    format(str, 64, "UPDATE `mru_strefy` SET `gang`='0' WHERE `id`='%d'", zoneid);
    mysql_query(str);
}

MruMySQL_CzyjToNumer(playerid, number)
{
    new string[128], string_two[144], connected_status, selectedplayer = INVALID_PLAYER_ID, nick[MAX_PLAYER_NAME];
    format(string, sizeof(string), "SELECT `owner` FROM mru_items WHERE `value1`='%d' AND `owner_type` = '%d' AND `item_type` = '%d'", number, ITEM_OWNER_TYPE_PLAYER, ITEM_TYPE_PHONE);
    mysql_query(string);
    mysql_store_result();
    if(mysql_num_rows())
    {
        new uid = mysql_fetch_int();
        format(string, sizeof(string), "SELECT `Nick`, `connected` FROM mru_konta WHERE `UID`='%d'", uid);
        mysql_query(string);
        mysql_store_result();
        while(mysql_fetch_row_format(string, "|"))
        {
            sscanf(string, "p<|>s[24]d", nick, connected_status);
            if(connected_status)
            {
                foreach(new i : Player)
                {
                    if(gPlayerLogged[i] != 0)
                    {
                        if(strcmp(GetNickEx(i), nick, true, strlen(nick)) == 0)
                        {
                            selectedplayer = i;
                        }
                    }
                }
            }
            format(string_two, sizeof(string_two), "{%s}(%s) {FFFFFF}%s%s", 
                connected_status > 0 ? "00FF00" : "FF0000",
                connected_status > 0 ? "Online" : "Offline",
                nick,
                selectedplayer != INVALID_PLAYER_ID ? sprintf(" [%d]", selectedplayer) : ""
            );
            
            SendClientMessage(playerid, COLOR_WHITE, string_two);
            selectedplayer = INVALID_PLAYER_ID;
        }
    }
    mysql_free_result();
}

MruMySQL_Gangzone(zoneid)
{
    new str[64];
    format(str, sizeof(str), "UPDATE `mru_config` SET `gangzone`='%d'", zoneid);
    mysql_query(str);
}

MruMySQL_KodStanowca(code)
{
    new lStr[64];
    format(lStr, sizeof(lStr), "UPDATE `mru_config` SET `stanowe_key`='%d'", code);
    mysql_query(lStr);
}

MruMySQL_SetZoneControl(frac, id)
{
    new str[128];
    format(str, 128, "UPDATE `mru_strefy` SET `gang`='%d' WHERE `id`='%d'", frac, id);
    mysql_query(str);
}

MruMySQL_ChangePassword(nick[], password[])
{
    new string[256];
    new escaped_nick[MAX_PLAYER_NAME];
    new hashedPassword[WHIRLPOOL_LEN], salt[SALT_LENGTH];
    randomString(salt, sizeof(salt));
    WP_Hash(hashedPassword, sizeof(hashedPassword), sprintf("%s%s%s", ServerSecret, password, salt));
    mysql_real_escape_string(nick, escaped_nick);
    format(string, sizeof(string), "UPDATE `mru_konta` SET `Key` = '%s', `Salt` = '%s' WHERE `Nick` = '%s'", hashedPassword, salt, escaped_nick);
    mysql_query(string);
}

MruMySQL_ZoneDelay(zoneid)
{
    new str[64];
    format(str, sizeof(str), "UPDATE `mru_config` SET `gangtimedelay`='%d'", zoneid);
    mysql_query(str);
}
