#include <YSI\y_hooks>

//------------------- Thoi Gian -------------------------
#define COUNT_BC_WAIT 15 // Thoi Gian Cho`
#define COUNT_BC_TRIBUTE 30 // Thoi Gian Mo Bai
#define COUNT_BC_SORT 15 // Thoi Gian Sap Xep Bai
#define DIALOG_SHOW_WINNER 9123
//-------------------------------------------------------
#define Function:%0(%1) forward %0(%1); public %0(%1)

hook OnGameModeInit()
{
	SettingsBCInfo();
	return 1;
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == SHOWLIST_BC)
    {
        if(!response) return 1;
        new bcid = listitem;
        JoinBCForPlayer(playerid,bcid);
    }
    return 1;
}

hook OnPlayerConnect(playerid)
{
    SettingsPlayerBC(playerid);
    return 1;
}

Function:FinishTribute(bcid)
{
    BCInfo[bcid][bc_Status] = STATUS_BC_SORT;
    BCInfo[bcid][bc_Count] = COUNT_BC_SORT;
    ResetPointBC(bcid);
    for(new b = 7; b < 19; b++)
    {
        BCTextDrawSetString(bcid, b, "ld_card:cdback");
    }
    HidePointFor(bcid);
    BCInfo[bcid][bc_Timer] = SetTimerEx("TimerBCInfo", 1000, true, "i", bcid);
    KickPointMoney(bcid);
    return 1;
}

Function:TimerBCInfo(bcid)
{
    new countstring[32],countstring2[128];
    format(countstring, sizeof(countstring), "%dS", BCInfo[bcid][bc_Count]);

    if(BCInfo[bcid][bc_Count] > -1)
    {
        if(BCInfo[bcid][bc_Player] >= 2)
        {
            BCInfo[bcid][bc_Count]--;
            for(new b = 0; b < MAX_PLAYER_BC; b++)
            {
                if(BCInfo[bcid][bc_Players][b] != INVALID_PLAYER_ID)
                {
                    new player = BCInfo[bcid][bc_Players][b];
                    PlayerTextDrawSetString(player, BAICAO_TDE[player][6], countstring);
                    if(BCInfo[bcid][bc_Status] == STATUS_BC_WAIT) countstring2 = "Thoi Gian Cho";
                    else if(BCInfo[bcid][bc_Status] == STATUS_BC_TRIBUTE) countstring2 = "Hay Kiem Tra Bai";
                    else if(BCInfo[bcid][bc_Status] == STATUS_BC_SORT) countstring2 = "Dang Tinh Diem";
                    PlayerTextDrawSetString(player, BAICAO_TDE[player][5], countstring2);
                }
            }
        }
        else 
        {
            BCInfo[bcid][bc_Status] = STATUS_BC_WAIT;
            BCInfo[bcid][bc_Count] = COUNT_BC_WAIT;
            BCTextDrawSetString(bcid, 6, "30S");
            BCTextDrawSetString(bcid, 5, "Thoi Gian Cho");
        }
    }
    //else if(BCInfo[bcid][bc_Count] == 0)
    else
    {
        if(BCInfo[bcid][bc_Player] >= 2)
        {
            /* WAIT > TRIBUTE > SORT */
            if(BCInfo[bcid][bc_Status] == STATUS_BC_WAIT)
            {
                BCInfo[bcid][bc_Status] = STATUS_BC_TRIBUTE;
                BCInfo[bcid][bc_Count] = COUNT_BC_TRIBUTE;
                ResetPointBC(bcid);
                for(new b = 7; b < 19; b++)
                {
                    BCTextDrawSetString(bcid, b, "ld_card:cdback");
                }
            }
            else if(BCInfo[bcid][bc_Status] == STATUS_BC_TRIBUTE)
            {
                KillTimer(BCInfo[bcid][bc_Timer]);
                CheckingForPoint(bcid); //Kiem tra coi co th nao ko do? bai` ko
                SortForPoint(bcid); // Sap xem diem Player
                GiveSortForPoint(bcid);
                SetTimerEx("FinishTribute", 8500, false, "i", bcid);
            }
            else if(BCInfo[bcid][bc_Status] == STATUS_BC_SORT)
            {
                BCInfo[bcid][bc_Status] = STATUS_BC_WAIT;
                BCInfo[bcid][bc_Count] = COUNT_BC_WAIT;
                ResetPointBC(bcid);
                for(new b = 7; b < 19; b++)
                {
                    BCTextDrawSetString(bcid, b, "ld_card:cdback");
                }
            }
        }
        else 
        {
            BCInfo[bcid][bc_Status] = STATUS_BC_WAIT;
            BCInfo[bcid][bc_Count] = COUNT_BC_WAIT;
            BCTextDrawSetString(bcid, 6, "30S");
            BCTextDrawSetString(bcid, 6, "Thoi Gian Cho");
        }
    }
    return 1;
}

