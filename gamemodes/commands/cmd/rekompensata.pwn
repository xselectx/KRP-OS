//rekompensata

YCMD:rekompensata(playerid, params[])
{
    sendErrorMessage(playerid, "Rekompensata na t¹ chwilê jest wy³¹czona.");
    /*if(GetPVarInt(playerid, "got-compensation"))
    {
        return sendErrorMessage(playerid, "Nie mo¿esz odebraæ rekompensaty.");
    }
    DajKase(playerid, 2000);
    if(IsPlayerPremiumOld(playerid))
        DajKP(playerid, PremiumInfo[playerid][pExpires]+259200);
    else
        DajKP(playerid, gettime()+259200);
    PlayerInfo[playerid][pThirst] = 0.0;
    PlayerInfo[playerid][pHunger] = 0.0;
    SendClientMessage(playerid, COLOR_YELLOW, "Otrzymujesz 2000$ oraz Konto Premium na 3 dni w ramach rekompensaty.");
    SetPVarInt(playerid, "got-compensation", 1);
    new query[248];
    format(query, sizeof(query), "UPDATE `mru_konta` SET `Compensation` = '1' WHERE `Nick` = '%s'", GetNickEx(playerid));
    mysql_query(query);
    ABroadCast(COLOR_LIGHTRED, sprintf("%s odebra³ rekompensatê", GetNickEx(playerid)), 3000);*/
    return 1;
}