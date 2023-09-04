//----------------------------------------------<< Source >>-------------------------------------------------//
//---------------------------------------[ Modu³: system-obiekty.pwn ]------------------------------------------//
//----------------------------------------[ Autor: renosk ]----------------------------------------//


new Iterator:DynamicObjects<max_objects>;

new forbidden[] ={955, 956, 1755, 1302, 1209, 1775, 1776, 1531, 1530, 1529, 1528, 1527, 1526, 1525, 1524, 1490, 11313, 18659, 18660, 18661, 18662, 18663, 18664, 18665, 18666, 18667};


UsunObiekt(objectid)
{
    new uid = ObjectInfo[objectid][o_UID], query[378];
    if(!uid) return 0;
    format(query, sizeof query, "SELECT `objectid` FROM `mru_mmat` WHERE `objectid` = '%d'", uid);
    mysql_query(query);
    mysql_store_result();
    if(mysql_num_rows()) {
        format(query, sizeof query, "DELETE FROM `mru_mmat` WHERE `objectid` = '%d'", uid);
        mysql_query(query);
    }
    mysql_free_result();
    format(query, sizeof query, "DELETE FROM `mru_obiekty` WHERE `UID` = '%d'", uid);
    if(mysql_query(query)) return 1;
    return 0;
}

StworzObiekt(objectid, sampid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, vw, int, owner_type, owner_id)
{
    new query[728], model = Streamer_GetIntData(STREAMER_TYPE_OBJECT, sampid, E_STREAMER_MODEL_ID);
    ObjectInfo[objectid][o_Object] = sampid;
    ObjectInfo[objectid][o_Model] = model;
    ObjectInfo[objectid][o_X] = x;
    ObjectInfo[objectid][o_Y] = y;
    ObjectInfo[objectid][o_Z] = z;
    ObjectInfo[objectid][o_RX] = rx;
    ObjectInfo[objectid][o_RY] = ry;
    ObjectInfo[objectid][o_RZ] = rz;
    ObjectInfo[objectid][o_VW] = vw;
    ObjectInfo[objectid][o_INT] = int;
    ObjectInfo[objectid][o_ownertype] = owner_type;
    ObjectInfo[objectid][o_owner] = owner_id;
    Streamer_SetIntData(STREAMER_TYPE_OBJECT, sampid, E_STREAMER_EXTRA_ID, objectid);
    Iter_Add(DynamicObjects, objectid);
    format(query, sizeof query, "INSERT INTO `mru_obiekty` (`model`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `vw`, `o_int`, `ownertype`, `owner`) VALUES ('%d', '%f', '%f', '%f', '%f','%f', '%f', '%d', '%d', '%d', '%d')",
        model,
        x,
        y,
        z,
        rx,
        ry,
        rz,
        vw,
        int,
        owner_type,
        owner_id);
    mysql_query(query);
    ObjectInfo[objectid][o_UID] = mysql_insert_id();
    return 1;
}

D_IsPlayerInHouse(playerid, admin = 1)
{
    if(PlayerInfo[playerid][pDom] <= 0 && GetPVarInt(playerid, "EditingHouse") == 0) return 0;
    new dom = PlayerInfo[playerid][pDom];
    new dom2 = GetPVarInt(playerid, "EditingHouse");
    if((PlayerInfo[playerid][pDomWKJ] == dom && Dom[dom][hVW] == GetPlayerVirtualWorld(playerid) && Dom[dom][hInterior] == GetPlayerInterior(playerid))
    || GetPVarInt(playerid, "EditingHouse") > 0 && PlayerInfo[playerid][pDomWKJ] == dom2 && Dom[dom2][hVW] == GetPlayerVirtualWorld(playerid) && Dom[dom2][hInterior] == GetPlayerInterior(playerid))
        return 1;
    if(PlayerInfo[playerid][pAdmin] >= 5000 && admin)
        return 1;
    return 0;
}


//-----------------<[ Komendy: ]>-------------------

