//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 zmienwiek                                                 //
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
// Autor: Simeone
// Data utworzenia: 23.09.2019


//

//------------------<[ Implementacja: ]>-------------------
command_zmienwiek_Impl(playerid, giveplayerid, valueWiek)
{
    new string[128];
    if (PlayerInfo[playerid][pAdmin] >= 100 || IsAScripter(playerid))
    {
        if(giveplayerid != INVALID_PLAYER_ID)
        {
            PlayerInfo[giveplayerid][pAge] = valueWiek;
            Log(adminLog, WARNING, "Admin %s zmieni� wiek %s na %d", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), valueWiek);
            format(string, sizeof(string), "   Tw�j wiek zosta� zmieniony na %d lat przez %s", valueWiek, GetNickEx(playerid));
            SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "   Zmieni�e� wiek graczowi %s na %d lat.", GetNick(giveplayerid),valueWiek);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        } 
    } 
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end