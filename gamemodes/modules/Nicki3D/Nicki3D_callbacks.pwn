//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  Nicki3D                                                 //
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
// Autor: Dawidoskyy
// Data utworzenia: 27.11.2021
//Opis:
/*
	System Nicki3D
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

/*hook OnPlayerConnect(playerid)
{
    cNametag[playerid] = CreateDynamic3DTextLabel("Loading nametag...", 0xFFFFFFFF, 0.0, 0.0, 0.1, NT_DISTANCE, .attachedplayer = playerid, .testlos = 1);
    return 1;
}
hook OnPlayerDisconnect(playerid, reason) 
{ 
    if(IsValidDynamic3DTextLabel(cNametag[playerid])) 
              DestroyDynamic3DTextLabel(cNametag[playerid]); 
    return 1; 
}
forward UpdateNametag();
public UpdateNametag()
{
    foreach(new i : Player)
    {
        if(IsPlayerConnected(i))
        {
            new nametag[128], playername[MAX_PLAYER_NAME], Float:armour;
            GetPlayerArmour(i, armour);
            GetPlayerName(i, playername, sizeof(playername));
            if(armour > 1.0)
            {
                format(nametag, sizeof(nametag), "{%06x}%s {FFFFFF}(%i)\n{FFFFFF}%s\n{FF0000}%s", GetPlayerColor(i) >>> 8, playername, i, GetArmorDots(i), GetHealthDots(i));
            }
            else
            {
                format(nametag, sizeof(nametag), "{%06x}%s {FFFFFF}(%i)\n{FF0000}%s", GetPlayerColor(i) >>> 8, playername, i, GetHealthDots(i));
            }
            UpdateDynamic3DTextLabelText(cNametag[i], 0xFFFFFFFF, nametag);
        }
    }
}
*/
//end