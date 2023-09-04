//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ skille ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

#if DEBUG_MODE == 1
YCMD:skille(playerid, params[], help)
{
    PlayerInfo[playerid][pDetSkill] = 5000;
    PlayerInfo[playerid][pLawSkill] = 5000;
    PlayerInfo[playerid][pMechSkill] = 5000;
    PlayerInfo[playerid][pNewsSkill] = 5000;
    PlayerInfo[playerid][pJackSkill] = 5000;
    PlayerInfo[playerid][pDrugsSkill] = 5000;
    PlayerInfo[playerid][pSexSkill] = 5000;
    PlayerInfo[playerid][pBoxSkill] = 5000;
    PlayerInfo[playerid][pGunSkill] = 5000;
    PlayerInfo[playerid][pFishSkill] = 5000;
    PlayerInfo[playerid][pFishSkill] = 5000;
    PlayerInfo[playerid][pTruckSkill] = 5000;

    //PlayerInfo[playerid][pMats] = 50000;
    Item_Add("Materia³y", ITEM_OWNER_TYPE_PLAYER, PlayerInfo[playerid][pUID], ITEM_TYPE_MATS, 0, 0, true, playerid, 50000, ITEM_NOT_COUNT);

    sendTipMessage(playerid, "[Dosta³eœ skille 5 w ka¿dej dziedzinie i 50000 mats]");

    return 1;
}
#endif
