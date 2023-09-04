//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  pizzaman                                                 //
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
// Autor: AnakinEU
// Data utworzenia: 01.11.2021
//Opis:
/*
	Szmugler
*/

//

//-----------------<[ Funkcje: ]>-------------------
public Czasokradania(playerid)
{
	
	TogglePlayerControllable(playerid, 1);
	ClearAnimations(playerid);
	if(IsPlayerInAnyVehicle(playerid)) 
	{
		OkradanieTira[playerid] = 0;
		return SendClientMessage(playerid, COLOR_BIALY, "[Szmugler] Zgubi³eœ paczkê poniewa¿ by³eœ w pojeŸdzie, spróbuj ponownie!");
	}
	Kradnie[playerid] = 1;
	ACSzmugler[playerid] = gettime() + 45;
	SendClientMessage(playerid, COLOR_BIALY, "Chris_Harris mówi: Pss, ziomek! Z zawartoœci¹ udaj siê do Las Colinas do opuszczonego domu, ziomek odkupi od ciebie wszystko.");
	return 1;
}

YCMD:sprzedajlombard(playerid, params[])
{
    new idZegarek = HasItemType(playerid, ITEM_TYPE_ZEGAREK);
    new idLancuszek = HasItemType(playerid, ITEM_TYPE_LANCUSZEK);
    new ilosc = strval(params);

    if (!IsPlayerInRangeOfPoint(playerid, 10, 204.41, -157.83, 1000.52))
    {
        SendClientMessage(playerid, COLOR_BIALY, "[Lombard] Nie jestes w miejscu, w ktorym mozna sprzedac rzeczy z lombardu.");
        return 1;
    }

    if (idZegarek == -1 && idLancuszek == -1)
    {
        SendClientMessage(playerid, COLOR_BIALY, "Nie masz zadnego zegarka ani lancuszka!");
        return 1;
    }

    if (ilosc <= 0)
    {
        return sendTipMessage(playerid, "U¿yj: /sprzedajlombard [iloœæ]");
    }

    if (idZegarek != -1 && Item[idZegarek][i_Quantity] >= ilosc)
    {
        SendClientMessage(playerid, COLOR_BIALY, "Troy_Henny mowi: No dobra, trzymaj tam jakies grosze za zegarek.");
        DajKase(playerid, 40 * ilosc);
        Item_Delete(idZegarek, true, ilosc);
        return 1;
    }
    
    if (idLancuszek != -1 && Item[idLancuszek][i_Quantity] >= ilosc)
    {
        SendClientMessage(playerid, COLOR_BIALY, "Troy_Henny mowi: No dobra, trzymaj tam jakies grosze za lancuszek.");
        DajKase(playerid, 60 * ilosc);
        Item_Delete(idLancuszek, true, ilosc);
        return 1;
    }

    SendClientMessage(playerid, COLOR_BIALY, "Nie masz wystarczajacej ilosci zegarkow ani lancuszkow!");
    return 1;
}

/*YCMD:wymienbron(playerid, params[])
{
    new idKAWALEKM4 = HasItemType(playerid, ITEM_TYPE_KAWALEKM4);
    new idKAWALEKAK = HasItemType(playerid, ITEM_TYPE_KAWALEKAK);

    if (!IsPlayerInRangeOfPoint(playerid, 3, 2485.19, -1769.87, 13.54))
    {
        SendClientMessage(playerid, COLOR_BIALY, "[BRON] Nie jestes w miejscu, w ktorym mozna wymieniac bronie.");
        return 1;
    }

    if (idKAWALEKM4 == -1 && idKAWALEKAK == -1)
    {
        SendClientMessage(playerid, COLOR_BIALY, "Nie masz ¿adnego kawa³ku broni!");
        return 1;
    }

    if (idKAWALEKM4 != -1 && Item[idKAWALEKM4][i_Quantity] >= 40)
    {
        SendClientMessage(playerid, COLOR_BIALY, "Hector_Moreno mowi: No dobra, trzymaj m4 za te kawa³ki.");
        SetWeaponValue(playerid, GetWeaponSlot(WEAPON_M4), WEAPON_M4, 100, 1);
        GivePlayerWeapon ( playerid, 31, 100 );
        Item_Delete(idKAWALEKM4, true, 40);
        return 1;
    }
    
    if (idKAWALEKAK != -1 && Item[idKAWALEKAK][i_Quantity] >= 30)
    {
        SendClientMessage(playerid, COLOR_BIALY, "Hector_Moreno mowi: No dobra, trzymaj ak47 za te kawa³ki.");
        SetWeaponValue(playerid, GetWeaponSlot(WEAPON_AK47), WEAPON_AK47, 100, 1);
        GivePlayerWeapon ( playerid, 30, 100 );
        Item_Delete(idKAWALEKAK, true, 30);
        return 1;
    }

    SendClientMessage(playerid, COLOR_BIALY, "Nie masz wystarczajacej ilosci kawa³ków broni!");
    return 1;
}
*/