Function:KickPointMoney(bcid)
{
    for(new b = 0; b < MAX_PLAYER_BC; b++)
    {
        if(BCInfo[bcid][bc_Players][b] != INVALID_PLAYER_ID)
        {
            new Player = BCInfo[bcid][bc_Players][b];
            if(GetPlayerCash(Player) < BCInfo[bcid][bc_Money])
            {
                QuitBCForPlayer(Player, bcid);
                SendClientMessage(Player, COLOR_GRAD2, "[!]: Ban bi duoi ra khoi song bai cao vi khong con du tien");
            }
        }
    }
    return 1;
}

stock MsgBC(bcid, color, message[])
{
    for(new b = 0; b < MAX_PLAYER_BC; b++)
    {
        if(BCInfo[bcid][bc_Players][b] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][b];
            SendClientMessage(player, color, message);
        }
    }
    return 1;
}

Function:FindCountDown(bcid, maxpoint)
{
    new tempstring[255], count = 0, playerz[MAX_PLAYER_BC] = INVALID_PLAYER_ID;
    for(new b = 0; b < MAX_PLAYER_BC; b++) 
    {
        if(BCInfo[bcid][bc_Players][b] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][b];
            if(PlayerBC[player][pBC_Point] >= maxpoint)
            {
                playerz[b] = player;
                count += 1;
            }
        }
    }
    new players = BCInfo[bcid][bc_Player] - 1;
    new moneyz = BCInfo[bcid][bc_Money]*players;
    if(count < 2)
    {
        for(new p = 0; p < MAX_PLAYER_BC; p++)
        {
            if(playerz[p] != INVALID_PLAYER_ID)
            {
                GivePlayerCash(playerz[p], moneyz);
                format(tempstring, sizeof(tempstring), "{FF0033}[BCID]{FFFFFF}: {33CCFF}%s{FFFFFF} {66FF99}+ %d$ (Cool)", GetPlayerNameEx(playerz[p]),moneyz);
                MsgBC(bcid, -1, tempstring);
                UpdateBCIDForTeam(bcid, PlayerBC[playerz[p]][pBC_Slot]);
                break;
            }
        }
    }
    return 1;
}

stock GiveSortForPoint(bcid)
{
    new resultbc[MAX_PLAYER_BC],resultplayer[MAX_PLAYER_BC];
    for(new a = 0; a < MAX_PLAYER_BC; a++)
    {
        if(BCInfo[bcid][bc_Players][a] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][a];
            resultbc[a] = PlayerBC[player][pBC_Point];
            resultplayer[a] = player;
        }
    }
    SortBC(resultbc, sizeof(resultbc));
    new tempstring[255],stringbc[255];
    for(new b = 0; b < MAX_PLAYER_BC; b++)
    {
        if(BCInfo[bcid][bc_Players][b] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][b];
            if(PlayerBC[player][pBC_Point] >= resultbc[0])
            {
                SetTimerEx("FindCountDown", 1000, false, "ii", bcid,resultbc[0]);
                /*if(count == 1)
                {
                    new players = BCInfo[bcid][bc_Player] - 1;
                    new moneyz = BCInfo[bcid][bc_Money]*players;
                    GivePlayerCash(player, moneyz);
                    format(tempstring, sizeof(tempstring), "{FF0033}[BCID]{FFFFFF}: {33CCFF}%s{FFFFFF} {66FF99}+ %d$ (Cool)", GetPlayerNameEx(player),moneyz);
                    MsgBC(bcid, -1, tempstring);
                    UpdateBCIDForTeam(bcid, PlayerBC[player][pBC_Slot]);
                }
                else if(count > 1)
                {
                    new players = BCInfo[bcid][bc_Player] - count;
                    new moneyz = BCInfo[bcid][bc_Money]*players;
                    GivePlayerCash(player, moneyz);
                    format(tempstring, sizeof(tempstring), "{FF0033}[BCID]{FFFFFF}: {33CCFF}%s{FFFFFF} {66FF99}+ %d$ (Cool =)", GetPlayerNameEx(player),moneyz);
                    MsgBC(bcid, -1, tempstring);
                    UpdateBCIDForTeam(bcid, PlayerBC[player][pBC_Slot]);
                }*/
            }
            else if(PlayerBC[player][pBC_Point] < resultbc[0])
            {
                GivePlayerCash(player, -BCInfo[bcid][bc_Money]);
                format(tempstring, sizeof(tempstring), "{FF0033}[BCID]{FFFFFF}: {33CCFF}%s{FFFFFF} {66FF99}- %d$ (Ohm)", GetPlayerNameEx(player),BCInfo[bcid][bc_Money]);
                MsgBC(bcid, -1, tempstring);
                UpdateBCIDForTeam(bcid, PlayerBC[player][pBC_Slot]);
                format(tempstring, sizeof(tempstring), "%d Diem", PlayerBC[player][pBC_Point]);
            }
            format(stringbc, sizeof(stringbc), "%s\n\t%s\t%d Diem", stringbc,GetPlayerNameEx(player),PlayerBC[player][pBC_Point]);
        }
    }
    ShowKetQuaBC(bcid, stringbc);
    return 1;
}

