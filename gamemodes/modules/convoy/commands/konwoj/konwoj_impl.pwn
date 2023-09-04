//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   konwoj                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 20.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_konwoj_Impl(playerid)
{
    new hour, minute, second;
    gettime(hour, minute, second);

    if(!IsPlayerInSecuriCar(playerid))
    {
        sendErrorMessage(playerid, "Musisz by� w poje�dzie konwojowym (securicar) aby rozpocz�� konw�j.");
        return 1;
    }

    if(PlayerInfo[playerid][pAdmin] < 1) 
    {
        if(!IsAConvoyTeamLeader(playerid))
        {
            sendErrorMessage(playerid, "Nie masz wystarczaj�cych uprawnie� aby zorganizowa� konw�j.");
            return 1;
        }

        if(hour < 15 || hour > 22)
        {
            sendErrorMessage(playerid, "Konw�j mo�na wystartowa� tylko od godziny 15:00 do 23:00.");
            return 1;
        }

        if(convoyDelayed)
        {
            sendErrorMessage(playerid, "Nast�pny konw�j mo�na wystartowa� dopiero po 3 godzinach od uko�czenia ostatniego.");
            return 1;
        }

        if(kaska[playerid] < CONVOY_PRICE)
        {
            sendErrorMessage(playerid, "Zorganizowanie konwoju kosztuje "#CONVOY_PRICE"$ a Ty tyle nie masz.");
            return 1;
        }
    }

    if(ConvoyStarted)
    {
        SendClientMessage(playerid, COLOR_WHITE, "Konw�j stop");
        StopConvoy(CONVOY_STOP_ADMIN);
        return 1;
    }

    StartConvoy(playerid, GetPlayerVehicleID(playerid));
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Wystartowa�e� konw�j. Po dojechaniu do celu otrzymasz nagrod�.");
    ZabierzKaseDone(playerid, CONVOY_PRICE);

    Log(adminLog, WARNING, "Admin %s wystartowa� konw�j", 
        GetPlayerLogName(playerid)
    );
    return 1;
}

//end