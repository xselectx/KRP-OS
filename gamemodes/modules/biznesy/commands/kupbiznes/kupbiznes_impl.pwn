//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 kupbiznes                                                 //
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
command_kupbiznes_Impl(playerid)
{
    if(PlayerInfo[playerid][pLevel] < 2)
	{
		sendTipMessage(playerid, "Mo�esz zakupi� w�asny biznes dopiero od poziomu 2");
		return 1;
	}
	if(GetPlayerBusiness(playerid) != INVALID_BIZ_ID)
	{
		sendTipMessage(playerid, "Jeste� w�a�cicielem b�d� cz�onkiem biznesu! Nie mo�esz kupi� nast�pnego.");
		sendTipMessage(playerid, "Je�eli jeste� w�a�cicielem wpisz: /zlomujbiznes");
		sendTipMessage(playerid, "Je�eli jeste� cz�onkiem wpisz: /quitbiznes"); 
		return 1; 
	}
	new businessID = GetNearestBusiness(playerid); 
	if(businessID == INVALID_BIZ_ID)
	{
		sendErrorMessage(playerid, "Nie jeste� obok biznesu!");
		return 1;
	}
	if(businessID == -1)
	{
		sendErrorMessage(playerid, "B��dne ID biznesu"); 
		return 1;
	}
	if(Business[businessID][b_ownerUID] != 0)
	{
		sendErrorMessage(playerid, "Ten biznes nale�y ju� do kogo�!"); 
		return 1;
	}
	if(Business[businessID][b_cost] <= 0)
	{
		sendErrorMessage(playerid, "Ten biznes mo�na zakupi� tylko w trakcie licytacji."); 
		return 1;
	}
	if(kaska[playerid] < Business[businessID][b_cost])
	{
		sendErrorMessage(playerid, "Nie sta� Ci�!"); 
		return 1;
	}
	PlayerInfo[playerid][pBusinessOwner] = businessID; 
	Business[businessID][b_ownerUID] = PlayerInfo[playerid][pUID]; 
	Business[businessID][b_Name_Owner] = GetNick(playerid); 
	new string[124]; 
	sendTipMessageEx(playerid, COLOR_GREEN, "===[Zakupi�e� sw�j w�asny biznes]===");
	format(string, sizeof(string), "Nazwa biznesu: %s", Business[businessID][b_Name]);  
	sendTipMessage(playerid, string);

	Log(payLog, WARNING, "%s kupi� biznes %s za %d$",
		GetPlayerLogName(playerid),
		GetBusinessLogName(businessID),
		Business[businessID][b_cost]
	);
	ZabierzKaseDone(playerid, Business[businessID][b_cost]); 
	ResetBizOffer(playerid);
    return 1;
}

//end