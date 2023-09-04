YCMD:reporty(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        new tekst[4096], string[128];
        if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pZG] >= 3 || IsAScripter(playerid) || PlayerInfo[playerid][pNewAP] >= 1){
            if(GetPlayerAdminDutyStatus(playerid) == 1){
			    iloscInne[playerid] = iloscInne[playerid]+1;
		    }
            strcat(tekst, "{d9d9d9}RepID\t{d9d9d9}Zg³aszaj¹cy\t{d9d9d9}Zg³oszony" );
            for (new i = 1; i < MAX_REPORTS; i++)
            {
                // Pomijamy zg³oszenia puste
                if (!strlen(repList[i][repOwner]) && !strlen(repList[i][reported]))
                    continue;

                format(string, sizeof(string), "\n{FFD700}%d\t{d9d9d9}%s(%d)\t{d9d9d9}%s(%d)", i, repList[i][repOwner], GetPlayerIDFromName(repList[i][repOwner]), repList[i][reported], GetPlayerIDFromName(repList[i][reported]));
                strcat(tekst, string);
            }
            ShowPlayerDialogEx(playerid, DIALOG_REPORT_LISTA, DIALOG_STYLE_TABLIST_HEADERS, "{d9d9d9}Zg³oszenia - REPORTY", tekst, "Wybierz", "WyjdŸ" );
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}