YCMD:mmat(playerid, params[], help)
{
    new index, model, txdname[32], texturename[32], materialcolor, query[248];
    if(sscanf(params, "dds[32]s[32]d(0)", index, model, txdname, texturename, materialcolor))
        return sendTipMessage(playerid, "U¿yj: /mmat [index] [model] [txd name] [texture name] [material color = 0]");
    if(IsValidDynamicObject(GetPVarInt(playerid, "DynamicObjects-selected")))
    {
        new obj = GetPVarInt(playerid, "DynamicObjects-selected");
        new oid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID);
        if(!ObjectInfo[oid][o_UID]) return sendErrorMessage(playerid, "Coœ posz³o nie tak.");
        SetPVarInt(playerid, "DynamicObjects-selected", 0);
        CancelEdit(playerid);
        if(ObjectInfo[oid][o_ownertype] == 1 && !Uprawnienia(playerid, ACCESS_MAPPER))
            return noAccessMessage(playerid);
        else if(ObjectInfo[oid][o_ownertype] == 2 && !D_IsPlayerInHouse(playerid))
            return sendTipMessage(playerid, "Obiekt nie nale¿y do Ciebie.");
        SetDynamicObjectMaterial(obj, index, model, txdname, texturename, materialcolor);
        format(query, sizeof query, "SELECT `objectid` FROM `mru_mmat` WHERE `objectid` = '%d'", ObjectInfo[oid][o_UID]);
        mysql_query(query);
        mysql_store_result();
        if(mysql_num_rows())
        {
            format(query, sizeof query, "UPDATE `mru_mmat` SET `objectid` = '%d', `materialindex` = '%d', \
            `modelid` = '%d', \
            `txdname` = '%s', \
            `texturename` = '%s', \
            `materialcolor` = '%d' \
            WHERE `objectid` = '%d'", ObjectInfo[oid][o_UID], index, model, txdname, texturename, materialcolor, ObjectInfo[oid][o_UID]);
            mysql_query(query);
        }
        else
        {
            format(query, sizeof query, "INSERT INTO `mru_mmat` (objectid, materialindex, modelid, txdname, texturename, materialcolor) VALUES ('%d', '%d', '%d', '%s', '%s', '%d')", ObjectInfo[oid][o_UID], index, model, txdname, texturename, materialcolor);
            mysql_query(query);
        }
        mysql_free_result();
    }
    else sendTipMessage(playerid, "Nie zaznaczy³eœ obiektu.");
    return 1;
}

YCMD:pomocnik(playerid, params[], help)
{
    new giveplayerid;
    if(sscanf(params, "k<fix>", giveplayerid))
    {
        sendTipMessage(playerid, "U¿yj: /pomocnik [playerid/CzêœæNicku]");
        return sendTipMessage(playerid, "Pozwala innemu graczowi na edycjê obiektów w Twoim domu.");
    }
    if(giveplayerid == INVALID_PLAYER_ID) return sendTipMessage(playerid, "Ten gracz nie istnieje!");
    if(PlayerInfo[playerid][pDom] == 0) 
        return sendTipMessage(playerid, "Nie posiadasz w³asnego domu.");
    SetPVarInt(giveplayerid, "EditingHouse", PlayerInfo[playerid][pDom]);
    sendTipMessage(playerid, sprintf("Uprawni³eœ %s do edycji Twojego domu", GetNick(giveplayerid)));
    sendTipMessage(giveplayerid, sprintf("%s uprawni³ Ciê do edycji swojego domu", GetNick(playerid)));
    return 1;
}

