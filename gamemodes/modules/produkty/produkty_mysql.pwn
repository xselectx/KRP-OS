//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  produkty                                                 //
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
// Data utworzenia: 31.05.2021
//Opis:
/*
	System produktów dla organizacji
*/

//

//------------------<[ MySQL: ]>--------------------

stock LoadProducts()
{
	new query[428], id;
	mysql_query_format("SELECT * FROM `mru_products` LIMIT %d", MAX_PRODUCTS);
	mysql_store_result();
	while(mysql_fetch_row_format(query, "|"))
	{
		id = Iter_Free(Products);
		if(id == -1) return 0;
		sscanf(query, "p<|>dds[64]ddddd", 
		Product[id][p_UID], 
		Product[id][p_OrgID], 
		Product[id][p_ProductName], 
		Product[id][p_Price], 
		Product[id][p_Value1], 
		Product[id][p_Value2],
		Product[id][p_ItemType],
		Product[id][p_Quant]);
		Iter_Add(Products, id);
	}
	mysql_free_result();
	printf("Zaladowano %d produktow.", Iter_Count(Products));
	return 1;
}

//end