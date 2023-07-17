#include <a_samp>
#include <YSI\y_hooks>

new SendClientText[MAX_PLAYERS];
new SendClientText1[MAX_PLAYERS];
new SendClientTextJob[MAX_PLAYERS];
new PlayerText:ClientText1[MAX_PLAYERS][1];
new PlayerText:ClientTextJob[MAX_PLAYERS][1];

hook OnPlayerConnect(playerid)
{

ClientText[playerid][0] = CreatePlayerTextDraw(playerid, 318.666290, 354.752777, "");
PlayerTextDrawLetterSize(playerid, ClientText[playerid][0], 0.310499, 1.794999);
PlayerTextDrawAlignment(playerid, ClientText[playerid][0], 2);
PlayerTextDrawColor(playerid, ClientText[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, ClientText[playerid][0], 0);
PlayerTextDrawSetOutline(playerid, ClientText[playerid][0], 1);
PlayerTextDrawBackgroundColor(playerid, ClientText[playerid][0], 255);
PlayerTextDrawFont(playerid, ClientText[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, ClientText[playerid][0], 1);

ClientText1[playerid][0] = CreatePlayerTextDraw(playerid, 318.500000, 388.333404, "");
PlayerTextDrawLetterSize(playerid, ClientText1[playerid][0], 0.310499, 1.794999);
PlayerTextDrawAlignment(playerid, ClientText1[playerid][0], 2);
PlayerTextDrawColor(playerid, ClientText1[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, ClientText1[playerid][0], 1);
PlayerTextDrawSetOutline(playerid, ClientText1[playerid][0], 0);
PlayerTextDrawBackgroundColor(playerid, ClientText1[playerid][0], 255);
PlayerTextDrawFont(playerid, ClientText1[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, ClientText1[playerid][0], 1);
PlayerTextDrawSetShadow(playerid, ClientText1[playerid][0], 1);

ClientTextJob[playerid][0] = CreatePlayerTextDraw(playerid, 10.399724, 233.626907, " ");
PlayerTextDrawLetterSize(playerid, ClientTextJob[playerid][0], 0.310499, 1.794999);
PlayerTextDrawTextSize(playerid, ClientTextJob[playerid][0], 206.000000, 0.000000);
PlayerTextDrawAlignment(playerid, ClientTextJob[playerid][0], 1);
PlayerTextDrawColor(playerid, ClientTextJob[playerid][0], -1);
PlayerTextDrawSetShadow(playerid, ClientTextJob[playerid][0], 1);
PlayerTextDrawBackgroundColor(playerid, ClientTextJob[playerid][0], 255);
PlayerTextDrawFont(playerid, ClientTextJob[playerid][0], 1);
PlayerTextDrawSetProportional(playerid, ClientTextJob[playerid][0], 1);

}

stock HienTextDrawToiUu(playerid, text[])
{
    if(GetPVarInt(playerid, "IsShowText") == 1) KillTimer(SendClientText[playerid]);
    PlayerTextDrawSetString(playerid,  ClientText[playerid][0], text);
    PlayerTextDrawShow(playerid, ClientText[playerid][0]);
    SendClientText[playerid] = SetTimerEx("ClosedClientText", 5000, 0, "d", playerid);
    SetPVarInt(playerid, "IsShowText", 1);
    return 1;
}

stock HienTextDraw(playerid, text[],time = 5)
{
    if(GetPVarInt(playerid, "IsShowText") == 1) KillTimer(SendClientText[playerid]);
    PlayerTextDrawSetString(playerid,  ClientText[playerid][0], text);
    PlayerTextDrawShow(playerid, ClientText[playerid][0]);
    SendClientText[playerid] = SetTimerEx("ClosedClientText", 1000 * time, 0, "d", playerid);
    SetPVarInt(playerid, "IsShowText", 1);
    return 1;
}
stock HienTextDraws(playerid, text[])
{
    if(GetPVarInt(playerid, "IsShowText") == 1) KillTimer(SendClientText[playerid]);
    PlayerTextDrawSetString(playerid,  ClientText[playerid][0], text);
    PlayerTextDrawShow(playerid, ClientText[playerid][0]);
    SendClientText[playerid] = SetTimerEx("ClosedClientText", 600, 0, "d", playerid);
    SetPVarInt(playerid, "IsShowText", 1);
    return 1;
}
forward ClosedClientText(playerid);
public ClosedClientText(playerid)
{
    PlayerTextDrawHide(playerid, ClientText[playerid][0]);
    DeletePVar(playerid, "IsShowText");
    return 1;
}

////////////////////////////////////////////////////////////////////////////////////
stock HienTextDraw1(playerid, text[])
{
    if(GetPVarInt(playerid, "IsShowText1") == 1) KillTimer(SendClientText1[playerid]);
    PlayerTextDrawSetString(playerid,  ClientText1[playerid][0], text);
    PlayerTextDrawShow(playerid, ClientText1[playerid][0]);
    SendClientText1[playerid] = SetTimerEx("ClosedClientText1", 3000, 0, "d", playerid);
    SetPVarInt(playerid, "IsShowText1", 1);
    return 1;
}
forward ClosedClientText1(playerid);
public ClosedClientText1(playerid)
{
    PlayerTextDrawHide(playerid, ClientText1[playerid][0]);
    DeletePVar(playerid, "IsShowText1");
    return 1;
}
////////////////////////////////////////////////////////////////////////////////////
stock HienTextDrawJob(playerid, text[])
{
    if(GetPVarInt(playerid, "IsShowTextJob") == 1) KillTimer(SendClientTextJob[playerid]);
    PlayerTextDrawSetString(playerid,  ClientTextJob[playerid][0], text);
    PlayerTextDrawShow(playerid, ClientTextJob[playerid][0]);
    SendClientTextJob[playerid] = SetTimerEx("ClosedClientTextJob", 3000, 0, "d", playerid);
    SetPVarInt(playerid, "IsShowTextJob", 1);
    return 1;
}
forward ClosedClientTextJob(playerid);
public ClosedClientTextJob(playerid)
{
    PlayerTextDrawHide(playerid, ClientTextJob[playerid][0]);
    DeletePVar(playerid, "IsShowTextJob");
    return 1;
}


CMD:testcl(playerid,params[]) return HienTextDraw(playerid,"Khong co lenh ~r~~h~%s~w~ trong he thong, vui long ~y~/trogiup~w~ de xem cac lenh co ban.");
CMD:testcl1(playerid,params[]) return HienTextDraw1(playerid,"Khong co lenh ~r~~h~%s~w~ trong he thong, vui long ~y~/trogiup~w~ de xem cac lenh co ban.");
CMD:testcl2(playerid,params[]) return HienTextDrawJob(playerid,"Khong co lenh ~r~~h~%s~w~ trong he thong, vui long ~y~/trogiup~w~ de xem cac lenh co ban.");
CMD:testcls(playerid,params[]) return HienTextDraws(playerid,"Khong co lenh ~r~~h~%s~w~ trong he thong, vui long ~y~/trogiup~w~ de xem cac lenh co ban.");