//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ kostka ]------------------------------------------------//
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

#define Frist_Bet_Value 100
#define Second_Bet_Value 1000

new krecikolemwtf[MAX_PLAYERS];


YCMD:kostka(playerid, params[], help)
{
    if(!IsPlayerInRangeOfPoint(playerid, 50.0, 1038.22924805,-1090.59741211,-67.52223969)) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Tylko w kasynie!");
    if(strcmp(params, "akceptuj", true) == 0 || strcmp(params, "a", true) == 0)
    {
        if(GetPVarInt(playerid, "kostka-wait") == 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nikt nie oferowa� Ci gry!");
        if(GetPVarInt(playerid, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Obecnie rozgrywasz ju� gr�!");
        new id = GetPVarInt(playerid, "kostka-wait")-1;
        if(GetPVarInt(id, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz obecnie rozgrywa gr�.");
        if(GetPVarInt(id, "kostka-last") != playerid) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Rozgrywka nieaktualna.");
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        if(!IsPlayerInRangeOfPoint(id, 10.0, x, y, z))  return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz nie stoi obok Ciebie.");
        new czas = GetPVarInt(id, "kostka-czas");
        if(czas != GetPVarInt(playerid, "kostka-czas")) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Rozgrywka nieaktualna.");
        if(kaska[id] < GetPVarInt(id, "kostka-cash") || kaska[playerid] < GetPVarInt(id, "kostka-cash")) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Jednego z graczy nie sta� na t� gr�.");

        SetPVarInt(playerid, "kostka-cash", GetPVarInt(id, "kostka-cash"));
        SetPVarInt(playerid, "kostka-throw", GetPVarInt(id, "kostka-throw"));

        SetPVarInt(playerid, "kostka", 1);
        SetPVarInt(id, "kostka", 1);
        new str[128], nick[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
        format(str, 128, "%s zaakceptowa� gr�, rzuca on pierwszy.", nick);
        sendTipMessageEx(id, COLOR_GREEN, str);
        sendTipMessageEx(playerid, COLOR_GREEN, "Zaakceptowa�e� gr�, rzucasz pierwszy.");

        SetPVarInt(playerid, "kostka-player", id);
        SetPVarInt(id, "kostka-player", playerid);

        SetPVarInt(playerid, "kostka-rzut", 1);
        SetPVarInt(id, "kostka-rzut", 0);

        ZabierzKaseDone(playerid, GetPVarInt(id, "kostka-cash"));
        ZabierzKaseDone(id, GetPVarInt(id, "kostka-cash"));
        Log(casinoLog, WARNING, "%s zaakceptowa� ofert� kostki od %s", GetPlayerLogName(playerid), GetPlayerLogName(id));
    }
    else if(strcmp(params, "odrzu�", true) == 0 || strcmp(params, "odrzuc", true) == 0 || strcmp(params, "o", true) == 0)
    {
        if(GetPVarInt(playerid, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Obecnie rozgrywasz ju� gr�!");
        if(GetPVarInt(playerid, "kostka-wait") == 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nikt nie oferowa� Ci gry!");
        new id = GetPVarInt(playerid, "kostka-wait")-1;

        SetPVarInt(playerid, "kostka-wait", 0);

        new str[64], nick[MAX_PLAYER_NAME + 1];
        GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
        format(str, 64, "%s odrzuci� Twoje zaproszenie.", nick);
        sendTipMessageEx(id, COLOR_RED, str);
        sendTipMessageEx(playerid, COLOR_RED, "Odrzuci�e� zaproszenie do gry.");
        Log(casinoLog, WARNING, "%s odrzuci� ofert� kostki od %s", GetPlayerLogName(playerid), GetPlayerLogName(id));
    }
    else if(GetPVarInt(playerid, "kostka") == 1)
    {
        if(GetPVarInt(playerid, "kostka-rzut") == 1)
        {
            if(GetPVarInt(playerid, "kostka-throw") == 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Brak rzut�w.");
            new rzuty = GetPVarInt(playerid, "kostka-throw"), str[64], nick[MAX_PLAYER_NAME +1];
            GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
            rzuty--;

            new ile;
            ile = 1+true_random(6);

            format(str, 64, "* %s wyrzuca %d oczek.", nick, ile);
            ProxDetector(12.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            Log(casinoLog, WARNING, "%s wyrzuca %d oczek.", GetPlayerLogName(playerid), ile);

            SetPVarInt(playerid, "kostka-throw", rzuty);
            SetPVarInt(playerid, "kostka-suma", ile + GetPVarInt(playerid, "kostka-suma"));
            new id = GetPVarInt(playerid, "kostka-player");

            if(rzuty == 0)
            {
                if(GetPVarInt(playerid, "kostka-suma") > GetPVarInt(id, "kostka-suma"))
                {
                    if(GetPVarInt(id, "kostka-throw") == 0)
                    {
                        new kasa = GetPVarInt(playerid, "kostka-cash");

                        format(str, 64, "Gratulacje! Wygra�e� %d$!", 2*kasa);
                        sendTipMessageEx(playerid, COLOR_GREEN, str);
                        format(str, 64, "Pora�ka! Przegra�e� %d$!", kasa);
                        sendTipMessageEx(id, COLOR_RED, str);
                        format(str, 64, "* %s wygrywa!", nick);
                        ProxDetector(12.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                        Log(casinoLog, WARNING, "%s wygrywa %d$.", GetPlayerLogName(playerid), 2*kasa);
                        Kostka_Wygrana(playerid, id, (2*kasa));

                        SetPVarInt(playerid, "kostka",0);
                        SetPVarInt(playerid, "kostka-throw", 0);
                        SetPVarInt(playerid, "kostka-suma", 0);
                        SetPVarInt(playerid, "kostka-cash", 0);
                        SetPVarInt(playerid, "kostka-first", 0);
                        SetPVarInt(playerid, "kostka-rzut", 0);
                        SetPVarInt(playerid, "kostka-wait", 0);
                        SetPVarInt(playerid, "kostka-player", 0);

                        SetPVarInt(id, "kostka",0);
                        SetPVarInt(id, "kostka-throw", 0);
                        SetPVarInt(id, "kostka-suma", 0);
                        SetPVarInt(id, "kostka-cash", 0);
                        SetPVarInt(id, "kostka-first", 0);
                        SetPVarInt(id, "kostka-rzut", 0);
                        SetPVarInt(id, "kostka-wait", 0);
                        SetPVarInt(id, "kostka-player", 0);
                    }

                }
                else if(GetPVarInt(playerid, "kostka-suma") == GetPVarInt(id, "kostka-suma"))
                {
                    if(GetPVarInt(id, "kostka-throw") == 0)
                    {
                        SetPVarInt(playerid, "kostka-throw", 1);
                        SetPVarInt(id, "kostka-throw", 1);

                        sendTipMessageEx(playerid, COLOR_RED, "REMIS! Masz dodatkowy rzut.");
                        sendTipMessageEx(id, COLOR_RED, "REMIS! Masz dodatkowy rzut.");
                        Log(casinoLog, WARNING, "%s ma dodatkowy rzut!", GetPlayerLogName(playerid));
                    }
                }
                else
                {
                    if(GetPVarInt(id, "kostka-throw") == 0)
                    {
                        new kasa = GetPVarInt(id, "kostka-cash");

                        GetPlayerName(id, nick, MAX_PLAYER_NAME);
                        format(str, 64, "Gratulacje! Wygra�e� %d$!", 2*kasa);
                        sendTipMessageEx(id, COLOR_GREEN, str);
                        format(str, 64, "Pora�ka! Przegra�e� %d$!", kasa);
                        sendTipMessageEx(playerid, COLOR_RED, str);
                        format(str, 64, "* %s wygrywa!", nick);
                        ProxDetector(12.0, id, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                        Log(casinoLog, WARNING, "%s wygrywa %d$.", GetPlayerLogName(id), 2*kasa);
                        Kostka_Wygrana(id, playerid, (2*kasa));

                        SetPVarInt(playerid, "kostka",0);
                        SetPVarInt(playerid, "kostka-throw", 0);
                        SetPVarInt(playerid, "kostka-suma", 0);
                        SetPVarInt(playerid, "kostka-cash", 0);
                        SetPVarInt(playerid, "kostka-first", 0);
                        SetPVarInt(playerid, "kostka-rzut", 0);
                        SetPVarInt(playerid, "kostka-wait", 0);
                        SetPVarInt(playerid, "kostka-player", 0);

                        SetPVarInt(id, "kostka",0);
                        SetPVarInt(id, "kostka-throw", 0);
                        SetPVarInt(id, "kostka-suma", 0);
                        SetPVarInt(id, "kostka-cash", 0);
                        SetPVarInt(id, "kostka-first", 0);
                        SetPVarInt(id, "kostka-rzut", 0);
                        SetPVarInt(id, "kostka-wait", 0);
                        SetPVarInt(id, "kostka-player", 0);
                    }
                }
            }
            SetPVarInt(playerid, "kostka-rzut", 0);
            SetPVarInt(id, "kostka-rzut", 1);
        }
        else sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "To nie jest Twoja kolej na rzut.");
    }
    else
    {
        new id, kasa, throw, Float:x, Float:y, Float:z;
        if(sscanf(params, "k<fix>dd", id, kasa, throw)) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Aby rozpocz�� gr� w kosci u�yj: /kostka [Nick/ID] [Stawka] [Ilo�c rzut�w]");
        if(!IsPlayerConnected(id) || id == playerid) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Nie ma takiego gracza.");
        if(kasa < PRICE_KOSTKA_MIN || kasa > PRICE_KOSTKA_MAX) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Stawka nie mniejsza ni� "#PRICE_KOSTKA_MIN"$ i nie wi�ksza ni� "#PRICE_KOSTKA_MAX"$");
        if(throw < 2 || throw > 10) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Minimalna ilo�� rzut�w to 2 a maksymalna to 10.");
        if(GetPVarInt(id, "kostka-wait") > 0) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz otrzyma� ju� ofert�.");
        if(GetPVarInt(id, "kostka") == 1 || GetPVarInt(playerid, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz obecnie rozgrywa gr�.");
        GetPlayerPos(playerid, x, y, z);
        if(!IsPlayerInRangeOfPoint(id, 10.0, x, y, z))  return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Ten gracz nie stoi obok Ciebie.");
        if(kaska[id] < kasa || kaska[playerid] < kasa) return sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "Za du�a stawka na Was, ktos nie ma tyle.");

        SetPVarInt(id, "kostka-wait", playerid+1);

        SetPVarInt(playerid, "kostka-cash", kasa);
        SetPVarInt(playerid, "kostka-throw", throw);

        SetPVarInt(playerid, "kostka-last", id);

        SetPVarInt(playerid, "kostka-czas", gettime());
        SetPVarInt(id, "kostka-czas", gettime());

        new str[128], nick[MAX_PLAYER_NAME + 1];
        GetPlayerName(id, nick, MAX_PLAYER_NAME);
        format(str, 128, "Wys�ano zaproszenie do gry graczowi %s.", nick);
        sendTipMessageEx(playerid, COLOR_GREEN, str);
        GetPlayerName(playerid, nick, MAX_PLAYER_NAME);
        format(str, 128, "Gracz %s chce zagra� z Tob� w ko�ci na %d rzut�w o %d $.", nick, throw, kasa);
        Log(casinoLog, WARNING, "%s oferuje kostk� graczowi %s.", GetPlayerLogName(playerid), GetPlayerLogName(id));
        sendTipMessageEx(id, COLOR_GREEN, str);
        sendTipMessageEx(id, COLOR_PAPAYAWHIP, "Aby zaakceptowa� u�yj /kostka akceptuj, aby odrzuci� u�yj /kostka odrzu�");
    }
    return 1;
}

YCMD:zakreckolem(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid,4,1016.8065,-1104.2010,-67.5729))
    {
        if(krecikolemwtf[playerid] == 1) return GameTextForPlayer(playerid, "Zakreciles juz kolem!", 3000, 3);
        if(kaska[playerid] <= PRICE_KASYNO_KF) return GameTextForPlayer(playerid, "Nie masz tyle pieniedzy ("#PRICE_KASYNO_KF"$)!", 3000, 3);
        {
            SetTimerEx("kolofortuny", 5000, false, "i", playerid);
            TextDrawInfoOn(playerid,"Trwa ~y~losowanie!",5000);
            ZabierzKaseDone(playerid, PRICE_KASYNO_KF);
            TogglePlayerControllable(playerid, 0);
            krecikolemwtf[playerid] = true;
        }
    }
    return 1;
}

YCMD:ruletka(playerid, params[])
{
    return 1; //sendErrorMessage(playerid, "Komenda wy��czona!");
}

forward kolofortuny(playerid);
public kolofortuny(playerid)
{
    new kolo = true_random(61), wygrana, string[256];
    if(kolo >= 1 && kolo <= 30)//1
    {
        wygrana = 1;
        Log(payLog, WARNING, "%s zakr�ci� ko�em fortuny i wypad�o: 1$", GetPlayerLogName(playerid));
        format(string, sizeof(string), "* %s zakr�ci� ko�em fortuny kt�re zatrzyma�o si� na: 1$", GetNick(playerid));
        ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
    }
    else if(kolo > 30 && kolo <= 45)//2
    {
        wygrana = 2;
        Log(payLog, WARNING, "%s zakr�ci� ko�em fortuny i wypad�o: 2$", GetPlayerLogName(playerid));
        format(string, sizeof(string), "* %s zakr�ci� ko�em fortuny kt�re zatrzyma�o si� na: 2$", GetNick(playerid));
        ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
    }
    else if(kolo > 45 && kolo <= 53)//5
    {
        wygrana = 5;
        Log(payLog, WARNING, "%s zakr�ci� ko�em fortuny i wypad�o: 5$", GetPlayerLogName(playerid));
        format(string, sizeof(string), "* %s zakr�ci� ko�em fortuny kt�re zatrzyma�o si� na: 5$", GetNick(playerid));
        ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
    }
    else if(kolo > 53 && kolo <= 57)//10
    {
        wygrana = 10;
        Log(payLog, WARNING, "%s zakr�ci� ko�em fortuny i wypad�o: 10$", GetPlayerLogName(playerid));
        format(string, sizeof(string), "* %s zakr�ci� ko�em fortuny kt�re zatrzyma�o si� na: 10$", GetNick(playerid));
        ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
    }
    else if(kolo == 58 || kolo == 59)//20
    {
        wygrana = 20;
        Log(payLog, WARNING, "%s zakr�ci� ko�em fortuny i wypad�o: 20$", GetPlayerLogName(playerid));
        format(string, sizeof(string), "* %s zakr�ci� ko�em fortuny kt�re zatrzyma�o si� na: 20$", GetNick(playerid));
        ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
    }
    else if(kolo == 60 || kolo == 61)//*
    {
        wygrana = 40;
        Log(payLog, WARNING, "%s zakr�ci� ko�em fortuny i wypad�o: 40$", GetPlayerLogName(playerid));
        format(string, sizeof(string), "* %s zakr�ci� ko�em fortuny kt�re zatrzyma�o si� na gwie�dzie fortuny (40$)", GetNick(playerid));
        ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
    }
    
    new StringWygrana[258];
    DajKaseDone(playerid, wygrana);
    TogglePlayerControllable(playerid, 1);
    krecikolemwtf[playerid] = false;
    format(StringWygrana, sizeof(StringWygrana), "~g~Wylosowano ~w~%d~g~$", wygrana);
    TextDrawInfoOn(playerid,StringWygrana,5000);

    return 1;
}