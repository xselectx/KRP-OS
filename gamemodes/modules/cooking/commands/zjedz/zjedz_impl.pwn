//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   zjedz                                                   //
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
// Autor: mrucznik
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
zjedz_OnDialogResponse(playerid, listitem)
{
    MruMySQL_EatCookedMeal(playerid, DynamicGui_GetValue(playerid, listitem));
    MruMySQL_CookedMealsDialog(playerid);
    return 1;
}

command_zjedz_Impl(playerid)
{
    new Float:hp;
    GetPlayerHealth(playerid, hp);
    if(hp >= 100.0)
    {
        sendErrorMessage(playerid, "Jeste� tak najedzony, �e nie zmie�cisz ju� wi�cej (masz pe�ne hp).");
        return 1;
    }
    
    if(gettime() - GetPVarInt(playerid, "lastDamage") < 60)
    {
        sendErrorMessage(playerid, "Nie mo�esz je�� podczas walki!");
        return 1;
    }

    MruMySQL_CookedMealsDialog(playerid);
    return 1;
}

//end