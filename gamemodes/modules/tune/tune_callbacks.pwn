//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                   tuning                                                  //
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
// Autor: xSeLeCTx
// Data utworzenia: 10.07.2021
//Opis:
/*
	Nowy system tuningu, dzialajacy na zasadzie obiektow doczepialnych do pojazdu
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(GetPVarInt(playerid, "Tune_active") == 1)
    {
        switch (response)
        {
            case EDIT_RESPONSE_FINAL:
            {
                SetDynamicObjectPos(objectid, Float:x, Float:y, Float:z);
                SetDynamicObjectRot(objectid, Float:rx, Float:ry, Float:rz);
                new Float:vx, Float:vy, Float:vz, Float:vrx, Float:vry, Float:vrz;
                GetVehiclePos(GetPlayerVehicleID(GetPVarInt(playerid, "Tune_giveplayerid")), vx, vy, vz);
                GetVehicleRealRotation(GetPlayerVehicleID(GetPVarInt(playerid, "Tune_giveplayerid")), vrx, vry, vrz);

                new Float:offsetX = x-vx;
                new Float:offsetY = y-vy;
                new Float:offsetZ = z-vz;
                new Float:offsetRX = rx-vrx;
                new Float:offsetRY = ry-vry;
                new Float:offsetRZ = rz-vrz;
                
                ApplyInverseRotation(offsetX, offsetY, offsetZ, vrx, vry, vrz);
                AttachDynamicObjectToVehicle(objectid, GetPlayerVehicleID(GetPVarInt(playerid, "Tune_giveplayerid")), offsetX, offsetY, offsetZ, offsetRX, offsetRY, offsetRZ);

                new tuneid = GetTunePartFromModel(GetPVarInt(playerid, "Tune_modelid"));
                if(tuneid == -1) 
                {
                    DestroyDynamicObject(objectid);
                    return sendErrorMessage(playerid, "Wyst¹pi³ b³¹d. (Brak identyfikatora tuningu)");
                }
                AddTuneToRecipe(GetPVarInt(playerid, "Tune_giveplayerid"), TuneParts[tuneid][tune_Name], GetPVarInt(playerid, "Tune_type"), TuneParts[tuneid][tune_Cost], TuneParts[tuneid][tune_Model], 0, 1);
            }

            case EDIT_RESPONSE_CANCEL:
            {
                DestroyDynamicObject(objectid);
            }
        }
    }
    return 1;
}

Tune_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == D_TUNE_PANEL)
    {
        if(response)
        {   
            SetPVarInt(playerid, "Tune_type", listitem);
            switch(listitem)
            {
                case TUNE_TYPE_NITRO:
                {
                    ShowPlayerDialogEx(playerid, D_TUNE_PANEL_NITRO, DIALOG_STYLE_TABLIST_HEADERS, sprintf("{99e805}Panel Tuningu {ffffff}» %s", TuneTypeNames[listitem]), 
                    "Pojemnoœæ\tSkill\tCena\n\
                    » 2 u¿ycia\t1\t{33AA33}$1000\n\
                    » 5 u¿yæ\t2\t{33AA33}$2000\n\
                    » 10 u¿yæ\t3\t{33AA33}$3000\n\
                    » Dozowane\t4\t{33AA33}$10000",
                    "Zamontuj", "Anuluj");
                }
                case TUNE_TYPE_DELETE:
                {
                    ShowTunePanel(playerid);
                    return sendErrorMessage(playerid, "Wkrótce!");
                }
                case TUNE_TYPE_FINISH:
                {
                    if(GetPVarInt(playerid, "Tune_check")) return ShowTunePanel(playerid);
                    ShowPlayerDialogEx(playerid, D_TUNE_PANEL_FINISH_CONFIRM, DIALOG_STYLE_MSGBOX, "{99e805}Panel Tuningu {ffffff}» Zakoñcz", "Czy na pewno chcesz zakoñczyæ tuning?\nSpowoduje to wys³anie oferty graczowi, a Ty nie bêdziesz móg³ ju¿ nic zmieniæ.", "Tak", "Nie");
                }
                case TUNE_TYPE_BUMPER:
                {
                    ShowPlayerDialogEx(playerid, D_TUNE_PANEL_SELECT_BUMPER, DIALOG_STYLE_LIST, "{99e805}Panel Tuningu {ffffff}» Zderzaki", "» Przednie\n» Tylne", "Wybierz", "Anuluj");
                }
                case TUNE_TYPE_NEON:
                {
                    new giveplayerid = GetPVarInt(playerid, "Tune_giveplayerid");
                    if(IsPlayerPremiumOld(giveplayerid))
                        ShowPlayerDialogEx(playerid, D_TUNE_PANEL_SELECT_NEON, DIALOG_STYLE_LIST, "{99e805}Panel Tuningu {ffffff}» Neony", "»{FFFFFF} Bia³y\n»{FF0000} Czerwony\n»{0000FF} Niebieski\n»{9ACD32} Zielony\n»{DAA520} ¯ó³ty\n»{C2A2DA} Ró¿owy", "Wybierz", "Anuluj");
                    else
                        ShowPlayerDialogEx(playerid, D_TUNE_PANEL_SELECT_NEON, DIALOG_STYLE_LIST, "{99e805}Panel Tuningu {ffffff}» Neony", "»{FFFFFF} Bia³y", "Wybierz", "Anuluj");
                }
                case TUNE_TYPE_HYDRA:
                {
                    if(GetPVarInt(playerid, "Tune_check")) return ShowTunePanel(playerid);
                    AddTuneToRecipe(GetPVarInt(playerid, "Tune_giveplayerid"), "Hydraulika", GetPVarInt(playerid, "Tune_type"), 2000, 0, 1, 0);
                    AddVehicleComponent(GetPVarInt(playerid, "Tune_vehicleid"),1087);
                }
                case TUNE_TYPE_PAINTJOB:
                {
                    new vehicleid = GetPVarInt(playerid, "Tune_vehicleid");
                    if(GetPVarInt(playerid, "Tune_check")) vehicleid = GetPlayerVehicleID(playerid);
                    new modelid = GetVehicleModel(vehicleid);
                    new pjcount = VehicleSupportedPaintJobs(modelid);
                    if(pjcount > 0)
                    {
                        new string[128];
                        for(new i = 1; i<=pjcount; i++)
                            format(string, sizeof(string), "%s» Maluenk %d\n", string, i);
                        return ShowPlayerDialogEx(playerid, D_TUNE_PANEL_SELECT_PAINT, DIALOG_STYLE_LIST, "{99e805}Panel Tuningu {ffffff}» Malunki", string, "Wybierz", "Anuluj");
                    }
                    sendTipMessage(playerid, "Ten pojazd nie mo¿e zostaæ pomalowany.");
		            return ShowTunePanel(playerid);
                }
                default:
                {
                    if(PlayerInfo[playerid][pMechSkill] < 200 && !GetPVarInt(playerid, "Tune_check")) 
                    {
                        ShowTunePanel(playerid);
                        return sendErrorMessage(playerid, "Musisz mieæ 4 skill mechanika!");
                    }
                    return ShowTuneOptions(playerid);
                    //ShowPlayerDialogEx(playerid, D_TUNE_PANEL_SHOWCASE, DIALOG_STYLE_PREVMODEL, sprintf("Panel Tuningu -> %s", TuneTypeNames[listitem]), DialogListaTune(listitem), "Zamontuj", "Anuluj");
                }
            }
        }
        else
        {
            //return CancelTune(playerid);
        }
        return 1;
    }
    else if(dialogid == D_TUNE_PANEL_SELECT_NEON)
    {
        if(!response) return ShowTunePanel(playerid);
        if(GetPVarInt(playerid, "Tune_check")) return ShowTunePanel(playerid);
        new val = 18652;
        if(listitem != 0) val = listitem+18646;
        new neontext[32];
        format(neontext, sizeof(neontext), "%s", inputtext);
        strreplace(neontext, "» ", "", true, 0, -1, 32);
        AddTuneToRecipe(GetPVarInt(playerid, "Tune_giveplayerid"), sprintf("%s neon", neontext), GetPVarInt(playerid, "Tune_type"), 15000, 0, val, 0);
        
        new vehicleid = GetPVarInt(playerid, "Tune_vehicleid");
        if(VehicleUID[vehicleid][vNeon])
        {
            DestroyDynamicObject(VehicleUID[vehicleid][vNeonObject][0]);
            DestroyDynamicObject(VehicleUID[vehicleid][vNeonObject][1]);
        }

        VehicleUID[vehicleid][vNeonObject][0] = CreateDynamicObject(val, 0.0,0.0,0.0, 0, 0, 0);
        AttachDynamicObjectToVehicle(VehicleUID[vehicleid][vNeonObject][0], vehicleid, -0.8, 0.0, -0.5, 0.0, 0.0, 0.0);
        VehicleUID[vehicleid][vNeonObject][1] = CreateDynamicObject(val, 0.0,0.0,0.0, 0, 0, 0);
        AttachDynamicObjectToVehicle(VehicleUID[vehicleid][vNeonObject][1], vehicleid, 0.8, 0.0, -0.5, 0.0, 0.0, 0.0);

        VehicleUID[vehicleid][vNeon] = true;
    
    }
    else if(dialogid == D_TUNE_PANEL_SELECT_BUMPER)
    {
        if(!response) return ShowTunePanel(playerid);
        SetPVarInt(playerid, "Tune_type", TUNE_TYPE_BUMPER_FRONT+listitem);
        return ShowTuneOptions(playerid);
    }
    else if(dialogid == D_TUNE_PANEL_FINISH_CONFIRM)
    {
        if(response)
        {
            if(GetPVarInt(playerid, "Tune_check")) return ShowTunePanel(playerid);
            new string[256];
            new giveplayerid = GetPVarInt(playerid, "Tune_giveplayerid");
            SetPVarInt(giveplayerid, "Tune_PendingInvite", 2);
            format(string, sizeof(string),  "%s zakoñczy³ tuning. Wpisz {bfbfbf}/akceptuj tuning{BFC0C2} by zaakceptowaæ lub {bfbfbf}/anuluj tuning{BFC0C2} by anulowaæ.", GetNick(playerid));
            SendClientMessage(giveplayerid, COLOR_GRAD2, string);
            format(string, sizeof(string),  "Zakoñczy³eœ tuning i oferujesz %s jego akceptacjê. Poczekaj, a¿ zaakceptuje Twoj¹ ofertê!", GetNick(giveplayerid));
            SendClientMessage(playerid, COLOR_GRAD2, string);
        }
        else
            return ShowTunePanel(playerid);
    }
    else if(dialogid == D_TUNE_PANEL_SELECT)
    {
        if(!response) return ShowTunePanel(playerid);
        switch(listitem)
        {
            case 0: // STOCK
            {
                new type = GetPVarInt(playerid, "Tune_type");
                return ShowPlayerDialogEx(playerid, D_TUNE_PANEL_STOCK, DIALOG_STYLE_PREVMODEL, sprintf("Panel Tuningu -> %s (Fabryczne)", TuneTypeNames[type]), DialogListaTune(type, false, playerid), "Zamontuj", "Anuluj");
            }
            case 1: // CUSTOM
            {   
                sendErrorMessage(playerid, "Tymczasowo wy³¹czone!");
                return ShowTunePanel(playerid);
                new type = GetPVarInt(playerid, "Tune_type");
                return ShowPlayerDialogEx(playerid, D_TUNE_PANEL_SHOWCASE, DIALOG_STYLE_PREVMODEL, sprintf("Panel Tuningu -> %s (Niestandardowe)", TuneTypeNames[type]), DialogListaTune(type), "Zamontuj", "Anuluj");
            }
        }
    }
    else if(dialogid == D_TUNE_PANEL_SHOWCASE)
    {
        //ShowTunePanel(playerid);
        if(!response) return ShowTunePanel(playerid);
        if(GetPVarInt(playerid, "Tune_check")) return ShowTunePanel(playerid);
        SetPVarInt(playerid, "Tune_modelid", strval(inputtext));
        new Float:x, Float:y, Float:z;
		GetPlayerPos(GetPVarInt(playerid, "Tune_giveplayerid"), x, y, z);
		new obj = CreateDynamicObject(strval(inputtext), x, y, z+1, 0, 0, 0);
		EditDynamicObject(playerid, obj);
        return 1;
    }
    else if(dialogid == D_TUNE_PANEL_STOCK)
    {
        if(!response) return ShowTunePanel(playerid);
        if(GetPVarInt(playerid, "Tune_check")) return ShowTunePanel(playerid);
        new modelid =  strval(inputtext);
        SetPVarInt(playerid, "Tune_modelid", modelid);
        AddTuneToRecipe(GetPVarInt(playerid, "Tune_giveplayerid"), GetComponentName(modelid), GetPVarInt(playerid, "Tune_type"), 2000, modelid, 0, 0);
        AddVehicleComponent(GetPVarInt(playerid, "Tune_vehicleid"), modelid);
    }
    else if(dialogid == D_TUNE_PANEL_NITRO)
    {
        if(response)
        {
            if(GetPVarInt(playerid, "Tune_check")) return ShowTunePanel(playerid);
            switch(listitem)
            {
                case 3: // dozowane
                {
                    SendClientMessage(playerid, COLOR_GRAD2, "Brak towaru!");
                    Tune_OnDialogResponse(playerid, D_TUNE_PANEL, true, TUNE_TYPE_NITRO, " "); // Powrót do dialogu z nitro
                }
                default:
                {
                    if(PlayerInfo[playerid][pMechSkill] < (listitem*50))
                    {
                        sendErrorMessage(playerid, sprintf("Musisz mieæ %d skill mechanika!", listitem+1));
                        return Tune_OnDialogResponse(playerid, D_TUNE_PANEL, true, TUNE_TYPE_NITRO, " "); // Powrót do dialogu z nitro
                    }
                    new model = 0;
                    new cost = 0;
                    if(listitem == 0) 
                    {
                        model = 1009; // 2x
                        cost = 1000;
                    }
                    else if(listitem == 1) 
                    {
                        model = 1008; // 5x
                        cost = 2000;
                    }
                    else if(listitem == 2)
                    {
                        model = 1010; // 10x
                        cost = 3000;
                    }
                    AddVehicleComponent(GetPVarInt(playerid, "Tune_vehicleid"), model);
                    AddTuneToRecipe(GetPVarInt(playerid, "Tune_giveplayerid"), "Nitro", TUNE_TYPE_NITRO, cost, model, listitem, 0);

                }
            }
        } else return ShowTunePanel(playerid);
        return 1;
    }
    return 0;
}

hook OnPlayerLeaveDynArea(playerid, area)
{
    if(IsValidDynamicArea(area))
    {
        printf("AREA: %d", area);
        if(area == GetPVarInt(playerid, "Tune_area"))
        {
            CancelTune(GetPVarInt(playerid, "Tune_mechanik"));
        }
    }
}
//end