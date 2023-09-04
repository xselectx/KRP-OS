//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  pizzaboy                                                 //
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
// Data utworzenia: 09.05.2021


//

//------------------<[ Implementacja: ]>-------------------
command_pizzaboy_Impl(playerid)
{
    if(PlayerInfo[playerid][pJob] == 11)
    {
        if(!Pizzaboy_Active[playerid])
        {
            if(Pizzaboy_State[playerid] == 0)
            {
                if(IsPlayerInRangeOfPoint(playerid, 5, Pizzaboy_Main_Locations[0][0], Pizzaboy_Main_Locations[0][1], Pizzaboy_Main_Locations[0][2]))
                {
                    if(GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
                    {
                        Pizzaboy_State[playerid] = 1;
                        Pizzaboy_Time[playerid] = 120;
                        Pizzaboy_Active[playerid] = true;
                        Pizzaboy_Start(playerid);
                        return 1;
                    }
                } else return sendErrorMessage(playerid, "Jesteœ za daleko!");
            } else return sendErrorMessage(playerid, "Wykonujesz ju¿ swoje zadanie!");
        } else {
            GameTextForPlayer(playerid, "Zakonczono prace!", 2500, 4);
            Pizzaboy_End(playerid);
        }
    } else return sendTipMessage(playerid, "Musisz najpierw siê zatrudniæ w tej pracy! Dolacz do tej pracy w urzêdzie pracy");
    
    return 1;
}

//end