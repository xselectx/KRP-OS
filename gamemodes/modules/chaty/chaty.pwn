//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   chaty                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 04.05.2019
//Opis:
/*
	Podstawowe chaty oraz narzÍdzia do ich pisania.
	Lista chatÛw:
		- [ic] /ad 
		- /live (/wywiad)
		- /news
		- /ro (rodziny ooc)
		- /fo (fraction ooc)
		- /r (rodziny ic)
		- /f (frakcje ic)
		- lokalny /l
		- krzyk /k
		- szept /s
		- lokalny ooc /b
		- globalny ooc /o
		- opisujπcy akcje /me
		- opisujπcy otoczenie /do
*/

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------

ReColor(text[])
{
    new
        pos = -1;
    while ((pos = strfind(text, "(", false, pos + 1)) != -1)
    {
        new
            c = pos + 1,
            n = 0,
            ch;
        // Note that the order of these is important!
        while ((ch = text[c]) && n != 6)
        {
            if (!('a' <= ch <= 'f' || 'A' <= ch <= 'F' || '0' <= ch <= '9'))
            {
                break;
            }
            ++c;
            ++n;
        }
        if (n == 6 && ch == ')')
        {
            text[pos] = '{';
            text[c] = '}';
        }
    }
}

sendFractionMessageToAll(playerid, groupid, text[])
{
	if(!IsValidGroup(groupid)) return 0;
	new slot = GetPlayerGroupSlot(playerid, groupid);
	new sContent[256];
	foreach(new i : Player) 
	{
		if(GetPVarInt(i, "TOG_frakcja_info") == 0 && PlayerPersonalization[i][PERS_FAMINFO] == 0)
		{
			fractionMessageRange++; 
			format(sContent, sizeof(sContent), "|___________ %s ___________|", GroupInfo[groupid][g_Name]); 
			SendClientMessage(i, COLOR_WHITE, sContent); 
			format(sContent, sizeof(sContent), "%s %s: %s", GroupRanks[groupid][PlayerInfo[playerid][pGrupaRank][slot-1]], GetNickEx(playerid), text);
			SendClientMessage(i, GroupInfo[groupid][g_Color], sContent); 
		}
	}
	format(sContent, sizeof(sContent), "WiadomoúÊ dotar≥a do %d graczy", fractionMessageRange); 
	sendTipMessage(playerid, sContent); 
	fractionMessageRange = 0; 
	return 1;
}

sprawdzReklame(text[], playerid)
{
	new valueAdd;
	if(strfind(text , "ip:" , true)>=0 
	|| strfind(text , "www." , true)>=0 
	|| strfind(text , ".pl" , true)>=0 
	|| strfind(text , "serw" , true)>=0  
	|| strfind(text , "serv" , true)>=0 
	|| strfind(text , ":7777" , true)>=0 
	|| strfind(text , ":2000" , true)>=0 
	|| strfind(text , ":3000" , true)>=0 
	|| strfind(text , ":4000" , true)>=0 
	|| strfind(text , ":5000" , true)>=0 
	|| strfind(text , ":6000" , true)>=0 
	|| strfind(text , ":8000" , true)>=0
	|| strfind(text, "lsrp", true)>=0
	|| strfind(text, "ls-rp", true)>=0
	|| strfind(text, "stories", true)>=0
	|| strfind(text, "n4g", true)>=0
	|| strfind(text, "fox", true)>=0)
	{
		new string[128];
		SendClientMessage(playerid, COLOR_GRAD2, "STOP REKLAMOM!");
		if(playerid != 666)
		{
			format(string, sizeof(string), "AdmWarning: %s [%d] REKLAMA: '' %s. '' ", GetNick(playerid), playerid, text);
		}
		else
		{
			format(string, sizeof(string), "AdmWarning: %s - Wykryto reklamÍ", text);
		}
		ABroadCast(COLOR_LIGHTRED,string,1);
		Log(warningLog, WARNING, "%s reklamuje: %s", GetPlayerLogName(playerid), text);
		valueAdd=1;
	}
	else
	{
		valueAdd=0;
	}
	return valueAdd;
}

