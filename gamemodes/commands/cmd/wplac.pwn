//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wplac ]-------------------------------------------------//
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

YCMD:wplac(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
	        if(PlayerInfo[playerid][pLocal] != 103 && !GraczBankomat(playerid))
	        {
          		sendTipMessage(playerid, "Nie jeste� w Banku ani przy bankomacie !");
	            return 1;
	        }
			new cashdeposit, bankomat_fee = 0;
			if( sscanf(params, "s[32]", string))
			{
				sendTipMessage(playerid, "U�yj /wplac [kwota]");
				format(string, sizeof(string), "Masz teraz $%d na swoim koncie.", PlayerInfo[playerid][pAccount]);
				sendTipMessage(playerid, string);
                if(GraczBankomat(playerid)) {
                    sendTipMessage(playerid, "UWAGA! Przy wp�atach przez bankomat prowizja to 6 procent!", COLOR_LIGHTBLUE);
                }
				return 1;
			}

			cashdeposit = FunkcjaK(string);

			if (cashdeposit > kaska[playerid] || cashdeposit < 1)
			{
				sendTipMessage(playerid, "Nie masz tyle");
				return 1;
			}

			if(PlayerInfo[playerid][pAccount] + cashdeposit >=100000000)
			{
				sendTipMessage(playerid, "Maksymalnie w banku mo�esz trzyma� 100 milion�w!"); 
				return 1;
			}

			if(GraczBankomat(playerid)) {
				bankomat_fee = floatround(((cashdeposit/100) * 6), floatround_round);
			}

			new oldaccount = PlayerInfo[playerid][pAccount];
			ZabierzKaseDone(playerid, cashdeposit);
            PlayerInfo[playerid][pAccount] += (cashdeposit - bankomat_fee);

			Log(payLog, WARNING, "%s wp�aci� na swoje konto %d$. Koszt wp�aty %d, nowy stan %d$.", GetPlayerLogName(playerid), cashdeposit-bankomat_fee, bankomat_fee, PlayerInfo[playerid][pAccount]);

            if(GraczBankomat(playerid)) {
                format(string, sizeof(string), "Wp�aci�e� $%d na swoje konto (prowizja %d), obecny stan to: $%d ", cashdeposit-bankomat_fee, bankomat_fee, PlayerInfo[playerid][pAccount]);
                SendClientMessage(playerid, COLOR_YELLOW, string);
            } else {
                SendClientMessage(playerid, COLOR_WHITE, "|___ STAN KONTA ___|");
                format(string, sizeof(string), "  Poprzedni stan: $%d", oldaccount);
                SendClientMessage(playerid, COLOR_GRAD2, string);
                format(string, sizeof(string), "  Depozyt: $%d", cashdeposit);
                SendClientMessage(playerid, COLOR_GRAD4, string);
                SendClientMessage(playerid, COLOR_GRAD6, "|-----------------------------------------|");
                format(string, sizeof(string), "  Nowy stan: $%d", PlayerInfo[playerid][pAccount]);
                SendClientMessage(playerid, COLOR_WHITE, string);
            }
			return 1;
		}
	}
	return 1;
}
