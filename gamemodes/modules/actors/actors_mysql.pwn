//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              ActorSystem                                                  //
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
// Autor: never 
// Data utworzenia: 28.05.2021
//Opis:
/*

*/

//

//-----------------<[ Funkcje: ]>-------------------
//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------
public LoadAnimations()
{
	new data[128], anim_id = 0;
	
	mysql_query("SELECT * FROM `mru_anims`");
	mysql_store_result();
	
	while( mysql_fetch_row_format( data ) )
	{
		anim_id ++;
		sscanf( data, "p<|>ds[12]s[16]s[24]fdddddd", 	AnimInfo[anim_id][aUID],
														AnimInfo[anim_id][aCommand],
														AnimInfo[anim_id][aLib],
														AnimInfo[anim_id][aName],
														AnimInfo[anim_id][aSpeed],
														AnimInfo[anim_id][aOpt1],
														AnimInfo[anim_id][aOpt2],
														AnimInfo[anim_id][aOpt3],
														AnimInfo[anim_id][aOpt4],
														AnimInfo[anim_id][aOpt5],
														AnimInfo[anim_id][aAction]);
	}
	
	mysql_free_result();
	
	printf("Wczytano %d animacje.", anim_id);
	return 1;
}

public LoadActors()
{
	new data[512], actors = 0;
	new uid;
	
	mysql_query("SELECT * FROM `mru_aktorzy`");
	mysql_store_result();
	
	while(mysql_fetch_row_format(data))
	{
		
		sscanf(data, "p<|>d", uid);
		
		sscanf(data, "p<|>ds[32]dfffdfd", 	
			ActorInfo[uid][aUID],
			ActorInfo[uid][aName],
			ActorInfo[uid][aSkin],
			ActorInfo[uid][aPosX],
			ActorInfo[uid][aPosY],
			ActorInfo[uid][aPosZ],
			ActorInfo[uid][aVW],
			ActorInfo[uid][aAngle],
			ActorInfo[uid][aAnimId]);
			
		ActorInfo[uid][aActor] = INVALID_ACTOR_ID;
		SpawnActor(uid);
		
		actors++;
	}
	
	mysql_free_result();
	
	printf("Wczytano %d aktorów.", actors);
	return 1;
}
//-----------------<[ Komendy: ]>-------------------

//end