sprawdzWulgaryzmy(text[], playerid)
{
	new valueWulgaryzmy;
	
	if(CheckVulgarityString(text) != 0)
	{
		if(playerid != 666)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "Zosta≥eú ukarany grzywnπ za wulgaryzmy! Kara: ("#PRICE_WULGARYZMY"$)");
			ZabierzKaseDone(playerid, PRICE_WULGARYZMY);
			Log(punishmentLog, WARNING, "Gracz %s zosta≥ ukarany karπ "#PRICE_WULGARYZMY"$ za przeklinanie.", GetPlayerLogName(playerid));
		}
		Log(warningLog, WARNING, "%s przeklina: %s", GetPlayerLogName(playerid), text);
		valueWulgaryzmy = 1;
	}
	else
	{
		valueWulgaryzmy=0;
	}
	return valueWulgaryzmy;
}

forward ProxDetectorEx(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
public ProxDetectorEx(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
    if(IsPlayerConnected(playerid))
    {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        new oldString[256];
        format(oldString, sizeof(oldString), "%s", string);
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);

        new x = -1, j = -1;
        new color1[16], color2[16], color3[16], color4[16], color5[16];

        format(color1, sizeof(color1), "{%x}", col1);
        format(color2, sizeof(color2), "{%x}", col2);
        format(color3, sizeof(color3), "{%x}", col3);
        format(color4, sizeof(color4), "{%x}", col4);
        format(color5, sizeof(color5), "{%x}", col5);

        strdel(color1, strlen(color1)-3, strlen(color1)-1);
        strdel(color2, strlen(color2)-3, strlen(color2)-1);
        strdel(color3, strlen(color3)-3, strlen(color3)-1);
        strdel(color4, strlen(color4)-3, strlen(color4)-1);
        strdel(color5, strlen(color5)-3, strlen(color5)-1);

        new color = 0;
        new cont = 0;
        new pos = 0;
        if(strcount(string, "*", true) < 24)
        {
        	for(new l = 0; l<strlen(string)-4; l++)
        	{
				
        		x = strfind(string, "**",false, l);
        		j = strfind(string, "**", false, x+2);
        		if(x != -1 && j != -1)
        		{
        			new mark_1 = strfind(string, "}", true, x-2);
        			new mark_2 = strfind(string, "{-", true, x-2);
        			if(x != mark_1+1 && j != mark_2-2)
        			{
        				new mark_3 = strfind(string, "{-", true, l);
        				new mark_4 = strfind(string, "}", true, l);
        				if((mark_3 > 0 && mark_4 != -1 ) || (mark_3 == -1 && (mark_4 == -1 || mark_4 == 0)))
        				{
        				    strins(string, "{C2A2DA}", x, 256);
        				    x = strfind(string, "**",false, l);
        				    j = strfind(string, "**", false, x+2);
        				    strins(string, "{-", j+2, 256);
        				    cont = 1;
        				    if(strlen(string) > 100)
        				    {
        				    	pos = strfind(string, " ", true, 100);
        				    	if(pos != -1)
        				    	{
									if(j > pos && x < pos) color = 1;
								}
							}
        				}
        	        }
        	    }  
        	}
    	}
        new text[256];
        new text2[128];
		strins(text, string, 0);
        if(color == 1)
        {
        	//new pos = strfind(text, " ", true, strlen(text) / 2);
        	if(pos != -1)
        	{
         		strmid(text2, text, pos + 1, strlen(text));
         		strdel(text, pos, strlen(text));

         		format(text, sizeof(text), "%s [..]", text);
         		format(text2, sizeof(text2), "{C2A2DA}[..] %s", text2);
         	}
        }
    	else
    	{
    		if(strlen(string) > 100)
    		{
    			pos = strfind(string, " ", true, 100);
    			if(pos != -1)
    			{
    	 			strmid(text2, text, pos + 1, strlen(text));
    	 			strdel(text, pos, strlen(text));
		
    	 			format(text, sizeof(text), "%s [..]", text);
    	 			format(text2, sizeof(text2), "[..] %s", text2);
    	 			color = 1;
    	 		}
    	 	}
    	}



        for(new i = 0; i < MAX_PLAYERS; i++)
        {     
            if(IsPlayerConnected(i))
            {
            	new text_2[256];
            	new text_22[128];
            	strins(text_2, text, 0);
            	strins(text_22, text2, 0);
                format(string, 256, "%s", oldString);
                GetPlayerPos(i, posx, posy, posz);
                tempposx = (oldposx -posx);
                tempposy = (oldposy -posy);
                tempposz = (oldposz -posz);

                if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i) && GetPlayerInterior(playerid) == GetPlayerInterior(i))
                {
                    if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
                    {
                        if(cont == 1) 
                        {
                        	strreplace(text_2, "{-", color1);
                        	strreplace(text_22, "{-", color1);
                        }

                        SendClientMessage(i, col1, text_2);
                        if(color == 1) SendClientMessage(i, col1, text_22);
                    }
                    else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
                    {
                        if(cont == 1) 
                        {
                        	strreplace(text_2, "{-", color2);
                        	strreplace(text_22, "{-", color2);
                        }

                        SendClientMessage(i, col2, text_2);
                        if(color == 1) SendClientMessage(i, col2, text_22);
                    }
                    else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
                    {
                        if(cont == 1) 
                        {
                        	strreplace(text_2, "{-", color3);
                        	strreplace(text_22, "{-", color3);
                        }

                        SendClientMessage(i, col3, text_2);
                        if(color == 1) SendClientMessage(i, col3, text_22);
                    }
                    else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
                    {
                        if(cont == 1) 
                        {
                        	strreplace(text_2, "{-", color4);
                        	strreplace(text_22, "{-", color4);
                        }

                        SendClientMessage(i, col4, text_2);
                        if(color == 1) SendClientMessage(i, col4, text_22);
                    }
                    else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
                    {
                        if(cont == 1) 
                        {
                        	strreplace(text_2, "{-", color5);
                        	strreplace(text_22, "{ ", color5);
                        }

                        SendClientMessage(i, col5, text_2);
                        if(color == 1) SendClientMessage(i, col5, text_22);
                    }
                }
            }
        }
    }
    return 1;
}
//#define VEHICLE_WDS_DEBUG
PlayerTalkIC(playerid, text[], jakMowi[], Float:rangeTalk, bool:chatBooble=true)
{
	new string[256]; 
	if(strlen(jakMowi) <= 1)
	{
		sendErrorMessage(playerid, "B≥πd! Zbyt krÛtka wartoúÊ 'jakMowi'"); 
		return 1;
	}
	text[0] = toupper(text[0]);
	new ostatnialitera = strlen(text)-1;


	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		if(strlen(text) < 78)
		{
			if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s ))", GetNick(playerid), playerid, text);
			else  format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s. ))", GetNick(playerid), playerid, text);
			ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
		}
		else
		{
			new pos = strfind(text, " ", true, strlen(text) / 2);
			if(pos != -1)
			{
				new text2[64];

				strmid(text2, text, pos + 1, strlen(text));
				strdel(text, pos, strlen(text));

				format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s [..] ))", GetNick(playerid), playerid, text);
				ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

				if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "{C0C0C0}>>(([..] %s ))", text2);
				else format(string, sizeof(string), "{C0C0C0}>>(([..] %s. ))", text2);
				ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
			}
		}
		return 1;
	}

	new newtext[256];
    format(newtext, sizeof(newtext), "%s", text);

	new emoticons_added = 0;
    for(new i = 0; i < sizeof EmoticonsChatList; i++)
    {
        for(;;)
        {
            if(emoticons_added < 3)
            {
                new pos = strfind(newtext, EmoticonsChatList[i][0], true);
                if(pos == -1) break;
                else
                {
                    strdel(newtext, pos, pos + strlen(EmoticonsChatList[i][0]));
                    new tmp_str[64];
                    format(tmp_str, sizeof tmp_str, "%s", EmoticonsChatList[i][1]);
                    strins(newtext, tmp_str, pos, sizeof newtext);
                    emoticons_added++;
                }
            }
            else break;
        }
        if(emoticons_added > 3) break;
    }

	if(strfind(jakMowi, "krzyczy", true, 0)  != -1)
	{
		format(string, sizeof(string), "%s %s: %s!", GetNick(playerid), jakMowi, newtext);
		ProxDetectorEx(rangeTalk, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		return 1;
	}
	if(strfind(newtext[ostatnialitera], ".", true, 0)  != -1 || strfind(newtext[ostatnialitera], "?", true, 0)  != -1 || strfind(newtext[ostatnialitera], "!", true, 0) != -1 || strfind(newtext[ostatnialitera], ":", true, 0)  != -1 || strfind(newtext[ostatnialitera], "*", true, 0) != -1 || strfind(newtext[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "%s %s: %s", GetNick(playerid), jakMowi, newtext);
	else format(string, sizeof(string), "%s %s: %s.", GetNick(playerid), jakMowi, newtext);
	new idvehicle = GetPlayerVehicleID(playerid);
	if(!IsPlayerInAnyVehicle(playerid) || IsABoat(idvehicle) || IsABike(idvehicle) || IsACarBezSzyb(idvehicle)){
		chatBooble = true;
		ProxDetectorEx(rangeTalk, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	else{
		if(IsVehicleWindowClosed(idvehicle, FL_DOOR) && IsVehicleWindowClosed(idvehicle, FR_DOOR) && IsVehicleWindowClosed(idvehicle, BL_DOOR) && IsVehicleWindowClosed(idvehicle, BR_DOOR)){
			chatBooble = false;
			if(strfind(newtext[ostatnialitera], ".", true, 0)  != -1 || strfind(newtext[ostatnialitera], "?", true, 0)  != -1 || strfind(newtext[ostatnialitera], "!", true, 0) != -1 || strfind(newtext[ostatnialitera], ":", true, 0)  != -1 || strfind(newtext[ostatnialitera], "*", true, 0) != -1 || strfind(newtext[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "%s %s (w pojeüdzie): %s", GetNick(playerid), jakMowi, newtext);
			else format(string, sizeof(string), "%s %s (w pojeüdzie): %s.", GetNick(playerid), jakMowi, newtext);
			foreach(new i : Player){
				if(IsPlayerInVehicle(i, idvehicle)){
					SendClientMessage(i, COLOR_FADE1, string);
					SetPlayerChatBubble(playerid, "**mÛwi coú w pojeüdzie**", KOLOR_JA, 20.0, 8000);
				}
			}
		}
		else{
			chatBooble = true;
			ProxDetectorEx(rangeTalk, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		}
	}
	if(PlayerPersonalization[playerid][PERS_TALKANIM] == 0 && !CheckBW(playerid))
		ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4);

	if(chatBooble == true)
	{
		if(strfind(newtext[ostatnialitera], ".", true, 0)  != -1 || strfind(newtext[ostatnialitera], "?", true, 0)  != -1 || strfind(newtext[ostatnialitera], "!", true, 0) != -1 || strfind(newtext[ostatnialitera], ":", true, 0)  != -1 || strfind(newtext[ostatnialitera], "*", true, 0) != -1 || strfind(newtext[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "%s: %s", jakMowi, newtext);
		else format(string, sizeof(string), "%s: %s.", jakMowi, newtext);
		if(strfind(jakMowi, "szepcze", true, 0) != -1) SetPlayerChatBubble(playerid,string,COLOR_FADE1,5.0,8000);
		else SetPlayerChatBubble(playerid,string,COLOR_FADE1,20.0,8000);
	}	
	return 1;
}

PlayerTalkOOC(playerid, text[], Float:rangeTalk)
{
	new string[256];
	if(IsPlayerConnected(playerid))
	{
		text[0] = toupper(text[0]);
		new ostatnialitera = strlen(text)-1;
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			if(strlen(text) < 78)
			{
				if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s ))", GetNick(playerid), playerid, text);
				else format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s. ))", GetNick(playerid), playerid, text);
				ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				SetPlayerChatBubble(playerid,text,COLOR_FADE1,10.0,8000);
			}
			else
			{
				new pos = strfind(text, " ", true, strlen(text) / 2);
				if(pos != -1)
				{
					new text2[64];

					strmid(text2, text, pos + 1, strlen(text));
					strdel(text, pos, strlen(text));

					format(string, sizeof(string), "{FF6A6A}@ %s {C0C0C0}[%d] Czat OOC: (( %s [..] ))", GetNick(playerid), playerid, text);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);

					if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "{C0C0C0}>>(([..] %s ))", text2);
					else format(string, sizeof(string), "{C0C0C0}>>(([..] %s. ))", text2);
					ProxDetector(13.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
				}
			}
			return 1;
		}
		if(strlen(text) < 78)
        {
            if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "%s [%d] Czat OOC: (( %s ))", GetNick(playerid), playerid, text);
			else format(string, sizeof(string), "%s [%d] Czat OOC: (( %s. ))", GetNick(playerid), playerid, text);
            ProxDetector(rangeTalk, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
        }
        else
        {
            new pos = strfind(text, " ", true, strlen(text) / 2);
            if(pos != -1)
            {
                new text2[64];

                strmid(text2, text, pos + 1, strlen(text));
                strdel(text, pos, strlen(text));

                format(string, sizeof(string), "%s [%d] Czat OOC: (( %s [.]", GetNick(playerid), playerid, text);
                ProxDetector(rangeTalk, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);

                if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "[.] %s ))", text2);
				else format(string, sizeof(string), "[.] %s. ))", text2);
                ProxDetector(rangeTalk, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
            }
        }
	    if(strfind(text[ostatnialitera], ".", true, 0)  != -1 || strfind(text[ostatnialitera], "?", true, 0)  != -1 || strfind(text[ostatnialitera], "!", true, 0) != -1 || strfind(text[ostatnialitera], ":", true, 0)  != -1 || strfind(text[ostatnialitera], "*", true, 0) != -1 || strfind(text[ostatnialitera], " ", true, 0)  != -1) format(string, sizeof(string), "(( %s Napisa≥: %s ))", GetNick(playerid), text);
		else format(string, sizeof(string), "(( %s Napisa≥: %s. ))", GetNick(playerid), text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1,25.0,8000);
	    Log(chatLog, WARNING, "%s OOC: %s", GetPlayerLogName(playerid), text);
	}
	return 1;
}

sendBiznesMessageToAll(playerid, text[])
{
	new sContent[256];
	foreach(new i : Player) 
	{
		if(GetPVarInt(i, "TOG_frakcja_info") == 0 && PlayerPersonalization[i][PERS_FAMINFO] == 0)
		{
			fractionMessageRange++; 
			format(sContent, sizeof(sContent), "|___________ %s ___________|", Business[PlayerInfo[playerid][pBusinessMember]][b_Name]); 
			SendClientMessage(i, COLOR_WHITE, sContent); 
			format(sContent, sizeof(sContent), "%s: %s", GetNickEx(playerid), text);
			SendClientMessage(i, -1, sContent); 
		}
	}
	format(sContent, sizeof(sContent), "WiadomoúÊ dotar≥a do %d graczy", fractionMessageRange); 
	sendTipMessage(playerid, sContent); 
	fractionMessageRange = 0; 
	return 1;
}

showTimedMsgBox(playerid, delay, text[]) {
	CzasInformacyjnego[playerid] = delay;
	PlayerTextDrawHide(playerid, TextInformacyjny[playerid]);
	PlayerTextDrawSetString(playerid, TextInformacyjny[playerid], text);
	PlayerTextDrawShow(playerid, TextInformacyjny[playerid]);
	return true;
}

//------------------<[ Z 3.0: ]>--------------------
stock ChatIC(playerid, text[])
{
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeüdzie)
		format(string, sizeof(string), "MÛwi: %s", text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s MÛwi(w pojeüdzie): %s", GetNick(playerid), text);
		RangeMessageColor(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	else
	{ //na zewnπtrz
		format(string, sizeof(string), "MÛwi: %s", text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s MÛwi: %s", GetNick(playerid), text);
		RangeMessageColor(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		ApplyAnimation(playerid,"PED","IDLE_CHAT",4.0,0,0,0,4,4); //animacja mowy
	}
	Log(chatLog, WARNING, "Chat IC: %s", text);
	return 1;
}

stock ActorChat(actorid, actor[], text[]) //TODO: better actor chat
{
	new Float:x, Float:y, Float:z;
	GetDynamicActorPos(actorid, x, y, z);
	return SystemRangeMessageColor(
		x, y, z, 
		GetDynamicActorVirtualWorld(actorid), 
		sprintf("%s MÛwi: %s", actor, text), 
		CHAT_RANGE, 
		COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5
	);
}

stock Krzyk(playerid, text[])
{
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeüdzie)
		format(string, sizeof(string), "Krzyczy: %s!!",text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, KRZYK_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Krzyczy(w pojeüdzie): %s!!", GetNick(playerid), text);
		RangeMessageColor(playerid, string, KRZYK_RANGE, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
	}
	else
	{ //na zewnπtrz
		format(string, sizeof(string), "Krzyczy: %s!!",text);
		SetPlayerChatBubble(playerid,string,COLOR_FADE1, KRZYK_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Krzyczy: %s!!", GetNick(playerid), text);
		RangeMessageColor(playerid, string, KRZYK_RANGE, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
	}
	Log(chatLog, WARNING, "Krzyk: %s", text);
	return 1;
}

stock Szept(playerid, text[])
{
	new string[256];
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
	{ //(w pojeüdzie)
		format(string, sizeof(string), "Szepcze: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, SZEPT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Szepcze(w pojeüdzie): %s", GetNick(playerid), text);
		RangeMessageColor(playerid, string, SZEPT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	else
	{ //na zewnπtrz
		format(string, sizeof(string), "Szepcze: %s", text);
		SetPlayerChatBubble(playerid,string, COLOR_FADE1, SZEPT_RANGE, CHATBUBBLE_TIME);
		format(string, sizeof(string), "%s Szepcze: %s", GetNick(playerid), text);
		RangeMessageColor(playerid, string, SZEPT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	}
	Log(chatLog, WARNING, "Szept: %s", text);
	return 1;
}

stock ChatOOC(playerid, text[])
{
	new string[256];
	format(string, sizeof(string), "(( %s ))", text);
	SetPlayerChatBubble(playerid,string, COLOR_FADE1, CHAT_RANGE, CHATBUBBLE_TIME);
	format(string, sizeof(string), "%s [%d] Czat OOC: %s", GetNick(playerid), playerid, string);
    RangeMessageColor(playerid, string, CHAT_RANGE, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
	Log(chatLog, WARNING, "Chat OOC: %s", text);
	return 1;
}

stock ChatMe(playerid, text[], Float:zasieg=ME_RANGE)
{
    new string[256];
	format(string, sizeof(string), "* %s *", text);
	SetPlayerChatBubble(playerid,string, COLOR_PURPLE, zasieg, CHATBUBBLE_TIME);
    format(string, sizeof(string), "* %s %s", GetNick(playerid), text);
    RangeMessage(playerid, COLOR_PURPLE, string, zasieg);
	format(string, sizeof(string), "--/me:-- %s", text);
	Log(chatLog, WARNING, "Chat me: %s", text);
	return 1;
}

stock ChatDo(playerid, text[], Float:zasieg=ME_RANGE)
{
    new string[256];
	format(string, sizeof(string), "** %s **", text);
	SetPlayerChatBubble(playerid,string, COLOR_DO, zasieg, CHATBUBBLE_TIME);
    format(string, sizeof(string), "* %s ((%s))", text, GetNick(playerid));
    RangeMessageColor(playerid, string, zasieg, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
	format(string, sizeof(string), "--/do:-- %s", text);
	Log(chatLog, WARNING, "Chat do: %s", text);
	return 1;
}

//------------------<[ MruMessage: ]>--------------------

stock MruMessage(playerid, kolor, text[])
{
	new lenght = strlen(text);
	if(lenght > MAX_MESSAGE_LENGHT)
	{
		new bufor[MAX_MESSAGE_LENGHT], spacja;
		for(spacja=MAX_MESSAGE_LENGHT-5; spacja>MAX_MESSAGE_LENGHT*0.75; spacja--)
			if(text[spacja] == ' ') break;
		
		strmid(bufor, text, 0, spacja);
		strcat(bufor, "...");
		SendClientMessage(playerid, kolor, bufor);
		strmid(bufor, text, spacja+1, lenght);
		strins(bufor, "...", 0);
		SendClientMessage(playerid, kolor, bufor);
		return 1;
	}
	else
	{
		return SendClientMessage(playerid, kolor, text);
	}
}

stock MruMessageToAll(kolor, text[])
{
	new lenght = strlen(text);
	if(lenght > MAX_MESSAGE_LENGHT)
	{
		new bufor[MAX_MESSAGE_LENGHT], spacja;
		for(spacja=MAX_MESSAGE_LENGHT-5; spacja>MAX_MESSAGE_LENGHT*0.75; spacja--)
			if(text[spacja] == ' ') break;
		
		strmid(bufor, text, 0, spacja);
		strcat(bufor, "...");
		SendClientMessageToAll(kolor, bufor);
		strmid(bufor, text, spacja+1, lenght);
		strins(bufor, "...", 0);
		SendClientMessageToAll(kolor, bufor);
	}
	else
	{
		return SendClientMessageToAll(kolor, text);
	}
	return 1;
}

stock MruMessageF(playerid, color, fstring[], {Float, _}:...) //by Y_Less edited by Mrucznik
{
    static const STATIC_ARGS = 3;
    new n = (numargs() - STATIC_ARGS) * BYTES_PER_CELL;
    if(n)
    {
        new message[256],arg_start,arg_end;
        #emit CONST.alt        fstring
        #emit LCTRL          5
        #emit ADD
        #emit STOR.S.pri        arg_start

        #emit LOAD.S.alt        n
        #emit ADD
        #emit STOR.S.pri        arg_end
        do
        {
            #emit LOAD.I
            #emit PUSH.pri
            arg_end -= BYTES_PER_CELL;
            #emit LOAD.S.pri      arg_end
        }
        while(arg_end > arg_start);

        #emit PUSH.S          fstring
        #emit PUSH.C          256
        #emit PUSH.ADR         message

        n += BYTES_PER_CELL * 3;
        #emit PUSH.S          n
        #emit SYSREQ.C         format

        n += BYTES_PER_CELL;
        #emit LCTRL          4
        #emit LOAD.S.alt        n
        #emit ADD
        #emit SCTRL          4

        if(playerid == INVALID_PLAYER_ID)
        {
            #pragma unused playerid
            return MruMessageToAll(color, message);
        } else {
            return MruMessage(playerid, color, message);
        }
    } else {
        if(playerid == INVALID_PLAYER_ID)
        {
            #pragma unused playerid
            return MruMessageToAll(color, fstring);
        } else {
            return MruMessage(playerid, color, fstring);
        }
    }
}

stock SystemRangeMessage(Float:x, Float:y, Float:z, vw, kolor, text[], Float:zasieg=30.0)
{ //wiadomoúÊ wyúwietlana w okreúlonym zasiÍgu
	foreach(new i : Player)
	{
		if(gPlayerLogged[i] == 0) continue;
		if(GetPlayerVirtualWorld(i) == vw || vw == -1)
		{
			if(IsPlayerInRangeOfPoint(i, zasieg, x, y, z))
			{
				MruMessage(i, kolor, text);
			}
		}
	}
	return 1;
}

stock RangeMessage(playerid, kolor, text[], Float:zasieg=30.0)
{ //wiadomoúÊ wyúwietlana w okreúlonym zasiÍgu
	new Float: x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	return SystemRangeMessage(x, y, z, GetPlayerVirtualWorld(playerid), kolor, text, zasieg);
}

stock SystemRangeMessageColor(Float:x, Float:y, Float:z, vw, text[], Float:zasieg, kolor1, kolor2, kolor3, kolor4, kolor5)
{
	foreach(new i : Player)
	{
		if(gPlayerLogged[i] == 0) continue;
		if(GetPlayerVirtualWorld(i) == vw || vw == -1)
		{
			new Float:distance = GetPlayerDistanceFromPoint(i, x, y, z);
			if(distance <= zasieg)
			{
				if(distance <= zasieg/16)
					MruMessage(i, kolor1, text);
				else if(distance <= zasieg/8)
					MruMessage(i, kolor2, text);
				else if(distance <= zasieg/4)
					MruMessage(i, kolor3, text);
				else if(distance <= zasieg/2)
					MruMessage(i, kolor4, text);
				else
					MruMessage(i, kolor5, text);
			}
		}
	}
	return 1;
}

stock RangeMessageColor(playerid, text[], Float:zasieg, kolor1, kolor2, kolor3, kolor4, kolor5)
{ //wiadomoúÊ wyúwietlana w okreúlonym zasiÍgu kolorowana w zaleønoúci od odleg≥oúci
	new Float: x, Float:y, Float:z;
	GetPlayerPos(playerid, x,y,z);
	
	return SystemRangeMessageColor(x, y, z, GetPlayerVirtualWorld(playerid), text, zasieg, kolor1, kolor2, kolor3, kolor4, kolor5);
}

//-----------------<[ Komendy: ]>-------------------

//end