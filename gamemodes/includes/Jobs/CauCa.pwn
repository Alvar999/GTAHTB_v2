//CauCaPlayTo
//Script Lai Boi TiloReRack

#include <YSI\y_hooks>


//=============================================//
//CauCaDiaLog
#define            DIALOG_NOTHING (01)
#define			BANCA					 (02)

//=============================================//
//CauCaNew
new new NPCBANCA[2];
new PlayerText:Thongtinca[MAX_PLAYERS][45];

//=============================================//
//CauCaEnum
enum CauCaPlayTo
{
    pCaChep,
    pRua,
    pCaMap,
    pCaHeo,
};

//=============================================//
hook OnGameModeInit()
{
    //Npc
    NPCBANCA[0] = CreateActor(2, -1575.5219,1277.2760,7.1793,177.3528);
    
    //PickUpCauCa
    CreateDynamicPickup(1239, 23, -1483.7195,770.3282,7.1778);//PickUpCauCa1
	CreateDynamicPickup(1239, 23, -1483.7194,765.9940,7.1778);//PickUpCauCa2
	CreateDynamicPickup(1239, 23, -1483.7194,761.4071,7.1778);//PickUpCauCa3
	CreateDynamicPickup(1239, 23, -1483.7194,757.1736,7.1778);//PickUpCauCa4
	CreateDynamicPickup(1239, 23, -1483.7194,752.7828,7.1778);//PickUpCauCa5
	
   
    //TextCauCa
	CreateDynamic3DTextLabel("{FF0000}[Khu Cau Ca]\n /cauca De Cau", -1, -1483.7195,770.3282,7.1778+1.1,10.0);
	CreateDynamic3DTextLabel("{FF0000}[Khu Cau Ca]\n /cauca De Cau", -1, -1483.7194,765.9940,7.1778+1.1,10.0);
	CreateDynamic3DTextLabel("{FF0000}[Khu Cau Ca]\n /cauca De Cau", -1, -1483.7194,761.4071,7.1778+1.1,10.0);
	CreateDynamic3DTextLabel("{FF0000}[Khu Cau Ca]\n /cauca De Cau", -1, -1483.7194,757.1736,7.1778+1.1,10.0);
	CreateDynamic3DTextLabel("{FF0000}[Khu Cau Ca]\n /cauca De Cau", -1, -1483.7194,752.7828,7.1778+1.1,10.0);
	
	return 1;
}

//=============================================//
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	if(newkeys & KEY_YES)
	{
        if(IsPlayerInRangeOfActor(playerid, npcbanca))
	    {
            ShowPlayerDialog(playerid, BANCA, DIALOG_STYLE_LIST, "{FF0000}NPC Thu Mua Ca", "Thu Mua Ca Chep Gia (50) SAD\n Thu Mua Rua Gia (500) SAD\n Thu Mua Ca Map Gia (800) SAD\n Thu Mua Ca Heo Gia (1000) SAD", "Chon", "Thoat");
		    return 1;
        }
	}
	
//=============================================//
hook OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(Text:INVALID_TEXT_DRAW == clickedid) {
	    if(GetPVarInt(playerid, "Thong_Tin_Ca") == 1) {
	        ExitThongtinca(playerid);
		}
	}
	
hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if(playertextid == Thongtinca[playerid][5]) // SHOP OBJECT
	 {
            SendClientMessageEx(playerid, COLOR_GREY, "{ff0000}[!]{ffff00} Ca Cua Ban Da Duoc Bao Quan /Tuica De Xem.");
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][0]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][1]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][2]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][3]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][4]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][5]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][6]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][7]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][8]);
			CancelSelectTextDraw(playerid);

	 }
     if(playertextid == Thongtinca[playerid][6]) // SHOP OBJECT
	 {
            if(PlayerInfo[playerid][pCaChep] >= 1)
			{
			SetPlayerAttachedObject( playerid, 0, 1599, 1, 0.217, 0.581999, 0, 0.699995, 99.7999, -83.1, 1, 1, 1);
			new string[128];
			format(string, sizeof(string), "{00ff00}%s : {ffffff}Khoe Ca Chep 33Cm {00ff00}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Ca Chep De Khoe");
			}
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][0]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][1]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][2]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][3]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][4]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][5]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][6]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][7]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][8]);
			CancelSelectTextDraw(playerid);

	 }
	 if(playertextid == Thongtinca[playerid][14]) // SHOP OBJECT
	 {
            SendClientMessageEx(playerid, COLOR_GREY, "{ff0000}[!]{ffff00} Ca Cua Ban Da Duoc Bao Quan /Tuica De Xem.");
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][9]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][10]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][11]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][12]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][13]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][14]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][15]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][16]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][17]);
			CancelSelectTextDraw(playerid);

	 }
     if(playertextid == Thongtinca[playerid][15])
	 {
            if(PlayerInfo[playerid][pRua] >= 1)
			{
		    new string[128];
			format(string, sizeof(string), "{00ff00}%s : {ffffff}Khoe Con Rua 150Cm Kha Hiem !!! {00ff00}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerAttachedObject( playerid, 0, 1609, 1, 0.272999, 0.595, 0.039, 1.6, 92.7, 91.1, 0.504, 0.587, 0.622);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Rua De Khoe");
			}
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][9]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][10]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][11]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][12]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][13]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][14]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][15]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][16]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][17]);
			CancelSelectTextDraw(playerid);
	 }
	 if(playertextid == Thongtinca[playerid][23]) // SHOP OBJECT
	 {
            SendClientMessageEx(playerid, COLOR_GREY, "{ff0000}[!]{ffff00} Ca Cua Ban Da Duoc Bao Quan /Tuica De Xem.");
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][18]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][19]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][20]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][21]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][22]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][23]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][24]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][25]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][26]);
			CancelSelectTextDraw(playerid);

	 }
     if(playertextid == Thongtinca[playerid][24])
	 {
            if(PlayerInfo[playerid][pCaMap] >= 1)
			{
			new string[128];
		    format(string, sizeof(string), "{00ff00}%s : {ffffff}Hiem Lam Day Do La {ff0000}(Shark){ffffff} 800Cm {00ff00}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerAttachedObject( playerid, 0, 1608, 1, 0.515999, 0.571999, 0.665999, -4.5, 93.4, -80.6, 0.383, 0.429999, 0.405);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Ca Map De Khoe");
			}
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][18]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][19]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][20]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][21]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][22]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][23]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][24]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][25]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][26]);
			CancelSelectTextDraw(playerid);
	 }
	 if(playertextid == Thongtinca[playerid][32]) // SHOP OBJECT
	 {
            SendClientMessageEx(playerid, COLOR_GREY, "{ff0000}[!]{ffff00} Ca Cua Ban Da Duoc Bao Quan /Tuica De Xem.");
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][27]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][28]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][29]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][30]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][31]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][32]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][33]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][34]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][35]);
			CancelSelectTextDraw(playerid);

	 }
     if(playertextid == Thongtinca[playerid][33])
	 {
            if(PlayerInfo[playerid][pCaHeo] >= 1)
			{
		    new string[128];
		    format(string, sizeof(string), "{00ff00}%s : {ffffff}Hiem Lam Day Do La Ca Heo Trang 1,000Cm {ff0000}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerAttachedObject( playerid, 0, 1607, 1, 0.382999, 0.574001, 0.184999, -2.2, 94.2999, -91.8, 0.437, 0.403, 0.451);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Ca Heo De Khoe");
			}
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][27]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][28]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][29]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][30]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][31]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][32]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][33]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][34]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][35]);
			CancelSelectTextDraw(playerid);
	 }
	 if(playertextid == Thongtinca[playerid][41]) // SHOP OBJECT
	 {
            SendClientMessageEx(playerid, COLOR_GREY, "{ff0000}[!]{ffff00} Ca Cua Ban Da Duoc Bao Quan /Tuica De Xem.");
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][36]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][37]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][38]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][39]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][40]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][41]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][42]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][43]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][44]);
			CancelSelectTextDraw(playerid);

	 }
    if(playertextid == Thongtinca[playerid][33])
    {
            if(PlayerInfo[playerid][pCaHeo] >= 1)
			{
		    new string[128];
		    format(string, sizeof(string), "{00ff00}%s : {ffffff}Hiem Lam Day Do La Ca Heo Trang 1,000Cm {ff0000}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerAttachedObject( playerid, 0, 1607, 1, 0.382999, 0.574001, 0.184999, -2.2, 94.2999, -91.8, 0.437, 0.403, 0.451);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Ca Heo De Khoe");
			}
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][27]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][28]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][29]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][30]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][31]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][32]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][33]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][34]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][35]);
			CancelSelectTextDraw(playerid);
    }
    if(playertextid == Thongtinca[playerid][41]) // SHOP OBJECT
    {
            SendClientMessageEx(playerid, COLOR_GREY, "{ff0000}[!]{ffff00} Ca Cua Ban Da Duoc Bao Quan /Tuica De Xem.");
			//HIDE
            PlayerTextDrawHide(playerid, Thongtinca[playerid][36]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][37]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][38]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][39]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][40]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][41]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][42]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][43]);
			PlayerTextDrawHide(playerid, Thongtinca[playerid][44]);
			CancelSelectTextDraw(playerid);
    }
    
    