stock ShowKetQuaBC(bcid, stig[])
{
    for(new k = 0; k < MAX_PLAYER_BC; k++)
    {
        if(BCInfo[bcid][bc_Players][k] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][k];
            ShowPlayerDialog(player, 500, DIALOG_STYLE_MSGBOX, "Ket qua diem bai cao", stig, "Ok", "");
        }
    }
    return 1;
}

stock SortBC(a[], size)
{
    new temp;
    for(new l = 0; l < size; l++)
    {
        for(new z = l + 1; z < size; z++)
        {
            if(a[z] > a[l])
            {
                temp = a[z];
                a[z] = a[l];
                a[l] = temp;
            }
        }
    }
}

stock SortForPoint(bcid)
{
    new tempz[200];
    for(new a = 0; a < MAX_PLAYER_BC; a++)
    {
        if(BCInfo[bcid][bc_Players][a] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][a];
            new fullpointslot = PlayerBC[player][pBC_Card][0] + PlayerBC[player][pBC_Card][1] + PlayerBC[player][pBC_Card][2];
            PlayerBC[player][pBC_Point] = fullpointslot;
            
            if(PlayerBC[player][pBC_Point] >= 10 && PlayerBC[player][pBC_Point] <= 19) PlayerBC[player][pBC_Point] -= 10;
            else if(PlayerBC[player][pBC_Point] >= 20 && PlayerBC[player][pBC_Point] <= 29) PlayerBC[player][pBC_Point] -= 20;
            format(tempz, sizeof(tempz), "%d Diem", PlayerBC[player][pBC_Point]);
            ShowPointFor(bcid, PlayerBC[player][pBC_Slot], tempz);
        }
    }
    return 1;
}

stock CheckingForPoint(bcid)
{
    for(new B = 0; B < MAX_PLAYER_BC; B++)
    {
        if(BCInfo[bcid][bc_Players][B] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][B];
            if(PlayerBC[player][pBC_Slot] == 0)
            {
                for(new b = 0; b < 3; b++)
                {
                    if(PlayerBC[player][pBC_Card][b] == 0)
                    {
                        if(b == 0) PointRandom(player, 7);
                        else if(b == 1) PointRandom(player, 8);
                        else if(b == 2) PointRandom(player, 9);
                    }
                }
            }
            else if(PlayerBC[player][pBC_Slot] == 1)
            {
                for(new b = 0; b < 3; b++)
                {
                    if(PlayerBC[player][pBC_Card][b] == 0)
                    {
                        if(b == 0) PointRandom(player, 10);
                        else if(b == 1) PointRandom(player, 11);
                        else if(b == 2) PointRandom(player, 12);
                    }
                }
            }
            else if(PlayerBC[player][pBC_Slot] == 0)
            {
                for(new b = 0; b < 3; b++)
                {
                    if(PlayerBC[player][pBC_Card][b] == 0)
                    {
                        if(b == 0) PointRandom(player, 13);
                        else if(b == 1) PointRandom(player, 14);
                        else if(b == 2) PointRandom(player, 15);
                    }
                }
            }
            else if(PlayerBC[player][pBC_Slot] == 0)
            {
                for(new b = 0; b < 3; b++)
                {
                    if(PlayerBC[player][pBC_Card][b] == 0)
                    {
                        if(b == 0) PointRandom(player, 16);
                        else if(b == 1) PointRandom(player, 17);
                        else if(b == 2) PointRandom(player, 18);
                    }
                }
            }
        }
    }
    return 1;
}

stock ResetPointBC(bcid)
{
    for(new b = 0; b < MAX_PLAYER_BC; b++)
    {
        if(BCInfo[bcid][bc_Players][b] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][b];
            PlayerBC[player][pBC_Card][0] = 0;
            PlayerBC[player][pBC_Card][1] = 0;
            PlayerBC[player][pBC_Card][2] = 0;
            PlayerBC[player][pBC_Point] = 0;
        }
    }
    return 1;
}

