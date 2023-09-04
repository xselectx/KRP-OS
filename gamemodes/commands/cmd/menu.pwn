//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ menu ]------------------------------------------------//
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
	Komenda /menu dla restauracji
*/


// Notatki skryptera:
/*
	
*/

YCMD:menu(playerid, params[], help)
{
    if(!IsARestauracja(playerid)) return noAccessMessage(playerid);
    if(!OnDuty[playerid]) return sendTipMessage(playerid, "Nie jesteœ na s³u¿bie!");

    new string[428], giveplayerid;
    if(sscanf(params, "r", giveplayerid))
        return sendTipMessage(playerid, "U¿yj: /menu [ID/nick gracza]");
    if(!IsPlayerConnected(giveplayerid))
        return sendErrorMessage(playerid, "Gracz o podanym ID nie istnieje.");
    string = "Nazwa\tCena\tNajedzenie";
    foreach(new i : Products)
    {
        if(Product[i][p_OrgID] != GetPlayerGroupUID(playerid, OnDuty[playerid]-1)) continue;
        strcat(string, sprintf("\n%s\t{00FF00}${FFFFFF}%d\t%d%%", Product[i][p_ProductName], Product[i][p_Price], Product[i][p_Value2]));
    }
    if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 30)
        return sendErrorMessage(playerid, "Ten gracz nie jest przy Tobie!");
    if(strlen(string) < 30)
        return sendErrorMessage(playerid, "Twoja grupa nie posiada ¿adnych produktów!");
    if(giveplayerid != playerid)
        ProxDetector(10.0, playerid, sprintf("* %s pokazuje menu %s", GetNick(playerid), GetNick(giveplayerid)),COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
    ShowPlayerDialogEx(giveplayerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Menu", string, "OK", #);
    return 1;
}