YCMD:bb(playerid, params[])
{
    new option[32], values[64];
    if(sscanf(params, "s[32]S()[64]", option, values))
    {
        if(PlayerInfo[playerid][pAdmin] >= 1000)
            return sendTipMessage(playerid, "U¿yj: /bb [rent/unrent/price/create/destroy]");
        else
            return sendTipMessage(playerid, "U¿yj: /bb [rent/unrent]");
    }
    if(strcmp(option, "rent", true) == 0)
    {
        sendTipMessage(playerid, "Bilboard mo¿esz wynajmowaæ od 2 poziomu!");
        return 1;
    }
    else if(strcmp(option, "unrent", true) == 0)
    {
        sendTipMessage(playerid, "Bilboard mo¿esz wynajmowaæ od 2 poziomu!");
        return 1;
    }
    if(PlayerInfo[playerid][pAdmin] < 1000) return sendTipMessage(playerid, "U¿yj: /bb [rent/unrent]");
    else
    {
        if(strcmp(option, "create", true) == 0)
        {
            if(PlayerInfo[playerid][pIsEditingBilboard] == false)
            {
                new Float:x, Float:y, Float:z, Float:a;
                GetPlayerPos(playerid, x, y, z);
                GetPlayerFacingAngle(playerid, a);
                GetXYInFrontOfPlayer(playerid, x, y, 2.0);
                PlayerInfo[playerid][pIsEditingBilboard] = true;
                PlayerInfo[playerid][pEditorBilboardObject] = CreateDynamicObject(1260, x, y, z + 10, 0, 0, a + 90, -1, -1, -1, 1000, 1000, -1, 1);
                EditDynamicObject(playerid, PlayerInfo[playerid][pEditorBilboardObject]);
                sendTipMessage(playerid, "Ustaw teraz bilboard na pozycji i nacisnik przycisk ZAPISZ(Dyskietka)...");
                sendTipMessage(playerid, "Przycisk {FF0000}SPACJA {FFFFFF}pozwala na poruszanie kamery.");
                sendTipMessage(playerid, "Przycisk {FF0000}ESC {FFFFFF}anuluje tworzenie bilboarda.");
            }
            else sendErrorMessage(playerid, "Aktualnie tworzysz bilboard.");
            return 1;
        }
        else if(strcmp(option, "price", true) == 0)
        {
            new bilbid, newcost;
            if(sscanf(values, "dd", bilbid, newcost))
                return sendTipMessage(playerid, "U¿yj: /bb price [id bilboardu] [cena]");

            if(bilbid < 0) sendErrorMessage(playerid, "ID bilboardu nie mo¿e byæ mniejsze ni¿ 0.");
            else if(Bilboard[bilbid][bcreated] == false && Bilboard[bilbid][bloaded] == false) sendErrorMessage(playerid, "Ten bilboard nie istnieje!");
            else if(!IsPlayerInRangeOfPoint(playerid, 50.0, Bilboard[bilbid][bposx], Bilboard[bilbid][bposy], Bilboard[bilbid][bposz])) sendErrorMessage(playerid, "Nie jesteœ w pobli¿u tego bilboardu!");
            else
            {
                Bilboard[bilbid][bcost] = newcost;
                new query[128];
                format(query, sizeof query, "UPDATE mru_bilboard SET cost = '%i' WHERE uid = '%i'", Bilboard[bilbid][bcost], Bilboard[bilbid][buid]);
                mysql_query(query);
                format(query, sizeof query, "Cena bilbordu ID %i zostala zmieniona na $%i za dzien.", bilbid, Bilboard[bilbid][bcost]);
                SendClientMessage(playerid, -1, query);
                if(Bilboard[bilbid][btime] == -1)
                    UpdateBilboard(bilbid);
            }
            return 1;
        }
    }

    return 1;
}