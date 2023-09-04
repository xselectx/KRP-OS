//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                stworzbiznes                                               //
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
// Data utworzenia: 20.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_stworzbiznes_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] == 5000)
    {
        if(GetPVarInt(playerid, "ActionCreateBiz") == 0)
        {
            sendTipMessage(playerid, "Rozpoczynam proces tworzenia biznesu!"); 
            ShowPlayerDialogEx(playerid, D_BIZ_WRITE, DIALOG_STYLE_INPUT, "Kotnik Role Play", "Wprowad� poni�ej kwot� za jak�\ngracz b�dzie m�g� naby� biznes", "Dalej", "Wyjd�"); 
        }
        else if(GetPVarInt(playerid, "ActionCreateBiz") == 1)
        {
            sendTipMessage(playerid, "Pomy�lnie zapisano pozycj� wej�cia!"); 
            sendTipMessage(playerid, "Wpisz ponownie /stworzbiznes aby zapisa� pozycje wyj�cia"); 
            sendTipMessageEx(playerid, COLOR_RED, "Ciekawostka: Nie rusz si�, a stworzysz akt w�asno�ci - bez wn�trza"); 
            sendTipMessageEx(playerid, COLOR_RED, "Ostrze�enia: System nie wykrywa VW i INT na wyj�ciu, tylko na wej�ciu!");
            new Float:p_X, Float:p_Y, Float:p_Z;  
            GetPlayerPos(playerid, p_X, p_Y, p_Z); 
            SetPVarFloat(playerid, "CreateBizOnX", p_X);
            SetPVarFloat(playerid, "CreateBizOnY", p_Y);
            SetPVarFloat(playerid, "CreateBizOnZ", p_Z);
            SetPVarInt(playerid, "ActionCreateBiz", 2);
            new pZone[MAX_ZONE_NAME];
            GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
            SetPVarString(playerid, "SetBizLocation", pZone); 
        }
        else if(GetPVarInt(playerid, "ActionCreateBiz") == 2)
        {
            new debugText[124]; 
            new Float:X, Float:Y, Float:Z; 
            new bizCost = GetPVarInt(playerid, "SetBizCost"); 
            new bizMoneyPD = GetPVarInt(playerid, "SetBizMoney"); 
            new bizName[64], bizLoc[64];
            GetPVarString(playerid, "SetBizName", bizName, sizeof(bizName));
            GetPVarString(playerid, "SetBizLocation", bizLoc, sizeof(bizLoc));  
            GetPlayerPos(playerid, X, Y, Z);  
            new nameOwn[MAX_PLAYER_NAME];
            format(nameOwn, sizeof(nameOwn), "Brak - na sprzeda�"); 
            if(IsPlayerInRangeOfPoint(playerid, 4.0, GetPVarFloat(playerid, "CreateBizOnX"), GetPVarFloat(playerid, "CreateBizOnY"), GetPVarFloat(playerid, "CreateBizOnZ")))
            {
                if(GetPlayerVirtualWorld(playerid) == 0)//Ustawianie tego samego - brak wej�cia 
                {
                    sendTipMessage(playerid, "Stworzy�e� biznes bez interioru!");
                    sendTipMessage(playerid, "Wpisz /bizinfo aby spojrze� na specyfikacj�"); 
                    new ID_BUSINESS = Create_BusinessMySQL(); //Tworzy kolumn� w bazie danych
                    if(ID_BUSINESS < 1) 
                        return sendErrorMessage(playerid, "B��d MySQL!");
                    Business[ID_BUSINESS][b_ID] = ID_BUSINESS;
                    mysql_real_escape_string(bizName, Business[ID_BUSINESS][b_Name]); 
                    Business[ID_BUSINESS][b_ownerUID] = 0; 
                    Business[ID_BUSINESS][b_enX] = GetPVarFloat(playerid, "CreateBizOnX");
                    Business[ID_BUSINESS][b_enY] = GetPVarFloat(playerid, "CreateBizOnY");
                    Business[ID_BUSINESS][b_enZ] = GetPVarFloat(playerid, "CreateBizOnZ"); 
                    Business[ID_BUSINESS][b_exX] = GetPVarFloat(playerid, "CreateBizOnX");
                    Business[ID_BUSINESS][b_exY] = GetPVarFloat(playerid, "CreateBizOnX");
                    Business[ID_BUSINESS][b_exZ] = GetPVarFloat(playerid, "CreateBizOnZ"); 
                    mysql_real_escape_string(nameOwn, Business[ID_BUSINESS][b_Name_Owner]); 
                    Business[ID_BUSINESS][b_int] = 0; 
                    Business[ID_BUSINESS][b_vw] = 0; 
                    Business[ID_BUSINESS][b_pLocal] = PLOCAL_DEFAULT; 
                    Business[ID_BUSINESS][b_maxMoney] = bizMoneyPD;
                    Business[ID_BUSINESS][b_cost] = bizCost;
                    mysql_real_escape_string(bizLoc, Business[ID_BUSINESS][b_Location]); 
                    CreateDynamic3DTextLabel(Business[ID_BUSINESS][b_Name], 0x008080FF, Business[ID_BUSINESS][b_enX], Business[ID_BUSINESS][b_enY], Business[ID_BUSINESS][b_enZ]+0.4, 10.0);
                    CreateDynamicPickup(1272, 1, Business[ID_BUSINESS][b_enX], Business[ID_BUSINESS][b_enY], Business[ID_BUSINESS][b_enZ], 0, 0, -1, STREAMER_PICKUP_SD); 
                    SaveBusiness(ID_BUSINESS); 
                    SetPVarInt(playerid, "ActionCreateBiz", 0);
                    SetPVarInt(playerid, "MustBe", 0); 
                    format(debugText, sizeof(debugText), "ID %d", ID_BUSINESS); 
                    sendTipMessage(playerid, debugText); 
                }
                else
                {
                    sendTipMessage(playerid, "Stworzy�e� biznes z interiorem!");
                    sendTipMessage(playerid, "Wpisz /bizinfo aby spojrze� na specyfikacj�");
                    new ID_BUSINESS = Create_BusinessMySQL(); //Tworzy kolumn� w bazie danych
                    if(ID_BUSINESS < 1) 
                        return sendErrorMessage(playerid, "B��d MySQL!");
                    Business[ID_BUSINESS][b_ID] = ID_BUSINESS;
                    mysql_real_escape_string(bizName, Business[ID_BUSINESS][b_Name]); 
                    Business[ID_BUSINESS][b_ownerUID] = 0; 
                    Business[ID_BUSINESS][b_enX] = GetPVarFloat(playerid, "CreateBizOnX");
                    Business[ID_BUSINESS][b_enY] = GetPVarFloat(playerid, "CreateBizOnY");
                    Business[ID_BUSINESS][b_enZ] = GetPVarFloat(playerid, "CreateBizOnZ"); 
                    Business[ID_BUSINESS][b_exX] = X;
                    Business[ID_BUSINESS][b_exY] = Y;
                    Business[ID_BUSINESS][b_exZ] = Z; 
                    mysql_real_escape_string(nameOwn, Business[ID_BUSINESS][b_Name_Owner]); 
                    Business[ID_BUSINESS][b_int] = GetPlayerInterior(playerid);   
                    Business[ID_BUSINESS][b_vw] = GetPlayerVirtualWorld(playerid); 
                    Business[ID_BUSINESS][b_pLocal] = GetPLocal(playerid); 
                    Business[ID_BUSINESS][b_maxMoney] = bizMoneyPD;
                    Business[ID_BUSINESS][b_cost] = bizCost;
                    mysql_real_escape_string(bizLoc, Business[ID_BUSINESS][b_Location]); 
                    CreateDynamic3DTextLabel(Business[ID_BUSINESS][b_Name], 0x008080FF, Business[ID_BUSINESS][b_enX], Business[ID_BUSINESS][b_enY], Business[ID_BUSINESS][b_enZ]+0.4, 10.0);
                    CreateDynamicPickup(1272, 1, Business[ID_BUSINESS][b_enX], Business[ID_BUSINESS][b_enY], Business[ID_BUSINESS][b_enZ], 0, 0, -1, STREAMER_PICKUP_SD); 
                    SaveBusiness(ID_BUSINESS); 
                    SetPVarInt(playerid, "ActionCreateBiz", 0);
                    SetPVarInt(playerid, "MustBe", 0); 
                }
            }
            else
            {
                if(GetPlayerVirtualWorld(playerid) == 0)
                {
                    sendErrorMessage(playerid, "VW nie mo�e by� r�wny 0"); 
                    sendErrorMessage(playerid, "Je�eli chcesz stworzy� wej�cie - zmie� VW. Je�eli nie chcesz interioru, wr�� do pozycji ze startu"); 
                    return 1;
                }
                sendTipMessage(playerid, "Stworzy�e� biznes z interiorem!");
                sendTipMessage(playerid, "Wpisz /bizinfo aby spojrze� na specyfikacj�"); 
                new ID_BUSINESS = Create_BusinessMySQL(); //Tworzy kolumn� w bazie danych
                if(ID_BUSINESS < 1) 
                    return sendErrorMessage(playerid, "B��d MySQL!");
                Business[ID_BUSINESS][b_ID] = ID_BUSINESS;
                mysql_real_escape_string(bizName, Business[ID_BUSINESS][b_Name]); 
                Business[ID_BUSINESS][b_ownerUID] = 0; 
                Business[ID_BUSINESS][b_enX] = GetPVarFloat(playerid, "CreateBizOnX");
                Business[ID_BUSINESS][b_enY] = GetPVarFloat(playerid, "CreateBizOnY");
                Business[ID_BUSINESS][b_enZ] = GetPVarFloat(playerid, "CreateBizOnZ"); 
                Business[ID_BUSINESS][b_exX] = X;
                Business[ID_BUSINESS][b_exY] = Y;
                Business[ID_BUSINESS][b_exZ] = Z; 
                mysql_real_escape_string(nameOwn, Business[ID_BUSINESS][b_Name_Owner]); 
                Business[ID_BUSINESS][b_int] = GetPlayerInterior(playerid);   
                Business[ID_BUSINESS][b_vw] = GetPlayerVirtualWorld(playerid); 
                Business[ID_BUSINESS][b_pLocal] = GetPLocal(playerid); 
                Business[ID_BUSINESS][b_maxMoney] = bizMoneyPD;
                Business[ID_BUSINESS][b_cost] = bizCost;
                mysql_real_escape_string(bizLoc, Business[ID_BUSINESS][b_Location]); 
                CreateDynamicPickup(1272, 1, Business[ID_BUSINESS][b_enX], Business[ID_BUSINESS][b_enY], Business[ID_BUSINESS][b_enZ], 0, 0, -1, STREAMER_PICKUP_SD); 
                CreateDynamic3DTextLabel(Business[ID_BUSINESS][b_Name], 0x008080FF, Business[ID_BUSINESS][b_enX], Business[ID_BUSINESS][b_enY], Business[ID_BUSINESS][b_enZ]+0.4, 10.0);
                SaveBusiness(ID_BUSINESS); 
                SetPVarInt(playerid, "ActionCreateBiz", 0); 
                SetPVarInt(playerid, "MustBe", 0); 
            }
        }
    }
    else 
    {
        return noAccessMessage(playerid); 
    }
    return 1;
}

//end