//=============================================//
//CommandsCauCa
CMD:khoeca(playerid, params[])
{
 new choice[32];
 if(sscanf(params, "s[32]", choice))
 {
  SendClientMessageEx(playerid, COLOR_GREY, "{00ff00}SU DUNG: /Khoeca [Ten Ca]");
  SendClientMessageEx(playerid, COLOR_WHITE, "{ffff00}CaChep ");
  SendClientMessageEx(playerid, COLOR_WHITE, "{00ff00}Rua ");
  SendClientMessageEx(playerid, COLOR_WHITE, "{ff00ff}CaMap ");
  SendClientMessageEx(playerid, COLOR_WHITE, "{ff00af}CaHeo");
  return 1;
 }
   else if(strcmp(choice,"CaChep",true) == 0)
   {
      if(PlayerInfo[playerid][pCaChep] >= 1)
	  {
			SetPlayerAttachedObject( playerid, 0, 1599, 1, 0.217, 0.581999, 0, 0.699995, 99.7999, -83.1, 1, 1, 1);
			new string[128];
			format(string, sizeof(string), "{00ff00}%s : Khoe Ca Chep 33Cm {00ff00}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Ca Chep De Khoe");
			}
   }
   else if(strcmp(choice,"Rua",true) == 0)
   {
     if(PlayerInfo[playerid][pRua] >= 1)
	 {
		    new string[128];
			format(string, sizeof(string), "{00ff00}%s : Khoe Con Rua 150Cm Kha Hiem !!! {00ff00}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerAttachedObject( playerid, 0, 1609, 1, 0.272999, 0.595, 0.039, 1.6, 92.7, 91.1, 0.504, 0.587, 0.622);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Rua De Khoe");
			}
   }
   else if(strcmp(choice,"CaMap",true) == 0)
   {
      if(PlayerInfo[playerid][pCaMap] >= 1)
	  {
			new string[128];
		    format(string, sizeof(string), "{00ff00}%s : {ffffff}Hiem Lam Day Do La {ff0000}(Shark){ffffff} 800Cm {00ff00}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerAttachedObject( playerid, 0, 1608, 1, 0.515999, 0.571999, 0.665999, -4.5, 93.4, -80.6, 0.383, 0.429999, 0.405);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Ca Map De Khoe");
			}
   }
   else if(strcmp(choice,"CaHeo",true) == 0)
   {
       if(PlayerInfo[playerid][pCaHeo] >= 1)
	   {
		    new string[128];
		    format(string, sizeof(string), "{00ff00}%s : {ffffff}Hiem Lam Day Do La Ca Heo Trang 1,000Cm {ff0000}[!]", GetPlayerNameEx(playerid));
			ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerAttachedObject( playerid, 0, 1607, 1, 0.382999, 0.574001, 0.184999, -2.2, 94.2999, -91.8, 0.437, 0.403, 0.451);
			ApplyAnimation(playerid,"CARRY","crry_prtial",4.1,1,0,0,1,1);
		    }
		    else
			{
		     SendClientMessageEx(playerid, COLOR_GREY,"{00ff00}[!] {ffffff}Ban Khong Co Ca Heo De Khoe");
			}
   }
 return 1;
}


CMD:setca(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 99999)
	{

		new string[128], giveplayerid, statcode, amount;
		if(sscanf(params, "udd", giveplayerid, statcode, amount))
		{
			SendClientMessageEx(playerid, COLOR_GREY, "SU DUNG: /setca [player] [ID] [so Luong]");
			SendClientMessageEx(playerid, COLOR_GRAD1, "1 Ca Chep |2 Rua |3 Ca Map |4 Ca Heo");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
			switch (statcode)
			{
			case 1:
				{
					PlayerInfo[giveplayerid][pCaChep] += amount;
					format(string, sizeof(string), "%s da set Fish  - CaChep %d.", GetPlayerNameEx(giveplayerid), amount);
				}
			case 2:
				{
					PlayerInfo[giveplayerid][pRua] += amount;
					format(string, sizeof(string), "%s da set Fish  - Rua %d.", GetPlayerNameEx(giveplayerid), amount);
				}
			case 3:
				{
					PlayerInfo[giveplayerid][pCaMap] += amount;
					format(string, sizeof(string), "%s da set Fish  - Ca Map %d.", GetPlayerNameEx(giveplayerid), amount);
				}
			case 4:
				{
					PlayerInfo[giveplayerid][pCaHeo] += amount;
					format(string, sizeof(string), "%s da set Fish  - Ca Heo %d.", GetPlayerNameEx(giveplayerid), amount);
				}

			default:
				{
					format(string, sizeof(string), "Ban ton tai ID ma ban da nhap , vui long thu lai.", amount);
				}
			}


			format(string, sizeof(string), "%s by %s", string, GetPlayerNameEx(playerid));
			Log("logs/setfish.log", string);
			SendClientMessageEx(playerid, COLOR_GRAD1, string);

		}
	}
	return 1;
}


