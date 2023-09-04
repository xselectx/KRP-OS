YCMD:stworzbrame(playerid, params[], help)
{
	if(PlayerInfo[playerid][pAdmin] < 5000)
		return noAccessMessage(playerid);
	new model, Float:speed, Float:range, perm_type, perm_id;
	if(sscanf(params, "dffdd", model, speed, range, perm_type, perm_id))
		return sendTipMessage(playerid, "U¿yj: /stworzbrame [model] [prêdkoœæ] [odleg³oœæ] [typ w³aœciciela (0 - wszyscy, 1 - grupa)] [id]");
	if(perm_type < 0 || perm_type > 2)
		return sendTipMessage(playerid, "U¿yj: /stworzbrame [model] [prêdkoœæ] [odleg³oœæ] [typ w³aœciciela (0 - wszyscy, 1 - grupa)] [id]");
	if(!IsValidGroup(perm_id) && perm_type == 1)
        return sendErrorMessage(playerid, "Grupa nie istnieje.");
    if(perm_type == 0) perm_type = BRAMA_UPR_TYPE_ALLPLAYERS;
	if(perm_id > 0 && perm_type == 0) perm_id = 0;
	if(range > 30.0)
		return sendTipMessage(playerid, "Za du¿a odleg³oœæ.");
	new Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	new gate = CreateDynamicObject(model, x, y, z-0.5, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	EditDynamicObject(playerid, gate);
	SetPVarInt(playerid, "gate-create", 1);

	SetPVarFloat(playerid, "gate-speed", speed);
	SetPVarFloat(playerid, "gate-range", range);
	SetPVarInt(playerid, "gate-permtype", perm_type);
	SetPVarInt(playerid, "gate-permid", perm_id);
	SetPVarInt(playerid, "gate-model", model);

	sendTipMessage(playerid, "Wybierz pozycje pocz¹tkow¹ bramy.");
	return 1;
}