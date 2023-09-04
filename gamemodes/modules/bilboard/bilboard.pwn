//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 bilboard                                                  //
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
// Data utworzenia: 17.07.2022
//Opis:
/*
	System bilboard
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock ConvertBilboardText(bilbtext[])
{
	new tempstring[158];
	format(tempstring, 158, bilbtext);
	strins(tempstring, "{FFFFFF}", 0);
	for(;;)
	{
		new linijka = strfind(tempstring, "/n");
		if(linijka == -1) break;
		else
		{
			strdel(tempstring, linijka, linijka + 2);
			strins(tempstring, "\n", linijka);
		}
	}
	return tempstring;
}

stock CreateBilboard(index)
{
	new string[256];
	if(Bilboard[index][bcreated] == false)
	{
		Bilboard[index][bobjid] = CreateDynamicObject(1260,  Bilboard[index][bposx], Bilboard[index][bposy], Bilboard[index][bposz], 0.0, 0.0, Bilboard[index][brotz], -1, -1, -1, 300, 300, -1, 1);
		Bilboard[index][btextobjid] = CreateDynamicObject(4732, Bilboard[index][bposx], Bilboard[index][bposy], Bilboard[index][bposz] + 6, 0.0, 0.0, Bilboard[index][brotz] + 55, -1, -1, -1, 300, 300, -1, 1);
		format(string, sizeof string, "{FF5E5E}Bilboard\n{FFFF00}ID: %i", index);
		Bilboard[index][btdtid] = CreateDynamic3DTextLabel(string, 0xFFFFFFFF, Bilboard[index][bposx], Bilboard[index][bposy], Bilboard[index][bposz], 20);
		Bilboard[index][bcreated] = true;
		UpdateBilboard(index);
	}
	return 1;
}

stock UpdateBilboard(bilbid)
{
	new string[256];
	if(Bilboard[bilbid][btime] == -1)
		format(string, sizeof string, "{FFFFFF}Tutaj moze byc Twoja reklama!\n$%i za dzien", Bilboard[bilbid][bcost]),
		SetDynamicObjectMaterialText(Bilboard[bilbid][btextobjid], 0, string, OBJECT_MATERIAL_SIZE_512x128, "Frutiger Light Cn", 41, 0, 0xFFFF8200, 0xFF000000, 1);
	else
		SetDynamicObjectMaterialText(Bilboard[bilbid][btextobjid], 0, ConvertBilboardText(Bilboard[bilbid][btext]), OBJECT_MATERIAL_SIZE_512x128, "Frutiger Light Cn", 41, 0, 0xFFFF8200, 0xFF000000, 1);
	return 1;
}

stock SaveBilboards()
{
	foreach(new i : Bilboards_Iter)
	{
		if(Bilboard[i][bcreated] && Bilboard[i][bloaded] && Bilboard[i][btime] != -1)
		{
			new query[128];
			format(query, sizeof query, "UPDATE mru_bilboard SET time = '%i' WHERE uid = '%i'", Bilboard[i][btime], Bilboard[i][buid]);
			mysql_query(query);
		}
	}
	return 1;
}

stock CreateNewBilboard(Float:x, Float:y, Float:z, Float:rz)
{
	new query[256];
	format(query, sizeof query, "INSERT INTO mru_bilboard(`posx`, `posy`, `posz`, `rotz`, `text`, `time`, `cost`, `rentuid`) VALUES('%f', '%f', '%f', '%f', '%s', '%i', '%i', '%i')", x, y, z, rz, "_", -1, 1500, 0);
	mysql_query(query);
	OnBilboardCreate(mysql_insert_id(), x, y, z, rz);
}

public OnBilboardCreate(id, Float:x, Float:y, Float:z, Float:rz)
{
	new i = Iter_Free(Bilboards_Iter);
	Bilboard[i][bloaded] = true;
	Bilboard[i][bcreated] = false;
	Bilboard[i][buid] = id;
	Bilboard[i][bposx] = x;
	Bilboard[i][bposy] = y;
	Bilboard[i][bposz] = z;
	Bilboard[i][brotz] = rz;
	format(Bilboard[i][btext], 128, "_");
	Bilboard[i][btime] = -1;
	Bilboard[i][bcost] = 1500;
	Bilboard[i][bruid] = 0;
	CreateBilboard(i);
	Iter_Add(Bilboards_Iter, i);
	return 0;
}

stock LoadBilboards()
{
	new query[728], i = 0;
	mysql_query("SELECT * FROM `mru_bilboard`");
	mysql_store_result();
	while(mysql_fetch_row_format(query, "|"))
    {
		Bilboard[i][bloaded] = true;
		Bilboard[i][bcreated] = false;
		sscanf(query, "p<|>dffffffs[256]ddd",
		Bilboard[i][buid],
		Bilboard[i][bposx],
		Bilboard[i][bposy],
		Bilboard[i][bposz],
		Bilboard[i][brotx],
		Bilboard[i][broty],
		Bilboard[i][brotz],
		Bilboard[i][btext],
		Bilboard[i][btime],
		Bilboard[i][bcost],
		Bilboard[i][bruid]
		);

		CreateBilboard(i);
		Iter_Add(Bilboards_Iter, i);
		i++;
	}
	printf("Za³adowano %d bilboardów", i);
	return 1;
}
//end