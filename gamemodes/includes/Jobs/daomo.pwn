#include <a_samp>
#include <YSI\y_hooks>
#include <a_actor>
#include <sscanf2>


new NPCSELLDAOMO;
new JOBDAOMO;
new DangDaoMo[MAX_PLAYERS];

hook OnGameModeInit()
{
	g_mysql_Init();
	CreateDynamic3DTextLabel("[Cong Viec Dao Mo]\n{FFFFFF}((  Nhan {FFFD00}[Y]{FFFFFF} De Tuong Tac NPC  ))",COLOR_YELLOW,823.93,-1099.10,25.78+0.5,4.0);//
	CreateDynamic3DTextLabel("[NPC Sell Dung Cu]\n{FFFFFF}((  Nhan {FFFD00}[Y]{FFFFFF} De Tuong Tac NPC  ))",COLOR_YELLOW,823.88,-1107.93,25.78+0.5,4.0);//
	NPCSELLDAOMO = CreateActor(2, 1810.4712,823.88,-1107.93,25.78);
    JOBDAOMO = CreateActor(2, 1810.4712,823.93,-1099.10,25.78);
	return 1;
}


CMD:daomo(playerid, params[]){
    if(PlayerInfo[playerid][pJob] != 39 && PlayerInfo[playerid][pJob2] != 39) return SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong phai la nguoi dao mo!");
    if(PlayerInfo[playerid][pSanDaoMo] == 1) return SendClientMessageEx(playerid, COLOR_WHITE, "Ban can co san de dao mo!");
    if(GetPlayerState(playerid) == 1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 4, 843.49, -1110.97, 24.18) || IsPlayerInRangeOfPoint(playerid, 30, -474.7479,-139.0629,76.7397) || IsPlayerInRangeOfPoint(playerid, 30, -545.8476,-18.1437,67.3524))
		{
		    if(DangDaoMo[playerid] == 0)
		    {
         	    SetTimerEx("DangDaoMo", 8500, 0, "d", playerid);
 	        	SetPVarInt(playerid, "DangDaoMo", 1);
                 TogglePlayerControllable(playerid,0);
 	        	ApplyAnimation(playerid, "SWORD", "sword_4", 4.0, 1, 0, 0, 0, 0, 1);
                 DangDaoMo[playerid] = 10000;
    	 		SetPlayerAttachedObject(playerid, 0, 18634, 6, 0.108999, 0.0310000, 0.083999, 109.300000, -81.700000, 6.800010, 1.000000, 1.000000, 1.000000, 0, 0);
			}
			else
			{
				SendClientMessageEx(playerid, COLOR_GREY, "Ban dang khai thac.");
				return 1;
			}
			return 1;
		}
		else
		{
			SendClientMessageEx(playerid, COLOR_GREY, "Ban khong o noi dao mo");
		}
		return 1;
	}
	else
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Ban khong the lam dieu nay tren xe.");
	}
	return 1;
}

CMD:muadungcu(playerid, params)
{
    if(IsPlayerInRangeOfActor(playerid, NPCSELLDUNGCU))
    {
        ShowPlayerDialog(playerid,SELLDUNGCU, DIALOG_STYLE_LIST, "Ban dung cu", "San?(5000$)", "Mua","Thoat");
        return 1;
    }
}

