//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                kuplicencje                                                //
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

//------------------<[ Implementacja: ]>-------------------
command_kuplicencje_Impl(playerid)
{
    if(PlayerInDmvPoint(playerid))
    {
        if(!DmvActorStatus)
        {
            sendErrorMessage(playerid, "Ta komenda jest wy��czona - Urz�d miasta nie obs�uguj� boty!"); 
            return 1;
        }
        new string[356]; 
        format(string, sizeof(string), "Nazwa\tKoszt\n\
        Dow�d Osobisty\t{80FF00}$%d\n\
        Karta w�dkarska\t{80FF00}$%d\n\
        Pozwolenie na bro�\t{80FF00}$%d\n\
        Patent �eglarski\t{80FF00}$%d\n\
        Prawo jazdy - teoria\t{80FF00}$%d\n\
        Prawo Jazdy - praktyka\t{80FF00}$%d\n\
        Prawo jazdy - odbi�r\t{80FF00}$%d\n\
        Licencja pilota\t{80FF00}$%d", 
        DmvLicenseCost[0], 
        DmvLicenseCost[1],
        DmvLicenseCost[2],
        DmvLicenseCost[3],
        DmvLicenseCost[4],
        DmvLicenseCost[5],
        DmvLicenseCost[6],
        DmvLicenseCost[7]);
        /* na p�niej
        DmvLicenseCost[8], - rejestracja pojazdu
        DmvLicenseCost[9]); - w�asna tablica rejestracyjna
        */
        ProxDetector(30.0, playerid, "Urz�dnik m�wi: Witam Pana(i) w Urz�dzie Miasta! W czym mog� Panu(i) pom�c?", COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY);
        ShowPlayerDialogEx(playerid, DIALOG_DMV, DIALOG_STYLE_TABLIST_HEADERS, "Wybierz dokument:", string, "Wyr�b", "Wyjdz");
    }
    else
    {
        sendErrorMessage(playerid, "Nie jeste� przy okienkach urz�du miasta!"); 
    }
    return 1;
}

//end