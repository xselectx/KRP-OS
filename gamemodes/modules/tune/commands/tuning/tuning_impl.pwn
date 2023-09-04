//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   tuning                                                  //
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
command_tuning_Impl(playerid, giveplayerid)
{
	if(giveplayerid == INVALID_PLAYER_ID)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			sendTipMessage(playerid, "�eby sprawdzi� list� dost�pnych tuning�w dla pojazdu, musisz by� w poje�dzie.");
			return sendTipMessage(playerid, "Je�li natomiast chcesz zrobi� tuning komu� innemu u�yj /tuning [playerid/Cz��Nicku]");
		}
		SetPVarInt(playerid, "Tune_check", 1);
		return ShowTunePanel(playerid);
	}
	SetPVarInt(playerid, "Tune_check", 0);
	if(!IsAMechazordWarsztatowy(playerid)) 
		return SendClientMessage(playerid, COLOR_GRAD2, "Nie jeste� mechanikiem.");

	if(!IsAtWarsztat(playerid)) 
		return SendClientMessage(playerid, COLOR_GRAD2, "Nie jeste� w warsztacie, w kt�rym mo�na prowadzi� tuning.");

	if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 10) 
		return SendClientMessage(playerid, COLOR_GRAD2, "Ten gracz jest za daleko.");

	if(!IsPlayerInAnyVehicle(giveplayerid)) 
		return SendClientMessage(playerid, COLOR_GRAD2, "Ten gracz nie jest w poje�dzie.");

	if(!IsCarOwner(giveplayerid, GetPlayerVehicleID(giveplayerid))) 
		return SendClientMessage(playerid, COLOR_GRAD2, "Ten pojazd nie nale�y do tego gracza.");
		
	if(GetPVarInt(playerid, "Tune_active") == 1)
	{
		if(GetPVarInt(playerid, "Tune_giveplayerid") != giveplayerid)
		{
			return SendClientMessage(playerid, COLOR_GRAD2, sprintf("Najpierw sko�cz tuning graczowi %s [%d]", GetNick(GetPVarInt(playerid, "Tune_giveplayerid")), GetPVarInt(playerid, "Tune_giveplayerid")));
		}
		if(GetPVarInt(playerid, "Tune_vehicleid") != GetPlayerVehicleID(GetPVarInt(playerid, "Tune_giveplayerid")))
		{
			CancelTune(playerid);
			return SendClientMessage(playerid, COLOR_GRAD2, sprintf("Gracz %s [%d] zmieni� pojazd. Tuning zosta� anulowany.", GetNick(GetPVarInt(playerid, "Tune_giveplayerid")), GetPVarInt(playerid, "Tune_giveplayerid")));
		}
	}

	if(GetPVarInt(giveplayerid, "Tune_PendingInvite") == 2)
		return SendClientMessage(playerid, COLOR_GRAD2, sprintf("Nie mo�esz ju� tuningowa� %s [%d] poniewa� oferta zosta�a ju� wys�ana.", GetNick(GetPVarInt(playerid, "Tune_giveplayerid")), GetPVarInt(playerid, "Tune_giveplayerid")));

	if(GetPVarInt(playerid, "Tune_active") == 1 || giveplayerid == playerid)
	{
		ShowTunePanel(playerid);
		
		SetPVarInt(giveplayerid, "Tune_mechanik", playerid);
		SetPVarInt(playerid, "Tune_giveplayerid", giveplayerid);
		SetPVarInt(playerid, "Tune_vehicleid", GetPlayerVehicleID(giveplayerid));
		SetPVarInt(playerid, "Tune_active", 1);
		new Float:x, Float:y, Float:z;
		GetPlayerPos(giveplayerid, x, y, z);
		if(GetPVarInt(giveplayerid, "Tune_area") == 0)
		{
			new area = CreateDynamicSphere(x, y, z, 15, -1, -1, giveplayerid);
			printf("NEW AREA %d", area);
		 	SetPVarInt(giveplayerid, "Tune_area", area);
		}
		return 1;
	}

	new string[128];
	SetPVarInt(giveplayerid, "Tune_PendingInvite", 1);
	SetPVarInt(giveplayerid, "Tune_mechanik", playerid);
	format(string, sizeof(string),  "%s oferuje Ci tuning. Wpisz {bfbfbf}/akceptuj tuning{BFC0C2} by zaakceptowa�.", GetNick(playerid));
	SendClientMessage(giveplayerid, COLOR_GRAD2, string);
	format(string, sizeof(string),  "Oferujsz tuning %s. Poczekaj, a� zaakceptuje Twoj� ofert�!", GetNick(giveplayerid));
	SendClientMessage(playerid, COLOR_GRAD2, string);
	
	return 1;
}

//end