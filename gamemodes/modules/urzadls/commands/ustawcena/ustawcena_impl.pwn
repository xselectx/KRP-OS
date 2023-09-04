//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 ustawcena                                                 //
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
// Data utworzenia: 20.09.2019


//

//------------------<[ Implementacja: ]>-------------------
command_ustawcena_Impl(playerid, valueChoice, valueCost)
{
    new string[124];
    if(valueChoice > 7 || valueChoice < 0)
    {   
        sendErrorMessage(playerid, "Nieprawid�owe u�ycie komendy!");
        sendTipMessage(playerid, "0 - dow�d || 1 - karta w�dkarska || 2 - pozwolenie na bro�"); 
        sendTipMessage(playerid, "3 - patent �eglarski || 4 - Prawko - teoria || 5 - Prawko - praktyka || 6 - Prawko - odbi�r");
        sendTipMessage(playerid, "7 - licencja pilota"); 
        return 1;
    }
    if(valueCost < 0)
    {
        sendErrorMessage(playerid, "Nie mo�esz wprowadza� minusowych kwot!"); 
        return 1;
    }
    if(valueCost > 7_500_000)
    {
        sendTipMessage(playerid, "Kwota nie mo�e przekroczy� 7.5kk");
        return 1;
    }
    if(PlayerInfo[playerid][pLider] != FRAC_GOV)
    {
        sendErrorMessage(playerid, "Nie jeste� liderem organizacji!"); 
        return 1;
    }
    DmvLicenseCost[valueChoice] = valueCost; 
    format(string, sizeof(string), "%s zmieni� cen� licencji numer %d na %d", GetNick(playerid), valueChoice, valueCost);
    SendLeaderRadioMessage(FRAC_GOV, COLOR_LIGHTGREEN, string); 
    sendTipMessage(playerid, "Ustawi�e� now� cen� licencji!"); 
    return 1;
}

//end