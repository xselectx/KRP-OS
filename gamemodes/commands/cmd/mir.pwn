//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ mir ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/


YCMD:mir(playerid, params[], help)
{
	if(IsAPolicja(playerid) || IsAFBI(playerid))  //RANGA
	{
        if(gettime() - GetPVarInt(playerid, "lastMiranda") < 20)
				return sendErrorMessage(playerid, "Nie mo�esz u�y� tego tak szybko!");

		MirandaTalk(playerid, 0);
        SetPVarInt(playerid, "lastMiranda", gettime());
	}
	return 1;
}

new MirandaTalkStages[][128] = {
	"Masz prawo zachowa� milczenie. Wszystko co powiesz..",
	"..mo�e zosta� u�yte przeciwko Tobie w s�dzie.",
	"Masz prawo do adwokata. Je�eli Ci� na niego nie sta�..",
	"..przys�uguje Ci urz�dnik z s�du.",
	"W ka�dej chwili mo�esz poprosi� o obecno�� Adwokata..",
	"..b�d� konsultacj� z nim. Czy zrozumia�e� swoje prawa?"
};

forward MirandaTalk(playerid, stage);
public MirandaTalk(playerid, stage)
{
	PlayerTalkIC(playerid, MirandaTalkStages[stage], "m�wi", 8.0);

	if(stage < sizeof(MirandaTalkStages))
		SetTimerEx("MirandaTalk", 750, false, "ii", playerid, stage+1);
}
