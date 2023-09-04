//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   amotel                                                  //
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
// Data utworzenia: 21.05.2021


//

//------------------<[ Implementacja: ]>-------------------
command_amotel_Impl(playerid, action[64], value[256])
{
    if(PlayerInfo[playerid][pAdmin] < 1000 && !IsAScripter(playerid)) return noAccessMessage(playerid);
    new motelID = Motel_GetCurrent(playerid, true, true, true);
    //if(strfind(action, "checkrent", true) != -1)
    //{
    //    Motel_GetAllRent();
    //    return 1;
    //}
    if(motelID != -1)
    {
        new string[128], string2[256];
        format(string, sizeof(string), "{e8c205}%s [UID: %d] {FFFFFF}» Edycja", Motels[motelID][motName], Motels[motelID][motUID]);
        format(string2, sizeof(string2), "» Nazwa (%s)\n» Cena ({11d625}$%d)\n» Iloœæ pokoi (%d/%d)\n» Zmieñ interior\n» Usuñ", Motels[motelID][motName], Motels[motelID][motPrice], Motels[motelID][motOccupied], Motels[motelID][motRooms]);
        ShowPlayerDialogEx(playerid, DIALOG_AMOTEL_EDIT, DIALOG_STYLE_LIST, string, string2, "Wybierz", "Anuluj");
    } else {
        if(strfind(action, "crea", true) != -1 || strfind(action, "stw", true) != -1) {
            new Float:InX, Float:InY, Float:InZ, InVW, InInterior, Price, Rooms, MotelName[64];
            if(sscanf(value, "fffdddds[64]", InX, InY, InZ, InVW, InInterior, Price, Rooms, MotelName))
            {
                sendTipMessage(playerid, "U¿yj /amotel stworz [InX] [InY] [InZ] [InVW] [InInterior] [Cena] [Pokoje] [Nazwa]");
                sendTipMessage(playerid, "Motel zostanie stworzony w miejscu w którym stoisz.");
                return 1;
            }
            Motel_Create(playerid, InX, InY, InZ, InVW, InInterior, Price, Rooms, MotelName);
            
            return 1;
        }
        ShowPlayerDialogEx(playerid, DIALOG_AMOTEL, DIALOG_STYLE_LIST, "{e8c205}Kreator moteli", "» Stwórz\n» Teleport", "Wybierz", "Anuluj");
    }
    return 1;
}

//end