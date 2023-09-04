//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  atuning                                                  //
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
// Autor: xSeLeCTx
// Data utworzenia: 10.07.2021


//

//------------------<[ Implementacja: ]>-------------------
command_atuning_Impl(playerid, params[])
{
    new modelid, color;
	if(sscanf(params, "dd", modelid, color)) { return SendClientMessage(playerid, -1, "Blad"); }
	if(IsPlayerInAnyVehicle(playerid))
	{
		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		new obj = CreateDynamicObject(modelid, x, y, z+1, 0, 0, 0);
		new materialindex, modelid2, txdname[256], texturename[256], materialcolor;
		GetDynamicObjectMaterial(obj, materialindex, modelid2, txdname, texturename, materialcolor, sizeof txdname, sizeof texturename);
		SetDynamicObjectMaterial(obj, materialindex, modelid2, txdname, texturename, color);
		//AttachDynamicObjectToVehicle(objectid, GetPlayerVehicleID(playerid), 0, 0, 0, 0, 0, 0);
		EditDynamicObject(playerid, obj);
	}
    return 1;
}

//end