CMD:tuica(playerid, params[])
{
	new str[2460], str1[1280], str2[1280], str3[1280], name[1280];
    format(str1, sizeof(str), "{00ff00}Ca Chep : %d\n{00ff00}Rua : %d\n{00ff00}Ca Map : %d\n{00ff00}Ca Heo : %d", PlayerInfo[playerid][pCaChep], PlayerInfo[playerid][pRua], PlayerInfo[playerid][pCaMap], PlayerInfo[playerid][pCaHeo]);
    format(str, sizeof(str), "%s\n\n%s\n%s\n%s", str1, str2, str3);
    format(name, sizeof(name), "TUI CA - %s", GetPlayerNameEx(playerid));
	ShowPlayerDialog(playerid, DIALOG_NOTHING, DIALOG_STYLE_MSGBOX, name, str, "Dong Lai", "");
	return 1;
}


CMD:cauca(playerid, params[])
{
   if(baocaotime[playerid] > 0)
   {
		new string[128];
		format(string, sizeof(string), "Ban ban vua moi bat dau cau ca, khong the su dung cau ca nua. %d", baocaotime[playerid]);
		SendClientMessageEx(playerid, COLOR_GREY, string);
		return 1;
   }
   if(IsAtCauCaPoint(playerid))
   {
      ApplyAnimation(playerid, "SAMP", "FishingIdle", 3.0,1,1,0,0,0);
      ApplyAnimation(playerid, "SAMP", "FishingIdle", 3.0,1,1,0,0,0);
      SetPlayerAttachedObject( playerid, 0, 18632, 1, -0.199999, 0.157, -0.049999, 88.8, -35.7001, -175.5, 1.188, 1.5, 1.474);
      SendClientMessageEx(playerid, COLOR_REALRED, "{00ff00}[!] {ffffff}Ban Da Vut Can Cau Xuong Va Cau");
      baocaotime[playerid] = 14;
      SetPVarInt(playerid, "CauCaTime", 1);
      SetTimerEx("CauCaTime", 14000, 0, "d", playerid);
	  return 1;
   }
   return 1;
}