YCMD:mc(playerid, params[], help)
{
    new model, ownertyp;
    new Float:Pos[3], obj;
    GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
    if(sscanf(params, "dd", model, ownertyp)) return sendTipMessage(playerid, "U¿yj: /mc [model] [w³aœciciel (1 - admin 2 - dom)]");
    if(model > 371 && model < 615)
        return sendTipMessage(playerid, "Nie mo¿esz utworzyæ obiektu o tym ID.");
    for(new i = 0; i < 26; i++)
		if(model == forbidden[i])
			return sendTipMessage(playerid, "Nie mo¿esz utworzyæ obiektu o tym ID.");
    if(ownertyp<1||ownertyp>2) return sendTipMessage(playerid, "Nieprawid³owy typ w³aœciciela.");
    if(ownertyp == 1 && !Uprawnienia(playerid, ACCESS_MAPPER)) return noAccessMessage(playerid);
    if(ownertyp==2 && !D_IsPlayerInHouse(playerid))
        return sendTipMessage(playerid, "Nie jesteœ w domu/dom nie nale¿y do Ciebie.");
    switch(ownertyp)
    {
        case 1:
        {
            obj = CreateDynamicObject(model, Pos[0], Pos[1], Pos[2]+0.3, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
            SetPVarInt(playerid, "creating-object", 1);
            SetPVarInt(playerid, "creating-object-ownertype", 1);
            SetPVarInt(playerid, "creating-object-owner", PlayerInfo[playerid][pUID]);
            SetPVarInt(playerid, "creating-object-id", obj);
            EditDynamicObject(playerid, obj);
        }
        case 2:
        {
            obj = CreateDynamicObject(model, Pos[0], Pos[1], Pos[2]+0.3, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
            SetPVarInt(playerid, "creating-object", 1);
            SetPVarInt(playerid, "creating-object-ownertype", 2);
            SetPVarInt(playerid, "creating-object-owner", PlayerInfo[playerid][pDomWKJ]);
            SetPVarInt(playerid, "creating-object-id", obj);
            EditDynamicObject(playerid, obj);
        }
    }
    return 1;
}

YCMD:rx(playerid, params[], help)
{
    new Float:rx;
    if(sscanf(params, "f", rx))
        return sendTipMessage(playerid, "U¿yj: /rx [pozycja rx]");
    if(IsValidDynamicObject(GetPVarInt(playerid, "DynamicObjects-selected")))
    {
        new obj = GetPVarInt(playerid, "DynamicObjects-selected");
        new oid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID);
        if(!ObjectInfo[oid][o_UID]) return sendErrorMessage(playerid, "Coœ posz³o nie tak.");
        if(ObjectInfo[oid][o_Model] != Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_MODEL_ID))
            return sendErrorMessage(playerid, "Ten obiekt nie istnieje w bazie danych!");
        if(ObjectInfo[oid][o_ownertype] == 1 && !Uprawnienia(playerid, ACCESS_MAPPER))
            return noAccessMessage(playerid);
        else if(ObjectInfo[oid][o_ownertype] == 2 && !D_IsPlayerInHouse(playerid))
            return sendTipMessage(playerid, "Obiekt nie nale¿y do Ciebie.");
        new Float:grx, Float:ry, Float:rz;
        GetDynamicObjectRot(obj, grx, ry, rz);
        SetDynamicObjectRot(obj, rx, ry, rz);
        ObjectInfo[oid][o_RX] = rx;
        CancelEdit(playerid);
        SetPVarInt(playerid, "DynamicObjects-selected", 0);
        new query[328];
        format(query, sizeof query, "UPDATE `mru_obiekty` SET `rx`='%f' WHERE `UID` = '%d'", rx, ObjectInfo[oid][o_UID]);
        mysql_query(query);
        sendTipMessage(playerid, "Pozycja zaaktualizowana.");
    }
    else sendTipMessage(playerid, "Nie zaznaczy³eœ obiektu.");
    return 1;
}

YCMD:ry(playerid, params[], help)
{
    new Float:ry;
    if(sscanf(params, "f", ry))
        return sendTipMessage(playerid, "U¿yj: /ry [pozycja ry]");
    if(IsValidDynamicObject(GetPVarInt(playerid, "DynamicObjects-selected")))
    {
        new obj = GetPVarInt(playerid, "DynamicObjects-selected");
        new oid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID);
        if(!ObjectInfo[oid][o_UID]) return sendErrorMessage(playerid, "Coœ posz³o nie tak.");
        if(ObjectInfo[oid][o_Model] != Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_MODEL_ID))
            return sendErrorMessage(playerid, "Ten obiekt nie istnieje w bazie danych!");
        if(ObjectInfo[oid][o_ownertype] == 1 && !Uprawnienia(playerid, ACCESS_MAPPER))
            return noAccessMessage(playerid);
        else if(ObjectInfo[oid][o_ownertype] == 2 && !D_IsPlayerInHouse(playerid))
            return sendTipMessage(playerid, "Obiekt nie nale¿y do Ciebie.");
        new Float:rx, Float:gry, Float:rz;
        GetDynamicObjectRot(obj, rx, gry, rz);
        SetDynamicObjectRot(obj, rx, ry, rz);
        ObjectInfo[oid][o_RY] = ry;
        CancelEdit(playerid);
        SetPVarInt(playerid, "DynamicObjects-selected", 0);
        new query[328];
        format(query, sizeof query, "UPDATE `mru_obiekty` SET `ry`='%f' WHERE `UID` = '%d'", ry, ObjectInfo[oid][o_UID]);
        mysql_query(query);
        sendTipMessage(playerid, "Pozycja zaaktualizowana.");
    }
    else sendTipMessage(playerid, "Nie zaznaczy³eœ obiektu.");
    return 1;
}

