//  podniesbw.pwn
YCMD:podniesbw(playerid, params[])
{
    if(CheckBW(playerid)) return sendErrorMessage(playerid, "Nie mo¿esz mieæ aktywnego BW!");
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return sendErrorMessage(playerid, "Musisz byæ pieszo.");
    new targetid = GetClosestPlayer(playerid);
    if(!IsPlayerConnected(targetid) || targetid == INVALID_PLAYER_ID || GetPlayerState(targetid) == PLAYER_STATE_SPECTATING) return sendErrorMessage(playerid, "W pobli¿u nie ma ¿adnego gracza!");
    if(!CheckBW(targetid)) return sendErrorMessage(playerid, "Gracz w pobli¿u którego siê znajdujesz nie ma BW!");
    if(GetPVarInt(playerid, "podniesbw-cd") > gettime()) return sendErrorMessage(playerid, "Tej komendy mo¿esz u¿yæ co 5 minut.");
    if(!IsPlayerNear(playerid, targetid)) return sendErrorMessage(playerid, "Error.");
    if(GetPVarInt(playerid, "healingprocess") >= 1000) return sendErrorMessage(playerid, "Leczysz ju¿ kogoœ.");

    SetPVarInt(playerid, "healingprocess", targetid+1000);
    SetPVarInt(playerid, "podniesbw-cd", gettime()+300);
    sendTipMessage(playerid, "Rozpocz¹³eœ proces podnoszenia z BW trwaj¹cy 60 sekund.");
    va_SendClientMessage(targetid, COLOR_GRAD3, "Gracz %s zacz¹³ podnosiæ Ciê z BW (odczekaj 60 sekund)", GetNick(playerid));
    TextDrawInfoOn(playerid, "poczekaj 60 sekund~n~aby przerwac nacisnij ~g~N", 60000);
    defer HealPlayer(targetid, playerid);
    return 1;
}

timer HealPlayer[60000](playerid, healer)
{
    if(!GetPVarInt(healer, "healingprocess")) return 0;
    DeletePVar(healer, "healingprocess");
    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(healer)) return 0;
    if(!IsPlayerNear(playerid, healer)) return sendErrorMessage(healer, "Oddali³eœ siê od gracza, którego leczy³eœ - proces przerwany.");
    if(!CheckBW(playerid)) return sendErrorMessage(healer, "Ten gracz nie ma BW.");
    if(CheckBW(healer)) return sendErrorMessage(healer, "Masz BW, nie mo¿esz uleczyæ innego gracza.");

    ZdejmijBW(playerid);
    sendTipMessage(healer, "Uleczy³eœ gracza.");
    sendTipMessage(playerid, "Zosta³eœ uleczony.");
    TextDrawInfooff(healer, "");
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_NO)
    {
        if(GetPVarInt(playerid, "healingprocess") >= 1000)
        {
            sendErrorMessage(GetPVarInt(playerid, "healingprocess")-1000, "Gracz podnosz¹cy Ciê z BW anulowa³ proces.");
            DeletePVar(playerid, "healingprocess");
            TextDrawInfooff(playerid, "");
            return sendTipMessage(playerid, "Proces leczenia przerwany.");
        }
    }
    return 1;
}

hook OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
    if(GetPVarInt(playerid, "healingprocess") >= 1000 && IsPlayerConnected(issuerid))
    {
        DeletePVar(playerid, "healingprocess");
        TextDrawInfooff(playerid, "");
        return sendTipMessage(playerid, "Proces leczenia przerwany.");
    }
    return 1;
}