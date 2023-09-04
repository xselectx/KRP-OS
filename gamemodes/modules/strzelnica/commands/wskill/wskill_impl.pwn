//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                wskill                                                //
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
// Data utworzenia: 06.05.2023

//------------------<[ Implementacja: ]>-------------------
command_wskill_Impl(playerid, params[])
{
    new skill;
    if(sscanf(params, "d", skill))
    {
        SendClientMessage(playerid, COLOR_WHITE, "|__________________ Weapon Skill Info __________________|");
		SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: /wskill [numer]");
		SendClientMessage(playerid, COLOR_GREY, "| 0: Desert Eagle              1: 9MM");
		SendClientMessage(playerid, COLOR_GREY, "| 2: Pistolet z t³umikiem      3: Shotgun");
        SendClientMessage(playerid, COLOR_GREY, "| 4: M4                        5: AK-47");
		SendClientMessage(playerid, COLOR_WHITE, "|________________________________________________|");
        return 1;
    }
    new weaponid = st_getWeaponIDBySkill(skill);
    if(weaponid == -1 || skill < 0 || skill > 5)
    {
        return sendTipMessage(playerid, "Z³y numer skilla!");
    }
    new gunname[32], skillvalue;
    skillvalue = st_getPlayerWeaponSkill(playerid, weaponid);
    GetWeaponName(weaponid, gunname, sizeof(gunname));
    va_SendClientMessage(playerid, COLOR_YELLOW, "Twój skill u¿ywania broni %s wynosi: %d", gunname, skillvalue);
    if(skillvalue < 5)
    {
        new tonext = 0;
        tonext = (skillvalue * 10) - PlayerInfo[playerid][pWeaponSkill][skill];
        va_SendClientMessage(playerid, COLOR_YELLOW, "Musisz jeszcze potrenowaæ %d razy na strzelnicy aby zwiêkszyæ skill!", tonext);
    }
    return 1;
}