YCMD:rz(playerid, params[], help)
{
    new Float:rz;
    if(sscanf(params, "f", rz))
        return sendTipMessage(playerid, "U¿yj: /rz [pozycja rz]");
    if(IsValidDynamicObject(GetPVarInt(playerid, "DynamicObjects-selected")))
    {
        new obj = GetPVarInt(playerid, "DynamicObjects-selected");
        new oid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID);
        if(!ObjectInfo[oid][o_UID]) return sendErrorMessage(playerid, "Coœ posz³o nie tak.");
        if(ObjectInfo[oid][o_Model] != Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_MODEL_ID))
            return sendErrorMessage(playerid, "Ten obiekt nie istnieje w bazie danych!");
        if(ObjectInfo[oid][o_ownertype] == 1 && !Uprawnienia(playerid, ACCESS_MAPPER))
            return noAccessMessage(playerid);
        else if(ObjectInfo[oid][o_ownertype] == 2 && !D_IsPlayerInHouse(playerid))
            return sendTipMessage(playerid, "Obiekt nie nale¿y do Ciebie.");
        new Float:rx, Float:ry, Float:grz;
        GetDynamicObjectRot(obj, rx, ry, grz);
        SetDynamicObjectRot(obj, rx, ry, rz);
        ObjectInfo[oid][o_RZ] = rz;
        CancelEdit(playerid);
        SetPVarInt(playerid, "DynamicObjects-selected", 0);
        new query[328];
        format(query, sizeof query, "UPDATE `mru_obiekty` SET `rz`='%f' WHERE `UID` = '%d'", rz, ObjectInfo[oid][o_UID]);
        mysql_query(query);
        sendTipMessage(playerid, "Pozycja zaaktualizowana.");
    }
    else sendTipMessage(playerid, "Nie zaznaczy³eœ obiektu.");
    return 1;
}

YCMD:mcopy(playerid, params[], help)
{
    if(IsValidDynamicObject(GetPVarInt(playerid, "DynamicObjects-selected")))
    {
        new obj = GetPVarInt(playerid, "DynamicObjects-selected");
        new oid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID);
        new new_id = Iter_Free(DynamicObjects);
        if(new_id == -1)
            return sendErrorMessage(playerid, "Brak wolnego miejsca na obiekt!");
        if(!ObjectInfo[oid][o_UID]) return sendErrorMessage(playerid, "Coœ posz³o nie tak.");
        if(ObjectInfo[oid][o_Model] != Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_MODEL_ID))
            return sendErrorMessage(playerid, "Ten obiekt nie istnieje w bazie danych!");
        if(ObjectInfo[oid][o_ownertype] == 1 && !Uprawnienia(playerid, ACCESS_MAPPER))
            return noAccessMessage(playerid);
        else if(ObjectInfo[oid][o_ownertype] == 2 && !D_IsPlayerInHouse(playerid))
            return sendTipMessage(playerid, "Obiekt nie nale¿y do Ciebie.");
        new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz;
        GetDynamicObjectPos(obj, x, y, z);
        GetDynamicObjectRot(obj, rx, ry, rz);
        new new_obj = CreateDynamicObject(ObjectInfo[oid][o_Model], x, y, z, rx, ry, rz, ObjectInfo[oid][o_VW], ObjectInfo[oid][o_INT]);
        if(!StworzObiekt(new_id, new_obj, x, y, z, rx, ry, rz, ObjectInfo[oid][o_VW], ObjectInfo[oid][o_INT], ObjectInfo[oid][o_ownertype], ObjectInfo[oid][o_owner]))
            return sendTipMessage(playerid, "Nie stworzy³em obiektu! B³¹d! (max_objects)");
        EditDynamicObject(playerid, new_obj);
        SetPVarInt(playerid, "DynamicObjects-selected", new_obj);
        sendTipMessage(playerid, "Pomyœlnie skopiowano obiekt.");
    }
    else sendTipMessage(playerid, "Nie zaznaczy³eœ obiektu.");
    return 1;
}

