//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ jail ]-------------------------------------------------//
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

YCMD:jail(playerid, params[], help)
{
    new string[128];
    new giveplayer[MAX_PLAYER_NAME];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new playa, money;
        if( sscanf(params, "k<fix>d", playa, money))
        {
            sendTipMessage(playerid, "U�yj /jail [playerid/Cz��Nicku] [czas(minuty)]");
            return 1;
        }


        if (PlayerInfo[playerid][pAdmin] >= 20 || IsAScripter(playerid))
        {
            if(IsPlayerConnected(playa))
            {
                if(playa != INVALID_PLAYER_ID)
                {
                    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    format(string, sizeof(string), "* Uwi�zi�e� %s.", giveplayer);
                    SendClientMessage(playerid, COLOR_LIGHTRED, string);
                    format(string, sizeof(string), "* Zosta�e� uwi�ziony przez Admina %s.", sendername);
                    SendClientMessage(playa, COLOR_LIGHTRED, string);
                    format(string, sizeof(string), "* %s zosta� uwi�ziony w wi�zieniu na %d minut przez admina %s.",giveplayer, money, sendername);
                    SendPunishMessage(string, playa);
                    RemovePlayerWeaponsTemporarity(playa);
                    PoziomPoszukiwania[playa] = 0;
                    PlayerInfo[playa][pJailed] = 1;
                    PlayerInfo[playa][pJailTime] = money * 60;
                    SetPlayerInterior(playa, 0);
                    SetPlayerVirtualWorld(playa, 29);
                    new losuj= random(sizeof(Cela));
                    SetPlayerPos(playa, Cela[losuj][0], Cela[losuj][1], Cela[losuj][2]);
                    format(string, sizeof(string), "Zosta�e� uwi�ziony na %s minut.   Kaucja: Niedost�pna", money);
                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                    Wchodzenie(playa);
                    EXPPlayerJail(playerid, money);
                }
            }
        } else
        {
            noAccessMessage(playerid);
        }
    }
    return 1;
}
