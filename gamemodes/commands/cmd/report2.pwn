
YCMD:report(playerid, params[], help){
    if(IsPlayerConnected(playerid)){
        new giveplayerid, text[128], string[128];
        new reportid = -1;
        if(gPlayerLogged[playerid] == 1){
            if(sscanf(params, "is[128]", giveplayerid, text)){
                sendTipMessage(playerid, "U�yj /report [playerid] [tekst]"); 
                return 1;
            }
            if(IsPlayerConnected(giveplayerid)){
                if(giveplayerid == playerid){
                        sendTipMessage(playerid, "Nie mo�esz zreportowa� sam siebie. U�yj /support w innym wypadku ni� zg�oszenie gracza!"); 
                        return 1;
                }
                if(GetPlayerAdminDutyStatus(giveplayerid) == 1){
                    sendTipMessage(playerid, "Zg�oszenia dotycz�ce cz�onk�w administracji sk�adamy na forum!");
                    return 1;
                }
                if(IsPlayerNPC(giveplayerid)){
                    sendTipMessage(playerid, "B��dne ID gracza!");
                    return 1;
                }
                if(GetPVarInt(playerid, "wyreportowany") > 1){
                    sendTipMessageFormat(playerid, "Odczekaj %d sekund przed nast�pnym wys�aniem zg�oszenia!", GetPVarInt(playerid, "wyreportowany"));
                    return 1;
                }
                if (strlen(text) <= 0){
                    sendTipMessage(playerid, "Uzupe�nij poprawnie zg�oszenie tekstem!");
                    return 1;
                }
                for( new xid = 1; xid < MAX_REPORTS; xid++ ) {
                    if( repList[ xid ][ repSend ] == false ) {
                        reportid = xid;
                        break;
                    }
                }
                if( reportid == -1 ) return sendTipMessage( playerid, "Osi�gni�to maksymaln� liczb� zg�osze�!" );
                
                repList[ reportid ][ repSend ] = true;
                repList[ reportid ][ repID ] = playerid;
        
                repInfo[ playerid ][ repSended ] = true;
                repInfo[ playerid ][ repAnswered ] = false;
                        
                strmid( repList[ reportid ][ reported ], GetNick( giveplayerid ), 0, strlen( GetNick( giveplayerid ) ), 32 );
                strmid( repList[ reportid ][ repOwner ], GetNick( playerid ), 0, strlen( GetNick( playerid ) ), 32 );
                strmid( repList[ reportid ][ repQuestion ], text, 0, strlen( text ), 128 );
                        
                SendClientMessage(playerid, 0x008000AA, "Tw�j report zosta� wys�any do administracji, oczekuj na reakcj� zanim napiszesz kolejny!");
                format(string, sizeof(string), "[REPORT #%d] %s[%d] na %s[%d]: {FFFFFF}%s", reportid, GetNick(playerid), playerid, GetNick(giveplayerid), giveplayerid, text);
                SendMessageToAdminEx(string, COLOR_YELLOW, 1);
                format(string, sizeof(string), "[REPORT %d] %s[%d] na %s[%d]: %s", reportid, GetNick(playerid), playerid, GetNick(giveplayerid), giveplayerid, ret_strreplace(text, "@", "", true));
			    SendDiscordMessage(DISCORD_REPORT, string);
                SetPVarInt(playerid, "wyreportowany", 15); //timer
            }
            else{
                sendTipMessage( playerid, "Tego gracza nie ma na serwerze!" );
            }
		}
    }
    return 1;
}