stock CreatePlayerBC(playerid)
{
    BAICAO_TDE[playerid][0] = CreatePlayerTextDraw(playerid, 264.231201, 33.083347, "Neex#0_(60$)");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][0], 0.211182, 1.045830);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][0], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][0], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][0], -1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][0], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][0], 0);

    BAICAO_TDE[playerid][1] = CreatePlayerTextDraw(playerid, 103.997100, 124.083328, "Connor_Adonis_(6000000000$)");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][1], 0.214931, 1.104164);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][1], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][1], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][1], -1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][1], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][1], 0);

    BAICAO_TDE[playerid][2] = CreatePlayerTextDraw(playerid, 412.752990, 120.000007, "Connor_Adonis_(6000000000$)");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][2], 0.207434, 1.045830);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][2], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][2], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][2], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][2], 0);

    BAICAO_TDE[playerid][3] = CreatePlayerTextDraw(playerid, 245.490509, 183.583389, "Connor_Adonis_(60000000000000$)");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][3], 0.177917, 1.109997);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][3], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][3], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][3], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][3], 0);

    BAICAO_TDE[playerid][4] = CreatePlayerTextDraw(playerid, 217.379165, 105.416687, "box");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][4], 0.000000, 7.235724);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][4], 388.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][4], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, BAICAO_TDE[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, BAICAO_TDE[playerid][4], 93);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][4], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][4], 0);

    BAICAO_TDE[playerid][5] = CreatePlayerTextDraw(playerid, 257.203369, 109.500007, "THOI_GIAN_CHO");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][5], 0.324097, 1.419165);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][5], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][5], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][5], 1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][5], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][5], 3);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][5], 0);

    BAICAO_TDE[playerid][6] = CreatePlayerTextDraw(playerid, 281.566558, 126.416648, "30s");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][6], 0.396250, 1.909167);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][6], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][6], -1378294017);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][6], 1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][6], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][6], 3);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][6], 0);

    BAICAO_TDE[playerid][7] = CreatePlayerTextDraw(playerid, 230.797882, 47.666656, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][7], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][7], 35.000000, 45.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][7], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][7], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][7], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][7], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][7], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][7], false);

    BAICAO_TDE[playerid][8] = CreatePlayerTextDraw(playerid, 273.901916, 47.666664, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][8], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][8], 35.000000, 45.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][8], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][8], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][8], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][8], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][8], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][8], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][8], false);

    BAICAO_TDE[playerid][9] = CreatePlayerTextDraw(playerid, 319.817199, 47.666667, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][9], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][9], 35.000000, 45.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][9], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][9], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][9], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][9], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][9], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][9], false);

    BAICAO_TDE[playerid][10] = CreatePlayerTextDraw(playerid, 92.115936, 137.500000, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][10], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][10], 35.000000, 46.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][10], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][10], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][10], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][10], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][10], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][10], false);

    BAICAO_TDE[playerid][11] = CreatePlayerTextDraw(playerid, 133.345794, 136.916687, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][11], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][11], 35.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][11], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][11], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][11], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][11], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][11], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][11], false);

    BAICAO_TDE[playerid][12] = CreatePlayerTextDraw(playerid, 174.575653, 136.333343, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][12], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][12], 35.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][12], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][12], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][12], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][12], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][12], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][12], false);

    BAICAO_TDE[playerid][13] = CreatePlayerTextDraw(playerid, 394.312011, 134.583343, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][13], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][13], 35.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][13], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][13], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][13], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][13], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][13], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][13], false);

    BAICAO_TDE[playerid][14] = CreatePlayerTextDraw(playerid, 435.542022, 134.000030, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][14], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][14], 35.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][14], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][14], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][14], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][14], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][14], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][14], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][14], false);

    BAICAO_TDE[playerid][15] = CreatePlayerTextDraw(playerid, 477.709014, 134.583358, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][15], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][15], 35.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][15], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][15], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][15], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][15], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][15], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][15], false);

    BAICAO_TDE[playerid][16] = CreatePlayerTextDraw(playerid, 229.861160, 197.583374, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][16], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][16], 35.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][16], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][16], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][16], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][16], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][16], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][16], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][16], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][16], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][16], false);

    BAICAO_TDE[playerid][17] = CreatePlayerTextDraw(playerid, 276.713195, 197.583404, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][17], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][17], 35.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][17], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][17], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][17], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][17], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][17], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][17], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][17], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][17], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][17], false);

    BAICAO_TDE[playerid][18] = CreatePlayerTextDraw(playerid, 323.565307, 197.583374, "ld_card:cdback");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE[playerid][18], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE[playerid][18], 35.000000, 47.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE[playerid][18], 1);
    PlayerTextDrawColor(playerid, BAICAO_TDE[playerid][18], -1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][18], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE[playerid][18], 0);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE[playerid][18], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE[playerid][18], 4);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE[playerid][18], 0);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE[playerid][18], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][18], false);

    BAICAO_TDE_NEW[playerid][0] = CreatePlayerTextDraw(playerid, 294.685150, 62.833335, "0 Diem");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE_NEW[playerid][0], 0.400000, 1.600000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE_NEW[playerid][0], 0.000000, 66.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE_NEW[playerid][0], 2);
    PlayerTextDrawColor(playerid, BAICAO_TDE_NEW[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, BAICAO_TDE_NEW[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, BAICAO_TDE_NEW[playerid][0], 56);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE_NEW[playerid][0], 1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE_NEW[playerid][0], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE_NEW[playerid][0], 3);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE_NEW[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][0], 0);

    BAICAO_TDE_NEW[playerid][1] = CreatePlayerTextDraw(playerid, 147.569488, 152.083374, "0 Diem");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE_NEW[playerid][1], 0.400000, 1.600000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE_NEW[playerid][1], 0.000000, 66.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE_NEW[playerid][1], 2);
    PlayerTextDrawColor(playerid, BAICAO_TDE_NEW[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, BAICAO_TDE_NEW[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, BAICAO_TDE_NEW[playerid][1], 56);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE_NEW[playerid][1], 1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE_NEW[playerid][1], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE_NEW[playerid][1], 3);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE_NEW[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][1], 0);

    BAICAO_TDE_NEW[playerid][2] = CreatePlayerTextDraw(playerid, 453.045501, 150.333389, "0 Diem");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE_NEW[playerid][2], 0.400000, 1.600000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE_NEW[playerid][2], 0.000000, 66.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE_NEW[playerid][2], 2);
    PlayerTextDrawColor(playerid, BAICAO_TDE_NEW[playerid][2], -1);
    PlayerTextDrawUseBox(playerid, BAICAO_TDE_NEW[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid, BAICAO_TDE_NEW[playerid][2], 56);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE_NEW[playerid][2], 1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE_NEW[playerid][2], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE_NEW[playerid][2], 3);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE_NEW[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][2], 0);

    BAICAO_TDE_NEW[playerid][3] = CreatePlayerTextDraw(playerid, 296.090789, 214.500030, "0 Diem");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE_NEW[playerid][3], 0.400000, 1.600000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE_NEW[playerid][3], 0.000000, 66.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE_NEW[playerid][3], 2);
    PlayerTextDrawColor(playerid, BAICAO_TDE_NEW[playerid][3], -1);
    PlayerTextDrawUseBox(playerid, BAICAO_TDE_NEW[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, BAICAO_TDE_NEW[playerid][3], 56);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE_NEW[playerid][3], 1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE_NEW[playerid][3], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE_NEW[playerid][3], 3);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE_NEW[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][3], 0);

    BAICAO_TDE_NEW[playerid][4] = CreatePlayerTextDraw(playerid, 501.303649, 295.000061, "Thoat");
    PlayerTextDrawLetterSize(playerid, BAICAO_TDE_NEW[playerid][4], 0.400000, 1.600000);
    PlayerTextDrawTextSize(playerid, BAICAO_TDE_NEW[playerid][4], 20.000000, 71.000000);
    PlayerTextDrawAlignment(playerid, BAICAO_TDE_NEW[playerid][4], 2);
    PlayerTextDrawColor(playerid, BAICAO_TDE_NEW[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, BAICAO_TDE_NEW[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, BAICAO_TDE_NEW[playerid][4], 113);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, BAICAO_TDE_NEW[playerid][4], 1);
    PlayerTextDrawBackgroundColor(playerid, BAICAO_TDE_NEW[playerid][4], 255);
    PlayerTextDrawFont(playerid, BAICAO_TDE_NEW[playerid][4], 3);
    PlayerTextDrawSetProportional(playerid, BAICAO_TDE_NEW[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, BAICAO_TDE_NEW[playerid][4], 0);
    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE_NEW[playerid][4], true);
    return 1;
}

