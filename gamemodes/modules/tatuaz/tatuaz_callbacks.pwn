//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 tatuaz                                                //
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
// Data utworzenia: 24.06.2023
//Opis:
/*

*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-------------------

hook OnPlayerSpawn(playerid)
{
    for(new i = 0; i < MAX_PLAYER_TATTOO; i++)
    {
        if(!PlayerTattoo[playerid][i][t_UID]) continue;
        LoadTattooItem(playerid, i);
    }
    return 1;
}

hook OnPlayerDeath(playerid, killerid)
{
    for(new i = 0; i < MAX_PLAYER_TATTOO; i++)
    {
        if(!PlayerTattoo[playerid][i][t_UID]) continue;
        RemovePlayerAttachedObject(playerid, PlayerTattoo[playerid][i][t_index]);
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    SetPVarInt(playerid, "Tattoo-Offer", INVALID_PLAYER_ID);
    SetPVarInt(playerid, "Tattoo-Price", 0);
    for(new i = 0; i < MAX_PLAYER_TATTOO; i++)
    {
        new slot = i;
        if(!PlayerTattoo[playerid][slot][t_UID]) continue;
        RemovePlayerAttachedObject(playerid, PlayerTattoo[playerid][slot][t_index]);
        PlayerTattoo[playerid][slot][t_UID] = 0;
        PlayerTattoo[playerid][slot][t_ID] = 0;
        PlayerTattoo[playerid][slot][t_offsetX] = 0;
        PlayerTattoo[playerid][slot][t_offsetY] = 0;
        PlayerTattoo[playerid][slot][t_offsetZ] = 0;
        PlayerTattoo[playerid][slot][t_RX] = 0;
        PlayerTattoo[playerid][slot][t_RY] = 0;
        PlayerTattoo[playerid][slot][t_RZ] = 0;
        PlayerTattoo[playerid][slot][t_bone] = 0;
        PlayerTattoo[playerid][slot][t_index] = 0;
    }
    return 1;
}

hook OnPlayerEditAttachedObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    //X: -0.48, 0.16
    //Y: -0.16, 0.16
    //Z: 0.14, -0.14
    if(GetPVarInt(playerid, "Tattoo-EditingObj") == 1)
    {
        if(response)
        {
            new id = GetPVarInt(playerid, "Tattoo-ModelIndex");
            new Float:oldoffset[3], Float:oldRot[3], Float:oldScale[3];
            oldoffset[0] = Tattoo_Models[id][dOffsetX];
            oldoffset[1] = Tattoo_Models[id][dOffsetY];
            oldoffset[2] = Tattoo_Models[id][dOffsetZ];
            oldRot[0] = Tattoo_Models[id][dRX];
            oldRot[1] = Tattoo_Models[id][dRY];
            oldRot[2] = Tattoo_Models[id][dRZ];
            oldScale[0] = Tattoo_Models[id][dScaleX];
            oldScale[1] = Tattoo_Models[id][dScaleY];
            oldScale[2] = Tattoo_Models[id][dScaleZ];

            if(oldScale[0] != fScaleX || oldScale[1] != fScaleY || oldScale[2] != fScaleZ)
            {
                SetPlayerAttachedObject(playerid, index, modelid, boneid, oldoffset[0], oldoffset[1], oldoffset[2], oldRot[0], oldRot[1], oldRot[2], oldScale[0], oldScale[1], oldScale[2]);
                EditAttachedObject(playerid, index);
                sendErrorMessage(playerid, "Nie mo¿esz zmieniæ skali tatua¿u!");
                return -2;
            }
            if(fOffsetX > 0.20 || fOffsetX < -0.50)
            {
                SetPlayerAttachedObject(playerid, index, modelid, boneid, oldoffset[0], oldoffset[1], oldoffset[2], oldRot[0], oldRot[1], oldRot[2], oldScale[0], oldScale[1], oldScale[2]);
                EditAttachedObject(playerid, index);
                sendErrorMessage(playerid, "Wartoœæ X wykracza poza granicê obszaru!");
                return -2;
            }
            if(fOffsetY > 0.16 || fOffsetY < -0.16)
            {
                SetPlayerAttachedObject(playerid, index, modelid, boneid, oldoffset[0], oldoffset[1], oldoffset[2], oldRot[0], oldRot[1], oldRot[2], oldScale[0], oldScale[1], oldScale[2]);
                EditAttachedObject(playerid, index);
                sendErrorMessage(playerid, "Wartoœæ Y wykracza poza granicê obszaru!");
                return -2;
            }
            if(fOffsetZ > 0.14 || fOffsetZ < -0.14)
            {
                SetPlayerAttachedObject(playerid, index, modelid, boneid, oldoffset[0], oldoffset[1], oldoffset[2], oldRot[0], oldRot[1], oldRot[2], oldScale[0], oldScale[1], oldScale[2]);
                EditAttachedObject(playerid, index);
                sendErrorMessage(playerid, "Wartoœæ Z wykracza poza granicê obszaru!");
                return -2;
            }
            Tattoo_StartMaking(playerid, GetPVarInt(playerid, "Tattoo-Offer"), id, index, boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ);
            RemovePlayerAttachedObject(playerid, index);
        }
        else
        {
            RemovePlayerAttachedObject(playerid, index);
            sendTipMessage(playerid, "Przerwa³eœ tworzenie tatua¿u!");
            if(IsPlayerConnected(GetPVarInt(playerid, "Tattoo-Offer"))) sendErrorMessage(GetPVarInt(playerid, "Tattoo-Offer"), "Gracz, któremu robi³eœ tatua¿ anulowa³ ofertê.");
            Tattoo_Failure(playerid);
            return -2;
        }
    }
    return 1;
}

Tattoo_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused inputtext
    switch(dialogid)
    {
        case D_TATTOO:
        {
            new offer = GetPVarInt(playerid, "Tattoo-Offer"), price = GetPVarInt(playerid, "Tattoo-Price");
            if(!response)
            {
                Tattoo_Failure(playerid);
                if(IsPlayerConnected(offer))
                    sendErrorMessage(offer, "Gracz, któremu oferowa³eœ tatua¿ anulowa³ ofertê.");
                sendErrorMessage(playerid, "Anulowa³eœ ofertê tatua¿u.");
                return 1;
            }
            if(offer == INVALID_PLAYER_ID || !IsPlayerConnected(offer)) return sendErrorMessage(playerid, "Nie masz aktywnej oferty!");
            if(price < 50 || price > 400) return sendErrorMessage(playerid, "Cena jest nieprawid³owa!");
            if(kaska[playerid] < price) return sendErrorMessage(playerid, "Nie masz tylu pieniêdzy przy sobie!");
            if(!GroupPlayerDutyPerm(offer, PERM_TATTOO)) return sendErrorMessage(playerid, "Gracz sk³adaj¹cy ofertê zszed³ z duty!");
            if(!IsPlayerNear(playerid, offer)) return sendErrorMessage(playerid, "Nie znajdujesz siê w pobli¿u tego gracza!");

            SetPVarInt(playerid, "Tattoo-ModelIndex", listitem);
            ShowPlayerDialogEx(playerid, D_TATTOO_BONE, DIALOG_STYLE_LIST, "Tatua¿ - Czêœæ cia³a", "+ Lewa rêka\n+ Prawa rêka\n+ Lewa noga\n+ Prawa noga", "Dalej", "Zamknij");
            return 1;
        }
        case D_TATTOO_BONE:
        {
            new offer = GetPVarInt(playerid, "Tattoo-Offer"), price = GetPVarInt(playerid, "Tattoo-Price"), tattoo = GetPVarInt(playerid, "Tattoo-ModelIndex");
            if(!response)
            {
                new string[sizeof Tattoo_Models * 68];
                for(new i = 0; i < sizeof(Tattoo_Models); i++)
                {
                    format(string, sizeof(string), "%s\n%d\t%s", string, Tattoo_Models[i][dModel], Tattoo_Models[i][d_Name]);
                }
                ShowPlayerDialogEx(playerid, D_TATTOO, DIALOG_STYLE_PREVIEW_MODEL, "Lista tatuazy", string, "Wybierz", "Zamknij");
                return 1;
            }
            if(offer == INVALID_PLAYER_ID || !IsPlayerConnected(offer)) return sendErrorMessage(playerid, "Nie masz aktywnej oferty!");
            if(price < 50 || price > 400) return sendErrorMessage(playerid, "Cena jest nieprawid³owa!");
            if(kaska[playerid] < price) return sendErrorMessage(playerid, "Nie masz tylu pieniêdzy przy sobie!");
            if(!GroupPlayerDutyPerm(offer, PERM_TATTOO)) return sendErrorMessage(playerid, "Gracz sk³adaj¹cy ofertê zszed³ z duty!");
            if(!IsPlayerNear(playerid, offer)) return sendErrorMessage(playerid, "Nie znajdujesz siê w pobli¿u tego gracza!");

            new bone;
            if(listitem == 0) bone = BONE_LEFT_HAND;
            if(listitem == 1) bone = BONE_RIGHT_HAND;
            if(listitem == 2) bone = 12;
            if(listitem == 3) bone = 11;

            new index = Tattoo_FindFreeIndex(playerid);
            if(index == -1)
            {
                Tattoo_Failure(playerid);
                SendClientMessage(offer, COLOR_LIGHTBLUE, "* Gracz, któremu robi³eœ tatua¿ przekroczy³ limit obiektów przyczepialnych.");
                SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Przekroczy³eœ limit obiektów przyczepialnych, tatua¿ nie móg³ zostaæ wykonany!");
                return 1;
            }
            SetPVarInt(playerid, "Tattoo-ObjectIndex", index);
            SetPVarInt(playerid, "Tattoo-Bone", bone);
            SetPVarInt(playerid, "Tattoo-EditingObj", 1);
            SetPlayerAttachedObject(playerid, index, Tattoo_Models[tattoo][dModel], bone, Tattoo_Models[tattoo][dOffsetX], Tattoo_Models[tattoo][dOffsetY], Tattoo_Models[tattoo][dOffsetZ], Tattoo_Models[tattoo][dRX], Tattoo_Models[tattoo][dRY], Tattoo_Models[tattoo][dRZ], Tattoo_Models[tattoo][dScaleX], Tattoo_Models[tattoo][dScaleY], Tattoo_Models[tattoo][dScaleZ]);
            EditAttachedObject(playerid, index);
            return 1;
        }
    }
    return 0;
}