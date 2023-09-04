//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   bramy                                                   //
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
// Autor: renosk
// Data utworzenia: 19.05.2021
//Opis:
/*
	
*/

hook OnPlayerEditDynamicObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(GetPVarInt(playerid, "gate-create") > 0)
	{
		switch(response)
		{
			case EDIT_RESPONSE_CANCEL:
			{
				sendTipMessage(playerid, "Przerwa³eœ tworzenie bramy.");
				DestroyDynamicObject(objectid);
				SetPVarInt(playerid, "gate-create", 0);
			}
			case EDIT_RESPONSE_FINAL:
			{
				if(GetPVarInt(playerid, "gate-create") == 1) //poczatkowa pozycja bramy
				{
					SetPVarFloat(playerid, "gate-x", x);
					SetPVarFloat(playerid, "gate-y", y);
					SetPVarFloat(playerid, "gate-z", z);
					SetPVarFloat(playerid, "gate-rx", rx);
					SetPVarFloat(playerid, "gate-ry", ry);
					SetPVarFloat(playerid, "gate-rz", rz);

					SetDynamicObjectPos(objectid, x, y, z);
					SetDynamicObjectRot(objectid, rx, ry, rz);

					SetPVarInt(playerid, "gate-create", 2);
					sendTipMessage(playerid, "Wybierz drug¹ pozycje bramy");
					EditDynamicObject(playerid, objectid);
				}
				else if(GetPVarInt(playerid, "gate-create") == 2)
				{
                    new log_gate[256];
					new Float:x1 = GetPVarFloat(playerid, "gate-x"), Float:y1 = GetPVarFloat(playerid, "gate-y"), Float:z1 = GetPVarFloat(playerid, "gate-z");
					new Float:rx1 = GetPVarFloat(playerid, "gate-rx"), Float:ry1 = GetPVarFloat(playerid, "gate-ry"), Float:rz1 = GetPVarFloat(playerid, "gate-rz");
					new Float:speed = GetPVarFloat(playerid, "gate-speed"), Float:range = GetPVarFloat(playerid, "gate-range"), permtype = GetPVarInt(playerid, "gate-permtype"), perm = GetPVarInt(playerid, "gate-permid");
					DodajBrame(objectid, x1, y1, z1, rx1, ry1, rz1, x, y, z, rx, ry, rz, speed, range, permtype, perm);
					InsertBrama();
					SetDynamicObjectPos(objectid, x1, y1, z1);
					SetDynamicObjectRot(objectid, rx1, ry1, rz1);

					format(log_gate, sizeof log_gate, "CMD_Info: /stworzbrame u¿yte przez %s [%d]", GetNick(playerid), playerid);
					SendCommandLogMessage(log_gate);
					SetPVarInt(playerid, "gate-create", 0);
				}
			}
		}
    }
    return 1;
}

//