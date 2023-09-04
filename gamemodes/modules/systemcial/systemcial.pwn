//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  systemcial                                              //
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
// Autor:
// Data utworzenia: 
//Opis:
/*
	
*/

//

//-----------------<[ Funkcje: ]>-------------------

stock sc_createCadaver(Float:x, Float:y, Float:z, vw, int, uid, name[] = "")
{
    new id = Iter_Free(I_Cadaver);
    if(id == -1)
        return 0;
    Cadaver[id][sc_id] = id;
    Cadaver[id][sc_pos][0] = x, Cadaver[id][sc_pos][1] = y, Cadaver[id][sc_pos][2] = z;
    Cadaver[id][sc_world][0] = vw, Cadaver[id][sc_world][1] = int;
    Cadaver[id][sc_playerUID] = uid;
    Iter_Add(I_Cadaver, id);

    //medyki info
    //new zone[MAX_ZONE_NAME];
    //GetPlayer2DZone()
    SendRadioMessage(FRAC_ERS, COLOR_LIGHTRED, sprintf("! W pobli¿u %s znaleziono cia³o. Wpisz komende /ciala aby udaæ siê w to miejsce !"), zone);
    return 1;
}

stock sc_removeCadaver(id)
{
    if(IsValidDynamic3DTextLabel(Cadaver[id][sc_text3d]))
        DestroyDynamic3DTextLabel(Cadaver[id][sc_text3d]);
    if(IsValidDynamicActor(Cadaver[id][sc_actorid]))
        DestroyDynamicActor(Cadaver[id][sc_actorid]);
    for(new i = 0; _Cadaver:i != _Cadaver; i++)
    {
        Cadaver[id][_Cadaver:i] = 0;
    }
    Iter_Remove(I_Cadaver, id);
    return 1;
}

//end