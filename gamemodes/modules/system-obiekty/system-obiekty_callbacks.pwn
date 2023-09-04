//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                 system-obiekty                                                 //
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
// Data utworzenia: 02.04.2021
//Opis:
/*
	System obiekty
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnPlayerSelectDynObj(playerid, objectid, modelid, Float:x, Float:y, Float:z)
{
    if(GetPVarInt(playerid, "DynamicObjects-select"))
    {
        new oid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID);
        if(!ObjectInfo[oid][o_UID]) {
            SetPVarInt(playerid, "DynamicObjects-select", 0);
            return 0;
        }
        if(ObjectInfo[oid][o_ownertype]==1 && !Uprawnienia(playerid, ACCESS_MAPPER))
            return noAccessMessage(playerid);
        else if(ObjectInfo[oid][o_ownertype] == 2 && !D_IsPlayerInHouse(playerid))
            return noAccessMessage(playerid);
        SetPVarInt(playerid, "DynamicObjects-selected", objectid);
        _MruGracz(playerid, sprintf("OBJ-ID: %d", ObjectInfo[oid][o_UID]));
        EditDynamicObject(playerid, objectid);
    }
    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
    if(IsValidDynamicObject(GetPVarInt(playerid, "creating-object-id")) && GetPVarInt(playerid, "creating-object-id") > 0)
        DestroyDynamicObject(GetPVarInt(playerid, "creating-object-id"));
    return 1;
}

hook OnPlayerEditDynamicObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(GetPVarInt(playerid, "creating-object"))
    {
        switch(response)
        {
            case EDIT_RESPONSE_UPDATE:
            {
                if(GetPVarInt(playerid, "creating-object-ownertype"))
                {
                    new dom = GetPVarInt(playerid, "creating-object-owner");
                    if(Dom[dom][hDomNr] == -1)
                    {
                        if(GetDistanceBetweenPoints(x, y, z, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z]) >= 60)
                        {
                            new Float:X, Float:Y, Float:Z, Float:rox, Float:roy, Float:roz;
                            GetDynamicObjectRot(objectid, rox, roy, roz);
                            GetDynamicObjectPos(objectid, X, Y, Z);
                            SendClientMessage(playerid, -1, "Obiekt jest za daleko od wejœcia!");
                            SetDynamicObjectPos(objectid, X, Y, Z);
                            SetDynamicObjectRot(objectid, rox, roy, roz);
                        }
                    }
                }
            }
            case EDIT_RESPONSE_CANCEL:
            {
                sendTipMessage(playerid, "Przerwa³eœ tworzenie obiektu.");
                SetPVarInt(playerid, "creating-object", 0);
                SetPVarInt(playerid, "creating-object-ownertype", 0);
                SetPVarInt(playerid, "creating-object-owner", 0);
                SetPVarInt(playerid, "creating-object-id", 0);
                DestroyDynamicObject(objectid);
            }
            case EDIT_RESPONSE_FINAL:
            {
                if(GetPVarInt(playerid, "creating-object-ownertype"))
                {
                    new dom = GetPVarInt(playerid, "creating-object-owner");
                    if(Dom[dom][hDomNr] == -1)
                    {
                        if(GetDistanceBetweenPoints(x, y, z, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z]) >= 60)
                        {
                            SetPVarInt(playerid, "creating-object", 0);
                            SetPVarInt(playerid, "creating-object-ownertype", 0);
                            SetPVarInt(playerid, "creating-object-owner", 0);
                            SetPVarInt(playerid, "creating-object-id", 0);
                            DestroyDynamicObject(objectid);
                            return sendErrorMessage(playerid, "By³eœ za daleko od wejœcia!");
                        }
                    }
                }
                new oid = Iter_Free(DynamicObjects), otype = GetPVarInt(playerid, "creating-object-ownertype"), owner = GetPVarInt(playerid, "creating-object-owner");
                if(oid == -1) return sendErrorMessage(playerid, "Brak wolnego miejsca na obiekt!");
                if(StworzObiekt(oid, objectid, x, y, z, rx, ry, rz, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), otype, owner))
                {
                    sendTipMessage(playerid, "Obiekt stworzony pomyœlnie.");
                    if(otype == 1) SendCommandLogMessage(sprintf("CMD_Info: /mc u¿yte przez %s [%d]", GetNick(playerid), playerid));
                    SetPVarInt(playerid, "creating-object", 0);
                    SetPVarInt(playerid, "creating-object-ownertype", 0);
                    SetPVarInt(playerid, "creating-object-owner", 0);
                    SetPVarInt(playerid, "creating-object-id", 0);
                    SetDynamicObjectPos(objectid, x, y, z);
                    SetDynamicObjectRot(objectid, rx, ry, rz);
                } else {
					sendTipMessage(playerid, "Nie stworzy³em obiektu! B³¹d! (max_objects)");
				}
            }
        }
    }
    else if(GetPVarInt(playerid, "DynamicObjects-select"))
    {
        switch(response)
        {
            case EDIT_RESPONSE_CANCEL:
            {
                SetPVarInt(playerid, "DynamicObjects-selected", 0);
                SetPVarInt(playerid, "DynamicObjects-select", 0);
            }
            case EDIT_RESPONSE_FINAL:
            {
                new oid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, objectid, E_STREAMER_EXTRA_ID);
                if(!ObjectInfo[oid][o_UID]) return sendErrorMessage(playerid, "Coœ posz³o nie tak.");
                if(ObjectInfo[oid][o_ownertype]==1 && !Uprawnienia(playerid, ACCESS_MAPPER))
                    return noAccessMessage(playerid);
                else if(ObjectInfo[oid][o_ownertype] == 2 && !D_IsPlayerInHouse(playerid))
                    return noAccessMessage(playerid);
                SetDynamicObjectPos(objectid, x, y, z);
                SetDynamicObjectRot(objectid, rx, ry, rz);
                ObjectInfo[oid][o_X] = x;
                ObjectInfo[oid][o_Y] = y;
                ObjectInfo[oid][o_Z] = z;
                ObjectInfo[oid][o_RX] = rx;
                ObjectInfo[oid][o_RY] = ry;
                ObjectInfo[oid][o_RZ] = rz;
                new query[328];
                format(query, sizeof query, "UPDATE `mru_obiekty` SET `x`='%f', `y`='%f', `z`='%f', `rx`='%f', `ry`='%f', `rz`='%f' WHERE `UID` = '%d'", x, y, z, rx, ry, rz, ObjectInfo[oid][o_UID]);
                mysql_query(query);
                SetPVarInt(playerid, "DynamicObjects-selected", 0);
                SetPVarInt(playerid, "DynamicObjects-select", 0);
                sendTipMessage(playerid, "Pozycja zaaktualizowana.");
            }
        }
    }
    return 1;
}
//end