//System wyborów

#include <a_samp>
#include <zcmd>
#include <sqlitei>

new DB:db_handle;
#define DB_FILE "wybory.db"
new bool:PlayerVoted[MAX_PLAYERS];

//Ustawienia
#define ELECTION_DAY 17
#define ELECTION_HOUR_START 7
#define ELECTION_HOUR_STOP 22

enum _candidate {
    c_Votes
};

new CandidateData[100][_candidate];

new Candidates[][] = 
{
    "Natalie_Lestrange",
    "Stanislaw_Szkodnik",
    "Paul_Brain",
    "Domenico_LaMuerte",
    "Douglas_Wright",
    "William_Kentucky",
    "Jason_Parker",
    "Norman_Klama",
    "Evan_Jones"
};

public OnFilterScriptInit()
{
    print("[wybory] Wczytywanie skryptu...");
    if((db_handle = db_open(DB_FILE)) == DB:0)
    {
        printf("[wybory] Brak pliku %s, wy³¹czam filterscript.", DB_FILE);
        SendRconCommand("unloadfs wybory_nowe");
    }
    else
    {
        printf("[wybory] Za³adowano plik %s.", DB_FILE);
    }
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i)) 
            OnPlayerConnect(i);
    }
    LoadVotes();
    return 1;
}

public OnFilterScriptExit()
{
    return 1;
}

public OnPlayerConnect(playerid)
{
    new DBResult:result, query[328];
    format(query, sizeof query, "SELECT `Voted` FROM `playervotes` WHERE `Voted` = 1 AND `Player` = '%s'", GetNickEx(playerid));
    result = db_query(db_handle, query);
    if(db_num_rows(result))
        PlayerVoted[playerid] = true;
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    PlayerVoted[playerid] = false;
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 21374)
    {
        if(!response) return 0;
        if(PlayerVoted[playerid])
            return SendClientMessage(playerid, 0xBFC0C2FF, "* Zag³osowa³eœ ju¿ w tych wyborach.");
        if(!strcmp(GetNickEx(playerid), Candidates[listitem]))
            return SendClientMessage(playerid, -1, "Nie mo¿esz zag³osowaæ na siebie!");
        CandidateData[listitem][c_Votes]++;
        PlayerVoted[playerid] = true;
        new string[456];
        format(string, sizeof string, "Odda³eœ g³os na kandydata nr %d. %s", listitem, Candidates[listitem]);
        SendClientMessage(playerid, 0xFF9900AA, string);

        format(string, sizeof string, "INSERT INTO `playervotes` (`Player`, `Voted`) VALUES ('%s', '1')", GetNickEx(playerid));
        db_free_result(db_query(db_handle, string));
        format(string, sizeof string, "UPDATE `votes` SET `Votes` = `Votes`+1 WHERE `Candidate` = '%s'", Candidates[listitem]);
        db_free_result(db_query(db_handle, string));
    }
    return 1;
}

stock LoadVotes()
{
    new DBResult:result, query[328];
    for(new i = 0; i < sizeof Candidates; i++)
    {
        format(query, sizeof query, "SELECT `Votes` FROM `votes` WHERE `Candidate` = '%s'", Candidates[i]);
        result = db_query(db_handle, query);
        if(db_num_rows(result))
        {
            CandidateData[i][c_Votes] = db_get_field_int(result);
            printf("%s: %d", Candidates[i], CandidateData[i][c_Votes]);
        }
        else
        {
            format(query, sizeof query, "INSERT INTO `votes` (`Candidate`, `Votes`) VALUES ('%s', '0')", Candidates[i]);
            db_free_result(db_query(db_handle, query));
        }
    }
    return 1;
}

stock GetNickEx(playerid, withmask = false)
{
	new nick[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, nick, sizeof(nick));
	if(withmask)
	{
		return nick;
	}
	else
	{
		new nick2[24];
		if(GetPVarString(playerid, "maska_nick", nick2, 24))
		{
			return nick2;
		}
	}
	return nick;
}

stock CanVote()
{
    new year, month, day, hour, minute, second; 
    getdate(year, month, day);
    gettime(hour, minute, second);
    if(day == ELECTION_DAY && hour >= ELECTION_HOUR_START && hour < ELECTION_HOUR_STOP)
        return 1;
    return 0;
}

CMD:glosuj(playerid, params[])
{
    if(!CanVote())
        return SendClientMessage(playerid, 0xBFC0C2FF, "Wybory jeszcze siê nie zaczê³y lub zosta³y ju¿ zakoñczone.");
    if(PlayerVoted[playerid])
        return SendClientMessage(playerid, 0xBFC0C2FF, "* Zag³osowa³eœ ju¿ w tych wyborach.");
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 1483.9663,-1760.7462,1.7179) && GetPlayerVirtualWorld(playerid) == 49)
    {
        new string[1024];
        string = "#\tKandydat";
        for(new i = 0; i < sizeof Candidates; i++)
            format(string, sizeof string, "%s\n%d\t%s", string, i, Candidates[i]);
        ShowPlayerDialog(playerid, 21374, DIALOG_STYLE_TABLIST_HEADERS, "Karta do g³osowania", string, "G³osuj", "Zamknij");
    }
    else
        SendClientMessage(playerid, 0xBFC0C2FF, "* Nie znajdujesz siê w lokalu wyborczym.");
    return 1;
}

CMD:wybory_wyniki(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, -1, "Brak uprawnieñ!");
    new string[1024];
    string = "Kandydat\tG³osy";
    for(new i = 0; i < sizeof Candidates; i++)
        format(string, sizeof string, "%s\n%s\t%d", string, Candidates[i], CandidateData[i][c_Votes]);
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "Wyniki wyborów", string, "OK", #);
    return 1;
}