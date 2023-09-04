//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  pizzaman                                                 //
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
// Autor: AnakinEU
// Data utworzenia: 01.11.2021
//Opis:
/*
	Praca dorywcza Magazynier
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnGameModeInit()
{
	Create3DTextLabel("Praca Magazyniera!\n{FFFFFF}(/{929292}ppodnies{FFFFFF}) aby pracowaæ\n(/{929292}podloz{FFFFFF}) aby od³o¿yæ paczkê", 0xFFA500AA, 2174.98, -2248.15, 13.30, 40, 0, 0);
    Create3DTextLabel("Praca Magazyniera!\n{FFFFFF}(/{929292}podloz{FFFFFF}) aby od³o¿yæ paczkê i zgarn¹æ pieni¹dze", 0xFFA500AA, 2147.58, -2257.88, 13.30, 40, 0, 0);
    CreateDynamic3DTextLabel("Aby zakrecic kolem wpisz\n{4169E1}/zakreckolem\n{ffffff}Koszt {4169E1}25k$", 0xFFFFFFFF, 1016.8065,-1104.2010,-67.5729, 5.0);
   // CreateDynamic3DTextLabel("Aby skorzystac z ruletki wpisz\n{4169E1}/ruletka", 0xFFFFFFFF, 1036.8600,-1090.8431,-67.5729, 5.0);
    CreateDynamic3DTextLabel("Aby pogadac z dilerem wcisnij klawisz\n{4169E1}Y", 0xFFFFFFFF, 2309.1284,-2130.5847,13.5735, 5.0);
    CreateDynamic3DTextLabel("Urz¹d Pracy\nLos Santos Goverment\n(/praca)", 0x9ACD32AA, 1498.4562,-1582.0427,13.5498, 15.0);
    CreateDynamic3DTextLabel("Apteka\n /kuphp)", 0x9ACD32AA, 148.7488,-1323.1597,68.2710, 15.0);
    CreateDynamic3DTextLabel("Stragan z bronia\nAby skorzystac wcisnij klawisz\n{4169E1}Y", 0x9ACD32AA, 1189.2003,-1373.2570,13.5327, 15.0);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    MaPaczke[playerid] = 0;
    PodnoszeniePaczki[playerid] = 0;
    ACMagazynier[playerid] = 0;
	return 1;
}
//end