stock randomEx(min, max)
{    
    //Credits to ******    
    new rand = random(max-min)+min;    
    return rand;
}

stock BCTextDrawSetString(bcid, slot, stringz[])
{
    for(new q = 0; q < MAX_PLAYER_BC; q++)
    {
        if(BCInfo[bcid][bc_Players][q] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][q];
            PlayerTextDrawSetString(player, BAICAO_TDE[player][slot], stringz);
        }
    }
    return 1;
}

stock PointRandom(playerid, slot)
{
    new randz = randomEx(1,9),tempstring[255],bcid = PlayerBC[playerid][pBC_ID];
    if(slot == 7 || slot == 10 || slot == 13 || slot == 16)
    {
        if(PlayerBC[playerid][pBC_Card][0] == 0)
        {
            PlayerBC[playerid][pBC_Card][0] = randz;
            format(tempstring, sizeof(tempstring), "%s", DeckBCTextDraw[randz]);
            PlayerTextDrawSetString(playerid, BAICAO_TDE[playerid][slot], tempstring);
            BCTextDrawSetString(bcid, slot, tempstring);
            //format(tempstring, sizeof(tempstring), "Slot 0 %d", randz);
            //SendClientMessage(playerid, -1, tempstring);
        }
    }
    if(slot == 8 || slot == 11 || slot == 14 || slot == 17)
    {
        if(PlayerBC[playerid][pBC_Card][1] == 0)
        {
            PlayerBC[playerid][pBC_Card][1] = randz;
            format(tempstring, sizeof(tempstring), "%s", DeckBCTextDraw[randz]);
            PlayerTextDrawSetString(playerid, BAICAO_TDE[playerid][slot], tempstring);
            BCTextDrawSetString(bcid, slot, tempstring);
            //format(tempstring, sizeof(tempstring), "Slot 1 %d", randz);
            //SendClientMessage(playerid, -1, tempstring);
        }
    }
    if(slot == 9 || slot == 12 || slot == 15 || slot == 18)
    {
        if(PlayerBC[playerid][pBC_Card][2] == 0)
        {
            PlayerBC[playerid][pBC_Card][2] = randz;
            format(tempstring, sizeof(tempstring), "%s", DeckBCTextDraw[randz]);
            PlayerTextDrawSetString(playerid, BAICAO_TDE[playerid][slot], tempstring);
            BCTextDrawSetString(bcid, slot, tempstring);
            //format(tempstring, sizeof(tempstring), "Slot 2 %d", randz);
            //SendClientMessage(playerid, -1, tempstring);
        }
    }
    return 1;
}

