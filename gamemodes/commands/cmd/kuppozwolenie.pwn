//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ kuppozwolenie ]---------------------------------------------//
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
// Autor: Sandal
// Data utworzenia: 24.01.2020

// Opis:
/*
    Kupno licencji prawniczej u NPC
*/


// Notatki skryptera:
/*
	
*/
YCMD:kuppozwolenie(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pJob] == 2 || CheckPlayerPerm(playerid, PERM_LAWYER))
        {
            if(IsPlayerInRangeOfPoint(playerid, 3.0, 1582.2563,-1677.6565,62.2363) && (GetPlayerVirtualWorld(playerid)==25)) 
            {
                if(ApprovedLawyer[playerid] == 0)
                {
                    if(PozwolenieBot == 0)
                    {
                        sendTipMessage(playerid, "Wy��czono mo�liwo�� automatycznego kupna pozwole�.");
                        return 1;
                    }
                    if(kaska[playerid] >= CENA_POZWOLENIE)
                    {
                        ZabierzKaseDone(playerid, CENA_POZWOLENIE);
                        Sejf_Add(FRAC_LSPD, CENA_POZWOLENIE);
                        ApprovedLawyer[playerid] = 1;
                        Log(payLog, WARNING, "%s zakupi� pozwolenie od aktora za "#CENA_POZWOLENIE"$", GetPlayerLogName(playerid));
                        sendTipMessage(playerid, "Zakupi�e� pozwolenie za "#CENA_POZWOLENIE"$");
                        return 1; 
                    }
                    else
                    {
                        sendTipMessage(playerid, "Nie sta� cie!");
                        return 1;
                    }
                }
                else
                {
                    sendTipMessage(playerid, "Posiadasz ju� pozwolenie.");
                    return 1;
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jeste� przy osobie wydaj�cej pozwolenia!");
                return 1; 
            }
        }
        else
        {
            sendTipMessage(playerid, "Komenda dost�pna tylko dla prawnik�w.");
            return 1;
        }
    }
    return 1;
}
