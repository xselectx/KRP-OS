//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                reloaditems                                                //
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
// Data utworzenia: 21.06.2021


//

//------------------<[ Implementacja: ]>-------------------
command_reloaditems_Impl(playerid)
{
    if(!IsAKox(playerid))
        return noAccessMessage(playerid);
    SendClientMessage(playerid, -1, "rozpocz�to usuwanie i zapisywanie item�w");
    foreach(new i : Items)
    {
        SaveItem(i);
        Item_Delete(i, false, Item[i][i_Quantity], false);
        Iter_SafeRemove(Items, i, i);
    }
    SendClientMessage(playerid, -1, "usuni�to wszystkie itemy z pami�ci, wczytuje od nowa");
    LoadItems();
    SendClientMessage(playerid, -1, "wczytano itemy, przypisuje je dla gracza");
    foreach(new i : Player)
        LoadPlayerItems(i);
    SendClientMessage(playerid, -1, "wczytano itemy dla wszystkich graczy.");
    SendClientMessage(playerid, -1, "Reload wykonany!");
    return 1;
}

//end