#if defined _Message2_included
	#endinput
#endif
#define _Message2_included

#define MSG_STYLE_ERROR		1
#define MSG_STYLE_INFO		2
#define MSG_STYLE_USAGE 	3
#define MSG_STYLE_ADVERT	4
#define MSG_STYLE_ADMIN 	5

new PlayerText:MessageTD[MAX_PLAYERS];
new MessageTimer[MAX_PLAYERS];
new bool:TimerActive[MAX_PLAYERS] = false;
new Float:CustomX[MAX_PLAYERS];
new Float:CustomY[MAX_PLAYERS];
new bool:CustomMessage[MAX_PLAYERS] = false;

forward SendServerMessage(playerid, msgstyle, const message[]);
public SendServerMessage(playerid, msgstyle, const message[])
{
	if(msgstyle == MSG_STYLE_ERROR)
	{
		if(TimerActive[playerid] == true)
		{
			KillTimer(MessageTimer[playerid]);
		}
		new msg[138];
		format(msg, sizeof msg, "~r~Error: ~w~%s", message);
    	PlayerTextDrawSetString(playerid, MessageTD[playerid], msg);
		PlayerTextDrawShow(playerid, MessageTD[playerid]);
		MessageTimer[playerid] = SetTimerEx("RemoveMessage", 5000, false, "i", playerid);
		TimerActive[playerid] = true;
	}
	else if(msgstyle == MSG_STYLE_USAGE)
	{
		if(TimerActive[playerid] == true)
		{
			KillTimer(MessageTimer[playerid]);
		}
		new msg[138];
		format(msg, sizeof msg, "~y~Usage: ~w~%s", message);
    	PlayerTextDrawSetString(playerid, MessageTD[playerid], msg);
		PlayerTextDrawShow(playerid, MessageTD[playerid]);
		TimerActive[playerid] = true;
		MessageTimer[playerid] = SetTimerEx("RemoveMessage", 5000, false, "i", playerid);
	}
	else if(msgstyle == MSG_STYLE_INFO)
	{
		if(TimerActive[playerid] == true)
		{
			KillTimer(MessageTimer[playerid]);
		}
		new msg[138];
		format(msg, sizeof msg, "~g~Info: ~w~%s", message);
    	PlayerTextDrawSetString(playerid, MessageTD[playerid], msg);
		PlayerTextDrawShow(playerid, MessageTD[playerid]);
		TimerActive[playerid] = true;
		MessageTimer[playerid] = SetTimerEx("RemoveMessage", 5000, false, "i", playerid);
	}
	else if(msgstyle == MSG_STYLE_ADVERT)
	{
		if(TimerActive[playerid] == true)
		{
			KillTimer(MessageTimer[playerid]);
		}
		new msg[138];
		format(msg, sizeof msg, "~g~~h~Advert: ~w~%s", message);
    	PlayerTextDrawSetString(playerid, MessageTD[playerid], msg);
		PlayerTextDrawShow(playerid, MessageTD[playerid]);
		TimerActive[playerid] = true;
		MessageTimer[playerid] = SetTimerEx("RemoveMessage", 5000, false, "i", playerid);
	}
	else if(msgstyle == MSG_STYLE_ADMIN)
	{
		foreach(Player, i)
		{
			if(TimerActive[i] == true)
			{
				KillTimer(MessageTimer[i]);
			}
			new msg[138];
			format(msg, sizeof msg, "~r~~h~Admin %s: ~w~%s", GetName(i) ,message);
    		PlayerTextDrawSetString(playerid, MessageTD[i], msg);
			PlayerTextDrawShow(playerid, MessageTD[i]);
			TimerActive[i] = true;
			MessageTimer[i] = SetTimerEx("RemoveMessage", 5000, false, "i", i);
		}
	}
	return 1;
}

forward RemoveMessage(playerid);
public RemoveMessage(playerid)
{
    PlayerTextDrawHide(playerid, MessageTD[playerid]);
    TimerActive[playerid] = false;
	return 1;
}

CreateMessageTextDraw(playerid)
{
	MessageTD[playerid] = CreatePlayerTextDraw(playerid,139.000000, 370.000000, "Msg: ~w~%s");
	PlayerTextDrawBackgroundColor(playerid,MessageTD[playerid], 255);
	PlayerTextDrawFont(playerid,MessageTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid,MessageTD[playerid], 0.300000, 1.000000);
	PlayerTextDrawColor(playerid,MessageTD[playerid], -16711681);
	PlayerTextDrawSetOutline(playerid,MessageTD[playerid], 0);
	PlayerTextDrawSetProportional(playerid,MessageTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid,MessageTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid,MessageTD[playerid], 0);	
}

CreateCustomMessageTextDraw(playerid)
{
	MessageTD[playerid] = CreatePlayerTextDraw(playerid,CustomX[playerid], CustomY[playerid], "Msg: ~w~%s");
	PlayerTextDrawBackgroundColor(playerid,MessageTD[playerid], 255);
	PlayerTextDrawFont(playerid,MessageTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid,MessageTD[playerid], 0.300000, 1.000000);
	PlayerTextDrawColor(playerid,MessageTD[playerid], -16711681);
	PlayerTextDrawSetOutline(playerid,MessageTD[playerid], 0);
	PlayerTextDrawSetProportional(playerid,MessageTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid,MessageTD[playerid], 1);
	PlayerTextDrawSetSelectable(playerid,MessageTD[playerid], 0);	
}

DestroyMessageTextDraw(playerid)
{
	PlayerTextDrawDestroy(playerid, MessageTD[playerid]);
}

CMD:msgpos(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Lenh tam khoa");
	new Float:x[MAX_PLAYERS], Float:y[MAX_PLAYERS], str[128];
	if(sscanf(params, "ff", x[playerid], y[playerid])) return SendServerMessage(playerid, MSG_STYLE_USAGE, "/msgpos [custom x] [custom y]");
	if(y[playerid] > 600.0) return SendServerMessage(playerid, MSG_STYLE_ERROR, "You can not go any higher then 600.00");
	if(y[playerid] < 0.0) return SendServerMessage(playerid, MSG_STYLE_ERROR, "You can not go any lower then 0.00");
	if(y[playerid] > 430.0) return SendServerMessage(playerid, MSG_STYLE_ERROR, "You can not go any higher then 430.00");
	if(y[playerid] < 0.0) return SendServerMessage(playerid, MSG_STYLE_ERROR, "You can not go any lower then 0.00");
	CustomX[playerid] = x[playerid];
	CustomY[playerid] = y[playerid];
	DestroyMessageTextDraw(playerid);
	CreateCustomMessageTextDraw(playerid);
	format(str, sizeof str, "You have changed your message text to %0.2f, %0.2f", CustomX[playerid], CustomY[playerid]);
	SendServerMessage(playerid, MSG_STYLE_INFO, str);
	CustomMessage[playerid] = true;
	return 1;
}

CMD:defaultmsg(playerid, params[])
{
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, -1, "Lenh tam khoa");
	if(CustomMessage[playerid] == false) return SendServerMessage(playerid, MSG_STYLE_ERROR, "You do not have a custom message position");
	DestroyMessageTextDraw(playerid);
	CreateMessageTextDraw(playerid);
	SendServerMessage(playerid, MSG_STYLE_INFO, "You have set your message text to the default position.");
	return 1;
}