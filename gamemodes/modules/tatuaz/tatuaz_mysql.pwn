//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   tatuaz                                                  //
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
// Data utworzenia: 23.06.2023
//Opis:
/*
	
*/

//

//-----------------<[ MySQL: ]>-------------------

stock LoadPlayerTattoo(playerid)
{   
    new query[248];
    query = "`UID`, `ID`, `offsetX`, `offsetY`, `offsetZ`, `rX`, `rY`, `rZ`, `bone`";
    format(query, sizeof(query), "SELECT %s FROM `mru_tattoo` WHERE `owner` = '%d'", query, PlayerInfo[playerid][pUID]);
    mysql_query(query);
    mysql_store_result();
    while(mysql_fetch_row_format(query, "|"))
    {
        new slot = GetFreeSlotTattoo(playerid);
        if(slot == -1) break;
        sscanf(query, "p<|>ddffffffd", PlayerTattoo[playerid][slot][t_UID], PlayerTattoo[playerid][slot][t_ID], PlayerTattoo[playerid][slot][t_offsetX], PlayerTattoo[playerid][slot][t_offsetY], PlayerTattoo[playerid][slot][t_offsetZ],
        PlayerTattoo[playerid][slot][t_RX], PlayerTattoo[playerid][slot][t_RY], PlayerTattoo[playerid][slot][t_RZ], PlayerTattoo[playerid][slot][t_bone]);
    }
    mysql_free_result();
    return 1;
}