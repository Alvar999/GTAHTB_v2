//SYSTEM 7 MAU
//DUOC BUILD LAI BY JHONSONG
//=================//
#include <a_samp>
#include <ZCMD>
#include <YSI\y_hooks>

#define COLOR_DGREEN    0xAAFF82FF
//#define MAUSAC    (9003)

new carcolor1[MAX_PLAYERS], 
    carcolor2[MAX_PLAYERS], 
    selection[MAX_PLAYERS] = -1,  
    rainbowon[MAX_PLAYERS],
    rainbowtimer[MAX_PLAYERS];
    
hook OnPlayerExitVehicle(playerid, vehicleid) 
{
   if(rainbowon[playerid] == 1) 
   {
         new vehid = GetPlayerVehicleID(playerid);
         ChangeVehicleColor(vehid, carcolor1[playerid], carcolor2[playerid]);
         rainbowtimer[playerid] = KillTimer(rainbowtimer[playerid]);
         SendClientMessage(playerid, COLOR_DGREEN, "Ban Da Roi Khoi Xe , Mau Cau Vong Se Dung Lai");
         rainbowon[playerid] = 0;
    }
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if(rainbowon[playerid] == 1) {
         new vehid = GetPlayerVehicleID(playerid);
         ChangeVehicleColor(vehid, carcolor1[playerid], carcolor2[playerid]);
         rainbowtimer[playerid] = KillTimer(rainbowtimer[playerid]);
         SendClientMessage(playerid, COLOR_DGREEN, "Ban Da Chet , Mau Cau Vong Se Dung Lai");
         rainbowon[playerid] = 0;
    }
}

hook OnPlayerDisconnect(playerid, reason)
{
     if(rainbowon[playerid] == 1) {
         new vehid = GetPlayerVehicleID(playerid);
         ChangeVehicleColor(vehid, carcolor1[playerid], carcolor2[playerid]);
         rainbowtimer[playerid] = KillTimer(rainbowtimer[playerid]);
         rainbowon[playerid] = 0;
    }
}

forward Rainbow(playerid);
public Rainbow(playerid) 
{ 
    rainbowtimer[playerid] = SetTimerEx("RainbowCar", 500, true, "i", playerid); 
}

forward RainbowCar(playerid);
public RainbowCar(playerid) {

    selection[playerid]++;
    switch(selection[playerid]) {

       case 0: ChangeVehicleColor(GetPlayerVehicleID(playerid), 175, 175);
       case 1: ChangeVehicleColor(GetPlayerVehicleID(playerid), 158, 158);
       case 2: ChangeVehicleColor(GetPlayerVehicleID(playerid), 222, 222);
       case 3: ChangeVehicleColor(GetPlayerVehicleID(playerid), 194, 194);
       case 4: ChangeVehicleColor(GetPlayerVehicleID(playerid), 229, 229);
       case 5: ChangeVehicleColor(GetPlayerVehicleID(playerid), 226, 226);
       case 6: ChangeVehicleColor(GetPlayerVehicleID(playerid), 155, 155);
       case 7: ChangeVehicleColor(GetPlayerVehicleID(playerid), 162, 162);
       case 8: ChangeVehicleColor(GetPlayerVehicleID(playerid), 211, 211),
       selection[playerid] = -1;
    }
}

CMD:mausacon(playerid, params[])
{
   if(IsPlayerInAnyVehicle(playerid)) {
	    if(rainbowon[playerid] == 0) { 
            new color1, color2;
            ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
            carcolor1[playerid] = color1;
            carcolor2[playerid] = color2;
            Rainbow(playerid);
            rainbowon[playerid] = 1;
           // SendClientMessage(playerid, COLOR_DGREEN, "[Mau Sac Xe] {41FF00} ON");
           HienTextDraw(playerid, "Mau Sac Xe: ~g~ON");
        }
        else {
            HienTextDraw(playerid, "Mau Sac Xe Da ~g~ON~w~ Khong The Bat Tiep");
        }
   }
   else {
         HienTextDraw(playerid, "~r~Ban Phai Tren Xe Moi Lam Duoc Dieu Nay");
   }
   return 1;
}
CMD:mausacoff(playerid, params[]) 
{
     if(IsPlayerInAnyVehicle(playerid)) {
         new vehid = GetPlayerVehicleID(playerid);
         ChangeVehicleColor(vehid, carcolor1[playerid], carcolor2[playerid]);
         rainbowtimer[playerid] = KillTimer(rainbowtimer[playerid]);
      //   SendClientMessage(playerid, COLOR_DGREEN, "[Mau Sac Xe] {FF0A00} OFF");
         HienTextDraw(playerid, "Mau Sac Xe: ~r~OFF");
         rainbowon[playerid] = 0;
         return 1;
     }
     else {
          HienTextDraw(playerid, "~r~Ban Phai Tren Xe Moi Lam Duoc Dieu Nay");
     }
     return 1;
}