forward CauCaTime(playerid);
public CauCaTime(playerid)
{
	if(IsAtCauCaPoint(playerid))
	{
		new randomselect = 1+random(11);
	    switch(randomselect)
	    {
			case 1:
			{
		        RemovePlayerAttachedObject(playerid, 0);
				SendClientMessageEx(playerid, COLOR_GREY, "{00ff00}[!] {ffffff} Ban Vua Cau Duoc 1 Bich Rac.");

				PlayerInfo[playerid][pCash] += 1000;
	        }
			case 2:
			{
			    RemovePlayerAttachedObject(playerid, 0);
				SendClientMessageEx(playerid, COLOR_GREY, "{00ff00}[!] {ffffff} Ban Vua Cau Duoc 1 Bich Rac.");

				PlayerInfo[playerid][pCash] += 1000;
			}
			case 3:
			{
                RemovePlayerAttachedObject(playerid, 0);
				SendClientMessageEx(playerid, COLOR_GREY, "{5fff00}[!] {FFFFFF}Ban Da Cau Duoc Mot Con Ca Chep /KhoeCa.");
                PlayerInfo[playerid][pCaChep] += 1;
				//show
				if(GetPVarInt(playerid, "Thong_Tin_Ca") == 0)
	            {
				PlayerTextDrawShow(playerid, Thongtinca[playerid][0]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][1]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][2]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][3]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][4]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][5]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][6]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][7]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][8]);
				SetPVarInt(playerid, "Thong_Tin_Ca", 1);

				SelectTextDraw(playerid, 0xA3B4C5FF);
				PlayerPlaySound(playerid, 1136, 0,0,0);
				}
			    else
			    {
			    ExitThongtinca(playerid);
			    }
			}
			case 4..5:
			{
			    RemovePlayerAttachedObject(playerid, 0);
				SendClientMessageEx(playerid, COLOR_GREY, "{5fff00}[!] {FFFFFF}Ban Da Cau Duoc Mot Con Ca Chep /KhoeCa.");
                PlayerInfo[playerid][pCaChep] += 1;
				//show
				if(GetPVarInt(playerid, "Thong_Tin_Ca") == 0)
	            {
				PlayerTextDrawShow(playerid, Thongtinca[playerid][0]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][1]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][2]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][3]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][4]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][5]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][6]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][7]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][8]);
				SetPVarInt(playerid, "Thong_Tin_Ca", 1);

				SelectTextDraw(playerid, 0xA3B4C5FF);
				PlayerPlaySound(playerid, 1136, 0,0,0);
				}
			    else
			    {
			    ExitThongtinca(playerid);
			    }
			}
			case 6..7:
			{
                RemovePlayerAttachedObject(playerid, 0);
				SendClientMessageEx(playerid, COLOR_GREY, "{5fff00}[!] {FFFFFF}Ban Da Cau Duoc Mot Con Rua /KhoeCa.");
                PlayerInfo[playerid][pRua] += 1;
				//show
				if(GetPVarInt(playerid, "Thong_Tin_Ca") == 0)
	            {
				PlayerTextDrawShow(playerid, Thongtinca[playerid][9]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][10]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][11]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][12]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][13]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][14]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][15]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][16]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][17]);
				SetPVarInt(playerid, "Thong_Tin_Ca", 1);

                SelectTextDraw(playerid, 0xA3B4C5FF);
				PlayerPlaySound(playerid, 1136, 0,0,0);
				}
			    else
			    {
			    ExitThongtinca(playerid);
			    }
			}
			case 8..9:
			{
                RemovePlayerAttachedObject(playerid, 0);
			    //new string[128];
				//format(string, sizeof(string), "{00ff00} %s [!] Vua Cau Duoc Bich Rac", GetPlayerNameEx(playerid));
				//ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				new str[128];
				format(str, sizeof(str), "{ff0000}Play Together: {00ff00}%s{ffffff} Vua Cau Duoc Mot Con {00ff00}Shark", GetPlayerNameEx(playerid));
		        SendClientMessageToAllEx(COLOR_LIGHTRED, str);
				SendClientMessageEx(playerid, COLOR_GREY, "{5fff00}[!] {FFFFFF}Ban Da Cau Duoc Mot Con Ca Map /KhoeCa.");
                PlayerInfo[playerid][pCaMap] += 1;
                //camap
                if(GetPVarInt(playerid, "Thong_Tin_Ca") == 0)
	            {
				PlayerTextDrawShow(playerid, Thongtinca[playerid][18]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][19]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][20]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][21]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][22]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][23]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][24]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][25]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][26]);
                SetPVarInt(playerid, "Thong_Tin_Ca", 1);

                SelectTextDraw(playerid, 0xA3B4C5FF);
				PlayerPlaySound(playerid, 1136, 0,0,0);
				}
			    else
			    {
			    ExitThongtinca(playerid);
			    }
			}
			case 10..11:
			{
                RemovePlayerAttachedObject(playerid, 0);
			    //new string[128];
				//format(string, sizeof(string), "{00ff00} %s [!] Vua Cau Duoc Bich Rac", GetPlayerNameEx(playerid));
				//ProxDetectorWrap(playerid, string, 92, 30.0, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
				new str[128];
				format(str, sizeof(str), "{ff0000}Play Together: {00ff00}%s{ffffff} Vua Cau Duoc Mot Con {00ff00}Ca Heo", GetPlayerNameEx(playerid));
		        SendClientMessageToAllEx(COLOR_LIGHTRED, str);
				SendClientMessageEx(playerid, COLOR_GREY, "{5fff00}[!] {FFFFFF}Ban Da Cau Duoc Mot Con Ca Heo /KhoeCa.");
                PlayerInfo[playerid][pCaHeo] += 1;
				//show
				if(GetPVarInt(playerid, "Thong_Tin_Ca") == 0)
	            {
				PlayerTextDrawShow(playerid, Thongtinca[playerid][27]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][28]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][29]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][30]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][31]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][32]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][33]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][34]);
				PlayerTextDrawShow(playerid, Thongtinca[playerid][35]);
                SetPVarInt(playerid, "Thong_Tin_Ca", 1);

                SelectTextDraw(playerid, 0xA3B4C5FF);
				PlayerPlaySound(playerid, 1136, 0,0,0);
				}
			    else
			    {
			    ExitThongtinca(playerid);
			    }
			}
		}
	}
	
	TogglePlayerControllable(playerid, 1);
   	DeletePVar(playerid, "CauCaTime");
   	return 1;
}

