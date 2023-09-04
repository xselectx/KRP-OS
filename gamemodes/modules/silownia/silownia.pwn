//new Object:bench;
new playerIsPressingKey[MAX_PLAYERS];
new playerIsOnBench[MAX_PLAYERS];
new playerHasMembership[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    playerIsPressingKey[playerid] = false;
    playerIsOnBench[playerid] = false;
    playerHasMembership[playerid] = false;
    return 1;
}

hook OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/kupkarnet", true))
    {
        playerHasMembership[playerid] = true; 
        SendClientMessage(playerid, COLOR_WHITE, "Zakupi³eœ karnet na si³owniê!");
        return 0;
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 400.250000, -1335.750000, 14.250000))
        {
            if(playerHasMembership[playerid]) 
            {
                if(newkeys == KEY_YES && !playerIsPressingKey[playerid] && !playerIsOnBench[playerid])
                {
                    GameTextForPlayer(playerid, "WYCISKASZ NA £AWECZCE", 5000, 2);
                    SendClientMessage(playerid, COLOR_WHITE, "Trwa trening przez 30 sekund.");
                    SetPlayerPos(playerid, 400.250000, -1335.750000, 15.250000);
                    SetPlayerFacingAngle(playerid, 96.0);
                    ApplyAnimation(playerid, "benchpress", "gym_bp_geton", 1, 0, 0, 0, 1, 1, 1 );

                    playerIsOnBench[playerid] = true;
                    playerIsPressingKey[playerid] = true;
                    SetTimerEx("EndBenchAnimation", 30000, false, "i", playerid);
                }
            }
            else 
            {
                SendClientMessage(playerid, COLOR_RED, "Musisz mieæ karnet, aby korzystaæ z ³aweczki na si³owni.");
            }
        }
    }
    return 1;
}
forward EndBenchAnimation(playerid);
public EndBenchAnimation(playerid)
{
    playerIsOnBench[playerid] = false;
    playerIsPressingKey[playerid] = false;
    ClearAnimations(playerid, 1);
    SendClientMessage(playerid, COLOR_WHITE, "Skoñczy³eœ trening! Twoja postaæ jest teraz szybsza i wiêcej zadaje.");
    return 1;
}

hook OnPlayerUpdate(playerid)
{
    if(playerIsPressingKey[playerid] && !playerIsOnBench[playerid])
    {
        ClearAnimations(playerid, 1);
        playerIsPressingKey[playerid] = false;
    }
    return 1;
}
