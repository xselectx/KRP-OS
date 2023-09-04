//EXTERNAL
//GET
forward MRP_GetPlayerMoney(playerid);
forward MRP_GetPlayerMC(playerid);
forward MRP_GetPlayerCarSlots(playerid);
forward MRP_GetPlayerPhone(playerid);
forward MRP_GetPlayerNickChanges(playerid);
forward MRP_GetPlayerAge(playerid);
forward MRP_GetPlayerUID(playerid);
forward MRP_IsInPolice(playerid);

//SET
forward MRP_SetPlayerMoney(playerid, val);
forward MRP_SetPlayerCarSlots(playerid, val);
forward MRP_SetPlayerPhone(playerid, val);
forward MRP_SetPlayerNickChanges(playerid, val);
forward MRP_SetPlayerAge(playerid, val);
forward MRP_ShopPurchaseCar(playerid, model, cena);
forward MRP_ForceDialog(playerid, dialogid);
forward MRP_SetPlayerKluczykiDoAuta(playerid, val);

//CALLBACKS
//GET
public MRP_GetPlayerMoney(playerid) return kaska[playerid];
public MRP_GetPlayerMC(playerid) return PlayerMC[playerid];
public MRP_GetPlayerCarSlots(playerid) return PlayerInfo[playerid][pCarSlots];
public MRP_GetPlayerPhone(playerid) return GetPhoneNumber(playerid);
public MRP_GetPlayerNickChanges(playerid) return PlayerInfo[playerid][pZmienilNick];
public MRP_GetPlayerAge(playerid) return PlayerInfo[playerid][pAge];
public MRP_GetPlayerUID(playerid) return PlayerInfo[playerid][pUID];
public MRP_IsInPolice(playerid)
{
    if(CheckPlayerPerm(playerid, PERM_POLICE)) return 1;
    return 0;
}

//SET
public MRP_SetPlayerMoney(playerid, val)  kaska[playerid] = val;
public MRP_SetPlayerCarSlots(playerid, val)  PlayerInfo[playerid][pCarSlots] = val;
public MRP_SetPlayerPhone(playerid, val)  {
	if(GetPhoneNumber(playerid) == 0) {
		Item_Add("Telefon", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_PHONE, val, 0, true, playerid);
	} else {
		Item_EditValues(HasItemType(playerid, ITEM_TYPE_PHONE), val, 0);
	}
}
public MRP_SetPlayerNickChanges(playerid, val)  PlayerInfo[playerid][pZmienilNick] = val;
public MRP_SetPlayerAge(playerid, val)  PlayerInfo[playerid][pAge] = val;
public MRP_SetPlayerKluczykiDoAuta(playerid, val)  {
    PlayerInfo[playerid][pKluczeAuta] = val;
    MruMySQL_SetAccInt("KluczykiDoAuta", GetNickEx(playerid), val);
}

forward MRPWeryfikacja(index, response_code, data[]);
public MRPWeryfikacja(index, response_code, data[])
{
    print("Kubi aka Smigol: Moj skarb!! Nie oddam mojego skarbu!");
	return 1;
}



//END
