//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                    glod                                                   //
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
// Data utworzenia: 26.05.2021
//Opis:
/*
	System gÂ³odu
*/

//

//-----------------<[ Timery: ]>-------------------

ptask CheckHunger[1000](playerid)
{
	if(gPlayerLogged[playerid])
	{
		//dodawanie glodu i pragnienia
		if(PlayerInfo[playerid][pHunger] < MAX_ALLOWED_HUNGER && GlodSet == 1 && !IsPlayerPaused(playerid)) 
		{
			PlayerInfo[playerid][pHunger] += GIVE_HUNGER;
			PlayerInfo[playerid][pThirst] += GIVE_THIRST;
		}
		
		if(PlayerInfo[playerid][pHunger] > MAX_ALLOWED_HUNGER) PlayerInfo[playerid][pHunger] = MAX_ALLOWED_HUNGER;
		if(PlayerInfo[playerid][pThirst] > MAX_ALLOWED_THIRST) PlayerInfo[playerid][pThirst] = MAX_ALLOWED_HUNGER;
		if(PlayerInfo[playerid][pHunger] < 0.0) PlayerInfo[playerid][pHunger] = 0.0;
		if(PlayerInfo[playerid][pThirst] < 0.0) PlayerInfo[playerid][pThirst] = 0.0;

		//objawy
		if(PlayerInfo[playerid][pHunger] >= 85.0 && GetPVarInt(playerid, "Glod-Info") < gettime())
		{
			_MruGracz(playerid, " Twoja postaæ zaczyna odczuwaæ g³ód, udaj siê do restauracji aby coœ zjeœæ!");
			SetPVarInt(playerid, "Glod-Info", gettime()+900); //info co 15 minut
		}
		if(PlayerInfo[playerid][pThirst] >= 91.0 && GetPVarInt(playerid, "Pragnienie-Info") < gettime())
		{
			_MruGracz(playerid, " Twoja postaæ zaczyna odczuwaæ pragnienie, udaj siê do restauracji, aby kupiæ coœ do picia!");
			SetPVarInt(playerid, "Pragnienie-Info", gettime()+900); //info co 15 minut
		}
		if(PlayerInfo[playerid][pHunger] >= 88.0 || PlayerInfo[playerid][pThirst] >= 91.0) 
			SetPlayerDrunkLevel(playerid, GetPlayerDrunkLevel(playerid)+200);
		if(GetPlayerDrunkLevel(playerid) > 7000 && (PlayerInfo[playerid][pHunger] >= 88.0 || PlayerInfo[playerid][pThirst] >= 91.0)) 
			SetPlayerDrunkLevel(playerid, 7000);

		if(PlayerInfo[playerid][pThirst] >= 96.5 && GetPVarInt(playerid, "bw-cooldown") < gettime() && !CheckBW(playerid)) //bw
		{
			SetPVarInt(playerid, "bw-cooldown", gettime() + 600);
			ShowPlayerInfoDialog(playerid, "Kotnik Role Play", "Twoja postaæ straci³a przytomnoœæ z powodu odwodnienia.");
			NadajRanny(playerid, INJURY_TIME_EXCEPTION);
			ProxDetector(15.0, playerid, sprintf("* %s traci przytomnoœæ z powodu odwodnienia.", GetNick(playerid)), COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
		}
		
		//aktualizacja textdraw
		htTextDrawShow(playerid);

	}
	return 1;
}

//end