forward DangDaoMo(playerid);
public DangDaoMo(playerid)
{

    ClearAnimations(playerid);
    TogglePlayerControllable(playerid,1);
	new string[128];
	RemovePlayerAttachedObject(playerid, 0);
	new daomo = Random(1,15);
	switch(daomo)
	{
	    case 1..5
	    {
	        PlayerInfo[playerid][pCash] += 5000;
	        format(string, sizeof(string), "Ban vua dao duoc 5000$!");
			SendClientMessageEx(playerid, COLOR_WHITE, string);
	    }
	    case 6..8
	    {
	        PlayerInfo[playerid][pVang] += 1;
	        format(string, sizeof(string), "Ban vua dao duoc 1 vang!");
			SendClientMessageEx(playerid, COLOR_WHITE, string);
	    }
	    case 9..13
	    {
	        PlayerInfo[playerid][pRac] += 1;
	        format(string, sizeof(string), "Ban vua dao duoc 1 bit rac!");
			SendClientMessageEx(playerid, COLOR_WHITE, string);
	    }
	    case 14..15
	    {
	        PlayerInfo[playerid][pKimCuong] += 1;
	        format(string, sizeof(string), "Ban vua dao duoc 1 kim cuong");
			SendClientMessageEx(playerid, COLOR_WHITE, string);
	    }
	}
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == SELLDUNGCU)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            if(PlayerInfo[playerid][pCash] == 5000) return SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong du 5000$ de mua san!");
	            {
	                PlayerInfo[playerid][pCash] -= 5000;
	                PlayerInfo[playerid][pSanDaoMo] +=1;
	                SendClientMessageEx(playerid, COLOR_WHITE, "Ban vua mua 1 san voi gia 50000$");
	            }
	        }
	    }
	}
	if(dialogid == Job_DaoMo) // xin viec
    {
        if(response)
        {
            if(listitem == 0) //Xin viec
		    {
   			if(PlayerInfo[playerid][pLevel] >= 1)
			{
		    	if(PlayerInfo[playerid][pJob] == 0)
            	{
		        	GettingJob[playerid] = 39;
                	PlayerInfo[playerid][pJob] = GettingJob[playerid];
                	SendClientMessageEx(playerid, COLOR_YELLOW, "Ban Da Xin Viec Dao Mo Thanh Cong");
                }
                else return SendClientMessageEx(playerid, COLOR_YELLOW, "Ban Dang Co Cong Viec Vui Long Thoat Viec De Xin Viec Tiep!");
			}
			else return SendClientMessageEx(playerid, COLOR_GREY, "Ban phai dat it nhat level 1 moi co the tro thanh Khai Thac");
		}
			if(listitem == 1) //xinviec phu
		    {
   			if(PlayerInfo[playerid][pLevel] >= 1)
			{
			if((PlayerInfo[playerid][pDonateRank] > 0 || PlayerInfo[playerid][pFamed] > 0) && PlayerInfo[playerid][pJob2] == 0) {
			if(PlayerInfo[playerid][pDonateRank] == 0){
            SendClientMessageEx(playerid, COLOR_YELLOW, "Chi VIP/Famed moi co the nhan duoc hai cong viec!");
		        }
		        	GettingJob[playerid] = 39;
                	PlayerInfo[playerid][pJob] = GettingJob[playerid];
                	SendClientMessageEx(playerid, COLOR_YELLOW, "Ban Da Xin Viec Dao Mo Thanh Cong");
                }
                else return SendClientMessageEx(playerid, COLOR_YELLOW, "Ban da co cong viec phu hoac khong co Vip/Famed de co the nhan cong viec phu");
			}
			else return SendClientMessageEx(playerid, COLOR_GREY, "Ban phai dat it nhat level 2 moi co the tro thanh Ngu Dan");
		}
			if(listitem == 2) // Nghi viec 1
		    {
                //PlayerInfo[playerid][pJob] = 0;
                return cmd_quitjob(playerid, "1");
			}
			if(listitem == 3) // Nghi viec 2
		    {
                //PlayerInfo[playerid][pJob2] = 0;
                return cmd_quitjob(playerid, "2");
			}
        }
    }
	if(dialogid == SELLDAOMO)
	{
	    if(response)
	    {
	        if(listitem == 0)
	        {
	            if(PlayerInfo[playerid][pRac] == 1) return SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong co bit rac nao ca!");
	            {
	                PlayerInfo[playerid][pCash] += 3;
	                PlayerInfo[playerid][pRac] -= 1;
	                SendClientMessageEx(playerid, COLOR_WHITE, "Ban da ban thanh con 1 bit rac voi gia 3$!");
	            }
	        }
	        if(listitem == 1)
	        {
	            if(PlayerInfo[playerid][pVang] == 1) return SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong co vabg nao ca!");
	            {
	                PlayerInfo[playerid][pCash] += 5000;
	                PlayerInfo[playerid][pVang] -= 1;
	                SendClientMessageEx(playerid, COLOR_WHITE, "Ban da ban thanh cong 1 cuc vang voi gia 5000$!");
	            }
	        }
	        if(listitem == 2)
	        {
	            if(PlayerInfo[playerid][pKimCuong] == 1) return SendClientMessageEx(playerid, COLOR_WHITE, "Ban khong co kim cuong nao ca!");
	            {
	                PlayerInfo[playerid][pCash] += 100000;
	                PlayerInfo[playerid][pKimCuong] -= 1;
	                SendClientMessageEx(playerid, COLOR_WHITE, "Ban da ban thanh cong 1 cuc kim cuong voi gia 100000$!");
	            }
	        }
	    }
	}
	return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_YES)
    {
        if(!IsPlayerInRangeOfActor(playerid, NPCSELLDAOMO))
        {
         ShowPlayerDialog(playerid, SELLDAOMO, DIALOG_STYLE_LIST,"Menu Sell","Bit rac(3$)\nVang(5000$)\nKim Cuong(100000$)","Ban", "Thoat");
         return 1;
        }
    }
    if(newkeys & KEY_YES) 
    {
	new Float:PosXACtor, Float:PosYACtor, Float:PosZACtor;
        GetActorPos(JOBDAOMO, PosXACtor, PosYACtor, PosZACtor);
        if(IsPlayerInRangeOfPoint(playerid, 2.0, PosXACtor, PosYACtor, PosZACtor))
        {
            if(PlayerInfo[playerid][pJob] != 39 && PlayerInfo[playerid][pJob2] != 39)
            {
       			ShowPlayerDialog(playerid, Job_DaoMo, DIALOG_STYLE_LIST, "Cong Viec Dao Mo", "Xin Viec Chinh\nXin Viec Phu\nTu bo cong viec 1\nTu bo cong viec 2", "Chon", "Huy");
				return 1;
			}
			else
			{
			    ShowPlayerDialog(playerid, Job_DaoMo, DIALOG_STYLE_LIST, "Cong Viec Dao Mo", "Xin Viec Chinh\nXin Viec Phu\nTu bo cong viec 1\nTu bo cong viec 2", "Chon", "Huy");
			}
			return 0;
        }
    }
    return 1;
}
