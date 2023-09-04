//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  gotobiz                                                  //
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
// Autor: Simeone
// Data utworzenia: 19.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_gotobiz_Impl(playerid, businessID)
{
    if(PlayerInfo[playerid][pAdmin] >= 5)
    {
        if(businessID >= MAX_BIZNES || businessID < 0)
        {
            sendErrorMessage(playerid, "Nie ma takiego biznesu!"); 
            return 1;
        }
        if(!Business[businessID][b_ID])
            return sendErrorMessage(playerid, "Nie ma takiego biznesu!");
        SetPlayerPos(playerid, Business[businessID][b_enX], Business[businessID][b_enY], Business[businessID][b_enZ]); 
        sendTipMessage(playerid, "Teleportowano Ci� do biznesu!"); 
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end