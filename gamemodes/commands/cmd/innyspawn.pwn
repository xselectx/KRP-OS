//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ innyspawn ]-----------------------------------------------//
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

YCMD:innyspawn(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pDom] != 0)
        {
            if(PlayerInfo[playerid][pSpawn])
            {
                sendTipMessageEx(playerid, COLOR_GREY, "B�dziesz si� teraz spawnowa� w normalnym miejscu !");
                PlayerInfo[playerid][pSpawn] = 0;
                PlayerInfo[playerid][pGrupaSpawn] = 0;
                if(IsAnInstructor(playerid))
                {
                    if(SchoolSpawn[playerid] == 0)
                    {
                        SchoolSpawn[playerid] = 1;
                        sendTipMessageEx(playerid, COLOR_GREY, "B�dziesz si� teraz spawnowa� w Szkole Latania !");
                    } else if(SchoolSpawn[playerid] == 1)
                    {
                        SchoolSpawn[playerid] = 0;
                        sendTipMessageEx(playerid, COLOR_GREY, "B�dziesz si� teraz spawnowa� w Szkole Jazdy !");
                    }
                }
            } else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "B�dziesz si� teraz spawnowa� w swoim/wynajmowanym domu !");
                PlayerInfo[playerid][pSpawn] = 1;
            }
        } else
        {
            if(IsAnInstructor(playerid))
            {
                if(SchoolSpawn[playerid] == 0)
                {
                    SchoolSpawn[playerid] = 1;
                    sendTipMessageEx(playerid, COLOR_GREY, "B�dziesz si� teraz spawnowa� w Szkole Latania !");
                } else if(SchoolSpawn[playerid] == 1)
                {
                    SchoolSpawn[playerid] = 0;
                    sendTipMessageEx(playerid, COLOR_GREY, "B�dziesz si� teraz spawnowa� w Szkole Jazdy !");
                }
            } else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Nie posiadasz/wynajmujesz domu !");
                return 1;
            }
        }
    }
    return 1;
}
