//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                setwskill                                                //
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================

//-------<[ command ]>-------
YCMD:setwskill(playerid, params[], help)
{
    if (help)
    {
        return 1;
    }
    
    if(PlayerInfo[playerid][pAdmin] < 3000)
        return noAccessMessage(playerid);
    new targetid, skillid, skillvalue;
    if(sscanf(params, "k<fix>dd", targetid, skillid, skillvalue))
        return sendTipMessage(playerid, "U¿yj: /setwskill [id gracza] [id skilla] [wartoœæ]");
    if(!IsPlayerConnected(targetid) || IsPlayerNPC(targetid))
        return sendTipMessage(playerid, "Gracz o podanym ID nie jest po³¹czony z serwerem.");
    if(skillid < 0 || skillid > 5)
        return sendTipMessage(playerid, "ID skilla od 0 do 5!");
    if(skillvalue < 0 || skillvalue > 40)
        return sendTipMessage(playerid, "Wartoœæ od 0 do 40!");
    PlayerInfo[targetid][pWeaponSkill][skillid] = skillvalue;
    return 1;
}