hook CreatePlayerTextDraws(playerid)
{
    //thongtinca
    Thongtinca[playerid][0] = CreatePlayerTextDraw(playerid, 407.199981, 117.124435, "box");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][0], 0.000000, 28.360034);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][0], 582.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][0], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, Thongtinca[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, Thongtinca[playerid][0], -10);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][0], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][0], 0);

	Thongtinca[playerid][1] = CreatePlayerTextDraw(playerid, 407.200042, 117.324455, "box");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][1], 0.000000, 2.440000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][1], 582.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][1], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, Thongtinca[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, Thongtinca[playerid][1], 16777215);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][1], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][1], 0);

	Thongtinca[playerid][2] = CreatePlayerTextDraw(playerid, 516.799865, 119.813316, "Ca Chep");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][2], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][2], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][2], 16711935);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][2], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][2], 0);

	Thongtinca[playerid][3] = CreatePlayerTextDraw(playerid, 438.999908, 165.951232, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][3], 111.000000, 103.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][3], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][3], 16711935);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][3], 1605);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][3], 0.000000, 0.000000, 90.000000, 0.200000);

	Thongtinca[playerid][4] = CreatePlayerTextDraw(playerid, 540.399841, 275.120056, "Gia : 200 SAD");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][4], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][4], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][4], -16776961);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][4], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][4], 0);

	Thongtinca[playerid][5] = CreatePlayerTextDraw(playerid, 419.399871, 332.208984, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][5], 64.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][5], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][5], 16777215);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][5], 1599);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, Thongtinca[playerid][5], true);

	Thongtinca[playerid][6] = CreatePlayerTextDraw(playerid, 506.200134, 332.209075, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][6], 64.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][6], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][6], -5963521);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][6], 1599);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, Thongtinca[playerid][6], true);

	Thongtinca[playerid][7] = CreatePlayerTextDraw(playerid, 473.999908, 337.342254, "Bao Quan");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][7], 0.336399, 1.585066);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][7], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][7], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][7], 0);

	Thongtinca[playerid][8] = CreatePlayerTextDraw(playerid, 550.399719, 337.342193, "Khoe");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][8], 0.336399, 1.585066);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][8], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][8], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][8], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][8], 0);

	//RUA
	Thongtinca[playerid][9] = CreatePlayerTextDraw(playerid, 407.199981, 117.124435, "box");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][9], 0.000000, 28.360034);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][9], 582.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][9], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][9], -1);
	PlayerTextDrawUseBox(playerid, Thongtinca[playerid][9], 1);
	PlayerTextDrawBoxColor(playerid, Thongtinca[playerid][9], -10);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][9], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][9], 0);

	Thongtinca[playerid][10] = CreatePlayerTextDraw(playerid, 407.200042, 117.324455, "box");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][10], 0.000000, 2.440000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][10], 582.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][10], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][10], -1);
	PlayerTextDrawUseBox(playerid, Thongtinca[playerid][10], 1);
	PlayerTextDrawBoxColor(playerid, Thongtinca[playerid][10], 16777215);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][10], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][10], 0);

	Thongtinca[playerid][11] = CreatePlayerTextDraw(playerid, 501.999969, 119.315536, "Rua");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][11], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][11], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][11], 16711935);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][11], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][11], 0);

	Thongtinca[playerid][12] = CreatePlayerTextDraw(playerid, 438.999908, 165.951232, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][12], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][12], 111.000000, 103.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][12], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][12], 16711935);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][12], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][12], 1609);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][12], 0.000000, 0.000000, 90.000000, 1.000000);

	Thongtinca[playerid][13] = CreatePlayerTextDraw(playerid, 546.000061, 275.120056, "Gia : 1,000 SAD");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][13], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][13], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][13], -16776961);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][13], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][13], 0);

	Thongtinca[playerid][14] = CreatePlayerTextDraw(playerid, 419.399871, 332.208984, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][14], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][14], 64.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][14], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][14], 16777215);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][14], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][14], 1599);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][14], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, Thongtinca[playerid][14], true);

	Thongtinca[playerid][15] = CreatePlayerTextDraw(playerid, 506.200134, 332.209075, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][15], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][15], 64.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][15], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][15], -5963521);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][15], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][15], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][15], 1599);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][15], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, Thongtinca[playerid][15], true);

	Thongtinca[playerid][16] = CreatePlayerTextDraw(playerid, 473.999908, 337.342254, "Bao Quan");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][16], 0.336398, 1.585065);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][16], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][16], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][16], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][16], 0);

	Thongtinca[playerid][17] = CreatePlayerTextDraw(playerid, 550.399719, 337.342193, "Khoe");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][17], 0.336398, 1.585065);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][17], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][17], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][17], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][17], 0);

	//CA MAP
	Thongtinca[playerid][18] = CreatePlayerTextDraw(playerid, 407.199981, 117.124435, "box");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][18], 0.000000, 28.360034);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][18], 582.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][18], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][18], -1);
	PlayerTextDrawUseBox(playerid, Thongtinca[playerid][18], 1);
	PlayerTextDrawBoxColor(playerid, Thongtinca[playerid][18], -10);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][18], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][18], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][18], 0);

	Thongtinca[playerid][19] = CreatePlayerTextDraw(playerid, 407.200042, 117.324455, "box");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][19], 0.000000, 2.440000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][19], 582.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][19], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][19], -1);
	PlayerTextDrawUseBox(playerid, Thongtinca[playerid][19], 1);
	PlayerTextDrawBoxColor(playerid, Thongtinca[playerid][19], 16777215);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][19], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][19], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][19], 0);

	Thongtinca[playerid][20] = CreatePlayerTextDraw(playerid, 514.000000, 120.808891, "Ca Map");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][20], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][20], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][20], 16711935);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][20], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][20], 0);

	Thongtinca[playerid][21] = CreatePlayerTextDraw(playerid, 438.999908, 165.951232, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][21], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][21], 111.000000, 103.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][21], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][21], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][21], -16711681);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][21], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][21], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][21], 1608);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][21], 0.000000, 0.000000, 90.000000, 1.000000);

	Thongtinca[playerid][22] = CreatePlayerTextDraw(playerid, 546.000061, 275.120056, "Gia : 1,500 SAD");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][22], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][22], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][22], -16776961);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][22], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][22], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][22], 0);

	Thongtinca[playerid][23] = CreatePlayerTextDraw(playerid, 419.399871, 332.208984, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][23], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][23], 64.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][23], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][23], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][23], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][23], 16777215);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][23], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][23], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][23], 1599);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][23], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, Thongtinca[playerid][23], true);

	Thongtinca[playerid][24] = CreatePlayerTextDraw(playerid, 506.200134, 332.209075, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][24], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][24], 64.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][24], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][24], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][24], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][24], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][24], -5963521);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][24], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][24], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][24], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][24], 1599);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][24], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, Thongtinca[playerid][24], true);

	Thongtinca[playerid][25] = CreatePlayerTextDraw(playerid, 473.999908, 337.342254, "Bao Quan");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][25], 0.336398, 1.585065);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][25], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][25], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][25], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][25], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][25], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][25], 0);

	Thongtinca[playerid][26] = CreatePlayerTextDraw(playerid, 550.399719, 337.342193, "Khoe");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][26], 0.336398, 1.585065);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][26], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][26], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][26], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][26], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][26], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][26], 0);

	//ca heo
	Thongtinca[playerid][27] = CreatePlayerTextDraw(playerid, 407.199981, 117.124435, "box");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][27], 0.000000, 28.360034);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][27], 582.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][27], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][27], -1);
	PlayerTextDrawUseBox(playerid, Thongtinca[playerid][27], 1);
	PlayerTextDrawBoxColor(playerid, Thongtinca[playerid][27], -10);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][27], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][27], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][27], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][27], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][27], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][27], 0);

	Thongtinca[playerid][28] = CreatePlayerTextDraw(playerid, 407.200042, 117.324455, "box");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][28], 0.000000, 2.440000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][28], 582.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][28], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][28], -1);
	PlayerTextDrawUseBox(playerid, Thongtinca[playerid][28], 1);
	PlayerTextDrawBoxColor(playerid, Thongtinca[playerid][28], 16777215);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][28], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][28], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][28], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][28], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][28], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][28], 0);

	Thongtinca[playerid][29] = CreatePlayerTextDraw(playerid, 514.000000, 120.808891, "Ca Heo");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][29], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][29], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][29], 16711935);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][29], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][29], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][29], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][29], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][29], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][29], 0);

	Thongtinca[playerid][30] = CreatePlayerTextDraw(playerid, 438.999908, 165.951232, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][30], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][30], 111.000000, 103.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][30], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][30], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][30], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][30], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][30], -16711681);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][30], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][30], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][30], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][30], 1607);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][30], 0.000000, 0.000000, 90.000000, 1.000000);

	Thongtinca[playerid][31] = CreatePlayerTextDraw(playerid, 550.800231, 276.613372, "Gia : 2,000 SAD");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][31], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][31], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][31], -16776961);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][31], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][31], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][31], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][31], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][31], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][31], 0);

	Thongtinca[playerid][32] = CreatePlayerTextDraw(playerid, 419.399871, 332.208984, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][32], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][32], 64.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][32], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][32], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][32], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][32], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][32], 16777215);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][32], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][32], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][32], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][32], 1599);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][32], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, Thongtinca[playerid][32], true);

	Thongtinca[playerid][33] = CreatePlayerTextDraw(playerid, 506.200134, 332.209075, "");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][33], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, Thongtinca[playerid][33], 64.000000, 26.000000);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][33], 1);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][33], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][33], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][33], 0);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][33], -5963521);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][33], 5);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][33], 0);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][33], 0);
	PlayerTextDrawSetPreviewModel(playerid, Thongtinca[playerid][33], 1599);
	PlayerTextDrawSetPreviewRot(playerid, Thongtinca[playerid][33], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid, Thongtinca[playerid][33], true);

	Thongtinca[playerid][34] = CreatePlayerTextDraw(playerid, 473.999908, 337.342254, "Bao Quan");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][34], 0.336398, 1.585065);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][34], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][34], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][34], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][34], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][34], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][34], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][34], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][34], 0);

	Thongtinca[playerid][35] = CreatePlayerTextDraw(playerid, 550.399719, 337.342193, "Khoe");
	PlayerTextDrawLetterSize(playerid, Thongtinca[playerid][35], 0.336398, 1.585065);
	PlayerTextDrawAlignment(playerid, Thongtinca[playerid][35], 3);
	PlayerTextDrawColor(playerid, Thongtinca[playerid][35], -1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][35], 0);
	PlayerTextDrawSetOutline(playerid, Thongtinca[playerid][35], -1);
	PlayerTextDrawBackgroundColor(playerid, Thongtinca[playerid][35], 255);
	PlayerTextDrawFont(playerid, Thongtinca[playerid][35], 1);
	PlayerTextDrawSetProportional(playerid, Thongtinca[playerid][35], 1);
	PlayerTextDrawSetShadow(playerid, Thongtinca[playerid][35], 0);
	
}

