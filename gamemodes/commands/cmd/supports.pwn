YCMD:supporty(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        new tekst[4096], string[128], skrocony[13];
        if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 3 || IsAScripter(playerid) || PlayerInfo[playerid][pNewAP] >= 1){
            if(GetPlayerAdminDutyStatus(playerid) == 1){
			    iloscInne[playerid] = iloscInne[playerid]+1;
		    }
            strcat(tekst, "{d9d9d9}SuppID\t{d9d9d9}Zg�aszaj�cy\t{d9d9d9}Pow�d" );
            for (new i = 1; i < MAX_SUPPORTS; i++)
            {
                // Pomijamy zg�oszenia puste
                if (!strlen(suppList[i][suppOwner]) && !strlen(suppList[i][suppQuestion]))
                    continue;
                
                strmid(skrocony, suppList[i][suppQuestion], 0, 13);

                format(string, sizeof(string), "\n{FFD700}%d\t{d9d9d9}%s(%d)\t{d9d9d9}%s", i, suppList[i][suppOwner], GetPlayerIDFromName(suppList[i][suppOwner]), skrocony);
                strcat(tekst, string);
            }
            ShowPlayerDialogEx(playerid, DIALOG_SUPPORT_LISTA, DIALOG_STYLE_TABLIST_HEADERS, "{d9d9d9}Zg�oszenia - SUPPORTS", tekst, "Wybierz", "Wyjd�" );
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}