YCMD:supportusun(playerid, params[], help)
{
	new string[64], powod[64];
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pZG] == 0 && PlayerInfo[playerid][pNewAP] == 0 && PlayerInfo[playerid][pAdmin] == 0) return 1;
        
        new supportid;
		if( sscanf(params, "ds[64]", supportid, powod))
		{
			sendTipMessage(playerid, "U�yj /supportusun [SupID] [pow�d]");
			return 1;
		}
        if(supportid > 51 || supportid < 1){
            sendTipMessage(playerid, "Niepoprawne SupID!");
			return 1;
        }
        if (!strlen(suppList[supportid][suppOwner]) && !strlen(suppList[supportid][suppQuestion])){
            sendTipMessage(playerid, "Niepoprawne SupID!");
			return 1;
        }
        if(strlen(powod) < 1){
            sendTipMessage(playerid, "Podaj poprawny pow�d!");
			return 1;
        }

        format(string, sizeof(string), "Usun��e� zg�oszenie o ID: %d od %s, pow�d: %s", supportid, suppList[supportid][suppOwner], powod);
		sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
        format(string, sizeof(string), "Twoje zg�oszenie zosta�o usuni�te przez: %s, pow�d: %s", GetNick(playerid), powod);
		sendTipMessageEx(GetPlayerIDFromName(suppList[supportid][suppOwner]), COLOR_LIGHTBLUE, string);
        SetPVarInt(GetPlayerIDFromName(suppList[supportid][suppOwner]), "active_ticket", 0);

        suppList[supportid][suppOwner] = 0;
		suppList[supportid][suppID] = -1;
		suppList[supportid][suppQuestion] = 0;
		suppList[supportid][suppSend] = false;
    }
    return 1;
}