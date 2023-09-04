//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ naucz ]-------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:naucz(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new playa, styl;
        if( sscanf(params, "k<fix>d", playa, styl))
        {
            SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /naucz [ID gracza] [numer stylu]");
            SendClientMessage(playerid, COLOR_LIGHTGREEN, "Dostêpne style: 1- Gangsterski("#PRICE_BOX_GANGSTER"$), 2- Kung-Fu("#PRICE_BOX_KUNGFU"$), 3- KickBoxing("#PRICE_BOX_KICKBOX"$)");
            SendClientMessage(playerid, COLOR_GRAD2, "Kiedy sprzedajesz komuœ styl zabiera ci kase (iloœæ podana przy stylu)");
            SendClientMessage(playerid, COLOR_LIGHTGREEN, "Aby zarobic dawaj 2-4 razy wiêksze ceny");
            return 1;
        }
        if(PlayerInfo[playerid][pJob] == 12 || PlayerInfo[playerid][pAdmin] >= 1000)
        {
            if(ProxDetectorS(8.0, playerid, playa) && IsPlayerInRangeOfPoint(playerid, 9.0, 762.9852,2.4439,1001.5942))
            {
                if(styl > 3 || styl < 1)
                {
                    SendClientMessage(playerid, COLOR_GRAD2, "Dostêpne style: 1- gangster("#PRICE_BOX_GANGSTER"$), 2- kung-fu("#PRICE_BOX_KUNGFU"$), 3- KickEx-boxing("#PRICE_BOX_KICKBOX"$)");
                    return 1;
                }
                if(IsPlayerConnected(playa))
                {
                    if(Spectate[playa] != INVALID_PLAYER_ID)
                    {
                        SendClientMessage(playerid, COLOR_GRAD1, "Ten gracz jest za daleko.");
                        return 1;
                    }
                    if(playa != INVALID_PLAYER_ID)
                    {
                        if(styl == 1)
                        {
                            if(kaska[playerid] < PRICE_BOX_GANGSTER)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj¹co du¿o pieniêdzy ($"#PRICE_BOX_GANGSTER").");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_BOXING)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u¿ywa stylu walki 'Gangster'");
                            }
                            else
                            {
                                SetPlayerFightingStyle(playa, FIGHT_STYLE_BOXING);
                                PlayerInfo[playa][pStylWalki] = 1;
                                ZabierzKaseDone(playerid, PRICE_BOX_GANGSTER);
                                format(string, sizeof(string), "* Nauczy³eœ gracza %s stylu walki 'gangster', koszty nauki wynios³y "#PRICE_BOX_GANGSTER"$",GetNick(playa));
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                format(string, sizeof(string), "* Bokser %s nauczy³ ciê stylu walki 'gangster'.",GetNick(playerid));
                                SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyjœciu z gry twoja postaæ nadal bêdzie posiada³a ten styl walki.");
                                format(string, sizeof(string), "~r~-$%d", PRICE_BOX_GANGSTER);
                                GameTextForPlayer(playerid, string, 5000, 1);
                                if(playerid != playa)
                                {
                                    SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczaiæ siê do nowego stylu musisz stoczyæ walkê z bokserem.");
                                    SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczaiæ ucznia do nowego stylu musisz stoczyæ z nim walkê.");
                                    SetPlayerInterior(playerid, 5); SetPlayerInterior(playa, 5);
                                    SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
                                    SetPlayerPos(playa, 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(playa, 313.1165);
                                    GameTextForPlayer(playerid, "~r~Czekaj", 3000, 1); GameTextForPlayer(playa, "~r~Czekaj", 3000, 1);
                    				TogglePlayerControllable(playerid, 0); TogglePlayerControllable(playa, 0);
                        			TBoxer = playerid;
                        			BoxDelay = 30;
                    				BoxWaitTime[playerid] = 1; BoxWaitTime[playa] = 1;
                    				if(BoxDelay < 1) { BoxDelay = 20; }
                    				InRing = 1;
                    				Boxer1 = playa;
                    				Boxer2 = playerid;
                    				PlayerBoxing[playerid] = 1;
                    				PlayerBoxing[playa] = 1;
                    				BoxOffer[playerid] = 999;
                    				BoxOffer[playa] = 999;
                                    //
                                }
                            }
                        }
                        else if(styl == 2)
                        {
                            if(kaska[playerid] < PRICE_BOX_KUNGFU)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj¹co du¿o pieniêdzy ($"#PRICE_BOX_KUNGFU").");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_KUNGFU)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u¿ywa stylu walki 'Kung Fu'");
                            }
                            else
                            {
                                if(PlayerInfo[playerid][pBoxSkill] > 100)
                                {
                                    SetPlayerFightingStyle(playa, FIGHT_STYLE_KUNGFU);
                                    PlayerInfo[playa][pStylWalki] = 2;
                                    ZabierzKaseDone(playerid, PRICE_BOX_KUNGFU);
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Naucz³eœ gracza %s stylu walki 'kung-fu', koszty nauki wynios³y "#PRICE_BOX_KUNGFU"$",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Bokser %s nauczy³ ciê stylu walki stylu walki 'kung-fu'",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyjœciu z gry twoja postaæ nadal bêdzie posiada³a ten styl walki");
                                    format(string, sizeof(string), "~r~-$%d", PRICE_BOX_KUNGFU);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    if(playerid != playa)
                                    {
                                        SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczaiæ siê do nowego stylu musisz stoczyæ walkê z bokserem");
                                        SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczaiæ ucznia do nowego stylu musisz stoczyæ z nim walkê");
                                        SetPlayerInterior(playerid, 5); SetPlayerInterior(playa, 5);
                                        SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
                                        SetPlayerPos(playa, 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(playa, 313.1165);
                                        TogglePlayerControllable(playerid, 0); TogglePlayerControllable(playa, 0);
                                        GameTextForPlayer(playerid, "~r~Czekaj", 3000, 1); GameTextForPlayer(playa, "~r~Czekaj", 3000, 1);
                                        if(BoxOffer[playerid] == 999) return GameTextForPlayer(playa, "~r~Brak oferty", 3000, 1);
                                        BoxWaitTime[playerid] = 1; BoxWaitTime[BoxOffer[playerid]] = 1;
                                        if(BoxDelay < 1){ BoxDelay = 20; }
                                        InRing = 1;
                                        Boxer1 = playa;
                                        Boxer2 = playerid;
                                        PlayerBoxing[playerid] = 1;
                                        PlayerBoxing[BoxOffer[playerid]] = 1;
                                        BoxDelay = 0;
                                        BoxWaitTime[playerid] = 0;
                                        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                                        PlayerPlaySound(playa, 1057, 0.0, 0.0, 0.0);
                                        GameTextForPlayer(playerid, "~g~Walka rozpoczeta", 5000, 1);
                                        GameTextForPlayer(playa, "~g~Walka rozpoczeta", 5000, 1);
                                        TogglePlayerControllable(playerid, 1);
                                        TogglePlayerControllable(playa, 1);
                                        RoundStarted = 1;
                                        PlayerInfo[playerid][pBoxSkill] ++;
                                        PlayerInfo[playerid][pBoxSkill] ++;
                                        PlayerInfo[playerid][pBoxSkill] ++;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill + 3");
                                    }
                                }
                                else
                                {
                                    SendClientMessage(playerid, COLOR_RED, "Potrzebujesz 3 skillu Boxera aby móc uczyæ kung fu");
                                }
                            }
                        }
                        else if(styl == 3)
                        {
                            if(kaska[playerid] < PRICE_BOX_KICKBOX)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Nie masz wystarczaj¹co du¿o pieniêdzy ($"#PRICE_BOX_KICKBOX").");
                            }
                            else if(GetPlayerFightingStyle(playa) == FIGHT_STYLE_KNEEHEAD)
                            {
                                SendClientMessage(playerid, COLOR_RED, "Gracz aktualnie u¿ywa stylu walki 'KickBoxing'");
                            }
                            else
                            {
                                if(PlayerInfo[playerid][pBoxSkill] > 200)
                                {
                                    SetPlayerFightingStyle(playa, FIGHT_STYLE_KNEEHEAD);
                                    PlayerInfo[playa][pStylWalki] = 3;
                                    ZabierzKaseDone(playerid, PRICE_BOX_KICKBOX);
                                    GetPlayerName(playerid, sendername, sizeof(sendername));
                                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                    format(string, sizeof(string), "* Naucz³eœ gracza %s stylu walki 'Kick Boxing', koszty nauki wynios³y "#PRICE_BOX_KICKBOX"$",giveplayer);
                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                    format(string, sizeof(string), "* Bokser %s nauczy³ ciê stylu walki stylu walki 'Kick Boxing'",sendername);
                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                    SendClientMessage(playa, COLOR_GRAD4, "INFORMACJA: Nawet po wyjœciu z gry twoja postaæ nadal bêdzie posiada³a ten styl walki");
                                    format(string, sizeof(string), "~r~-$%d", PRICE_BOX_KICKBOX);
                                    GameTextForPlayer(playerid, string, 5000, 1);
                                    if(playerid != playa)
                                    {
                                        SendClientMessage(playa, COLOR_PANICRED, "Aby przyzwyczaiæ siê do nowego stylu musisz stoczyæ walkê z bokserem");
                                        SendClientMessage(playerid, COLOR_PANICRED, "Aby przyzwyczaiæ ucznia do nowego stylu musisz stoczyæ z nim walkê");
                                        SetPlayerInterior(playerid, 5); SetPlayerInterior(playa, 5);
                                        SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
                                        SetPlayerPos(playa, 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(playa, 313.1165);
                                        TogglePlayerControllable(playerid, 0); TogglePlayerControllable(playa, 0);
                                        GameTextForPlayer(playerid, "~r~Czekaj", 3000, 1); GameTextForPlayer(playa, "~r~Czekaj", 3000, 1);
                                        if(BoxOffer[playerid] == 999) return GameTextForPlayer(playa, "~r~Brak oferty", 3000, 1);
                                        BoxWaitTime[playerid] = 1; BoxWaitTime[BoxOffer[playerid]] = 1;
                                        if(BoxDelay < 1){ BoxDelay = 20; }
                                        InRing = 1;
                                        Boxer1 = playa;
                                        Boxer2 = playerid;
                                        PlayerBoxing[playerid] = 1;
                                        PlayerBoxing[BoxOffer[playerid]] = 1;
                                        BoxDelay = 0;
                                        BoxWaitTime[playerid] = 0;
                                        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                                        PlayerPlaySound(playa, 1057, 0.0, 0.0, 0.0);
                                        GameTextForPlayer(playerid, "~g~Walka rozpoczeta", 5000, 1);
                                        GameTextForPlayer(playa, "~g~Walka rozpoczeta", 5000, 1);
                                        TogglePlayerControllable(playerid, 1);
                                        TogglePlayerControllable(playa, 1);
                                        RoundStarted = 1;
                                        PlayerInfo[playerid][pBoxSkill] ++;
                                        PlayerInfo[playerid][pBoxSkill] ++;
                                        PlayerInfo[playerid][pBoxSkill] ++;
                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill + 3");
                                    }
                                }
                                else
                                {
                                    SendClientMessage(playerid, COLOR_RED, "Potrzebujesz 4 skillu Boxera aby móc uczyæ Kick Boxingu");
                                }
                            }
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_RED, "Gracz nie istnieje.");
                    }
                }
            }
            else
            {
                SendClientMessage(playerid, COLOR_RED, "Gracz jest za daleko.");
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, "Nie jesteœ bokserem.");
        }
    }
    return 1;
}
