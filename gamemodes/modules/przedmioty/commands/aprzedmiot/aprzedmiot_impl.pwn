//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 aprzedmiot                                                //
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
// Data utworzenia: 12.06.2021


//

//------------------<[ Implementacja: ]>-------------------
command_aprzedmiot_Impl(playerid, opt1[64], opt2[64])
{
    switch(YHash(opt1))
    {
        case _H<stworz>:
        {
            if(PlayerInfo[playerid][pAdmin] < 4000 && !IsAScripter(playerid) && !Uprawnienia(playerid, ACCESS_EDITCAR))
                return noAccessMessage(playerid);
            new name[32], type, value1, value2, owner, quant, secretValue;
            if(sscanf(opt2, "s[32]dddddd", name, type, value1, value2, owner, quant, secretValue)) {
                SendClientMessage(playerid, COLOR_GRAD4, "�� U�yj: /aprzedmiot stworz [nazwa (do 32 znak�w)] [typ przedmiotu (/ap typy)] [value1] [value2] [UID gracza] [ilo��] [secretValue]");
                SendClientMessage(playerid, COLOR_GRAD4, "�� UID gracza mo�esz pobra� poprzez komend� /check [id] (je�eli jest online)");
                return 1;
            }
            strreplace(name, "_", " ");
            new giveplayerid = GetPlayerIDFromUID(owner); //pobierz ID gracza je�eli jest online
            if(!MruMySQL_DoesAccountExistByUID(owner)) //sprawdza czy gracz o podanym UID istnieje
                return sendErrorMessage(playerid, "U�ytkownik o podanym UID nie istnieje!");
            if(type < 0 || type > sizeof(ItemTypes)-1) //sprawdza czy dany typ przedmiotu jest prawid�owy
                return sendErrorMessage(playerid, "Z�y typ przedmiotu! (/ap typy)");
            if(quant > 100 && type != ITEM_TYPE_MATS) //je�eli ilo�� przekracza 100
                return sendErrorMessage(playerid, "Za du�a ilo��! (max: 100, gracz i tak wi�cej nie uniesie)");
            if(type == ITEM_TYPE_MATS) 
                secretValue = ITEM_NOT_COUNT;
            if(giveplayerid != INVALID_PLAYER_ID && IsPlayerConnected(giveplayerid) && secretValue != ITEM_NOT_COUNT) //je�eli gracz nie pomie�ci tylu przedmiot�w (tylko w przypadku gdy jest online)
            {
                if(Item_Count(giveplayerid)+quant > GetPlayerItemLimit(playerid))
                    return sendErrorMessage(playerid, sprintf("Ten gracz nie pomie�ci tylu przedmiot�w! (%d/%d)", Item_Count(giveplayerid), GetPlayerItemLimit(giveplayerid)));
            }
            if(type == ITEM_TYPE_PHONE || type == ITEM_TYPE_MATS) //sprawdza czy dany gracz posiada ju� telefon lub matsy
            {
                mysql_query_format("SELECT `UID` FROM `mru_items` WHERE `owner_type` = '%d' AND `owner` = '%d' AND `item_type` = '%d'", ITEM_OWNER_TYPE_PLAYER, owner, type);
                mysql_store_result();
                new result = mysql_num_rows();
                mysql_free_result();
                if(result > 0)
                    return sendErrorMessage(playerid, "Ten gracz posiada ju� telefon lub matsy!");
            }
            new id = Item_Add(name, ITEM_OWNER_TYPE_PLAYER, owner, type, value1, value2, true, giveplayerid, quant, secretValue);
            if(id == -1 || Item[id][i_UID] < 1) //je�eli przedmiot nie m�g� zosta� stworzony z powodu b��du MySQL lub przekroczenia limitu przedmiot�w (nigdy nie powinno si� wydarzy�)
                return sendErrorMessage(playerid, "Przedmiot nie m�g� zosta� stworzony z powodu b��du MySQL lub braku wolnego slotu (t� okoliczno�� zg�o� do xSeLeCTx lub spr�buj ponownie)");
            va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Stworzy�e� przedmiot o ID: %d [UID: %d]", id, Item[id][i_UID]);
            if(IsPlayerConnected(giveplayerid) && giveplayerid != INVALID_PLAYER_ID)
                va_SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* Administrator %s da� Ci przedmiot %s x%d", GetNickEx(playerid), name, quant);
            Log(itemLog, WARNING, "%s tworzy nowy przedmiot %s dla gracza o UID %d", GetPlayerLogName(playerid), GetItemLogName(id), owner);
            ABroadCast(COLOR_LIGHTRED, sprintf("AdmCMD: %s stworzy� nowy przedmiot o nazwie %s dla gracza o UID %d", GetNickEx(playerid), name, owner), 4000);
            
        }
        case _H<usun>:
        {
            if(!IsAHeadAdmin(playerid)) return noAccessMessage(playerid);
            new itemid, quant;
            if(sscanf(opt2, "dd", itemid, quant))
                return sendTipMessage(playerid, "U�yj: /aprzedmiot usun [id] [ilo�� (0 = wszystko)]");
            if(!Iter_Contains(Items, itemid) || Item[itemid][i_UID] < 1)
                return sendErrorMessage(playerid, "Przedmiot o podanym ID nie istnieje!");
            if(Item[itemid][i_Quantity] < quant || quant <= 0)
                quant = Item[itemid][i_Quantity];
            Log(itemLog, WARNING, "%s usun�� przedmiot %s x%d", GetPlayerLogName(playerid), GetItemLogName(itemid), quant);
            va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Usun��e� przedmiot o ID: %d x%d", itemid, quant);
            Item_Delete(itemid, true, quant);
        }
        case _H<usun_uid>:
        {
            if(!IsAKox(playerid)) return noAccessMessage(playerid);
            sendTipMessage(playerid, "UWAGA! Ta komenda mo�e spowodowa� chwilowego laga.");
            new uid, quant;
            if(sscanf(opt2, "dd", uid, quant))
                return sendTipMessage(playerid, "U�yj: /aprzedmiot usun_uid [uid] [ilo�� (0 = wszystko)]");
            new itemid = FindItemByUID(uid);
            if(itemid == -1)
                return sendErrorMessage(playerid, "Przedmiot o podanym UID nie istnieje!");
            if(Item[itemid][i_Quantity] < quant || quant <= 0)
                quant = Item[itemid][i_Quantity];
            Log(itemLog, WARNING, "%s usun�� przedmiot %s x%d (przez uid)", GetPlayerLogName(playerid), GetItemLogName(itemid), quant);
            va_SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Usun��e� przedmiot o ID: %d x%d", itemid, quant);
            Item_Delete(itemid, true, quant);
        }
        case _H<typy>:
        {
            new string[1024];
            string = "Typ\tNazwa";
            for(new i = 0; i < sizeof(ItemTypes); i++)
                strcat(string, sprintf("\n%d\t%s", i, ItemTypes[i]));
            ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Zarz�dzanie przedmiotami �� Typy", string, "OK", #);
        }
        case _H<clear3dtext>:
        {
            if(!PlayerInfo[playerid][pAdmin]) return noAccessMessage(playerid);
            foreach(new i : Items) //TODO: zmodyfikowac to po lekkiej optymalizacji skryptu
            {
                if(Item[i][i_OwnerType] == ITEM_OWNER_TYPE_DROPPED && Item[i][i_Dropped] && IsValidDynamic3DTextLabel(Item[i][i_3DText]))
                    DestroyDynamic3DTextLabel(Item[i][i_3DText]);
            }
            SendClientMessage(playerid, COLOR_PANICRED, "Wyczy�ci�e� wszystkie 3D texty od�o�onych przedmiot�w.");
            SendCommandLogMessage(sprintf("Admin %s wyczy�ci� 3D Texty od�o�onych przedmiot�w!", GetNickEx(playerid)));
        }
        default:
            sendTipMessage(playerid, "Nieprawid�owa opcja.");
    }
    return 1;
}

//end