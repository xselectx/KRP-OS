//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ opis2 ]-------------------------------------------------//
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
// Data utworzenia: 2019-4-27

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/


YCMD:opis2(playerid, params[], help)
{
    //SendClientMessage(playerid, COLOR_RED, "Komenda wy��czona na czas naprawy. Przepraszamy za utrudnienia.");
    /*
    if(PlayerInfo[playerid][pConnectTime] < 4) return sendErrorMessage(playerid, "Opis dost�pny od 4 godzin online!");
    new var[8], id=-1;
    sscanf(params, "s[8]K<fix>(-1)", var, id);
    if(strlen(var) == 4 && (strcmp(var, "usu�", true) == 0 || strcmp(var, "usun", true) == 0))
    {
        if(id != -1 && PlayerInfo[playerid][pAdmin] >= 1)
        {
            if(!Opis_Usun(id)) return SendClientMessage(playerid, -1, "Opis: Gracz nie posiada opisu.");
            else
            {
                new str[64];
                format(str, 64, "(OPIS) - Administrator %s usun�� Tw�j opis.", GetNick(playerid, true));
                SendClientMessage(id, COLOR_PURPLE, str);
                format(str, 64, "(OPIS) - Usun��e� opis graczowi %s.", GetNick(id, true));
                SendClientMessage(playerid, COLOR_PURPLE, str);
                return 1;
            }
        }
        else if(!Opis_Usun(playerid, true)) return SendClientMessage(playerid, -1, "Opis: Nie posiadasz opisu.");
        return 1;
    }
    if(PlayerInfo[playerid][pBP] == 0)
    {
        new lStr[256];
        strunpack(lStr, PlayerDesc[playerid]);
        format(lStr, 256, "%s\n� Ustaw opis\n� Zmie� opis\n� {FF0000}Usu�", lStr);
        ShowPlayerDialogEx(playerid, D_OPIS, DIALOG_STYLE_LIST, "Opis postaci", lStr, "Wybierz", "Wyjd�");
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Posiadasz blokad� pisania na czatach globalnych, nie mo�esz utworzy� opisu.");
    }*/
    return 1;
} 