IsAtCauCaPoint(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 10, -1483.7195,770.3282,7.1778) || IsPlayerInRangeOfPoint(playerid, 10, -1483.7194,765.9940,7.1778) ||
	IsPlayerInRangeOfPoint(playerid, 10, -1483.7194,761.4071,7.1778) || IsPlayerInRangeOfPoint(playerid, 10, -1483.7194,757.1736,7.1778) ||
	IsPlayerInRangeOfPoint(playerid, 10, -1483.7194,752.7828,7.1778) || IsPlayerInRangeOfPoint(playerid, 10, 396.1335,-2088.7983,7.8359) ||
	IsPlayerInRangeOfPoint(playerid, 10, 391.0315,-2088.7983,7.8359) || IsPlayerInRangeOfPoint(playerid, 10, 383.4200,-2088.7983,7.8359) ||
	IsPlayerInRangeOfPoint(playerid, 10, 374.9158,-2088.7983,7.8359) || IsPlayerInRangeOfPoint(playerid, 10, 369.8153,-2088.7983,7.8359) ||
	IsPlayerInRangeOfPoint(playerid, 10, 367.2509,-2088.7983,7.8359))
	{ return true; }
	return false;
}

ExitThongtinca(playerid) {
		CancelSelectTextDraw(playerid);
		PlayerPlaySound(playerid, 1135, 0,0,0);
		SetPVarInt(playerid, "Thong_Tin_Ca", 0);

        PlayerTextDrawHide(playerid, Thongtinca[playerid][0]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][1]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][2]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][3]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][4]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][5]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][6]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][7]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][8]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][9]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][10]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][11]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][12]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][13]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][14]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][15]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][16]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][17]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][18]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][19]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][20]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][21]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][22]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][23]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][24]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][25]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][26]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][27]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][28]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][29]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][30]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][31]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][32]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][33]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][34]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][35]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][36]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][37]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][38]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][39]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][40]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][41]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][42]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][43]);
		PlayerTextDrawHide(playerid, Thongtinca[playerid][44]);
    	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])    
{
	if(dialogid == BANCA)
 	{
      if(response)
      {
      if(listitem == 0)
      {
      if(PlayerInfo[playerid][pCaChep] >= 1)
      {
      PlayerInfo[playerid][pCaChep] -= 1;
      PlayerInfo[playerid][pCash] += 50;
      SendClientMessageEx(playerid, COLOR_RED, "[SHOP THU MUA CA] Ban Da Ban Con Ca Chep Voi Gia 50 SAD");
      }
      else return SendClientMessageEx(playerid, COLOR_RED, "Ban Khong Co Ca Chep De Ban {ff0000}[!]");
      }
      if(listitem == 1)
      {
      if(PlayerInfo[playerid][pRua] >= 1)
      {
      PlayerInfo[playerid][pRua] -= 1;
      PlayerInfo[playerid][pCash] += 500;
      SendClientMessageEx(playerid, COLOR_RED, "[SHOP THU MUA CA] Ban Da Ban Con Rua Gia 500 SAD");
      }
      else return SendClientMessageEx(playerid, COLOR_RED, "Ban Khong Co Rua De Ban {ff0000}[!]");
      }
      if(listitem == 2)
      {
      if(PlayerInfo[playerid][pCaMap] >= 1)
      {
      PlayerInfo[playerid][pCaMap] -= 1;
      PlayerInfo[playerid][pCash] += 800;
      SendClientMessageEx(playerid, COLOR_RED, "[SHOP THU MUA CA] Ban Da Ban Con Ca Map Voi Gia 800 SAD ");
      }
      else return SendClientMessageEx(playerid, COLOR_RED, "Ban Khong Co Ca Map De Ban {ff0000}[!]");
      }
      if(listitem == 3)
      {
      if(PlayerInfo[playerid][pCaHeo] >= 1)
      {
      PlayerInfo[playerid][pCaHeo] -= 1;
      PlayerInfo[playerid][pCash] += 1000;
      SendClientMessageEx(playerid, COLOR_RED, "[SHOP THU MUA CA] Ban Da Ban Con Ca Heo Sieu Hiem Voi Gia 1000 SAD");
      }
      else return SendClientMessageEx(playerid, COLOR_RED, "Ban Khong Co Ca Heo De Ban {ff0000}[!]");
      }
      }
    }

