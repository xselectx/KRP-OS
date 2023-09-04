//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ addcar ]------------------------------------------------//
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
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:addcar(playerid, params[], help)
{
    if(!Uprawnienia(playerid, ACCESS_EDITCAR)) return 1;
    new model, color1, color2;
    if(sscanf(params, "ddd", model, color1, color2)) return sendTipMessage(playerid, "U�yj /addcar [Model] [Kolor] [Kolor]");
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x ,y ,z);
    GetPlayerFacingAngle(playerid, a);
    x+=floatsin(-a, degrees);
    y+=floatcos(-a, degrees);
    SetPlayerPos(playerid, x, y, z+0.5);
    new id = Car_Create(model, x,y,z,a, color1, color2);
    if(id == -1) return SendClientMessage(playerid, COLOR_GRAD2, "Brak wolnego miejsca?");
    new str[128];
    format(str, 128, "[CAR] Stworzono pojazd (UID: %d) model: %d przez %s", CarData[id][c_UID], model, GetNickEx(playerid));
	SendClientMessage(playerid, COLOR_GRAD2, str);
    Log(adminLog, WARNING, "Admin %s stworzy� Auto o UID %d model %d", GetPlayerLogName(playerid), CarData[id][c_UID], model);
    return 1;
}

