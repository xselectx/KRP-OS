//----------------------------------------------<< Callbacks >>----------------------------------------------//
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
	Praca dorywcza Magazynier
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    if(InfoSkate[playerid][sActive] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT){
        static bool:act;
        SetPlayerArmedWeapon(playerid,0);
        if(newkeys & KEY_HANDBRAKE){
            #if MODE_SKATE == 0
            // medium speed
            ApplyAnimation(playerid, "SKATE","skate_run",4.1,1,1,1,1,1,1);
            #else
            // fast speed
            ApplyAnimation(playerid, "SKATE","skate_sprint",4.1,1,1,1,1,1,1);
            #endif
            if(!act){
                act = true;
                RemovePlayerAttachedObject(playerid,INDEX_SKATE);
                DestroyObject(InfoSkate[playerid][sSkate]);
                InfoSkate[playerid][sSkate] = CreateObject(19878,0,0,0,0,0,0);
                AttachObjectToPlayer(InfoSkate[playerid][sSkate],playerid, -0.2,0,-0.9,0,0,90);
            }
        }
        if(oldkeys & KEY_HANDBRAKE){
            ApplyAnimation(playerid, "CARRY","crry_prtial",4.0,0,0,0,0,0);
            if(act){
                act = false;
                DestroyObject(InfoSkate[playerid][sSkate]);
                RemovePlayerAttachedObject(playerid,INDEX_SKATE);
                #if TYPE_SKATE == 0
                // the skate is placed on the right arm
                SetPlayerAttachedObject(playerid,INDEX_SKATE,19878,6,-0.055999,0.013000,0.000000,-84.099983,0.000000,-106.099998,1.000000,1.000000,1.000000);
                #else
                // the skate is placed in the back
                SetPlayerAttachedObject(playerid,INDEX_SKATE,19878,1,0.055999,-0.173999,-0.007000,-95.999893,-1.600010,24.099992,1.000000,1.000000,1.000000);
                #endif
            }
        }
    }
    return true;
}
 
hook OnGamemodeInit(){
    AddPlayerClass(23,1916.1304,-1367.8215,13.6492,99.3507,0,0,0,0,0,0); //
    return true;
}

hook OnPlayerDisconnect(playerid, reason)
{
	InfoSkate[playerid][sActive] = false;
    BlockDeska[playerid] = false;
	return 1;
}
//end