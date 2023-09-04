//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  discord                                                  //
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
// Autor: skTom
// Data utworzenia: 04.05.2019
//Opis:
/*
	Modu³ ³¹cz¹cy gamemode z Mrucznikowym Discordem.
*/
// dev Nzk5MDUwMDQwMjA3MzQzNjM2.GJv3x_.CD7wvmZafL6EY7ejS22UT3mK2DWY86LtYfWCfc

//

//-----------------<[ Callbacki: ]>-----------------
//-----------------<[ Funkcje: ]>-------------------
LoadDiscordChannels()
{
    new query[512], type, org_id, channel_id[64];
    mysql_query("SELECT `type`, `org_id`, `channel_id` FROM `mru_discord` ORDER BY `id` ASC");
    mysql_store_result();

    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>dds[64]", type, org_id, channel_id);
		//printf("%d. ORG: %d CHN: %s", type, org_id, channel_id);
		if(!strcmp(channel_id, "0", true)) continue;
		if(type == 1) //frakcja
		{
			g_GroupChannel[org_id] = DCC_FindChannelById(channel_id);
		}
		else if(type == 3) //sytemowe
		{
			g_OtherChannel[org_id] = DCC_FindChannelById(channel_id);
		}
		else //logi
		{
			g_LogChannel[org_id] = DCC_FindChannelById(channel_id);
		}
    }
    mysql_free_result();
    print("Wczytano kana3y discord");
}
DiscordConnectInit()
{
	LoadDiscordChannels();
	DCC_SetBotActivity("0 graczy");
	return 1;
}
SendDiscordMessage(channel, message[])
{
	new dest[512];
	utf8encode(dest, message);
	//printf("sending to: (%d) %d", channel, g_OtherChannel[channel]);
	DCC_SendChannelMessage(g_OtherChannel[channel], dest);
	return 1;
}

SendDiscordLogMessage(fractionid, message[])
{
	new dest[512];
	utf8encode(dest, message);
	DCC_SendChannelMessage(g_LogChannel[fractionid], dest);

	return 1;
}

SendDiscordGroupMessage(fractionid, message[])
{
	new dest[512];
	utf8encode(dest, message);
	DCC_SendChannelMessage(g_GroupChannel[fractionid], dest);

	return 1;
}
public DCC_OnMessageCreate(DCC_Message:message)
{
	new content[1024];
	new DCC_User:author;
	new DCC_Channel:channel;
	DCC_GetMessageAuthor(message, author);
	DCC_GetMessageContent(message, content, sizeof content);
	DCC_GetMessageChannel(message, channel);
	new bool:IsBot;
	DCC_IsUserBot(author, IsBot);
	if(strcmp(content, "kotnik", true) == 0)
	{
		new count = 0;
		for(new i = 0; i<MAX_PLAYERS; i++)
			if(IsPlayerConnected(i) && !IsPlayerNPC(i))
				count++;
		new str[128];
		if(count > 0)
			format(str, sizeof str, "Na kotniku gra aktualnie %d %s!", count, (count > 1 ? "graczy" : "gracz"));
		else
			format(str, sizeof str, "Na kotniku aktualnie nikt nie gra!");
		DCC_SendChannelMessage(channel, str);
	}
	if(channel == g_OtherChannel[DISCORD_ADMIN_CHAT] && IsBot == false)
	{
		new user_name[32 + 1],str[128], dest[128];
		DCC_GetUserName(author, user_name);
		format(str,sizeof(str), "[DISCORD] %s: %s",user_name, content);
		utf8decode(dest, str);
		strreplace(dest,"%","#");
		SendAdminMessage(0xFFC0CB, dest);
		return 1;
	}
	//grupy
	for(new i=0;i<MAX_GROUPS;i++)
	{
		if(channel == g_GroupChannel[i] && IsBot == false) 
		{
			new user_name[32 + 1],str[128],dest[128];
			DCC_GetUserName(author, user_name);
			format(str,sizeof(str), "[DISCORD] %s: %s",user_name, content);
			utf8decode(dest, str);
			strreplace(dest,"%","#");
			SendRadioMessage(i, GroupInfo[i][g_Color], str, 1);
			return 1;
		}
	}
	return 1;
}


//-----------------<[ Timery: ]>-------------------
task DiscordTask[30000]()
{
	new count = 0;
	for(new i = 0; i<MAX_PLAYERS; i++)
		if(IsPlayerConnected(i) && !IsPlayerNPC(i))
			count++;
	new str[64];
	format(str, sizeof str, "%d %s!", count, (count != 1 ? "graczy" : "gracz"));
	DCC_SetBotActivity(str);
	return 1;
}
//------------------<[ MySQL: ]>--------------------
YCMD:reloaddiscord(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1000 || IsAScripter(playerid))
	{
		for(new i = 0; i<200; i++)
		{
			g_GroupChannel[i] = 0;
			g_LogChannel[i] = 0;
			if(i<=9)
			{
				g_OtherChannel[i] = 0;
			}
		}
		LoadDiscordChannels();
		return 1;
	}
	else return noAccessMessage(playerid);
}
//end