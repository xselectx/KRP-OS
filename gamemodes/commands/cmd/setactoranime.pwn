//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ setactoranim ]---------------------------------------------//
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

YCMD:setactoranim(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pNewAP] != 5 && PlayerInfo[playerid][pAdmin] < 3000)
        {
            noAccessMessage(playerid); 
            return 1;
        }
        new aID;
        if(sscanf(params, "d", aID))
        {
            sendTipMessage(playerid, "/setactoranim [ID]"); 
            return 1;
        }
        SetPVarInt(playerid, "ActorIDChoice", aID); 
        ShowPlayerDialogEx(playerid, 1215, DIALOG_STYLE_LIST, "Kotnik Role Play", "Ramiona\nRapowanie\nOpiera sie o lade\nM�wi\nPojeb Dance\nDance 6\nNoga na noge\nPowitanie Nazisty\nWskazuje\nSikanie\nOpieraj - szlug\nPalenie\nClear Animation", "Okej", "Wyjdz"); 

    }
    return 1;
}
