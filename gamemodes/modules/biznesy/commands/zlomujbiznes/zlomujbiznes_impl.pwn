//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                zlomujbiznes                                               //
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
command_zlomujbiznes_Impl(playerid)
{
    if(GetPlayerBusiness(playerid) == INVALID_BIZ_ID)
    {
        sendTipMessage(playerid, "Nie posiadasz w�asnego biznesu!");
        return 1; 
    }
    new businessID = GetNearestBusiness(playerid); 
    if(businessID == INVALID_BIZ_ID)
    {
        sendErrorMessage(playerid, "Nie jeste� obok biznesu!");
        return 1;
    }
    new valueMoneyB = (Business[businessID][b_cost]/2); 
    if(businessID != PlayerInfo[playerid][pBusinessOwner])
    {
        sendErrorMessage(playerid, "Nie jeste� w�a�cicielem tego biznesu"); 
        return 1;
    }
    if(GetPVarInt(playerid, "Wpisal_zlomujbiznes") == 0)
    {
        sendTipMessage(playerid, "Uwaga! Stracisz sw�j biznes, dostaniesz po�ow� jego ceny jako zwrot!"); 
        sendTipMessage(playerid, "Je�eli akceptujesz powy�sze warunki wpisz ponownie /zlomujbiznes"); 
        SetPVarInt(playerid, "Wpisal_zlomujbiznes", 1);
        return 1;
    }
    else if(GetPVarInt(playerid, "Wpisal_zlomujbiznes") == 1)
    {
        new stringName[MAX_PLAYER_NAME]; 
        new string[128]; 
        Business[businessID][b_ownerUID] = 0;  
        format(stringName, sizeof(stringName), "Brak - na sprzeda�");
        Business[businessID][b_Name_Owner] = stringName; 
        PlayerInfo[playerid][pBusinessOwner] = INVALID_BIZ_ID; 
        format(string, sizeof(string), "%s zez�omowa� biznes %d za $%d", GetNick(playerid), businessID, valueMoneyB); 
        SendMessageToAdmin(string, COLOR_RED); 

        Log(payLog, WARNING, "%s zez�omowa� biznes %s za $%d",
            GetPlayerLogName(playerid),
            GetBusinessLogName(businessID),
            valueMoneyB
        );
        DajKaseDone(playerid, valueMoneyB); 
        SetPVarInt(playerid, "Wpisal_zlomujbiznes", 0);
        sendTipMessage(playerid, "Pomy�lnie zez�omowa�e� sw�j biznes!"); 
    }
    return 1;
}

//end