stock SettingsBCInfo()
{
    for(new o = 0; o < MAX_BAICAO; o++)
    {
        BCInfo[o][bc_Players][0] = INVALID_PLAYER_ID;
        BCInfo[o][bc_Players][1] = INVALID_PLAYER_ID;
        BCInfo[o][bc_Players][2] = INVALID_PLAYER_ID;
        BCInfo[o][bc_Players][3] = INVALID_PLAYER_ID;
        BCInfo[o][bc_Status] = STATUS_BC_WAIT;
        BCInfo[o][bc_Player] = 0;
        BCInfo[o][bc_Count] = COUNT_BC_WAIT;
        KillTimer(BCInfo[o][bc_Timer]);
        BCInfo[o][bc_Timer] = SetTimerEx("TimerBCInfo", 1000, true, "i", o);
    }
    BCInfo[0][bc_Money] = 100000;
    BCInfo[1][bc_Money] = 200000;
    BCInfo[2][bc_Money] = 300000;
    BCInfo[3][bc_Money] = 400000;
    BCInfo[4][bc_Money] = 500000;
    BCInfo[5][bc_Money] = 100000;
    BCInfo[6][bc_Money] = 200000;
    BCInfo[7][bc_Money] = 300000;
    BCInfo[8][bc_Money] = 400000;
    BCInfo[9][bc_Money] = 500000;
    return 1;
}

stock SettingsPlayerBC(playerid)
{
    PlayerBC[playerid][pBC_ID] = -1;
    PlayerBC[playerid][pBC_Slot] = -1;
    PlayerBC[playerid][pBC_Card][0] = 0;
    PlayerBC[playerid][pBC_Card][1] = 0;
    PlayerBC[playerid][pBC_Card][2] = 0;
    PlayerBC[playerid][pBC_Point] = 0;
    return 1;
}

stock ShowListBCForPlayer(playerid)
{
    new szStrong[1028];
    for(new j = 0; j < MAX_BAICAO; j++)
    {
        format(szStrong, sizeof(szStrong), "%s\n%d. %d Money (%d/4)", szStrong,j,BCInfo[j][bc_Money],BCInfo[j][bc_Player]);
    }
    ShowPlayerDialog(playerid, SHOWLIST_BC, DIALOG_STYLE_LIST, "Lua chon phong", szStrong, "Select", "Cancel");
    return 1;
}

stock GetFreeSlotBC(bcid)
{
    new slot = -1;
    for(new p = 0; p < MAX_PLAYER_BC; p++)
    {
        if(BCInfo[bcid][bc_Players][p] == INVALID_PLAYER_ID)
        {
            slot = p;
            return slot;
        }
    }
    return -1;
}

stock ShowPointFor(bcid, slot, stringz[])
{
    for(new q = 0; q < MAX_PLAYER_BC; q++)
    {
        if(BCInfo[bcid][bc_Players][q] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][q];
            PlayerTextDrawShow(player, BAICAO_TDE_NEW[player][slot]);
            PlayerTextDrawSetString(player, BAICAO_TDE_NEW[player][slot], stringz);
        }
    }
    return 1;
}

stock HidePointFor(bcid)
{
    for(new p = 0; p < MAX_PLAYER_BC; p++)
    {
        if(BCInfo[bcid][bc_Players][p] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][p];
            for(new z = 0; z < MAX_PLAYER_BC; z++)
            {
                PlayerTextDrawHide(player, BAICAO_TDE_NEW[player][z]);
            }
        }
    }
    return 1;
}

