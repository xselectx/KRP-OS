//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  strzelnica                                                  //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
// Autor: renosk
// Data utworzenia: 02.05.2023
// Opis:

//

ptask stTimer[1000](playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(stPlayer[playerid][stp_place] == -1 || stPlayer[playerid][stp_place] > MAX_ST) return 0;
    if(GetPVarInt(playerid, "bypassac-forweapon") <= 0) return 0;

    stPlayer[playerid][stp_spenttime]++;
    stPlayer[playerid][stp_lefttime]--;
    if(stPlayer[playerid][stp_lefttime] <= 0)
    {
        //Koniec czasu
        if(stPlayer[playerid][stp_accurate] > stPlayer[playerid][stp_misses] && stPlayer[playerid][stp_points] >= 300)
        {
            st_addSkillToWeapon(playerid, GetPVarInt(playerid, "bypassac-forweapon"));
        }
        else
        {
            sendErrorMessage(playerid, "Niestety twoje umiejêtnoœci nie wzros³y. Masz zbyt du¿o niecelnych strza³ów/za ma³o punktów, popracuj nad tym!");
        }
        st_stop(playerid);
        return 1;
    }
    new string[328], phase = stPlayer[playerid][stp_phase], points = stPlayer[playerid][stp_points], gunname[32], spenttime = stPlayer[playerid][stp_spenttime], lefttime = stPlayer[playerid][stp_lefttime];
    new lastshot = gettime() - stPlayer[playerid][stp_lastshot];
    if( lastshot >= 40 && lastshot < 60 && stPlayer[playerid][stp_lastshot] > 0 && GetPVarInt(playerid, "stafkinfo") == 0)
    {
        ShowPlayerInfoDialog(playerid, "Strzelnica - Nieaktywnoœæ", "Za chwilê zostaniesz wyrzucony ze strzelnicy, je¿eli nie wykonasz ¿adnej czynnoœci.");
        SetPVarInt(playerid, "stafkinfo", 1);
    }
    else if(lastshot >= 50 && stPlayer[playerid][stp_lastshot] > 0)
    {
        return st_stop(playerid, "Brak jakiejkolwiek aktywnoœci.");
    }
    
    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    if( (IsPlayerAimingEx(playerid) || keys & KEY_AIM) && points < 200 && st_getPlayerWeaponSkill(playerid, GetPVarInt(playerid, "bypassac-forweapon") <= 1))
    {
        SetPlayerDrunkLevel(playerid, 3000);
    }
    else
    {
        SetPlayerDrunkLevel(playerid, 0);
    }

    GetWeaponName(GetPVarInt(playerid, "bypassac-forweapon"), gunname, sizeof(gunname));
    new lefttime_m = 0, spenttime_m = 0;
    lefttime_m = floatround(lefttime / 60 % 60);
    spenttime_m = floatround(spenttime / 60 % 60);
    lefttime -= (lefttime_m * 60);
    spenttime -= (spenttime_m * 60);
    format(string, sizeof(string), "Bron: ~y~%s~n~~w~Punkty: ~y~%d~n~~w~Spedzony czas:~y~%dm %ds~n~~w~Zostalo: ~y~%dm %ds~n~~w~Typ: ~y~%s", gunname, points, spenttime_m, spenttime, lefttime_m, lefttime, (phase == 1) ? ("strzelanie do nieruchomych celow") : ("?"));
    PlayerTextDrawSetString(playerid, strzelnica_textdraw[playerid], string);
    if(points >= 200)
    {
        SetPlayerDrunkLevel(playerid, 2000);
    }
    return 1;
}