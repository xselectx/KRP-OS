//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ napraw ]------------------------------------------------//
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

YCMD:napraw(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pJob] == 7 ||  IsANoA(playerid) || HasPerm(playerid, PERM_MECHANIC))
        {
            new playa, money;
            if( sscanf(params, "k<fix>s[32]", playa, string))
            {
                sendTipMessage(playerid, "U�yj /napraw [playerid/Cz��Nicku] [cena]");
                return 1;
            }
            money = FunkcjaK(string);

            if(money < PRICE_MECH_FIX_MIN || money > PRICE_MECH_FIX_MAX) { sendTipMessageEx(playerid, COLOR_GREY, "Cena od "#PRICE_MECH_FIX_MIN"$ do "#PRICE_MECH_FIX_MAX"$!"); return 1; }
            if(IsPlayerConnected(playa))
            {
                if(playa != INVALID_PLAYER_ID)
                {
                    if(ProxDetectorS(8.0, playerid, playa) && IsPlayerInAnyVehicle(playa) && Spectate[playa] == INVALID_PLAYER_ID)
                    {
                        if(SpamujeMechanik[playerid] == 0)
                        {
                            if(!IsPlayerInAnyVehicle(playerid))
                            {
                                if(playa == playerid) { sendErrorMessage(playerid, "Nie mo�esz naprawi� wozu samemu sobie!"); return 1; }
                                GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                GetPlayerName(playerid, sendername, sizeof(sendername));
                                format(string, sizeof(string), "* Oferujesz %s napraw� wozu za $%d .",giveplayer,money);
                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                format(string, sizeof(string), "* Mechanik %s proponuje napraw� twojego wozu za $%d, (wpisz /akceptuj naprawe) aby akceptowa�.",sendername,money);
                                SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                RepairOffer[playa] = playerid;
                                RepairPrice[playa] = money;
                                SpamujeMechanik[playerid] = 1;
                                SetTimerEx("AntySpamMechanik",30000,0,"d",playerid);
                            }
                            else
                            {
                                sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz naprawia� auta b�d�c w wozie.");
                            }
                        }
                        else
                        {
                            sendTipMessageEx(playerid, COLOR_GREY, "Poczekaj 30 sekund.");
                        }
                    }
                    else
                    {
                        sendErrorMessage(playerid, "Ten gracz nie jest przy tobie / nie jest w wozie.");
                    }
                }
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie ma takiego gracza.");
            }
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� mechanikiem!");
            return 1;
        }
    }
    return 1;
}