stock HidePointForSlot(bcid, slot)
{
    for(new q = 0; q < MAX_PLAYER_BC; q++)
    {
        if(BCInfo[bcid][bc_Players][q] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][q];
            PlayerTextDrawHide(player, BAICAO_TDE_NEW[player][slot]);
        }
    }
    return 1;
}
/* -----------------------------------------------------------------------------------------*/
stock ShowBCIDForPlayer(playerid, bcid)
{
    new Sporting[255],countstring[32];
    format(countstring, sizeof(countstring), "%dS", BCInfo[bcid][bc_Count]);
    SelectTextDraw(playerid, 0x00FF00FF);
    PlayerTextDrawShow(playerid, BAICAO_TDE_NEW[playerid][4]);
    for(new l = 0; l < MAX_PLAYER_BC; l++)
    {
        if(BCInfo[bcid][bc_Players][l] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][l];
            PlayerTextDrawSetString(playerid, BAICAO_TDE[playerid][6], countstring);
            if(l == 0)
            {
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][l]);
                format(Sporting, sizeof(Sporting), "%s_~g~(%d$)", GetPlayerNameEx(player),GetPlayerCash(player));
                PlayerTextDrawSetString(playerid, BAICAO_TDE[playerid][l], Sporting);
                if(player == playerid)
                {
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][7], true);
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][8], true);
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][9], true);
                }
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][7]);
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][8]);
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][9]);
            }
            if(l == 1)
            {
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][l]);
                format(Sporting, sizeof(Sporting), "%s_~g~(%d$)", GetPlayerNameEx(player),GetPlayerCash(player));
                PlayerTextDrawSetString(playerid, BAICAO_TDE[playerid][l], Sporting);
                if(player == playerid)
                {
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][10], true);
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][11], true);
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][12], true);
                }                
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][10]);
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][11]);
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][12]);
            }
            if(l == 2)
            {
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][l]);
                format(Sporting, sizeof(Sporting), "%s_~g~(%d$)", GetPlayerNameEx(player),GetPlayerCash(player));
                PlayerTextDrawSetString(playerid, BAICAO_TDE[playerid][l], Sporting);
                if(player == playerid)
                {
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][13], true);
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][14], true);
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][15], true);
                }
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][13]);
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][14]);
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][15]);
            }
            if(l == 3)
            {
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][l]);
                format(Sporting, sizeof(Sporting), "%s_~g~(%d$)", GetPlayerNameEx(player),GetPlayerCash(player));
                PlayerTextDrawSetString(playerid, BAICAO_TDE[playerid][l], Sporting);
                if(player == playerid)
                {
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][16], true);
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][17], true);
                    PlayerTextDrawSetSelectable(playerid, BAICAO_TDE[playerid][18], true);
                }
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][16]);
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][17]);
                PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][18]);
            }
        }
    }
    return 1;
}

stock UpdateBCIDForTeam(bcid,slot)
{
    new Sporting[255];
    for(new v = 0; v < MAX_PLAYER_BC; v++)
    {
        if(BCInfo[bcid][bc_Players][v] != INVALID_PLAYER_ID)
        {
            new player = BCInfo[bcid][bc_Players][v];
            new playerd = BCInfo[bcid][bc_Players][slot];
            if(slot == 0)
            {
                if(BCInfo[bcid][bc_Players][slot] == INVALID_PLAYER_ID)
                {
                    PlayerTextDrawHide(player, BAICAO_TDE[player][slot]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][7]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][8]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][9]);
                }
                else 
                {
                    PlayerTextDrawShow(player, BAICAO_TDE[player][slot]);
                    format(Sporting, sizeof(Sporting), "%s_~g~(%d$)", GetPlayerNameEx(playerd),GetPlayerCash(playerd));
                    PlayerTextDrawSetString(player, BAICAO_TDE[player][slot], Sporting);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][7]);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][8]);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][9]);
                }
            }
            else if(slot == 1)
            {
                if(BCInfo[bcid][bc_Players][slot] == INVALID_PLAYER_ID)
                {
                    PlayerTextDrawHide(player, BAICAO_TDE[player][slot]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][10]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][11]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][12]);
                }
                else 
                {
                    PlayerTextDrawShow(player, BAICAO_TDE[player][slot]);
                    format(Sporting, sizeof(Sporting), "%s_~g~(%d$)", GetPlayerNameEx(playerd),GetPlayerCash(playerd));
                    PlayerTextDrawSetString(player, BAICAO_TDE[player][slot], Sporting);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][10]);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][11]);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][12]);
                }   
            }
            else if(slot == 2)
            {
                if(BCInfo[bcid][bc_Players][slot] == INVALID_PLAYER_ID)
                {
                    PlayerTextDrawHide(player, BAICAO_TDE[player][slot]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][13]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][14]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][15]);
                }
                else 
                {
                    PlayerTextDrawShow(player, BAICAO_TDE[player][slot]);
                    format(Sporting, sizeof(Sporting), "%s_~g~(%d$)", GetPlayerNameEx(playerd),GetPlayerCash(playerd));
                    PlayerTextDrawSetString(player, BAICAO_TDE[player][slot], Sporting);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][13]);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][14]);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][15]);
                }
            }
            else if(slot == 3)
            {
                if(BCInfo[bcid][bc_Players][slot] == INVALID_PLAYER_ID)
                {
                    PlayerTextDrawHide(player, BAICAO_TDE[player][slot]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][16]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][17]);
                    PlayerTextDrawHide(player, BAICAO_TDE[player][18]);
                }
                else 
                {
                    PlayerTextDrawShow(player, BAICAO_TDE[player][slot]);
                    format(Sporting, sizeof(Sporting), "%s_~g~(%d$)", GetPlayerNameEx(playerd),GetPlayerCash(playerd));
                    PlayerTextDrawSetString(player, BAICAO_TDE[player][slot], Sporting);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][16]);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][17]);
                    PlayerTextDrawShow(player, BAICAO_TDE[player][18]);
                }
            }
        }
    } 
    return 1;
}