YCMD:mdel(playerid, params[], help)
{
    if(IsValidDynamicObject(GetPVarInt(playerid, "DynamicObjects-selected")))
    {
        new obj = GetPVarInt(playerid, "DynamicObjects-selected");
        new oid = Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_EXTRA_ID);
        if(!ObjectInfo[oid][o_UID]) return sendErrorMessage(playerid, "Coœ posz³o nie tak.");
        if(ObjectInfo[oid][o_Model] != Streamer_GetIntData(STREAMER_TYPE_OBJECT, obj, E_STREAMER_MODEL_ID))
            return sendErrorMessage(playerid, "Ten obiekt nie istnieje w bazie danych!");
        if(ObjectInfo[oid][o_ownertype] == 1 && !Uprawnienia(playerid, ACCESS_MAPPER))
            return noAccessMessage(playerid);
        else if(ObjectInfo[oid][o_ownertype] == 2 && !D_IsPlayerInHouse(playerid))
            return sendTipMessage(playerid, "Obiekt nie nale¿y do Ciebie.");
        SetPVarInt(playerid, "DynamicObjects-selected", 0);
        CancelEdit(playerid);
        if(!UsunObiekt(oid))
            return sendTipMessage(playerid, "Nie mo¿na by³o znaleŸæ UID obiektu");
        if(ObjectInfo[oid][o_ownertype]==1)
            SendCommandLogMessage(sprintf("CMD_Info: /mdel u¿yte przez %s [%d]", GetNick(playerid), playerid));
        DestroyDynamicObject(obj);
        ObjectInfo[oid][o_UID] = -1;
        ObjectInfo[oid][o_Model] = 0;
        Iter_Remove(DynamicObjects, oid);
    }
    else sendTipMessage(playerid, "Nie zaznaczy³eœ obiektu.");
    return 1;
}

YCMD:msel(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_MAPPER) && !D_IsPlayerInHouse(playerid))
        return sendTipMessage(playerid, "Nie mo¿esz u¿yæ tej komendy w tym miejscu.");
    SelectObject(playerid);
    SetPVarInt(playerid, "DynamicObjects-select", 1);
    return 1;
}

//-----------------<[ MySQL: ]>-------------------

LoadMMat()
{
    new ilosctekstur, objectid, index, model, txdname[32], texturename[32], materialcolor, query[728]; 
    mysql_query("SELECT * FROM `mru_mmat`");
    mysql_store_result();

    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>ddds[32]s[32]d", objectid,
        index,
        model,
        txdname,
        texturename,
        materialcolor);

        foreach(new i : DynamicObjects)
        {
            if(ObjectInfo[i][o_UID] == objectid) {
                SetDynamicObjectMaterial(ObjectInfo[i][o_Object], index, model, txdname, texturename, materialcolor);
                break;
            }
        }
        ilosctekstur++;
    }
    printf("[LOAD] Za³adowano tekstur: %d", ilosctekstur);
    return 1;
}

LoadObjects()
{
    new iloscobiektow, query[728], model, Float:Pos[6], int, vw, otype, oowner, object, uid1;
    mysql_query("SELECT * FROM `mru_obiekty`");
    mysql_store_result();

    while(mysql_fetch_row_format(query, "|"))
    {
        object = Iter_Free(DynamicObjects);
        if(object == -1) return 0;
        sscanf(query, "p<|>ddffffffdddd", uid1,
        model,
        Pos[0],
        Pos[1],
        Pos[2],
        Pos[3],
        Pos[4],
        Pos[5],
        vw,
        int,
        otype,
        oowner);
        new lol = CreateDynamicObject(model, Pos[0],Pos[1],Pos[2],Pos[3],Pos[4],Pos[5],vw,int);
        ObjectInfo[object][o_Object] = lol;
        ObjectInfo[object][o_UID] = uid1;
        ObjectInfo[object][o_Model] = model;
        ObjectInfo[object][o_X] = Pos[0];
        ObjectInfo[object][o_Y] = Pos[1];
        ObjectInfo[object][o_Z] = Pos[2];
        ObjectInfo[object][o_RX] = Pos[3];
        ObjectInfo[object][o_RY] = Pos[4];
        ObjectInfo[object][o_RZ] = Pos[5];
        ObjectInfo[object][o_VW] = vw;
        ObjectInfo[object][o_INT] = int;
        ObjectInfo[object][o_ownertype] = otype;
        ObjectInfo[object][o_owner] = oowner;
        Streamer_SetIntData(STREAMER_TYPE_OBJECT, lol, E_STREAMER_EXTRA_ID, object);
        Iter_Add(DynamicObjects, object);
        iloscobiektow++;
    }
    printf("[LOAD] Za³adowano obiektów: %d", iloscobiektow);
    return 1;
}
