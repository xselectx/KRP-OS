//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                    logi                                                   //
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
	Narzêdzia do obs³ugi logów.
*/

//

#include <YSI_Coding\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

new logdate[64];
new logString[8192];

hook OnGameModeInit()
{
	new year, month, day;
	getdate(year, month, day);
	
	format(logdate, sizeof(logdate), "logs/logi/%d.%d.%d", day, month, year);
	dir_create(logdate);
	format(logdate, sizeof(logdate), "%d.%d.%d", day, month, year);

	format(logString, sizeof(logString), "Logger:\n");
	
	CreateLogEx(sprintf("logi/%s/admin", logdate));
	CreateLogEx(sprintf("logi/%s/pay", logdate));
	CreateLogEx(sprintf("logi/%s/punishment", logdate));
	CreateLogEx(sprintf("logi/%s/warning", logdate));
	CreateLogEx(sprintf("logi/%s/nick", logdate));
	CreateLogEx(sprintf("logi/%s/sejf", logdate));
	CreateLogEx(sprintf("logi/%s/server", logdate));
	CreateLogEx(sprintf("logi/%s/command", logdate));
	CreateLogEx(sprintf("logi/%s/chat", logdate));
	CreateLogEx(sprintf("logi/%s/damage", logdate));
	CreateLogEx(sprintf("logi/%s/money", logdate));
	CreateLogEx(sprintf("logi/%s/error", logdate));
	CreateLogEx("logi/old/premium");
	CreateLogEx("logi/old/connect");
	CreateLogEx("logi/old/mysql");
	CreateLogEx("logi/old/items");
	CreateLogEx("logi/old/motele");
	CreateLogEx("logi/old/kasyno");
	CreateLogEx("logi/old/adminduty");

	format(logString, sizeof(logString), "%sLogLevel:\n  Error:\n    PrintToConsole: true\n", logString);
	format(logString, sizeof(logString), "%sEnableColors: true", logString);
	file_write("log-config.yml", logString, "w");
	

	adminLog = CreateLog(sprintf("logi/%s/admin", logdate), false);
	payLog = CreateLog(sprintf("logi/%s/pay", logdate), false);
	punishmentLog = CreateLog(sprintf("logi/%s/punishment", logdate), false);
	warningLog = CreateLog(sprintf("logi/%s/warning", logdate), false);
	nickLog = CreateLog(sprintf("logi/%s/nick", logdate), false);
	sejfLog = CreateLog(sprintf("logi/%s/sejf", logdate), false);
	serverLog = CreateLog(sprintf("logi/%s/server", logdate), false);
	commandLog = CreateLog(sprintf("logi/%s/command", logdate), false);
	chatLog = CreateLog(sprintf("logi/%s/chat", logdate), false);
	damageLog = CreateLog(sprintf("logi/%s/damage", logdate), false);
	moneyLog = CreateLog(sprintf("logi/%s/money", logdate), false);
	errorLog = CreateLog(sprintf("logi/%s/error", logdate), true);
	premiumLog = CreateLog("logi/old/premium", false);
	connectLog = CreateLog("logi/old/connect", false);
	mysqlLog = CreateLog("logi/old/mysql", true);
	itemLog = CreateLog("logi/old/items", false);
	moteleLog = CreateLog("logi/old/motele", false);
	casinoLog = CreateLog("logi/old/kasyno", false);
	admindutyLog = CreateLog("logi/old/adminduty", false);
}

stock CreateLogEx(logname[])
{
	new text[512];
	format(text, sizeof(text), "  %s:\n    LogLevel: All\n    LogRotation:\n      Type: Size\n      Trigger: 5GB\n      BackupCount: 15\n", logname);
	format(logString, sizeof(logString), "%s%s", logString, text);
}

hook OnGameModeExit()
{
	DestroyLog(adminLog);
	DestroyLog(payLog);
	DestroyLog(punishmentLog);
	DestroyLog(warningLog);
	DestroyLog(nickLog);
	DestroyLog(sejfLog);
	DestroyLog(serverLog);
	DestroyLog(commandLog);
	DestroyLog(chatLog);
	DestroyLog(damageLog);
	DestroyLog(moneyLog);
	DestroyLog(errorLog);
	DestroyLog(premiumLog);
	DestroyLog(connectLog);
	DestroyLog(mysqlLog);
	DestroyLog(itemLog);
	DestroyLog(moteleLog);
	DestroyLog(casinoLog);
	DestroyLog(admindutyLog);
}

//end