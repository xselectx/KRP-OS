//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 bagaznik                                                //
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


//-------<[ include ]>-------

//-------<[ initialize ]>-------

//-------<[ command ]>-------

YCMD:bagaznik(playerid, params[], help)
{
    if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT)
        return sendErrorMessage(playerid, "Musisz byæ pieszo.");
    new vehicleid = GetClosestCar(playerid);
    if(vehicleid == -1)
        return sendErrorMessage(playerid, "Nie znajdujesz siê przy ¿adnym pojeŸdzie!");
    if(!Car_IsValid(vehicleid) || !IsCarOwner(playerid, vehicleid) && strcmp(params, "przeszukaj", true))
        return sendErrorMessage(playerid, "Ten pojazd nie nale¿y do Ciebie.");
    if(!IsPlayerNearVehiclePart(playerid, vehicleid, VEH_PART_TRUNK, 1.0))
    {
        new Float:x, Float:y, Float:z;
        GetPosNearVehiclePart(vehicleid, VEH_PART_TRUNK, x, y, z);
        SetPlayerCheckpoint(playerid, x, y, z, 1.5);
        return sendErrorMessage(playerid, "Nie znajdujesz siê przy baga¿niku! (zosta³ on oznaczony na mapie)");
    }
    new vehicleUID = CarData[VehicleUID[vehicleid][vUID]][c_UID];
    if(vehicleUID == 0)
        return sendErrorMessage(playerid, "Ten pojazd nie istnieje.");
    if(isnull(params)) //show dialog
    {
        sendTipMessage(playerid, "U¿yj: /bagaznik [wyci¹gnij | schowaj | przeszukaj]");

        new string[1024], itemCount = 0;
        DynamicGui_Init(playerid);
        foreach(new i : Items)
        {
            if(Item[i][i_OwnerType] != ITEM_OWNER_TYPE_VEHICLE || Item[i][i_Owner] != vehicleUID) continue;
            if(itemCount > MAX_VEHICLE_ITEMS) break;
            format(string, sizeof(string), "%s\n%s (x%d)", string, Item[i][i_Name], Item[i][i_Quantity]);
            DynamicGui_AddRow(playerid, i);
            itemCount++;
        }
        if(itemCount < MAX_VEHICLE_ITEMS) {
            strcat(string, "\n»» Schowaj przedmiot");
            DynamicGui_AddRow(playerid, -1);
        }
        SetPVarInt(playerid, "bagaznik-id", vehicleid);
        ShowPlayerDialogEx(playerid, D_ITEM_VEHICLE_ITEMS, DIALOG_STYLE_LIST, MruTitle("Baga¿nik"), string, "Wyci¹gnij", "Zamknij");

        //Efekty wizualne
        SetTrunkState(playerid, vehicleid, 1);
        return 1;
    }
    
    //Wyci¹gnij, Schowaj, Przeszukaj
    if(!strcmp(params, "wyciagnij", true) || !strcmp(params, "wyci¹gnij", true))
    {
        new string[1024], itemCount = 0;
        DynamicGui_Init(playerid);
        foreach(new i : Items)
        {
            if(Item[i][i_OwnerType] != ITEM_OWNER_TYPE_VEHICLE || Item[i][i_Owner] != vehicleUID) continue;
            if(itemCount > MAX_VEHICLE_ITEMS) break;
            format(string, sizeof(string), "%s\n%s (x%d)", string, Item[i][i_Name], Item[i][i_Quantity]);
            DynamicGui_AddRow(playerid, i);
            itemCount++;
        }
        if(itemCount < 1)
            return sendErrorMessage(playerid, "W tym baga¿niku nie ma ¿adnych przedmiotów!");
        SetPVarInt(playerid, "bagaznik-id", vehicleid);
        ShowPlayerDialogEx(playerid, D_ITEM_VEHICLE_ITEMS, DIALOG_STYLE_LIST, MruTitle("Baga¿nik"), string, "Wyci¹gnij", "Zamknij");
        SetTrunkState(playerid, vehicleid, 1);
        return 1;
    }
    else if(!strcmp(params, "schowaj", true))
    {
        if(BagaznikCount(vehicleUID) >= MAX_VEHICLE_ITEMS)
            return sendErrorMessage(playerid, "W tym baga¿niku nie zmieœci siê wiêcej przedmiotów.");
        SetPVarInt(playerid, "bagaznik-id", vehicleid);
        new string[1024];
        DynamicGui_Init(playerid);
        foreach(new i : PlayerItems[playerid])
        {
            if(!Item[i][i_UID] || Item[i][i_Owner] != PlayerInfo[playerid][pUID]) continue;
            if(!CanGive(playerid, Item[i][i_ItemType], i)) continue;
            format(string, sizeof(string), "%s\n(%d) %s (x%d)", string, i, Item[i][i_Name], Item[i][i_Quantity]);
            DynamicGui_AddRow(playerid, i);
        }
        if(isnull(string))
            return sendTipMessage(playerid, "Nie posiadasz ¿adnych przedmiotów!");
        ShowPlayerDialogEx(playerid, D_TRUNK_ITEMS, DIALOG_STYLE_LIST, MruTitle("Schowaj przedmiot"), string, "Schowaj", "Zamknij");
        SetTrunkState(playerid, vehicleid, 1);
        return 1;
    }
    else if(!strcmp(params, "przeszukaj", true))
    {
        if(!IsAPolicja(playerid))
            return sendTipMessage(playerid, "Nie jesteœ na s³u¿bie grupy z takimi uprawnieniami!");
        new string[1024];
        foreach(new i : Items)
        {
            if(!Item[i][i_UID]) continue;
            if(Item[i][i_OwnerType] != ITEM_OWNER_TYPE_VEHICLE || Item[i][i_Owner] != vehicleUID) continue;

            format(string, sizeof(string), "%s\n(%d) %s", string, i, Item[i][i_Name]);
        }
        if(isnull(string))
            return sendErrorMessage(playerid, "W tym pojeŸdzie nie ma ¿adnych przedmiotów!");
        ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_LIST, MruTitle("Baga¿nik - Przedmioty"), string, "OK", #);
        RunCommand(playerid, "ja", "przeszukuje baga¿nik");
        return 1;
    }
    return 1;
}