stock HidePlayerBC(playerid)
{
    for(new b = 0; b < 19; b++)
    {
        PlayerTextDrawDestroy(playerid, BAICAO_TDE[playerid][b]);
        PlayerTextDrawHide(playerid, BAICAO_TDE[playerid][b]);
    }   
    PlayerTextDrawDestroy(playerid, BAICAO_TDE_NEW[playerid][0]);
    PlayerTextDrawHide(playerid, BAICAO_TDE_NEW[playerid][0]);
    PlayerTextDrawDestroy(playerid, BAICAO_TDE_NEW[playerid][1]);
    PlayerTextDrawHide(playerid, BAICAO_TDE_NEW[playerid][1]);
    PlayerTextDrawDestroy(playerid, BAICAO_TDE_NEW[playerid][2]);
    PlayerTextDrawHide(playerid, BAICAO_TDE_NEW[playerid][2]);
    PlayerTextDrawDestroy(playerid, BAICAO_TDE_NEW[playerid][3]);
    PlayerTextDrawHide(playerid, BAICAO_TDE_NEW[playerid][3]);
    PlayerTextDrawDestroy(playerid, BAICAO_TDE_NEW[playerid][4]);
    PlayerTextDrawHide(playerid, BAICAO_TDE_NEW[playerid][4]);
    return 1;
}

stock JoinBCForPlayer(playerid, bcid)
{
    if(BCInfo[bcid][bc_Status] == STATUS_BC_TRIBUTE) return SendClientMessage(playerid, -1, "[!] Phong nay dang trong qua trinh mo bai");
    if(GetPlayerCash(playerid) < BCInfo[bcid][bc_Money]) return SendClientMessage(playerid, -1, "[!] Ban khong du tien de tham gia vao phong nay");
    if(PlayerBC[playerid][pBC_ID] != -1 || PlayerBC[playerid][pBC_Slot] != -1) return SendClientMessage(playerid, -1, "[!] Ban dang o choi mot phong khac");
    new getslot = GetFreeSlotBC(bcid);
    if(getslot == -1) return SendClientMessage(playerid, -1, "[!] Phong nay da day, xin moi ban ra phong khac");
    BCInfo[bcid][bc_Players][getslot] = playerid;
    BCInfo[bcid][bc_Player]++;
    PlayerBC[playerid][pBC_ID] = bcid;
    PlayerBC[playerid][pBC_Slot] = getslot;
    PlayerBC[playerid][pBC_Card][0] = 0;
    PlayerBC[playerid][pBC_Card][1] = 0;
    PlayerBC[playerid][pBC_Card][2] = 0;
    PlayerBC[playerid][pBC_Point] = 0;
    CreatePlayerBC(playerid);
    for(new b = 4; b < 7; b++) PlayerTextDrawShow(playerid, BAICAO_TDE[playerid][b]);
    ShowBCIDForPlayer(playerid, bcid); 
    UpdateBCIDForTeam(bcid,getslot);
    return 1;
}

stock QuitBCForPlayer(playerid, bcid)
{
    new slot = PlayerBC[playerid][pBC_Slot];
    HidePlayerBC(playerid);
    BCInfo[bcid][bc_Player]--;
    if(BCInfo[bcid][bc_Status] == STATUS_BC_TRIBUTE)
    {
        GivePlayerCash(playerid, -BCInfo[bcid][bc_Money]*2);
        HidePointForSlot(bcid, slot);
        if(BCInfo[bcid][bc_Player] < 2)
        {
            BCInfo[bcid][bc_Status] = STATUS_BC_SORT;
            BCInfo[bcid][bc_Count] = COUNT_BC_SORT;
            ResetPointBC(bcid);
            for(new b = 7; b < 19; b++)
            {
                BCTextDrawSetString(bcid, b, "ld_card:cdback");
            }
            HidePointFor(bcid);
            //BCInfo[bcid][bc_Timer] = SetTimerEx("TimerBCInfo", 1000, true, "i", bcid);
        }
    }
    BCInfo[bcid][bc_Players][slot] = INVALID_PLAYER_ID;
    UpdateBCIDForTeam(bcid, slot);
    PlayerBC[playerid][pBC_ID] = -1;
    PlayerBC[playerid][pBC_Slot] = -1;
    PlayerBC[playerid][pBC_Card][0] = 0;
    PlayerBC[playerid][pBC_Card][1] = 0;
    PlayerBC[playerid][pBC_Card][2] = 0;
    PlayerBC[playerid][pBC_Point] = 0;
    new tempstring[255];
    format(tempstring, sizeof(tempstring), "{FF0033}[BCID]{FFFFFF}: {33CCFF}%s{FFFFFF} da roi khoi ban", GetPlayerNameEx(playerid));
    MsgBC(bcid, -1, tempstring);
    CancelSelectTextDraw(playerid);
    return 1;
}

CMD:bc(playerid,params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 1.0, 2233.8032,1712.2303,1011.7632))
	{
		SendClientMessageEx(playerid, COLOR_GREY, "Ban khong o trong CASINO!");
		return 1;
	}
    ShowListBCForPlayer(playerid);
    return 1;
}
