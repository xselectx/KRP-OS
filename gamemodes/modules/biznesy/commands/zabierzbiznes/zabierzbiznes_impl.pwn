//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               zabierzbiznes                                               //
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
command_zabierzbiznes_Impl(playerid)
{
    new businessID = GetNearestBusiness(playerid); 
	if(businessID == INVALID_BIZ_ID)
	{
		sendErrorMessage(playerid, "Nie jesteœ obok biznesu!");
		return 1;
	}
    if(PlayerInfo[playerid][pAdmin] < 1000 && !IsAScripter(playerid))
    {
        noAccessMessage(playerid); 
        return 1;   
    }
    Log(adminLog, WARNING, "%s zabral biznes %s graczowi {Player: %s[%d]}",
        GetPlayerLogName(playerid), 
        GetBusinessLogName(businessID),
        Business[businessID][b_Name_Owner],
        Business[businessID][b_ownerUID]
    );
    Business[businessID][b_ownerUID] = 0;
    format(Business[businessID][b_Name_Owner], MAX_PLAYER_NAME, "Brak");
    sendTipMessageEx(playerid, COLOR_RED, "Zabra³eœ biznes z r¹k gracza"); 
    ClearBusinessOwner(Business[businessID][b_ID]); 
    return 1;
}

//end