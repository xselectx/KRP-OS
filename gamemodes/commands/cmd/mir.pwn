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
				return sendErrorMessage(playerid, "Nie mo¿esz u¿yæ tego tak szybko!");

		MirandaTalk(playerid, 0);
        SetPVarInt(playerid, "lastMiranda", gettime());
	}
	return 1;
}

new MirandaTalkStages[][128] = {
	"Masz prawo zachowaæ milczenie. Wszystko co powiesz..",
	"..mo¿e zostaæ u¿yte przeciwko Tobie w s¹dzie.",
	"Masz prawo do adwokata. Je¿eli Ciê na niego nie staæ..",
	"..przys³uguje Ci urzêdnik z s¹du.",
	"W ka¿dej chwili mo¿esz poprosiæ o obecnoœæ Adwokata..",
	"..b¹dŸ konsultacjê z nim. Czy zrozumia³eœ swoje prawa?"
};

forward MirandaTalk(playerid, stage);
public MirandaTalk(playerid, stage)
{
	PlayerTalkIC(playerid, MirandaTalkStages[stage], "mówi", 8.0);

	if(stage < sizeof(MirandaTalkStages))
		SetTimerEx("MirandaTalk", 750, false, "ii", playerid, stage+1);
}
